Return-Path: <SRS0=6o4L=5Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC178C2D0EF
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Mar 2020 19:29:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A65BA2072E
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Mar 2020 19:29:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="jMR1MNms"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731422AbgCaT3c (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 31 Mar 2020 15:29:32 -0400
Received: from mailout1.w1.samsung.com ([210.118.77.11]:36163 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729153AbgCaT3c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Mar 2020 15:29:32 -0400
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20200331192930euoutp011a419e23e35fe6e0db53fefafb4b30df~BekKg98Xj1278112781euoutp01Q
        for <linux-kernel@vger.kernel.org>; Tue, 31 Mar 2020 19:29:30 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20200331192930euoutp011a419e23e35fe6e0db53fefafb4b30df~BekKg98Xj1278112781euoutp01Q
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1585682970;
        bh=5TcLSchSxIf6i45hOrft2Axtz8VMmsYHHtpuwr3TN4U=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=jMR1MNmstoKwLnMD+nt7V3BE2skvMfqgtk5JZ2zi6HcLcDZnx3iCJbu110aeEobgy
         YaHhaNiQSesXFg7vngVpeq4jlWlOHSJ1J04VsfLc4/mGmjaEiZvKGp2X8UCmlK9r82
         03rkbNI26dZ9YCSCP9KrPHGpfdoti6D3q2SnHdQ4=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20200331192929eucas1p2504d40d75aa7c063b5a79836ecb7c41d~BekJZ9lfG0078800788eucas1p2Z;
        Tue, 31 Mar 2020 19:29:29 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges1new.samsung.com (EUCPMTA) with SMTP id DF.DA.61286.91A938E5; Tue, 31
        Mar 2020 20:29:29 +0100 (BST)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20200331192928eucas1p20327aab9f22430820b066fe05e310b51~BekJDHR090078100781eucas1p2h;
        Tue, 31 Mar 2020 19:29:28 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20200331192928eusmtrp2577689e1a37335c321c15922ee7664ac~BekJCekFb2625726257eusmtrp2m;
        Tue, 31 Mar 2020 19:29:28 +0000 (GMT)
X-AuditID: cbfec7f2-ef1ff7000001ef66-e3-5e839a19d4d7
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id 6B.D6.08375.81A938E5; Tue, 31
        Mar 2020 20:29:28 +0100 (BST)
Received: from [106.210.88.143] (unknown [106.210.88.143]) by
        eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20200331192928eusmtip19e05c1cd467a4331da0d5e959570b545~BekIVZxgy0318503185eusmtip1V;
        Tue, 31 Mar 2020 19:29:28 +0000 (GMT)
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
Message-ID: <da888000-52b6-b0c6-76ac-8fc535d07a5d@samsung.com>
Date:   Tue, 31 Mar 2020 21:29:24 +0200
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:68.0) Gecko/20100101
        Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <d9fe575926342b355f76e1f38fef62f0d7d38075.camel@gmail.com>
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrIKsWRmVeSWpSXmKPExsWy7djPc7qSs5rjDJ7+5bCYf+Qcq0X/49fM
        FufPb2C32PT4GqvF5V1z2CxmnN/HZLH0+kUmi/7Fl1gsfhzvY7Zo3XuE3WLKkpnsDtwea+at
        YfRYfamdzWPnrLvsHptWdbJ5bF5S7/F5k1wAWxSXTUpqTmZZapG+XQJXxoJrd9gK2sUqzs9a
        zNbAuFiwi5GTQ0LARGLDsS7GLkYuDiGBFYwSU1Z+YoVwvjBKvLo/lwXC+cwo0Tj9CVAZB1jL
        wxd6EPHljBJH7qxig3DeM0o8XvSIBaRIWMBDYv/zZJAVIgJZEs3/usGmMgtsZ5Jo/riPHSTB
        JmAo0fW2iw3E5hWwk1i/9wYLiM0ioCqxftUcJhBbVCBG4uLhflaIGkGJkzOfgNVwCrhLfOzb
        B1bDLCAv0bx1NjOELS5x68l8JojfbrFLHH3gDWG7SHybeZENwhaWeHV8CzuELSPxfydIPReQ
        3cwo8fDcWnYIp4dR4nLTDEaIKmuJO+d+sYF8xiygKbF+lz4kJBwl3t6UgDD5JG68FYQ4gU9i
        0rbpzBBhXomONiGIGWoSs46vg9t68MIl5gmMSrOQPDYLyTOzkDwzC2HtAkaWVYziqaXFuemp
        xYZ5qeV6xYm5xaV56XrJ+bmbGIEJ6/S/4592MH69lHSIUYCDUYmHt8KmOU6INbGsuDL3EKME
        B7OSCC+bf0OcEG9KYmVValF+fFFpTmrxIUZpDhYlcV7jRS9jhQTSE0tSs1NTC1KLYLJMHJxS
        DYzs+s1LHx7xc1ddEKG2vyi4NPNUXNOmhM1P+uZPNQjb83LnUpsNk/e5flpuzOocOV8qJCA2
        sV/SJmS+iF7u8vJ/kxiTol7cFFy09Omt1vD7G2+zPN3fs/P+rVKnXsm/dRWfXWt3GyoEhDMG
        rWmq/DpbWXON9ZLClUu9+14JPnXK/utwM/nh/BAlluKMREMt5qLiRABB9k9WVAMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrCIsWRmVeSWpSXmKPExsVy+t/xu7oSs5rjDDb+1beYf+Qcq0X/49fM
        FufPb2C32PT4GqvF5V1z2CxmnN/HZLH0+kUmi/7Fl1gsfhzvY7Zo3XuE3WLKkpnsDtwea+at
        YfRYfamdzWPnrLvsHptWdbJ5bF5S7/F5k1wAW5SeTVF+aUmqQkZ+cYmtUrShhZGeoaWFnpGJ
        pZ6hsXmslZGpkr6dTUpqTmZZapG+XYJexoJrd9gK2sUqzs9azNbAuFiwi5GDQ0LAROLhC70u
        Ri4OIYGljBLrDlxh7WLkBIrLSJyc1gBlC0v8udbFBlH0llGis3ETG0izsICHxP7nySA1IgJZ
        Ejuef2cCqWEW2M4ksXbTOmaQhJDALWaJvq2MIDabgKFE11uQQZwcvAJ2Euv33mABsVkEVCXW
        r5rDBGKLCsRI/NzTxQJRIyhxcuYTMJtTwF3iY98+sBpmATOJeZsfMkPY8hLNW2dD2eISt57M
        Z5rAKDQLSfssJC2zkLTMQtKygJFlFaNIamlxbnpusaFecWJucWleul5yfu4mRmCMbjv2c/MO
        xksbgw8xCnAwKvHwVtg0xwmxJpYVV+YeYpTgYFYS4WXzb4gT4k1JrKxKLcqPLyrNSS0+xGgK
        9NxEZinR5Hxg+sgriTc0NTS3sDQ0NzY3NrNQEuftEDgYIySQnliSmp2aWpBaBNPHxMEp1cCo
        41Z7aBKLf5Ifh6jK9ZURW84xvo6pfnG7p6rY5qCi0MJftduEqt+frJ5ZMu3B8e/HtsdU/z2w
        ptRz113N/9e0vpxTcDz499Err80hPfvO+QQuKN9lp7hku1TwnE/WnQ49Nq1dRztXbPDZeuWd
        jufnwz1+/JqzZqhGbnirwPDlytp9fpYmc849V2Ipzkg01GIuKk4EAESzMbnnAgAA
X-CMS-MailID: 20200331192928eucas1p20327aab9f22430820b066fe05e310b51
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
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi

On 2020-03-31 17:29, Paweł Chmiel wrote:
> On Tue, 2020-03-31 at 15:55 +0200, Marek Szyprowski wrote:
>> Hi Paul,
>>
>> On 2020-03-31 15:09, Paul Cercueil wrote:
>>> Cc: Paweł Chmiel <pawel.mikolaj.chmiel@gmail.com>
>>>
>>> Hi Marek,
>>>
>>> Le mar. 31 mars 2020 à 7:36, Marek Szyprowski
>>> <m.szyprowski@samsung.com> a écrit :
>>>> Hi Paul,
>>>>
>>>> On 2020-03-18 15:25, Paul Cercueil wrote:
>>>>>>>    +    };
>>>>>>>    +
>>>>>>>    +    tsp_reg: regulator-1 {
>>>>>>>    +        compatible = "regulator-fixed";
>>>>>>>    +        regulator-name = "TSP_FIXED_VOLTAGES";
>>>>>>>    +        regulator-min-microvolt = <3300000>;
>>>>>>>    +        regulator-max-microvolt = <3300000>;
>>>>>>>    +        gpio = <&gpl0 3 GPIO_ACTIVE_HIGH>;
>>>>>>>    +        startup-delay-us = <70000>;
>>>>>>>    +        enable-active-high;
>>>>>>>    +        regulator-boot-on;
>>>>>>>    +        regulator-always-on;
>>>>>>   always-on and boot-on should not be needed. You have a consumer
>>>>>> for this
>>>>>>   regulator.
>>>>>   About this: the touchscreen driver does not use a regulator, so I
>>>>>   believe that's why these properties were here.
>>>>>
>>>>>   I sent patches upstream to address the issue:
>>>>>   https://protect2.fireeye.com/url?k=e8aedc29-b53072b3-e8af5766-0cc47a336fae-759579fd576d8382&u=https://lkml.org/lkml/2020/3/15/94
>>>>>
>>>>>
>>>>>   I believe this means I cannot merge the i9100 devicetree until it is
>>>>>   acked.
>>>> One more information - similar change has been already posted, but it
>>>> looks it got lost then: https://patchwork.kernel.org/patch/10550903/
>>> I was aware of this patch, but didn't know it was sent upstream.
>>>
>>> This other patch uses two regulators, vdd/avdd but doesn't give any
>>> reason why.
>>>
>> I've checked the UniversalC210 schematic, which uses the same
>> touchscreen chip. There are 2 supplies to the touchscreen chip: 2.8V VDD
>> and 3.3V AVDD. Both are enabled by the same GPIO pin though. There is
>> however no reset GPIO pin there.
> Hi
> Don't remember now how it worked on Galaxy S1, but it looks like it has
> the same setup - two regulators enabled by one GPIO pin.

It is quite common for the regulators to share the enable GPIO line, so 
this is not an issue. Regulator framework supports such configuration 
for ages. I'm curious about the reset GPIO line, which were made 
mandatory for the regulators control in your patch. I didn't find it on 
any schematic of the devices with this touch screen, but I don't have a 
schematic of the Galaxy S1. IMHO the reset signal is simply derived from 
the supply regulators with some simple circuit, but I don't have 
schematic of that part.

Best regards
-- 
Marek Szyprowski, PhD
Samsung R&D Institute Poland

