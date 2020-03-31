Return-Path: <SRS0=6o4L=5Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AFCA3C2D0EF
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Mar 2020 05:36:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 858C5206F6
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Mar 2020 05:36:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="K7EEWQFS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726520AbgCaFgp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 31 Mar 2020 01:36:45 -0400
Received: from mailout2.w1.samsung.com ([210.118.77.12]:53561 "EHLO
        mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726236AbgCaFgo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Mar 2020 01:36:44 -0400
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20200331053642euoutp026f564035ec82f2ec03cdb277627cf263~BTNChF0dQ1789117891euoutp02p
        for <linux-kernel@vger.kernel.org>; Tue, 31 Mar 2020 05:36:42 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20200331053642euoutp026f564035ec82f2ec03cdb277627cf263~BTNChF0dQ1789117891euoutp02p
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1585633002;
        bh=BborsbrEshHe2Rc0bJAjGGKeyQdcyjyJSDh2GBoOQTg=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=K7EEWQFSCYWoWFa9NqlCJVH/n5zFsO4jukOXTgJWh4m0kbQxl7CodchZT4hHzuXfV
         TIVH0/ssM8ZiW0Xs7Kr8U2dXL0tpK4Ts6l4MlJVqiSs6hGsXLGoYFgyYMSg2OzHGeB
         12OrwJVq+nbzpPajWF2agfkJ2Maxs1vjdmg2eVCU=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20200331053642eucas1p11652b7fc88dd370d61f32d6e325adc60~BTNCUw5QU2605026050eucas1p1E;
        Tue, 31 Mar 2020 05:36:42 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges2new.samsung.com (EUCPMTA) with SMTP id 31.4E.60679.AE6D28E5; Tue, 31
        Mar 2020 06:36:42 +0100 (BST)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20200331053642eucas1p195aa5bdef38639d877278494003abfd8~BTNB-7Dep0811408114eucas1p1l;
        Tue, 31 Mar 2020 05:36:42 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20200331053642eusmtrp1dce61997d1e2c2b797a2c6593b025a9b~BTNB-QtTD1690716907eusmtrp1N;
        Tue, 31 Mar 2020 05:36:42 +0000 (GMT)
X-AuditID: cbfec7f4-0e5ff7000001ed07-c9-5e82d6ea4f07
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id 78.88.07950.AE6D28E5; Tue, 31
        Mar 2020 06:36:42 +0100 (BST)
Received: from [106.210.88.143] (unknown [106.210.88.143]) by
        eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20200331053641eusmtip2b065b823f6a40381f00957d61277d241~BTNBbxNE71887318873eusmtip2E;
        Tue, 31 Mar 2020 05:36:41 +0000 (GMT)
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
Message-ID: <6c549058-00f9-8526-a272-48c538166ccf@samsung.com>
Date:   Tue, 31 Mar 2020 07:36:39 +0200
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:68.0) Gecko/20100101
        Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <D6.31.03891.A6F227E5@epmailinsp8.samsung.com>
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrDKsWRmVeSWpSXmKPExsWy7djP87qvrjXFGdyfL2sx/8g5Vov+x6+Z
        Lc6f38BusenxNVaLy7vmsFnMOL+PyWLp9YtMFv2LL7FYtO49wm4xZclMdgcujzXz1jB6rL7U
        zuaxc9Zddo9NqzrZPDYvqff4vEkugC2KyyYlNSezLLVI3y6BK2Ne+0e2gt2cFffmfmRqYPzM
        3sXIySEhYCKxt3M6axcjF4eQwApGiY/TPrBDOF8YJZ7v3M0E4XxmlNh/czYTTMvReXugqpYz
        Srxun84I4bxnlGi6cJ+ti5GDQ1jAQ2L/82SQBhGBQInTE16zgtjMAnOZJK5vMwGx2QQMJbre
        drGB2LwCdhI3jnWA3cQioCrx/NwXsLioQIzExcP9rBA1ghInZz5hARnPKWAtceg8P8RIeYnm
        rbOZIWxxiVtP5oMdLSFwjl3i+dHjLBBHu0hMbv3ACmELS7w6vgXqfxmJ05N7WCAamhklHp5b
        yw7h9DBKXG6awQhRZS1x59wvsMeYBTQl1u/SBzElBBwl3t6UgDD5JG68FYS4gU9i0rbpzBBh
        XomONiGIGWoSs46vg9t68MIl5gmMSrOQPDYLyTezkHwzC2HtAkaWVYziqaXFuempxUZ5qeV6
        xYm5xaV56XrJ+bmbGIFp6vS/4192MO76k3SIUYCDUYmH98HVxjgh1sSy4srcQ4wSHMxKIrxs
        /g1xQrwpiZVVqUX58UWlOanFhxilOViUxHmNF72MFRJITyxJzU5NLUgtgskycXBKNTCqnD5x
        49wH9pCoCewszjJOTwxfzE+Wl3rzWdTS1MPRMP00+/t9KZLvhdtm/7w4bWul0+bFct/+RYfM
        2eHbdTjkx/8rcZMCujp9vvLKrAme4q+n7qYtkJYpmewdEvj9wMv/wo2fil6d9Vc/NFt/t4ee
        orFise8i/ht8ob/lZgvm9lWemnPimbgSS3FGoqEWc1FxIgCAEmwGTwMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrPIsWRmVeSWpSXmKPExsVy+t/xe7qvrjXFGexez24x/8g5Vov+x6+Z
        Lc6f38BusenxNVaLy7vmsFnMOL+PyWLp9YtMFv2LL7FYtO49wm4xZclMdgcujzXz1jB6rL7U
        zuaxc9Zddo9NqzrZPDYvqff4vEkugC1Kz6Yov7QkVSEjv7jEVina0MJIz9DSQs/IxFLP0Ng8
        1srIVEnfziYlNSezLLVI3y5BL2Ne+0e2gt2cFffmfmRqYPzM3sXIySEhYCJxdN4eMFtIYCmj
        RNtlWYi4jMTJaQ2sELawxJ9rXWxdjFxANW8ZJe7t2czSxcjBISzgIbH/eTJIjYhAoMSW/5vA
        apgF5jNJTHr1jhmioYtJov3/ZbBJbAKGEl1vQSZxcvAK2EncONYBtplFQFXi+bkvYHFRgRiJ
        n3u6WCBqBCVOznwCtoxTwFri0Hl+kDCzgJnEvM0PmSFseYnmrbOhbHGJW0/mM01gFJqFpHsW
        kpZZSFpmIWlZwMiyilEktbQ4Nz232EivODG3uDQvXS85P3cTIzAytx37uWUHY9e74EOMAhyM
        Sjy8D642xgmxJpYVV+YeYpTgYFYS4WXzb4gT4k1JrKxKLcqPLyrNSS0+xGgK9NtEZinR5Hxg
        0sgriTc0NTS3sDQ0NzY3NrNQEuftEDgYIySQnliSmp2aWpBaBNPHxMEp1cBYu01h/pRHVqLP
        NiqosJ+7tjshv9TKLciz9Xf/5YZna/6vaJj88MLpN8vmTEoy4S7+kKHzb+2a3M/CJ1Zyz97x
        zD6Z43Sfv+QpGYXm92HzllVWLtc7/EP/b3lea/Wyc95u9WbH1jB5Tjz69lTiSt+dH5rKLdQc
        52ptM7A4sb7zue2MT05f+vZ9VWIpzkg01GIuKk4EANAxl6viAgAA
