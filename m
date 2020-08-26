Return-Path: <SRS0=kGB5=CE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45C8BC433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Aug 2020 12:50:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 19D0B20FC3
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Aug 2020 12:50:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="Hv9fmGyT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730030AbgHZMuR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Aug 2020 08:50:17 -0400
Received: from lelv0142.ext.ti.com ([198.47.23.249]:54982 "EHLO
        lelv0142.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730012AbgHZMuI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Aug 2020 08:50:08 -0400
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 07QCo19P076319;
        Wed, 26 Aug 2020 07:50:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1598446201;
        bh=WvxWI+ShvmWioWD0ODRxCYOaU0Q35AJSaFjxm1zMZi4=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=Hv9fmGyTDi0DeK+yiYxtDM19z4fIDMx41BEchLg7B6aXiUnUs7mJwa0EjYo/mp2pW
         ARE0X+3Pk52+W7fvqJqS+KkNiTz8YpUS74BzLc4TBT7/Pjf2YW9WmAMHYUbwKJjPm0
         +X0VVJPpLBcWAr0m9J1nxFaX86kKlKhRxdNB7qVU=
Received: from DLEE112.ent.ti.com (dlee112.ent.ti.com [157.170.170.23])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 07QCo1x1097504
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 26 Aug 2020 07:50:01 -0500
Received: from DLEE109.ent.ti.com (157.170.170.41) by DLEE112.ent.ti.com
 (157.170.170.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Wed, 26
 Aug 2020 07:50:00 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DLEE109.ent.ti.com
 (157.170.170.41) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Wed, 26 Aug 2020 07:50:00 -0500
Received: from [192.168.2.14] (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 07QCnwtY026098;
        Wed, 26 Aug 2020 07:49:58 -0500
Subject: Re: [PATCH 3/3] usb: cdns3: Enable workaround for USB2.0 PHY Rx
 compliance test PHY lockup
To:     Peter Chen <peter.chen@nxp.com>,
        Pawel Laszczak <pawell@cadence.com>
CC:     "balbi@kernel.org" <balbi@kernel.org>,
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
From:   Roger Quadros <rogerq@ti.com>
Message-ID: <ab38721a-ef48-c6a7-aa33-3085ca7b8852@ti.com>
Date:   Wed, 26 Aug 2020 15:49:57 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <AM7PR04MB71576DF6C03387C7628DBE3A8B540@AM7PR04MB7157.eurprd04.prod.outlook.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Peter,

On 26/08/2020 11:07, Peter Chen wrote:
>   
>>
>>
>>>
>>> On 20-08-26 04:04:01, Pawel Laszczak wrote:
>>>>> On 20-08-25 15:00:59, Roger Quadros wrote:
>>>>>> From: Pawel Laszczak <pawell@cadence.com>
>>>>>>
>>>>>> USB2.0 PHY hangs in Rx Compliance test when the incoming packet
>>>>>> amplitude is varied below and above the Squelch Level of Receiver
>>>>>> during the active packet multiple times.
>>>>>>
>>>>>> Version 1 of the controller allows PHY to be reset when RX fail
>>>>>> condition is detected to work around the above issue. This feature
>>>>>> is disabled by default and needs to be enabled using a bit from
>>>>>> the newly added PHYRST_CFG register. This patch enables the workaround.
>>>>>>
>>>>>> As there is no way to distinguish between the controller version
>>>>>> before the device controller is started we need to rely on a DT
>>>>>> property to decide when to apply the workaround.
>>>>>
>>>>> Pawel, it could know the controller version at cdns3_gadget_start,
>>>>> but the controller starts when it tries to bind gadget driver, at
>>>>> that time, it has already known the controller version.
>>>>>
>>>>> For me, the device controller starts is using USB_CONF.DEVEN (Device
>>>>> Enable) through usb_gadget_connect, I am not sure if it is the same
>>>>> with yours.
>>>>>
>>>>
>>>> Yes in device mode driver knows controller version but this
>>>> workaround Must be enabled also in host mode. In host mode the
>>>> controller doesn't have access to device registers. The controller
>>>> version is placed in device register.
>>>>
>>>
>>> You may suggest your design team adding CHIP_VER register at global
>>> register region, it will easy the software engineer life.
>>>
>> >From what I read, this register is only enabling USB2 PHY reset
>>> software control, it needs for all chips with rev 0x0002450D, and the
>>> place you current change is only for 0x0002450D, right?
>>
>> Even I could say that this workaround should be enabled only for Specific USB2
>> PHY  (only 0x0002450D)
>>
>> This bit should not have any impact for Cadence PHY but it can has Impact for third
>> party PHYs.
>>
> 
> So, it is related to specific PHY, but enable this specific PHY reset bit is at controller region, why don't
> put this enable bit at PHY region?

I think this is related to Controller + PHY combination.
The fix for the issue is via a bit in the controller, so it needs to be managed by the
controller driver.

> 
> So, you use controller's device property to know this specific PHY, can controller know this specific
> PHY dynamically?

Still the PHY will have to tell the controller the enable that bit. How to do that?

Adding a dt-property that vendors can used was the simplest option.

cheers,
-roger

> 
> Peter
> 
>> Pawel
>>
>>>
>>> Peter
>>>
>>>> Pawel
>>>>
>>>>> Peter
>>>>>
>>>>>
>>>>>>
>>>>>> Signed-off-by: Pawel Laszczak <pawell@cadence.com>
>>>>>> Signed-off-by: Roger Quadros <rogerq@ti.com>
>>>>>> ---
>>>>>>   drivers/usb/cdns3/core.c |  2 ++
>>>>>>   drivers/usb/cdns3/core.h |  1 +
>>>>>>   drivers/usb/cdns3/drd.c  | 12 ++++++++++++
>>>>>> drivers/usb/cdns3/drd.h  |  5 ++++-
>>>>>>   4 files changed, 19 insertions(+), 1 deletion(-)
>>>>>>
>>>>>> diff --git a/drivers/usb/cdns3/core.c b/drivers/usb/cdns3/core.c
>>>>>> index 5c1586ec7824..34b36487682b 100644
>>>>>> --- a/drivers/usb/cdns3/core.c
>>>>>> +++ b/drivers/usb/cdns3/core.c
>>>>>> @@ -443,6 +443,8 @@ static int cdns3_probe(struct platform_device *pdev)
>>>>>>   		return -ENXIO;
>>>>>>   	}
>>>>>>
>>>>>> +	cdns->phyrst_a_enable = device_property_read_bool(dev,
>>>>>> +"cdns,phyrst-a-enable");
>>>>>> +
>>>>>>   	cdns->otg_res = *res;
>>>>>>
>>>>>>   	mutex_init(&cdns->mutex);
>>>>>> diff --git a/drivers/usb/cdns3/core.h b/drivers/usb/cdns3/core.h
>>>>>> index 1ad1f1fe61e9..24cf0f1b5726 100644
>>>>>> --- a/drivers/usb/cdns3/core.h
>>>>>> +++ b/drivers/usb/cdns3/core.h
>>>>>> @@ -76,6 +76,7 @@ struct cdns3 {
>>>>>>   #define CDNS3_CONTROLLER_V0	0
>>>>>>   #define CDNS3_CONTROLLER_V1	1
>>>>>>   	u32				version;
>>>>>> +	bool				phyrst_a_enable;
>>>>>>
>>>>>>   	int				otg_irq;
>>>>>>   	int				dev_irq;
>>>>>> diff --git a/drivers/usb/cdns3/drd.c b/drivers/usb/cdns3/drd.c
>>>>>> index 6234bcd6158a..b74803e9703d 100644
>>>>>> --- a/drivers/usb/cdns3/drd.c
>>>>>> +++ b/drivers/usb/cdns3/drd.c
>>>>>> @@ -42,6 +42,18 @@ int cdns3_set_mode(struct cdns3 *cdns, enum
>> usb_dr_mode mode)
>>>>>>   			reg = readl(&cdns->otg_v1_regs->override);
>>>>>>   			reg |= OVERRIDE_IDPULLUP;
>>>>>>   			writel(reg, &cdns->otg_v1_regs->override);
>>>>>> +
>>>>>> +			/*
>>>>>> +			 * Enable work around feature built into the
>>>>>> +			 * controller to address issue with RX Sensitivity
>>>>>> +			 * est (EL_17) for USB2 PHY. The issue only occures
>>>>>> +			 * for 0x0002450D controller version.
>>>>>> +			 */
>>>>>> +			if (cdns->phyrst_a_enable) {
>>>>>> +				reg = readl(&cdns->otg_v1_regs->phyrst_cfg);
>>>>>> +				reg |= PHYRST_CFG_PHYRST_A_ENABLE;
>>>>>> +				writel(reg, &cdns->otg_v1_regs->phyrst_cfg);
>>>>>> +			}
>>>>>>   		} else {
>>>>>>   			reg = readl(&cdns->otg_v0_regs->ctrl1);
>>>>>>   			reg |= OVERRIDE_IDPULLUP_V0;
>>>>>> diff --git a/drivers/usb/cdns3/drd.h b/drivers/usb/cdns3/drd.h
>>>>>> index 7e7cf7fa2dd3..f1ccae285a16 100644
>>>>>> --- a/drivers/usb/cdns3/drd.h
>>>>>> +++ b/drivers/usb/cdns3/drd.h
>>>>>> @@ -31,7 +31,7 @@ struct cdns3_otg_regs {
>>>>>>   	__le32 simulate;
>>>>>>   	__le32 override;
>>>>>>   	__le32 susp_ctrl;
>>>>>> -	__le32 reserved4;
>>>>>> +	__le32 phyrst_cfg;
>>>>>>   	__le32 anasts;
>>>>>>   	__le32 adp_ramp_time;
>>>>>>   	__le32 ctrl1;
>>>>>> @@ -153,6 +153,9 @@ struct cdns3_otg_common_regs {
>>>>>>   /* Only for CDNS3_CONTROLLER_V0 version */
>>>>>>   #define OVERRIDE_IDPULLUP_V0		BIT(24)
>>>>>>
>>>>>> +/* PHYRST_CFG - bitmasks */
>>>>>> +#define PHYRST_CFG_PHYRST_A_ENABLE     BIT(0)
>>>>>> +
>>>>>>   #define CDNS3_ID_PERIPHERAL		1
>>>>>>   #define CDNS3_ID_HOST			0
>>>>>>
>>>>>> --
>>>>>> Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
>>>>>> Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
>>>>>>
>>>>>
>>>>> --
>>>>>
>>>>> Thanks,
>>>>> Peter Chen
>>>
>>> --
>>>
>>> Thanks,
>>> Peter Chen

-- 
Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
