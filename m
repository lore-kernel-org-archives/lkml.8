Return-Path: <SRS0=8grS=CJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 192DAC433E2
	for <linux-kernel@archiver.kernel.org>; Mon, 31 Aug 2020 09:45:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DB6882064B
	for <linux-kernel@archiver.kernel.org>; Mon, 31 Aug 2020 09:45:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726804AbgHaJpz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 31 Aug 2020 05:45:55 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:38020 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726042AbgHaJpy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Aug 2020 05:45:54 -0400
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: eballetbo)
        with ESMTPSA id A5267291F0E
Subject: Re: [PATCH v3 1/1] drm/bridge: ps8640: Rework power state handling
To:     Bilal Wasim <bwasim.lkml@gmail.com>
Cc:     linux-kernel@vger.kernel.org,
        Collabora Kernel ML <kernel@collabora.com>,
        matthias.bgg@gmail.com, drinkcat@chromium.org, hsinyi@chromium.org,
        laurent.pinchart@ideasonboard.com, sam@ravnborg.org,
        Andrzej Hajda <a.hajda@samsung.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>,
        Jernej Skrabec <jernej.skrabec@siol.net>,
        Jonas Karlman <jonas@kwiboo.se>,
        Neil Armstrong <narmstrong@baylibre.com>,
        dri-devel@lists.freedesktop.org
References: <20200827085911.944899-1-enric.balletbo@collabora.com>
 <20200827085911.944899-2-enric.balletbo@collabora.com>
 <20200831143223.1a775ba6@a-VirtualBox>
From:   Enric Balletbo i Serra <enric.balletbo@collabora.com>
Message-ID: <c9e19863-6d6c-17d8-c837-f67989ce80eb@collabora.com>
Date:   Mon, 31 Aug 2020 11:45:47 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20200831143223.1a775ba6@a-VirtualBox>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Bilal,

