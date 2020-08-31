Return-Path: <SRS0=8grS=CJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.7 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6690C433E2
	for <linux-kernel@archiver.kernel.org>; Mon, 31 Aug 2020 13:57:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7965E208CA
	for <linux-kernel@archiver.kernel.org>; Mon, 31 Aug 2020 13:57:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="gUqfOVOZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727946AbgHaN5S (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 31 Aug 2020 09:57:18 -0400
Received: from mailout1.w1.samsung.com ([210.118.77.11]:47418 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726503AbgHaN5N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Aug 2020 09:57:13 -0400
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20200831135711euoutp01ef5645da8a683bf91aef515f907fba57~wXusPPcS00657606576euoutp016
        for <linux-kernel@vger.kernel.org>; Mon, 31 Aug 2020 13:57:11 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20200831135711euoutp01ef5645da8a683bf91aef515f907fba57~wXusPPcS00657606576euoutp016
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1598882231;
        bh=BKP8JEkEFE5BywjT1C24BxvHhurtAQ+NCMqa1WK4w5w=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=gUqfOVOZlf7XmvM/mURObomOjtWMdG1gSx2d6AB3ntR5HIDktlXwYJ9iMQYXS6INO
         nWzDOhJpH4WnkUTz8CDqTY1WTUTg+Hpj/AAu9abV6HvTBdWfa+y+KvAT7bNPmRvq30
         OmX6lq9iXR96ELXB13aHzgkB7380ifUzbuE/Dsv8=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20200831135711eucas1p1d6d9c317eb6424ed2a00eea0f4756f47~wXur8NJJ72359223592eucas1p1E;
        Mon, 31 Aug 2020 13:57:11 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges2new.samsung.com (EUCPMTA) with SMTP id 5C.AD.05997.6B10D4F5; Mon, 31
        Aug 2020 14:57:11 +0100 (BST)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20200831135710eucas1p2764a3b42658c75b37f91e82e4f0e131f~wXurlH6td1908919089eucas1p2V;
        Mon, 31 Aug 2020 13:57:10 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20200831135710eusmtrp21a7c436ce75980cfa7562600c01d5da5~wXurjR-fR2287022870eusmtrp2z;
        Mon, 31 Aug 2020 13:57:10 +0000 (GMT)
X-AuditID: cbfec7f4-677ff7000000176d-e3-5f4d01b62e29
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id 58.DE.06017.6B10D4F5; Mon, 31
        Aug 2020 14:57:10 +0100 (BST)
Received: from [106.210.123.115] (unknown [106.210.123.115]) by
        eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20200831135709eusmtip24bac4f7a89946d71273f710ce38afa22~wXuqzbuOm3199831998eusmtip2R;
        Mon, 31 Aug 2020 13:57:09 +0000 (GMT)
Subject: Re: [PATCH 23/33] ARM: dts: exynos: Remove empty camera pinctrl
 configuration in Odroid X/U3
To:     Krzysztof Kozlowski <krzk@kernel.org>
Cc:     Sylwester Nawrocki <snawrocki@kernel.org>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Rob Herring <robh+dt@kernel.org>,
        Kukjin Kim <kgene@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        "linux-samsung-soc@vger.kernel.org" 
        <linux-samsung-soc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Denis GNUtoo Carikli <GNUtoo@cyberdimension.org>,
        Simon Shields <simon@lineageos.org>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
From:   Sylwester Nawrocki <s.nawrocki@samsung.com>
Message-ID: <01bb90db-511d-fbf5-d29a-1fba932f0abf@samsung.com>
Date:   Mon, 31 Aug 2020 15:57:08 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
        Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <CAJKOXPdF4zzXvYrOiGQM9o=4rrWHvEr=o9aSTuR238dEaiD4cQ@mail.gmail.com>
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA01SbUhTYRjl3b2792rOrlPzQaNoWWD4mWEXEsmQ2A8DI4SQUpde5swvNjW1
        H2lmmqYuCT+WYJmlWGpOU1sYZVsrzU3Kr1ySNItUVorSh1nmdpX8d87znMN5zstLYcJ+vjsl
        S0ln5SmSJBFhj3e9+GX06UbHYvxXPyOmvbqNz9RpDXymYMxMMuXmOYwxGh+QjNo8ymfeamoJ
        ptr4hMe0aCdJpqBXSzKdr00EU/hpBjvsINY9zcPE6uYrhPhSm5oQdzRcEJd1NiPxonpHBBFl
        HxzPJskyWblfSKx9wrWFYSLt4tasplIlmYsaHIqRHQX0ARgbLeIXI3tKSDchyCusJzmyhKDi
        2yjBkUUE48VvyA2L6c78uqoRwdToz3WygKBj5QZmVTnTUrAM6WzYhfaCsT8/bCEYnYuDwfId
        ty4IOgBKdWXIigV0CCyaTDaM03tgyHzfZnalo+GhfoTHaZzgVc20zWtHH4eSl7dseox2g4np
        Oh6Hd0K3pRazhgH9kYT+mgked3cYWHqf4xx2hll953qf7bD6yGq2GvIRXH1sIjmiRPBBfxNx
        qkPw3rC89hzUWoQXtGn8uHEoKGvbSesYaEcYtzhxRzhCRVcVxo0FUHRZyKk94Xdz1fo57lAy
        vYorkUi1qZpqUx3Vpjqq/7k3Ed6M3NgMRbKUVexPYc/5KiTJiowUqW9carIarf2wgb/6pR6k
        WTnTh2gKiRwEEUvhMUK+JFORndyHgMJELoIjgwPRQkG8JDuHlafGyDOSWEUf8qBwkZsgsH7m
        tJCWStLZsyybxso3tjzKzj0XtcjgXYlOO+Fx3r1R3VN4W5CQ7oGyeowrhthWSWCdOdjY7h00
        tktVOfj1xJdQcapqPumUjN07ddTVf/kkCqxUbWuIibx3V5kYn+2kiew0dPgE66XhbcNdRVsS
        y4uDFuaKrqf79MvCvJ/N5o/UTS5Hte4+6JATF5ff3uSZkJc3IcIVCZKAfZhcIfkHIlYqZl0D
        AAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrNIsWRmVeSWpSXmKPExsVy+t/xe7rbGH3jDW69V7HYOGM9q8X8I+dY
        LVqvP2a36H/8mtni/PkN7BabHl9jtbi8aw6bxYzz+5gs1h65y27RuvcIu8WWM7fZLNqfvmR2
        4PE4eqCR2WPTqk42j5b1m9g8Ni+p9+jbsorR4/MmuQC2KD2bovzSklSFjPziElulaEMLIz1D
        Sws9IxNLPUNj81grI1MlfTublNSczLLUIn27BL2MiR+vsBU08Ves6J3A3sC4hKeLkZNDQsBE
        4vbSD+xdjFwcQgJLGSUOfb/K2MXIAZSQkpjfogRRIyzx51oXG0TNe0aJc0teMoIkhAXSJd5e
        OMoMYosIaEpc//udFaSIWaCJRWL75HdQU1czS+xY28EGUsUmYCjRe7QPrJtXwE7i8+3bYDaL
        gKrEhcdrwCaJCsRJPO79zwxRIyhxcuYTFhCbUyBQovvEQrB6ZgF1iT/zLjFD2OISt57MZ4Kw
        5SW2v53DPIFRaBaS9llIWmYhaZmFpGUBI8sqRpHU0uLc9NxiI73ixNzi0rx0veT83E2MwIjd
        duznlh2MXe+CDzEKcDAq8fAGfPGJF2JNLCuuzD3EKMHBrCTC63T2dJwQb0piZVVqUX58UWlO
        avEhRlOg5yYyS4km5wOTSV5JvKGpobmFpaG5sbmxmYWSOG+HwMEYIYH0xJLU7NTUgtQimD4m
        Dk6pBkYNnq/WyVUO1+9uednOa77AoTpsg8zW+W0dQpNWrfr47Zz/vNUz5KYqJkq+OsVnW79c
        Kk0qeMHyPnE9pYCTTG/XxeneMhEom31SpeTBkp7H784tyEnN1dO08dkezvyUNcrwqURT6+eL
        N77sX+PDJbJLTTXQJ9lD5G+qrUeCIIPmRVeRCRNMdiuxFGckGmoxFxUnAgDfjqfz7gIAAA==
X-CMS-MailID: 20200831135710eucas1p2764a3b42658c75b37f91e82e4f0e131f
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20200830135508eucas1p21ad0d4f6a2ef78f854fc74750db3fa2a
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20200830135508eucas1p21ad0d4f6a2ef78f854fc74750db3fa2a
References: <20200830135200.24304-1-krzk@kernel.org>
        <CGME20200830135508eucas1p21ad0d4f6a2ef78f854fc74750db3fa2a@eucas1p2.samsung.com>
        <20200830135200.24304-23-krzk@kernel.org>
        <c9daff05-dca7-f1b1-8cfe-46b185bf60dd@samsung.com>
        <CAJKOXPfR8YVmBqCd5+8B2TdM_tXZbWobK0pLxXxxkrsDEMR-vw@mail.gmail.com>
        <96651e85-c27f-3167-7b41-2ea051c25c65@kernel.org>
        <CAJKOXPdF4zzXvYrOiGQM9o=4rrWHvEr=o9aSTuR238dEaiD4cQ@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 31.08.2020 12:42, Krzysztof Kozlowski wrote:
> On Mon, 31 Aug 2020 at 12:35, Sylwester Nawrocki <snawrocki@kernel.org> wrote:
>> On 8/31/20 10:38, Krzysztof Kozlowski wrote:
>>> On Mon, 31 Aug 2020 at 10:31, Marek Szyprowski <m.szyprowski@samsung.com> wrote:
>>>> On 30.08.2020 15:51, Krzysztof Kozlowski wrote:
>>>>> The camera's pinctrl configuration is simply empty and not effective.
>>>>> Remove it to fix dtbs_check warning:
>>>>>
>>>>>     arch/arm/boot/dts/exynos4412-odroidx.dt.yaml: camera: pinctrl-0: True is not of type 'array'
>>>>>
>>>>> Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
>>>>
>>>> I think that this was intentional to properly enable support for
>>>> mem-2-mem mode in Exynos4-IS (FIMC), but I'm not sure what are the
>>>> default values if no pinctrl properties are provided. Sylwester, could
>>>> you comment?
>>>
>>> Indeed it could be intentional... I see now errors:
>>> [   33.752203] s5p-fimc-md soc:camera: Failed to get pinctrl: -19
>>>
>>> I wonder why getting an empty pinctrl is needed... maybe the driver
>>> should accept missing pinctrl?
>>
>> It might have been better to have the pinctrl properties optional, as there
>> might be boards without the image sensor attached and FIMC could still be
>> used in memory-to-memory mode, as Marek pointed out. But it seems too late
>> now to change that. The binding defines the pinctrl properties as required
>> (Documentation/devicetree/bindings/media/samsung-fimc.txt) and we need to
>> keep them in dtses.
> 
> You can always make a required property optional and it is not a break
> of ABI. The other way around would be a break. Why then not changing
> the driver to accept optional pinctrl?

Feel free to send the patch, I would prefer to leave that as is though.
Is it really suddenly a problem to use an empty property? The pinctrl 
bindings allows it.

-- 
Regards,
Sylwester
