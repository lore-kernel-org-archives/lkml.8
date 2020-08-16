Return-Path: <SRS0=yO2T=B2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B2F8C433DF
	for <linux-kernel@archiver.kernel.org>; Sun, 16 Aug 2020 17:21:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D850920658
	for <linux-kernel@archiver.kernel.org>; Sun, 16 Aug 2020 17:21:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Y6u1bIXt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729377AbgHPRVw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 16 Aug 2020 13:21:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726511AbgHPRVv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Aug 2020 13:21:51 -0400
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C049C061786
        for <linux-kernel@vger.kernel.org>; Sun, 16 Aug 2020 10:21:51 -0700 (PDT)
Received: by mail-wr1-x442.google.com with SMTP id c15so12626191wrs.11
        for <linux-kernel@vger.kernel.org>; Sun, 16 Aug 2020 10:21:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=qhnpa/trjt4QH5oDT0w3lHC9wDtosLLIKcCmM7fmRXQ=;
        b=Y6u1bIXtETM8nGKBLOBIaoMtwk7e5Dq322h5yNAMefwW3i4FFJYEsqBEsxmq18/fq9
         ObAoERHhe90ZEKwShMc6+htbd50V4WJvTmDHdgjXBjna2PbHzD844iMrjmHMbrEojuDU
         JCuD+pgOnmx8YEZO8konRuzf8afDGnIl2/BrV26HFcFCb08Pxh/a8tgAfV+lwWfO1iSb
         lyd4tRbvqaKbydcHQt7dMMHBM1ThkrT0Q8aXsrvpbGtNimi3nNj9zyG1iDsQTiltuSJJ
         ySeqmVUsvIJcj7WvE+UX+MZx8rQIMNNV9PgA5qj85w1Jaqyfvg+PH1vymjfAGYmlaHst
         RAJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=qhnpa/trjt4QH5oDT0w3lHC9wDtosLLIKcCmM7fmRXQ=;
        b=TtgvUs6+RKYBoCDh2ig40XA+u2Zga8a/ahqItRgXpPZlv2wbw8OpFO1pBrmdUd6bmL
         baZxGko1V2TSHyFDKVFLMY+6YkV6ap9jDwo4cxdNudxJ6uS6+uDMdDk1Yx/Jnhzu5Gb+
         /k+Vbi1qkMSXDscQ4oSa+0hxFOke5DNT7sduwOomZCJyEW7BGRfRxxU2ON611Cy7jVPy
         Cqr/OLnqZ3e5nBwGu0GcNUauF4j7I/JGfXvfAeg2evKIqdnrNC0XwLDhx0uA0qL+1cvB
         oUPIzdSy1ySNT6XNuHI6hj3xOn9/m6ph+/VlVb9KLMgG4uBqBxfzGoXBETDFW1Ml+e6q
         uWRQ==
X-Gm-Message-State: AOAM533iZXMKDyUwNX2I6JMiWWFLXgkohTKlyarLyl0W3wEHSIriWqqp
        lE9ynCsiEjRimMPGRWvJ7TY=
X-Google-Smtp-Source: ABdhPJxyPopkvGjX4OPrqDue+B2GiVZNzO8/x7ztlFw9xOxvn8pjAforCHS7gsWVwSKA3+GmKPlmtQ==
X-Received: by 2002:a5d:4b11:: with SMTP id v17mr11304091wrq.224.1597598508589;
        Sun, 16 Aug 2020 10:21:48 -0700 (PDT)
Received: from tsnow ([94.159.146.190])
        by smtp.gmail.com with ESMTPSA id i66sm27550212wma.35.2020.08.16.10.21.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 16 Aug 2020 10:21:48 -0700 (PDT)
Date:   Sun, 16 Aug 2020 20:21:44 +0300
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
Subject: [PATCH 1/3] staging: androind: Replace BUG_ONs with WARN_ONs
Message-ID: <b300cc0e9c75bfc14b091c874d22359b8ad9d6c9.1597597955.git.tomersamara98@gmail.com>
References: <cover.1597597955.git.tomersamara98@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1597597955.git.tomersamara98@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

BUG_ON() is replaced with WARN_ON at ion_page_pool.c
Fixes the following issue:
Avoid crashing the kernel - try using WARN_ON & recovery code ratherthan BUG() or BUG_ON().

Signed-off-by: Tomer Samara <tomersamara98@gmail.com>
---
 drivers/staging/android/ion/ion_page_pool.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/drivers/staging/android/ion/ion_page_pool.c b/drivers/staging/android/ion/ion_page_pool.c
index 0198b886d906..4acc0eebf781 100644
--- a/drivers/staging/android/ion/ion_page_pool.c
+++ b/drivers/staging/android/ion/ion_page_pool.c
@@ -46,11 +46,13 @@ static struct page *ion_page_pool_remove(struct ion_page_pool *pool, bool high)
 	struct page *page;
 
 	if (high) {
-		BUG_ON(!pool->high_count);
+		if (WARN_ON(!pool->high_count))
+			return NULL:
 		page = list_first_entry(&pool->high_items, struct page, lru);
 		pool->high_count--;
 	} else {
-		BUG_ON(!pool->low_count);
+		if (WARN_ON(!pool->low_count))
+			return NULL;
 		page = list_first_entry(&pool->low_items, struct page, lru);
 		pool->low_count--;
 	}
@@ -65,7 +67,8 @@ struct page *ion_page_pool_alloc(struct ion_page_pool *pool)
 {
 	struct page *page = NULL;
 
-	BUG_ON(!pool);
+	if (WARN_ON(!pool))
+		return NULL;
 
 	mutex_lock(&pool->mutex);
 	if (pool->high_count)
@@ -82,7 +85,8 @@ struct page *ion_page_pool_alloc(struct ion_page_pool *pool)
 
 void ion_page_pool_free(struct ion_page_pool *pool, struct page *page)
 {
-	BUG_ON(pool->order != compound_order(page));
+	if (WARN_ON(pool->order != compound_order(page)))
+		return;
 
 	ion_page_pool_add(pool, page);
 }
-- 
2.25.1

