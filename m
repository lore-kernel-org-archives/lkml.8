Return-Path: <SRS0=6o4L=5Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B21FC2D0F0
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Mar 2020 13:55:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 55A4B20784
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Mar 2020 13:55:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="ordyPWYp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730915AbgCaNzf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 31 Mar 2020 09:55:35 -0400
Received: from mailout1.w1.samsung.com ([210.118.77.11]:53392 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730420AbgCaNze (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Mar 2020 09:55:34 -0400
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20200331135533euoutp01ade0505e123870c1dcb88a58fa933a08~BaAlXbCIC1924719247euoutp01d
        for <linux-kernel@vger.kernel.org>; Tue, 31 Mar 2020 13:55:33 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20200331135533euoutp01ade0505e123870c1dcb88a58fa933a08~BaAlXbCIC1924719247euoutp01d
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1585662933;
        bh=eLAV6rJTvPK37Qjgr9MT4qBTJmPhi+qYspTzF9BjccM=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=ordyPWYpv8IaNOgwBviRSrViyperps4qnBK8UvIedLJv9UdwQqHmUnJ7Ih5D0DXG0
         2GKxTE7lECSi0FvVeUts1a69dwHh54jQkzwY3mTym0HZnFsFmi+qRY8v1m9N9XClnh
         CqhVFC0qWX2SkEkNJuP3y+FOBcbD3vbFXimP7Vv0=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20200331135532eucas1p21abe4721e7f75c524f78346b0532676b~BaAlLOw402654426544eucas1p2Q;
        Tue, 31 Mar 2020 13:55:32 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges3new.samsung.com (EUCPMTA) with SMTP id 6F.72.60698.4DB438E5; Tue, 31
        Mar 2020 14:55:32 +0100 (BST)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20200331135532eucas1p1e64e7b122de756d54bc28abaea41dd08~BaAkuujy62016720167eucas1p17;
        Tue, 31 Mar 2020 13:55:32 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20200331135532eusmtrp1d9784225ee78473c7434897f705a0418~BaAkuEui92490124901eusmtrp1u;
        Tue, 31 Mar 2020 13:55:32 +0000 (GMT)
X-AuditID: cbfec7f5-a0fff7000001ed1a-01-5e834bd4789f
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id AB.0E.08375.4DB438E5; Tue, 31
        Mar 2020 14:55:32 +0100 (BST)
Received: from [106.210.88.143] (unknown [106.210.88.143]) by
        eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20200331135531eusmtip2152bcfe35dd0ab3049509c085051f934~BaAkEdcUv2932629326eusmtip2U;
        Tue, 31 Mar 2020 13:55:31 +0000 (GMT)
Subject: Re: [PATCH 2/2] ARM: DTS: Add devicetree file for the Galaxy S2
To:     Paul Cercueil <paul@crapouillou.net>
Cc:     Krzysztof Kozlowski <krzk@kernel.org>,
        Kukjin Kim <kgene@kernel.org>,
        =?UTF-8?Q?Pawe=c5=82_Chmiel?= <pawel.mikolaj.chmiel@gmail.com>,
        Rob Herring <robh+dt@kernel.org>, mark.rutland@arm.com,
        Stenkin Evgeniy <stenkinevgeniy@gmail.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
From:   Marek Szyprowski <m.szyprowski@samsung.com>
Message-ID: <6ca59c1b-2676-e69d-e4eb-4667a81d155f@samsung.com>
Date:   Tue, 31 Mar 2020 15:55:28 +0200
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:68.0) Gecko/20100101
        Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <X7728Q.UX8A28S31JO92@crapouillou.net>
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Brightmail-Tracker: H4sIAAAAAAAAA02SWUwTURSGczvTmaFaHArKCRrRGoiQCBLETBQVEh9qfNAXjRK2ChMgsjQd
        Vn0QrKA2KASJloLFSImILFqBCBFURBBRKgXZAhoDpizBGtkEl9hxRHn7zjn/Wf6bS2Gyp2I3
        Ki4xmVUnKuPlhARvaF8y7+g7rAnfqV0OYErbusVM3tg0xpjN90nGNNYvZnqbSghGZ24RMeUD
        PSImr8yCM986rmJMdnMbyRQai8igNYoqQxVS3LNcJBSN+lFSYaq8TCgeGs8pZk2bjxIhksBo
        Nj4ulVX77o+UxN59n4updHT6A/McnolMUi2iKKB3Qc6XbVokoWR0BYI378ZxLXKwB3MI6h4z
        QmEWQe+FOXKlodqGC/k7CCayfiIhsCEwmMsQL3KmFfDEGsUPcqG3g3GymeA1GL0kgqGhQcQX
        CNoPtDNagmcpvR9GS6fFPOO0BxjqS0U8r6dDoed5nljQOEFnkXCdA+0Pn/O7SZ4x2h009cWY
        wK4wPM73SuyH9pMw9ar8zwKgD8KkrvMvO8NURx0p8CboupaLCw0aBB+7q0khyLV7Pq9Dgmov
        jHQvE7w1jPaC2iZf4SmCYWYIBHSEwRkn4QZHKGi4gQlpKVzKkQkzPEHfUfNv67O3FiwfyfWr
        nOlXudGvcqP/v/YWwiuRK5vCJcSwnH8im+bDKRO4lMQYn6ikBBOy/6uuXx3zj1DLj1OtiKaQ
        fK00PVATLhMrU7mMhFYEFCZ3kRJHMsNl0mhlxhlWnRShTolnuVa0kcLlrlL/25NhMjpGmcye
        ZlkVq16piigHt0zkk9UZnL81QronvSHixbEtr5v1aaEq92lrcAgetMj1WF+GZRuC5ZFGjb5F
        M7bhrK3kpC1JHTMsCrLuK144pAuosYyUBRwwL1gyvitPVHzIW1R5ehsietnar7sD2YrCKcbV
        w8M0P3HlUxJR2njzON7XfN1WUOtFDJRPZ1vb3dbJcS5W6eeNqTnlb1PUR6pTAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrCIsWRmVeSWpSXmKPExsVy+t/xe7pXvJvjDDbMEbOYf+Qcq0X/49fM
        FufPb2C32PT4GqvF5V1z2CxmnN/HZLH0+kUmi/7Fl1gsfhzvY7Zo3XuE3WLKkpnsDtwea+at
        YfRYfamdzWPnrLvsHptWdbJ5bF5S7/F5k1wAW5SeTVF+aUmqQkZ+cYmtUrShhZGeoaWFnpGJ
        pZ6hsXmslZGpkr6dTUpqTmZZapG+XYJexsp7PcwFMwQqNp7/wtLAuIm3i5GDQ0LARGLte5Yu
        Ri4OIYGljBLb519k7WLkBIrLSJyc1gBlC0v8udbFBlH0llFi+t7rTCDNwgIeEvufJ4PUiAho
        SCx5uReshlngJ5PExOsL2UASQgIvmCS6JiSA2GwChhJdb7vA4rwCdhJ3578GW8AioCoxb+t8
        JhBbVCBG4ueeLhaIGkGJkzOfgNmcAsYS7yacYwexmQXMJOZtfsgMYctLNG+dDWWLS9x6Mp9p
        AqPQLCTts5C0zELSMgtJywJGllWMIqmlxbnpucWGesWJucWleel6yfm5mxiBMbrt2M/NOxgv
        bQw+xCjAwajEw1th0xwnxJpYVlyZe4hRgoNZSYSXzb8hTog3JbGyKrUoP76oNCe1+BCjKdBz
        E5mlRJPzgekjryTe0NTQ3MLS0NzY3NjMQkmct0PgYIyQQHpiSWp2ampBahFMHxMHp1QDo67k
        l6UaJeIpHScUDq2cYOBdm6H4nvk0y8YojajzxYIH/CJf7Xu4saHu67eoJsHQb+3Tz9xrjGS2
        FbyV3Fxw48FC/pO5W61nvdjx1ZHd67xLEvO5o+zxt61MyrseBPBxbrGt0WlWeij3Q0/knP3y
        zc0/+35HLP9gKXO8nvWp/2KzlvdXF/ivUmIpzkg01GIuKk4EAGng0CvnAgAA
X-CMS-MailID: 20200331135532eucas1p1e64e7b122de756d54bc28abaea41dd08
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
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Paul,

On 2020-03-31 15:09, Paul Cercueil wrote:
> Cc: Paweł Chmiel <pawel.mikolaj.chmiel@gmail.com>
>
> Hi Marek,
>
> Le mar. 31 mars 2020 à 7:36, Marek Szyprowski 
> <m.szyprowski@samsung.com> a écrit :
>> Hi Paul,
>>
>> On 2020-03-18 15:25, Paul Cercueil wrote:
>>>>>   +    };
>>>>>   +
>>>>>   +    tsp_reg: regulator-1 {
>>>>>   +        compatible = "regulator-fixed";
>>>>>   +        regulator-name = "TSP_FIXED_VOLTAGES";
>>>>>   +        regulator-min-microvolt = <3300000>;
>>>>>   +        regulator-max-microvolt = <3300000>;
>>>>>   +        gpio = <&gpl0 3 GPIO_ACTIVE_HIGH>;
>>>>>   +        startup-delay-us = <70000>;
>>>>>   +        enable-active-high;
>>>>>   +        regulator-boot-on;
>>>>>   +        regulator-always-on;
>>>>
>>>>  always-on and boot-on should not be needed. You have a consumer 
>>>> for this
>>>>  regulator.
>>>
>>>  About this: the touchscreen driver does not use a regulator, so I
>>>  believe that's why these properties were here.
>>>
>>>  I sent patches upstream to address the issue:
>>>  https://protect2.fireeye.com/url?k=e8aedc29-b53072b3-e8af5766-0cc47a336fae-759579fd576d8382&u=https://lkml.org/lkml/2020/3/15/94 
>>>
>>>
>>>  I believe this means I cannot merge the i9100 devicetree until it is
>>>  acked.
>>
>> One more information - similar change has been already posted, but it
>> looks it got lost then: https://patchwork.kernel.org/patch/10550903/
>
> I was aware of this patch, but didn't know it was sent upstream.
>
> This other patch uses two regulators, vdd/avdd but doesn't give any 
> reason why.
>
I've checked the UniversalC210 schematic, which uses the same 
touchscreen chip. There are 2 supplies to the touchscreen chip: 2.8V VDD 
and 3.3V AVDD. Both are enabled by the same GPIO pin though. There is 
however no reset GPIO pin there.

> Paweł, is that really needed?
>
Best regards
-- 
Marek Szyprowski, PhD
Samsung R&D Institute Poland

