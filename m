Return-Path: <SRS0=kGB5=CE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48AAEC433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Aug 2020 13:49:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2608C20707
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Aug 2020 13:49:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1598449776;
	bh=iMbq3Vh+H31eGvphc6zlg9usjYqvBuIWSg9IIg6WVIw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=VoxgiWx2MsYY85Puu+YsOSOfj8nyiDz0T6aK3PC8zPKYtZS/AB8U922hNVIPbc2p3
	 TsjA2C7SR9vDmgFkVIsj8ks+np4ts6LG7Y6IKNhRE8Q6UxbqSIjp3zUMI8d4+ObZRT
	 El99yP8HuclyJTzzHMu2VvPF6mb8iNwOJI/H+mV0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730487AbgHZNt2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Aug 2020 09:49:28 -0400
Received: from mail.kernel.org ([198.145.29.99]:57276 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730454AbgHZNr7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Aug 2020 09:47:59 -0400
Received: from localhost.localdomain (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D679B2224D;
        Wed, 26 Aug 2020 13:47:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598449678;
        bh=iMbq3Vh+H31eGvphc6zlg9usjYqvBuIWSg9IIg6WVIw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=GbHaji5WW5Nqy393fO4JxH33+7gp6YS9YdMRM8BBGhY+gVPxNA128LADN1PbRfjlh
         clNFZztOcGrMbl4cGdRryMHmR3OYEKlS4O0KCLYSojV/5UxwOURYg3erPKOdOiBcOf
         u0ONK/PlJkPQHEuN2BhCIElsniRhN91El0hFJJpE=
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Eddy Wu <Eddy_Wu@trendmicro.com>, linux-kernel@vger.kernel.org,
        x86@kernel.org, "David S . Miller" <davem@davemloft.net>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>,
        "Naveen N . Rao" <naveen.n.rao@linux.ibm.com>,
        Anil S Keshavamurthy <anil.s.keshavamurthy@intel.com>,
        linux-arch@vger.kernel.org
Subject: [RFC PATCH 10/14] powerpc: kprobes: Use generic kretprobe trampoline handler
Date:   Wed, 26 Aug 2020 22:47:53 +0900
Message-Id: <159844967360.510284.6540811008662323447.stgit@devnote2>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <159844957216.510284.17683703701627367133.stgit@devnote2>
References: <159844957216.510284.17683703701627367133.stgit@devnote2>
User-Agent: StGit/0.19
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
---
 arch/powerpc/kernel/kprobes.c |   55 ++++-------------------------------------
 1 file changed, 5 insertions(+), 50 deletions(-)

diff --git a/arch/powerpc/kernel/kprobes.c b/arch/powerpc/kernel/kprobes.c
index 6ab9b4d037c3..ad4208e6e95b 100644
--- a/arch/powerpc/kernel/kprobes.c
+++ b/arch/powerpc/kernel/kprobes.c
@@ -218,6 +218,7 @@ bool arch_kprobe_on_func_entry(unsigned long offset)
 void arch_prepare_kretprobe(struct kretprobe_instance *ri, struct pt_regs *regs)
 {
 	ri->ret_addr = (kprobe_opcode_t *)regs->link;
+	ri->fp = NULL;
 
 	/* Replace the return addr with trampoline addr */
 	regs->link = (unsigned long)kretprobe_trampoline;
@@ -396,50 +397,11 @@ asm(".global kretprobe_trampoline\n"
  */
 static int trampoline_probe_handler(struct kprobe *p, struct pt_regs *regs)
 {
-	struct kretprobe_instance *ri = NULL;
-	struct hlist_head *head, empty_rp;
-	struct hlist_node *tmp;
-	unsigned long flags, orig_ret_address = 0;
-	unsigned long trampoline_address =(unsigned long)&kretprobe_trampoline;
-
-	INIT_HLIST_HEAD(&empty_rp);
-	kretprobe_hash_lock(current, &head, &flags);
-
-	/*
-	 * It is possible to have multiple instances associated with a given
-	 * task either because an multiple functions in the call path
-	 * have a return probe installed on them, and/or more than one return
-	 * return probe was registered for a target function.
-	 *
-	 * We can handle this because:
-	 *     - instances are always inserted at the head of the list
-	 *     - when multiple return probes are registered for the same
-	 *       function, the first instance's ret_addr will point to the
-	 *       real return address, and all the rest will point to
-	 *       kretprobe_trampoline
-	 */
-	hlist_for_each_entry_safe(ri, tmp, head, hlist) {
-		if (ri->task != current)
-			/* another task is sharing our hash bucket */
-			continue;
-
-		if (ri->rp && ri->rp->handler)
-			ri->rp->handler(ri, regs);
-
-		orig_ret_address = (unsigned long)ri->ret_addr;
-		recycle_rp_inst(ri, &empty_rp);
-
-		if (orig_ret_address != trampoline_address)
-			/*
-			 * This is the real return address. Any other
-			 * instances associated with this task are for
-			 * other calls deeper on the call stack
-			 */
-			break;
-	}
-
-	kretprobe_assert(ri, orig_ret_address, trampoline_address);
+	unsigned long orig_ret_address;
 
+	orig_ret_address = __kretprobe_trampoline_handler(regs,
+			(unsigned long)trampoline_p.addr,
+			NULL);
 	/*
 	 * We get here through one of two paths:
 	 * 1. by taking a trap -> kprobe_handler() -> here
@@ -458,13 +420,6 @@ static int trampoline_probe_handler(struct kprobe *p, struct pt_regs *regs)
 	regs->nip = orig_ret_address - 4;
 	regs->link = orig_ret_address;
 
-	kretprobe_hash_unlock(current, &flags);
-
-	hlist_for_each_entry_safe(ri, tmp, &empty_rp, hlist) {
-		hlist_del(&ri->hlist);
-		kfree(ri);
-	}
-
 	return 0;
 }
 NOKPROBE_SYMBOL(trampoline_probe_handler);

