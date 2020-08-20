Return-Path: <SRS0=YvwE=B6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D36EC433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Aug 2020 03:41:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1D8092177B
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Aug 2020 03:41:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="AU6pOAFy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726846AbgHTDlE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Aug 2020 23:41:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726435AbgHTDlE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Aug 2020 23:41:04 -0400
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com [IPv6:2607:f8b0:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E3BCC061757
        for <linux-kernel@vger.kernel.org>; Wed, 19 Aug 2020 20:41:04 -0700 (PDT)
Received: by mail-pf1-x441.google.com with SMTP id f193so363820pfa.12
        for <linux-kernel@vger.kernel.org>; Wed, 19 Aug 2020 20:41:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=J8YVoHBmhP7CwdTtvl1VuAAC1kupCb0CJ2Q7eWIL2Qg=;
        b=AU6pOAFyZUuERVPlUGgQ633WDZ41yAxyiPrfn91iU3wpnAPmf83Atkl0hdBSgRmmQS
         ZRjcfQxA+fFqXOfJY/CcH1Ey1UJnYB374q6Zg6zrY+vQldYy40Sq3WpW19jFKM8kncFR
         sICeqEb93KmCfIlNkBuLhO8EXviVMyxL/narlfzvxjt2d31fXtUTgkxALNvyVPFSkDHY
         OarfKqjNid+4wytiNixG0wOlTER+obDITTobrWnFtWAUxICEccsVp6YtHtGlzaclXw0p
         fCUB5NbFnDne0+bgV9UZe9umxJtdTCRMjusN2+Cd3dsrweZQhQZ3M+LzPKkPw0aZKOzB
         M9DQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=J8YVoHBmhP7CwdTtvl1VuAAC1kupCb0CJ2Q7eWIL2Qg=;
        b=ofnnFxc5eO6XU5IGeljF4XlQFU9BF0K/zle9xxua2/NzVNO4Vf9A2uvF49hgPBWxXt
         qfCukM3IvExy9EDEhvItbzoXlS3J6oqXlQ1QcRL0HdNDs1a0s5aFi4L120raKRJpMhpg
         M2Q8ccxZcXclWt/QjZlxGD6uB9KaxPpiLSjAky9CI/ySmtj7aNh6DS0Jip8gHAUlG/1L
         +97p5d5DKQQhmwTBfOYEX+kC1DslR4p/7FCsmiT0GAVO5NSriudGyDIuwb4oo0sA1jWB
         xkCKW6Q4a8Z99wgitBJUID8FyOgqXbpRoPWD+rojepPzoX5WGWsXOyiIzkJu3aed5yMX
         cEYA==
X-Gm-Message-State: AOAM5316VWyXutHu2vC1bWl0ME3960WrHhspSE9BYc32NIzO+ENJsyg6
        DbRxfRlGnXWnb2jzLEc29MNCd8N7cX8l2Q==
X-Google-Smtp-Source: ABdhPJyhB2GNDaHZkcuGGQCn+7emHrUxCM2nzwttMrYziKfs722BrdQHw/nqTvpSU6n6JeP5+jhfIw==
X-Received: by 2002:a62:5cc4:: with SMTP id q187mr799823pfb.95.1597894863592;
        Wed, 19 Aug 2020 20:41:03 -0700 (PDT)
Received: from localhost.localdomain ([2601:1c2:680:1319:692:26ff:feda:3a81])
        by smtp.gmail.com with ESMTPSA id y126sm786477pfy.138.2020.08.19.20.41.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Aug 2020 20:41:02 -0700 (PDT)
From:   John Stultz <john.stultz@linaro.org>
To:     lkml <linux-kernel@vger.kernel.org>
Cc:     John Stultz <john.stultz@linaro.org>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Manivannan Sadhasivam <mani@kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Liwei Cai <cailiwei@hisilicon.com>,
        Xinliang Liu <xinliang.liu@linaro.org>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        Chen Feng <puck.chen@hisilicon.com>
Subject: [PATCH 2/3] drm: kirin9xxx: Add additional color formats
Date:   Thu, 20 Aug 2020 03:40:59 +0000
Message-Id: <20200820034100.128062-1-john.stultz@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200820033939.127932-1-john.stultz@linaro.org>
References: <20200820033939.127932-1-john.stultz@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is against Mauro's tree here:
https://gitlab.freedesktop.org/mchehab_kernel/hikey-970/-/commits/master/

Add support for two color formats (ARGB and ABGR) needed for use
with drm_hwcomposer and AOSP.

NOTE: I see Red/Blue swapped colors with this (and yes I did try
the obvious swap of formats here, to no luck :), so I need to dig
more on whats different from the other driver on this.

But with these formats supported drm_hwcomposer no longer crashes

Cc: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Manivannan Sadhasivam <mani@kernel.org>
Cc: dri-devel <dri-devel@lists.freedesktop.org>
Cc: Liwei Cai <cailiwei@hisilicon.com>
Cc: Xinliang Liu <xinliang.liu@linaro.org>
Cc: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc: Sam Ravnborg <sam@ravnborg.org>
Cc: Sumit Semwal <sumit.semwal@linaro.org>
Cc: Chen Feng <puck.chen@hisilicon.com>
Signed-off-by: John Stultz <john.stultz@linaro.org>
---
 drivers/staging/hikey9xx/gpu/kirin9xx_drm_dss.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/staging/hikey9xx/gpu/kirin9xx_drm_dss.c b/drivers/staging/hikey9xx/gpu/kirin9xx_drm_dss.c
index e3a1f85bdbd2..f2e99c766927 100644
--- a/drivers/staging/hikey9xx/gpu/kirin9xx_drm_dss.c
+++ b/drivers/staging/hikey9xx/gpu/kirin9xx_drm_dss.c
@@ -55,14 +55,15 @@ static const struct dss_format dss_formats[] = {
 	{ DRM_FORMAT_XBGR8888, HISI_FB_PIXEL_FORMAT_BGRX_8888 },
 	{ DRM_FORMAT_RGBA8888, HISI_FB_PIXEL_FORMAT_RGBA_8888 },
 	{ DRM_FORMAT_BGRA8888, HISI_FB_PIXEL_FORMAT_BGRA_8888 },
-	/*{ DRM_FORMAT_ARGB8888,  },*/
-	/*{ DRM_FORMAT_ABGR8888,  },*/
+	{ DRM_FORMAT_ARGB8888, HISI_FB_PIXEL_FORMAT_RGBA_8888 },
+	{ DRM_FORMAT_ABGR8888, HISI_FB_PIXEL_FORMAT_BGRA_8888 },
 };
 
 static const u32 channel_formats1[] = {
 	DRM_FORMAT_RGB565, DRM_FORMAT_BGR565,
 	DRM_FORMAT_XRGB8888, DRM_FORMAT_XBGR8888,
-	DRM_FORMAT_RGBA8888, DRM_FORMAT_BGRA8888
+	DRM_FORMAT_RGBA8888, DRM_FORMAT_BGRA8888,
+	DRM_FORMAT_ARGB8888, DRM_FORMAT_ABGR8888,
 };
 
 u32 dss_get_channel_formats(u8 ch, const u32 **formats)
-- 
2.17.1

