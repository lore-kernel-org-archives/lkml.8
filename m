Return-Path: <SRS0=fqu/=3Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36B1AC35254
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Feb 2020 14:34:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 03F2820702
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Feb 2020 14:34:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727456AbgBEOej (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Feb 2020 09:34:39 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:35664 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726627AbgBEOei (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Feb 2020 09:34:38 -0500
Received: from localhost ([127.0.0.1] helo=flow.W.breakpoint.cc)
        by Galois.linutronix.de with esmtp (Exim 4.80)
        (envelope-from <bigeasy@linutronix.de>)
        id 1izLlB-0003IJ-Ob; Wed, 05 Feb 2020 15:34:33 +0100
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     linux-kernel@vger.kernel.org, nouveau@lists.freedesktop.org
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@kernel.org>,
        Karol Herbst <karolherbst@gmail.com>,
        Pekka Paalanen <ppaalanen@gmail.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: [PATCH] x86/mm/kmmio: Use this_cpu_ptr() instead get_cpu_var() for kmmio_ctx
Date:   Wed,  5 Feb 2020 15:34:26 +0100
Message-Id: <20200205143426.2592512-1-bigeasy@linutronix.de>
X-Mailer: git-send-email 2.25.0
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Both call sites, that access kmmio_ctx, access kmmio_ctx with interrupts
disabled. There is no need to use get_cpu_var() which additionally
disables preemption.

Use this_cpu_ptr() to access the kmmio_ctx variable of the current CPU.

Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 arch/x86/mm/kmmio.c | 10 +++-------
 1 file changed, 3 insertions(+), 7 deletions(-)

diff --git a/arch/x86/mm/kmmio.c b/arch/x86/mm/kmmio.c
index 49d7814b59a9b..9994353fb75de 100644
--- a/arch/x86/mm/kmmio.c
+++ b/arch/x86/mm/kmmio.c
@@ -260,7 +260,7 @@ int kmmio_handler(struct pt_regs *regs, unsigned long a=
ddr)
 		goto no_kmmio;
 	}
=20
-	ctx =3D &get_cpu_var(kmmio_ctx);
+	ctx =3D this_cpu_ptr(&kmmio_ctx);
 	if (ctx->active) {
 		if (page_base =3D=3D ctx->addr) {
 			/*
@@ -285,7 +285,7 @@ int kmmio_handler(struct pt_regs *regs, unsigned long a=
ddr)
 			pr_emerg("previous hit was at 0x%08lx.\n", ctx->addr);
 			disarm_kmmio_fault_page(faultpage);
 		}
-		goto no_kmmio_ctx;
+		goto no_kmmio;
 	}
 	ctx->active++;
=20
@@ -314,11 +314,8 @@ int kmmio_handler(struct pt_regs *regs, unsigned long =
addr)
 	 * the user should drop to single cpu before tracing.
 	 */
=20
-	put_cpu_var(kmmio_ctx);
 	return 1; /* fault handled */
=20
-no_kmmio_ctx:
-	put_cpu_var(kmmio_ctx);
 no_kmmio:
 	rcu_read_unlock();
 	preempt_enable_no_resched();
@@ -333,7 +330,7 @@ int kmmio_handler(struct pt_regs *regs, unsigned long a=
ddr)
 static int post_kmmio_handler(unsigned long condition, struct pt_regs *reg=
s)
 {
 	int ret =3D 0;
-	struct kmmio_context *ctx =3D &get_cpu_var(kmmio_ctx);
+	struct kmmio_context *ctx =3D this_cpu_ptr(&kmmio_ctx);
=20
 	if (!ctx->active) {
 		/*
@@ -371,7 +368,6 @@ static int post_kmmio_handler(unsigned long condition, =
struct pt_regs *regs)
 	if (!(regs->flags & X86_EFLAGS_TF))
 		ret =3D 1;
 out:
-	put_cpu_var(kmmio_ctx);
 	return ret;
 }
=20
--=20
2.25.0

