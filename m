Return-Path: <SRS0=2gBQ=CN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A696EC43461
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Sep 2020 13:19:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6F54E2074D
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Sep 2020 13:19:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="u5kjzrkp";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="0LQnhupv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730114AbgIDNTY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 4 Sep 2020 09:19:24 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:33088 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730367AbgIDNQR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Sep 2020 09:16:17 -0400
Date:   Fri, 04 Sep 2020 13:16:09 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1599225370;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=kVYUUm7ioySyd+3gJf++9hCNsBTIa19jS9UzeRxCIyQ=;
        b=u5kjzrkpg1P+J6dEkJSBDl1cTJcpiC9cTa6aOYZnpUdRz4C6CSP0dVisSijUsR8+X8rEAg
        t8hFUygpZB2XPaGUM5GHJvBDrp8GuvaWH8VnnMQvnJmN/DIP+o4C/532b4jAdaFDfGLUD3
        KYDzAHNhZOrh8f1fde/iKL2wJXC3jBNjRD9uKt1uAlON9lYJI5C3xEbqXSgRT/tlSjX1tD
        pWyLPD6ubwQehhMJZZ2DaFu/nF7d3LBiS21VZUyK3gO30EnTWEnSBOnH4xegajKPemYIqJ
        Fnbc1Dc6B/Hx8tDruPPdaZtjARGSHpRdL8Z+3stK7kOvijtg/aaOCnYjMW3tlQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1599225370;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=kVYUUm7ioySyd+3gJf++9hCNsBTIa19jS9UzeRxCIyQ=;
        b=0LQnhupvL07f8sqyNP6FcV20JyDDWgBaRv2IP3AMl0+7ft2fkKzTMzROLXIPUylEOS5/m2
        MXBqjVVed12xUTAA==
From:   "tip-bot2 for Peter Zijlstra" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/entry] x86/debug: Simplify #DB signal code
Cc:     "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        x86 <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200902133200.967434217@infradead.org>
References: <20200902133200.967434217@infradead.org>
MIME-Version: 1.0
Message-ID: <159922536940.20229.5627974333570135957.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the x86/entry branch of tip:

Commit-ID:     4182e9436916a48f16207f0619562f1d3843a0c8
Gitweb:        https://git.kernel.org/tip/4182e9436916a48f16207f0619562f1d3843a0c8
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Wed, 02 Sep 2020 15:25:55 +02:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Fri, 04 Sep 2020 15:12:52 +02:00

x86/debug: Simplify #DB signal code

There's no point in calculating si_code if it's not going to be used.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Tested-by: Daniel Thompson <daniel.thompson@linaro.org>
Link: https://lore.kernel.org/r/20200902133200.967434217@infradead.org

---
 arch/x86/kernel/traps.c | 15 +++++++++------
 1 file changed, 9 insertions(+), 6 deletions(-)

diff --git a/arch/x86/kernel/traps.c b/arch/x86/kernel/traps.c
index 58bc434..24e09f8 100644
--- a/arch/x86/kernel/traps.c
+++ b/arch/x86/kernel/traps.c
@@ -786,15 +786,14 @@ static __always_inline unsigned long debug_read_clear_dr6(void)
 static void handle_debug(struct pt_regs *regs, unsigned long dr6)
 {
 	struct task_struct *tsk = current;
-	bool user_icebp;
-	int si_code;
+	bool icebp;
 
 	/*
 	 * If dr6 has no reason to give us about the origin of this trap,
 	 * then it's very likely the result of an icebp/int01 trap.
 	 * User wants a sigtrap for that.
 	 */
-	user_icebp = !dr6;
+	icebp = !dr6;
 
 	/* Store the virtualized DR6 value */
 	tsk->thread.debugreg6 = dr6;
@@ -813,6 +812,11 @@ static void handle_debug(struct pt_regs *regs, unsigned long dr6)
 		goto out;
 	}
 
+	/*
+	 * Reload dr6, the notifier might have changed it.
+	 */
+	dr6 = tsk->thread.debugreg6;
+
 	if (WARN_ON_ONCE((dr6 & DR_STEP) && !user_mode(regs))) {
 		/*
 		 * Historical junk that used to handle SYSENTER single-stepping.
@@ -825,9 +829,8 @@ static void handle_debug(struct pt_regs *regs, unsigned long dr6)
 		regs->flags &= ~X86_EFLAGS_TF;
 	}
 
-	si_code = get_si_code(tsk->thread.debugreg6);
-	if (tsk->thread.debugreg6 & (DR_STEP | DR_TRAP_BITS) || user_icebp)
-		send_sigtrap(regs, 0, si_code);
+	if (dr6 & (DR_STEP | DR_TRAP_BITS) || icebp)
+		send_sigtrap(regs, 0, get_si_code(dr6));
 
 out:
 	cond_local_irq_disable(regs);
