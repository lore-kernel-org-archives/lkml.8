Return-Path: <SRS0=8wH5=AU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F5B6C433E2
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jul 2020 10:47:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 660FE2076A
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jul 2020 10:47:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726769AbgGIKrU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Jul 2020 06:47:20 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:57096 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726440AbgGIKrT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jul 2020 06:47:19 -0400
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: eballetbo)
        with ESMTPSA id 72D912A3CAC
Subject: Re: [RESEND PATCH 3/3] drm/mediatek: mtk_dpi: Use simple encoder
From:   Enric Balletbo i Serra <enric.balletbo@collabora.com>
To:     Boris Brezillon <boris.brezillon@collabora.com>
Cc:     linux-kernel@vger.kernel.org,
        Collabora Kernel ML <kernel@collabora.com>,
        narmstrong@baylibre.com, a.hajda@samsung.com,
        laurent.pinchart@ideasonboard.com, matthias.bgg@gmail.com,
        drinkcat@chromium.org, hsinyi@chromium.org,
        Chun-Kuang Hu <chunkuang.hu@kernel.org>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
References: <20200518173909.2259259-1-enric.balletbo@collabora.com>
 <20200518173909.2259259-4-enric.balletbo@collabora.com>
 <20200701134128.6a967a89@collabora.com>
 <3f7338ad-b83d-da1d-2b07-f5225c56d7f9@collabora.com>
Message-ID: <dba9e359-6f58-e283-d39a-82bfbec15d5a@collabora.com>
Date:   Thu, 9 Jul 2020 12:47:11 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <3f7338ad-b83d-da1d-2b07-f5225c56d7f9@collabora.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi again,

On 8/7/20 17:12, Enric Balletbo i Serra wrote:
> Hi Boris,
> 
> Thank you to spend some time to review the patches.
> 
> On 1/7/20 13:41, Boris Brezillon wrote:
>> On Mon, 18 May 2020 19:39:09 +0200
>> Enric Balletbo i Serra <enric.balletbo@collabora.com> wrote:
>>
>>> The mtk_dpi driver uses an empty implementation for its encoder. Replace
>>> the code with the generic simple encoder.
>>>
>>> Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
>>> Reviewed-by: Chun-Kuang Hu <chunkuang.hu@kernel.org>
>>> ---
>>>
>>>  drivers/gpu/drm/mediatek/mtk_dpi.c | 14 +++-----------
>>>  1 file changed, 3 insertions(+), 11 deletions(-)
>>>
>>> diff --git a/drivers/gpu/drm/mediatek/mtk_dpi.c b/drivers/gpu/drm/mediatek/mtk_dpi.c
>>> index baad198c69eb..80778b2aac2a 100644
>>> --- a/drivers/gpu/drm/mediatek/mtk_dpi.c
>>> +++ b/drivers/gpu/drm/mediatek/mtk_dpi.c
>>> @@ -20,6 +20,7 @@
>>>  #include <drm/drm_bridge.h>
>>>  #include <drm/drm_crtc.h>
>>>  #include <drm/drm_of.h>
>>> +#include <drm/drm_simple_kms_helper.h>
>>>  
>>>  #include "mtk_dpi_regs.h"
>>>  #include "mtk_drm_ddp_comp.h"
>>> @@ -510,15 +511,6 @@ static int mtk_dpi_set_display_mode(struct mtk_dpi *dpi,
>>>  	return 0;
>>>  }
>>>  
>>> -static void mtk_dpi_encoder_destroy(struct drm_encoder *encoder)
>>> -{
>>> -	drm_encoder_cleanup(encoder);
>>> -}
>>> -
>>> -static const struct drm_encoder_funcs mtk_dpi_encoder_funcs = {
>>> -	.destroy = mtk_dpi_encoder_destroy,
>>> -};
>>> -
>>>  static int mtk_dpi_bridge_attach(struct drm_bridge *bridge,
>>>  				 enum drm_bridge_attach_flags flags)
>>>  {
>>> @@ -591,8 +583,8 @@ static int mtk_dpi_bind(struct device *dev, struct device *master, void *data)
>>>  		return ret;
>>>  	}
>>>  
>>> -	ret = drm_encoder_init(drm_dev, &dpi->encoder, &mtk_dpi_encoder_funcs,
>>> -			       DRM_MODE_ENCODER_TMDS, NULL);
>>> +	ret = drm_simple_encoder_init(drm_dev, &dpi->encoder,
>>> +				      DRM_MODE_ENCODER_TMDS);
>>
>> Not related to this change, but shouldn't we have DRM_MODE_ENCODER_DPI
>> here?
>>
> 

Thinking a bit more about this and this patchset in general, I think I'll drop
this patch from the series, at the end, all the encoder creation stuff should be
moved to mtk_drm_drv.


> Right, I'll add a patch to fix this.
> 
>>>  	if (ret) {
>>>  		dev_err(dev, "Failed to initialize decoder: %d\n", ret);
>>>  		goto err_unregister;
>>
> 
