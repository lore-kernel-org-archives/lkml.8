Return-Path: <SRS0=fsZL=42=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A56B9C10F27
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Mar 2020 16:02:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 767DF208C3
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Mar 2020 16:02:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="po9U227B"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727059AbgCIQCV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Mar 2020 12:02:21 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:44154 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726758AbgCIQCV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Mar 2020 12:02:21 -0400
Received: by mail-pl1-f195.google.com with SMTP id d9so4137752plo.11
        for <linux-kernel@vger.kernel.org>; Mon, 09 Mar 2020 09:02:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=FPahBlx9BxgYf27cCynxoigTpGq1oNMafhDT1t5E2i0=;
        b=po9U227B3G8D+omYOHGTuf/4x0/W09eJkeNJg4vLPzb4Rd5ucAh7Z21VTV2lLryz0I
         rHFfoxh7V+x1VQOAC9k8tgGB2zDS/nkEEZ83Btpw9Ch6e2PytlZqxUbUD2HLdIYPY71w
         pvtjSoyW6mUBooxIseZ94yeg8ejfVUHsSlgJxdzFvgJEwsmv5QO9WkhyGXv4TEB1TMcz
         q+aQKW2Qs5vlLv4e1vkQMh0/rsTGBJfBoi/gt1QTUi8/DyZ3PGsmaOPGLsw/3yLgB3eD
         G6ImskgVSMfs12GhCwE1Ge/4SUoJJ9UuhPGzpqae1vYOG/0Zm4GvRM21CLEeDuT0kYIg
         dPdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=FPahBlx9BxgYf27cCynxoigTpGq1oNMafhDT1t5E2i0=;
        b=QnbNVKWTu9pK6Nq2hnvzVviRnDudsU9t5PVWY0VMI5oHLbiZWicOqxT+vN0H3wCfkm
         fEUxuHE+rV4yxkHKBu5ogbOjzR9iD9xihrkb7ltKe7KJoBCCHCp1PkS4wwRiI0A6KXWm
         ln0f+QvRqaIc8YjjxxGzLl30pP5DNTuCzFUKQfXc8QHSrB8SOwAQqR0nm0gQqgHjzGrc
         Bvp2xL2yRQ9POhofsfW4alu8DUoZIuBnp8hyzKgFHR0YLGZNBFJ1Dx0yq19Vp9++VbR2
         adT71XQNPRbWwrag4tTiTQ9xWnWBT8PuREp+XsR8w0Z80kwKPq0bkdAh2QoHjoHcDc60
         LcNA==
X-Gm-Message-State: ANhLgQ1odImggpkydnhu2/9kTItCneNyDpIXI34ewfYutCmftAnOwxV8
        uAu2PkvfWkPdqmuVZctoqpE=
X-Google-Smtp-Source: ADFU+vuTmDpK2u1hSHiAOuALuH6EjpV9vE0STSXYwk6jvu0PW54pEH7vbVVsSmLV0pI67uFpz6AJOQ==
X-Received: by 2002:a17:90a:8:: with SMTP id 8mr18953pja.130.1583769740092;
        Mon, 09 Mar 2020 09:02:20 -0700 (PDT)
Received: from localhost ([43.224.245.179])
        by smtp.gmail.com with ESMTPSA id q12sm45104429pfh.158.2020.03.09.09.02.18
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Mon, 09 Mar 2020 09:02:19 -0700 (PDT)
From:   qiwuchen55@gmail.com
To:     akpm@linux-foundation.org, peterz@infradead.org, walken@google.com,
        rfontana@redhat.com, dbueso@suse.de
Cc:     tglx@linutronix.de, linux-kernel@vger.kernel.org,
        chenqiwu <chenqiwu@xiaomi.com>
Subject: [PATCH] rbtree: introduce three helpers about sort-order iteration
Date:   Tue, 10 Mar 2020 00:02:14 +0800
Message-Id: <1583769734-1311-1-git-send-email-qiwuchen55@gmail.com>
X-Mailer: git-send-email 1.9.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: chenqiwu <chenqiwu@xiaomi.com>

I noticed that there are many relatively common usages about the
sort-order iteration for rbtree, like this:

[drivers/android/binder.c]
for (n = rb_first(&proc->nodes); n != NULL; n = rb_next(n)) {
	struct binder_node *node = rb_entry(n, struct binder_node,
					    rb_node);
	......
}

This patch introduced three helpers to simplify sort-order iteration
for rbtree.

Signed-off-by: chenqiwu <chenqiwu@xiaomi.com>
---
 include/linux/rbtree.h | 45 +++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 43 insertions(+), 2 deletions(-)

diff --git a/include/linux/rbtree.h b/include/linux/rbtree.h
index 1fd61a9..26b4359 100644
--- a/include/linux/rbtree.h
+++ b/include/linux/rbtree.h
@@ -90,11 +90,52 @@ static inline void rb_link_node_rcu(struct rb_node *node, struct rb_node *parent
 	})
 
 /**
+ * rbtree_for_each - iterate in sort-order over a rbtree.
+ * @pos:	the 'rb_node *' to use as a loop cursor.
+ * @root:	'rb_root *' of the rbtree.
+ */
+#define rbtree_for_each(pos, root) \
+	for (pos = rb_first(root); pos; pos = rb_next(pos))
+
+/**
+ * rbtree_for_each_entry - iterate in sort-order over rb_root of given type.
+ * @pos:	the 'type *' to use as a loop cursor.
+ * @root:	'rb_root *' of the rbtree.
+ * @field:	the name of the rb_node field within 'type'.
+ */
+#define rbtree_for_each_entry(pos, root, field) \
+	for (pos = rb_entry_safe(rb_first(root), typeof(*pos), field); \
+	     pos; \
+	     pos = rb_entry_safe(rb_next(&pos->field), typeof(*pos), field))
+
+/**
+ * rbtree_for_each_entry_safe - iterate in sort-order over of given type
+ * allowing the backing memory of @pos to be invalidated.
+ * @pos:	the 'type *' to use as a loop cursor.
+ * @n:		another 'type *' to use as temporary storage.
+ * @root:	'rb_root *' of the rbtree.
+ * @field:	the name of the rb_node field within 'type'.
+ *
+ * rbtree_order_for_each_entry_safe() provides a similar guarantee as
+ * list_for_each_entry_safe() and allows the sort-order iteration to
+ * continue independent of changes to @pos by the body of the loop.
+ *
+ * Note, however, that it cannot handle other modifications that re-order the
+ * rbtree it is iterating over. This includes calling rb_erase() on @pos, as
+ * rb_erase() may rebalance the tree, causing us to miss some nodes.
+ */
+#define rbtree_for_each_entry_safe(pos, n, root, field) \
+	for (pos = rb_entry_safe(rb_first(root), typeof(*pos), field); \
+	     pos && ({ n = rb_entry_safe(rb_next(&pos->field), \
+			typeof(*pos), field); 1; }); \
+	     pos = n)
+
+/**
  * rbtree_postorder_for_each_entry_safe - iterate in post-order over rb_root of
- * given type allowing the backing memory of @pos to be invalidated
+ * given type allowing the backing memory of @pos to be invalidated.
  *
  * @pos:	the 'type *' to use as a loop cursor.
- * @n:		another 'type *' to use as temporary storage
+ * @n:		another 'type *' to use as temporary storage.
  * @root:	'rb_root *' of the rbtree.
  * @field:	the name of the rb_node field within 'type'.
  *
-- 
1.9.1

