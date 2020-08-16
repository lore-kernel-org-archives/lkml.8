Return-Path: <SRS0=yO2T=B2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 631F6C433DF
	for <linux-kernel@archiver.kernel.org>; Sun, 16 Aug 2020 19:28:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3B2832067C
	for <linux-kernel@archiver.kernel.org>; Sun, 16 Aug 2020 19:28:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FI13GFTD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729619AbgHPT2D (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 16 Aug 2020 15:28:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725873AbgHPT2C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Aug 2020 15:28:02 -0400
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC491C061786
        for <linux-kernel@vger.kernel.org>; Sun, 16 Aug 2020 12:28:01 -0700 (PDT)
Received: by mail-wr1-x443.google.com with SMTP id y3so12863249wrl.4
        for <linux-kernel@vger.kernel.org>; Sun, 16 Aug 2020 12:28:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=qmVZU2POW4M1NknCFfoJ+T7RKAAxlTCPnNob32YEXP4=;
        b=FI13GFTDazrcCLiwoMFoX4rPxfeSLd+dEX0MnJIXY38KAk+OoAxDTTH/LWrrR/lQau
         FS9gmx2OqHIFY6vjpcx/71Ym1XOkivVCVgWOjIq6kogNa/Xrb3Yho3gOGG3+vJyV4pA3
         gckna1DsvjcCCwNrQRi7MHpB2YhIVaMgJTFQhs45G6yzC0gb0tHJZJmYOV6s6AUjjRwk
         ZjJgWfNVcWVJSDwmbdZgh3Nm2wYQycbaUHjY7/yKO5V6pLGTTSZhU8aenemekkTvY5x0
         xroYsQNjE1YRyIgqQ/o12hGMtV4MDX0/5oYyEdyY00pHVPSoecavdi1obsR4PjIsfEWy
         P1KA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=qmVZU2POW4M1NknCFfoJ+T7RKAAxlTCPnNob32YEXP4=;
        b=sXS8VnmWdhpWdSQjpRPb3DzxcBx5B0uP8vAp1CeKcW42Dmw2GXgSTXxhfU4q/a1vZ+
         Wr8wJMD7t+uhM5cr8ibq5Qrvbeqk8f+O3wvdI4svUf7dM4V6C3cGQYq4hvz78HFL3g11
         OMWSXTRk//Zq1R0js1i8uxgnbcYPGL1jF7hocCsTlr1MBecE+hIER7kkKMy+xAOnD+Ly
         qHwBWnVKN/nxA2rJZQVQoTUMShNMcxGyYUImC3na2+5UOlF0Ix8IM2fphRY0a+ikd3he
         QBlvkQ6mJe5ebqZpqLrzhVsy1Vk8n6Dtj3LR4pEis+1bpkM8dbd//dsTz9At+Rn3b4R0
         AV1A==
X-Gm-Message-State: AOAM530wApsqXojdrZGtztMQWKsNkKzlar4f0tJ4yiNOTaR1oiLCau3L
        UNB9mFPQkiqzY8xVBMzN/x0=
X-Google-Smtp-Source: ABdhPJws100GEXO8VJoudjq/JU8ylyAC9G/2T2ozuekoGXQnoiSSFbbidajX0sTKjRXP8SKt9PCiIA==
X-Received: by 2002:adf:f48d:: with SMTP id l13mr11505879wro.43.1597606080602;
        Sun, 16 Aug 2020 12:28:00 -0700 (PDT)
Received: from tsnow ([94.159.146.190])
        by smtp.gmail.com with ESMTPSA id r11sm26917543wrw.78.2020.08.16.12.24.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 16 Aug 2020 12:28:00 -0700 (PDT)
Date:   Sun, 16 Aug 2020 22:24:22 +0300
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
Subject: [PATCH v2 2/4] staging: android: Add error handling to
 ion_page_pool_shrink
Message-ID: <73d1b8b904ae867f59e7ada14c3fb90e27f12bbb.1597602783.git.tomersamara98@gmail.com>
References: <cover.1597602783.git.tomersamara98@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1597602783.git.tomersamara98@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add error check to ion_page_pool_shrink after calling
ion_page_pool_remove, due to converting BUG_ON to WARN_ON.

Signed-off-by: Tomer Samara <tomersamara98@gmail.com>
---
 drivers/staging/android/ion/ion_page_pool.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/staging/android/ion/ion_page_pool.c b/drivers/staging/android/ion/ion_page_pool.c
index c1b9eda35c96..031550473000 100644
--- a/drivers/staging/android/ion/ion_page_pool.c
+++ b/drivers/staging/android/ion/ion_page_pool.c
@@ -128,6 +128,8 @@ int ion_page_pool_shrink(struct ion_page_pool *pool, gfp_t gfp_mask,
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

