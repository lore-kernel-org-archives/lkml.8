Return-Path: <SRS0=2gBQ=CN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42FD3C43461
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Sep 2020 13:19:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 147BB2078E
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Sep 2020 13:19:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="XffMdUMf";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="GToOOx1q"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730358AbgIDNTe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 4 Sep 2020 09:19:34 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:33090 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730369AbgIDNQR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Sep 2020 09:16:17 -0400
Date:   Fri, 04 Sep 2020 13:16:10 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1599225371;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=fljRKHgAWHMbuzD4XnCCLGpYt5AlZ7Sxj0FjH8NVt6w=;
        b=XffMdUMfQRZ5jtuil1thZQ4Alg1h0bgV2AbMen5OVlY+9fo3g9vsE656m9pt5U7+ybACFy
        ODKWSqs5YDjI9aJh+rPFrqHBC2Jqgh+i0YLr/MlnT58yg0DqqkDYT+x7J7UpE7zCq8+Wqi
        QB6VOuyjUjncIMvVSkF5qFfDC4eGnRU0MMLRHbTBYT40EX1xD5uapWSBwHJwoM05Dzc14d
        cGmGIlRV+IRidNsDML8ZpOP6ikNR/yeVtBJGrXQ6oIHLzK5MqemI9AMQjt35ExOaRRURWj
        +XJlRuTTSLQTFrI96dQFfu9MHPz50zgkNpbQQtEuPvjpMIrPYu5RbtWAh9EJ2A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1599225371;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=fljRKHgAWHMbuzD4XnCCLGpYt5AlZ7Sxj0FjH8NVt6w=;
        b=GToOOx1q8b38nlxydhLx7/QiLDjfzseIvIb1ucRO77BMAX164ufIl3JYLLl+lcjrBRWgta
        FbObbnDMpHsVawDg==
From:   "tip-bot2 for Peter Zijlstra" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/entry] x86/debug: Sync BTF earlier
Cc:     "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        Andy Lutomirski <luto@kernel.org>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200902133200.786888252@infradead.org>
References: <20200902133200.786888252@infradead.org>
MIME-Version: 1.0
Message-ID: <159922537072.20229.12383477145708165237.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the x86/entry branch of tip:

Commit-ID:     c182487da1b5281463f2255d2347885dba219c08
Gitweb:        https://git.kernel.org/tip/c182487da1b5281463f2255d2347885dba219c08
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Wed, 02 Sep 2020 15:25:52 +02:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Fri, 04 Sep 2020 15:12:52 +02:00

x86/debug: Sync BTF earlier

Move the BTF sync near the DR6 load, as this will be the only common
code guaranteed to run on every #DB.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Tested-by: Daniel Thompson <daniel.thompson@linaro.org>
Acked-by: Andy Lutomirski <luto@kernel.org>
Link: https://lore.kernel.org/r/20200902133200.786888252@infradead.org

---
 arch/x86/kernel/traps.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/arch/x86/kernel/traps.c b/arch/x86/kernel/traps.c
index 81a2fb7..9945642 100644
--- a/arch/x86/kernel/traps.c
+++ b/arch/x86/kernel/traps.c
@@ -749,6 +749,13 @@ static __always_inline unsigned long debug_read_clear_dr6(void)
 	/* Filter out all the reserved bits which are preset to 1 */
 	dr6 &= ~DR6_RESERVED;
 
+	/*
+	 * The SDM says "The processor clears the BTF flag when it
+	 * generates a debug exception."  Clear TIF_BLOCKSTEP to keep
+	 * TIF_BLOCKSTEP in sync with the hardware BTF flag.
+	 */
+	clear_thread_flag(TIF_BLOCKSTEP);
+
 	return dr6;
 }
 
@@ -783,13 +790,6 @@ static void handle_debug(struct pt_regs *regs, unsigned long dr6, bool user)
 	int si_code;
 
 	/*
-	 * The SDM says "The processor clears the BTF flag when it
-	 * generates a debug exception."  Clear TIF_BLOCKSTEP to keep
-	 * TIF_BLOCKSTEP in sync with the hardware BTF flag.
-	 */
-	clear_thread_flag(TIF_BLOCKSTEP);
-
-	/*
 	 * If DR6 is zero, no point in trying to handle it. The kernel is
 	 * not using INT1.
 	 */
