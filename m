Return-Path: <SRS0=OCv1=CF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44E7BC433E1
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Aug 2020 09:36:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1B33E207CD
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Aug 2020 09:36:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="wTHDnESg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728380AbgH0Jg6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Aug 2020 05:36:58 -0400
Received: from fllv0016.ext.ti.com ([198.47.19.142]:56550 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726882AbgH0Jgz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Aug 2020 05:36:55 -0400
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 07R9anEk086876;
        Thu, 27 Aug 2020 04:36:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1598521009;
        bh=gq9PsmCr2b2hlhGa81Jfhi1VEMeq5fSGg/TFRp1g5+s=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=wTHDnESgv8vwzPcqsnOtcCasnTKXCPJAI3NJcewfw9MGKGMOlRbbxG2O6LP/eaG72
         VkbzNEdZFV3qhtZCkBM9D+XH2n90HzW+oeNQr5vNhqmG9JrIpQCzlUlaZojzjHdOw7
         HVrqw9J/VShiR6RnYhV0t/EWNGpnev0rcp0DMjQU=
Received: from DFLE114.ent.ti.com (dfle114.ent.ti.com [10.64.6.35])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 07R9an7A111323
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 27 Aug 2020 04:36:49 -0500
Received: from DFLE106.ent.ti.com (10.64.6.27) by DFLE114.ent.ti.com
 (10.64.6.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Thu, 27
 Aug 2020 04:36:49 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DFLE106.ent.ti.com
 (10.64.6.27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Thu, 27 Aug 2020 04:36:48 -0500
Received: from [192.168.2.14] (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 07R9ak6O018513;
        Thu, 27 Aug 2020 04:36:47 -0500
Subject: Re: [PATCH 3/3] usb: cdns3: Enable workaround for USB2.0 PHY Rx
 compliance test PHY lockup
To:     Peter Chen <peter.chen@nxp.com>
CC:     Pawel Laszczak <pawell@cadence.com>,
        "balbi@kernel.org" <balbi@kernel.org>,
        Rahul Kumar <kurahul@cadence.com>,
        "nsekhar@ti.com" <nsekhar@ti.com>,
        "vigneshr@ti.com" <vigneshr@ti.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
References: <20200825120059.12436-1-rogerq@ti.com>
 <20200825120059.12436-4-rogerq@ti.com> <20200826031948.GA7646@b29397-desktop>
 <DM6PR07MB5529A43AFDEB25993595DB59DD540@DM6PR07MB5529.namprd07.prod.outlook.com>
 <20200826071504.GA19661@b29397-desktop>
 <DM6PR07MB5529EB2FB7E3380321191B44DD540@DM6PR07MB5529.namprd07.prod.outlook.com>
 <AM7PR04MB71576DF6C03387C7628DBE3A8B540@AM7PR04MB7157.eurprd04.prod.outlook.com>
 <ab38721a-ef48-c6a7-aa33-3085ca7b8852@ti.com>
 <20200827002339.GA17559@b29397-desktop>
From:   Roger Quadros <rogerq@ti.com>
Message-ID: <b083883d-b8c3-ee16-6b02-8987cade17ed@ti.com>
Date:   Thu, 27 Aug 2020 12:36:46 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200827002339.GA17559@b29397-desktop>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 27/08/2020 03:24, Peter Chen wrote:
> On 20-08-26 15:49:57, Roger Quadros wrote:
>> Peter,
>>
>> On 26/08/2020 11:07, Peter Chen wrote:
>>>>
>>>>
>>>>>
>>>>> On 20-08-26 04:04:01, Pawel Laszczak wrote:
>>>>>>> On 20-08-25 15:00:59, Roger Quadros wrote:
>>>>>>>> From: Pawel Laszczak <pawell@cadence.com>
>>>>>>>>
>>>>>>>> USB2.0 PHY hangs in Rx Compliance test when the incoming packet
>>>>>>>> amplitude is varied below and above the Squelch Level of Receiver
>>>>>>>> during the active packet multiple times.
>>>>>>>>
>>>>>>>> Version 1 of the controller allows PHY to be reset when RX fail
>>>>>>>> condition is detected to work around the above issue. This feature
>>>>>>>> is disabled by default and needs to be enabled using a bit from
>>>>>>>> the newly added PHYRST_CFG register. This patch enables the workaround.
>>>>>>>>
>>>>>>>> As there is no way to distinguish between the controller version
>>>>>>>> before the device controller is started we need to rely on a DT
>>>>>>>> property to decide when to apply the workaround.
>>>>>>>
>>>>>>> Pawel, it could know the controller version at cdns3_gadget_start,
>>>>>>> but the controller starts when it tries to bind gadget driver, at
>>>>>>> that time, it has already known the controller version.
>>>>>>>
>>>>>>> For me, the device controller starts is using USB_CONF.DEVEN (Device
>>>>>>> Enable) through usb_gadget_connect, I am not sure if it is the same
>>>>>>> with yours.
>>>>>>>
>>>>>>
>>>>>> Yes in device mode driver knows controller version but this
>>>>>> workaround Must be enabled also in host mode. In host mode the
>>>>>> controller doesn't have access to device registers. The controller
>>>>>> version is placed in device register.
>>>>>>
>>>>>
>>>>> You may suggest your design team adding CHIP_VER register at global
>>>>> register region, it will easy the software engineer life.
>>>>>
>>>> >From what I read, this register is only enabling USB2 PHY reset
>>>>> software control, it needs for all chips with rev 0x0002450D, and the
>>>>> place you current change is only for 0x0002450D, right?
>>>>
>>>> Even I could say that this workaround should be enabled only for Specific USB2
>>>> PHY  (only 0x0002450D)
>>>>
>>>> This bit should not have any impact for Cadence PHY but it can has Impact for third
>>>> party PHYs.
>>>>
>>>
>>> So, it is related to specific PHY, but enable this specific PHY reset bit is at controller region, why don't
>>> put this enable bit at PHY region?
>>
>> I think this is related to Controller + PHY combination.
>> The fix for the issue is via a bit in the controller, so it needs to be managed by the
>> controller driver.
>>
>>>
>>> So, you use controller's device property to know this specific PHY, can controller know this specific
>>> PHY dynamically?
>>
>> Still the PHY will have to tell the controller the enable that bit. How to do that?
>>
>> Adding a dt-property that vendors can used was the simplest option.
>>
> 
> Ok, does all controllers with ver 0x0002450D need this fix? I just think
> if we introduce a flag stands for ver 0x0002450D in case this ver has
> other issues in future or just using phy reset enable property?
> 
> Pawel & Roger, what's your opinion?
> 
I think it is best to keep the flags specific to the issue rather than a one flag for
all issues with a specific version. This way you can re-use the flag irrespective
of IP version.

But best case is that Cadence put a IP revision register in common area as you
have previously suggested so driver can automatically apply quirks to specific
versions.

cheers,
-roger
-- 
Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
