Return-Path: <SRS0=nvtT=6P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA27EC47253
	for <linux-kernel@archiver.kernel.org>; Fri,  1 May 2020 14:59:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C0FA020836
	for <linux-kernel@archiver.kernel.org>; Fri,  1 May 2020 14:59:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729069AbgEAO7s (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 May 2020 10:59:48 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:33296 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728724AbgEAO7s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 May 2020 10:59:48 -0400
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: eballetbo)
        with ESMTPSA id 3C1082A30D9
Subject: Re: [PATCH v3 7/7] drm/mediatek: mtk_dsi: Create connector for
 bridges
To:     Chun-Kuang Hu <chunkuang.hu@kernel.org>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>,
        Collabora Kernel ML <kernel@collabora.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Nicolas Boichat <drinkcat@chromium.org>,
        Hsin-Yi Wang <hsinyi@chromium.org>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        DRI Development <dri-devel@lists.freedesktop.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>
References: <20200417150614.2631786-1-enric.balletbo@collabora.com>
 <20200417150614.2631786-8-enric.balletbo@collabora.com>
 <CAAOTY_8uWP80ZMO5ZQGLJ5YLFZcmGjZwc33Hi_oXsCPj5Yr89A@mail.gmail.com>
From:   Enric Balletbo i Serra <enric.balletbo@collabora.com>
Message-ID: <0584a198-02f2-a8a3-676e-74365a697bd4@collabora.com>
Date:   Fri, 1 May 2020 16:59:41 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <CAAOTY_8uWP80ZMO5ZQGLJ5YLFZcmGjZwc33Hi_oXsCPj5Yr89A@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Chun-Kuang,

Thank you for your review.

On 1/5/20 16:26, Chun-Kuang Hu wrote:
> Hi, Enric:
> 
> Enric Balletbo i Serra <enric.balletbo@collabora.com> 於 2020年4月17日 週五 下午11:06寫道：
>>
>> Use the drm_bridge_connector helper to create a connector for pipelines
>> that use drm_bridge. This allows splitting connector operations across
>> multiple bridges when necessary, instead of having the last bridge in
>> the chain creating the connector and handling all connector operations
>> internally.
>>
>> Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
>> ---
>>
>> Changes in v3:
>> - Move the bridge.type line to the patch that adds drm_bridge support. (Laurent Pinchart)
>>
>> Changes in v2: None
>>
>>  drivers/gpu/drm/mediatek/mtk_dsi.c | 13 ++++++++++++-
>>  1 file changed, 12 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/gpu/drm/mediatek/mtk_dsi.c b/drivers/gpu/drm/mediatek/mtk_dsi.c
>> index 157097c63b23..85f76b01ae4d 100644
>> --- a/drivers/gpu/drm/mediatek/mtk_dsi.c
>> +++ b/drivers/gpu/drm/mediatek/mtk_dsi.c
>> @@ -17,6 +17,7 @@
>>
>>  #include <drm/drm_atomic_helper.h>
>>  #include <drm/drm_bridge.h>
>> +#include <drm/drm_bridge_connector.h>
>>  #include <drm/drm_mipi_dsi.h>
>>  #include <drm/drm_of.h>
>>  #include <drm/drm_panel.h>
>> @@ -183,6 +184,7 @@ struct mtk_dsi {
>>         struct drm_encoder encoder;
>>         struct drm_bridge bridge;
>>         struct drm_bridge *next_bridge;
>> +       struct drm_connector *connector;
>>         struct phy *phy;
>>
>>         void __iomem *regs;
>> @@ -977,10 +979,19 @@ static int mtk_dsi_encoder_init(struct drm_device *drm, struct mtk_dsi *dsi)
>>          */
>>         dsi->encoder.possible_crtcs = 1;
>>
>> -       ret = drm_bridge_attach(&dsi->encoder, &dsi->bridge, NULL, 0);
>> +       ret = drm_bridge_attach(&dsi->encoder, &dsi->bridge, NULL,
>> +                               DRM_BRIDGE_ATTACH_NO_CONNECTOR);
>>         if (ret)
>>                 goto err_cleanup_encoder;
>>
>> +       dsi->connector = drm_bridge_connector_init(drm, &dsi->encoder);
>> +       if (IS_ERR(dsi->connector)) {
>> +               DRM_ERROR("Unable to create bridge connector\n");
>> +               ret = PTR_ERR(dsi->connector);
>> +               goto err_cleanup_encoder;
>> +       }
>> +       drm_connector_attach_encoder(dsi->connector, &dsi->encoder);
>> +
> 
> I'm not very clear about how brige-connector works, but why connector
> does not attach to panel?
> 

Laurent or other drm maintainers might have more details than me, but, AFAIK the
drm_bridge_connector_init initializes a connector for a chain of bridges that
starts at the @encoder. At this point you don't know which bridge is connected
to the panel physically but doesn't really matter as what you know is that will
be only one connector in the  chain.

Thanks,
 Enric

> Regards,
> Chun-Kuang.
> 
>>         return 0;
>>
>>  err_cleanup_encoder:
>> --
>> 2.25.1
>>
