Return-Path: <SRS0=bWCJ=AA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9181C433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jun 2020 07:20:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 93B842080C
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jun 2020 07:20:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1592551201;
	bh=73y/yWAa1uy/PoHKIOVM7+nJAaoKewCVVyD8restAhI=;
	h=Date:From:To:cc:Subject:In-Reply-To:References:List-ID:From;
	b=PL3JG5y6bYwg3ZoS9L+UES6t+qBjl7uSJrR0uE/pIqbxjsDsM6+SjXPAr4d5tJqoN
	 hL2OgGWetm+X+y8zE85O+xdIs4O7MC9uQo4hLZseUThz/8/dMFSOtPjUEtTvRsUQUB
	 ymSE1yH4AJng0bQKeemdM0u2Cm0bcd08MHf6sHdQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730434AbgFSHT7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Jun 2020 03:19:59 -0400
Received: from mail.kernel.org ([198.145.29.99]:53598 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729080AbgFSHT7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Jun 2020 03:19:59 -0400
Received: from pobox.suse.cz (nat1.prg.suse.com [195.250.132.148])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8892C2078D;
        Fri, 19 Jun 2020 07:19:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592551198;
        bh=73y/yWAa1uy/PoHKIOVM7+nJAaoKewCVVyD8restAhI=;
        h=Date:From:To:cc:Subject:In-Reply-To:References:From;
        b=ahLOl6lkf4RlScffHtFTFCy+uYY6+KvVdmHwtS+KDy4UkiP+EEi+fYbvAT3eYXtcG
         K/w4VyV4eK3WPmOLqYT5cIm/0fGBzbo6gj9aA4JFj2b2kF9LIG62wYuQiPrPGsypHi
         1ulwdhoey54LS1vsQB0/+jUKwdGOHqgMJpMxxBkU=
Date:   Fri, 19 Jun 2020 09:19:55 +0200 (CEST)
From:   Jiri Kosina <jikos@kernel.org>
To:     =?ISO-8859-2?Q?Kamil_Doma=F1ski?= <kamil@domanski.co>
cc:     linux-kernel@vger.kernel.org,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        Nestor Lopez Casado <nlopezcasad@logitech.com>,
        =?ISO-8859-15?Q?Filipe_La=EDns?= <lains@archlinux.org>
Subject: Re: [PATCH v2] HID: logitech-hidpp: add support for Logitech G533
 headset
In-Reply-To: <023148f582cc20bef7079508ce417c8ebeb0febb.camel@domanski.co>
Message-ID: <nycvar.YFH.7.76.2006190916230.13242@cbobk.fhfr.pm>
References: <023148f582cc20bef7079508ce417c8ebeb0febb.camel@domanski.co>
User-Agent: Alpine 2.21 (LSU 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-2
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Kamil,

thanks a lot for your patch. I have a couple of comments, in addition to 
Felipe's review.

On Fri, 5 Jun 2020, Kamil Domañski wrote:

Changelog is missing here.

> Signed-off-by: Kamil Domañski <kamil@domanski.co>
> ---
>  drivers/hid/hid-logitech-hidpp.c | 200 ++++++++++++++++++++++++++++++-
>  1 file changed, 199 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/hid/hid-logitech-hidpp.c b/drivers/hid/hid-logitech-hidpp.c
> index 094f4f1b6555..b898ad4ceac5 100644
> --- a/drivers/hid/hid-logitech-hidpp.c
> +++ b/drivers/hid/hid-logitech-hidpp.c
> @@ -29,6 +29,7 @@
>  
>  MODULE_LICENSE("GPL");
>  MODULE_AUTHOR("Benjamin Tissoires <benjamin.tissoires@gmail.com>");
> +MODULE_AUTHOR("Kamil Domañski <kamil@domanski.co>");
>  MODULE_AUTHOR("Nestor Lopez Casado <nlopezcasad@logitech.com>");
>  
>  static bool disable_raw_mode;
> @@ -92,6 +93,7 @@ MODULE_PARM_DESC(disable_tap_to_click,
>  #define HIDPP_CAPABILITY_BATTERY_MILEAGE	BIT(2)
>  #define HIDPP_CAPABILITY_BATTERY_LEVEL_STATUS	BIT(3)
>  #define HIDPP_CAPABILITY_BATTERY_VOLTAGE	BIT(4)
> +#define HIDPP_CAPABILITY_ADC_MEASUREMENT	BIT(5)
>  
>  /*
>   * There are two hidpp protocols in use, the first version hidpp10 is known
> @@ -141,6 +143,7 @@ struct hidpp_battery {
>  	u8 feature_index;
>  	u8 solar_feature_index;
>  	u8 voltage_feature_index;
> +	u8 adc_measurement_feature_index;
>  	struct power_supply_desc desc;
>  	struct power_supply *ps;
>  	char name[64];
> @@ -215,6 +218,7 @@ struct hidpp_device {
>  #define HIDPP_ERROR_INVALID_PARAM_VALUE		0x0b
>  #define HIDPP_ERROR_WRONG_PIN_CODE		0x0c
>  /* HID++ 2.0 error codes */
> +#define HIDPP20_ERROR_DISCONNECTED	0x05
>  #define HIDPP20_ERROR				0xff
>  
>  static void hidpp_connect_event(struct hidpp_device *hidpp_dev);
> @@ -1378,6 +1382,184 @@ static int hidpp20_battery_voltage_event(struct hidpp_device *hidpp,
>  	return 0;
>  }
>  
> +/* -------------------------------------------------------------------------- */
> +/* 0x1F20: Analog-digital converter measurement                               */
> +/* -------------------------------------------------------------------------- */
> +
> +#define HIDPP_PAGE_ADC_MEASUREMENT 0x1F20
> +
> +#define CMD_ADC_MEASUREMENT_GET_VOLTAGE 0x01
> +
> +/**
> + * hidpp20_adc_map_status_voltage() - convert HID++ code to power supply status
> + * @hidpp: HID++ device struct.
> + * @data: ADC report data.
> + * @voltage: Pointer to variable where the ADC voltage shall be written.
> + *
> + * This function decodes the ADC voltage and charge status
> + * of the device's battery.
> + *
> + * Return: Returns the power supply charge status code.
> + */
> +static int hidpp20_adc_map_status_voltage(struct hidpp_device *hidpp,
> +						u8 data[3], int *voltage)
> +{
> +	bool isConnected;
> +	bool isCharging;
> +	bool chargingComplete;
> +	bool chargingFault;

We are not using CamelCase in the kernel. Could you please convert it to 
something that'd be in line with the kernel coding style, e.g. 
'is_connected', etc?

[ ... snip ... ]
>  static enum power_supply_property hidpp_battery_props[] = {
>  	POWER_SUPPLY_PROP_ONLINE,
>  	POWER_SUPPLY_PROP_STATUS,
> @@ -1426,6 +1608,11 @@ static int hidpp_battery_get_property(struct power_supply *psy,
>  			val->strval = hidpp->hid_dev->uniq;
>  			break;
>  		case POWER_SUPPLY_PROP_VOLTAGE_NOW:
> +			/* ADC feature doesn't automatically report the voltage
> +			   so we poll it explicitly when the property is read. */

Please use

	/*
	 * this style
	 * of multi-line comments
	 */


Thanks,

-- 
Jiri Kosina
SUSE Labs

