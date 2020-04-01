Return-Path: <SRS0=sqB7=5R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A094C2D0F1
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Apr 2020 10:42:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 42D0C2078B
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Apr 2020 10:42:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="AxuVWVF0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732249AbgDAKmU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Apr 2020 06:42:20 -0400
Received: from mailout2.w1.samsung.com ([210.118.77.12]:35126 "EHLO
        mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732205AbgDAKmS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Apr 2020 06:42:18 -0400
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20200401104216euoutp0272f7a51bc41120f8522ff027c04bc745~BrBHd8I1b2183521835euoutp02U
        for <linux-kernel@vger.kernel.org>; Wed,  1 Apr 2020 10:42:16 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20200401104216euoutp0272f7a51bc41120f8522ff027c04bc745~BrBHd8I1b2183521835euoutp02U
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1585737736;
        bh=oyvVweq5rCiDPBSGX/iNsRaVRSr4YFX/8gSUUJ9l9Q0=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=AxuVWVF0aHtmon6aJeXK7ikknqCLJFP71oL2tIJDSM2Xl0BiG0Oxo9Ig5hSooloyE
         ou6QmNw5gZ484ePL6tlD/EFugTZ3jOa4wkidl8aF76GdP4VASWoyz293BN05hYOEYl
         pUnYNBNR6ouQSge3fSzAtRMQIQ+Jf/5a8OJjzvbI=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20200401104216eucas1p28a74dac22aa3c201c6eb96e34a4a16de~BrBHIgWHA1417914179eucas1p2g;
        Wed,  1 Apr 2020 10:42:16 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges1new.samsung.com (EUCPMTA) with SMTP id 5E.AD.61286.800748E5; Wed,  1
        Apr 2020 11:42:16 +0100 (BST)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20200401104215eucas1p158e002d4deb038641d6afd1e3c32e645~BrBGrmoak2926129261eucas1p1z;
        Wed,  1 Apr 2020 10:42:15 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20200401104215eusmtrp20567d4a5acd37bf9460647f0ff72b5bf~BrBGq4j901756017560eusmtrp2L;
        Wed,  1 Apr 2020 10:42:15 +0000 (GMT)
X-AuditID: cbfec7f2-f0bff7000001ef66-30-5e84700831fd
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id C3.97.08375.700748E5; Wed,  1
        Apr 2020 11:42:15 +0100 (BST)
Received: from [106.210.88.143] (unknown [106.210.88.143]) by
        eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20200401104215eusmtip2b90557b660a45ba9b36077a5153523b8~BrBGCvaM_2190421904eusmtip2O;
        Wed,  1 Apr 2020 10:42:14 +0000 (GMT)
Subject: Re: [PATCH 2/2] ARM: DTS: Add devicetree file for the Galaxy S2
To:     =?UTF-8?Q?Pawe=c5=82_Chmiel?= <pawel.mikolaj.chmiel@gmail.com>,
        Paul Cercueil <paul@crapouillou.net>
Cc:     Krzysztof Kozlowski <krzk@kernel.org>,
        Kukjin Kim <kgene@kernel.org>,
        Rob Herring <robh+dt@kernel.org>, mark.rutland@arm.com,
        Stenkin Evgeniy <stenkinevgeniy@gmail.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
From:   Marek Szyprowski <m.szyprowski@samsung.com>
Message-ID: <ba6ecdaf-35cf-6d97-47ad-5e9e7af292a5@samsung.com>
Date:   Wed, 1 Apr 2020 12:42:14 +0200
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:68.0) Gecko/20100101
        Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <8a77ca985214cb0058e4defe4dcaa27a79eafacc.camel@gmail.com>
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Brightmail-Tracker: H4sIAAAAAAAAA02Sa0gUYRSG+3ZmZ0Zz43M1PFkULCEYqFn+GEpEU3MpKI36UXlpcwevq7br
        NYjMNS0zFY3UVVJKU7wV62XVylCXTItVV/KG/ogVQ8vEVFAJy3Gw/Pec873nvO+BjyGk3WJH
        JioukVPHKWJllDXZ9mHd5MIkZIYen26m2QqjSczmW74T7ODga5rVW0bF7EhnOcWWDHaJ2Oqx
        YRGb/8JMsmt9eQR7/52RZp9UldLee+UNzxqQvN6cTck7dNO0XF/3kJI3V92VL+sPB1LXrD2V
        XGxUMqd287phHfm2Lp9MMB9IbTcYROmo3D4HWTGAPWCkoB7lIGtGimsRGAfmKaFYQTDdvkEI
        xTKCRsuqeGdkcUBL8yzFNQiahjwE0SKCnxbTlohh7LAc3n8L5zX2OBq0m4/EvIbABhFol7q2
        hynsDjkLORSvl2AvMOVd5dskPgq9RW0Uz/txMAz35m/7SrAt9JfOkDxb4QCoNnzZXkPgI6Bt
        LSMEdoDJmQoR7wV4kob64RJSCO0HhQW1lMB2MN/XQgt8CP507AxoEXw1NdJCkYtgJKMECarT
        MGXa2E5KYGd41enGI2AfWJgAAffB+IKtkGEfFLYVE0JbAg+ypMIOJ9D1Nf1z7R4yEwVIptt1
        mW7XNbpd1+j+21Yisg45cEkaVQSncY/jUlw1CpUmKS7CNTxepUdbH+vTZt+vdrRqvtmDMINk
        NpLUyMxQqViRrElT9SBgCJm9pMxvqyVRKtJuc+r4MHVSLKfpQQcZUuYgOfl8LkSKIxSJXAzH
        JXDqnVcRY+WYjvZ4ZTn5pwQ2V6+4nC/6fSost3QMZxeNO59NGfXNyPP5eGHOu17ZH8SsnbHZ
        8FyTym9NaYcSK4uzVCO65eiApYErrcE1JmXY9RMFonvGde+YcSJLdu7xy0sJviFPDXem3lQt
        oujyJcY/PDPIHJQ7K76o//wjb6JmymnCO2y2ZfKyjNREKtyPEWqN4i8c5ZHUVAMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrCIsWRmVeSWpSXmKPExsVy+t/xe7rsBS1xBhcuqVvMP3KO1aL/8Wtm
        i/PnN7BbbHp8jdXi8q45bBYzzu9jslh6/SKTRf/iSywWP473MVu07j3CbjFlyUx2B26PNfPW
        MHqsvtTO5rFz1l12j02rOtk8Ni+p9/i8SS6ALUrPpii/tCRVISO/uMRWKdrQwkjP0NJCz8jE
        Us/Q2DzWyshUSd/OJiU1J7MstUjfLkEvY8+qfpaCS5IVO7ZvZ2pgnCPSxcjJISFgIvH+VDM7
        iC0ksJRR4sERQYi4jMTJaQ2sELawxJ9rXWxdjFxANW8ZJSY+m87YxcjBISzgIbH/eTJIjYhA
        lsSO59+ZQGqYBbYzSazdtI4ZouEMi8SdvrfMIFVsAoYSXW9BJnFw8ArYSZzriwQJswioSBye
        vI0NxBYViJH4uaeLBcTmFRCUODnzCZjNKeAusXT7VbBDmQXMJOZtfsgMYctLNG+dDWWLS9x6
        Mp9pAqPQLCTts5C0zELSMgtJywJGllWMIqmlxbnpucWGesWJucWleel6yfm5mxiBMbrt2M/N
        OxgvbQw+xCjAwajEw1uR0RInxJpYVlyZe4hRgoNZSYR3tgtQiDclsbIqtSg/vqg0J7X4EKMp
        0HMTmaVEk/OB6SOvJN7Q1NDcwtLQ3Njc2MxCSZy3Q+BgjJBAemJJanZqakFqEUwfEwenVAOj
        qsuJ56dr8sULTy09PjNP7OfmOx7fzzVe0rRL//Hmn+8vseVXPvwv3zKfKyeqavoSaeuy4sBv
        X/1u8kp9jOXdoZ2XITY19NG6VyV6UsWhjErHi7dPvDgl/aTpO/1PXf3zPicHV9aI3u4zVfNw
        /LLoooHPzSL2lDKPmVozbCoql3WaLG19HHVIiaU4I9FQi7moOBEAS0wsk+cCAAA=
