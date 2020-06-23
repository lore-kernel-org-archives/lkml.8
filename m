Return-Path: <SRS0=AM+j=AE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 667E7C433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 15:16:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 41EA520774
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 15:16:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732959AbgFWPQu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Jun 2020 11:16:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732946AbgFWPQt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Jun 2020 11:16:49 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08438C061573
        for <linux-kernel@vger.kernel.org>; Tue, 23 Jun 2020 08:16:49 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: eballetbo)
        with ESMTPSA id D3A4C2A3535
Subject: Re: [PATCH 3/3] drm/bridge: ps8640: Rework power state handling
To:     Sam Ravnborg <sam@ravnborg.org>
Cc:     linux-kernel@vger.kernel.org,
        Jernej Skrabec <jernej.skrabec@siol.net>,
        drinkcat@chromium.org, Jonas Karlman <jonas@kwiboo.se>,
        David Airlie <airlied@linux.ie>,
        Neil Armstrong <narmstrong@baylibre.com>,
        dri-devel@lists.freedesktop.org,
        Andrzej Hajda <a.hajda@samsung.com>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        hsinyi@chromium.org, matthias.bgg@gmail.com,
        Collabora Kernel ML <kernel@collabora.com>,
        Boris Brezillon <boris.brezillon@collabora.com>
References: <20200615205320.790334-1-enric.balletbo@collabora.com>
 <20200615205320.790334-4-enric.balletbo@collabora.com>
 <20200620214225.GD74146@ravnborg.org>
From:   Enric Balletbo i Serra <enric.balletbo@collabora.com>
Message-ID: <0220cfe5-2ac9-2d8b-529d-bb1a61478395@collabora.com>
Date:   Tue, 23 Jun 2020 17:16:43 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <20200620214225.GD74146@ravnborg.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Sam,

Many thanks for your feedback. See my answers below.

On 20/6/20 23:42, Sam Ravnborg wrote:
> Hi Enric.
> 
> On Mon, Jun 15, 2020 at 10:53:20PM +0200, Enric Balletbo i Serra wrote:
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
>> pre_enable() is called before.
> Is it correct to fix this in the driver?
> Why not just fail and tell user-sapce to try again later?
> (Dunno what error-code to use - there must be one).
> 

My undestanding, I might be wrong, is that userspace should don't know which
bits, regulators, etc, are needed to get the EDID with an ioctl. Is the kernel
that should make sure that all is set properly (the required regulators, etc)
when userspace wants to read the EDID.

> Then we avoid complicating drivers fro somethign we really should
> fix in user-space.
> 
>> The side effect of this, for example, is
>> that you see anything when `Frecon` starts, neither the splash screen,
> that you do not see ...
> 
> (Otherwise I do not parse the above).
> 
>> until the graphical session manager starts.
>>
>> To fix this we need to make sure that all we need is enabled before
>> reading the EDID. This means the following:
>>
>> 1. If get_edid() is called before having the device powered we need to
>>    power on the device. In such case, the driver will power off again the
>>    device.
>>
>> 2. If get_edid() is called after having the device powered, all should
>>    just work. We added a powered flag in order to avoid recurrent calls
>>    to ps8640_bridge_poweron() and unneeded delays.
>>
>> 3. This seems to be specific for this device, but we need to make sure
>>    the panel is powered on before do a power on cycle on this device.
>>    Otherwise the device fails to retrieve the EDID.
> Step 3. looks like an ugly hack too....
> 

It is, but I don't have enough hardware details to be able to answer why we need
to do this. What is well tested is that, if I don't power the panel before
powering on the bridge, it doesn't get a proper EDID. Seems that when the bridge
goes up, the firmware tries to read the EDID and caches somehow. Well not sure.

