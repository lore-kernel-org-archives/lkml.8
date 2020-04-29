Return-Path: <SRS0=ObIu=6N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73F76C83004
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Apr 2020 15:37:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4FB4620775
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Apr 2020 15:37:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="L+Py9bfh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727773AbgD2Phy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Apr 2020 11:37:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727044AbgD2Phl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Apr 2020 11:37:41 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11F81C03C1AD
        for <linux-kernel@vger.kernel.org>; Wed, 29 Apr 2020 08:37:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-Id:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To;
        bh=HLF/+LUx7J/2rXFpj6mY+dC2tC8N2DBg3yXpcpU2RF8=; b=L+Py9bfhzGjMwSrbKVjBOD+Tk5
        9uo9JBpaHf2rbvRaF38iHa8wqrh0eR5TawTVjI4+IhkTjIWIM1WSb9rXBbhgjEicKHXKnYTv6KT4U
        m3KnrHCiVnMHL6n6drYr8Kr63Mo5+hL3wXW/j80ifhsMvfO2lv1OR2wUCOiP05Bov8eMVSPrWSfnP
        gFjjvN405BNyfVMg8d19dnhKWdH0aqWmQq1u56L29UT471Am+lHE50zcnPDRMIbkDVH15KyGUXWGJ
        slMvk1eO+iGl6HdsngIsX1gvAau9jptNBNKJfxm405bagfW+/R/wV3IzQysQu98j0JMiK4C9H+2rc
        PDoZ1TDA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jTomE-0006Kf-Mm; Wed, 29 Apr 2020 15:37:34 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 66D0B307480;
        Wed, 29 Apr 2020 17:37:32 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id E08B4236D79F3; Wed, 29 Apr 2020 17:37:31 +0200 (CEST)
Message-Id: <20200429153549.252285117@infradead.org>
User-Agent: quilt/0.65
Date:   Wed, 29 Apr 2020 17:33:03 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     linux-kernel@vger.kernel.org
Cc:     walken@google.com, dave@stgolabs.net, mingo@kernel.org,
        tglx@linutronix.de, oleg@redhat.com, irogers@google.com,
        juri.lelli@redhat.com, vincent.guittot@linaro.org,
        peterz@infradead.org
Subject: [RFC][PATCH 5/7] rbtree, uprobes: Use rbtree helpers
References: <20200429153258.563269446@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 kernel/events/uprobes.c  |   82 ++++++++++++++++++++++-------------------------
 kernel/locking/rtmutex.c |   54 ++++++++++--------------------
 2 files changed, 58 insertions(+), 78 deletions(-)

--- a/kernel/events/uprobes.c
+++ b/kernel/events/uprobes.c
@@ -619,41 +619,56 @@ static void put_uprobe(struct uprobe *up
 	}
 }
 
-static int match_uprobe(struct uprobe *l, struct uprobe *r)
+static __always_inline
+int uprobe_cmp(const struct inode *l_inode, const loff_t l_offset,
+	       const struct uprobe *r)
 {
-	if (l->inode < r->inode)
+	if (l_inode < r->inode)
 		return -1;
 
-	if (l->inode > r->inode)
+	if (l_inode > r->inode)
 		return 1;
 
-	if (l->offset < r->offset)
+	if (l_offset < r->offset)
 		return -1;
 
-	if (l->offset > r->offset)
+	if (l_offset > r->offset)
 		return 1;
 
 	return 0;
 }
 
+#define __node_2_uprobe(node) \
+	rb_entry((node), struct uprobe, rb_node)
+
+struct __uprobe_key {
+	struct inode *inode;
+	loff_t offset;
+};
+
+static inline int __uprobe_cmp_key(const void *key, const struct rb_node *b)
+{
+	const struct __uprobe_key *a = key;
+	return uprobe_cmp(a->inode, a->offset, __node_2_uprobe(b));
+}
+
+static inline int __uprobe_cmp(struct rb_node *a, const struct rb_node *b)
+{
+	struct uprobe *u = __node_2_uprobe(a);
+	return uprobe_cmp(u->inode, u->offset, __node_2_uprobe(b));
+}
+
 static struct uprobe *__find_uprobe(struct inode *inode, loff_t offset)
 {
-	struct uprobe u = { .inode = inode, .offset = offset };
-	struct rb_node *n = uprobes_tree.rb_node;
-	struct uprobe *uprobe;
-	int match;
+	struct __uprobe_key key = {
+		.inode = inode,
+		.offset = offset,
+	};
+	struct rb_node *node = rb_find(&uprobes_tree, &key, __uprobe_cmp_key);
+
+	if (node)
+		return __node_2_uprobe(node);
 
-	while (n) {
-		uprobe = rb_entry(n, struct uprobe, rb_node);
-		match = match_uprobe(&u, uprobe);
-		if (!match)
-			return get_uprobe(uprobe);
-
-		if (match < 0)
-			n = n->rb_left;
-		else
-			n = n->rb_right;
-	}
 	return NULL;
 }
 
@@ -674,32 +689,15 @@ static struct uprobe *find_uprobe(struct
 
 static struct uprobe *__insert_uprobe(struct uprobe *uprobe)
 {
-	struct rb_node **p = &uprobes_tree.rb_node;
-	struct rb_node *parent = NULL;
-	struct uprobe *u;
-	int match;
-
-	while (*p) {
-		parent = *p;
-		u = rb_entry(parent, struct uprobe, rb_node);
-		match = match_uprobe(uprobe, u);
-		if (!match)
-			return get_uprobe(u);
-
-		if (match < 0)
-			p = &parent->rb_left;
-		else
-			p = &parent->rb_right;
+	struct rb_node *node;
 
-	}
+	node = rb_find_add(&uprobes_tree, &uprobe->rb_node, __uprobe_cmp);
+	if (node)
+		return get_uprobe(__node_2_uprobe(node));
 
-	u = NULL;
-	rb_link_node(&uprobe->rb_node, parent, p);
-	rb_insert_color(&uprobe->rb_node, &uprobes_tree);
 	/* get access + creation ref */
 	refcount_set(&uprobe->ref, 2);
-
-	return u;
+	return NULL;
 }
 
 /*


