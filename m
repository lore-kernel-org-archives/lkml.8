Return-Path: <SRS0=2JZx=64=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 419DAC433E1
	for <linux-kernel@archiver.kernel.org>; Thu, 14 May 2020 12:53:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2154D206A5
	for <linux-kernel@archiver.kernel.org>; Thu, 14 May 2020 12:53:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=st.com header.i=@st.com header.b="aqMOulBA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726304AbgENMxf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 May 2020 08:53:35 -0400
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:12874 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725955AbgENMxe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 May 2020 08:53:34 -0400
Received: from pps.filterd (m0046660.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 04ECqOfG012268;
        Thu, 14 May 2020 14:53:08 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=st.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=STMicroelectronics;
 bh=nHSWD3rAvd4p9vuLYKA3ZWiKVn+Vm2Lf+IPFO5a7YEk=;
 b=aqMOulBAvl+8xoCgiDgMnbTqfEe79LvSFqONLc7j5PE6Hpuh1hW6OjVpaMaDDCalnUim
 asRk0IBE6JIzsW0gKEpec3FgCSv+4gBMntCJHSqfdnBmCy5rXRn5/tgT0Debk3c5oZVg
 ywFW1sS8IYwPOP1RK4gTQBxMzEoJh1T4kbeURsD6gyvIBPzugWOuT+NJL2j9OX5m1SME
 zZZumUCD5bLXiTFkt0v+jhyyatlDh0HlK3Fu6fHTi5xeEXGr972vRrahzpV5PveXxKWX
 31xMuAnpAko1YAR9rsPFP0oh3/YyYzbjxVRINoHrOfZwEgFT8YHKIW0oAi8azE1Hor+A bg== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 3100vpkb2f-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 14 May 2020 14:53:08 +0200
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 442B5100034;
        Thu, 14 May 2020 14:53:05 +0200 (CEST)
Received: from Webmail-eu.st.com (sfhdag3node2.st.com [10.75.127.8])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 18F0F2BAE4E;
        Thu, 14 May 2020 14:53:05 +0200 (CEST)
Received: from lmecxl0912.tpe.st.com (10.75.127.47) by SFHDAG3NODE2.st.com
 (10.75.127.8) with Microsoft SMTP Server (TLS) id 15.0.1347.2; Thu, 14 May
 2020 14:52:56 +0200
Subject: Re: [PATCH v3 3/5] ARM: dts: stm32: enable ltdc binding with ili9341
 on stm32429-disco board
To:     Linus Walleij <linus.walleij@linaro.org>, <dillon.minfei@gmail.com>
CC:     Rob Herring <robh+dt@kernel.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        "thierry.reding@gmail.com" <thierry.reding@gmail.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        Dave Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "open list:DRM PANEL DRIVERS" <dri-devel@lists.freedesktop.org>,
        linux-clk <linux-clk@vger.kernel.org>
References: <1589267017-17294-1-git-send-email-dillon.minfei@gmail.com>
 <1589267017-17294-4-git-send-email-dillon.minfei@gmail.com>
 <CACRpkda5VjjBdbruXTi33QBNb=VU6vK2zDE8yyQXoWw7=NQFeg@mail.gmail.com>
From:   Alexandre Torgue <alexandre.torgue@st.com>
Message-ID: <a4ebd7cd-5756-0683-135f-0f96be8a4a7b@st.com>
Date:   Thu, 14 May 2020 14:52:49 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <CACRpkda5VjjBdbruXTi33QBNb=VU6vK2zDE8yyQXoWw7=NQFeg@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.75.127.47]
X-ClientProxiedBy: SFHDAG3NODE1.st.com (10.75.127.7) To SFHDAG3NODE2.st.com
 (10.75.127.8)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.216,18.0.676
 definitions=2020-05-14_03:2020-05-14,2020-05-14 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 5/14/20 10:24 AM, Linus Walleij wrote:
> On Tue, May 12, 2020 at 9:04 AM <dillon.minfei@gmail.com> wrote:
> 
>> From: dillon min <dillon.minfei@gmail.com>
>>
>> Enable the ltdc & ili9341 on stm32429-disco board.
>>
>> Signed-off-by: dillon min <dillon.minfei@gmail.com>
> 
> This mostly looks good but...
> 
>> +&spi5 {
>> +       status = "okay";
>> +       pinctrl-0 = <&spi5_pins>;
>> +       pinctrl-names = "default";
>> +       #address-cells = <1>;
>> +       #size-cells = <0>;
>> +       cs-gpios = <&gpioc 2 GPIO_ACTIVE_LOW>;
>> +       dmas = <&dma2 3 2 0x400 0x0>,
>> +              <&dma2 4 2 0x400 0x0>;
>> +       dma-names = "rx", "tx";
> 
> These DMA assignments seem to be SoC things and should
> rather be in the DTS(I) file where &spi5 is defined, right?
> stm32f429.dtsi I suppose?

I agree with Linus, DMA have to be defined in SoC dtsi. And if a board 
doesn't want to use it, we use the "delete-property".

> 
> It is likely the same no matter which device is using spi5.
> 
> Yours,
> Linus Walleij
> 
