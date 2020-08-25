Return-Path: <SRS0=mfLo=CD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C5ACC433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Aug 2020 03:05:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5ED4B206EB
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Aug 2020 03:05:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728488AbgHYDFV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Aug 2020 23:05:21 -0400
Received: from mga05.intel.com ([192.55.52.43]:26334 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728110AbgHYDFU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Aug 2020 23:05:20 -0400
IronPort-SDR: jtfTJcT4yCvGXs8I5FHthDy8avTVZ8N+SGrIkEMXqzpu4BVqO+q0DvgEOK4NE8YhfnEXxZAchG
 vpwkFlVkjShw==
X-IronPort-AV: E=McAfee;i="6000,8403,9723"; a="240848940"
X-IronPort-AV: E=Sophos;i="5.76,351,1592895600"; 
   d="scan'208";a="240848940"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Aug 2020 20:05:19 -0700
IronPort-SDR: WKaCUdT6JA5i5RDxv5fIxrFTi6SMBmSqCbPJFfcOiF5vy7FjPvRJr8Hz5uPJNbmSqpoV//C7Rt
 BnvMulyRTu6Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.76,351,1592895600"; 
   d="scan'208";a="499696883"
Received: from linux.intel.com ([10.54.29.200])
  by fmsmga005.fm.intel.com with ESMTP; 24 Aug 2020 20:05:20 -0700
Received: from [10.213.45.180] (vramuthx-MOBL1.gar.corp.intel.com [10.213.45.180])
        by linux.intel.com (Postfix) with ESMTP id 2908758043C;
        Mon, 24 Aug 2020 20:05:15 -0700 (PDT)
Reply-To: vadivel.muruganx.ramuthevar@linux.intel.com
Subject: Re: [RESEND PATCH v8 2/2] phy: Add USB3 PHY support for Intel LGM SoC
To:     Vinod Koul <vkoul@kernel.org>
Cc:     linux-kernel@vger.kernel.org, kishon@ti.com,
        devicetree@vger.kernel.org, robh+dt@kernel.org,
        gregkh@linuxfoundation.org, p.zabel@pengutronix.de,
        balbi@kernel.org, andriy.shevchenko@intel.com,
        cheol.yong.kim@intel.com, qi-ming.wu@intel.com, yin1.li@intel.com
References: <20200817070513.34376-1-vadivel.muruganx.ramuthevar@linux.intel.com>
 <20200817070513.34376-3-vadivel.muruganx.ramuthevar@linux.intel.com>
 <20200823160637.GW2639@vkoul-mobl>
From:   "Ramuthevar, Vadivel MuruganX" 
        <vadivel.muruganx.ramuthevar@linux.intel.com>
Message-ID: <4da0441a-0396-5bd0-ff9d-94c6ce5d158c@linux.intel.com>
Date:   Tue, 25 Aug 2020 11:05:14 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20200823160637.GW2639@vkoul-mobl>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Vinod,

   Thank you for the review comments...

On 24/8/2020 12:06 am, Vinod Koul wrote:
> On 17-08-20, 15:05, Ramuthevar,Vadivel MuruganX wrote:
>> From: Ramuthevar Vadivel Murugan <vadivel.muruganx.ramuthevar@linux.intel.com>
>>
>> Add support for USB PHY on Intel LGM SoC.
>>
>> Signed-off-by: Ramuthevar Vadivel Murugan <vadivel.muruganx.ramuthevar@linux.intel.com>
>> Reviewed-by: Philipp Zabel <p.zabel@pengutronix.de>
>> ---
>>   drivers/phy/Kconfig       |  11 ++
>>   drivers/phy/Makefile      |   1 +
>>   drivers/phy/phy-lgm-usb.c | 278 ++++++++++++++++++++++++++++++++++++++++++++++
>>   3 files changed, 290 insertions(+)
>>   create mode 100644 drivers/phy/phy-lgm-usb.c
>>
>> diff --git a/drivers/phy/Kconfig b/drivers/phy/Kconfig
>> index de9362c25c07..01b53f86004c 100644
>> --- a/drivers/phy/Kconfig
>> +++ b/drivers/phy/Kconfig
>> @@ -49,6 +49,17 @@ config PHY_XGENE
>>   	help
>>   	  This option enables support for APM X-Gene SoC multi-purpose PHY.
>>   
>> +config USB_LGM_PHY
>> +	tristate "INTEL Lightning Mountain USB PHY Driver"
>> +	depends on USB_SUPPORT
> 
> Why is the dependent on USB..? Should that not be other way around?
Good catch, it's not required.
> 
>> +static int get_flipped(struct tca_apb *ta, bool *flipped)
>> +{
>> +	union extcon_property_value property;
>> +	int ret;
>> +
>> +	ret = extcon_get_property(ta->phy.edev, EXTCON_USB_HOST,
>> +				  EXTCON_PROP_USB_TYPEC_POLARITY, &property);
>> +	if (ret) {
>> +		dev_err(ta->phy.dev, "no polarity property from extcon\n");
>> +		return ret;
>> +	}
>> +
>> +	*flipped = property.intval;
>> +
>> +	return ret;
> 
> return 0 here?
Noted.
> 
>> +static int phy_init(struct usb_phy *phy)
>> +{
>> +	struct tca_apb *ta = container_of(phy, struct tca_apb, phy);
>> +	void __iomem *ctrl1 = phy->io_priv + CTRL1_OFFSET;
>> +	int val, ret, i;
>> +
>> +	if (ta->phy_initialized)
>> +		return 0;
>> +
>> +	for (i = 0; i < ARRAY_SIZE(PHY_RESETS); i++)
>> +		reset_control_deassert(ta->resets[i]);
>> +
>> +	ret = readl_poll_timeout(ctrl1, val, val & SRAM_INIT_DONE, 10, 10 * 1000);
>> +	if (ret) {
>> +		dev_err(ta->phy.dev, "SRAM init failed, 0x%x\n", val);
>> +		return ret;
>> +	}
>> +
>> +	writel(readl(ctrl1) | SRAM_EXT_LD_DONE, ctrl1);
>> +
>> +	ta->phy_initialized = true;
>> +	if (!ta->phy.edev) {
>> +		writel(TCPC_CONN, ta->phy.io_priv + TCPC_OFFSET);
>> +		return phy->set_vbus(phy, true);
>> +	}
>> +
>> +	schedule_work(&ta->wk);
> 
> why work for init?
Yes, it's required during the reboot and already device is connected 
status update to controller, well tested.
> 
>> +static void tca_work(struct work_struct *work)
>> +{
>> +	struct tca_apb *ta = container_of(work, struct tca_apb, wk);
>> +	bool connected;
>> +	bool flipped = false;
>> +	u32 val;
>> +	int ret;
>> +
>> +	ret = get_flipped(ta, &flipped);
> 
> so every time this work is scheduled you are reading from firmware, why..
> Typically we should read in probe and store it..
> 
>> +	connected = extcon_get_state(ta->phy.edev, EXTCON_USB_HOST) && !ret;
> 
> lets handle ret and extcon_get_state separately please
Sure, we can handle it separately.
> 
>> +	if (connected == ta->connected)
>> +		return;
>> +
>> +	ta->connected = connected;
>> +	if (connected) {
>> +		val = TCPC_CONN;
>> +		if (flipped)
>> +			val |= TCPC_FLIPPED;
>> +		dev_info(ta->phy.dev, "connected%s\n", flipped ? " flipped" : "");
> 
> debug perhaps
Noted.
> 
>> +	} else {
>> +		val = TCPC_DISCONN;
>> +		dev_info(ta->phy.dev, "disconnected\n");
> 
> here too
Noted.
> 
>> +static int vbus_notifier(struct notifier_block *nb, unsigned long evnt, void *ptr)
>> +{
>> +	return NOTIFY_DONE;
>> +}
> 
> empty notifier, why bother?
Let me check and double confirm if it's required or not.
> 
>> +static int phy_probe(struct platform_device *pdev)
>> +{
>> +	struct reset_control *resets[ARRAY_SIZE(CTL_RESETS)];
>> +	struct device *dev = &pdev->dev;
>> +	struct usb_phy *phy;
>> +	struct tca_apb *ta;
>> +	int i;
>> +
>> +	ta = devm_kzalloc(dev, sizeof(*ta), GFP_KERNEL);
>> +	if (!ta)
>> +		return -ENOMEM;
>> +
>> +	platform_set_drvdata(pdev, ta);
>> +	INIT_WORK(&ta->wk, tca_work);
>> +
>> +	phy = &ta->phy;
>> +	phy->dev = dev;
>> +	phy->label = dev_name(dev);
>> +	phy->type = USB_PHY_TYPE_USB3;
>> +	phy->init = phy_init;
>> +	phy->shutdown = phy_shutdown;
>> +	phy->set_vbus = phy_set_vbus;
>> +	phy->id_nb.notifier_call = id_notifier;
>> +	phy->vbus_nb.notifier_call = vbus_notifier;
>> +
>> +	phy->io_priv = devm_platform_ioremap_resource(pdev, 0);
>> +	if (IS_ERR(phy->io_priv))
>> +		return PTR_ERR(phy->io_priv);
>> +
>> +	ta->vbus = devm_regulator_get(dev, "vbus");
>> +	if (IS_ERR(ta->vbus))
>> +		return PTR_ERR(ta->vbus);
>> +
>> +	for (i = 0; i < ARRAY_SIZE(CTL_RESETS); i++) {
>> +		resets[i] = devm_reset_control_get_exclusive(dev, CTL_RESETS[i]);
>> +		if (IS_ERR(resets[i])) {
>> +			dev_err(dev, "%s reset not found\n", CTL_RESETS[i]);
>> +			return PTR_ERR(resets[i]);
>> +		}
>> +	}
>> +
>> +	for (i = 0; i < ARRAY_SIZE(PHY_RESETS); i++) {
>> +		ta->resets[i] = devm_reset_control_get_exclusive(dev, PHY_RESETS[i]);
>> +		if (IS_ERR(ta->resets[i])) {
>> +			dev_err(dev, "%s reset not found\n", PHY_RESETS[i]);
>> +			return PTR_ERR(ta->resets[i]);
>> +		}
>> +	}
>> +
>> +	for (i = 0; i < ARRAY_SIZE(CTL_RESETS); i++)
>> +		reset_control_assert(resets[i]);
>> +
>> +	for (i = 0; i < ARRAY_SIZE(PHY_RESETS); i++)
>> +		reset_control_assert(ta->resets[i]);
> 
> no time lag b/w assert and dessert below?
yes you're right but not required for Intel LGM SoC, it's working fine.

Regards
Vadivel
> 
>> +	/*
>> +	 * Out-of-band reset of the controller after PHY reset will cause
>> +	 * controller malfunctioning, so we should use in-band controller
>> +	 * reset only and leave the controller de-asserted here.
>> +	 */
>> +	for (i = 0; i < ARRAY_SIZE(CTL_RESETS); i++)
>> +		reset_control_deassert(resets[i]);
>> +
>> +	/* Need to wait at least 20us after de-assert the controller */
>> +	usleep_range(20, 100);
>> +
>> +	return usb_add_phy_dev(phy);
> 
> aha, this is usb_phy stuff.
> 
> Kishon this is not really a generic phy driver, should it be in
> drivers/phy..?
> 
