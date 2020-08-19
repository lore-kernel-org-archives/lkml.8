Return-Path: <SRS0=EnQK=B5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9CFB6C433E1
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Aug 2020 17:14:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 75F412067C
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Aug 2020 17:14:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oFBXmglF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726796AbgHSROg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Aug 2020 13:14:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726741AbgHSROY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Aug 2020 13:14:24 -0400
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B3D2C061757
        for <linux-kernel@vger.kernel.org>; Wed, 19 Aug 2020 10:14:23 -0700 (PDT)
Received: by mail-wr1-x442.google.com with SMTP id y3so22291583wrl.4
        for <linux-kernel@vger.kernel.org>; Wed, 19 Aug 2020 10:14:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=uxW4P/9c5owj5TbqeeSJhimozsZ/ts6TLrVEcdoDcKc=;
        b=oFBXmglFqppJ5H90JX7k9hVq8siJfn73/Uhkmym4cndlhhgXjw4iDjKyVkO8F42dui
         dEbp2PPwm99BpwM07gh7iv6zAyTreBFl2zIdvbvU+uieLrbSW3w6DM1km47en0+Bizfe
         8AKRsx+fg1XsTpvJuGOTZWK2KQ7gpM8avVsrNwBjaC730kj4ckvcJ3CJfhVYhJNBIi3r
         jCWrYD0yGziZ6ueN0FREoyhaitcwrI7Q18FXL/5hgm09WF59Ri5Ipe4IRXnjU6UtswGc
         4hwH/CVPBKpDUPfuT9HFbA/0Rm2U14iAHLyPHFmdawomBqNr9ZMIWU+0Eo4Gh/p7acp2
         d/PQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=uxW4P/9c5owj5TbqeeSJhimozsZ/ts6TLrVEcdoDcKc=;
        b=BkZcmiY4gb7xtRCE71/BbTBj3sCtz6qX2Oc68RtsyXiF0+uAqymfsBmFcZkLBCERAP
         Ba+79/m2d7v5mV0m1Ij2GeU04OuNe8xNPzYDcze4CAqDG9a8XGTQFoDpto1G4sQZfNOO
         Drv3WeFfG6KRwScfEbFwPa0DdQcxFUWE+9l13lubrFN58XDUeSiB0/mNJ/LLubiGKZdy
         r8+cU7TRrED2tV6qvOY1/jgP/oE3Of+GcYSo5u30qW3RZXCmhMsDD+vGrTyXcZoXeJWA
         MVzenmS2GAHB5eOnyJJiitQ4W9vTJspxNiADPD4ZJjM0kk3VbnRgEJFB2+boorCkjeul
         NtWQ==
X-Gm-Message-State: AOAM531bDkpog8/Qth/TiR+v9XA5qhyQUAKM4jLtUNmw2JP7Q2bp47Dd
        U6sofQzj9bZjM4ulIKE6kKg=
X-Google-Smtp-Source: ABdhPJxuglAF/P70gnxyfeZB51uIoA+nGJl5R01Hf8f8HnZsYxB4igMuLgNDVozV2tn4SOsRThTh5w==
X-Received: by 2002:a5d:6646:: with SMTP id f6mr25966574wrw.155.1597857262147;
        Wed, 19 Aug 2020 10:14:22 -0700 (PDT)
Received: from ziggy.stardust ([93.176.180.54])
        by smtp.gmail.com with ESMTPSA id f17sm6742926wru.13.2020.08.19.10.14.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 19 Aug 2020 10:14:21 -0700 (PDT)
Subject: Re: [PATCH v5 5/7] drm/mediatek: dpi/dsi: change the getting
 possible_crtc way
To:     Frank Wunderlich <linux@fw-web.de>,
        linux-mediatek@lists.infradead.org
Cc:     Frank Wunderlich <frank-w@public-files.de>,
        Chun-Kuang Hu <chunkuang.hu@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        David Airlie <airlied@linux.ie>, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org, Daniel Vetter <daniel@ffwll.ch>,
        linux-arm-kernel@lists.infradead.org,
        Jitao Shi <jitao.shi@mediatek.com>
References: <20200819081752.4805-1-linux@fw-web.de>
 <20200819081752.4805-6-linux@fw-web.de>
From:   Matthias Brugger <matthias.bgg@gmail.com>
Message-ID: <4812f750-5f85-61bb-fb68-4eec99285e77@gmail.com>
Date:   Wed, 19 Aug 2020 19:14:20 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20200819081752.4805-6-linux@fw-web.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 19/08/2020 10:17, Frank Wunderlich wrote:
> From: Jitao Shi <jitao.shi@mediatek.com>
> 
> For current mediatek dsi encoder, its possible crtc is fixed in crtc
> 0, and mediatek dpi encoder's possible crtc is fixed in crtc 1. In
> some SoC the possible crtc is not fixed in this case, so call
> mtk_drm_find_possible_crtc_by_comp() to find out the correct possible
> crtc.
> 

Hm, shouldn't we stash this int 4/7, otherwise we will have not used functions 
in 4/7.

Regards,
Matthias

> Signed-off-by: Jitao Shi <jitao.shi@mediatek.com>
> Signed-off-by: Frank Wunderlich <frank-w@public-files.de>
> Reviewed-by: Chun-Kuang Hu <chunkuang.hu@kernel.org>
> ---
>   drivers/gpu/drm/mediatek/mtk_dpi.c | 3 ++-
>   drivers/gpu/drm/mediatek/mtk_dsi.c | 3 ++-
>   2 files changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/gpu/drm/mediatek/mtk_dpi.c b/drivers/gpu/drm/mediatek/mtk_dpi.c
> index d4f0fb7ad312..e43977015843 100644
> --- a/drivers/gpu/drm/mediatek/mtk_dpi.c
> +++ b/drivers/gpu/drm/mediatek/mtk_dpi.c
> @@ -608,7 +608,8 @@ static int mtk_dpi_bind(struct device *dev, struct device *master, void *data)
>   	drm_encoder_helper_add(&dpi->encoder, &mtk_dpi_encoder_helper_funcs);
>   
>   	/* Currently DPI0 is fixed to be driven by OVL1 */
> -	dpi->encoder.possible_crtcs = BIT(1);
> +	dpi->encoder.possible_crtcs =
> +		mtk_drm_find_possible_crtc_by_comp(drm_dev, dpi->ddp_comp);
>   
>   	ret = drm_bridge_attach(&dpi->encoder, dpi->bridge, NULL, 0);
>   	if (ret) {
> diff --git a/drivers/gpu/drm/mediatek/mtk_dsi.c b/drivers/gpu/drm/mediatek/mtk_dsi.c
> index 16fd99dcdacf..c9f4ad029cb1 100644
> --- a/drivers/gpu/drm/mediatek/mtk_dsi.c
> +++ b/drivers/gpu/drm/mediatek/mtk_dsi.c
> @@ -974,7 +974,8 @@ static int mtk_dsi_encoder_init(struct drm_device *drm, struct mtk_dsi *dsi)
>   	 * Currently display data paths are statically assigned to a crtc each.
>   	 * crtc 0 is OVL0 -> COLOR0 -> AAL -> OD -> RDMA0 -> UFOE -> DSI0
>   	 */
> -	dsi->encoder.possible_crtcs = 1;
> +	dsi->encoder.possible_crtcs =
> +		mtk_drm_find_possible_crtc_by_comp(drm, dsi->ddp_comp);
>   
>   	ret = drm_bridge_attach(&dsi->encoder, &dsi->bridge, NULL,
>   				DRM_BRIDGE_ATTACH_NO_CONNECTOR);
> 
