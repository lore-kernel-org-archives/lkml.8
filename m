Return-Path: <SRS0=eGSO=AR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7278EC433DF
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jul 2020 06:08:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5006220715
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jul 2020 06:08:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="S0pex2ju"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728896AbgGFGIM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Jul 2020 02:08:12 -0400
Received: from mailout2.w1.samsung.com ([210.118.77.12]:59114 "EHLO
        mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728804AbgGFGIL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jul 2020 02:08:11 -0400
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20200706060809euoutp02c0af2e844998ed6fff1fd14a2eb82927~fFNLwctX51000610006euoutp020
        for <linux-kernel@vger.kernel.org>; Mon,  6 Jul 2020 06:08:09 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20200706060809euoutp02c0af2e844998ed6fff1fd14a2eb82927~fFNLwctX51000610006euoutp020
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1594015689;
        bh=5CPSUaRLJ02ikOuFUBcQHrGOJxVwDdq4iNg5amFKq5w=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=S0pex2juluGYhknFqBCMSNubZy9Ick5WWlk5lSPhNDhGu7KLmLuz+0xzUpyCpy5hD
         4ALZI2tEgtrlX5y2/E7xpIG4g29KwaQttTWA1axLX4B23W19z0Bm7GqwS2cPhLI8mw
         QohU2rAoPmY8irFQZqsL7gykc2mY3YLQkD3/clUY=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20200706060809eucas1p2f696eb7ff0d0ab71a26b02a69569e50d~fFNLhRG2E2614426144eucas1p2I;
        Mon,  6 Jul 2020 06:08:09 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges1new.samsung.com (EUCPMTA) with SMTP id 51.5F.06456.9CFB20F5; Mon,  6
        Jul 2020 07:08:09 +0100 (BST)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20200706060808eucas1p2753f16dcc9f6301bcc2df5525e769b86~fFNLRVrlD2614826148eucas1p2A;
        Mon,  6 Jul 2020 06:08:08 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20200706060808eusmtrp195743d56050c80e0b931fa75f1a24c1f~fFNLQq6rs0760307603eusmtrp1K;
        Mon,  6 Jul 2020 06:08:08 +0000 (GMT)
X-AuditID: cbfec7f2-809ff70000001938-cc-5f02bfc8d9d8
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id 8D.0C.06017.8CFB20F5; Mon,  6
        Jul 2020 07:08:08 +0100 (BST)
Received: from [106.210.88.143] (unknown [106.210.88.143]) by
        eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20200706060808eusmtip27de6ee15a6c65a9ca95306d1a0e075ce~fFNKkcldy2997429974eusmtip2g;
        Mon,  6 Jul 2020 06:08:07 +0000 (GMT)
Subject: Re: [PATCH v3] ARM: dts: exynos: Remove DMA controller bus node
 name to fix dtschema warnings
To:     Krzysztof Kozlowski <krzk@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Kukjin Kim <kgene@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Sylwester Nawrocki <snawrocki@kernel.org>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Pankaj Dubey <pankaj.dubey@samsung.com>
From:   Marek Szyprowski <m.szyprowski@samsung.com>
Message-ID: <87ed95bf-5979-1de6-370c-48840dc966f3@samsung.com>
Date:   Mon, 6 Jul 2020 08:08:07 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
        Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200705181754.13284-1-krzk@kernel.org>
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Brightmail-Tracker: H4sIAAAAAAAAA01Se0hTcRTmt3vvdjecXafiaUnhiCIhTTK6UJi9aJB/CImQkLb0pqZzuvnI
        +kPR1mPIFFc4l28bxiq1aZozFR8kOpymYGYPCw3xhaAT00rydrX875zvfN/5zgeHxCRvCCkZ
        n5TKqJMUiTK+CG96u+Y43NfBizryc5xHfy1r4tMvjXUE/d45TdDlPQ6Czp+cw+jBwXoBbZ0c
        JegRWwmfNg628+iqV04BrW3rEdD3vs9gwS5yq+UBX97wJEuub7Qg+bJ1bygeIToZwyTGpzNq
        /6Crorja+gEi2SC82V1xKRvlCHRISAIVCP35rZgOiUgJ9RRB3lC1gGucCHob9DyWJaGWERQ3
        pW4r2op1W4oaBMYVO8E1iwha1rU4y3Kn4sDqLPo78GDVI4ZRjB1g1GcEBYXxbM2nAkC3oOOz
        tZgKgmXb3KaAJHFqP5ht0SzsSUVC3Uwzj6O4QV/xFM5ShNQxMOuDuI37oHmhZGu7F4xPlfNY
        W6CGBTCfayS4q89BZ0U3n6vdYba3cSu/N9gNeTgnyEXwzfFCwDV5m0fnGBHHOgGfHOt81hmj
        DkGdzZ+DT0PNuxbEwkC5wtiCG3eEKxQ2FWEcLIb7dyUc+wCYemv/2XYODWMFSGbakcy0I45p
        RxzTf98KhFuQF5OmUcYymoAkJsNPo1Bq0pJi/aJVSiva/Cn7Ru/Sa7QyfK0LUSSSuYjrf6Mo
        CaFI12QquxCQmMxDfGbAHikRxygybzFqVZQ6LZHRdKE9JC7zEh+tmrkioWIVqUwCwyQz6u0p
        jxRKsxHjMh9S+SNDO6Ef461c9pHPBu0SEqJSkOOB0z6+1V7pH7Ie60tsGwXS9Xrt6qzKIBCH
        XjD3j0asdshUd9qNpt3XKzNC5s+Hk0siy9ris8wJQ2fK9PhxpTI84WLrQ/MXT++qX2FhIWXm
        shu3g1MixkvHDp6StT8/qx+VTn981CHDNXGKAF9MrVH8ATcmwgVPAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrPIsWRmVeSWpSXmKPExsVy+t/xe7on9jPFGyz+pWvxYN42NouNM9az
        Wlz/8pzVYv6Rc6wW/Y9fM1ucP7+B3WLT42usFpd3zWGzmHF+H5PFoq1f2C1a9x5ht2h/+pLZ
        gcdj06pONo/NS+o9+rasYvT4vEkugCVKz6Yov7QkVSEjv7jEVina0MJIz9DSQs/IxFLP0Ng8
        1srIVEnfziYlNSezLLVI3y5BL2PdhrOsBZM5Kw4vCG5gbGLvYuTkkBAwkdg7s4sZxBYSWMoo
        sfeVAERcRuLktAZWCFtY4s+1LrYuRi6gmreMEmdfvGYCSQgLZEj8aT7GDJIQEfjMKPGscROY
        wyxwn1HifNtPdoiWDkaJFd8+gs1iEzCU6HoLMouTg1fATuLzrtdAcQ4OFgEViaW7kkHCogJx
        Esu3zGeHKBGUODnzCQtICaeAqcTSPjuQMLOAmcS8zQ+ZIWx5ie1v50DZ4hK3nsxnmsAoNAtJ
        9ywkLbOQtMxC0rKAkWUVo0hqaXFuem6xkV5xYm5xaV66XnJ+7iZGYGRuO/Zzyw7GrnfBhxgF
        OBiVeHg3/GWMF2JNLCuuzD3EKMHBrCTC63T2dJwQb0piZVVqUX58UWlOavEhRlOg1yYyS4km
        5wOTRl5JvKGpobmFpaG5sbmxmYWSOG+HwMEYIYH0xJLU7NTUgtQimD4mDk6pBsZthXm166fG
        LxA+eNTXusxbLPyAw5uJ2ld+zfS+qyR4tEnik8Lc/pMCEbuclGufWTPYxBzzmrTs5Fw1/UDN
        OXYJqY9S/kn9Psltf2PRk2I9llgrro3r7kTzP2dpXefgPulXwTrBr7bVW+IPnm3+KZCr/umg
        3NfXNe/3vtX+G3MhrHaHZELRzg1KLMUZiYZazEXFiQCUeuXg4gIAAA==
X-CMS-MailID: 20200706060808eucas1p2753f16dcc9f6301bcc2df5525e769b86
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20200705181810eucas1p1b310ef2f430a0d23602234928b79ba11
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20200705181810eucas1p1b310ef2f430a0d23602234928b79ba11
References: <CGME20200705181810eucas1p1b310ef2f430a0d23602234928b79ba11@eucas1p1.samsung.com>
        <20200705181754.13284-1-krzk@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 05.07.2020 20:17, Krzysztof Kozlowski wrote:
> There is no need to keep DMA controller nodes under AMBA bus node.
> Remove the "amba" node to fix dtschema warnings like:
>
>      amba: $nodename:0: 'amba' does not match '^(bus|soc|axi|ahb|apb)(@[0-9a-f]+)?$'
>
> Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>

Works fine on all affected SoCs.

Tested-by: Marek Szyprowski <m.szyprowski@samsung.com>

>
> ---
>
> Changes since v2:
> 1. Keep the alphabetical order in exynos4210-universal_c210.dts, as suggested by Marek
>
> Changes since v1:
> 1. Remove the bus, as suggested by Marek
> ---
>   arch/arm/boot/dts/exynos3250.dtsi             |  47 +++----
>   arch/arm/boot/dts/exynos4.dtsi                |  70 +++++-----
>   .../boot/dts/exynos4210-universal_c210.dts    |  28 ++--
>   arch/arm/boot/dts/exynos5250.dtsi             |  92 ++++++-------
>   arch/arm/boot/dts/exynos5410.dtsi             |  46 +++----
>   arch/arm/boot/dts/exynos5420.dtsi             | 130 ++++++++----------
>   6 files changed, 187 insertions(+), 226 deletions(-)
>
 > ...

Best regards
-- 
Marek Szyprowski, PhD
Samsung R&D Institute Poland
