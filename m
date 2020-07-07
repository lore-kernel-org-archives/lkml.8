Return-Path: <SRS0=aTFg=AS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A394C433E1
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jul 2020 16:14:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7550120674
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jul 2020 16:14:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=st.com header.i=@st.com header.b="m0RDiPDM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728628AbgGGQOK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Jul 2020 12:14:10 -0400
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:54370 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727789AbgGGQOK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jul 2020 12:14:10 -0400
Received: from pps.filterd (m0046661.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 067G9tuq013325;
        Tue, 7 Jul 2020 18:13:50 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=st.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=STMicroelectronics;
 bh=3Afx2BNI/P16pD98uz+SOHXGDbHLupUEHpZV47RnCLo=;
 b=m0RDiPDM/I0GpRhFENOsWoTXnVZkezWbT606WIGk0x7Xb+EFofzEb2CVNsxRsVQZPOmn
 pcxx2qga7NiCGHC2R7cjLdTLilLXsTAxkGAeqbjIOV4wSdoORuPzla/Cbt4O2ZGes8eV
 ++U+L1KwWGpudPuBgiNvBURVoiDpQZyPRrU0k1bx0emIqFTMywBaz0N3e/zKpoXeDAM0
 QLgh7n0FPxYt82pPLNWStz4xt+Zbk61ujtXaRes35hbq8IIs99aDgzCFtaFSQRunSefk
 pwxFxO4hjamTB1qTT7O31I8DsvylAHIsJnakrhk8lyTyttvKgXU/cUu8Op4Rrf/C5Kau Rw== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 322gnfhyr1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 07 Jul 2020 18:13:50 +0200
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id DA37E10002A;
        Tue,  7 Jul 2020 18:13:48 +0200 (CEST)
Received: from Webmail-eu.st.com (sfhdag3node2.st.com [10.75.127.8])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id C8ABB2C5AAF;
        Tue,  7 Jul 2020 18:13:48 +0200 (CEST)
Received: from lmecxl0995.lme.st.com (10.75.127.48) by SFHDAG3NODE2.st.com
 (10.75.127.8) with Microsoft SMTP Server (TLS) id 15.0.1347.2; Tue, 7 Jul
 2020 18:13:48 +0200
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
From:   Amelie DELAUNAY <amelie.delaunay@st.com>
Message-ID: <05a81997-5ddb-ea81-7a89-8078b8a2b610@st.com>
Date:   Tue, 7 Jul 2020 18:13:47 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200704174219.612060-1-martin.blumenstingl@googlemail.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.75.127.48]
X-ClientProxiedBy: SFHDAG6NODE3.st.com (10.75.127.18) To SFHDAG3NODE2.st.com
 (10.75.127.8)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-07-07_08:2020-07-07,2020-07-07 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Martin,

On 7/4/20 7:42 PM, Martin Blumenstingl wrote:
> Hello Amelie,
> 
> thank you for this patch - I am hoping that it will help us on Amlogic
> Meson8, Meson8b, Meson8m2 and GXBB SoCs as well.
> On these SoCs the ID detection is performed by the PHY IP and needs to
> be polled.
> I think usb_role_switch is the perfect framework for this on dwc2 side.
> For the PHY driver I'm going to implement the cable state using the
> extcon framework and then having a new usb-conn-extcon driver. This is
> just to give you an overview why I'm interested in this.
> 

I'm wondering, why use extcon framework and not the usb role switch API 
? This patch on dwc2 is tested on STM32MP157C-DK2 board with STUSB160x 
Type-C controller driver recently pushed with usb role switch. You can 
have a look here https://lore.kernel.org/patchwork/patch/1256238/.

