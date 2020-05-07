Return-Path: <SRS0=0sZ+=6V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1248C38A2A
	for <linux-kernel@archiver.kernel.org>; Thu,  7 May 2020 12:21:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AC2AB20CC7
	for <linux-kernel@archiver.kernel.org>; Thu,  7 May 2020 12:21:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=st.com header.i=@st.com header.b="d+NGdAqK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727084AbgEGMVP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 May 2020 08:21:15 -0400
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:53830 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726948AbgEGMVN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 May 2020 08:21:13 -0400
Received: from pps.filterd (m0046661.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 047CBwO7017687;
        Thu, 7 May 2020 14:21:02 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=st.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=STMicroelectronics;
 bh=sy+j/OzdVrEShb4BU6oaOmleHPnk3+iamhvdZNojZEw=;
 b=d+NGdAqKZLAQ6HBYKK+y8XVU0Z3aE6OQ0SW6zYRQR/oFSWeN8KB4KtWisXPV4g314C/C
 7gQ2XxwcWR6om6AawV5ikoN2jc75VEKlE6vaDVtmwqxb3o7qcRN0cRtO5Hduvtrpaa97
 AOli0a/6ljvu72oqCiURwN2aJf1kYTG6OzpW+sSokga3M5i5PRVw2qamLK9/04DK1mgs
 clLiN0MoODFrfi+W09hLdjQYqVIf38q57oDDmSTUgzGTBBXb4vFkCb2Gzm0u14T7ojCI
 8QTQXYKlpYGf1EKOjVNV5Ub+XcjLbfYbpVseGXBcsO85i4BiOAqom6oEBWyAn2IbXBTt LQ== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 30ryrjkhm7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 07 May 2020 14:21:02 +0200
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id E925310002A;
        Thu,  7 May 2020 14:21:01 +0200 (CEST)
Received: from Webmail-eu.st.com (sfhdag3node2.st.com [10.75.127.8])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id D7E6A2B4D2A;
        Thu,  7 May 2020 14:21:01 +0200 (CEST)
Received: from lmecxl0912.tpe.st.com (10.75.127.49) by SFHDAG3NODE2.st.com
 (10.75.127.8) with Microsoft SMTP Server (TLS) id 15.0.1347.2; Thu, 7 May
 2020 14:20:58 +0200
Subject: Re: [PATCH 3/4] ARM: dts: stm32: enable stmpe811 on stm32429-disco
 board
To:     Hua Dillon <dillonhua@gmail.com>
CC:     "dillon.minfei@gmail.com" <dillon.minfei@gmail.com>,
        "mcoquelin.stm32@gmail.com" <mcoquelin.stm32@gmail.com>,
        "philippe.schenker@toradex.com" <philippe.schenker@toradex.com>,
        "linux-stm32@st-md-mailman.stormreply.com" 
        <linux-stm32@st-md-mailman.stormreply.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <1588850125-24344-1-git-send-email-dillon.minfei@gmail.com>
 <98d6d44c-ff23-ac15-c17b-8f5f49ad2274@st.com>
 <CAPTRvHns7WZj49O2MKHN-ByJpHjYftCqakHN_XOzTwMkg57z0Q@mail.gmail.com>
From:   Alexandre Torgue <alexandre.torgue@st.com>
Message-ID: <bf42a03d-0719-b4c9-7153-818e26dae888@st.com>
Date:   Thu, 7 May 2020 14:20:51 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <CAPTRvHns7WZj49O2MKHN-ByJpHjYftCqakHN_XOzTwMkg57z0Q@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.75.127.49]
X-ClientProxiedBy: SFHDAG8NODE1.st.com (10.75.127.22) To SFHDAG3NODE2.st.com
 (10.75.127.8)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.216,18.0.676
 definitions=2020-05-07_06:2020-05-07,2020-05-07 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 5/7/20 2:13 PM, Hua Dillon wrote:
> hi, alexandre torgue
> 
> so, if i add "---" below
>   Signed-off-by: dillon min <dillon.minfei@gmail.com 
> <mailto:dillon.minfei@gmail.com>>
>   in git commit process, with changes log after that.  the log will not 
> show in commit messages, but will exist in git patchs, just showing for 
> reviewers ?

Sorry I was not enough clear. Add --- after your signed-off and add your 
log change after

