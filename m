Return-Path: <SRS0=Zj89=5W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16659C2BA1B
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Apr 2020 15:25:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DEF5722C9E
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Apr 2020 15:25:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728931AbgDFPZH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Apr 2020 11:25:07 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:55590 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728736AbgDFPZG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Apr 2020 11:25:06 -0400
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: eballetbo)
        with ESMTPSA id 66E2D293F03
Subject: Re: [PATCH] drm: mediatek: fix device passed to cmdq
To:     Hsin-Yi Wang <hsinyi@chromium.org>,
        linux-arm-kernel@lists.infradead.org
Cc:     Philipp Zabel <p.zabel@pengutronix.de>,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        Matthias Brugger <matthias.bgg@gmail.com>,
        linux-mediatek@lists.infradead.org,
        Daniel Vetter <daniel@ffwll.ch>, CK Hu <ck.hu@mediatek.com>
References: <20200406051131.225748-1-hsinyi@chromium.org>
From:   Enric Balletbo i Serra <enric.balletbo@collabora.com>
Message-ID: <095576cb-7124-9b23-fe24-7a91cce57d99@collabora.com>
Date:   Mon, 6 Apr 2020 17:25:01 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200406051131.225748-1-hsinyi@chromium.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Hsin-Yi

Thanks for sending the patch upstream

On 6/4/20 7:11, Hsin-Yi Wang wrote:
> drm device is now probed from mmsys. We need to use mmsys device to get gce
> nodes. Fix following errors:
> 
> [    0.740068] mediatek-drm mediatek-drm.1.auto: error -2 can't parse gce-client-reg property (0)
> [    0.748721] mediatek-drm mediatek-drm.1.auto: error -2 can't parse gce-client-reg property (0)
> ...
> [    2.659645] mediatek-drm mediatek-drm.1.auto: failed to request channel
> [    2.666270] mediatek-drm mediatek-drm.1.auto: failed to request channel
> 
> Fixes: 1d367541aded ("soc / drm: mediatek: Fix mediatek-drm device probing")
> Signed-off-by: Hsin-Yi Wang <hsinyi@chromium.org>

Right, the mmsys device is now the parent of the drm device.

Reviewed-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>

Also I tested drm with the patch applied and adding the gce client register to
my device-tree.

Tested-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>

Thanks,
 Enric

> ---
>  drivers/gpu/drm/mediatek/mtk_drm_crtc.c | 6 ++++--
>  drivers/gpu/drm/mediatek/mtk_drm_drv.c  | 3 ++-
>  2 files changed, 6 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/gpu/drm/mediatek/mtk_drm_crtc.c b/drivers/gpu/drm/mediatek/mtk_drm_crtc.c
> index 615a54e60fe2..8621f0289399 100644
> --- a/drivers/gpu/drm/mediatek/mtk_drm_crtc.c
> +++ b/drivers/gpu/drm/mediatek/mtk_drm_crtc.c
> @@ -822,14 +822,16 @@ int mtk_drm_crtc_create(struct drm_device *drm_dev,
>  
>  #if IS_REACHABLE(CONFIG_MTK_CMDQ)
>  	mtk_crtc->cmdq_client =
> -			cmdq_mbox_create(dev, drm_crtc_index(&mtk_crtc->base),
> +			cmdq_mbox_create(mtk_crtc->mmsys_dev,
> +					 drm_crtc_index(&mtk_crtc->base),
>  					 2000);
>  	if (IS_ERR(mtk_crtc->cmdq_client)) {
>  		dev_dbg(dev, "mtk_crtc %d failed to create mailbox client, writing register by CPU now\n",
>  			drm_crtc_index(&mtk_crtc->base));
>  		mtk_crtc->cmdq_client = NULL;
>  	}
> -	ret = of_property_read_u32_index(dev->of_node, "mediatek,gce-events",
> +	ret = of_property_read_u32_index(mtk_crtc->mmsys_dev->of_node,
> +					 "mediatek,gce-events",
>  					 drm_crtc_index(&mtk_crtc->base),
>  					 &mtk_crtc->cmdq_event);
>  	if (ret)
> diff --git a/drivers/gpu/drm/mediatek/mtk_drm_drv.c b/drivers/gpu/drm/mediatek/mtk_drm_drv.c
> index e2bb0d19ef99..dc78e86bccc0 100644
> --- a/drivers/gpu/drm/mediatek/mtk_drm_drv.c
> +++ b/drivers/gpu/drm/mediatek/mtk_drm_drv.c
> @@ -517,7 +517,8 @@ static int mtk_drm_probe(struct platform_device *pdev)
>  				goto err_node;
>  			}
>  
> -			ret = mtk_ddp_comp_init(dev, node, comp, comp_id, NULL);
> +			ret = mtk_ddp_comp_init(dev->parent, node, comp,
> +						comp_id, NULL);
>  			if (ret) {
>  				of_node_put(node);
>  				goto err_node;
> 
