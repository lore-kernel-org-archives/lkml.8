Return-Path: <SRS0=aBbL=CG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F5EFC433E6
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Aug 2020 09:13:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 054272071B
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Aug 2020 09:13:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=st.com header.i=@st.com header.b="04QPLnNq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728733AbgH1JNU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Aug 2020 05:13:20 -0400
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:52182 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726010AbgH1JNN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Aug 2020 05:13:13 -0400
Received: from pps.filterd (m0046661.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 07S97JVx008936;
        Fri, 28 Aug 2020 11:13:01 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=st.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=STMicroelectronics;
 bh=iLG15dhrsfK3a5qnX3uOMQK8LyuA+bMvi9d+/C/JDPE=;
 b=04QPLnNqYVtj07QzTGrKWKT46oXeoi1GxGgAMRs+pzFR/OgzajhbFu1C5Mr28e8FcDZ7
 Jq0INYTTa+mrhZWbbN6VfrCE2euLb9duoP0rRHhgjz90wXaAoO6yre/QFXSABxaqgjHu
 hSAaJZmOELgTx9mECjI/eTov+SUB3MYAHzZog2bGOS2NPkGLPzgawtpa0g19QWXATZUu
 vkgecfJ+6Nu5jkeLgZrqQp8fPqSRljVq/YA5EruKXGOvZ6O3zkOlzIHG04CN6QvLIA8p
 dhGsgVRwem1UDBKo3NNix1dSLdb0N1y0QM+jIwBgpOsiYrzBkqJ7OIAXbc86dqGlyC3V vQ== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 332t8g5hhc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 28 Aug 2020 11:13:01 +0200
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 8CEF4100038;
        Fri, 28 Aug 2020 11:13:00 +0200 (CEST)
Received: from Webmail-eu.st.com (sfhdag3node2.st.com [10.75.127.8])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 785522A76E6;
        Fri, 28 Aug 2020 11:13:00 +0200 (CEST)
Received: from lmecxl0912.lme.st.com (10.75.127.46) by SFHDAG3NODE2.st.com
 (10.75.127.8) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Fri, 28 Aug
 2020 11:12:59 +0200
Subject: Re: [PATCH] ARM: dts: stm32: lxa-mc1: Fix kernel warning about PHY
 delays
To:     Holger Assmann <h.assmann@pengutronix.de>,
        Rob Herring <robh+dt@kernel.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Ahmad Fatoum <a.fatoum@pengutronix.de>
CC:     <devicetree@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
References: <20200807150355.6116-1-h.assmann@pengutronix.de>
From:   Alexandre Torgue <alexandre.torgue@st.com>
Message-ID: <1a3291ca-daa4-32fc-d4da-15bb9faf73f9@st.com>
Date:   Fri, 28 Aug 2020 11:12:57 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200807150355.6116-1-h.assmann@pengutronix.de>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.75.127.46]
X-ClientProxiedBy: SFHDAG6NODE2.st.com (10.75.127.17) To SFHDAG3NODE2.st.com
 (10.75.127.8)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-08-28_05:2020-08-28,2020-08-28 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Holger

On 8/7/20 5:03 PM, Holger Assmann wrote:
> The KSZ9031 PHY skew timings for rxc/txc, originally set to achieve
> the desired phase shift between clock- and data-signal, now trigger a
> kernel warning when used in rgmii-id mode:
> 
>   *-skew-ps values should be used only with phy-mode = "rgmii"
> 
> This is because commit bcf3440c6dd7 ("net: phy: micrel: add phy-mode
> support for the KSZ9031 PHY") now configures own timings when
> phy-mode = "rgmii-id". Device trees wanting to set their own delays
> should use phy-mode "rgmii" instead as the warning prescribes.
> 
> The "standard" timings now used with "rgmii-id" work fine on this
> board, so drop the explicit timings in the device tree and thereby
> silence the warning.
> 
> Fixes: 666b5ca85cd3 ("ARM: dts: stm32: add STM32MP1-based Linux Automation MC-1 board")
> Signed-off-by: Holger Assmann <h.assmann@pengutronix.de>
> ---
>   arch/arm/boot/dts/stm32mp157c-lxa-mc1.dts | 2 --
>   1 file changed, 2 deletions(-)
> 
> diff --git a/arch/arm/boot/dts/stm32mp157c-lxa-mc1.dts b/arch/arm/boot/dts/stm32mp157c-lxa-mc1.dts
> index 5700e6b700d3..b85025d00943 100644
> --- a/arch/arm/boot/dts/stm32mp157c-lxa-mc1.dts
> +++ b/arch/arm/boot/dts/stm32mp157c-lxa-mc1.dts
> @@ -121,8 +121,6 @@
>   			reset-gpios = <&gpiog 0 GPIO_ACTIVE_LOW>; /* ETH_RST# */
>   			interrupt-parent = <&gpioa>;
>   			interrupts = <6 IRQ_TYPE_EDGE_FALLING>; /* ETH_MDINT# */
> -			rxc-skew-ps = <1860>;
> -			txc-skew-ps = <1860>;
>   			reset-assert-us = <10000>;
>   			reset-deassert-us = <300>;
>   			micrel,force-master;
> 

Applied on stm32-next.

Thanks.
Alex
