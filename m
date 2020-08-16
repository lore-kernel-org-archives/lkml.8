Return-Path: <SRS0=yO2T=B2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD30AC433E1
	for <linux-kernel@archiver.kernel.org>; Sun, 16 Aug 2020 19:23:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A43F82067C
	for <linux-kernel@archiver.kernel.org>; Sun, 16 Aug 2020 19:23:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="V8aN4aPG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729529AbgHPTXt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 16 Aug 2020 15:23:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725873AbgHPTXq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Aug 2020 15:23:46 -0400
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15D35C061786
        for <linux-kernel@vger.kernel.org>; Sun, 16 Aug 2020 12:23:46 -0700 (PDT)
Received: by mail-wr1-x441.google.com with SMTP id y3so12857384wrl.4
        for <linux-kernel@vger.kernel.org>; Sun, 16 Aug 2020 12:23:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=EwFJZ7dfAqQ1UBhHBt6LFEw2dpyCC5fZ/uaODPbwQ/k=;
        b=V8aN4aPGz4W/rhy/Q2gJmxMbjDP4IRKELAm+TZMXVoa0g3IM5sKGSKxAL9WDkdzRdc
         uX5MQexjBo90N5mP/4jKoS5+JudjMkTKk3qNBvmKoOJ3808ZSsyL0gS0BM9pEUjkjpUa
         XWBxdX/ZyfepBIe5evz+gbIeF/ppVLyVFOizf3ffAoNVrVagVhIGSVrKp7GQHVy5VgUE
         jF84GKxPp5e/FBgozBO+6QPKig3WofCX9L+050rUp26G17L8UADyqFy/YVbyAGXzqy70
         3w21mQc95ILOXaVw0ukA1NkVVTWtvzAQ6G57LYlI9XYpWjIJ0D59UFkCgvXPKuj6BBw3
         BffQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=EwFJZ7dfAqQ1UBhHBt6LFEw2dpyCC5fZ/uaODPbwQ/k=;
        b=gGZ+qHNFA6wc7/X6jPFwDv9Ro+aIKW4sQUJuIgf93F1FTbqSbuNF+4LwZbDdPH6ToT
         89eB6Cof9eJqkWsKstI377H3VF+RM/nBbNZfZYxB+PJQtDBacbwApPcpNB6qgkKM3WNF
         jnm9K6tntbR9v6sOlAP/Pm7+ST4spc0so/mjhVey7mEN9X4hMgn0qDOSECYoHMMnJHXx
         3RfF+Kk5atdvcYytGhzLkgb7+3+/gS5EHhVt9K5iIYq5G3PSSRWxdUQg2t1tjaX6XsVi
         DFkbMChMXxgkNOUe+CQl7Mdy2FDmvmr/yG4+qGY0ji7O/USv3uNOCjL2MUwXRlGgeFuT
         hZrA==
X-Gm-Message-State: AOAM532UlGqDqfK6vp5vxLvDmBzhaLLfYhJbYAnc/N2WtC5xcJp1PxIe
        TmULQcwzciYbUL/Z/LNr6H8=
X-Google-Smtp-Source: ABdhPJzKVZZ6r6L7ot1ZZO9bdKj1FQQ/74Sm840x6qryXJBgWNNZtbnpDq+zS2ZuU1QSHa5zhMF0vg==
X-Received: by 2002:a5d:4144:: with SMTP id c4mr11672695wrq.200.1597605824368;
        Sun, 16 Aug 2020 12:23:44 -0700 (PDT)
Received: from tsnow ([94.159.146.190])
        by smtp.gmail.com with ESMTPSA id p17sm30992902wra.81.2020.08.16.12.23.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 16 Aug 2020 12:23:43 -0700 (PDT)
Date:   Sun, 16 Aug 2020 22:23:25 +0300
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
Subject: [PATCH v2 1/4] staging: android: Replace BUG_ON with WARN_ON
Message-ID: <fd55c53cb20c4887a87c05fffa28c28a740cd314.1597602783.git.tomersamara98@gmail.com>
References: <cover.1597602783.git.tomersamara98@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1597602783.git.tomersamara98@gmail.com>
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
index 0198b886d906..c1b9eda35c96 100644
--- a/drivers/staging/android/ion/ion_page_pool.c
+++ b/drivers/staging/android/ion/ion_page_pool.c
@@ -46,11 +46,13 @@ static struct page *ion_page_pool_remove(struct ion_page_pool *pool, bool high)
 	struct page *page;
 
 	if (high) {
-		BUG_ON(!pool->high_count);
+		if (WARN_ON(!pool->high_count))
+			return NULL;
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