X-CMS-MailID: 20200401104215eucas1p158e002d4deb038641d6afd1e3c32e645
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20200318142549eucas1p1793027850923ebad20b4691cba676671
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20200318142549eucas1p1793027850923ebad20b4691cba676671
References: <20200312153411.13535-1-paul@crapouillou.net>
        <20200312153411.13535-2-paul@crapouillou.net> <20200313090011.GB7416@pi3>
        <CGME20200318142549eucas1p1793027850923ebad20b4691cba676671@eucas1p1.samsung.com>
        <D6.31.03891.A6F227E5@epmailinsp8.samsung.com>
        <6c549058-00f9-8526-a272-48c538166ccf@samsung.com>
        <X7728Q.UX8A28S31JO92@crapouillou.net>
        <6ca59c1b-2676-e69d-e4eb-4667a81d155f@samsung.com>
        <d9fe575926342b355f76e1f38fef62f0d7d38075.camel@gmail.com>
        <da888000-52b6-b0c6-76ac-8fc535d07a5d@samsung.com>
        <8a77ca985214cb0058e4defe4dcaa27a79eafacc.camel@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Paweł,

On 2020-03-31 21:50, Paweł Chmiel wrote:
> On Tue, 2020-03-31 at 21:29 +0200, Marek Szyprowski wrote:
>> On 2020-03-31 17:29, Paweł Chmiel wrote:
>>> On Tue, 2020-03-31 at 15:55 +0200, Marek Szyprowski wrote:
>>>> On 2020-03-31 15:09, Paul Cercueil wrote:
>>>>> Le mar. 31 mars 2020 à 7:36, Marek Szyprowski
>>>>> <m.szyprowski@samsung.com> a écrit :
>>>>>> On 2020-03-18 15:25, Paul Cercueil wrote:
>>>>>>>>>     +    };
>>>>>>>>>     +
>>>>>>>>>     +    tsp_reg: regulator-1 {
>>>>>>>>>     +        compatible = "regulator-fixed";
>>>>>>>>>     +        regulator-name = "TSP_FIXED_VOLTAGES";
>>>>>>>>>     +        regulator-min-microvolt = <3300000>;
>>>>>>>>>     +        regulator-max-microvolt = <3300000>;
>>>>>>>>>     +        gpio = <&gpl0 3 GPIO_ACTIVE_HIGH>;
>>>>>>>>>     +        startup-delay-us = <70000>;
>>>>>>>>>     +        enable-active-high;
>>>>>>>>>     +        regulator-boot-on;
>>>>>>>>>     +        regulator-always-on;
>>>>>>>>    always-on and boot-on should not be needed. You have a consumer
>>>>>>>> for this
>>>>>>>>    regulator.
>>>>>>>    About this: the touchscreen driver does not use a regulator, so I
>>>>>>>    believe that's why these properties were here.
>>>>>>>
>>>>>>>    I sent patches upstream to address the issue:
>>>>>>>    https://protect2.fireeye.com/url?k=e8aedc29-b53072b3-e8af5766-0cc47a336fae-759579fd576d8382&u=https://lkml.org/lkml/2020/3/15/94
>>>>>>>
>>>>>>>
>>>>>>>    I believe this means I cannot merge the i9100 devicetree until it is
>>>>>>>    acked.
>>>>>> One more information - similar change has been already posted, but it
>>>>>> looks it got lost then: https://patchwork.kernel.org/patch/10550903/
>>>>> I was aware of this patch, but didn't know it was sent upstream.
>>>>>
>>>>> This other patch uses two regulators, vdd/avdd but doesn't give any
>>>>> reason why.
>>>>>
>>>> I've checked the UniversalC210 schematic, which uses the same
>>>> touchscreen chip. There are 2 supplies to the touchscreen chip: 2.8V VDD
>>>> and 3.3V AVDD. Both are enabled by the same GPIO pin though. There is
>>>> however no reset GPIO pin there.
>>> Hi
>>> Don't remember now how it worked on Galaxy S1, but it looks like it has
>>> the same setup - two regulators enabled by one GPIO pin.
>> It is quite common for the regulators to share the enable GPIO line, so
>> this is not an issue. Regulator framework supports such configuration
>> for ages. I'm curious about the reset GPIO line, which were made
>> mandatory for the regulators control in your patch. I didn't find it on
>> any schematic of the devices with this touch screen, but I don't have a
>> schematic of the Galaxy S1. IMHO the reset signal is simply derived from
>> the supply regulators with some simple circuit, but I don't have
>> schematic of that part.
> Hi
> Regarding this change - it was suggested during review of v1 version of
> those patches. It's first reply here
> https://patchwork.kernel.org/patch/10524007/

Well, I know that this has been requested in v1 review, but I thought 
that you have tested v3 of your patch on I9000, thus I was curious about 
that reset GPIO line.

Best regards
-- 
Marek Szyprowski, PhD
Samsung R&D Institute Poland