On 31/8/20 11:32, Bilal Wasim wrote:
> 
> Hi Enric,
> 
> On Thu, 27 Aug 2020 10:59:11 +0200
> Enric Balletbo i Serra <enric.balletbo@collabora.com> wrote:
> 
>> The get_edid() callback can be triggered anytime by an ioctl, i.e
>>
>>   drm_mode_getconnector (ioctl)
>>     -> drm_helper_probe_single_connector_modes
>>        -> drm_bridge_connector_get_modes
>>           -> ps8640_bridge_get_edid  
>>
>> Actually if the bridge pre_enable() function was not called before
>> get_edid(), the driver will not be able to get the EDID properly and
>> display will not work until a second get_edid() call is issued and if
>> pre_enable() is called before. The side effect of this, for example,
>> is that you see anything when `Frecon` starts, neither the splash
>> screen, until the graphical session manager starts.
>>
>> To fix this we need to make sure that all we need is enabled before
>> reading the EDID. This means the following:
>>
>> 1. If get_edid() is called before having the device powered we need to
>>    power on the device. In such case, the driver will power off again
>> the device.
>>
>> 2. If get_edid() is called after having the device powered, all should
>>    just work. We added a powered flag in order to avoid recurrent
>> calls to ps8640_bridge_poweron() and unneeded delays.
>>
>> 3. This seems to be specific for this device, but we need to make sure
>>    the panel is powered on before do a power on cycle on this device.
>>    Otherwise the device fails to retrieve the EDID.
>>
>> Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
>> ---
>>
>> Changes in v3:
>> - Make poweron/poweroff and pre_enable/post_disable reverse one to
>> each other (Sam Ravnborg)
>>
>> Changes in v2:
>> - Use drm_bridge_chain_pre_enable/post_disable() helpers (Sam
>> Ravnborg)
>>
>>  drivers/gpu/drm/bridge/parade-ps8640.c | 68
>> ++++++++++++++++++++++---- 1 file changed, 58 insertions(+), 10
>> deletions(-)
>>
>> diff --git a/drivers/gpu/drm/bridge/parade-ps8640.c
>> b/drivers/gpu/drm/bridge/parade-ps8640.c index
>> 9f7b7a9c53c5..7bd0affa057a 100644 ---
>> a/drivers/gpu/drm/bridge/parade-ps8640.c +++
>> b/drivers/gpu/drm/bridge/parade-ps8640.c @@ -65,6 +65,7 @@ struct
>> ps8640 { struct regulator_bulk_data supplies[2];
>>  	struct gpio_desc *gpio_reset;
>>  	struct gpio_desc *gpio_powerdown;
>> +	bool powered;
>>  };
>>  
>>  static inline struct ps8640 *bridge_to_ps8640(struct drm_bridge *e)
>> @@ -91,13 +92,15 @@ static int ps8640_bridge_vdo_control(struct
>> ps8640 *ps_bridge, return 0;
>>  }
>>  
>> -static void ps8640_pre_enable(struct drm_bridge *bridge)
>> +static void ps8640_bridge_poweron(struct ps8640 *ps_bridge)
>>  {
>> -	struct ps8640 *ps_bridge = bridge_to_ps8640(bridge);
>>  	struct i2c_client *client = ps_bridge->page[PAGE2_TOP_CNTL];
>>  	unsigned long timeout;
>>  	int ret, status;
>>  
>> +	if (ps_bridge->powered)
>> +		return;
>> +
>>  	ret = regulator_bulk_enable(ARRAY_SIZE(ps_bridge->supplies),
>>  				    ps_bridge->supplies);
>>  	if (ret < 0) {
>> @@ -152,10 +155,6 @@ static void ps8640_pre_enable(struct drm_bridge
>> *bridge) goto err_regulators_disable;
>>  	}
>>  
>> -	ret = ps8640_bridge_vdo_control(ps_bridge, ENABLE);
>> -	if (ret)
>> -		goto err_regulators_disable;
>> -
>>  	/* Switch access edp panel's edid through i2c */
>>  	ret = i2c_smbus_write_byte_data(client, PAGE2_I2C_BYPASS,
>>  					I2C_BYPASS_EN);
>> @@ -164,6 +163,8 @@ static void ps8640_pre_enable(struct drm_bridge
>> *bridge) goto err_regulators_disable;
>>  	}
>>  
>> +	ps_bridge->powered = true;
>> +
>>  	return;
>>  
>>  err_regulators_disable:
>> @@ -171,12 +172,12 @@ static void ps8640_pre_enable(struct drm_bridge
>> *bridge) ps_bridge->supplies);
>>  }
>>  
>> -static void ps8640_post_disable(struct drm_bridge *bridge)
>> +static void ps8640_bridge_poweroff(struct ps8640 *ps_bridge)
>>  {
>> -	struct ps8640 *ps_bridge = bridge_to_ps8640(bridge);
>>  	int ret;
>>  
>> -	ps8640_bridge_vdo_control(ps_bridge, DISABLE);
>> +	if (!ps_bridge->powered)
>> +		return;
>>  
>>  	gpiod_set_value(ps_bridge->gpio_reset, 1);
>>  	gpiod_set_value(ps_bridge->gpio_powerdown, 1);
>> @@ -184,6 +185,28 @@ static void ps8640_post_disable(struct
>> drm_bridge *bridge) ps_bridge->supplies);
>>  	if (ret < 0)
>>  		DRM_ERROR("cannot disable regulators %d\n", ret);
>> +
>> +	ps_bridge->powered = false;
>> +}
>> +
>> +static void ps8640_pre_enable(struct drm_bridge *bridge)
>> +{
>> +	struct ps8640 *ps_bridge = bridge_to_ps8640(bridge);
>> +	int ret;
>> +
>> +	ps8640_bridge_poweron(ps_bridge);
>> +
>> +	ret = ps8640_bridge_vdo_control(ps_bridge, ENABLE);
>> +	if (ret < 0)
>> +		ps8640_bridge_poweroff(ps_bridge);
>> +}
>> +
>> +static void ps8640_post_disable(struct drm_bridge *bridge)
>> +{
>> +	struct ps8640 *ps_bridge = bridge_to_ps8640(bridge);
>> +
>> +	ps8640_bridge_vdo_control(ps_bridge, DISABLE);
>> +	ps8640_bridge_poweroff(ps_bridge);
>>  }
>>  
>>  static int ps8640_bridge_attach(struct drm_bridge *bridge,
>> @@ -249,9 +272,34 @@ static struct edid
>> *ps8640_bridge_get_edid(struct drm_bridge *bridge, struct
>> drm_connector *connector) {
>>  	struct ps8640 *ps_bridge = bridge_to_ps8640(bridge);
>> +	bool poweroff = !ps_bridge->powered;
>> +	struct edid *edid;
>> +
>> +	/*
>> +	 * When we end calling get_edid() triggered by an ioctl, i.e
>> +	 *
>> +	 *   drm_mode_getconnector (ioctl)
>> +	 *     -> drm_helper_probe_single_connector_modes
>> +	 *        -> drm_bridge_connector_get_modes
>> +	 *           -> ps8640_bridge_get_edid
>> +	 *
>> +	 * We need to make sure that what we need is enabled before
>> reading
>> +	 * EDID, for this chip, we need to do a full poweron,
>> otherwise it will
>> +	 * fail.
>> +	 */
>> +	drm_bridge_chain_pre_enable(bridge);
> 
> Are we sure that pre_enable is always good enough to get the EDID? I
> know that we only have support for ps8640 on the MT8173 SoC which works
> only with pre_enable, but I think a more scalable solution would be to
> call drm_bridge_chain_pre_enable / drm_bridge_chain_enable here, and
> drm_bridge_chain_post_disable / drm_bridge_chain_disable when disabling
> the chain. If this is not a concern and we are sure that pre_enable
> will always work (especially on newer boards), then please ignore my
> comment. 
> 

Not a drm_bridge API expert, and sometimes I am confused about it, but, from
what I know, I'm pretty sure that we _don't_ want to call drm_bridge_chain_enable().

The call drm_bridge_chain_pre_enable() will end with calling
drm_panel_prepare(), which, as per documentation:

 * Calling this function will enable power and deassert any reset signals to
 * the panel. After this has completed it is possible to communicate with any
 * integrated circuitry via a command bus.

Calling drm_bridge_chain_enable() too will end calling drm_panel_enable(), and,
as per documentation:

 * Calling this function will cause the panel display drivers to be turned on
 * and the backlight to be enabled. Content will be visible on screen after
 * this call completes

Which can trigger a screen flickering and enable more things that what we want.
Reading the EDID should be possible just after a call of drm_bridge_prepare().
Enable the panel should not be required.

Cheers,
 Enric

> Other than this, everything looks fine.
> 
>>  
>> -	return drm_get_edid(connector,
>> +	edid = drm_get_edid(connector,
>>  			    ps_bridge->page[PAGE0_DP_CNTL]->adapter);
>> +
>> +	/*
>> +	 * If we call the get_edid() function without having enabled
>> the chip
>> +	 * before, return the chip to its original power state.
>> +	 */
>> +	if (poweroff)
>> +		drm_bridge_chain_post_disable(bridge);
>> +
>> +	return edid;
>>  }
>>  
>>  static const struct drm_bridge_funcs ps8640_bridge_funcs = {
> 
> -Bilal
> 
