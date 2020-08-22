Return-Path: <SRS0=ximN=CA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C122C433DF
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Aug 2020 19:43:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 15A132078A
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Aug 2020 19:43:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="E4a7p3u+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728710AbgHVTnY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 22 Aug 2020 15:43:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728639AbgHVTnX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Aug 2020 15:43:23 -0400
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62765C061573
        for <linux-kernel@vger.kernel.org>; Sat, 22 Aug 2020 12:43:23 -0700 (PDT)
Received: by mail-wm1-x342.google.com with SMTP id o21so4815667wmc.0
        for <linux-kernel@vger.kernel.org>; Sat, 22 Aug 2020 12:43:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=bDeHhD/5z6aaFlItq04V8HlPaMZcoXhz68jm6W6MONk=;
        b=E4a7p3u+k/VHbSDKvo+vWFDgHYz75Y8+NmMpZQGWE5shPjdmZTRi24d7YVdsF6YAFZ
         zrYn1oTQeDaXMki76OWmSBV9Vyn6OIAazfgRl3Y0NYfr5L1R+JueMY7PulbAUEYYTnHP
         ae9Ipw2x67GtWT1+eQBwo51wObjS5xBprbcXr5Dk6a7ZvOmo8xGQzaJpAGeuS5F/Bakt
         W2r1VFpkF83+xZm5nurZsceL67OmWE3bi/pV6mNiCNI0Ok94JeIWh2+8BeX5Zs6ltUDK
         chaMncvuVVyxcbzBUTXB2oy0iwh0lEjDBuVexS9xnCBznQ715CgWQ+2HK3ir/iMCELyV
         jBzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=bDeHhD/5z6aaFlItq04V8HlPaMZcoXhz68jm6W6MONk=;
        b=bPaZOn7C/mY9svg4RdNr3Ply7nlN+XvMrWjIJBWuIDV9z8JsM8lYvQ8LRJJE28HcuF
         iM+VJ6gXfRW2BNZ5EXZgtYvcFE3Vdatt4/N3BRtkuAX7MH8ooVLZMiqH40eXQHWxJ83v
         xX9NOmlZ5Sq3FDhN2ndUYR6pkupqsQiLwsWaYwbF+BYqCu0ZV4S6Y+NJcPsm7xwbC+pr
         FCoWnx4yjSTtk4xXntUKbx98GfH/x31VD+GnUNTfCNpgb+9rvnjdKGtY30hh1FzkKeUR
         4UvGWFw3Err62Jktib0PW7V0IzMfvlxbNQDfX2SvBv2/MqVgPHK/4JEvyhTRQ6TDY47e
         9Iqw==
X-Gm-Message-State: AOAM533I7qLIyLNwqRV+Srm423vBkso23Iyj/w9cXaK3Q+Vr0cBi60Wj
        +ZVEFJMZdiBU8eQcoiKEiS8=
X-Google-Smtp-Source: ABdhPJwnnkIT5/uCftHhMXqn1D4NcYSiQuuoKXX9omd0RYEa9lVbqCbaGzyn1xpBO11hX4gU7y3p3w==
X-Received: by 2002:a1c:28d5:: with SMTP id o204mr9837747wmo.104.1598125402082;
        Sat, 22 Aug 2020 12:43:22 -0700 (PDT)
Received: from tsnow (IGLD-83-130-62-237.inter.net.il. [83.130.62.237])
        by smtp.gmail.com with ESMTPSA id z12sm12968394wrp.20.2020.08.22.12.43.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 22 Aug 2020 12:43:21 -0700 (PDT)
Date:   Sat, 22 Aug 2020 22:43:02 +0300
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
Subject: [PATCH v5 1/2] staging: android: Remove BUG_ON from ion_page_pool.c
Message-ID: <aaea4be2ab36395e70f759f3b6976782fe2acfa1.1598125227.git.tomersamara98@gmail.com>
References: <cover.1598125227.git.tomersamara98@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1598125227.git.tomersamara98@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

BUG_ON() is removed at ion_page_pool.c

Fixes the following issue:
Avoid crashing the kernel - try using WARN_ON & recovery code ratherthan BUG() or BUG_ON().

Signed-off-by: Tomer Samara <tomersamara98@gmail.com>
---
 drivers/staging/android/ion/ion_page_pool.c | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/drivers/staging/android/ion/ion_page_pool.c b/drivers/staging/android/ion/ion_page_pool.c
index 0198b886d906..fa764299f004 100644
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
@@ -82,8 +78,6 @@ struct page *ion_page_pool_alloc(struct ion_page_pool *pool)
 
 void ion_page_pool_free(struct ion_page_pool *pool, struct page *page)
 {
-	BUG_ON(pool->order != compound_order(page));
-
 	ion_page_pool_add(pool, page);
 }
 
-- 
2.25.1

