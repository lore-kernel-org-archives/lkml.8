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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62951C433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 27 May 2020 20:51:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3783220890
	for <linux-kernel@archiver.kernel.org>; Wed, 27 May 2020 20:51:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="drVk745L"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728596AbgE0UvM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 May 2020 16:51:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728082AbgE0UvI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 May 2020 16:51:08 -0400
Received: from mail-lj1-x243.google.com (mail-lj1-x243.google.com [IPv6:2a00:1450:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 672FCC08C5C1
        for <linux-kernel@vger.kernel.org>; Wed, 27 May 2020 13:51:06 -0700 (PDT)
Received: by mail-lj1-x243.google.com with SMTP id b6so30690385ljj.1
        for <linux-kernel@vger.kernel.org>; Wed, 27 May 2020 13:51:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=OmqE1cLIwHpE8JGzINfwEZTtrgAXgsJu/fEWYlPrDEY=;
        b=drVk745LRWLryhFg3ZtxBGKcWOOHTcyc8bs1BpYQLj4kEeO2aiqzwvm6H4ZelTQOhD
         JeL5DNb1rgwjMXIozFMRJaFGetE3q+jZ7/zBRbmTfS0nuXlSH/ZbSd6SOU60/XsAk5/Q
         F0yCqeX2OueKBUxP26pGNbPlLf+ZkrNEW9ER9NR3hjz5xNMKFdhYVOhNuGJ+8rfKM43o
         8xY+zwXUrDe/V3wi5LOA/wVegzMUine3gO0+HGjtGeod2dJs1Ct1yj1M+N/S3pQSfzi5
         C1wzVgK1TFvxUrQ8GqpROrDQt/iPhUvMmu+CSaMfwp9puM0SAWuMo1U8+TdXZ/j1NCbu
         0bDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=OmqE1cLIwHpE8JGzINfwEZTtrgAXgsJu/fEWYlPrDEY=;
        b=oUB2Rh4lX7YjY7iiI8jNGP6aAPP0NicmLLO0kGoshAGzGqIjCXb3uK75cAIgG3TUmA
         J5/99XKpGXTY9UMKZ0qjEQWS4OzrPAN9m1ePaCrGEEK5LB/7BfhyK3mgFvOojf+bkcAz
         kUbBZwni3fAOZEA+vXB3IPDdixmeHd+y36EhDMgC9p+Hlf+NbDnYxQU9+km17L25wcck
         rlm2YouD7Wi2sJPRXVm2BedN4WVDKaD/wMEHDKRw54TFB2Vh1ZkaCibbsvJ17V+07fLi
         bcGwD3KGqXLvV1ByaxhP4rNUgLTUE9/Vpgdt7bvVK33N+qB+Om6N5TlxgZPiCADrF3BB
         0mLA==
X-Gm-Message-State: AOAM532qCZ+wfNBd+Z9VDxtTd/FMGkEBmXi8EHbGH0ilH1MeSHkFeg1h
        O2zxbTpx9zSNSvMRIyiPcpY=
X-Google-Smtp-Source: ABdhPJwCwQrSw/zunwzVa/PiIHTusXHW4ZfltBsjfWuWSwh5DRWilqn62KbStOdr3Kjzckw34M32tw==
X-Received: by 2002:a05:651c:338:: with SMTP id b24mr3553506ljp.118.1590612664836;
        Wed, 27 May 2020 13:51:04 -0700 (PDT)
Received: from pc638.lan (h5ef52e31.seluork.dyn.perspektivbredband.net. [94.245.46.49])
        by smtp.gmail.com with ESMTPSA id z78sm1045919lfc.80.2020.05.27.13.51.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 May 2020 13:51:04 -0700 (PDT)
From:   "Uladzislau Rezki (Sony)" <urezki@gmail.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-mm@kvack.org, LKML <linux-kernel@vger.kernel.org>,
        Uladzislau Rezki <urezki@gmail.com>,
        Hillf Danton <hdanton@sina.com>,
        Michal Hocko <mhocko@suse.com>,
        Matthew Wilcox <willy@infradead.org>,
        Oleksiy Avramchenko <oleksiy.avramchenko@sonymobile.com>,
        Steven Rostedt <rostedt@goodmis.org>
Subject: [PATCH 3/3] mm/vmalloc: switch to "propagate()" callback
Date:   Wed, 27 May 2020 22:50:54 +0200
Message-Id: <20200527205054.1696-3-urezki@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200527205054.1696-1-urezki@gmail.com>
References: <20200527205054.1696-1-urezki@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

An augment_tree_propagate_from() function uses its own
implementation that populates a tree from the specified
node toward a root node.

From the other hand the RB_DECLARE_CALLBACKS_MAX macro
provides the "propagate()" callback that does exactly
the same. Having two similar functions does not make
sense and is redundant.

Reuse "built in" functionality to the macros. So the
code size gets reduced.

Signed-off-by: Uladzislau Rezki (Sony) <urezki@gmail.com>
---
 mm/vmalloc.c | 25 ++++++-------------------
 1 file changed, 6 insertions(+), 19 deletions(-)

diff --git a/mm/vmalloc.c b/mm/vmalloc.c
index 62d48f5e7105..e3d5b8d1f987 100644
--- a/mm/vmalloc.c
+++ b/mm/vmalloc.c
@@ -633,25 +633,12 @@ augment_tree_propagate_check(void)
 static __always_inline void
 augment_tree_propagate_from(struct vmap_area *va)
 {
-	struct rb_node *node = &va->rb_node;
-	unsigned long new_va_sub_max_size;
-
-	while (node) {
-		va = rb_entry(node, struct vmap_area, rb_node);
-		new_va_sub_max_size = compute_subtree_max_size(va);
-
-		/*
-		 * If the newly calculated maximum available size of the
-		 * subtree is equal to the current one, then it means that
-		 * the tree is propagated correctly. So we have to stop at
-		 * this point to save cycles.
-		 */
-		if (va->subtree_max_size == new_va_sub_max_size)
-			break;
-
-		va->subtree_max_size = new_va_sub_max_size;
-		node = rb_parent(&va->rb_node);
-	}
+	/*
+	 * Populate the tree from bottom towards the root until
+	 * the calculated maximum available size of checked node
+	 * is equal to its current one.
+	 */
+	free_vmap_area_rb_augment_cb_propagate(&va->rb_node, NULL);
 
 #if DEBUG_AUGMENT_PROPAGATE_CHECK
 	augment_tree_propagate_check();
-- 
2.20.1

