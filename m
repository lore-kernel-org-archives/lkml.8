Return-Path: <SRS0=NqQd=7Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7BD6C433E1
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Jun 2020 08:36:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9448E20656
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Jun 2020 08:36:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726803AbgFKIgj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Jun 2020 04:36:39 -0400
Received: from mga01.intel.com ([192.55.52.88]:28034 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726560AbgFKIgi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Jun 2020 04:36:38 -0400
IronPort-SDR: lOKWR2sA++bVoHADnte08VIQl50LoRhATXUliGYK/7alKvJiJBymhptU+9JYr6qtZWpDCQqzS+
 OGtdAtUPJROQ==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jun 2020 01:36:38 -0700
IronPort-SDR: HRmqmbzRLw8/f2rQQukq4hhYhkyAW6AAnCu6i+38YfyYkbtaL1vbq0s5e6LxjNOenQqT8pLdBk
 nPRcJVHMlrUA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,499,1583222400"; 
   d="scan'208";a="271520565"
Received: from linux.intel.com ([10.54.29.200])
  by orsmga003.jf.intel.com with ESMTP; 11 Jun 2020 01:36:38 -0700
Received: from [10.214.154.243] (vramuthx-mobl1.gar.corp.intel.com [10.214.154.243])
        by linux.intel.com (Postfix) with ESMTP id 9056E580458;
        Thu, 11 Jun 2020 01:36:33 -0700 (PDT)
Reply-To: vadivel.muruganx.ramuthevar@linux.intel.com
Subject: Re: [PATCH v2 2/2] usb: phy: Add USB3 PHY support for Intel LGM SoC
To:     Andy Shevchenko <andriy.shevchenko@intel.com>
Cc:     linux-kernel@vger.kernel.org, balbi@kernel.org,
        p.zabel@pengutronix.de, gregkh@linuxfoundation.org,
        robh@kernel.org, devicetree@vger.kernel.org,
        linux-usb@vger.kernel.org, cheol.yong.kim@intel.com,
        qi-ming.wu@intel.com, yin1.li@intel.com
References: <20200611021246.3250-1-vadivel.muruganx.ramuthevar@linux.intel.com>
 <20200611021246.3250-3-vadivel.muruganx.ramuthevar@linux.intel.com>
 <20200611081254.GR2428291@smile.fi.intel.com>
From:   "Ramuthevar, Vadivel MuruganX" 
        <vadivel.muruganx.ramuthevar@linux.intel.com>
Message-ID: <21b5db0e-c45a-2255-0389-04b204685d63@linux.intel.com>
Date:   Thu, 11 Jun 2020 16:36:29 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.1
MIME-Version: 1.0
In-Reply-To: <20200611081254.GR2428291@smile.fi.intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andy,

Thank you so much for the review comments...

On 11/6/2020 4:12 pm, Andy Shevchenko wrote:
> On Thu, Jun 11, 2020 at 10:12:46AM +0800, Ramuthevar,Vadivel MuruganX wrote:
>> From: Ramuthevar Vadivel Murugan <vadivel.muruganx.ramuthevar@linux.intel.com>
>>
>> Add support for USB PHY on Intel LGM SoC.
> 
> ...
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
> 
>> +		return false;
> 
> return ret;
Noted.
> 
>> +	}
>> +
>> +	*flipped = property.intval;
>> +
> 
>> +	return *flipped;
> 
> return 0;
Noted.
> 
>> +}
> 
> ...I suppose it should be as above.
> 
> ...
> 
>> +	ret = readl_poll_timeout(ctrl1, val, val & SRAM_INIT_DONE,
>> +				 10, 10 * 1000);
exceeds more than 80 characters, so checkpatch throws warnings, to avoid 
that move to next line.
> 
> On one line easier to read.
> 
>> +	if (ret) {
>> +		dev_err(ta->phy.dev, "SRAM init failed, 0x%x\n", val);
>> +		return ret;
>> +	}
> 
> ...
> 
>> +static int phy_set_vbus(struct usb_phy *phy, int on)
>> +{
>> +	struct tca_apb *ta = container_of(phy, struct tca_apb, phy);
> 
>> +	int ret = 0;
> 
> Assignment is redundant.
so you mean , should be declared as
int ret;
right?

> 
>> +
>> +	if (on) {
>> +		ret = regulator_enable(ta->vbus);
>> +		if (ret)
>> +			dev_err(ta->phy.dev, "regulator not enabled\n");
>> +	} else {
>> +		ret = regulator_disable(ta->vbus);
>> +		if (ret)
>> +			dev_err(ta->phy.dev, "regulator not disabled\n");
>> +	}
>> +
>> +	return ret;
>> +}
> 
> ...
> 
>> +	ret = get_flipped(ta, &flipped);
>> +	if (!ret)
>> +		dev_err(ta->phy.dev, "no polarity property from extcon\n");
> 
> This should be fixed accordingly.
Noted.
> 
> ...
> 
>> +		dev_info(ta->phy.dev, "connected%s\n",
>> +			 flipped ? " flipped" : "");
> 
> One line.
exceeds more than 80 characters, so checkpatch throw warnings, to avoid 
that moved to next line.

Regards
Vadivel
> 
