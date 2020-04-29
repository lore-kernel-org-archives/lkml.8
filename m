Return-Path: <SRS0=ObIu=6N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B380CC83000
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Apr 2020 14:02:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 917E120731
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Apr 2020 14:02:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727121AbgD2OCY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Apr 2020 10:02:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726861AbgD2OCY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Apr 2020 10:02:24 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59113C03C1AD
        for <linux-kernel@vger.kernel.org>; Wed, 29 Apr 2020 07:02:24 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: eballetbo)
        with ESMTPSA id CB2E32A05D5
Subject: Re: [PATCH v3 -next] drm/mediatek: Fix Kconfig warning
To:     YueHaibing <yuehaibing@huawei.com>, chunkuang.hu@kernel.org,
        p.zabel@pengutronix.de, airlied@linux.ie, daniel@ffwll.ch,
        matthias.bgg@gmail.com, ck.hu@mediatek.com
Cc:     linux-kernel@vger.kernel.orc, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org,
        linux-mediatek@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org
References: <20200420135045.27984-1-yuehaibing@huawei.com>
 <20200429071337.49528-1-yuehaibing@huawei.com>
From:   Enric Balletbo i Serra <enric.balletbo@collabora.com>
Message-ID: <178db061-7068-e688-dd5a-0d767e57c22c@collabora.com>
Date:   Wed, 29 Apr 2020 16:02:17 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200429071337.49528-1-yuehaibing@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi YueHaibing,

Thank you for your patch.

On 29/4/20 9:13, YueHaibing wrote:
> WARNING: unmet direct dependencies detected for MTK_MMSYS
>   Depends on [n]: (ARCH_MEDIATEK [=y] || COMPILE_TEST [=n]) && COMMON_CLK_MT8173_MMSYS [=n]
>   Selected by [y]:
>   - DRM_MEDIATEK [=y] && HAS_IOMEM [=y] && DRM [=y] && (ARCH_MEDIATEK [=y] || ARM && COMPILE_TEST [=n]) && COMMON_CLK [=y] && HAVE_ARM_SMCCC [=y] && OF [=y]
> 
> Make DRM_MEDIATEK depend on MTK_MMSYS to fix this.
> 
> Fixes: 2c758e301ed9 ("soc / drm: mediatek: Move routing control to mmsys device")
> Signed-off-by: YueHaibing <yuehaibing@huawei.com>

Definitively we shouldn't select the MTK_MMSYS and we should depend on MTK_MMSYS
instead, so

Reviewed-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>

> ---
> v3: make DRM_MEDIATEK depends on MTK_MMSYS
> v2: select COMMON_CLK_MT8173_MMSYS instead of adding DRM_MEDIATEK dependency  
> ---
>  drivers/gpu/drm/mediatek/Kconfig | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/mediatek/Kconfig b/drivers/gpu/drm/mediatek/Kconfig
> index c420f5a3d33b..aa74aac3cbcc 100644
> --- a/drivers/gpu/drm/mediatek/Kconfig
> +++ b/drivers/gpu/drm/mediatek/Kconfig
> @@ -6,12 +6,12 @@ config DRM_MEDIATEK
>  	depends on COMMON_CLK
>  	depends on HAVE_ARM_SMCCC
>  	depends on OF
> +	depends on MTK_MMSYS
>  	select DRM_GEM_CMA_HELPER
>  	select DRM_KMS_HELPER
>  	select DRM_MIPI_DSI
>  	select DRM_PANEL
>  	select MEMORY
> -	select MTK_MMSYS
>  	select MTK_SMI
>  	select VIDEOMODE_HELPERS
>  	help
> 
