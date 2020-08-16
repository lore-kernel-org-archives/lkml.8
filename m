Return-Path: <SRS0=yO2T=B2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 895CBC433DF
	for <linux-kernel@archiver.kernel.org>; Sun, 16 Aug 2020 18:40:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 61AF62067C
	for <linux-kernel@archiver.kernel.org>; Sun, 16 Aug 2020 18:40:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qn1tYUlM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729388AbgHPSkl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 16 Aug 2020 14:40:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725873AbgHPSkj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Aug 2020 14:40:39 -0400
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95F04C061786
        for <linux-kernel@vger.kernel.org>; Sun, 16 Aug 2020 11:40:39 -0700 (PDT)
Received: by mail-wr1-x443.google.com with SMTP id f1so12794332wro.2
        for <linux-kernel@vger.kernel.org>; Sun, 16 Aug 2020 11:40:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
        bh=GMPBK8NnXSwBg3pxRK5LStqyUM6u/9HiM5fcS5/2YLM=;
        b=qn1tYUlMkD1N+dqWYlL9N71yUtVYbRD55m5C/8A8+k8xvwwsoRCXCFNfQgK2TFZm7C
         FsjsKSxhVnBI/ADmrdVk76KsNambeKhwe1dwmN1KulSYpo1bTPmy+cmVz74v+tnuNz2J
         Hwxj3D6mHqbEkmUKIe27kDqgSwKu4lWmejqtZ4ZFjSGxqP1yyZv+pkVJBcEAcdJ6wW7I
         dcsoXMx1HxyD1nNGMfnDFlRu0z4wZML5YrAbZd3wrVB5y2NqFFTzJWlMTyGE/p6gFg1B
         UFHE355ORj0RqYwaVm2wbYdbdt+JhUGH+Q5eIFURqNwJeSCM9+2VWZKrJU8GoFsxP+o/
         3Xlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=GMPBK8NnXSwBg3pxRK5LStqyUM6u/9HiM5fcS5/2YLM=;
        b=kkQHlrfudEUYaJBq6I9yh110I2qkTuxeOZee3lqUrKdJK2tSJNkC/VyHP6iZsrWAjN
         fAbk+vyYYronFjwndSknI6fo7j0ja7VRjOnK+t4GsdfFeBKT5wDnOwg5XJL3AURg2osH
         t1byThXd1/h4jmP0GOi9RYDDFPHeSGbMgpNUojaqyFx84QBuEYDfYsdcRNutv37/C8hy
         88Z/HG00zjYFh/ugmRL5o7skecV4xZOaI7hw8xpYR0jBaLcMqUSR4ObQHfXI9c2aL9LG
         3ODTK7gxZGEUyoUxQEgaNQJenZuPa6l9qHdWeOrFxJfBX02lgBwtXqPkU+wT0XTIRWw8
         goGA==
X-Gm-Message-State: AOAM530DS3GmAV8SxMNSOdPjIZI19YhsUbNbbS02V6QqtSrJdfPhVfKm
        dCNPM3vuiSHKpj5RXwLgVkQ=
X-Google-Smtp-Source: ABdhPJwedwjz3znts+4tP79UkI2LDgWwjkT5I6NMg5cOaR9plyiIwz32l67j6k2yqGPK9TPrZn1PJg==
X-Received: by 2002:a5d:538a:: with SMTP id d10mr12305018wrv.280.1597603238417;
        Sun, 16 Aug 2020 11:40:38 -0700 (PDT)
Received: from tsnow ([94.159.146.190])
        by smtp.gmail.com with ESMTPSA id w64sm29735632wmb.26.2020.08.16.11.40.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 16 Aug 2020 11:40:37 -0700 (PDT)
Date:   Sun, 16 Aug 2020 21:40:33 +0300
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
Subject: [PATCH v2 0/4] Replace BUG/BUG_ON to WARN/WARN_ON
Message-ID: <cover.1597602783.git.tomersamara98@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


This series convert BUGs/BUG_ONs to WARNs/WARN_ONs

Tomer Samara (4):
  staging: android: Replace BUG_ON with WARN_ON
  staging: android: Add error handling to ion_page_pool_shrink
  staging: android: Convert BUG to WARN
  staging: android: Add error handling to order_to_index callers

 drivers/staging/android/ion/ion_page_pool.c   | 14 ++++++++++----
 drivers/staging/android/ion/ion_system_heap.c | 16 +++++++++++++---
 2 files changed, 23 insertions(+), 7 deletions(-)

-- 
2.25.1

