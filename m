Return-Path: <SRS0=xNW4=3S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50321C35240
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Jan 2020 09:13:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1F9C520716
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Jan 2020 09:13:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="MBAooP6z"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726252AbgA2JNc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Jan 2020 04:13:32 -0500
Received: from hqnvemgate24.nvidia.com ([216.228.121.143]:17471 "EHLO
        hqnvemgate24.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725951AbgA2JNc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jan 2020 04:13:32 -0500
Received: from hqpgpgate102.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate24.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5e314c880000>; Wed, 29 Jan 2020 01:12:40 -0800
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate102.nvidia.com (PGP Universal service);
  Wed, 29 Jan 2020 01:13:30 -0800
X-PGP-Universal: processed;
        by hqpgpgate102.nvidia.com on Wed, 29 Jan 2020 01:13:30 -0800
Received: from [10.19.66.205] (172.20.13.39) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Wed, 29 Jan
 2020 09:13:27 +0000
Subject: Re: [Patch V3 03/18] phy: tegra: xusb: Add usb-role-switch support
To:     Thierry Reding <thierry.reding@gmail.com>
CC:     <balbi@kernel.org>, <gregkh@linuxfoundation.org>,
        <jonathanh@nvidia.com>, <mark.rutland@arm.com>,
        <robh+dt@kernel.org>, <kishon@ti.com>,
        <devicetree@vger.kernel.org>, <linux-tegra@vger.kernel.org>,
        <linux-usb@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <1577704195-2535-1-git-send-email-nkristam@nvidia.com>
 <1577704195-2535-4-git-send-email-nkristam@nvidia.com>
 <20200128173244.GA2293590@ulmo>
X-Nvconfidentiality: public
From:   Nagarjuna Kristam <nkristam@nvidia.com>
Message-ID: <b6de0078-f1cd-31a1-70bd-dfc320eab70e@nvidia.com>
Date:   Wed, 29 Jan 2020 14:45:38 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20200128173244.GA2293590@ulmo>
X-Originating-IP: [172.20.13.39]
X-ClientProxiedBy: HQMAIL107.nvidia.com (172.20.187.13) To
 HQMAIL107.nvidia.com (172.20.187.13)
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1580289160; bh=AfKsN9drip9fGF1J0qLuc6MudsZ5rcBopOsTLJQmYOU=;
        h=X-PGP-Universal:Subject:To:CC:References:X-Nvconfidentiality:From:
         Message-ID:Date:User-Agent:MIME-Version:In-Reply-To:
         X-Originating-IP:X-ClientProxiedBy:Content-Type:Content-Language:
         Content-Transfer-Encoding;
        b=MBAooP6zorBL94Rw5yws9+pE/JuBQTCObfMRTLoCqHa7DkGpdPFUVTuyxJNMrl2Yn
         uNS7Ry4YpvrYeuh4Vtez6/SPp7MiOVe8GMHYaqMmNnhUptibVxL8XLaDTPUVSUepM+
         AmhQ0jo5hhnn+7fnT+I4soRC6ZpbeO9ZV0MUdGO04iVKOqpITv+LRl0JqvHk6JVXzm
         D66WU5Mtr+iC9LEgwd+GPB9RKWzvt275lKagF6mHDNM/8HCwOmK7EOXKatldBrWuoA
         iWfnXwllUpw96TA64d9dVETfJIVNZQp0nIEOtTNpmDWGUk6pz9SU2gUoMXyeAxXwTM
         tPZGwOIA1GCeQ==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 28-01-2020 23:02, Thierry Reding wrote:
> On Mon, Dec 30, 2019 at 04:39:40PM +0530, Nagarjuna Kristam wrote:
>> If usb-role-switch property is present in USB 2 port, register
>> usb-role-switch to receive usb role changes.
>>
>> Signed-off-by: Nagarjuna Kristam<nkristam@nvidia.com>
>> ---
>> V3:
>>   - Driver aborts if usb-role-switch is not added in dt forotg/peripheral
>>     roles.
>>   - Added role name strings instead of enum values in debug prints.
>>   - Updated arguments and variable allignments as per Thierry inputs.
>> ---
>> V2:
>>   - Removed dev_set_drvdata for port->dev.
>>   - Added of_platform_depopulate during error handling and driver removal.
>> ---
>>   drivers/phy/tegra/Kconfig |  1 +
>>   drivers/phy/tegra/xusb.c  | 57 +++++++++++++++++++++++++++++++++++++++++++++++
>>   drivers/phy/tegra/xusb.h  |  3 +++
>>   3 files changed, 61 insertions(+)
>>
>> diff --git a/drivers/phy/tegra/Kconfig b/drivers/phy/tegra/Kconfig
>> index f9817c3..df07c4d 100644
>> --- a/drivers/phy/tegra/Kconfig
>> +++ b/drivers/phy/tegra/Kconfig
>> @@ -2,6 +2,7 @@
>>   config PHY_TEGRA_XUSB
>>   	tristate "NVIDIA Tegra XUSB pad controller driver"
>>   	depends on ARCH_TEGRA
>> +	select USB_CONN_GPIO
>>   	help
>>   	  Choose this option if you have an NVIDIA Tegra SoC.
>>   
>> diff --git a/drivers/phy/tegra/xusb.c b/drivers/phy/tegra/xusb.c
>> index f98ec39..11ea9b5 100644
>> --- a/drivers/phy/tegra/xusb.c
>> +++ b/drivers/phy/tegra/xusb.c
>> @@ -523,6 +523,7 @@ static int tegra_xusb_port_init(struct tegra_xusb_port *port,
>>   	port->dev.type = &tegra_xusb_port_type;
>>   	port->dev.of_node = of_node_get(np);
>>   	port->dev.parent = padctl->dev;
>> +	port->dev.driver = padctl->dev->driver;
> This looks wrong. I don't think driver's are supposed to set this
> because it basically means that the device is being attached to the
> driver, but in this case it doesn't get probed by the driver and in
> fact the ports don't match the pad controller, so they can't really
> be driven by the same driver.
> 
> Is there any particular reason why you need this?
> 
> Thierry

Yes, port->dev.driver->owner is accessed in USB role switch driver in 
API usb_role_switch_get. If driver param is not updated, it causes NULL 
pointer exception. Based on your inputs, since this assignment is not 
supposed to used, I believe option available is to create a new 
device_driver structure and assign the same here.
Please share your thoughts.

- Nagarjuna
