Return-Path: <SRS0=3W8M=6B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5757AC352BE
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Apr 2020 14:51:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2DCC12223D
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Apr 2020 14:51:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728249AbgDQOvO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Apr 2020 10:51:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727850AbgDQOvN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Apr 2020 10:51:13 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70B91C061A0C
        for <linux-kernel@vger.kernel.org>; Fri, 17 Apr 2020 07:51:13 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: eballetbo)
        with ESMTPSA id 047E72A22E0
Subject: Re: [PATCH v2 1/7] drm/bridge: ps8640: Get the EDID from eDP control
To:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc:     linux-kernel@vger.kernel.org,
        Collabora Kernel ML <kernel@collabora.com>,
        matthias.bgg@gmail.com, drinkcat@chromium.org, hsinyi@chromium.org,
        Andrzej Hajda <a.hajda@samsung.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>,
        Jernej Skrabec <jernej.skrabec@siol.net>,
        Jonas Karlman <jonas@kwiboo.se>,
        Neil Armstrong <narmstrong@baylibre.com>,
        dri-devel@lists.freedesktop.org
References: <20200416155720.2360443-1-enric.balletbo@collabora.com>
 <20200416155720.2360443-2-enric.balletbo@collabora.com>
 <20200416172215.GK4796@pendragon.ideasonboard.com>
From:   Enric Balletbo i Serra <enric.balletbo@collabora.com>
Message-ID: <95bf8d3b-3daf-c505-eeb0-e5ef167085ac@collabora.com>
Date:   Fri, 17 Apr 2020 16:51:08 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200416172215.GK4796@pendragon.ideasonboard.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Laurent,

On 16/4/20 19:22, Laurent Pinchart wrote:
> Hi Enric,
> 
> Thank you for the patch.
> 
> On Thu, Apr 16, 2020 at 05:57:13PM +0200, Enric Balletbo i Serra wrote:
>> The PS8640 DSI-to-eDP bridge can retrieve the EDID, so implement the
>> .get_edid callback and set the flag to indicate the core to use it.
>>
>> Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
>> ---
>>
>> Changes in v2: None
>>
>>  drivers/gpu/drm/bridge/parade-ps8640.c | 12 ++++++++++++
>>  1 file changed, 12 insertions(+)
>>
>> diff --git a/drivers/gpu/drm/bridge/parade-ps8640.c b/drivers/gpu/drm/bridge/parade-ps8640.c
>> index d3a53442d449..956b76e0a44d 100644
>> --- a/drivers/gpu/drm/bridge/parade-ps8640.c
>> +++ b/drivers/gpu/drm/bridge/parade-ps8640.c
>> @@ -242,8 +242,18 @@ static int ps8640_bridge_attach(struct drm_bridge *bridge,
>>  	return ret;
>>  }
>>  
>> +static struct edid *ps8640_bridge_get_edid(struct drm_bridge *bridge,
>> +					   struct drm_connector *connector)
>> +{
>> +	struct ps8640 *ps_bridge = bridge_to_ps8640(bridge);
>> +
>> +	return drm_get_edid(connector,
>> +			    ps_bridge->page[PAGE0_DP_CNTL]->adapter);
> 
> This will only work if the DDC signals are connected to the PS8640
> (quite obviously). Is that guaranteed, or could some systems connect
> them directory to an SoC I2C controller ?

It is possible but IMHO opinion this is hardware tricky, I mean, ps8640 outputs
eDP interface and the panel is an eDP interface, so I'd expect hardware
engineers do a pin to pin design, not routing the DDC signals to the SoC
directly ignoring the eDP interface.

> In the latter case we would
> have to report this in the DT bindings of the PS8640. That's not
> blocking for this patch, I am just wondering, as I would have expected
> the driver to already expose EDID one way or another if this was
> available and used.
> 
> Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
> 
>> +}
>> +
>>  static const struct drm_bridge_funcs ps8640_bridge_funcs = {
>>  	.attach = ps8640_bridge_attach,
>> +	.get_edid = ps8640_bridge_get_edid,
>>  	.post_disable = ps8640_post_disable,
>>  	.pre_enable = ps8640_pre_enable,
>>  };
>> @@ -296,6 +306,8 @@ static int ps8640_probe(struct i2c_client *client)
>>  
>>  	ps_bridge->bridge.funcs = &ps8640_bridge_funcs;
>>  	ps_bridge->bridge.of_node = dev->of_node;
>> +	ps_bridge->bridge.ops = DRM_BRIDGE_OP_EDID;
>> +	ps_bridge->bridge.type = DRM_MODE_CONNECTOR_eDP;
>>  
>>  	ps_bridge->page[PAGE0_DP_CNTL] = client;
>>  
> 
