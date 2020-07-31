Return-Path: <SRS0=S/iQ=BK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0313C433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Jul 2020 21:28:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D87432087C
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Jul 2020 21:28:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728291AbgGaV2Y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 Jul 2020 17:28:24 -0400
Received: from mail-lf1-f67.google.com ([209.85.167.67]:35412 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726806AbgGaV2Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Jul 2020 17:28:24 -0400
Received: by mail-lf1-f67.google.com with SMTP id j22so11683172lfm.2
        for <linux-kernel@vger.kernel.org>; Fri, 31 Jul 2020 14:28:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=2LM9wmlkgT4PsRWE1wCcqgQWCXbjCWE/5JCh3nJ0oCA=;
        b=FdGu0jzP55VSvuvrqU/RWMTfZf6fu1vgUm4hY4m2jV580ml9lYmmqQghBcSlrhkTzR
         KpxaKRwYqtEiHep/ODjxcaE7THQkaLucc2GCXxjXsJsVtnQTgd8bvVRU4w8XJBxVZ9oz
         pO9JiEnhcOJYxekCkwE8+mC7SxU/T+Anm9ZZ24ExsU/i+DEtjDgRvgQ6qLa+V0UiqQMG
         +xGUxtHyHVb2EcC+SM7IZ9IC7VwVL5ZfMzMarvsCX6yjZa3RhwYp7I3hT3Gz8kZgZjbK
         ozxSMOrZzTHgL6opmfEW94tFLtwNvwFPC4MQFZo3L3DFRNH9Ie36zo+o3izmHEj9J0HF
         ZAWA==
X-Gm-Message-State: AOAM533VrlBiLAoM6bG9Rsub5oiZPqOmj2bDgagNNcoiEtCEaznJ2h5y
        GqsWq6Btfs0K+sb6vBrr6VoUbNvVljg=
X-Google-Smtp-Source: ABdhPJx5rpPcTf6BM7go7zcF82POs7Vn/gQAL/VNoJB8vwJy+X5By9cH+RyEn/BuffP3aKBK6Z020Q==
X-Received: by 2002:a19:e50:: with SMTP id 77mr2864709lfo.188.1596230902010;
        Fri, 31 Jul 2020 14:28:22 -0700 (PDT)
Received: from localhost.localdomain (broadband-37-110-38-130.ip.moscow.rt.ru. [37.110.38.130])
        by smtp.googlemail.com with ESMTPSA id y1sm2643326lfb.45.2020.07.31.14.28.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 Jul 2020 14:28:21 -0700 (PDT)
From:   Denis Efremov <efremov@linux.com>
To:     Bob Peterson <rpeterso@redhat.com>,
        Andreas Gruenbacher <agruenba@redhat.com>
Cc:     Denis Efremov <efremov@linux.com>, cluster-devel@redhat.com,
        linux-kernel@vger.kernel.org
Subject: [PATCH] gfs2: Use kvmalloc instead of opencoded kmalloc/vmalloc
Date:   Sat,  1 Aug 2020 00:28:18 +0300
Message-Id: <20200731212818.10782-1-efremov@linux.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use kvmalloc instead of opencoded kmalloc/vmalloc condition.

Signed-off-by: Denis Efremov <efremov@linux.com>
---
 fs/gfs2/dir.c   | 23 ++++-------------------
 fs/gfs2/quota.c |  5 +----
 2 files changed, 5 insertions(+), 23 deletions(-)

diff --git a/fs/gfs2/dir.c b/fs/gfs2/dir.c
index c0f2875c946c..5d2a708fae9c 100644
--- a/fs/gfs2/dir.c
+++ b/fs/gfs2/dir.c
@@ -352,9 +352,7 @@ static __be64 *gfs2_dir_get_hash_table(struct gfs2_inode *ip)
 		return ERR_PTR(-EIO);
 	}
 
-	hc = kmalloc(hsize, GFP_NOFS | __GFP_NOWARN);
-	if (hc == NULL)
-		hc = __vmalloc(hsize, GFP_NOFS);
+	hc = kvmalloc(hsize, GFP_NOFS);
 
 	if (hc == NULL)
 		return ERR_PTR(-ENOMEM);
@@ -1320,18 +1318,6 @@ static int do_filldir_main(struct gfs2_inode *dip, struct dir_context *ctx,
 	return 0;
 }
 
-static void *gfs2_alloc_sort_buffer(unsigned size)
-{
-	void *ptr = NULL;
-
-	if (size < KMALLOC_MAX_SIZE)
-		ptr = kmalloc(size, GFP_NOFS | __GFP_NOWARN);
-	if (!ptr)
-		ptr = __vmalloc(size, GFP_NOFS);
-	return ptr;
-}
-
-
 static int gfs2_set_cookies(struct gfs2_sbd *sdp, struct buffer_head *bh,
 			    unsigned leaf_nr, struct gfs2_dirent **darr,
 			    unsigned entries)
@@ -1409,7 +1395,8 @@ static int gfs2_dir_read_leaf(struct inode *inode, struct dir_context *ctx,
 	 * 99 is the maximum number of entries that can fit in a single
 	 * leaf block.
 	 */
-	larr = gfs2_alloc_sort_buffer((leaves + entries + 99) * sizeof(void *));
+	larr = kvmalloc_array(leaves + entries + 99,
+			      sizeof(void *), GFP_NOFS);
 	if (!larr)
 		goto out;
 	darr = (struct gfs2_dirent **)(larr + leaves);
@@ -1985,9 +1972,7 @@ static int leaf_dealloc(struct gfs2_inode *dip, u32 index, u32 len,
 
 	memset(&rlist, 0, sizeof(struct gfs2_rgrp_list));
 
-	ht = kzalloc(size, GFP_NOFS | __GFP_NOWARN);
-	if (ht == NULL)
-		ht = __vmalloc(size, GFP_NOFS | __GFP_NOWARN | __GFP_ZERO);
+	ht = kvzalloc(size, GFP_NOFS);
 	if (!ht)
 		return -ENOMEM;
 
diff --git a/fs/gfs2/quota.c b/fs/gfs2/quota.c
index 4b67d47a7e00..204b34f38e5c 100644
--- a/fs/gfs2/quota.c
+++ b/fs/gfs2/quota.c
@@ -1362,10 +1362,7 @@ int gfs2_quota_init(struct gfs2_sbd *sdp)
 	bm_size = DIV_ROUND_UP(sdp->sd_quota_slots, 8 * sizeof(unsigned long));
 	bm_size *= sizeof(unsigned long);
 	error = -ENOMEM;
-	sdp->sd_quota_bitmap = kzalloc(bm_size, GFP_NOFS | __GFP_NOWARN);
-	if (sdp->sd_quota_bitmap == NULL)
-		sdp->sd_quota_bitmap = __vmalloc(bm_size, GFP_NOFS |
-						 __GFP_ZERO);
+	sdp->sd_quota_bitmap = kvzalloc(bm_size, GFP_NOFS);
 	if (!sdp->sd_quota_bitmap)
 		return error;
 
-- 
2.26.2

