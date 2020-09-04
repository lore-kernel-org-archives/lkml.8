Return-Path: <SRS0=2gBQ=CN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87620C433E2
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Sep 2020 13:21:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5CCA5206F2
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Sep 2020 13:21:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="vJfeW6Vj";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="LMEG6W+C"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730464AbgIDNVQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 4 Sep 2020 09:21:16 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:33004 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730255AbgIDNQK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Sep 2020 09:16:10 -0400
Date:   Fri, 04 Sep 2020 13:16:07 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1599225367;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=BVAh8I/2bxTPz9UIi08lc10tsx0Q9qTXm+c63FuVeog=;
        b=vJfeW6Vjgn17H3MJT1jz3Tfin2vd6YT7/++r9vylVVzVzbePu00Cu0wWeyI/hlMzY17n2B
        OSw0EVgRkDIKWCVuHoZvsjISU/3drdrcZ5OjgPbvs2QM1QlNQEsfWTosF3V5ylKXgaLUZI
        9l19ck9oYz74euuR61fKhN3zSKxruXFNeRR/GlvD+yPtiUXeKvRZw3GWK/EcbbPOhDXukP
        Jq/GKhyaK+ljasct4IZ7cRQ6vkafPuQvJKUMy/dYV6gUmjOUguBlfyZ3kc7MRPrfko7T3h
        69aURSi9Pf55vMSbcv85Vgj1fdEOYT8Wpl2pxWpKQReeGrwyNJU1FvClGSSKeg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1599225367;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=BVAh8I/2bxTPz9UIi08lc10tsx0Q9qTXm+c63FuVeog=;
        b=LMEG6W+CZcmf0wg4GWzI6L4qrnXoe35edK7coGjInVs0fnFrsx+Od9LyoGC5EIN/C8rM+7
        7F0fYhf3LEEyaKDw==
From:   "tip-bot2 for Peter Zijlstra" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/entry] x86/debug: Simplify hw_breakpoint_handler()
Cc:     "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        x86 <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200902133201.292906672@infradead.org>
References: <20200902133201.292906672@infradead.org>
MIME-Version: 1.0
Message-ID: <159922536721.20229.16306947437710774866.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the x86/entry branch of tip:

Commit-ID:     21d44be7b6ff4c254dc971e2c99d4082dd470afd
Gitweb:        https://git.kernel.org/tip/21d44be7b6ff4c254dc971e2c99d4082dd470afd
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Wed, 02 Sep 2020 15:26:00 +02:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Fri, 04 Sep 2020 15:12:56 +02:00

x86/debug: Simplify hw_breakpoint_handler()

This is called with interrupts disabled, there's no point in using
get_cpu() and per_cpu().

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Tested-by: Daniel Thompson <daniel.thompson@linaro.org>
Link: https://lore.kernel.org/r/20200902133201.292906672@infradead.org

---
 arch/x86/kernel/hw_breakpoint.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/arch/x86/kernel/hw_breakpoint.c b/arch/x86/kernel/hw_breakpoint.c
index ca9de59..7b7d9f2 100644
--- a/arch/x86/kernel/hw_breakpoint.c
+++ b/arch/x86/kernel/hw_breakpoint.c
@@ -487,7 +487,7 @@ EXPORT_SYMBOL_GPL(hw_breakpoint_restore);
  */
 static int hw_breakpoint_handler(struct die_args *args)
 {
-	int i, cpu, rc = NOTIFY_STOP;
+	int i, rc = NOTIFY_STOP;
 	struct perf_event *bp;
 	unsigned long dr6;
 	unsigned long *dr6_p;
@@ -505,12 +505,10 @@ static int hw_breakpoint_handler(struct die_args *args)
 		return NOTIFY_DONE;
 
 	/*
-	 * Assert that local interrupts are disabled
 	 * Reset the DRn bits in the virtualized register value.
 	 * The ptrace trigger routine will add in whatever is needed.
 	 */
 	current->thread.debugreg6 &= ~DR_TRAP_BITS;
-	cpu = get_cpu();
 
 	/* Handle all the breakpoints that were triggered */
 	for (i = 0; i < HBP_NUM; ++i) {
@@ -525,7 +523,7 @@ static int hw_breakpoint_handler(struct die_args *args)
 		 */
 		rcu_read_lock();
 
-		bp = per_cpu(bp_per_reg[i], cpu);
+		bp = this_cpu_read(bp_per_reg[i]);
 		/*
 		 * Reset the 'i'th TRAP bit in dr6 to denote completion of
 		 * exception handling
@@ -560,8 +558,6 @@ static int hw_breakpoint_handler(struct die_args *args)
 	    (dr6 & (~DR_TRAP_BITS)))
 		rc = NOTIFY_DONE;
 
-	put_cpu();
-
 	return rc;
 }
 
