Return-Path: <SRS0=Rqeb=BC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4F7EC433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jul 2020 07:15:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BBD052068F
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jul 2020 07:15:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=st.com header.i=@st.com header.b="At0Pl150"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726728AbgGWHPk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Jul 2020 03:15:40 -0400
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:59684 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725536AbgGWHPk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jul 2020 03:15:40 -0400
Received: from pps.filterd (m0046661.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 06N7DD7m014051;
        Thu, 23 Jul 2020 09:15:20 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=st.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=STMicroelectronics;
 bh=yqcfY/padsjVsHSiHABJVoYRhWwTvp1SMriQZY8ccyU=;
 b=At0Pl150HlvjCdBUER0ftWuQuekxfi0EwklT75x/bePqYqO4iWqKjxuNsDn7aFrOZpLe
 42WJqY4eJEJYzCCfh/TdisUjXbq47ICeBRdrfFAg1n3vrswF9wFc/L6+9l7FjlYtbXQt
 ozlUIOEaCMZYqIrJm2Hkl+fcCAUERTXyqFjbBOcq/0GLgFxwvX8H7yVXfR6PxmwRFprp
 eNlqkDES+OBWBOHik1XACNAmvweFWNWXHS8ed4YVhMeDS/KSfUhK60bbf0KJWTXQs8CG
 btG6mEnaLZj84V88bkHov2UkcUEiRRfWtd1swOyWMnDoc2ka7q39STFgU6Gh1OKqTcVS 7A== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 32bsah95dp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 23 Jul 2020 09:15:20 +0200
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 4B13610002A;
        Thu, 23 Jul 2020 09:15:19 +0200 (CEST)
Received: from Webmail-eu.st.com (sfhdag3node2.st.com [10.75.127.8])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 32E0621FEA9;
        Thu, 23 Jul 2020 09:15:19 +0200 (CEST)
Received: from lmecxl0995.lme.st.com (10.75.127.51) by SFHDAG3NODE2.st.com
 (10.75.127.8) with Microsoft SMTP Server (TLS) id 15.0.1347.2; Thu, 23 Jul
 2020 09:15:18 +0200
Subject: Re: [PATCH 1/3] usb: dwc2: override PHY input signals with usb role
 switch support
To:     Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        "balbi@kernel.org" <balbi@kernel.org>
CC:     Alexandre TORGUE <alexandre.torgue@st.com>,
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
 <ee4ee889-835e-2244-504c-2b1b605d78aa@st.com>
 <CAFBinCDUxvovAyDywz3xVcu_1v4nai+ebR2D38U2B8oBGss=yg@mail.gmail.com>
From:   Amelie DELAUNAY <amelie.delaunay@st.com>
Message-ID: <7497c0ed-bac6-969e-8198-c40a41e874e3@st.com>
Date:   Thu, 23 Jul 2020 09:15:17 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <CAFBinCDUxvovAyDywz3xVcu_1v4nai+ebR2D38U2B8oBGss=yg@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.75.127.51]
X-ClientProxiedBy: SFHDAG8NODE1.st.com (10.75.127.22) To SFHDAG3NODE2.st.com
 (10.75.127.8)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-07-23_02:2020-07-22,2020-07-23 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Felipe,
Hi Martin,

I saw the issue reported ([balbi-usb:testing/next 2/17] 
drivers/usb/dwc2/drd.c:80:38: error: no member named 'test_mode' in 
'struct dwc2_hsotg'). I prepare a V2 fixing it + adressing Martin's 
comments.

Regards,
Amelie

On 7/19/20 9:56 PM, Martin Blumenstingl wrote:
> Hello Amelie,
> 
> sorry for the late reply
> 
> On Wed, Jul 8, 2020 at 6:00 PM Amelie DELAUNAY <amelie.delaunay@st.com> 
> wrote:
> [...]
>> Could you please test with:
>>
>> static int dwc2_drd_role_sw_set(struct device *dev, enum usb_role role)
>> {
>>         struct dwc2_hsotg *hsotg = dev_get_drvdata(dev);
>>         unsigned long flags;
>>         int already = 0;
>>
>>         /* Skip session not in line with dr_mode */
>>         if ((role == USB_ROLE_DEVICE && hsotg->dr_mode == USB_DR_MODE_HOST) ||
>>             (role == USB_ROLE_HOST && hsotg->dr_mode == USB_DR_MODE_PERIPHERAL))
>>                 return -EINVAL;
>>
>>         /* Skip session if core is in test mode */
>>         if (role == USB_ROLE_NONE && hsotg->test_mode) {
>>                 dev_dbg(hsotg->dev, "Core is in test mode\n");
>>                 return -EBUSY;
>>         }
>>
>>         spin_lock_irqsave(&hsotg->lock, flags);
>>
>>         if (role == USB_ROLE_HOST) {
>>                 already = dwc2_ovr_avalid(hsotg, true);
>>         } else if (role == USB_ROLE_DEVICE) {
>>                 already = dwc2_ovr_bvalid(hsotg, true);
>>                 /* This clear DCTL.SFTDISCON bit */
>>                 dwc2_hsotg_core_connect(hsotg);
>>         } else {
>>                 if (dwc2_is_device_mode(hsotg)) {
>>                     if (!dwc2_ovr_bvalid(hsotg, false))
>>                         /* This set DCTL.SFTDISCON bit */
>>                         dwc2_hsotg_core_disconnect(hsotg);
>>                 } else {
>>                         dwc2_ovr_avalid(hsotg, false);
>>                 }
>>         }
>>
>>         spin_unlock_irqrestore(&hsotg->lock, flags);
>>
>>         if (!already &&
>>             role != USB_ROLE_NONE && hsotg->dr_mode == USB_DR_MODE_OTG)
>>                 /* This will raise a Connector ID Status Change Interrupt */
>>                 dwc2_force_mode(hsotg, role == USB_ROLE_HOST);
>>
>>         dev_dbg(hsotg->dev, "%s-session valid\n",
>>                 role == USB_ROLE_NONE ? "No" :
>>                 role == USB_ROLE_HOST ? "A" : "B");
>>
>>         return 0;
>> }
>>
>>
>> dwc2_force_mode is called outside the spin_lock_irqsave so the kernel
>> should not complain. I've tested on my setup and the behavior seems the
>> same.
> this one is looking good - the previous kernel warnings are now gone!
> thank you very much
> 
> 
> Best regards,
> Martin
