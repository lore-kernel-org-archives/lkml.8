Return-Path: <SRS0=g5yc=BI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7971EC433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Jul 2020 14:33:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5746222BEF
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Jul 2020 14:33:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="MLvWqUUn";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="2gJ0v1qS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727118AbgG2Odn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Jul 2020 10:33:43 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:42938 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726971AbgG2Odg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jul 2020 10:33:36 -0400
Date:   Wed, 29 Jul 2020 14:33:33 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1596033213;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=+21/d33zSJQzOrFuH9hDP7UKKlTattNthwOTTDKc/Z0=;
        b=MLvWqUUnGhEtzsxIqWVpWYz3GHrA2SIoArx4KdgGNIjxiRofnbmFhzXUlV5ci5gd+zc0ix
        KzC9fOjxMgMorvdCSrYTkCGlwh6fkoCuDHSM/TdDvMC+E6ea5N7wmdZ5CS3fdN+wummEDj
        5lT5c6BqHrGPB03wl2pm8sjzIgRWItJuTu31zWf+EsmLELnSDDrHMleK49J9AGW8f3tHcm
        oTWGjpgiXgJ3anQuIaIW0TpiIYqwutkSrL7sBZ5xpnqhQPWwyCq+1314EZpBvEDxh2gjrJ
        tYkNk8kIspQ8huRmnpiYVz4fZXzChgVOsDQ90ecMmr1OdgesE0fASCg14aB3mA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1596033213;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=+21/d33zSJQzOrFuH9hDP7UKKlTattNthwOTTDKc/Z0=;
        b=2gJ0v1qSuRsBDL/G4fw3Zs7KFpwocLsWGzErJyY/K6Cb+1d2QEZf2SFYpmFcdozE8dk2N0
        QnVZ/p7gc+8cptDA==
From:   "tip-bot2 for Ahmed S. Darwish" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: locking/core] netfilter: nft_set_rbtree: Use sequence counter
 with associated rwlock
Cc:     "Ahmed S. Darwish" <a.darwish@linutronix.de>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        x86 <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200720155530.1173732-16-a.darwish@linutronix.de>
References: <20200720155530.1173732-16-a.darwish@linutronix.de>
MIME-Version: 1.0
Message-ID: <159603321315.4006.14315455150696649562.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the locking/core branch of tip:

Commit-ID:     b901892b51317b321c7bc96e2ccd2f522d1380ee
Gitweb:        https://git.kernel.org/tip/b901892b51317b321c7bc96e2ccd2f522d1380ee
Author:        Ahmed S. Darwish <a.darwish@linutronix.de>
AuthorDate:    Mon, 20 Jul 2020 17:55:21 +02:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Wed, 29 Jul 2020 16:14:26 +02:00

netfilter: nft_set_rbtree: Use sequence counter with associated rwlock

A sequence counter write side critical section must be protected by some
form of locking to serialize writers. A plain seqcount_t does not
contain the information of which lock must be held when entering a write
side critical section.

Use the new seqcount_rwlock_t data type, which allows to associate a
rwlock with the sequence counter. This enables lockdep to verify that
the rwlock used for writer serialization is held when the write side
critical section is entered.

If lockdep is disabled this lock association is compiled out and has
neither storage size nor runtime overhead.

Signed-off-by: Ahmed S. Darwish <a.darwish@linutronix.de>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lkml.kernel.org/r/20200720155530.1173732-16-a.darwish@linutronix.de
---
 net/netfilter/nft_set_rbtree.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/net/netfilter/nft_set_rbtree.c b/net/netfilter/nft_set_rbtree.c
index b6aad3f..4b2834f 100644
--- a/net/netfilter/nft_set_rbtree.c
+++ b/net/netfilter/nft_set_rbtree.c
@@ -18,7 +18,7 @@
 struct nft_rbtree {
 	struct rb_root		root;
 	rwlock_t		lock;
-	seqcount_t		count;
+	seqcount_rwlock_t	count;
 	struct delayed_work	gc_work;
 };
 
@@ -523,7 +523,7 @@ static int nft_rbtree_init(const struct nft_set *set,
 	struct nft_rbtree *priv = nft_set_priv(set);
 
 	rwlock_init(&priv->lock);
-	seqcount_init(&priv->count);
+	seqcount_rwlock_init(&priv->count, &priv->lock);
 	priv->root = RB_ROOT;
 
 	INIT_DEFERRABLE_WORK(&priv->gc_work, nft_rbtree_gc);
