Return-Path: <SRS0=/IhT=AT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07EB5C433E1
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jul 2020 16:00:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D523A20672
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jul 2020 16:00:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=st.com header.i=@st.com header.b="oqmo0akG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730569AbgGHQAh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Jul 2020 12:00:37 -0400
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:7228 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1730179AbgGHQAf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jul 2020 12:00:35 -0400
Received: from pps.filterd (m0046660.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 068G0Fvg007327;
        Wed, 8 Jul 2020 18:00:16 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=st.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=STMicroelectronics;
 bh=SG00orgNi5qahqGwC4U9KWpO6xjL5yxam6QNkjvK9NQ=;
 b=oqmo0akGAzF7/w5hPqTQrfCmlNV0xosKr5Nu5gKVI6AS9MNCNR5s/+nbVMQshBcjfGZc
 87MZ1NV8lLKnhE3+cnwGBMxD/6vJWWWBDvy4K/G0XdN8mWFDT974QteHIn8G+qBwormI
 +UL+3RPNJ09eNVWpAWi1J29JJkWLgYhGULvZRTHRUMoxCnkmG7Z3tVVNSdprHm+HxrRx
 iOlJYBaxN5NsRvU5GQmtYNTDw2rKPJS88P8YJEjch7vz8nGuoVbkFiENYfr4+E90mA/n
 CvEjeIFdgigh7Q8jEDqYLLGOuei4a3JpyNnPBCXOqL/2Yk2auWPGivc8U9fRGzbn2nMI Hg== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 322ew9gngq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 08 Jul 2020 18:00:16 +0200
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 3D31E100034;
        Wed,  8 Jul 2020 18:00:08 +0200 (CEST)
Received: from Webmail-eu.st.com (sfhdag3node2.st.com [10.75.127.8])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 219BA2C7A63;
        Wed,  8 Jul 2020 18:00:08 +0200 (CEST)
Received: from lmecxl0995.lme.st.com (10.75.127.44) by SFHDAG3NODE2.st.com
 (10.75.127.8) with Microsoft SMTP Server (TLS) id 15.0.1347.2; Wed, 8 Jul
 2020 18:00:07 +0200
Subject: Re: [PATCH 1/3] usb: dwc2: override PHY input signals with usb role
 switch support
To:     Martin Blumenstingl <martin.blumenstingl@googlemail.com>
CC:     Alexandre TORGUE <alexandre.torgue@st.com>,
        "balbi@kernel.org" <balbi@kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        Fabrice GASNIER <fabrice.gasnier@st.com>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "hminas@synopsys.com" <hminas@synopsys.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-stm32@st-md-mailman.stormreply.com" 
        <linux-stm32@st-md-mailman.stormreply.com>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "mcoquelin.stm32@gmail.com" <mcoquelin.stm32@gmail.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>
References: <20200616140717.28465-2-amelie.delaunay@st.com>
 <20200704174219.612060-1-martin.blumenstingl@googlemail.com>
 <05a81997-5ddb-ea81-7a89-8078b8a2b610@st.com>
 <CAFBinCCVYJ=DuKbqhJJ8463Gs+GW0bgxyXSFiLXhUfvWV6AR0Q@mail.gmail.com>
From:   Amelie DELAUNAY <amelie.delaunay@st.com>
Message-ID: <ee4ee889-835e-2244-504c-2b1b605d78aa@st.com>
Date:   Wed, 8 Jul 2020 18:00:07 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <CAFBinCCVYJ=DuKbqhJJ8463Gs+GW0bgxyXSFiLXhUfvWV6AR0Q@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.75.127.44]
X-ClientProxiedBy: SFHDAG5NODE1.st.com (10.75.127.13) To SFHDAG3NODE2.st.com
 (10.75.127.8)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-07-08_13:2020-07-08,2020-07-08 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Martin,

