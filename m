Return-Path: <SRS0=qsSF=76=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D716C433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jun 2020 00:11:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 20C9F207C4
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jun 2020 00:11:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726474AbgFQALC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Jun 2020 20:11:02 -0400
Received: from mga04.intel.com ([192.55.52.120]:12749 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725894AbgFQALC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Jun 2020 20:11:02 -0400
IronPort-SDR: HEl8dHQAngKmfV+LKbhSexzEQqUA0f4lvnddg8BLe17G/i3RcvBOU4Qm2pQzkEL7A1+y9IEFg0
 VYYodHQWG+mA==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jun 2020 17:11:00 -0700
IronPort-SDR: Ic1p5T8W1QCzSqe9lmhp5ybj+bZUIbIjZ3r0ByG7ZOe+wKHgC56m3Gv4aK2LaglZ4Rw+MX0jOE
 1+cgNNIwMOkg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,520,1583222400"; 
   d="scan'208";a="277101692"
Received: from linux.intel.com ([10.54.29.200])
  by orsmga006.jf.intel.com with ESMTP; 16 Jun 2020 17:11:00 -0700
Received: from [10.214.159.136] (unknown [10.214.159.136])
        by linux.intel.com (Postfix) with ESMTP id 8FE065800BD;
        Tue, 16 Jun 2020 17:10:57 -0700 (PDT)
Reply-To: vadivel.muruganx.ramuthevar@linux.intel.com
Subject: Re: [PATCH v3 2/2] usb: phy: Add USB3 PHY support for Intel LGM SoC
To:     Andy Shevchenko <andriy.shevchenko@intel.com>
Cc:     linux-kernel@vger.kernel.org, balbi@kernel.org, robh@kernel.org,
        p.zabel@pengutronix.de, gregkh@linuxfoundation.org,
        devicetree@vger.kernel.org, linux-usb@vger.kernel.org,
        cheol.yong.kim@intel.com, qi-ming.wu@intel.com, yin1.li@intel.com
References: <20200612025941.5484-1-vadivel.muruganx.ramuthevar@linux.intel.com>
 <20200612025941.5484-3-vadivel.muruganx.ramuthevar@linux.intel.com>
 <20200612131822.GG2428291@smile.fi.intel.com>
From:   "Ramuthevar, Vadivel MuruganX" 
        <vadivel.muruganx.ramuthevar@linux.intel.com>
Message-ID: <530dc44b-59d7-7ecd-4ec9-fd13f5f0e129@linux.intel.com>
Date:   Wed, 17 Jun 2020 08:10:55 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <20200612131822.GG2428291@smile.fi.intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andy,

Thank you very much for the review comments and your time...

On 12/6/2020 9:18 pm, Andy Shevchenko wrote:
> On Fri, Jun 12, 2020 at 10:59:41AM +0800, Ramuthevar,Vadivel MuruganX wrote:
>> From: Ramuthevar Vadivel Murugan <vadivel.muruganx.ramuthevar@linux.intel.com>
>>
>> Add support for USB PHY on Intel LGM SoC.
> 
> Thank you for an update, looks pretty much good, my comments below.
Sure, will update.
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
> 
>> +		dev_err(ta->phy.dev, "no polarity property from extcon\n");
> 
> (1)
Noted.
> 
>> +		return ret;
>> +	}
>> +
>> +	*flipped = property.intval;
>> +
>> +	return ret;
>> +}
> 
> ...
> 
>> +	ret = get_flipped(ta, &flipped);
>> +	if (ret)
>> +		dev_err(ta->phy.dev, "no polarity property from extcon\n");
> 
> You already has a message in (1). You should decide which one to leave.
> 
> But note, if it's a fatal error, you have to return here, otherwise, if you
> decide to leave message here, it should be not on error level.
Agreed!, let double and update as per your suggestion if it is fatal error.
> 
>> +	connected = extcon_get_state(ta->phy.edev, EXTCON_USB_HOST);
>> +	if (connected == ta->connected)
>> +		return;
>> +
>> +	ta->connected = connected;
>> +	if (connected) {
>> +		val = TCPC_VALID | FIELD_PREP(TCPC_MUX_CTL, MUX_USB);
>> +		if (flipped)
>> +			val |= TCPC_FLIPPED;
>> +		dev_info(ta->phy.dev, "connected%s\n", flipped ? " flipped" : "");
>> +	} else {
>> +		val = TCPC_DISCONN;
>> +		dev_info(ta->phy.dev, "disconnected\n");
>> +	}
>> +
>> +	writel(val, ta->phy.io_priv + TCPC_OFFSET);
>> +
> 
>> +	if (ta->phy.set_vbus(&ta->phy, connected))
>> +		dev_err(ta->phy.dev, "failed to set VBUS\n");
> 
> Please, split it to
> 	ret = ...;
Noted, will update.
> 	if (ret)
> 
>> +}
> 
> ...
> 
>> +static int vbus_notifier(struct notifier_block *nb,
>> +			 unsigned long event, void *ptr)
> 
> Consider to put it on one line (you can also shrink the names of unused
> parameters.
Sure, will try to reduce the length of the variable names.

Regards
Vadivel
> 
>> +{
>> +	return NOTIFY_DONE;
>> +}
> 
