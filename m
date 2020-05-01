Return-Path: <SRS0=nvtT=6P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E747FC47253
	for <linux-kernel@archiver.kernel.org>; Fri,  1 May 2020 14:41:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C89EF20857
	for <linux-kernel@archiver.kernel.org>; Fri,  1 May 2020 14:41:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729535AbgEAOlF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 May 2020 10:41:05 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:33048 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729078AbgEAOlD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 May 2020 10:41:03 -0400
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: eballetbo)
        with ESMTPSA id E17FF2A0BDB
Subject: Re: [PATCH v3 4/7] drm/mediatek: mtk_dsi: Convert to bridge driver
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
 <20200417150614.2631786-5-enric.balletbo@collabora.com>
 <CAAOTY_-nzdS-jg2pgpM1ksrsQVewB2AEB8TihHcCB-MJd+qFfw@mail.gmail.com>
From:   Enric Balletbo i Serra <enric.balletbo@collabora.com>
Message-ID: <72511ddc-c94d-3c20-14cb-e971b000fc48@collabora.com>
Date:   Fri, 1 May 2020 16:40:54 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <CAAOTY_-nzdS-jg2pgpM1ksrsQVewB2AEB8TihHcCB-MJd+qFfw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Chun-Kuang,

Thank you for the review.

