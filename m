Return-Path: <SRS0=EnQK=B5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 515D2C433E1
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Aug 2020 19:39:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2F4B7207BB
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Aug 2020 19:39:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Y/TMCp2A"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726980AbgHSTjB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Aug 2020 15:39:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726466AbgHSTi6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Aug 2020 15:38:58 -0400
Received: from mail-ej1-x642.google.com (mail-ej1-x642.google.com [IPv6:2a00:1450:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38B2BC061757
        for <linux-kernel@vger.kernel.org>; Wed, 19 Aug 2020 12:38:57 -0700 (PDT)
Received: by mail-ej1-x642.google.com with SMTP id jp10so27740962ejb.0
        for <linux-kernel@vger.kernel.org>; Wed, 19 Aug 2020 12:38:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=YRPJpeT5dhxWJ12GIFcarr8oc1JgRi4yV8j1UvVpQQs=;
        b=Y/TMCp2AfpTBeZ1xLSiaWieg09HkNJpTltYziCwR0usYRnVKobknSYN9bZc2H9GOU3
         RlIzAqE9UhP0dz/dIgffplwsHnZ1x+3PLshll/AhehzZn2KTF23JO76enX5pTX5OJsup
         8WmPltVJM2ZOJdjgexK8RyQ0dCeuBPqsGfwdgFRz+oF84/sKwsu+AC5jELgEtq0rgbQE
         PjJIav1YKoqMmyPrZWdFV3DEyAjPYgVOlnEnEkUMxzCHp3n575g0i3fAw1QUt6gfcOIp
         DcmV0sGoZMEdYhGzIEsBf1K6jqr4iBeu7ULnw1jnCMq4sCDnr/ug208FqJx8N6exgCI8
         bXhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=YRPJpeT5dhxWJ12GIFcarr8oc1JgRi4yV8j1UvVpQQs=;
        b=AS5AH5ilqM/CAPAogKxvsQhEZ4f/VHHhXbkkXQYyZYSQ/0H30sj24VGyLAlgPQHISW
         Ugn+H67eVitRuko7stz+RXQe2BVTbb4LQKhuXvG2UvRFHRGvaH5he6y/0/M0t0w4Nsf0
         3/XLevYSykS12Sx3cduNcI2t0TT65ILoVZlsmChOsDaLisL8AlGJvD61Ydn/kG5ylo8m
         qMHtuv2FvdqLlEXs256wrobAZqL+ptEGJtTi24AVQ/DwdGTGJmO8gkDao6gI9Sa7Ujwa
         FtYM/h6JDf6KEksz8w6EYVBttez+j8ef6x8A+sFohkNXI/A4Igm/NBuJRjV+HzD6RTIo
         oK3Q==
X-Gm-Message-State: AOAM531BgAEJvBdj7z/+ZeOzgK2okFL9kd5hF4dUcmPHvm95zEq0LU09
        WrPyAO5c3QzPd1FaY+L8Uds=
X-Google-Smtp-Source: ABdhPJwaiRRbcYN8dZl/U4YqQD41O2+zpth7YbXzWPNZCNAzTKai7VUycG9u+6QMlPAbQdRSaR7nAQ==
X-Received: by 2002:a17:906:c187:: with SMTP id g7mr6051159ejz.108.1597865936360;
        Wed, 19 Aug 2020 12:38:56 -0700 (PDT)
Received: from tsnow (IGLD-83-130-68-114.inter.net.il. [83.130.68.114])
        by smtp.gmail.com with ESMTPSA id x16sm18064084edr.25.2020.08.19.12.38.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Aug 2020 12:38:55 -0700 (PDT)
Date:   Wed, 19 Aug 2020 22:38:47 +0300
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
Subject: [PATCH v3 1/2] staging: android: Remove BUG_ON from ion_page_pool.c
Message-ID: <2e6c71ad168f92170ef856922b9a0c8dd0f85e11.1597865771.git.tomersamara98@gmail.com>
References: <cover.1597865771.git.tomersamara98@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1597865771.git.tomersamara98@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

BUG_ON() is removed at ion_page_pool.c and add error handleing to
ion_page_pool_shrink

Fixes the following issue:
Avoid crashing the kernel - try using WARN_ON & recovery code ratherthan BUG() or BUG_ON().

Signed-off-by: Tomer Samara <tomersamara98@gmail.com>
---
 drivers/staging/android/ion/ion_page_pool.c | 14 ++++++++++----
 1 file changed, 10 insertions(+), 4 deletions(-)

diff --git a/drivers/staging/android/ion/ion_page_pool.c b/drivers/staging/android/ion/ion_page_pool.c
index 0198b886d906..ae2bc57bcbe8 100644
--- a/drivers/staging/android/ion/ion_page_pool.c
+++ b/drivers/staging/android/ion/ion_page_pool.c
@@ -46,11 +46,13 @@ static struct page *ion_page_pool_remove(struct ion_page_pool *pool, bool high)
 	struct page *page;
 
 	if (high) {
-		BUG_ON(!pool->high_count);
+		if (!pool->high_count)
+			return NULL;
 		page = list_first_entry(&pool->high_items, struct page, lru);
 		pool->high_count--;
 	} else {
-		BUG_ON(!pool->low_count);
+		if (!pool->low_count)
+			return NULL;
 		page = list_first_entry(&pool->low_items, struct page, lru);
 		pool->low_count--;
 	}
@@ -65,7 +67,8 @@ struct page *ion_page_pool_alloc(struct ion_page_pool *pool)
 {
 	struct page *page = NULL;
 
-	BUG_ON(!pool);
+	if (!pool)
+		return NULL;
 
 	mutex_lock(&pool->mutex);
 	if (pool->high_count)
@@ -82,7 +85,8 @@ struct page *ion_page_pool_alloc(struct ion_page_pool *pool)
 
 void ion_page_pool_free(struct ion_page_pool *pool, struct page *page)
 {
-	BUG_ON(pool->order != compound_order(page));
+	if (pool->order != compound_order(page))
+		return;
 
 	ion_page_pool_add(pool, page);
 }
@@ -124,6 +128,8 @@ int ion_page_pool_shrink(struct ion_page_pool *pool, gfp_t gfp_mask,
 			break;
 		}
 		mutex_unlock(&pool->mutex);
+		if (!page)
+			break;
 		ion_page_pool_free_pages(pool, page);
 		freed += (1 << pool->order);
 	}
-- 
2.25.1

