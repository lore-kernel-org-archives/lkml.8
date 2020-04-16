Return-Path: <SRS0=1dCa=6A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36B44C2BA2B
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Apr 2020 21:33:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1CB8B206D5
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Apr 2020 21:33:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728028AbgDPVdb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Apr 2020 17:33:31 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:44244 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725843AbgDPVda (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Apr 2020 17:33:30 -0400
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: eballetbo)
        with ESMTPSA id 768E62A1269
Subject: Re: [PATCH v2 7/7] drm/mediatek: mtk_dsi: Create connector for
 bridges
To:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc:     linux-kernel@vger.kernel.org,
        Collabora Kernel ML <kernel@collabora.com>,
        matthias.bgg@gmail.com, drinkcat@chromium.org, hsinyi@chromium.org,
        Chun-Kuang Hu <chunkuang.hu@kernel.org>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
References: <20200416155720.2360443-1-enric.balletbo@collabora.com>
 <20200416155720.2360443-8-enric.balletbo@collabora.com>
 <20200416173525.GQ4796@pendragon.ideasonboard.com>
 <20200416173615.GR4796@pendragon.ideasonboard.com>
From:   Enric Balletbo i Serra <enric.balletbo@collabora.com>
Message-ID: <cb5db1ad-c0c6-44aa-8a26-0c7731b973fd@collabora.com>
Date:   Thu, 16 Apr 2020 23:33:24 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200416173615.GR4796@pendragon.ideasonboard.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Laurent,

On 16/4/20 19:36, Laurent Pinchart wrote:
> Hi Enric,
> 
> On Thu, Apr 16, 2020 at 08:35:26PM +0300, Laurent Pinchart wrote:
>> On Thu, Apr 16, 2020 at 05:57:19PM +0200, Enric Balletbo i Serra wrote:
>>> Use the drm_bridge_connector helper to create a connector for pipelines
>>> that use drm_bridge. This allows splitting connector operations across
>>> multiple bridges when necessary, instead of having the last bridge in
>>> the chain creating the connector and handling all connector operations
>>> internally.
>>
>> That's the right direction, but this should be done in the mtk display
>> controller driver core, not in here. I'm OK with the code being here as
>> an interim measure if needed to move forward, but that should then be
>> temporary only.

It'd be nice if we can do this as an interim measure for now, so at least we
have the embedded display working. IIUC to move that to the display controller
driver core I should also convert/rework the mtk_dpi and mtk_hdmi drivers. This
is used for the external display on my device but to fully support this I'll
also need to rework the bridge chain logic to handle the multi-sink/multi-source
use case. This is something I plan to work on but I suspect won't be easy and
will trigger lots of discussions, and, of course, some time.

So, if is fine I won't move this for now.

Thanks,
 Enric


> 
> I forgot to mention that the drm_encoder should also move out of the
> bridge driver to the display controller driver.
> 
>>> Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
>>> ---
>>>
>>> Changes in v2: None
>>>
>>>  drivers/gpu/drm/mediatek/mtk_dsi.c | 14 +++++++++++++-
>>>  1 file changed, 13 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/drivers/gpu/drm/mediatek/mtk_dsi.c b/drivers/gpu/drm/mediatek/mtk_dsi.c
>>> index 44718fa3d1ca..2f8876c32864 100644
>>> --- a/drivers/gpu/drm/mediatek/mtk_dsi.c
>>> +++ b/drivers/gpu/drm/mediatek/mtk_dsi.c
>>> @@ -17,6 +17,7 @@
>>>  
>>>  #include <drm/drm_atomic_helper.h>
>>>  #include <drm/drm_bridge.h>
>>> +#include <drm/drm_bridge_connector.h>
>>>  #include <drm/drm_mipi_dsi.h>
>>>  #include <drm/drm_of.h>
>>>  #include <drm/drm_panel.h>
>>> @@ -184,6 +185,7 @@ struct mtk_dsi {
>>>  	struct drm_bridge bridge;
>>>  	struct drm_bridge *panel_bridge;
>>>  	struct drm_bridge *next_bridge;
>>> +	struct drm_connector *connector;
>>>  	struct phy *phy;
>>>  
>>>  	void __iomem *regs;
>>> @@ -983,10 +985,19 @@ static int mtk_dsi_encoder_init(struct drm_device *drm, struct mtk_dsi *dsi)
>>>  	 */
>>>  	dsi->encoder.possible_crtcs = 1;
>>>  
>>> -	ret = drm_bridge_attach(&dsi->encoder, &dsi->bridge, NULL, 0);
>>> +	ret = drm_bridge_attach(&dsi->encoder, &dsi->bridge, NULL,
>>> +				DRM_BRIDGE_ATTACH_NO_CONNECTOR);
>>>  	if (ret)
>>>  		goto err_cleanup_encoder;
>>>  
>>> +	dsi->connector = drm_bridge_connector_init(drm, &dsi->encoder);
>>> +	if (IS_ERR(dsi->connector)) {
>>> +		DRM_ERROR("Unable to create bridge connector\n");
>>> +		ret = PTR_ERR(dsi->connector);
>>> +		goto err_cleanup_encoder;
>>> +	}
>>> +	drm_connector_attach_encoder(dsi->connector, &dsi->encoder);
>>> +
>>>  	return 0;
>>>  
>>>  err_cleanup_encoder:
>>> @@ -1144,6 +1155,7 @@ static int mtk_dsi_probe(struct platform_device *pdev)
>>>  
>>>  	dsi->bridge.funcs = &mtk_dsi_bridge_funcs;
>>>  	dsi->bridge.of_node = dev->of_node;
>>> +	dsi->bridge.type = DRM_MODE_CONNECTOR_DSI;
>>
>> I think this line belongs to the patch that adds drm_bridge support to
>> this driver.
>>
>>>  
>>>  	drm_bridge_add(&dsi->bridge);
>>>  
> 
