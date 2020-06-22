Return-Path: <SRS0=Xj+s=AD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43848C433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jun 2020 15:45:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1A7562074D
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jun 2020 15:45:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="eCZjft2H"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729421AbgFVPpv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Jun 2020 11:45:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728431AbgFVPpu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Jun 2020 11:45:50 -0400
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B5C5C061573
        for <linux-kernel@vger.kernel.org>; Mon, 22 Jun 2020 08:45:50 -0700 (PDT)
Received: by mail-wm1-x344.google.com with SMTP id g75so32414wme.5
        for <linux-kernel@vger.kernel.org>; Mon, 22 Jun 2020 08:45:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=3pXTgzcjVOwvTxrnjgIPNbjQoMVzZLONAKcQJc4dpMU=;
        b=eCZjft2HDpve9Eo9DCGTC1GBUIUxUQB4BbyIfvl7mxQc7a+nGiuBW4O1chMuTz5Wmu
         23kFhzGclpK5sKnINBDx77tR3XQ2DjmfO5HcgGPthz2WeFTHIail8AncimbnA24bFs/5
         3Mtv6mSZ7KWixp75iMQCAeA2GgD0DZ75a21t8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=3pXTgzcjVOwvTxrnjgIPNbjQoMVzZLONAKcQJc4dpMU=;
        b=my05H8aPVVJkRyajwAMobTgbsNnoUE4yScjwKOzU42GK/aMNQEmJ+4w2fSmceidZuF
         O2RHrADtGlvZ/kt6/5D0cPXG5WTYwStJ30zGkG7lApBX8TTwNt/eum8Sapom3GIr9HJN
         6EzGSw8kWqXL6Gj1hBGAiDE93spUgOo4q2Lg9UYhRoZCUrTqB8zjTaIUZb2xXllGDiIc
         ZOD6r9ZL3BkqJTsRAakCEczqHkTCdmGAvchNA6UF4nHHUJBbnoMRu76TpTVV1k+EbWHz
         uXuMAjzEz1btpVRFcODHWut9F+Tji1TIg02ArWOGm3Z0laAUgzqraF4dJu2oVWiiIjos
         NPCg==
X-Gm-Message-State: AOAM533iAmThbtuPDbsST2KelHACOWk3hnT3bS1PkpN6n4b14+dRQjAV
        6XN5lmpsOMnhUwj8ugvei+whww==
X-Google-Smtp-Source: ABdhPJxwtp9f/mSns4DATYM0QPXSM6xAp/C11F+xFUSRhT+GCDKTeQfV4GCzZW24J0vrJiWg3VxjTQ==
X-Received: by 2002:a7b:cd06:: with SMTP id f6mr18978008wmj.8.1592840749368;
        Mon, 22 Jun 2020 08:45:49 -0700 (PDT)
Received: from chromium.org (205.215.190.35.bc.googleusercontent.com. [35.190.215.205])
        by smtp.gmail.com with ESMTPSA id z16sm9227540wrr.35.2020.06.22.08.45.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Jun 2020 08:45:48 -0700 (PDT)
Date:   Mon, 22 Jun 2020 15:45:47 +0000
From:   Tomasz Figa <tfiga@chromium.org>
To:     Hsin-Yi Wang <hsinyi@chromium.org>
Cc:     linux-arm-kernel@lists.infradead.org,
        Chun-Kuang Hu <chunkuang.hu@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        dri-devel@lists.freedesktop.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        yongqiang.niu@mediatek.com
Subject: Re: [PATCH v3] drm/mediatek: check plane visibility in atomic_update
Message-ID: <20200622154547.GA3503@chromium.org>
References: <20200622153106.112115-1-hsinyi@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200622153106.112115-1-hsinyi@chromium.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 22, 2020 at 11:31:06PM +0800, Hsin-Yi Wang wrote:
> Disable the plane if it's not visible. Otherwise mtk_ovl_layer_config()
> would proceed with invalid plane and we may see vblank timeout.
> 
> Fixes: 119f5173628a ("drm/mediatek: Add DRM Driver for Mediatek SoC MT8173.")
> Signed-off-by: Hsin-Yi Wang <hsinyi@chromium.org>
> Reviewed-by: Chun-Kuang Hu <chunkuang.hu@kernel.org>
> Change-Id: Id5341d60ddfffc88a38d9db0caa089b2d6a1d29c
> ---
> v3: Address comment
> v2: Add fixes tag
> ---
>  drivers/gpu/drm/mediatek/mtk_drm_plane.c | 25 ++++++++++++++----------
>  1 file changed, 15 insertions(+), 10 deletions(-)
> 

+/- the Change-Id pointed out by Matthias:

Reviewed-by: Tomasz Figa <tfiga@chromium.org>

Best regards,
Tomasz
