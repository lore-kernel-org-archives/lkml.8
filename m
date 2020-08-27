Return-Path: <SRS0=OCv1=CF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62001C433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Aug 2020 15:12:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 358CD2177B
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Aug 2020 15:12:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="eQf4RpNF";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="BwqGaAlv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728035AbgH0PLp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Aug 2020 11:11:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728798AbgH0LlA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Aug 2020 07:41:00 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66B2DC061264
        for <linux-kernel@vger.kernel.org>; Thu, 27 Aug 2020 04:40:59 -0700 (PDT)
From:   "Ahmed S. Darwish" <a.darwish@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1598528458;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Fyooa1JKyjIOPOClwLVPEO7fYkpy+R2U62wuI7bOcP4=;
        b=eQf4RpNFoowsBHBVaGdXvPdmXXhEHsBObl5z2g7GcL3uNm02SOs4g/be2ByGDWXvj0HwiD
        1O4V+NugNr6qOnpvDH/SwrMDxLQej6tCrrBBBSiN+CmGru7xQ4mFxex0TweES5r/rGuiUY
        OKFzz+YkquVNBR3f1/bACHKXr0cBWM6enI1w4wr01os7A2MYHDJkwrYxB2xYQb4AoKuYNf
        rIs8e4uQN6KT8rOjTMVLhzVstK/gw0Jj3TCZMkaam9SmQVIxlcEL00V8cblVkC7K2sPKkI
        MH2/wIaaBXROOsLoPVjf6UWZAuleyCYtsOE1FWrvNXplh6RmBAE99r0A7vlCAw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1598528458;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Fyooa1JKyjIOPOClwLVPEO7fYkpy+R2U62wuI7bOcP4=;
        b=BwqGaAlvjYNChER2GGWfyB5xjGmyht7aVnMopi5voEJ7XYZSl0zLRk9403M/iSPNNA+yG0
        BA1MgPtkq4XzlAAQ==
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        "Sebastian A. Siewior" <bigeasy@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>,
        "Ahmed S. Darwish" <a.darwish@linutronix.de>
Subject: [PATCH v1 7/8] rbtree_latch: Use seqcount_latch_t
Date:   Thu, 27 Aug 2020 13:40:43 +0200
Message-Id: <20200827114044.11173-8-a.darwish@linutronix.de>
In-Reply-To: <20200827114044.11173-1-a.darwish@linutronix.de>
References: <20200519214547.352050-1-a.darwish@linutronix.de>
 <20200827114044.11173-1-a.darwish@linutronix.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Latch sequence counters have unique read and write APIs, and thus
seqcount_latch_t was recently introduced at seqlock.h.

Use that new data type instead of plain seqcount_t. This adds the
necessary type-safety and ensures that only latching-safe seqcount APIs
are to be used.

Signed-off-by: Ahmed S. Darwish <a.darwish@linutronix.de>
---
 include/linux/rbtree_latch.h | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/include/linux/rbtree_latch.h b/include/linux/rbtree_latch.h
index 7d012faa509a..3d1a9e716b80 100644
--- a/include/linux/rbtree_latch.h
+++ b/include/linux/rbtree_latch.h
@@ -42,8 +42,8 @@ struct latch_tree_node {
 };
 
 struct latch_tree_root {
-	seqcount_t	seq;
-	struct rb_root	tree[2];
+	seqcount_latch_t	seq;
+	struct rb_root		tree[2];
 };
 
 /**
@@ -206,7 +206,7 @@ latch_tree_find(void *key, struct latch_tree_root *root,
 	do {
 		seq = raw_read_seqcount_latch(&root->seq);
 		node = __lt_find(key, root, seq & 1, ops->comp);
-	} while (read_seqcount_retry(&root->seq, seq));
+	} while (read_seqcount_latch_retry(&root->seq, seq));
 
 	return node;
 }
-- 
2.28.0