> 
> i will try this tomorrow, resubmit it.
> 
> thanks for your help.
> 
> best regards
> 
> dillon
> 
> 在 2020年5月7日星期四，Alexandre Torgue <alexandre.torgue@st.com 
> <mailto:alexandre.torgue@st.com>> 写道：
> 
>     Hi Dillon
> 
>     On 5/7/20 1:15 PM, dillon.minfei@gmail.com
>     <mailto:dillon.minfei@gmail.com> wrote:
> 
>         From: dillon min <dillon.minfei@gmail.com
>         <mailto:dillon.minfei@gmail.com>>
> 
>         Enable the stmpe811 touch screen on stm32429-disco board.
> 
>         Signed-off-by: dillon min <dillon.minfei@gmail.com
>         <mailto:dillon.minfei@gmail.com>>
> 
>         [PATCH 3/4]: ARM: dts: stm32: enable stmpe811 on stm32429-disco
> 
>         V2:
>         patch 3: remove unused id, blocks, irq-trigger
> 
>         V1:
>         patch 4: fix read touch screen xyz timeout bug
>         patch 3: enable stmpe_touchscreen on stm32f429-disco board
>         patch 2: add i2c3 pin mux for stm32f4
>         patch 1: add i2c3 controller interface for stm32f4
> 
> 
>     Good idea to add changes log for this patch. But this log has to be
>     placed  after "---" below. This log has not to appear in your commit
>     message. Furthermore, you should only add changes for this patch
>     without talking about other patches .
> 
> 
>         Signed-off-by: dillon min <dillon.minfei@gmail.com
>         <mailto:dillon.minfei@gmail.com>>
>         ---
> 
> 
>     Add patch change log here.
> 
>            arch/arm/boot/dts/stm32f429-disco.dts | 47
>         +++++++++++++++++++++++++++++++++++
>            1 file changed, 47 insertions(+)
> 
>         diff --git a/arch/arm/boot/dts/stm32f429-disco.dts
>         b/arch/arm/boot/dts/stm32f429-disco.dts
>         index 30c0f67..fad1ec1 100644
>         --- a/arch/arm/boot/dts/stm32f429-disco.dts
>         +++ b/arch/arm/boot/dts/stm32f429-disco.dts
>         @@ -49,6 +49,8 @@
>            #include "stm32f429.dtsi"
>            #include "stm32f429-pinctrl.dtsi"
>            #include <dt-bindings/input/input.h>
>         +#include <dt-bindings/interrupt-controller/irq.h>
>         +#include <dt-bindings/gpio/gpio.h>
>              / {
>                  model = "STMicroelectronics STM32F429i-DISCO board";
>         @@ -127,3 +129,48 @@
>                  pinctrl-names = "default";
>                  status = "okay";
>            };
>         +
>         +&i2c3 {
>         +       pinctrl-names = "default";
>         +       pinctrl-0 = <&i2c3_pins>;
>         +       clock-frequency = <100000>;
>         +       status = "okay";
>         +
>         +       stmpe811@41 {
>         +               compatible = "st,stmpe811";
>         +               reg = <0x41>;
>         +               interrupts = <15 IRQ_TYPE_EDGE_FALLING>;
>         +               interrupt-parent = <&gpioa>;
>         +               /* 3.25 MHz ADC clock speed */
>         +               st,adc-freq = <1>;
>         +               /* 12-bit ADC */
>         +               st,mod-12b = <1>;
>         +               /* internal ADC reference */
>         +               st,ref-sel = <0>;
>         +               /* ADC converstion time: 80 clocks */
>         +               st,sample-time = <4>;
>         +
>         +               stmpe_touchscreen {
>         +                       compatible = "st,stmpe-ts";
>         +                       /* 8 sample average control */
>         +                       st,ave-ctrl = <3>;
>         +                       /* 7 length fractional part in z */
>         +                       st,fraction-z = <7>;
>         +                       /*
>         +                        * 50 mA typical 80 mA max touchscreen
>         drivers
>         +                        * current limit value
>         +                        */
>         +                       st,i-drive = <1>;
>         +                       /* 1 ms panel driver settling time */
>         +                       st,settling = <3>;
>         +                       /* 5 ms touch detect interrupt delay */
>         +                       st,touch-det-delay = <5>;
>         +               };
>         +
>         +               stmpe_adc {
>         +                       compatible = "st,stmpe-adc";
>         +                       /* forbid to use ADC channels 3-0 (touch) */
>         +                       st,norequest-mask = <0x0F>;
>         +               };
>         +       };
>         +};
> 
> 
>     _______________________________________________
>     linux-arm-kernel mailing list
>     linux-arm-kernel@lists.infradead.org
>     <mailto:linux-arm-kernel@lists.infradead.org>
>     http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
>     <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>
> 
