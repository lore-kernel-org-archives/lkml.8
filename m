Return-Path: <SRS0=2gBQ=CN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 353BCC43461
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Sep 2020 13:18:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E2DCC2074D
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Sep 2020 13:18:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="kJOTDoZ6";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="hZBIrOrP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730456AbgIDNSH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 4 Sep 2020 09:18:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730331AbgIDNQP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Sep 2020 09:16:15 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 004F2C061245;
        Fri,  4 Sep 2020 06:16:14 -0700 (PDT)
Date:   Fri, 04 Sep 2020 13:16:06 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1599225367;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=jPurnusEvbb6GiM/Ja09Ig3drGdcyoC1dTl+SUfGJzk=;
        b=kJOTDoZ61nvDeD9kEdG8b2DDWCqT5BgpeOB+axWUnfWXij/UOWdheTBRPDblWOgcVnk3ib
        y73zQlAm2zXsQ15QVJ3EpuzmCvmgqSu84gkvyTri1DdVEdmh0Aw2P/nhmX3P60jHK+BMcY
        sVSW5aV+nFx9tDgBudb84y3YR2/DUeG40E7WbTy3d9caEWnG+i/ctuRf3OQI3P4ppSKJ8g
        zgprqBo+IF7R3AhHDjC5zy2omGqF8JnxwecjZxxtcc1BAKwrD6f4777iGhUBKyzkdAr+hA
        OGmVy+0s1/c/J09qnoITIHKAWynWFdsQo80ULx7J5KgcdATAOjoo6uPTuMFBgg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1599225367;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=jPurnusEvbb6GiM/Ja09Ig3drGdcyoC1dTl+SUfGJzk=;
        b=hZBIrOrPIM5YG7EZgB/2K8a7/EcpbOLxVE03XXz9co1jSWoutFfwTijC623kKAJJ7K6QeI
        O1hVG+XnxrIGI5Aw==
From:   "tip-bot2 for Peter Zijlstra" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/entry] x86/debug: Support negative polarity DR6 bits
Cc:     Andrew Cooper <Andrew.Cooper3@citrix.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        x86 <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200902133201.354220797@infradead.org>
References: <20200902133201.354220797@infradead.org>
MIME-Version: 1.0
Message-ID: <159922536683.20229.14204270773798170350.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the x86/entry branch of tip:

Commit-ID:     f4956cf83ed12271bdbd5b547f3378add72bbffb
Gitweb:        https://git.kernel.org/tip/f4956cf83ed12271bdbd5b547f3378add72bbffb
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Wed, 02 Sep 2020 15:26:01 +02:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Fri, 04 Sep 2020 15:12:57 +02:00

x86/debug: Support negative polarity DR6 bits

DR6 has a whole bunch of bits that have negative polarity; they were
architecturally reserved and defined to be 1 and are now getting used.
Since they're 1 by default, 0 becomes the signal value.

Handle this by xor'ing the read DR6 value by the reserved mask, this
will flip them around such that 1 is the signal value (positive
polarity).

Current Linux doesn't yet support any of these bits, but there's two
defined:

 - DR6[11] Bus Lock Debug Exception		(ISEr39)
 - DR6[16] Restricted Transactional Memory	(SDM)

Update ptrace_{set,get}_debugreg() to provide/consume the value in
architectural polarity. Although afaict ptrace_set_debugreg(6) is
pointless, the value is not consumed anywhere.

Change hw_breakpoint_restore() to alway write the DR6_RESERVED value
to DR6, again, no consumer for that write.

Suggested-by: Andrew Cooper <Andrew.Cooper3@citrix.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Tested-by: Daniel Thompson <daniel.thompson@linaro.org>
Link: https://lore.kernel.org/r/20200902133201.354220797@infradead.org

---
 arch/x86/kernel/hw_breakpoint.c | 2 +-
 arch/x86/kernel/ptrace.c        | 4 ++--
 arch/x86/kernel/traps.c         | 5 ++---
 3 files changed, 5 insertions(+), 6 deletions(-)

diff --git a/arch/x86/kernel/hw_breakpoint.c b/arch/x86/kernel/hw_breakpoint.c
index 7b7d9f2..d17a1da 100644
--- a/arch/x86/kernel/hw_breakpoint.c
+++ b/arch/x86/kernel/hw_breakpoint.c
@@ -464,7 +464,7 @@ void hw_breakpoint_restore(void)
 	set_debugreg(__this_cpu_read(cpu_debugreg[1]), 1);
 	set_debugreg(__this_cpu_read(cpu_debugreg[2]), 2);
 	set_debugreg(__this_cpu_read(cpu_debugreg[3]), 3);
-	set_debugreg(current->thread.debugreg6, 6);
+	set_debugreg(DR6_RESERVED, 6);
 	set_debugreg(__this_cpu_read(cpu_dr7), 7);
 }
 EXPORT_SYMBOL_GPL(hw_breakpoint_restore);
diff --git a/arch/x86/kernel/ptrace.c b/arch/x86/kernel/ptrace.c
index e7537c5..5f98289 100644
--- a/arch/x86/kernel/ptrace.c
+++ b/arch/x86/kernel/ptrace.c
@@ -601,7 +601,7 @@ static unsigned long ptrace_get_debugreg(struct task_struct *tsk, int n)
 		if (bp)
 			val = bp->hw.info.address;
 	} else if (n == 6) {
-		val = thread->debugreg6;
+		val = thread->debugreg6 ^ DR6_RESERVED; /* Flip back to arch polarity */
 	} else if (n == 7) {
 		val = thread->ptrace_dr7;
 	}
@@ -657,7 +657,7 @@ static int ptrace_set_debugreg(struct task_struct *tsk, int n,
 	if (n < HBP_NUM) {
 		rc = ptrace_set_breakpoint_addr(tsk, n, val);
 	} else if (n == 6) {
-		thread->debugreg6 = val;
+		thread->debugreg6 = val ^ DR6_RESERVED; /* Flip to positive polarity */
 		rc = 0;
 	} else if (n == 7) {
 		rc = ptrace_write_dr7(tsk, val);
diff --git a/arch/x86/kernel/traps.c b/arch/x86/kernel/traps.c
index 1e89001..114515b 100644
--- a/arch/x86/kernel/traps.c
+++ b/arch/x86/kernel/traps.c
@@ -745,9 +745,8 @@ static __always_inline unsigned long debug_read_clear_dr6(void)
 	 * Keep it simple: clear DR6 immediately.
 	 */
 	get_debugreg(dr6, 6);
-	set_debugreg(0, 6);
-	/* Filter out all the reserved bits which are preset to 1 */
-	dr6 &= ~DR6_RESERVED;
+	set_debugreg(DR6_RESERVED, 6);
+	dr6 ^= DR6_RESERVED; /* Flip to positive polarity */
 
 	/*
 	 * The SDM says "The processor clears the BTF flag when it
