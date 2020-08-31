Return-Path: <SRS0=8grS=CJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.7 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9D5DC433E2
	for <linux-kernel@archiver.kernel.org>; Mon, 31 Aug 2020 09:49:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C965D20936
	for <linux-kernel@archiver.kernel.org>; Mon, 31 Aug 2020 09:49:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="fiC9jjPh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726512AbgHaJtb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 31 Aug 2020 05:49:31 -0400
Received: from mailout1.w1.samsung.com ([210.118.77.11]:33010 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726472AbgHaJt2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Aug 2020 05:49:28 -0400
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20200831094926euoutp01fa490944854a069580ad79497c8a8bf0~wUWYesqAu1974519745euoutp01G
        for <linux-kernel@vger.kernel.org>; Mon, 31 Aug 2020 09:49:26 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20200831094926euoutp01fa490944854a069580ad79497c8a8bf0~wUWYesqAu1974519745euoutp01G
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1598867366;
        bh=Diyd1p/YtM54i6WL211QvS3lG+oSuuHPJ61nvQbet0A=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=fiC9jjPhrc9sytLw8IMyyWnAI22gN8oh3EuU2dRN4eJRR0f/ZbWAyONwuhrC5lnI9
         F5xdeZQtULYG3JlXFG1Q0CnunUfZnd2EDAJMRCCgxt1srCPngiGOJO+9+E0NCLmZ1k
         /AuDJlUgMshvjxU+9zGu+bhpWJWN2+BmGxO+R5qk=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20200831094926eucas1p2ccfa6dbc1387c7b4002a04d94bad369e~wUWYA4EqS1973319733eucas1p2G;
        Mon, 31 Aug 2020 09:49:26 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges1new.samsung.com (EUCPMTA) with SMTP id 9C.78.06456.6A7CC4F5; Mon, 31
        Aug 2020 10:49:26 +0100 (BST)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20200831094925eucas1p1b370f9fab4368f7d867c820f097c4b0f~wUWXrwduA2381723817eucas1p1U;
        Mon, 31 Aug 2020 09:49:25 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20200831094925eusmtrp231b327335ea6508239dba2d4d9ec240a~wUWXrFKHx0051400514eusmtrp2a;
        Mon, 31 Aug 2020 09:49:25 +0000 (GMT)
X-AuditID: cbfec7f2-7efff70000001938-6b-5f4cc7a63396
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id A7.18.06314.5A7CC4F5; Mon, 31
        Aug 2020 10:49:25 +0100 (BST)
Received: from [106.210.88.143] (unknown [106.210.88.143]) by
        eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20200831094925eusmtip2294662723bd884d53b3e9a65ab184879~wUWXCQtHe0543305433eusmtip2n;
        Mon, 31 Aug 2020 09:49:25 +0000 (GMT)
Subject: Re: [PATCH 05/33] ARM: dts: exynos: Correct S3C RTC bindings and
 enable it in Trats
To:     Krzysztof Kozlowski <krzk@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Kukjin Kim <kgene@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Denis GNUtoo Carikli <GNUtoo@cyberdimension.org>,
        Simon Shields <simon@lineageos.org>
Cc:     Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Sylwester Nawrocki <snawrocki@kernel.org>
From:   Marek Szyprowski <m.szyprowski@samsung.com>
Message-ID: <22b599d2-57a4-54d1-c68f-015e201a7415@samsung.com>
Date:   Mon, 31 Aug 2020 11:49:25 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
        Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <20200830135200.24304-5-krzk@kernel.org>
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrMKsWRmVeSWpSXmKPExsWy7djP87rLjvvEG1w8yGOxccZ6Vov5R86x
        WrRef8xu0f/4NbPF+fMb2C02Pb7GanF51xw2ixnn9zFZtO49wm6x5cxtNov2py+ZHbg9jh5o
        ZPbYtKqTzaNl/SY2j81L6j36tqxi9Pi8SS6ALYrLJiU1J7MstUjfLoEr49D+iawFJwUq1nwT
        aGD8yNPFyMkhIWAi8evAS7YuRi4OIYEVjBJX1t9ihHC+MEoc7r7NCuF8ZpTY/mEPC0zLzvYf
        7BCJ5YwSZ9r+MEE47xkl3p+8wQpSJSwQJzHvwXSwWSICZ5gk/n67wgySYBZIldj99hhYEZuA
        oUTX2y42EJtXwE7i3KkF7CA2i4CqxOEzbUwgtijQoGOnHrFA1AhKnJz5BMzmFDCVeDnnA9RM
        eYntb+dA2eISt57MZ4I49RK7xNeTwhC2i0RPw0VGCFtY4tXxLewQtozE/53zwT6QEGhmlHh4
        bi07hNPDKHG5aQZUh7XEnXO/gC7lANqgKbF+lz5E2FHixfcuFpCwhACfxI23ghA38ElM2jad
        GSLMK9HRJgRRrSYx6/g6uLUHL1xinsCoNAvJZ7OQfDMLyTezEPYuYGRZxSieWlqcm55abJiX
        Wq5XnJhbXJqXrpecn7uJEZi0Tv87/mkH49dLSYcYBTgYlXh4fxz1jhdiTSwrrsw9xCjBwawk
        wut09nScEG9KYmVValF+fFFpTmrxIUZpDhYlcV7jRS9jhQTSE0tSs1NTC1KLYLJMHJxSDYzb
        beee1Kzu/FD9c0Jxs5FMa2DLG+cjTxROzz4kpM10UcJm778pSjKX3z2fmm6xp/7XldtMPcZx
        ZuEbv1628c0pjWiPbJ1jvHVbSJMq0xXVnYw7FKV+5L0rm79z7Xnj54vbX1zw2rBLwlvW54Cr
        Zs1uBgaFMKe7UXd9jbuFXp8vnP/WoPCWXIYSS3FGoqEWc1FxIgA4QzoIVgMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrGIsWRmVeSWpSXmKPExsVy+t/xe7pLj/vEG0z/YmCxccZ6Vov5R86x
        WrRef8xu0f/4NbPF+fMb2C02Pb7GanF51xw2ixnn9zFZtO49wm6x5cxtNov2py+ZHbg9jh5o
        ZPbYtKqTzaNl/SY2j81L6j36tqxi9Pi8SS6ALUrPpii/tCRVISO/uMRWKdrQwkjP0NJCz8jE
        Us/Q2DzWyshUSd/OJiU1J7MstUjfLkEv49D+iawFJwUq1nwTaGD8yNPFyMkhIWAisbP9B3sX
        IxeHkMBSRomLexYwQSRkJE5Oa2CFsIUl/lzrYoMoessocf/1cxaQhLBAnMS8B9MZQRIiAueY
        JGYu7GcHSTALpEpMbJrKBNGxmVHid+9VsLFsAoYSXW9BRnFy8ArYSZw7tQCsgUVAVeLwmTaw
        GlGgqWd6XkDVCEqcnPkEbBungKnEyzkfmCEWmEnM2/wQypaX2P52DpQtLnHryXymCYxCs5C0
        z0LSMgtJyywkLQsYWVYxiqSWFuem5xYb6hUn5haX5qXrJefnbmIExum2Yz8372C8tDH4EKMA
        B6MSD++Po97xQqyJZcWVuYcYJTiYlUR4nc6ejhPiTUmsrEotyo8vKs1JLT7EaAr03ERmKdHk
        fGAKySuJNzQ1NLewNDQ3Njc2s1AS5+0QOBgjJJCeWJKanZpakFoE08fEwSnVwLioSfPmXVGF
        gEOzPxy+GOv036xYetvnm3+WKB1KzK598LR6orHp6+Wpcw9uZYwpTo477iV+WlmReWHVz4nO
        apaHZP5uVpXPldhzO21X78pXO/44H3+Z/Pe7K9OT06GSoiVOP5zKxXID909k7xb4JJsStK1k
        U1rc8fxLwplsbecylpYxTP9W4qfEUpyRaKjFXFScCAB0zIzQ6QIAAA==
X-CMS-MailID: 20200831094925eucas1p1b370f9fab4368f7d867c820f097c4b0f
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20200830135413eucas1p2c4db259433ffde5260a2fe85aa4b2570
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20200830135413eucas1p2c4db259433ffde5260a2fe85aa4b2570
References: <20200830135200.24304-1-krzk@kernel.org>
        <CGME20200830135413eucas1p2c4db259433ffde5260a2fe85aa4b2570@eucas1p2.samsung.com>
        <20200830135200.24304-5-krzk@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 30.08.2020 15:51, Krzysztof Kozlowski wrote:
> The S3C RTC requires 32768 Hz clock as input which is provided by PMIC
> (Maxim MAX8997).  However there is no clock provided for the PMIC and
> the driver registers the clock as regulator.  This is an old driver
> which will not be updated so add a workaround:
> 1. Enable the "clock" regulator in PMIC,
> 2. Add a fixed-clock to fill missing clock phandle reference in S3C RTC.
>
> This allows to enable the S3C RTC and fixes dtbs_check warnings:
>
>    arch/arm/boot/dts/exynos4210-trats.dt.yaml: rtc@10070000: clocks: [[5, 346]] is too short
>    arch/arm/boot/dts/exynos4210-trats.dt.yaml: rtc@10070000: clock-names: ['rtc'] is too short
>
> Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>

Confirmed, this workaround enables s3c-rtc driver operation on this board.

Tested-by: Marek Szyprowski <m.szyprowski@samsung.com>

> ---
>   arch/arm/boot/dts/exynos4210-trats.dts | 18 ++++++++++++++++++
>   1 file changed, 18 insertions(+)
>
> diff --git a/arch/arm/boot/dts/exynos4210-trats.dts b/arch/arm/boot/dts/exynos4210-trats.dts
> index 5cc96f04a4fa..634f009b622e 100644
> --- a/arch/arm/boot/dts/exynos4210-trats.dts
> +++ b/arch/arm/boot/dts/exynos4210-trats.dts
> @@ -132,6 +132,13 @@
>   			compatible = "samsung,clock-xusbxti";
>   			clock-frequency = <24000000>;
>   		};
> +
> +		pmic_ap_clk: pmic-ap-clk {
> +			/* Workaround for missing clock on max8997 PMIC */
> +			compatible = "fixed-clock";
> +			#clock-cells = <0>;
> +			clock-frequency = <32768>;
> +		};
>   	};
>   
>   	thermal-zones {
> @@ -444,10 +451,21 @@
>   			     regulator-name = "SAFEOUT2";
>   			     regulator-boot-on;
>   			};
> +
> +			EN32KHZ_AP {
> +				regulator-name = "EN32KHZ_AP";
> +				regulator-always-on;
> +			};
>   		};
>   	};
>   };
>   
> +&rtc {
> +	status = "okay";
> +	clocks = <&clock CLK_RTC>, <&pmic_ap_clk>;
> +	clock-names = "rtc", "rtc_src";
> +};
> +
>   &sdhci_0 {
>   	bus-width = <8>;
>   	non-removable;

Best regards
-- 
Marek Szyprowski, PhD
Samsung R&D Institute Poland