> [...]
>> +static int dwc2_drd_role_sw_set(struct usb_role_switch *sw, enum usb_role role)
>> +{
>> +     struct dwc2_hsotg *hsotg = usb_role_switch_get_drvdata(sw);
>> +     unsigned long flags;
>> +
>> +     /* Skip session not in line with dr_mode */
>> +     if ((role == USB_ROLE_DEVICE && hsotg->dr_mode == USB_DR_MODE_HOST) ||
>> +         (role == USB_ROLE_HOST && hsotg->dr_mode == USB_DR_MODE_PERIPHERAL))
>> +             return -EINVAL;
>> +
>> +     /* Skip session if core is in test mode */
>> +     if (role == USB_ROLE_NONE && hsotg->test_mode) {
>> +             dev_dbg(hsotg->dev, "Core is in test mode\n");
>> +             return -EBUSY;
>> +     }
>> +
>> +     spin_lock_irqsave(&hsotg->lock, flags);
> due to this spin_lock_irqsave() ...
> 
>> +     if (role == USB_ROLE_HOST) {
>> +             if (dwc2_ovr_avalid(hsotg, true))
>> +                     goto unlock;
>> +
>> +             if (hsotg->dr_mode == USB_DR_MODE_OTG)
>> +                     /*
>> +                      * This will raise a Connector ID Status Change
>> +                      * Interrupt - connID A
>> +                      */
>> +                     dwc2_force_mode(hsotg, true);
> ... we cannot sleep in here. the call flow is:
> dwc2_drd_role_sw_set
>    spin_lock_irqsave
>    dwc2_force_mode
>      dwc2_wait_for_mode
>        usleep_range
> 

In fact, with the avalid or bvalid overriding + the debounce filter 
bypass, GINTSTS_CURMOD is already in the expected mode, so that we exit 
the loop directly, without running into usleep_range.

>> +     } else if (role == USB_ROLE_DEVICE) {
>> +             if (dwc2_ovr_bvalid(hsotg, true))
>> +                     goto unlock;
>> +
>> +             if (hsotg->dr_mode == USB_DR_MODE_OTG)
>> +                     /*
>> +                      * This will raise a Connector ID Status Change
>> +                      * Interrupt - connID B
>> +                      */
>> +                     dwc2_force_mode(hsotg, false);
> (same sleeping issue here)
> 
> [...]
> +int dwc2_drd_init(struct dwc2_hsotg *hsotg)
> +{
> +       struct usb_role_switch_desc role_sw_desc = {0};
> +       struct usb_role_switch *role_sw;
> +       int ret;
> +
> +       if (!device_property_read_bool(hsotg->dev, "usb-role-switch"))
> +               return 0;
> should we also return early here if dr_mode != "otg"?
> 

No, because when VBUS is not connected to the controller, you also need 
to get the usb_role_none from the usb-role-switch to catch the 
unattached state (also in Peripheral or Host only mode).

> [...]
> @@ -532,6 +534,13 @@ static int dwc2_driver_probe(struct platform_device 
> *dev)
>                   dwc2_writel(hsotg, ggpio, GGPIO);
>           }
> 
> +       retval = dwc2_drd_init(hsotg);
> +       if (retval) {
> +               if (retval != -EPROBE_DEFER)
> +                       dev_err(hsotg->dev, "failed to initialize 
> dual-role\n");
> +               goto error_init;
> +       }
> +
>           if (hsotg->dr_mode != USB_DR_MODE_HOST) {
>                   retval = dwc2_gadget_init(hsotg);
>                   if (retval)
> I think dwc2_driver_probe() needs a new label (for example named
> error_drd) which then calls dwc2_drd_exit. See [0] which I have
> submitted as a patch for Linux 5.8, so it's not in usb-next yet.
> 

I agree.

> Also in general I think you need to submit a dt-bindings patch that
> documents the usb-role-switch property. Personally I would use
> Documentation/devicetree/bindings/usb/renesas,usb3-peri.yaml as
> reference for that.
> 

Sure. Will be done in V2 with new label for drd_exit in probe failure 
path. I'll rebase my patch on yours to avoid conflicts.

> Can you please keep me Cc'ed on a v2 because I'm not subscribed to the
> linux-usb mailing list?

OK. Thanks for your review and future tests!
Regards,
Amelie

> I am going to test this on Amlogic SoCs - once I made "everything else"
> work I can give my Tested-by as well.
> 
> 
> Thank you!
> Martin
> 
> 
> [0] https://patchwork.kernel.org/patch/11642957/
