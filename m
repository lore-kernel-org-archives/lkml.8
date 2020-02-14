Return-Path: <SRS0=fG1M=4C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F21C9C2BA83
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Feb 2020 13:11:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 30510222C4
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Feb 2020 13:11:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gerhold.net header.i=@gerhold.net header.b="QRZ7tfWu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729277AbgBNNLG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Feb 2020 08:11:06 -0500
Received: from mo4-p00-ob.smtp.rzone.de ([85.215.255.21]:14641 "EHLO
        mo4-p00-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729032AbgBNNLG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Feb 2020 08:11:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1581685864;
        s=strato-dkim-0002; d=gerhold.net;
        h=In-Reply-To:References:Message-ID:Subject:Cc:To:From:Date:
        X-RZG-CLASS-ID:X-RZG-AUTH:From:Subject:Sender;
        bh=2iQ0MT1U9CEUvMzykFVhxG6fcNf9dbQ++m0bxVU4LOA=;
        b=QRZ7tfWuQfyu5XGZM09W/LcqlGoQbNr6aG9UHgzwDMla0AS3p9vd9Sq9daOEEzh4tR
        ZL2cqg1PqduwWmVOZXliFNVK6FwueobZO2nN+H1kd0hNPv5DLRWguKsragdSp38JrXPe
        F9YOqs3mXjIAKReHt4rf2yspQ2Otq4mdq1vRpciAnm8YSKPuSpGnWCF0vit2ZqLkjLxp
        c2ZRJ8aSwyJYUjX5bKurs6TuuNttLPt5kJZDnm2PGctrK3jd91N10EQa9OEDYkGIxUu3
        6XGOqZzUs7byzWdcsbQcjHLfM+bEc2bMQ/XjkMaybV++8DyqeD1cdp+rAXK5ju1HNo4t
        ub5A==
X-RZG-AUTH: ":P3gBZUipdd93FF5ZZvYFPugejmSTVR2nRPhVOQ/OcYgojyw4j34+u266EZF6ORJKAk/tplRN"
X-RZG-CLASS-ID: mo00
Received: from gerhold.net
        by smtp.strato.de (RZmta 46.1.12 AUTH)
        with ESMTPSA id a01fe9w1ED81Prk
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
        Fri, 14 Feb 2020 14:08:01 +0100 (CET)
Date:   Fri, 14 Feb 2020 14:07:55 +0100
From:   Stephan Gerhold <stephan@gerhold.net>
To:     Chanwoo Choi <cw00.choi@samsung.com>
Cc:     MyungJoo Ham <myungjoo.ham@samsung.com>,
        linux-kernel@vger.kernel.org
Subject: Re: extcon: sm5502: USB-HOST (OTG) detection not working
Message-ID: <20200214130755.GA93507@gerhold.net>
References: <20191011145015.GA127238@gerhold.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191011145015.GA127238@gerhold.net>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Chanwoo,

On Fri, Oct 11, 2019 at 04:50:21PM +0200, Stephan Gerhold wrote:
> Hi Chanwoo,
> 
> after getting interrupts working on my Samsung Galaxy A5 (2015),
> I am now trying to make the extcon device detect USB-HOST=1
> when I plug in an USB OTG adapter.
> 
> At the moment, the driver can sucessfully detect:
>   - USB=1 + SDP=1 when I detect the phone to a PC
>   - DCP=1 when I connect it to an AC charger
> but it does not set USB-HOST=1 when I connect the USB OTG adapter.
> 
> It seems to be a problem in the sm5502 driver, since I do get an
> SM5502_IRQ_INT1_ATTACH interrupt when I plug in the USB OTG adapter.
> 
> In this case, SM5502 reports:
>     SM5502_REG_ADC = 0x00 (SM5502_MUIC_ADC_GROUND)
>     SM5502_REG_DEV_TYPE1 = 0x80 (SM5502_REG_DEV_TYPE1_USB_OTG_MASK)
> 
> However, at the moment the sm5502 driver ignores all attach events with
> SM5502_REG_ADC == SM5502_MUIC_ADC_GROUND:
> 
> 	/*
> 	 * If ADC is SM5502_MUIC_ADC_GROUND(0x0), external cable hasn't
> 	 * connected with to MUIC device.
> 	 */
> 	cable_type = adc & SM5502_REG_ADC_MASK;
> 	if (cable_type == SM5502_MUIC_ADC_GROUND)
> 		return SM5502_MUIC_ADC_GROUND;
> 
> However, I definitely have a cable attached in this case...
> 
> The sm5502 driver seems to expect SM5502_REG_ADC == SM5502_MUIC_ADC_OPEN.
> Any idea why my hardware reports ADC_GROUND for the USB OTG adapter
> instead of ADC_OPEN?
> 
> Confusingly, the driver used in the original downstream kernel of
> the Samsung Galaxy A5 [1] calls ADC = 0x00 "ADC_OTG" instead of
> "ADC_GROUND".
> So getting ADC = 0x00 may not be entirely unexpected here...
> 
> Thanks in advance,
> Stephan
> 
> [1]: https://github.com/msm8916-mainline/android_kernel_qcom_msm8916/blob/SM-A500FU/drivers/misc/sm5502.c#L195

This mail is quite old now but I am still confused by this.
Any idea what could be wrong here?

I was not able to find any datasheet for SM5502 unfortunately...

Thanks,
Stephan