X-CMS-MailID: 20200331053642eucas1p195aa5bdef38639d877278494003abfd8
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
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Paul,

On 2020-03-18 15:25, Paul Cercueil wrote:
>>>  +    };
>>>  +
>>>  +    tsp_reg: regulator-1 {
>>>  +        compatible = "regulator-fixed";
>>>  +        regulator-name = "TSP_FIXED_VOLTAGES";
>>>  +        regulator-min-microvolt = <3300000>;
>>>  +        regulator-max-microvolt = <3300000>;
>>>  +        gpio = <&gpl0 3 GPIO_ACTIVE_HIGH>;
>>>  +        startup-delay-us = <70000>;
>>>  +        enable-active-high;
>>>  +        regulator-boot-on;
>>>  +        regulator-always-on;
>>
>> always-on and boot-on should not be needed. You have a consumer for this
>> regulator.
>
> About this: the touchscreen driver does not use a regulator, so I 
> believe that's why these properties were here.
>
> I sent patches upstream to address the issue: 
> https://lkml.org/lkml/2020/3/15/94
>
> I believe this means I cannot merge the i9100 devicetree until it is 
> acked.

One more information - similar change has been already posted, but it 
looks it got lost then: https://patchwork.kernel.org/patch/10550903/

Best regards
-- 
Marek Szyprowski, PhD
Samsung R&D Institute Poland

