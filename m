Return-Path: <SRS0=S/iQ=BK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49D67C433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Jul 2020 09:26:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 22F21208E4
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Jul 2020 09:26:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="hc/BImUz";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="z1Ia/bhD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732773AbgGaJ0M (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 Jul 2020 05:26:12 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:56642 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732439AbgGaJXZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Jul 2020 05:23:25 -0400
Date:   Fri, 31 Jul 2020 09:23:21 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1596187402;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=rwXQvnHIyt/BB6QUB+SN81t5umOQIb46CpgUHXwCTM4=;
        b=hc/BImUz0QyneZ8X94yUmZaFM66XJB+2yKL6eWzAY+wKiJrRkQe8E5w7nE4IK6tM77FngV
        zX0SpL5o+OdrncJNNaIm3o7wTxFVHncu/mi9jOTvIlsQJf2Tmzb2hEY/oYa0va1k0g1qpX
        rs7UXfQ5r5ffVWiDHhDUHvv9iz6IF/dA/9gqPKDa1eFCwTMapMliXk4nIuq5KUqF8ooQxJ
        WfldfjPDWzk/EPws8lCyjosWvo+YYXCy0MkPWAmPZxUeqpv2FhncQHU7Wu8ijSxn8E8wh9
        itOyAg7h/4Z1x3d3e8ZE2oAXmxpv7iqYum5FGRljdhM0vnu+/rx7kb+QgVcPqA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1596187402;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=rwXQvnHIyt/BB6QUB+SN81t5umOQIb46CpgUHXwCTM4=;
        b=z1Ia/bhDxkNOmY1HVSqcvrHomvO8QmEvKI1GOwMS9SuSguPR1OIZNCBKZaf20EJ5/2s8vl
        TxztuQFTjWHmuHCA==
From:   "tip-bot2 for Uladzislau Rezki (Sony)" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: core/rcu] rcu/tree: Simplify KFREE_BULK_MAX_ENTR macro
Cc:     Boqun Feng <boqun.feng@gmail.com>,
        "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        "Uladzislau Rezki (Sony)" <urezki@gmail.com>,
        "Paul E. McKenney" <paulmck@kernel.org>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <159618740185.4006.17649713013825336750.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the core/rcu branch of tip:

Commit-ID:     3af84862817403d317dc33312e7a88d76e79401a
Gitweb:        https://git.kernel.org/tip/3af84862817403d317dc33312e7a88d76e79401a
Author:        Uladzislau Rezki (Sony) <urezki@gmail.com>
AuthorDate:    Mon, 25 May 2020 23:47:49 +02:00
Committer:     Paul E. McKenney <paulmck@kernel.org>
CommitterDate: Mon, 29 Jun 2020 11:59:25 -07:00

rcu/tree: Simplify KFREE_BULK_MAX_ENTR macro

We can simplify KFREE_BULK_MAX_ENTR macro and get rid of
magic numbers which were used to make the structure to be
exactly one page.

Suggested-by: Boqun Feng <boqun.feng@gmail.com>
Reviewed-by: Joel Fernandes (Google) <joel@joelfernandes.org>
Signed-off-by: Uladzislau Rezki (Sony) <urezki@gmail.com>
Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/rcu/tree.c | 17 +++++++++--------
 1 file changed, 9 insertions(+), 8 deletions(-)

diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index 143c1e9..bcdc063 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -2958,13 +2958,6 @@ EXPORT_SYMBOL_GPL(call_rcu);
 #define KFREE_DRAIN_JIFFIES (HZ / 50)
 #define KFREE_N_BATCHES 2
 
-/*
- * This macro defines how many entries the "records" array
- * will contain. It is based on the fact that the size of
- * kfree_rcu_bulk_data structure becomes exactly one page.
- */
-#define KFREE_BULK_MAX_ENTR ((PAGE_SIZE / sizeof(void *)) - 3)
-
 /**
  * struct kfree_rcu_bulk_data - single block to store kfree_rcu() pointers
  * @nr_records: Number of active pointers in the array
@@ -2973,10 +2966,18 @@ EXPORT_SYMBOL_GPL(call_rcu);
  */
 struct kfree_rcu_bulk_data {
 	unsigned long nr_records;
-	void *records[KFREE_BULK_MAX_ENTR];
 	struct kfree_rcu_bulk_data *next;
+	void *records[];
 };
 
+/*
+ * This macro defines how many entries the "records" array
+ * will contain. It is based on the fact that the size of
+ * kfree_rcu_bulk_data structure becomes exactly one page.
+ */
+#define KFREE_BULK_MAX_ENTR \
+	((PAGE_SIZE - sizeof(struct kfree_rcu_bulk_data)) / sizeof(void *))
+
 /**
  * struct kfree_rcu_cpu_work - single batch of kfree_rcu() requests
  * @rcu_work: Let queue_rcu_work() invoke workqueue handler after grace period
