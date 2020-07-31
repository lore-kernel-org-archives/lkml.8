Return-Path: <SRS0=S/iQ=BK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2643C433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Jul 2020 09:27:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7529A22B40
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Jul 2020 09:27:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="4mq2pjV9";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="xxbaIFoV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732367AbgGaJXJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 Jul 2020 05:23:09 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:56350 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732261AbgGaJWw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Jul 2020 05:22:52 -0400
Date:   Fri, 31 Jul 2020 09:22:50 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1596187371;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=fYSCTLOskcFaf1QqHBSI9+EiG25nPncE/g+OlbowEWs=;
        b=4mq2pjV9GKJCPTuPoHvLPviXSUYcLWo8qrdhba+GoD0arBJwhlQqQ+8KOdGCyZlzdzmgTb
        27d1PMBTBRwt3y4rqlN4mZaXv8p3SdP3nmmV5VNBifLcHxf4D2ZcDtMrYfE4/VFCBLMtGu
        aVvPV95uB8FcF/uo1lBAsn/A1flsNhQoOc0W2Q6TU87mcL4zfTD8Uv5Q0WIjoxl6w0/98A
        DP6saxQFh4Tr97gpvn4Mj/4rdLui7ZKGukCHn9rTsgi4yJjzm+rcQxu0JW0u0S0ojK6lzr
        5nuqW4dLYcAWqr0iEfCYDNrIb7MfmKG6nKQbC7Aq3Kl4+S+0ThZ1v20G5LOY5Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1596187371;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=fYSCTLOskcFaf1QqHBSI9+EiG25nPncE/g+OlbowEWs=;
        b=xxbaIFoV86Ibum1bqagqwuwbIQWzyriybPZoeSxWGLzvtsz9cmMie+d+RavVDjX2lFSES4
        fzwhBcqxPX6MH5CQ==
From:   "tip-bot2 for Ethon Paul" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: core/rcu] srcu: Fix a typo in comment "amoritized"->"amortized"
Cc:     Ethon Paul <ethp@qq.com>, "Paul E. McKenney" <paulmck@kernel.org>,
        x86 <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <159618737065.4006.9118760174636133381.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the core/rcu branch of tip:

Commit-ID:     7fef6cff8f2814bf8eb632e2bb8f0a987ffd9ece
Gitweb:        https://git.kernel.org/tip/7fef6cff8f2814bf8eb632e2bb8f0a987ffd9ece
Author:        Ethon Paul <ethp@qq.com>
AuthorDate:    Sat, 18 Apr 2020 19:46:47 +08:00
Committer:     Paul E. McKenney <paulmck@kernel.org>
CommitterDate: Mon, 29 Jun 2020 12:01:22 -07:00

srcu: Fix a typo in comment "amoritized"->"amortized"

This commit fixes a typo in a comment.

Signed-off-by: Ethon Paul <ethp@qq.com>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/rcu/srcutree.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/rcu/srcutree.c b/kernel/rcu/srcutree.c
index 6d3ef70..8ff71e5 100644
--- a/kernel/rcu/srcutree.c
+++ b/kernel/rcu/srcutree.c
@@ -766,7 +766,7 @@ static void srcu_flip(struct srcu_struct *ssp)
  * it, if this function was preempted for enough time for the counters
  * to wrap, it really doesn't matter whether or not we expedite the grace
  * period.  The extra overhead of a needlessly expedited grace period is
- * negligible when amoritized over that time period, and the extra latency
+ * negligible when amortized over that time period, and the extra latency
  * of a needlessly non-expedited grace period is similarly negligible.
  */
 static bool srcu_might_be_idle(struct srcu_struct *ssp)