On 7/7/20 8:55 PM, Martin Blumenstingl wrote:
> Hi Amelie,
> 
> On Tue, Jul 7, 2020 at 6:13 PM Amelie DELAUNAY <amelie.delaunay@st.com> wrote:
>>
>> Hi Martin,
>>
>> On 7/4/20 7:42 PM, Martin Blumenstingl wrote:
>>> Hello Amelie,
>>>
>>> thank you for this patch - I am hoping that it will help us on Amlogic
>>> Meson8, Meson8b, Meson8m2 and GXBB SoCs as well.
>>> On these SoCs the ID detection is performed by the PHY IP and needs to
>>> be polled.
>>> I think usb_role_switch is the perfect framework for this on dwc2 side.
>>> For the PHY driver I'm going to implement the cable state using the
>>> extcon framework and then having a new usb-conn-extcon driver. This is
>>> just to give you an overview why I'm interested in this.
>>>
>>
>> I'm wondering, why use extcon framework and not the usb role switch API
>> ? This patch on dwc2 is tested on STM32MP157C-DK2 board with STUSB160x
>> Type-C controller driver recently pushed with usb role switch. You can
>> have a look here https://lore.kernel.org/patchwork/patch/1256238/.
> one of the boards that I'm working on is for example the Odroid-C1. It
> has a Micro-USB port and there's no Type-C controller present.
> 
> in the next few days I'll try to send my idea as RFC, but this is the
> .dts I've come up with so far:
> &usb0 {
>      dr_mode = "otg";
>      usb-role-switch;
> 
>      connector {
>          compatible = "extcon-usb-b-connector", "usb-b-connector";
>          type = "micro";
>          extcon = <&usb0_phy>;
>          vbus-supply = <&usb_vbus>;
>      };
> };
> 
> I did this for two reasons:
> 1. I think the PHY is not a connector and thus it's driver shouldn't
> implement any connector specific logic (managing VBUS)
> 2. without the connector there would be a circular dependency: the USB
> controller needs the PHY to initialize but the PHY would need the USB
> controller so it can manage the role switch
> 
> (or in other words: the connector replaces the Type-C controller in this case)
> 
>>> [...]
>>>> +static int dwc2_drd_role_sw_set(struct usb_role_switch *sw, enum usb_role role)
>>>> +{
>>>> +     struct dwc2_hsotg *hsotg = usb_role_switch_get_drvdata(sw);
>>>> +     unsigned long flags;
>>>> +
>>>> +     /* Skip session not in line with dr_mode */
>>>> +     if ((role == USB_ROLE_DEVICE && hsotg->dr_mode == USB_DR_MODE_HOST) ||
>>>> +         (role == USB_ROLE_HOST && hsotg->dr_mode == USB_DR_MODE_PERIPHERAL))
>>>> +             return -EINVAL;
>>>> +
>>>> +     /* Skip session if core is in test mode */
>>>> +     if (role == USB_ROLE_NONE && hsotg->test_mode) {
>>>> +             dev_dbg(hsotg->dev, "Core is in test mode\n");
>>>> +             return -EBUSY;
>>>> +     }
>>>> +
>>>> +     spin_lock_irqsave(&hsotg->lock, flags);
>>> due to this spin_lock_irqsave() ...
>>>
>>>> +     if (role == USB_ROLE_HOST) {
>>>> +             if (dwc2_ovr_avalid(hsotg, true))
>>>> +                     goto unlock;
>>>> +
>>>> +             if (hsotg->dr_mode == USB_DR_MODE_OTG)
>>>> +                     /*
>>>> +                      * This will raise a Connector ID Status Change
>>>> +                      * Interrupt - connID A
>>>> +                      */
>>>> +                     dwc2_force_mode(hsotg, true);
>>> ... we cannot sleep in here. the call flow is:
>>> dwc2_drd_role_sw_set
>>>     spin_lock_irqsave
>>>     dwc2_force_mode
>>>       dwc2_wait_for_mode
>>>         usleep_range
>>>
>>
>> In fact, with the avalid or bvalid overriding + the debounce filter
>> bypass, GINTSTS_CURMOD is already in the expected mode, so that we exit
>> the loop directly, without running into usleep_range.
> on my Amlogic SoC this is not the case:
> The kernel complains because of that usleep_range from within the
> spinlock context
> 
> Please let me know if/how I can help debug this.
> 

Could you please test with:

static int dwc2_drd_role_sw_set(struct device *dev, enum usb_role role)
{
	struct dwc2_hsotg *hsotg = dev_get_drvdata(dev);
	unsigned long flags;
	int already = 0;

	/* Skip session not in line with dr_mode */
	if ((role == USB_ROLE_DEVICE && hsotg->dr_mode == USB_DR_MODE_HOST) ||
	    (role == USB_ROLE_HOST && hsotg->dr_mode == USB_DR_MODE_PERIPHERAL))
		return -EINVAL;

	/* Skip session if core is in test mode */
	if (role == USB_ROLE_NONE && hsotg->test_mode) {
		dev_dbg(hsotg->dev, "Core is in test mode\n");
		return -EBUSY;
	}

	spin_lock_irqsave(&hsotg->lock, flags);

	if (role == USB_ROLE_HOST) {
		already = dwc2_ovr_avalid(hsotg, true);
	} else if (role == USB_ROLE_DEVICE) {
		already = dwc2_ovr_bvalid(hsotg, true);
		/* This clear DCTL.SFTDISCON bit */
		dwc2_hsotg_core_connect(hsotg);
	} else {
		if (dwc2_is_device_mode(hsotg)) {
		    if (!dwc2_ovr_bvalid(hsotg, false))
			/* This set DCTL.SFTDISCON bit */
			dwc2_hsotg_core_disconnect(hsotg);
		} else {
			dwc2_ovr_avalid(hsotg, false);
		}
	}

	spin_unlock_irqrestore(&hsotg->lock, flags);

	if (!already &&
	    role != USB_ROLE_NONE && hsotg->dr_mode == USB_DR_MODE_OTG)
		/* This will raise a Connector ID Status Change Interrupt */
		dwc2_force_mode(hsotg, role == USB_ROLE_HOST);

	dev_dbg(hsotg->dev, "%s-session valid\n",
		role == USB_ROLE_NONE ? "No" :
		role == USB_ROLE_HOST ? "A" : "B");

	return 0;
}


dwc2_force_mode is called outside the spin_lock_irqsave so the kernel 
should not complain. I've tested on my setup and the behavior seems the 
same.

Regards,
Amelie
