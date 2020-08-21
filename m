Return-Path: <SRS0=Oudi=B7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 006B0C433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Aug 2020 15:27:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D3906207DE
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Aug 2020 15:27:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="q1l9IeVS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728140AbgHUP1z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Aug 2020 11:27:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727973AbgHUP1p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Aug 2020 11:27:45 -0400
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EBA6BC061573
        for <linux-kernel@vger.kernel.org>; Fri, 21 Aug 2020 08:27:44 -0700 (PDT)
Received: by mail-wr1-x444.google.com with SMTP id p20so2343450wrf.0
        for <linux-kernel@vger.kernel.org>; Fri, 21 Aug 2020 08:27:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=A2ib5YeLmICUMl8rksAwSuoFVXHYJ4y/hwVWZYHuMbY=;
        b=q1l9IeVSjBMpvx9pappt54xWWzVHKZAIjcy2grhmETrscRqtkMd92gelvCAxF9/YxC
         df2utnw/GutYtLaWTyxshKq81bXGskLk4qcfcSscEKDCL886LGJEwbC1r96+vnepfNBv
         jkjHnEbfuoDp1u2zzg9/wRQMYc1+nwHjwzSo5R54G3vmWIpoag3D8Nw+ooApVOW1lPIL
         2sySVBcDBsREymUfLDG/3d/biHjObMIHhwnvYhhvHCc+2n9XpU8cgcNkZzk/MNTvt1Kj
         Z68WE74zqAh5LRtvnrlfIyn4mnRWfq7JDcngcwi2y3FeCEqGNlMqQpe1/NrbzwXGCJjD
         9J8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=A2ib5YeLmICUMl8rksAwSuoFVXHYJ4y/hwVWZYHuMbY=;
        b=QlAFdqc8BBxy0mMRjXGNFDWsm+Vd0Q4bDq/WtrFotk/dHgq9jjoh5f2aIpF96vmB20
         5nK9Yv5jJ64wEwAeCHTLdotwnafgNVeYmuiisNthpXefXRPJslMOW4AkVR6JLmuQVR5m
         +Jd4FHseVsq5XfoqFraRVrbdnA035kxN2AH+UhlOrJWL2UqTlte6fGhA76O+Ak1ysGVd
         m20GvRJNMXg/wT92oPRgx2g29qxNZydTQhNNySOVvIAUsVLoQ7VhUevv1gH2ndKuXPHO
         5n/4X9r3mNA8ixYsmQBQA3GCssUrdK/d2NQHkZm7F8f+lsnyvvcx5Mux2EAmGsVJYM3b
         iGBw==
X-Gm-Message-State: AOAM533hmanmrPtDwAeiKUVV02yqYjgmkcris8zNGSAzOCcL1q0d0KUi
        +3bSKKOgL6Q3a3bBE7Ty/5s=
X-Google-Smtp-Source: ABdhPJwnHUuth1Lgg+jMpWeo2o0KMQOm5Qu+a71/U7ael4vzzcfepC1XxXX3R/e7IfVXP9rCUNyY7Q==
X-Received: by 2002:a5d:4701:: with SMTP id y1mr3322387wrq.416.1598023663658;
        Fri, 21 Aug 2020 08:27:43 -0700 (PDT)
Received: from tsnow (IGLD-83-130-85-196.inter.net.il. [83.130.85.196])
        by smtp.gmail.com with ESMTPSA id i4sm4575674wrw.26.2020.08.21.08.27.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Aug 2020 08:27:43 -0700 (PDT)
Date:   Fri, 21 Aug 2020 18:27:37 +0300
From:   Tomer Samara <tomersamara98@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Arve =?iso-8859-1?B?SGr4bm5lduVn?= <arve@android.com>,
        Riley Andrews <riandrews@android.com>,
        Laura Abbott <labbott@redhat.com>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        Todd Kjos <tkjos@android.com>,
        Martijn Coenen <maco@android.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Christian Brauner <christian@brauner.io>,
        Hridya Valsaraju <hridya@google.com>,
        Suren Baghdasaryan <surenb@google.com>,
        devel@driverdev.osuosl.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v4 1/2] staging: android: Remove BUG_ON from ion_page_pool.c
Message-ID: <32ea3b6d840cb56ea927400e1875d9d4db38e926.1598023524.git.tomersamara98@gmail.com>
References: <cover.1598023523.git.tomersamara98@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1598023523.git.tomersamara98@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

BUG_ON() is removed at ion_page_pool.c

Fixes the following issue:
Avoid crashing the kernel - try using WARN_ON & recovery code ratherthan BUG() or BUG_ON().

Signed-off-by: Tomer Samara <tomersamara98@gmail.com>
---
 drivers/staging/android/ion/ion_page_pool.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/drivers/staging/android/ion/ion_page_pool.c b/drivers/staging/android/ion/ion_page_pool.c
index 0198b886d906..a3ed3bfd47ee 100644
--- a/drivers/staging/android/ion/ion_page_pool.c
+++ b/drivers/staging/android/ion/ion_page_pool.c
@@ -46,11 +46,9 @@ static struct page *ion_page_pool_remove(struct ion_page_pool *pool, bool high)
 	struct page *page;
 
 	if (high) {
-		BUG_ON(!pool->high_count);
 		page = list_first_entry(&pool->high_items, struct page, lru);
 		pool->high_count--;
 	} else {
-		BUG_ON(!pool->low_count);
 		page = list_first_entry(&pool->low_items, struct page, lru);
 		pool->low_count--;
 	}
@@ -65,8 +63,6 @@ struct page *ion_page_pool_alloc(struct ion_page_pool *pool)
 {
 	struct page *page = NULL;
 
-	BUG_ON(!pool);
-
 	mutex_lock(&pool->mutex);
 	if (pool->high_count)
 		page = ion_page_pool_remove(pool, true);
@@ -82,7 +78,7 @@ struct page *ion_page_pool_alloc(struct ion_page_pool *pool)
 
 void ion_page_pool_free(struct ion_page_pool *pool, struct page *page)
 {
-	BUG_ON(pool->order != compound_order(page));
+	WARN_ON(pool->order != compound_order(page))
 
 	ion_page_pool_add(pool, page);
 }
-- 
2.25.1

