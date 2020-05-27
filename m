Return-Path: <SRS0=UR55=7J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1994C433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 27 May 2020 20:51:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C91D720DD4
	for <linux-kernel@archiver.kernel.org>; Wed, 27 May 2020 20:51:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="n3AmKW+b"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728475AbgE0UvJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 May 2020 16:51:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726129AbgE0UvF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 May 2020 16:51:05 -0400
Received: from mail-lf1-x141.google.com (mail-lf1-x141.google.com [IPv6:2a00:1450:4864:20::141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 546C0C05BD1E
        for <linux-kernel@vger.kernel.org>; Wed, 27 May 2020 13:51:05 -0700 (PDT)
Received: by mail-lf1-x141.google.com with SMTP id c12so15287559lfc.10
        for <linux-kernel@vger.kernel.org>; Wed, 27 May 2020 13:51:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=jZe9RvzT7wl7ndcZbn0P06YqzSmFmsaoAvrOUPt0Ne8=;
        b=n3AmKW+bKEYTPO20auGkzmmC8j2yS6HdooUNkIgxZhVvxbBwSjtiXZgEgozslW60RD
         ogH8JqfhCJF+R2MfnvFuOSTvPocn6q6heuZaPt41lm/7L7xhUOpAHSE76Fic3PbwnRGt
         kf9bcQN7tMt+EQMJOXgEuwvTlmXFQyA4HO58X0X0iqb8QX8PsNtn2XvyXTkd35qDmHsU
         ce28g+ITpqbkBblq/BZAhxWi/4kAit2ny6TaIDhR7r9vhvW5owNwWouUErgbJgXC/Fal
         3tJHPdt5IPGnlOWdzCGIFJa/BiyhmqgAq9GlQ4wgK/cR6F1w4lp4QWkHph6dyCehXCtG
         cxHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=jZe9RvzT7wl7ndcZbn0P06YqzSmFmsaoAvrOUPt0Ne8=;
        b=UwQ6dbWufio+2i+dBYUx5NmoikWDnDYfI6dDJtwo76c3bz9gc7oMryABjiRiZpTBdx
         92p1JjPbcGoDsOlzkIkKeqzR5XkvdmhhKCCv+UHjL4K4eb5SLXqrbEt+JoSHO6/55xNF
         LgHxWTG1aYmGK3Sx2TRy0DJqReQdrisqUdNs3KRwPgjbpFL6+gCzY27aHQ81l0kI57mx
         J7jUcVlaMdykeI/GMC1U9jPqQ+RzPoOdF+J4feXvdz+ZiK+llNE1RQGRhQRWiSz7SPQQ
         2OjOctV0iypy2LDb8zv1pzHZcZUd1w4n8SI9MxfzOTPoJnGiMmsQ31Am0TCfx46sYWHL
         U7UA==
X-Gm-Message-State: AOAM530wDbNG8LGwo88pBPq6q5X5OUWuW2Xhj60OZn9J+VatJ7zvoV4P
        rTQPdP09aBx96LoaiTTHJrI=
X-Google-Smtp-Source: ABdhPJx2ZWW44hsL/x3eDlEFjD3nvzE31o/wrgaO+cuPsQZoKAwspUtTZZ5einOvs8496ZFr9mvhVA==
X-Received: by 2002:a19:6554:: with SMTP id c20mr3886603lfj.140.1590612663778;
        Wed, 27 May 2020 13:51:03 -0700 (PDT)
Received: from pc638.lan (h5ef52e31.seluork.dyn.perspektivbredband.net. [94.245.46.49])
        by smtp.gmail.com with ESMTPSA id z78sm1045919lfc.80.2020.05.27.13.51.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 May 2020 13:51:03 -0700 (PDT)
From:   "Uladzislau Rezki (Sony)" <urezki@gmail.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-mm@kvack.org, LKML <linux-kernel@vger.kernel.org>,
        Uladzislau Rezki <urezki@gmail.com>,
        Hillf Danton <hdanton@sina.com>,
        Michal Hocko <mhocko@suse.com>,
        Matthew Wilcox <willy@infradead.org>,
        Oleksiy Avramchenko <oleksiy.avramchenko@sonymobile.com>,
        Steven Rostedt <rostedt@goodmis.org>
Subject: [PATCH 2/3] mm/vmalloc: simplify augment_tree_propagate_check() func.
Date:   Wed, 27 May 2020 22:50:53 +0200
Message-Id: <20200527205054.1696-2-urezki@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200527205054.1696-1-urezki@gmail.com>
References: <20200527205054.1696-1-urezki@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This function is for debug purpose only. Currently it uses
recursion for tree traversal, checking an augmented value
of each node to find out if it is valid or not.

The recursion can corrupt the stack because the tree can be
huge if synthetic tests are applied. To prevent it, navigate
the tree from bottom to upper levels using a regular list
instead, because nodes are linked among each other also.
It is faster and without recursion.

Signed-off-by: Uladzislau Rezki (Sony) <urezki@gmail.com>
---
 mm/vmalloc.c | 42 ++++++++----------------------------------
 1 file changed, 8 insertions(+), 34 deletions(-)

diff --git a/mm/vmalloc.c b/mm/vmalloc.c
index a875eef1e2c2..62d48f5e7105 100644
--- a/mm/vmalloc.c
+++ b/mm/vmalloc.c
@@ -589,43 +589,17 @@ unlink_va(struct vmap_area *va, struct rb_root *root)
 
 #if DEBUG_AUGMENT_PROPAGATE_CHECK
 static void
-augment_tree_propagate_check(struct rb_node *n)
+augment_tree_propagate_check(void)
 {
 	struct vmap_area *va;
-	struct rb_node *node;
-	unsigned long size;
-	bool found = false;
-
-	if (n == NULL)
-		return;
-
-	va = rb_entry(n, struct vmap_area, rb_node);
-	size = va->subtree_max_size;
-	node = n;
-
-	while (node) {
-		va = rb_entry(node, struct vmap_area, rb_node);
-
-		if (get_subtree_max_size(node->rb_left) == size) {
-			node = node->rb_left;
-		} else {
-			if (va_size(va) == size) {
-				found = true;
-				break;
-			}
+	unsigned long computed_size;
 
-			node = node->rb_right;
-		}
-	}
-
-	if (!found) {
-		va = rb_entry(n, struct vmap_area, rb_node);
-		pr_emerg("tree is corrupted: %lu, %lu\n",
-			va_size(va), va->subtree_max_size);
+	list_for_each_entry(va, &free_vmap_area_list, list) {
+		computed_size = compute_subtree_max_size(va);
+		if (computed_size != va->subtree_max_size)
+			pr_emerg("tree is corrupted: %lu, %lu\n",
+				va_size(va), va->subtree_max_size);
 	}
-
-	augment_tree_propagate_check(n->rb_left);
-	augment_tree_propagate_check(n->rb_right);
 }
 #endif
 
@@ -680,7 +654,7 @@ augment_tree_propagate_from(struct vmap_area *va)
 	}
 
 #if DEBUG_AUGMENT_PROPAGATE_CHECK
-	augment_tree_propagate_check(free_vmap_area_root.rb_node);
+	augment_tree_propagate_check();
 #endif
 }
 
-- 
2.20.1

