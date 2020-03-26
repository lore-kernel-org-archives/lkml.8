Return-Path: <SRS0=aGSP=5L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B3B3C43331
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Mar 2020 14:50:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 51ADA2078B
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Mar 2020 14:50:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1585234220;
	bh=ANg5UcJMy7ARPpBhASg4TtuCceP4vQ+pfjolvrO1hdI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Hxodkzpwne4Ed8O2GbzU9iLEqC8rwggIu7WAQyvFEmUDfLhWm5eF6jaqMlJOjDQX9
	 n8W6wv7VOrhzzy1yrYWDQbsz9MzlobrRkV1svmddf4BivuZrRmRFno5dgZlDqa8nFX
	 ow/klR2ErTCnbkp9QaSZ7aoKXjEcLKeCnBYSueCI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728309AbgCZOuT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Mar 2020 10:50:19 -0400
Received: from mail.kernel.org ([198.145.29.99]:53378 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728188AbgCZOuS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Mar 2020 10:50:18 -0400
Received: from localhost.localdomain (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 663B820775;
        Thu, 26 Mar 2020 14:50:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1585234218;
        bh=ANg5UcJMy7ARPpBhASg4TtuCceP4vQ+pfjolvrO1hdI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=zmwak50JNRiDlMjMhAomIv0Kq9XAwgKMGD056RItd6Ls+OjcEaBz8WyEpm3BIcsL3
         EfQyPVHYVk7HCV2c0ThmaxoNy9mAvg39u+XBX1BcyhMuxmfYrQZzkzBIPvykbOc1l2
         3ugzf/aIof3xSvctTouJHfqWEjpn9ZS1mRVuglyU=
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     LKML <linux-kernel@vger.kernel.org>, x86@kernel.org,
        Paul McKenney <paulmck@kernel.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Brian Gerst <brgerst@gmail.com>,
        Juergen Gross <jgross@suse.com>,
        Alexandre Chartre <alexandre.chartre@oracle.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Paolo Bonzini <pbonzini@redhat.com>
Subject: [PATCH -tip 4/4] samples/kprobes: Add __kprobes and NOKPROBE_SYMBOL() for handlers.
Date:   Thu, 26 Mar 2020 23:50:11 +0900
Message-Id: <158523421177.24735.16273975317343670204.stgit@devnote2>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <158523416289.24735.10455512519475919061.stgit@devnote2>
References: <158523416289.24735.10455512519475919061.stgit@devnote2>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add __kprobes and NOKPROBE_SYMBOL() for sample
kprobe handlers.

Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
---
 samples/kprobes/kprobe_example.c    |    6 ++++--
 samples/kprobes/kretprobe_example.c |    2 ++
 2 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/samples/kprobes/kprobe_example.c b/samples/kprobes/kprobe_example.c
index d693c23a85e8..501911d1b327 100644
--- a/samples/kprobes/kprobe_example.c
+++ b/samples/kprobes/kprobe_example.c
@@ -25,7 +25,7 @@ static struct kprobe kp = {
 };
 
 /* kprobe pre_handler: called just before the probed instruction is executed */
-static int handler_pre(struct kprobe *p, struct pt_regs *regs)
+static int __kprobes handler_pre(struct kprobe *p, struct pt_regs *regs)
 {
 #ifdef CONFIG_X86
 	pr_info("<%s> pre_handler: p->addr = 0x%p, ip = %lx, flags = 0x%lx\n",
@@ -54,7 +54,7 @@ static int handler_pre(struct kprobe *p, struct pt_regs *regs)
 }
 
 /* kprobe post_handler: called after the probed instruction is executed */
-static void handler_post(struct kprobe *p, struct pt_regs *regs,
+static void __kprobes handler_post(struct kprobe *p, struct pt_regs *regs,
 				unsigned long flags)
 {
 #ifdef CONFIG_X86
@@ -90,6 +90,8 @@ static int handler_fault(struct kprobe *p, struct pt_regs *regs, int trapnr)
 	/* Return 0 because we don't handle the fault. */
 	return 0;
 }
+/* NOKPROBE_SYMBOL() is also available */
+NOKPROBE_SYMBOL(handler_fault);
 
 static int __init kprobe_init(void)
 {
diff --git a/samples/kprobes/kretprobe_example.c b/samples/kprobes/kretprobe_example.c
index 186315ca88b3..013e8e6ebae9 100644
--- a/samples/kprobes/kretprobe_example.c
+++ b/samples/kprobes/kretprobe_example.c
@@ -48,6 +48,7 @@ static int entry_handler(struct kretprobe_instance *ri, struct pt_regs *regs)
 	data->entry_stamp = ktime_get();
 	return 0;
 }
+NOKPROBE_SYMBOL(entry_handler);
 
 /*
  * Return-probe handler: Log the return value and duration. Duration may turn
@@ -67,6 +68,7 @@ static int ret_handler(struct kretprobe_instance *ri, struct pt_regs *regs)
 			func_name, retval, (long long)delta);
 	return 0;
 }
+NOKPROBE_SYMBOL(ret_handler);
 
 static struct kretprobe my_kretprobe = {
 	.handler		= ret_handler,

