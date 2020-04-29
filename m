Return-Path: <SRS0=ObIu=6N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4DBFC83000
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Apr 2020 15:37:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C3D1820775
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Apr 2020 15:37:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="3AreKkIh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727794AbgD2Ph7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Apr 2020 11:37:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727774AbgD2Ph5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Apr 2020 11:37:57 -0400
Received: from merlin.infradead.org (unknown [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 994CBC03C1AE
        for <linux-kernel@vger.kernel.org>; Wed, 29 Apr 2020 08:37:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-Id:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To;
        bh=Cg9auHt1crrTAQ9BW8HG3W/ZbS3EFiSANBjfOVaQrQY=; b=3AreKkIhjTsdVaxmXgHrdXBSYg
        9SCYHLTB71BnRvTOLNGTWNErRNXvRpzzfWjS9KPrJK3/hDloF622AxGbK1yd/06seuKxONjtCufGD
        OYfe2NHq3rHHrHgAUza7omzu0hGwCLxyMGjH4NDyyojW6w2/5r+tkU2aN7fKRbXxcSr7zzeG6qJJV
        g+W/jc75yxO/lAgFotNhcQus3FmaB+Kht2ebkH8Vxv5Yv/m4SZi5uTGoWhQFNqmt4XOXH3PtASbzC
        x6vveYZcgaWAVWuU4r86nmkPbIACdynJ9SovI20c1K2D0RI8QC7gh6IMBolfPicp2qxRG4OB5QL1m
        jAycFIiA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jTomE-00028P-UT; Wed, 29 Apr 2020 15:37:35 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 69A57307494;
        Wed, 29 Apr 2020 17:37:32 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id E89CE236D79F4; Wed, 29 Apr 2020 17:37:31 +0200 (CEST)
Message-Id: <20200429153549.371949748@infradead.org>
User-Agent: quilt/0.65
Date:   Wed, 29 Apr 2020 17:33:05 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     linux-kernel@vger.kernel.org
Cc:     walken@google.com, dave@stgolabs.net, mingo@kernel.org,
        tglx@linutronix.de, oleg@redhat.com, irogers@google.com,
        juri.lelli@redhat.com, vincent.guittot@linaro.org,
        peterz@infradead.org
Subject: [RFC][PATCH 7/7] rbtree, timerqueue: Use rb_add_cached()
References: <20200429153258.563269446@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 lib/timerqueue.c |   28 +++++++++-------------------
 1 file changed, 9 insertions(+), 19 deletions(-)

--- a/lib/timerqueue.c
+++ b/lib/timerqueue.c
@@ -14,6 +14,14 @@
 #include <linux/rbtree.h>
 #include <linux/export.h>
 
+#define __node_2_tq(_n) \
+	rb_entry((_n), struct timerqueue_node, node)
+
+static inline bool __timerqueue_less(struct rb_node *a, const struct rb_node *b)
+{
+	return __node_2_tq(a)->expires < __node_2_tq(b)->expires;
+}
+
 /**
  * timerqueue_add - Adds timer to timerqueue.
  *
@@ -26,28 +34,10 @@
  */
 bool timerqueue_add(struct timerqueue_head *head, struct timerqueue_node *node)
 {
-	struct rb_node **p = &head->rb_root.rb_root.rb_node;
-	struct rb_node *parent = NULL;
-	struct timerqueue_node *ptr;
-	bool leftmost = true;
-
 	/* Make sure we don't add nodes that are already added */
 	WARN_ON_ONCE(!RB_EMPTY_NODE(&node->node));
 
-	while (*p) {
-		parent = *p;
-		ptr = rb_entry(parent, struct timerqueue_node, node);
-		if (node->expires < ptr->expires) {
-			p = &(*p)->rb_left;
-		} else {
-			p = &(*p)->rb_right;
-			leftmost = false;
-		}
-	}
-	rb_link_node(&node->node, parent, p);
-	rb_insert_color_cached(&node->node, &head->rb_root, leftmost);
-
-	return leftmost;
+	return rb_add_cached(&head->rb_root, &node->node, __timerqueue_less);
 }
 EXPORT_SYMBOL_GPL(timerqueue_add);
 