>>
>> Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
>> ---
>>
>>  drivers/gpu/drm/bridge/parade-ps8640.c | 79 ++++++++++++++++++++++++--
>>  1 file changed, 73 insertions(+), 6 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/bridge/parade-ps8640.c b/drivers/gpu/drm/bridge/parade-ps8640.c
>> index 9f7b7a9c53c52..ca651480891df 100644
>> --- a/drivers/gpu/drm/bridge/parade-ps8640.c
>> +++ b/drivers/gpu/drm/bridge/parade-ps8640.c
>> @@ -65,6 +65,7 @@ struct ps8640 {
>>  	struct regulator_bulk_data supplies[2];
>>  	struct gpio_desc *gpio_reset;
>>  	struct gpio_desc *gpio_powerdown;
>> +	bool powered;
>>  };
>>  
>>  static inline struct ps8640 *bridge_to_ps8640(struct drm_bridge *e)
>> @@ -91,13 +92,25 @@ static int ps8640_bridge_vdo_control(struct ps8640 *ps_bridge,
>>  	return 0;
>>  }
>>  
>> -static void ps8640_pre_enable(struct drm_bridge *bridge)
>> +static void ps8640_bridge_poweron(struct ps8640 *ps_bridge)
>>  {
>> -	struct ps8640 *ps_bridge = bridge_to_ps8640(bridge);
>>  	struct i2c_client *client = ps_bridge->page[PAGE2_TOP_CNTL];
>> +	struct drm_bridge *panel;
>>  	unsigned long timeout;
>>  	int ret, status;
>>  
>> +	if (ps_bridge->powered)
>> +		return;
>> +
>> +	/*
>> +	 * That seems to be specific to this chip, and a weird behaviour, but
>> +	 * we need to call drm_panel_prepare before issuing a poweron cycle. If
>> +	 * we don't do this, the chip is not able to read properly the EDID.
>> +	 */
>> +	panel = ps_bridge->panel_bridge;
>> +	if (panel->funcs && panel->funcs->pre_enable)
>> +		panel->funcs->pre_enable(panel);
>> +
>>  	ret = regulator_bulk_enable(ARRAY_SIZE(ps_bridge->supplies),
>>  				    ps_bridge->supplies);
>>  	if (ret < 0) {
>> @@ -164,6 +177,8 @@ static void ps8640_pre_enable(struct drm_bridge *bridge)
>>  		goto err_regulators_disable;
>>  	}
>>  
>> +	ps_bridge->powered = true;
>> +
>>  	return;
>>  
>>  err_regulators_disable:
>> @@ -171,12 +186,13 @@ static void ps8640_pre_enable(struct drm_bridge *bridge)
>>  			       ps_bridge->supplies);
>>  }
>>  
>> -static void ps8640_post_disable(struct drm_bridge *bridge)
>> +static void ps8640_bridge_poweroff(struct ps8640 *ps_bridge)
>>  {
>> -	struct ps8640 *ps_bridge = bridge_to_ps8640(bridge);
>> +	struct drm_bridge *panel;
>>  	int ret;
>>  
>> -	ps8640_bridge_vdo_control(ps_bridge, DISABLE);
>> +	if (!ps_bridge->powered)
>> +		return;
>>  
>>  	gpiod_set_value(ps_bridge->gpio_reset, 1);
>>  	gpiod_set_value(ps_bridge->gpio_powerdown, 1);
>> @@ -184,6 +200,32 @@ static void ps8640_post_disable(struct drm_bridge *bridge)
>>  				     ps_bridge->supplies);
>>  	if (ret < 0)
>>  		DRM_ERROR("cannot disable regulators %d\n", ret);
>> +
>> +	panel = ps_bridge->panel_bridge;
>> +	if (panel->funcs && panel->funcs->post_disable)
>> +		panel->funcs->post_disable(panel);
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
>> +	ret = ps8640_bridge_vdo_control(ps_bridge, DISABLE);
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
>> @@ -249,9 +291,34 @@ static struct edid *ps8640_bridge_get_edid(struct drm_bridge *bridge,
>>  					   struct drm_connector *connector)
>>  {
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
>> +	 * We need to make sure that what we need is enabled before reading
>> +	 * EDID, for this chip, we need to do a full poweron, otherwise it will
>> +	 * fail.
>> +	 */
>> +	ps8640_bridge_poweron(ps_bridge);
>>  
>> -	return drm_get_edid(connector,
>> +	edid = drm_get_edid(connector,
>>  			    ps_bridge->page[PAGE0_DP_CNTL]->adapter);
>> +
>> +	/*
>> +	 * If we call the get_edid() function without having enabled the chip
>> +	 * before, return the chip to its original power state.
>> +	 */
>> +	if (poweroff)
>> +		ps8640_bridge_poweroff(ps_bridge);
>> +
>> +	return edid;
>>  }
>>  
>>  static const struct drm_bridge_funcs ps8640_bridge_funcs = {
>> -- 
>> 2.27.0
>>
>> _______________________________________________
>> dri-devel mailing list
>> dri-devel@lists.freedesktop.org
>> https://lists.freedesktop.org/mailman/listinfo/dri-devel
