Return-Path: <SRS0=CUu6=46=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15F3EC5ACC0
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Mar 2020 15:24:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D306220724
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Mar 2020 15:24:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="dY23mrXe"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726984AbgCMPYQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Mar 2020 11:24:16 -0400
Received: from mailout1.w1.samsung.com ([210.118.77.11]:36366 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726861AbgCMPYQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Mar 2020 11:24:16 -0400
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20200313152414euoutp0177a94687995debba946cae65f4b17a83~75m4FZ7jv0220202202euoutp01N
        for <linux-kernel@vger.kernel.org>; Fri, 13 Mar 2020 15:24:14 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20200313152414euoutp0177a94687995debba946cae65f4b17a83~75m4FZ7jv0220202202euoutp01N
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1584113054;
        bh=aWYruqPImE2yRmXAc06ncHutY2ccoXbCh2dVKoEvLqE=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=dY23mrXeK+TjyGvUcklE9Xu4poah7S023VJU5+YECWUVljGdZrmogd+vabxJLXkHd
         IgFsIpLOtlDdtq8WiclaYSdToTdFylChYOZCQeUc/ihSc6B8q6++24B8K6/bFnIpZS
         YAon+tfZ0GeKIMupnHwy6ZC0U3Q70KrwuEZrKtas=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20200313152413eucas1p228ff0292a076a20865747d2f7b92dfed~75m3zUxlM0602106021eucas1p2K;
        Fri, 13 Mar 2020 15:24:13 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges1new.samsung.com (EUCPMTA) with SMTP id F9.09.61286.D95AB6E5; Fri, 13
        Mar 2020 15:24:13 +0000 (GMT)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20200313152413eucas1p2f4d16175542741285150966a2e2ad151~75m3YCfU50602106021eucas1p2G;
        Fri, 13 Mar 2020 15:24:13 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20200313152413eusmtrp17e6cfb72f3f5b7d25ebafa902dd67a9d~75m3UcAv20468004680eusmtrp1G;
        Fri, 13 Mar 2020 15:24:13 +0000 (GMT)
X-AuditID: cbfec7f2-ef1ff7000001ef66-3b-5e6ba59dde66
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id 56.FC.08375.D95AB6E5; Fri, 13
        Mar 2020 15:24:13 +0000 (GMT)
Received: from [106.120.51.15] (unknown [106.120.51.15]) by
        eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20200313152412eusmtip2c36baa481c0ed00df010fc32f765ac86~75m22hhje1905919059eusmtip2N;
        Fri, 13 Mar 2020 15:24:12 +0000 (GMT)
Subject: Re: [PATCH 2/2] ARM: DTS: Add devicetree file for the Galaxy S2
To:     Paul Cercueil <paul@crapouillou.net>,
        Krzysztof Kozlowski <krzk@kernel.org>
Cc:     Kukjin Kim <kgene@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Stenkin Evgeniy <stenkinevgeniy@gmail.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
From:   Marek Szyprowski <m.szyprowski@samsung.com>
Message-ID: <fbc3b48c-9f99-5ce2-0a7b-3d879588ab4c@samsung.com>
Date:   Fri, 13 Mar 2020 16:24:12 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
        Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <1584110014.3.1@crapouillou.net>
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrDKsWRmVeSWpSXmKPExsWy7djPc7pzl2bHGcx8amgx/8g5Vov+x6+Z
        Lc6f38BusenxNVaLy7vmsFnMOL+PyWLp9YtMFv2LL7FYtO49wm4xZclMdgcujzXz1jB6rL7U
        zuaxc9Zddo9NqzrZPDYvqff4vEkugC2KyyYlNSezLLVI3y6BK+NC+xKmgnN8Fd8/9LI2ML7i
        7mLk4JAQMJF4NCe4i5GLQ0hgBaPEspvvmCGcL4wSz3sPQzmfGSW+tExn6mLkBOs4/vw/C0Ri
        OaPE4WnzWCGct4wS71rvs4HMFRbwkNj/PBmkQUQgUOL0hNesIDazwFwmievbTEBsNgFDia63
        XWDlvAJ2EgevWYKEWQRUJWZv3soMYosKxErMXnmYBcTmFRCUODnzCZjNKaArceZMKzPESHmJ
        5q2zoWxxiVtP5jOBnCMhcIld4tGU42wQR7tIrL3TwA5hC0u8Or4FypaROD25hwWioZlR4uG5
        tewQTg+jxOWmGYwQVdYSd879AruUWUBTYv0ufYiwo8TF3umMkHDkk7jxVhDiCD6JSdumM0OE
        eSU62oQgqtUkZh1fB7f24IVLzBMYlWYheW0WkndmIXlnFsLeBYwsqxjFU0uLc9NTiw3zUsv1
        ihNzi0vz0vWS83M3MQLT1Ol/xz/tYPx6KekQowAHoxIPb0RqdpwQa2JZcWXuIUYJDmYlEd6O
        GqAQb0piZVVqUX58UWlOavEhRmkOFiVxXuNFL2OFBNITS1KzU1MLUotgskwcnFINjGkHP4k+
        PfXZOfDtC6Hmye/UdUpFX3z7Ye716HJfgcOch7f8ndeVXQsweNj8zOoOY7qloLR80qLHkxp1
        D1sEGWSXlvP8+DN928k72uLu79cU35Kte+4851/EP5OCB+ISL+7GJfO6C585l+YfaTDh78vc
        qgpnjdsn7H2fSVfnX/p5e+LKz/ejA5RYijMSDbWYi4oTAYjqyBFPAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrAIsWRmVeSWpSXmKPExsVy+t/xe7pzl2bHGaw5w28x/8g5Vov+x6+Z
        Lc6f38BusenxNVaLy7vmsFnMOL+PyWLp9YtMFv2LL7FYtO49wm4xZclMdgcujzXz1jB6rL7U
        zuaxc9Zddo9NqzrZPDYvqff4vEkugC1Kz6Yov7QkVSEjv7jEVina0MJIz9DSQs/IxFLP0Ng8
        1srIVEnfziYlNSezLLVI3y5BL+NC+xKmgnN8Fd8/9LI2ML7i7mLk5JAQMJE4/vw/SxcjF4eQ
        wFJGiVXzF7BAJGQkTk5rYIWwhSX+XOtigyh6zSjRcqqFuYuRg0NYwENi//NkkBoRgUCJLf83
        gdUwC8xnkpj06h0zRMMfRoljn94yg1SxCRhKdL0FmcTBwStgJ3HwmiVImEVAVWL25q1gJaIC
        sRI3ZnYwgdi8AoISJ2c+ATuIU0BX4syZVrAaZgEziXmbH0LZ8hLNW2dD2eISt57MZ5rAKDQL
        SfssJC2zkLTMQtKygJFlFaNIamlxbnpusaFecWJucWleul5yfu4mRmBsbjv2c/MOxksbgw8x
        CnAwKvHwRqRmxwmxJpYVV+YeYpTgYFYS4e2oAQrxpiRWVqUW5ccXleakFh9iNAV6biKzlGhy
        PjBt5JXEG5oamltYGpobmxubWSiJ83YIHIwREkhPLEnNTk0tSC2C6WPi4JRqYBTe/0NrfUry
        pHd9k7NPyvJq3DKTbJux1U3j3XENpq686Mb1Qea/dE7dfLgi+XNh2p8VCsUfnrTv7/HYv+/z
        0cpZ9++9WZAQ7qTnW5dXOdug/k/o2kX/vafcYNJ9OHH6La3QhdkOXBMLVzhlvc7rWPYy/KLv
        pJDeU7VzzGTsvgrGaX7JrVlTLaHEUpyRaKjFXFScCADoGegu4wIAAA==
X-CMS-MailID: 20200313152413eucas1p2f4d16175542741285150966a2e2ad151
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20200313143349eucas1p22d40f6966299ffdf132f0f2e488e8c11
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20200313143349eucas1p22d40f6966299ffdf132f0f2e488e8c11
References: <20200312153411.13535-1-paul@crapouillou.net>
        <20200312153411.13535-2-paul@crapouillou.net> <20200313090011.GB7416@pi3>
        <CGME20200313143349eucas1p22d40f6966299ffdf132f0f2e488e8c11@eucas1p2.samsung.com>
        <1584110014.3.1@crapouillou.net>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Paul,

On 13.03.2020 15:33, Paul Cercueil wrote:
> Hi Krzysztof,
>
>
> Le ven., mars 13, 2020 at 10:00, Krzysztof Kozlowski <krzk@kernel.org> 
> a écrit :
>> On Thu, Mar 12, 2020 at 04:34:11PM +0100, Paul Cercueil wrote:
>>>  From: Stenkin Evgeniy <stenkinevgeniy@gmail.com>
>>>
>>>  Add devicetree file for the Exynos 4210 based Galaxy S2 (i9100 
>>> version).

 > [...]

>  +
>>>  +
>>>  +    memory@40000000 {
>>>  +        device_type = "memory";
>>>  +        reg = <0x40000000 0x40000000>;
>>>  +    };
>>>  +
>>
>> You do not have a chosen node, at least for stdout serial selection.
>> Probably you should have one... bootargs I guess could come from
>> bootloader.
>
> Problem is, I have no idea which UART is available via the USB jig :)

See exynos4210-trats.dts and exynos4210-universal_c210.dts, they are 
similar to i9100 and share a lots. They all use serial2 for debug UART 
via USB jig.

>>>  +    vemmc_reg: regulator-0 {
>>>  +        compatible = "regulator-fixed";
>>>  +        regulator-name = "VMEM_VDD_2.8V";
>>>  +        regulator-min-microvolt = <2800000>;
>>>  +        regulator-max-microvolt = <2800000>;
>>>  +        gpio = <&gpk0 2 GPIO_ACTIVE_HIGH>;
>>>  +        enable-active-high;
>>
>> This looks like a stub/fake regulator. Probably it shoould be replaced
>> with proper regulator coming from PMIC (few seems to be missing there).
>>
>> I don't have the schematics so I cannot judge... I see Trats has the
>> same.
>>
>> Marek, mayybe you know, is it really a separate regulator?

Trats has the same regulator and according to the schematic it is 
supplied from VBAT and controlled via eMMC_EN GPIO pin.

> > [...]

Best regards
-- 
Marek Szyprowski, PhD
Samsung R&D Institute Poland

