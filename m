Return-Path: <SRS0=2gBQ=CN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 840F4C2BC84
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Sep 2020 06:47:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 59F51206B8
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Sep 2020 06:47:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="UUtp1rvA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728163AbgIDGrM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 4 Sep 2020 02:47:12 -0400
Received: from mailout2.w1.samsung.com ([210.118.77.12]:54980 "EHLO
        mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726089AbgIDGrK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Sep 2020 02:47:10 -0400
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20200904064707euoutp02b7854cb444c2387d79318b2c8ecee100~xgcV6gmNM1899618996euoutp02Z
        for <linux-kernel@vger.kernel.org>; Fri,  4 Sep 2020 06:47:07 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20200904064707euoutp02b7854cb444c2387d79318b2c8ecee100~xgcV6gmNM1899618996euoutp02Z
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1599202027;
        bh=67a+pt9I2jtHRBIG4Hc52tlennfGIpB6ZIhmKV+jdAc=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=UUtp1rvAsv+k+nCyMMcUzpAmjdcKyAQAJp2x1hJLvIFIhsbBOhsynwiAho/6+clNy
         WzogXpUFcZNO6B4+qbxgG+N3+ZflYT9+gms58N9MJMd6jJhwPvM00VkODYo7IZwKk2
         7tLE0irq/RNK0Bj2HypDrvfkN5SLnD4j2C8oHO4w=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20200904064707eucas1p1a492751e701126307c7afa8459d84bc1~xgcVnRxUy0374403744eucas1p1j;
        Fri,  4 Sep 2020 06:47:07 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges1new.samsung.com (EUCPMTA) with SMTP id 91.C2.06456.BE2E15F5; Fri,  4
        Sep 2020 07:47:07 +0100 (BST)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20200904064707eucas1p24ca97f26742aed3fd092b37012861fca~xgcVM5k_51330813308eucas1p2K;
        Fri,  4 Sep 2020 06:47:07 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20200904064706eusmtrp218e6fe4f52d1b160b2ea5e82d9a981a9~xgcVHNqm21768817688eusmtrp2M;
        Fri,  4 Sep 2020 06:47:06 +0000 (GMT)
X-AuditID: cbfec7f2-7efff70000001938-fa-5f51e2eb12a8
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id 12.62.06314.AE2E15F5; Fri,  4
        Sep 2020 07:47:06 +0100 (BST)
Received: from [106.210.88.143] (unknown [106.210.88.143]) by
        eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20200904064706eusmtip276985d5c504de0a45479dcbe3d764a5f~xgcUpDwwd2982729827eusmtip2W;
        Fri,  4 Sep 2020 06:47:06 +0000 (GMT)
Subject: Re: [PATCH v2 1/3] ARM: dts: exynos: Add assigned clock parent to
 CMU in Exynos3250
To:     Krzysztof Kozlowski <krzk@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Kukjin Kim <kgene@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Sylwester Nawrocki <snawrocki@kernel.org>
From:   Marek Szyprowski <m.szyprowski@samsung.com>
Message-ID: <4bc2ea2e-65a2-6c0b-9557-5777e359241a@samsung.com>
Date:   Fri, 4 Sep 2020 08:47:10 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
        Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <20200903181425.5015-1-krzk@kernel.org>
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrGKsWRmVeSWpSXmKPExsWy7djP87qvHwXGG3y9KWkx/8g5Vov+x6+Z
        Lc6f38BusenxNVaLy7vmsFnMOL+PyaJ17xF2i/anL5kdODw2repk89i8pN7j8ya5AOYoLpuU
        1JzMstQifbsEroyll38zF+zirVj27j1zA2MzdxcjJ4eEgInEz1NrmLsYuTiEBFYwSuzc3sYG
        4XxhlFi2+hErhPOZUeL58pdMMC0bbuyBqlrOKNH58BsLhPMeqOr3FUaQKmGBOImDjd/ZQRIi
        IO2XJ19jBkkwC+hKTH/3BsxmEzCU6HrbxQZi8wrYSTS+ugvUzMHBIqAiceKuFEhYFGjOsVOP
        WCBKBCVOznwCZnMCXXH/4TYmiJHyEtvfzoEaLy5x68l8JpC9EgLL2CUeT3nEDHG2i8T5mTvZ
        IGxhiVfHt7BD2DIS/3fCNDQzSjw8t5YdwukBurppBiNElbXEnXO/2ECuYxbQlFi/Sx8i7Cix
        eMFRdpCwhACfxI23ghBH8ElM2jadGSLMK9HRJgRRrSYx6/g6uLUHL1xinsCoNAvJa7OQvDML
        yTuzEPYuYGRZxSieWlqcm55abJiXWq5XnJhbXJqXrpecn7uJEZh6Tv87/mkH49dLSYcYBTgY
        lXh4b7wPiBdiTSwrrsw9xCjBwawkwut09nScEG9KYmVValF+fFFpTmrxIUZpDhYlcV7jRS9j
        hQTSE0tSs1NTC1KLYLJMHJxSDYydXvfufSzbY+p/TvcCS8fqTXt+LNfXuHR/t88G9mV/zZor
        AxIKb+TyhGxT/DzznsO5pH9HM224k5i7I9yya7kneTNPbv3+z8R8gfyUzbxt0VICm5LfmS/L
        39Exq1fU22NHcLB/pMuN44EHOjcuW54g7qtU8fqRjKHhjWmZt4L3mOz0uHypaq8SS3FGoqEW
        c1FxIgCeWsMhOQMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrOIsWRmVeSWpSXmKPExsVy+t/xe7qvHgXGG5x9bWkx/8g5Vov+x6+Z
        Lc6f38BusenxNVaLy7vmsFnMOL+PyaJ17xF2i/anL5kdODw2repk89i8pN7j8ya5AOYoPZui
        /NKSVIWM/OISW6VoQwsjPUNLCz0jE0s9Q2PzWCsjUyV9O5uU1JzMstQifbsEvYyll38zF+zi
        rVj27j1zA2MzdxcjJ4eEgInEhht72EBsIYGljBK7t2lBxGUkTk5rYIWwhSX+XOsCquECqnnL
        KDH57z8WkISwQJzEmhMrWUASIgKfGSWeNW5iBkkwC+hKTH/3hhmiox2o4/ctRpAEm4ChRNfb
        LrB1vAJ2Eo2v7gLFOThYBFQkTtyVAgmLAg090/MCqkRQ4uTMJ2DLOIEuvf9wGxPEfDOJeZsf
        Qu2Sl9j+dg6ULS5x68l8pgmMQrOQtM9C0jILScssJC0LGFlWMYqklhbnpucWG+oVJ+YWl+al
        6yXn525iBEbatmM/N+9gvLQx+BCjAAejEg/vjfcB8UKsiWXFlbmHGCU4mJVEeJ3Ono4T4k1J
        rKxKLcqPLyrNSS0+xGgK9NtEZinR5HxgEsgriTc0NTS3sDQ0NzY3NrNQEuftEDgYIySQnliS
        mp2aWpBaBNPHxMEp1cAYsEAppqrH9LWo8Y3IukPblnB8yGXKOfub6+1SWaY53Re219Qm7jCe
        fXm73epAl3VhCheMlRd0RJ05yMMqG/H7neOnue1KsnHT3GM3/pXUv8EY1Gq6cub/9yGGq06+
        Vpz64trMNweeTo4Q4FWYxtJ+ffm/Ne9dO4192HdukHu7b1aEvnxbfsdFJZbijERDLeai4kQA
        46qE7MoCAAA=
X-CMS-MailID: 20200904064707eucas1p24ca97f26742aed3fd092b37012861fca
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20200903181437eucas1p16b97d1c425672700bac7ece19084584c
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20200903181437eucas1p16b97d1c425672700bac7ece19084584c
References: <CGME20200903181437eucas1p16b97d1c425672700bac7ece19084584c@eucas1p1.samsung.com>
        <20200903181425.5015-1-krzk@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Krzysztof,

On 03.09.2020 20:14, Krzysztof Kozlowski wrote:
> Commit 52005dece527 ("ARM: dts: Add assigned clock parents to CMU node
> for exynos3250") added assigned clocks under Clock Management Unit to
> fix hangs when accessing ISP registers.
>
> However the dtschema expects "clocks" property if "assigned-clocks" are
> used.  Add reference to input clock, the parent used in
> "assigned-clock-parents" to silence the dtschema warnings:
>
>    arch/arm/boot/dts/exynos3250-artik5-eval.dt.yaml: clock-controller@10030000: 'clocks' is a dependency of 'assigned-clocks'
>
> Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
>
> ---
>
> Changes since v1:
> 1. Add clocks property.
>
> This is a v2 for:
> https://lore.kernel.org/linux-samsung-soc/20200901101534.GE23793@kozik-lap/T/#me85ac382b847dadbc3f6ebf30e94e70b5df1ebb6
> ---
>   arch/arm/boot/dts/exynos3250.dtsi | 1 +
>   1 file changed, 1 insertion(+)
>
> diff --git a/arch/arm/boot/dts/exynos3250.dtsi b/arch/arm/boot/dts/exynos3250.dtsi
> index a1e93fb7f694..89b160280469 100644
> --- a/arch/arm/boot/dts/exynos3250.dtsi
> +++ b/arch/arm/boot/dts/exynos3250.dtsi
> @@ -214,6 +214,7 @@
>   			compatible = "samsung,exynos3250-cmu";
>   			reg = <0x10030000 0x20000>;
>   			#clock-cells = <1>;
> +			clocks = <&cmu CLK_FIN_PLL>;

This is not a correct input clock for this CMU. Please assign it to 
xusbxti, xxti or xtcxo in the respective board dts, as this is a board 
property.

>   			assigned-clocks = <&cmu CLK_MOUT_ACLK_400_MCUISP_SUB>,
>   					  <&cmu CLK_MOUT_ACLK_266_SUB>;
>   			assigned-clock-parents = <&cmu CLK_FIN_PLL>,

Best regards
-- 
Marek Szyprowski, PhD
Samsung R&D Institute Poland