On 1/5/20 15:21, Chun-Kuang Hu wrote:
> Hi, Enric:
> 
> Enric Balletbo i Serra <enric.balletbo@collabora.com> 於 2020年4月17日 週五 下午11:06寫道：
>>
>> Convert mtk_dsi to a bridge driver with built-in encoder support for
>> compatibility with existing component drivers.
>>
>> Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
>> ---
>>
>> Changes in v3:
>> - Add the bridge.type. (Laurent Pinchart)
>>
>> Changes in v2: None
>>
>>  drivers/gpu/drm/mediatek/mtk_dsi.c | 93 ++++++++++++++++++++++--------
>>  1 file changed, 69 insertions(+), 24 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/mediatek/mtk_dsi.c b/drivers/gpu/drm/mediatek/mtk_dsi.c
>> index 37b8d7ffd835..869ae0a2e9f8 100644
>> --- a/drivers/gpu/drm/mediatek/mtk_dsi.c
>> +++ b/drivers/gpu/drm/mediatek/mtk_dsi.c
>> @@ -180,6 +180,7 @@ struct mtk_dsi {
>>         struct device *dev;
>>         struct mipi_dsi_host host;
>>         struct drm_encoder encoder;
>> +       struct drm_bridge bridge;
>>         struct drm_connector conn;
>>         struct drm_panel *panel;
>>         struct drm_bridge *next_bridge;
>> @@ -205,9 +206,9 @@ struct mtk_dsi {
>>         const struct mtk_dsi_driver_data *driver_data;
>>  };
>>
>> -static inline struct mtk_dsi *encoder_to_dsi(struct drm_encoder *e)
>> +static inline struct mtk_dsi *bridge_to_dsi(struct drm_bridge *b)
>>  {
>> -       return container_of(e, struct mtk_dsi, encoder);
>> +       return container_of(b, struct mtk_dsi, bridge);
>>  }
>>
>>  static inline struct mtk_dsi *connector_to_dsi(struct drm_connector *c)
>> @@ -796,32 +797,43 @@ static const struct drm_encoder_funcs mtk_dsi_encoder_funcs = {
>>         .destroy = mtk_dsi_encoder_destroy,
>>  };
>>
>> -static bool mtk_dsi_encoder_mode_fixup(struct drm_encoder *encoder,
>> -                                      const struct drm_display_mode *mode,
>> -                                      struct drm_display_mode *adjusted_mode)
>> +static int mtk_dsi_create_conn_enc(struct drm_device *drm, struct mtk_dsi *dsi);
>> +static void mtk_dsi_destroy_conn_enc(struct mtk_dsi *dsi);
>> +
>> +static int mtk_dsi_bridge_attach(struct drm_bridge *bridge,
>> +                                enum drm_bridge_attach_flags flags)
>> +{
>> +       struct mtk_dsi *dsi = bridge_to_dsi(bridge);
>> +
>> +       return mtk_dsi_create_conn_enc(bridge->dev, dsi);
>> +}
>> +
>> +static void mtk_dsi_bridge_detach(struct drm_bridge *bridge)
>>  {
>> -       return true;
>> +       struct mtk_dsi *dsi = bridge_to_dsi(bridge);
>> +
>> +       mtk_dsi_destroy_conn_enc(dsi);
>>  }
>>
>> -static void mtk_dsi_encoder_mode_set(struct drm_encoder *encoder,
>> -                                    struct drm_display_mode *mode,
>> -                                    struct drm_display_mode *adjusted)
>> +static void mtk_dsi_bridge_mode_set(struct drm_bridge *bridge,
>> +                                   const struct drm_display_mode *mode,
>> +                                   const struct drm_display_mode *adjusted)
>>  {
>> -       struct mtk_dsi *dsi = encoder_to_dsi(encoder);
>> +       struct mtk_dsi *dsi = bridge_to_dsi(bridge);
>>
>>         drm_display_mode_to_videomode(adjusted, &dsi->vm);
>>  }
>>
>> -static void mtk_dsi_encoder_disable(struct drm_encoder *encoder)
>> +static void mtk_dsi_bridge_disable(struct drm_bridge *bridge)
>>  {
>> -       struct mtk_dsi *dsi = encoder_to_dsi(encoder);
>> +       struct mtk_dsi *dsi = bridge_to_dsi(bridge);
>>
>>         mtk_output_dsi_disable(dsi);
>>  }
>>
>> -static void mtk_dsi_encoder_enable(struct drm_encoder *encoder)
>> +static void mtk_dsi_bridge_enable(struct drm_bridge *bridge)
>>  {
>> -       struct mtk_dsi *dsi = encoder_to_dsi(encoder);
>> +       struct mtk_dsi *dsi = bridge_to_dsi(bridge);
>>
>>         mtk_output_dsi_enable(dsi);
>>  }
>> @@ -833,11 +845,12 @@ static int mtk_dsi_connector_get_modes(struct drm_connector *connector)
>>         return drm_panel_get_modes(dsi->panel, connector);
>>  }
>>
>> -static const struct drm_encoder_helper_funcs mtk_dsi_encoder_helper_funcs = {
>> -       .mode_fixup = mtk_dsi_encoder_mode_fixup,
>> -       .mode_set = mtk_dsi_encoder_mode_set,
>> -       .disable = mtk_dsi_encoder_disable,
>> -       .enable = mtk_dsi_encoder_enable,
>> +static const struct drm_bridge_funcs mtk_dsi_bridge_funcs = {
>> +       .attach = mtk_dsi_bridge_attach,
>> +       .detach = mtk_dsi_bridge_detach,
>> +       .disable = mtk_dsi_bridge_disable,
>> +       .enable = mtk_dsi_bridge_enable,
>> +       .mode_set = mtk_dsi_bridge_mode_set,
>>  };
>>
>>  static const struct drm_connector_funcs mtk_dsi_connector_funcs = {
>> @@ -1123,6 +1136,34 @@ static const struct mipi_dsi_host_ops mtk_dsi_ops = {
>>         .transfer = mtk_dsi_host_transfer,
>>  };
>>
>> +static int mtk_dsi_encoder_init(struct drm_device *drm, struct mtk_dsi *dsi)
>> +{
>> +       int ret;
>> +
>> +       ret = drm_encoder_init(drm, &dsi->encoder, &mtk_dsi_encoder_funcs,
>> +                              DRM_MODE_ENCODER_DSI, NULL);
> 
> I'm a bit confused here. drm_encoder_init() exist here and in
> mtk_dsi_create_conn_enc(). Do you plan to init encodr twice?
> 

Right, it should be removed from mtk_dsi_create_conn_enc(). I will do in next
version.

>> +       if (ret) {
>> +               DRM_ERROR("Failed to encoder init to drm\n");
>> +               return ret;
>> +       }
>> +
>> +       /*
>> +        * Currently display data paths are statically assigned to a crtc each.
>> +        * crtc 0 is OVL0 -> COLOR0 -> AAL -> OD -> RDMA0 -> UFOE -> DSI0
>> +        */
>> +       dsi->encoder.possible_crtcs = 1;
>> +
>> +       ret = drm_bridge_attach(&dsi->encoder, &dsi->bridge, NULL, 0);
>> +       if (ret)
>> +               goto err_cleanup_encoder;
>> +
>> +       return 0;
>> +
>> +err_cleanup_encoder:
>> +       drm_encoder_cleanup(&dsi->encoder);
>> +       return ret;
>> +}
>> +
>>  static int mtk_dsi_bind(struct device *dev, struct device *master, void *data)
>>  {
>>         int ret;
>> @@ -1136,11 +1177,9 @@ static int mtk_dsi_bind(struct device *dev, struct device *master, void *data)
>>                 return ret;
>>         }
>>
>> -       ret = mtk_dsi_create_conn_enc(drm, dsi);
>> -       if (ret) {
>> -               DRM_ERROR("Encoder create failed with %d\n", ret);
>> +       ret = mtk_dsi_encoder_init(drm, dsi);
>> +       if (ret)
>>                 goto err_unregister;
>> -       }
>>
>>         return 0;
>>
>> @@ -1155,7 +1194,6 @@ static void mtk_dsi_unbind(struct device *dev, struct device *master,
>>         struct drm_device *drm = data;
>>         struct mtk_dsi *dsi = dev_get_drvdata(dev);
>>
>> -       mtk_dsi_destroy_conn_enc(dsi);
> 
> There is mtk_dsi_encoder_init() in bind(), why no mtk_dsi_encoder_uninit() here?
> 

Right, I need uninit the encoder but a simple call to drm_encoder_cleanup should
be enough. I don't think is needed create a new function for that. I'll do in
next version.

> Regards,
> Chun-Kuang.
> 
>>         mtk_ddp_comp_unregister(drm, &dsi->ddp_comp);
>>  }
>>
>> @@ -1265,6 +1303,12 @@ static int mtk_dsi_probe(struct platform_device *pdev)
>>
>>         platform_set_drvdata(pdev, dsi);
>>
>> +       dsi->bridge.funcs = &mtk_dsi_bridge_funcs;
>> +       dsi->bridge.of_node = dev->of_node;
>> +       dsi->bridge.type = DRM_MODE_CONNECTOR_DSI;
>> +
>> +       drm_bridge_add(&dsi->bridge);
>> +
>>         ret = component_add(&pdev->dev, &mtk_dsi_component_ops);
>>         if (ret) {
>>                 dev_err(&pdev->dev, "failed to add component: %d\n", ret);
>> @@ -1283,6 +1327,7 @@ static int mtk_dsi_remove(struct platform_device *pdev)
>>         struct mtk_dsi *dsi = platform_get_drvdata(pdev);
>>
>>         mtk_output_dsi_disable(dsi);
>> +       drm_bridge_remove(&dsi->bridge);
>>         component_del(&pdev->dev, &mtk_dsi_component_ops);
>>         mipi_dsi_host_unregister(&dsi->host);
>>
>> --
>> 2.25.1
>>
