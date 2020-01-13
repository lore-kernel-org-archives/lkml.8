Return-Path: <SRS0=WByN=3C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73549C3F68F
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jan 2020 02:15:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 47F762187F
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jan 2020 02:15:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="fvY0DzsK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733103AbgAMCPU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 12 Jan 2020 21:15:20 -0500
Received: from hqnvemgate26.nvidia.com ([216.228.121.65]:11469 "EHLO
        hqnvemgate26.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732487AbgAMCPU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Jan 2020 21:15:20 -0500
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate26.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5e1bd2a20000>; Sun, 12 Jan 2020 18:14:58 -0800
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Sun, 12 Jan 2020 18:15:17 -0800
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Sun, 12 Jan 2020 18:15:17 -0800
Received: from [10.19.108.118] (10.124.1.5) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Mon, 13 Jan
 2020 02:15:15 +0000
Subject: Re: [PATCH v5 3/5] dt-bindings: phy: tegra: Add Tegra194 support
To:     Thierry Reding <thierry.reding@gmail.com>
CC:     Rob Herring <robh@kernel.org>, <gregkh@linuxfoundation.org>,
        <jonathanh@nvidia.com>, <kishon@ti.com>,
        <linux-tegra@vger.kernel.org>, <linux-usb@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <nkristam@nvidia.com>
References: <20200103081814.9848-1-jckuo@nvidia.com>
 <20200103081814.9848-4-jckuo@nvidia.com> <20200103223940.GA9205@bogus>
 <baa9b5f4-74be-0ab4-0b24-bf926cf3207c@nvidia.com>
 <4c3f3776-65e2-aafd-7bb9-fa69df301cb6@nvidia.com>
 <20200110112650.GB2233456@ulmo>
X-Nvconfidentiality: public
From:   JC Kuo <jckuo@nvidia.com>
Message-ID: <dc6853d2-2178-b781-6bc6-23e4ed38ccb2@nvidia.com>
Date:   Mon, 13 Jan 2020 10:15:09 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20200110112650.GB2233456@ulmo>
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL101.nvidia.com (172.20.187.10) To
 HQMAIL107.nvidia.com (172.20.187.13)
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1578881698; bh=VfhchbKgOZx7krVcK3EI9o3Udj7ufQOUyty7hnxpDjw=;
        h=X-PGP-Universal:Subject:To:CC:References:X-Nvconfidentiality:From:
         Message-ID:Date:User-Agent:MIME-Version:In-Reply-To:
         X-Originating-IP:X-ClientProxiedBy:Content-Type:Content-Language:
         Content-Transfer-Encoding;
        b=fvY0DzsKMOOEqRT5BycfN+QfhdLFNzZrPo4ySYR0Dbnu4h80Tb01qr+tiBDRMalQi
         8+5CTyvq2vvpIUb7a7vwsIfIDe9ceONUS7pE1eUr37N6pgggRi9rptcealfIXEs+RG
         HmPwIbNGtECrVx8GxcsdXRAm9TIpa7p/xVIq0j6H/4jySFoHoM7XjJ2x51zKgTRuxk
         KvU2SOtZLPEvUPC+VE4cMZ6OoaGsSb4hW6YkX9Vsrktgr6rw6w/+aJhdhAt93r4UVY
         9dFI3aHZX9gLn+yZVqVJ6dzLMm1GP5OiTdXRbBvzECRKf7Au8PlpwGmrq9ou+4wNwC
         HUj16VGTgMNJA==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/10/20 7:26 PM, Thierry Reding wrote:
> On Thu, Jan 09, 2020 at 09:31:27AM +0800, JC Kuo wrote:
>> Hi Rob,
>> For now we have two options.
>> 1. reusing the existing "maximum-speed" which is documented in usb/generic.txt
>> Pro: no need to add new property
>> Con: only "super-speed" and "super-speed-plus" are valid for Tegra XUSB PADCTL,
>> therefore extra code/document change is required.
>>
>> +	if (device_property_present(&port->dev, "maximum-speed")) {
>> +		maximum_speed =  usb_get_maximum_speed(&port->dev);
>> +		if (maximum_speed == USB_SPEED_SUPER)
>> +			usb3->disable_gen2 = true;
>> +		else if (maximum_speed == USB_SPEED_SUPER_PLUS)
>> +			usb3->disable_gen2 = false;
>> +		else
>> +			return -EINVAL;
>> +	}
>>
>> 2. introducing a new proprietary "nvidia,disable-gen2" property
>> Pro: its logic perfectly matches the need, and code change is minimum
>>
>> +        usb3->disable_gen2 = of_property_read_bool(np, "nvidia,disable-gen2");
>>
>> Con: it's a new and proprietary property.
>>
>> Please let me know which one do you prefer or there is something else
>> works better.
> 
> I think the first version is much clearer. maximum-speed = "super-speed"
> is very clear and explicit. nvidia,disable-gen2 is less so. While it may
> be true in this case what "disable-gen2" does, using the generic
> bindings has the advantage that it'll be more familiar to people already
> familiar with other USB device tree bindings.
> 
> Also, the nvidia,disable-gen2 property only perfectly matches the need
> because it reflects the name of the variable. If you rewrote the code to
> do something like this:
> 
> 	if (port->maximum_speed <= USB_SPEED_SUPER) {
> 		/* disable gen2 */
> 		...
> 	}

"low-speed/full-speed/high-speed/wireless" options are invalid to a usb3 port
because a usb3 port is not capable of operating at
low-/full-/high-speed/wireless protocols. Therefore,
maximum-speed="low-/full-/high-speed/wireless" is something more like completely
disabling the usb3 port than just disabling super-speed-plus.

I see using an existing "maximum-speed" is preferred. Please review code change
in v5 and let me know if anything could be improved further.

> 
> Then all of a sudden the "maximum-speed" property is a perfect match. In
> general, bindings should be natural to the domain of the bus or device
> that they describe rather than a reflection of how the driver programs
> the device's registers.
> 
> On a side-note: we should also update the usb/generic.txt binding to
> describe the "super-speed-plus" value for the maximum-speed property.
Yes, I feel the same. I will send a patch for it.

Thanks,
JC

> 
> Thierry
> 
>> Thanks,
>> JC
>>
>>
>> On 1/6/20 3:10 PM, JC Kuo wrote:
>>> On 1/4/20 6:39 AM, Rob Herring wrote:
>>>> On Fri, Jan 03, 2020 at 04:18:12PM +0800, JC Kuo wrote:
>>>>> Extend the bindings to cover the set of features found in Tegra194.
>>>>> Note that, technically, there are four more supplies connected to the
>>>>> XUSB pad controller (DVDD_PEX, DVDD_PEX_PLL, HVDD_PEX and HVDD_PEX_PLL)
>>>>> , but the power sequencing requirements of Tegra194 require these to be
>>>>> under the control of the PMIC.
>>>>>
>>>>> Tegra194 XUSB PADCTL supports up to USB 3.1 Gen 2 speed, however, it
>>>>> is possible for some platforms have long signal trace that could not
>>>>> provide sufficient electrical environment for Gen 2 speed. This patch
>>>>> adds a "maximum-speed" property to usb3 ports which can be used to
>>>>> specify the maximum supported speed for any particular USB 3.1 port.
>>>>> For a port that is not capable of SuperSpeedPlus, "maximum-speed"
>>>>> property should carry "super-speed".
>>>>>
>>>>> Signed-off-by: JC Kuo <jckuo@nvidia.com>
>>>>> ---
>>>>> Changes in v5:
>>>>> - re-use "maximum-speed" instead of adding "nvidia,disable-gen2"
>>>>> Changes in v4: none
>>>>> Changes in v3: none
>>>>> Changes in v2:
>>>>> - fix a typo
>>>>>
>>>>>  .../phy/nvidia,tegra124-xusb-padctl.txt        | 18 ++++++++++++++++++
>>>>>  1 file changed, 18 insertions(+)
>>>>>
>>>>> diff --git a/Documentation/devicetree/bindings/phy/nvidia,tegra124-xusb-padctl.txt b/Documentation/devicetree/bindings/phy/nvidia,tegra124-xusb-padctl.txt
>>>>> index 9fb682e47c29..7d0089006e67 100644
>>>>> --- a/Documentation/devicetree/bindings/phy/nvidia,tegra124-xusb-padctl.txt
>>>>> +++ b/Documentation/devicetree/bindings/phy/nvidia,tegra124-xusb-padctl.txt
>>>>> @@ -37,6 +37,7 @@ Required properties:
>>>>>    - Tegra132: "nvidia,tegra132-xusb-padctl", "nvidia,tegra124-xusb-padctl"
>>>>>    - Tegra210: "nvidia,tegra210-xusb-padctl"
>>>>>    - Tegra186: "nvidia,tegra186-xusb-padctl"
>>>>> +  - Tegra194: "nvidia,tegra194-xusb-padctl"
>>>>>  - reg: Physical base address and length of the controller's registers.
>>>>>  - resets: Must contain an entry for each entry in reset-names.
>>>>>  - reset-names: Must include the following entries:
>>>>> @@ -62,6 +63,10 @@ For Tegra186:
>>>>>  - vclamp-usb-supply: Bias rail for USB pad. Must supply 1.8 V.
>>>>>  - vddio-hsic-supply: HSIC PHY power supply. Must supply 1.2 V.
>>>>>  
>>>>> +For Tegra194:
>>>>> +- avdd-usb-supply: USB I/Os, VBUS, ID, REXT, D+/D- power supply. Must supply
>>>>> +  3.3 V.
>>>>> +- vclamp-usb-supply: Bias rail for USB pad. Must supply 1.8 V.
>>>>>  
>>>>>  Pad nodes:
>>>>>  ==========
>>>>> @@ -154,6 +159,11 @@ For Tegra210, the list of valid PHY nodes is given below:
>>>>>  - sata: sata-0
>>>>>    - functions: "usb3-ss", "sata"
>>>>>  
>>>>> +For Tegra194, the list of valid PHY nodes is given below:
>>>>> +- usb2: usb2-0, usb2-1, usb2-2, usb2-3
>>>>> +  - functions: "xusb"
>>>>> +- usb3: usb3-0, usb3-1, usb3-2, usb3-3
>>>>> +  - functions: "xusb"
>>>>>  
>>>>>  Port nodes:
>>>>>  ===========
>>>>> @@ -221,6 +231,11 @@ Optional properties:
>>>>>    is internal. In the absence of this property the port is considered to be
>>>>>    external.
>>>>>  
>>>>> +- maximum-speed: Only for Tegra194. A string property that specifies maximum
>>>>> +  supported speed of a usb3 port. Valid values are:
>>>>> +  - "super-speed-plus": default, the usb3 port supports USB 3.1 Gen 2 speed.
>>>>
>>>> Not defined as a valid value in usb/generic.txt. '-gen2' instead of 
>>>> '-plus' would be clearer IMO. However, is there any need to define the 
>>>> maximum speed possible? The purpose of this property is to limit the 
>>>> speed below the max.
>>>>
>>> usb_get_maximum_speed(), which parses "maximum-speed" property, indeed handles
>>> string "super-speed-plus". Should "super-speed-plus" be documented in
>>> usb/generic.txt"?
>>>
>>> static const char *const speed_names[] = {
>>> 	[USB_SPEED_UNKNOWN] = "UNKNOWN",
>>> 	[USB_SPEED_LOW] = "low-speed",
>>> 	[USB_SPEED_FULL] = "full-speed",
>>> 	[USB_SPEED_HIGH] = "high-speed",
>>> 	[USB_SPEED_WIRELESS] = "wireless",
>>> 	[USB_SPEED_SUPER] = "super-speed",
>>> 	[USB_SPEED_SUPER_PLUS] = "super-speed-plus",
>>> };
>>>
>>> A proprietary "nvidia,disable-gen2" property was proposed in earlier revision to
>>> "limit the speed below the max". I like it because it fit our needs better and
>>> requires only one line of code change.
>>>
>>>    usb3->disable_gen2 = of_property_read_bool(np, "nvidia,disable-gen2");
>>>
>>> Should I fallback to that approach?
>>>
>>> Thanks,
>>> JC
>>>
>>>>> +  - "super-speed": the usb3 port supports USB 3.1 Gen 1 speed only.
>>>>> +
>>>>>  For Tegra124 and Tegra132, the XUSB pad controller exposes the following
>>>>>  ports:
>>>>>  - 3x USB2: usb2-0, usb2-1, usb2-2
>>>>> @@ -233,6 +248,9 @@ For Tegra210, the XUSB pad controller exposes the following ports:
>>>>>  - 2x HSIC: hsic-0, hsic-1
>>>>>  - 4x super-speed USB: usb3-0, usb3-1, usb3-2, usb3-3
>>>>>  
>>>>> +For Tegra194, the XUSB pad controller exposes the following ports:
>>>>> +- 4x USB2: usb2-0, usb2-1, usb2-2, usb2-3
>>>>> +- 4x super-speed USB: usb3-0, usb3-1, usb3-2, usb3-3
>>>>>  
>>>>>  Examples:
>>>>>  =========
>>>>> -- 
>>>>> 2.17.1
>>>>>
