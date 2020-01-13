Return-Path: <SRS0=WByN=3C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD60DC33CB0
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jan 2020 04:35:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8D9AD21556
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jan 2020 04:35:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="WsBWMEtE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387605AbgAMEfN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 12 Jan 2020 23:35:13 -0500
Received: from hqnvemgate24.nvidia.com ([216.228.121.143]:10958 "EHLO
        hqnvemgate24.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387474AbgAMEfN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Jan 2020 23:35:13 -0500
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate24.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5e1bf34a0000>; Sun, 12 Jan 2020 20:34:18 -0800
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Sun, 12 Jan 2020 20:35:11 -0800
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Sun, 12 Jan 2020 20:35:11 -0800
Received: from [10.24.192.96] (10.124.1.5) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Mon, 13 Jan
 2020 04:35:08 +0000
Subject: Re: [Patch V2 01/18] dt-bindings: phy: tegra-xusb: Add
 usb-role-switch
To:     Thierry Reding <thierry.reding@gmail.com>,
        JC Kuo <jckuo@nvidia.com>
CC:     <balbi@kernel.org>, <gregkh@linuxfoundation.org>,
        <jonathanh@nvidia.com>, <mark.rutland@arm.com>,
        <robh+dt@kernel.org>, <kishon@ti.com>,
        <devicetree@vger.kernel.org>, <linux-tegra@vger.kernel.org>,
        <linux-usb@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <1576660591-10383-1-git-send-email-nkristam@nvidia.com>
 <1576660591-10383-2-git-send-email-nkristam@nvidia.com>
 <20191219130503.GG1440537@ulmo>
 <fe47fd52-efd0-4f84-d1e4-4bce5571e425@nvidia.com>
 <20200110111633.GA2233456@ulmo>
From:   Nagarjuna Kristam <nkristam@nvidia.com>
X-Nvconfidentiality: public
Message-ID: <6eb31a50-472f-439c-3bc7-bcad1c0c9ff4@nvidia.com>
Date:   Mon, 13 Jan 2020 10:07:08 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20200110111633.GA2233456@ulmo>
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL101.nvidia.com (172.20.187.10) To
 HQMAIL107.nvidia.com (172.20.187.13)
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1578890059; bh=ahbQ/S5bwZQeCgRAcPe/SQefbnQj07L0nfH3z9X6qrM=;
        h=X-PGP-Universal:Subject:To:CC:References:From:X-Nvconfidentiality:
         Message-ID:Date:User-Agent:MIME-Version:In-Reply-To:
         X-Originating-IP:X-ClientProxiedBy:Content-Type:Content-Language:
         Content-Transfer-Encoding;
        b=WsBWMEtE/xX7NnovBHwpO5f+SsTyMwTUbTO/0ZVBxMKV0xml5+ColYwaizFRHh0nG
         +iSFNveIIGtet5fYoTGkIsFZi0agHepKyqkmKIoSrMeizWqvkmNM4E2cHRCr7K6OYI
         +yIHx50VhHSOUF4XG57nB5rXSTFGJEHV79FgjueqJ8gsVOOjQuWHmjt1BiDtshbRi9
         FdmIFcL7bGobL9mGT0Dc8kU8QdyBGg/8Z3RIRmJWMr/wzFNNpMQLGstfZ34vR0ulpi
         VDHz7zmbIoS3EkEWO/ij8TMwWAAMTg10V71+MU/rZfwUUHldWrEbqLuPxgKcbV6h8r
         RP76q+O5e/Xwg==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 10-01-2020 16:46, Thierry Reding wrote:
> On Fri, Dec 20, 2019 at 04:08:30PM +0800, JC Kuo wrote:
>> On 12/19/19 9:05 PM, Thierry Reding wrote:
>>> On Wed, Dec 18, 2019 at 02:46:14PM +0530, Nagarjuna Kristam wrote:
>>>> Add usb-role-switch property for Tegra210 and Tegra186 platforms. This
>>>> entry is used by XUSB pad controller driver to register for role changes
>>>> for OTG/Peripheral capable USB 2 ports.
>>>>
>>>> Signed-off-by: Nagarjuna Kristam<nkristam@nvidia.com>
>>>> ---
>>>> V2:
>>>>   - Moved usb-role-switch to seperate Required section as suggested by Thierry.
>>>>   - Added reference to usb/usb-conn-gpio.txt for connector subnode.
>>>> ---
>>>>   .../devicetree/bindings/phy/nvidia,tegra124-xusb-padctl.txt         | 6 ++++++
>>>>   1 file changed, 6 insertions(+)
>>>>
>>>> diff --git a/Documentation/devicetree/bindings/phy/nvidia,tegra124-xusb-padctl.txt b/Documentation/devicetree/bindings/phy/nvidia,tegra124-xusb-padctl.txt
>>>> index 9fb682e..23bf354 100644
>>>> --- a/Documentation/devicetree/bindings/phy/nvidia,tegra124-xusb-padctl.txt
>>>> +++ b/Documentation/devicetree/bindings/phy/nvidia,tegra124-xusb-padctl.txt
>>>> @@ -174,6 +174,12 @@ Required properties:
>>>>     - "device": for USB device mode
>>>>     - "otg": for USB OTG mode
>>>>   
>>>> +Required properties for OTG/Peripheral capable USB2 ports:
>>>> +- usb-role-switch: Boolean property to indicate that the port support OTG or
>>> "supports", and also, why if it supports OTG*or*  peripheral? Doesn't
>>> OTG imply peripheral? OTG means it can be either peripheral or host,
>>> right? So I think the end of that sentence can be just:
>>>
>>> 	"... the port supports OTG."
>> An USB OTG port is capable of both USB host and peripheral operations. An USB
>> peripheral port can only act as an USB peripheral.
>>
>> The micro USB ports found on Jetson TX1/TX2 platforms are micro-AB ports which
>> should implement both host and peripheral capabilities. We say such ports
>> support OTG. The micro USB port found on Jetson Nano is a micro-B port which
>> should implement peripheral capability only. We say such ports support
>> peripheral, rather than OTG.
> I the port supports only peripheral mode, why do we need to have a
> usb-role-switch property? Shouldn't we in that case have a mode property
> with value "device"?
> 
> usb-mode-switch is only needed if mode = "otg", isn't it? In all other
> cases the functionality is fixed (either host or peripheral) and the
> mode cannot be switched.
> 
> Thierry

usb-role-switch is needed when mode == "otg" or "peripheral".

Device mode is detected via vbus GPIO irrespective of mode being 
peripheral only or OTG.
Host mode is detected via id-gpio, in OTG case.

When mode is peripheral, role changes happens between USB_ROLE_DEVICE 
and USB_ROLE_NONE, which are generally based on Vbus GPIO(hot plug) 
detection.

When mode is otg, role changes happens between USB_ROLE_HOST, 
USB_ROLE_DEVICE and USB_ROLE_NONE, which are detected via id-gpio, 
vbus-gpio and no detection respectively.

-Nagarjuna
