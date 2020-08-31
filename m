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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37223C433E6
	for <linux-kernel@archiver.kernel.org>; Mon, 31 Aug 2020 09:49:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 06704208DB
	for <linux-kernel@archiver.kernel.org>; Mon, 31 Aug 2020 09:49:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="WoZlihlO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726467AbgHaJtX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 31 Aug 2020 05:49:23 -0400
Received: from mailout2.w1.samsung.com ([210.118.77.12]:58793 "EHLO
        mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726048AbgHaJtP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Aug 2020 05:49:15 -0400
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20200831094913euoutp02d7c60c2d28ac34a89aa172c597856c4a~wUWMRslHL1203512035euoutp02Z
        for <linux-kernel@vger.kernel.org>; Mon, 31 Aug 2020 09:49:13 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20200831094913euoutp02d7c60c2d28ac34a89aa172c597856c4a~wUWMRslHL1203512035euoutp02Z
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1598867353;
        bh=XejqyvM4JPkBDZIm0Rq47c3xkGmMqLcQiEnaUjoSOvE=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=WoZlihlOeFxWnPYJiedPkWBpzNBIOub8Bl/+yjLAwduFt2qRwgcEGNsnFv6UhPRKF
         XMB+JASP+L6ISV1JbF9iqr0iiBo5QdJOMvvCeUsbfVKcAGyL+xwDhXuxvMqnEqBAwu
         RW5lYvQjKl8VzCE+Ws+fCw7t/SYj1nOUsD+a5ys8=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20200831094913eucas1p1c6d27664ca70d16f8790ebba6493a87d~wUWL-WoJK0434204342eucas1p16;
        Mon, 31 Aug 2020 09:49:13 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges3new.samsung.com (EUCPMTA) with SMTP id A6.10.06318.997CC4F5; Mon, 31
        Aug 2020 10:49:13 +0100 (BST)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20200831094913eucas1p22f6c0f17f622f2e320eb6650359b1136~wUWLtlnSZ1130811308eucas1p2b;
        Mon, 31 Aug 2020 09:49:13 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20200831094913eusmtrp2906a8f1253b51a972187285a448b53b1~wUWLs4mt-0051400514eusmtrp2E;
        Mon, 31 Aug 2020 09:49:13 +0000 (GMT)
X-AuditID: cbfec7f5-38bff700000018ae-a9-5f4cc7992621
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id 82.18.06314.897CC4F5; Mon, 31
        Aug 2020 10:49:13 +0100 (BST)
Received: from [106.210.88.143] (unknown [106.210.88.143]) by
        eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20200831094912eusmtip2ff3fefbd61b7ad66690e10572f12302a~wUWLJSGof0559205592eusmtip2I;
        Mon, 31 Aug 2020 09:49:12 +0000 (GMT)
Subject: Re: [PATCH 04/33] ARM: dts: exynos: Correct S3C RTC bindings and
 enable it in Origen
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
Message-ID: <6bebd580-d6c6-bb2f-6dd4-383072e7bde5@samsung.com>
Date:   Mon, 31 Aug 2020 11:49:12 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
        Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <20200830135200.24304-4-krzk@kernel.org>
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrMKsWRmVeSWpSXmKPExsWy7djP87ozj/vEG0z6L2SxccZ6Vov5R86x
        WrRef8xu0f/4NbPF+fMb2C02Pb7GanF51xw2ixnn9zFZtO49wm6x5cxtNov2py+ZHbg9jh5o
        ZPbYtKqTzaNl/SY2j81L6j36tqxi9Pi8SS6ALYrLJiU1J7MstUjfLoErY/bLs0wFKwQqenZf
        YGtgvMXTxcjJISFgIvFx93rmLkYuDiGBFYwSbyb1s0M4XxglTvydDZX5zCgx59gNxi5GDrCW
        F6sDIOLLGSVmvu1jhXDeM0r8uHqPDWSusEC8RNOrm4wgCRGBM0wSf79dYQZJMAukSux+e4wV
        xGYTMJToetvFBjKVV8BOYuVSS5Awi4CqxOMJt1lAbFGBOIljpx6B2bwCghInZz4BszkFTCXe
        HH/ADjFSXmL72zlQ48Ulbj2ZzwSyV0LgFrvE0flT2CEedZG42XMeyhaWeHV8C5QtI/F/J0xD
        M6PEw3Nr2SGcHkaJy00zGCGqrCXunPsFdimzgKbE+l36EGFHiQWrQTaDgoVP4sZbQYgj+CQm
        bZsOFeaV6GgTgqhWk5h1fB3c2oMXLjFPYFSaheS1WUjemYXknVkIexcwsqxiFE8tLc5NTy02
        zkst1ytOzC0uzUvXS87P3cQITFqn/x3/uoNx35+kQ4wCHIxKPLw/jnrHC7EmlhVX5h5ilOBg
        VhLhdTp7Ok6INyWxsiq1KD++qDQntfgQozQHi5I4r/Gil7FCAumJJanZqakFqUUwWSYOTqkG
        xn3y1+/ey/fzU6lcavbaXbIoYFnOLM+3K3r+21s0mi+briI0Xyssq5H/2onXvgx3z+r9+vli
        TV7ki/RvZWaJDtYbq4S+nAmYnF98RPJ7uPqTfxNMLDpsFttuYDYqey/4jXtHoX+hRZxx3qfn
        X/tnGXWeL2rzDLsyj/HJ48PTV98pWfyvPaR7sRJLcUaioRZzUXEiAFMnoMNWAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrCIsWRmVeSWpSXmKPExsVy+t/xe7ozj/vEG7xMttg4Yz2rxfwj51gt
        Wq8/Zrfof/ya2eL8+Q3sFpseX2O1uLxrDpvFjPP7mCxa9x5ht9hy5jabRfvTl8wO3B5HDzQy
        e2xa1cnm0bJ+E5vH5iX1Hn1bVjF6fN4kF8AWpWdTlF9akqqQkV9cYqsUbWhhpGdoaaFnZGKp
        Z2hsHmtlZKqkb2eTkpqTWZZapG+XoJcx++VZpoIVAhU9uy+wNTDe4uli5OCQEDCReLE6oIuR
        i0NIYCmjxNWeXcxdjJxAcRmJk9MaWCFsYYk/17rYIIreMkrs6j/GCJIQFoiXaHp1kxEkISJw
        jkli5sJ+dpAEs0CqxMSmqUwQHZsZJXZ0TQEbxSZgKNH1FmQUBwevgJ3EyqWWIGEWAVWJxxNu
        s4DYogJxEmd6XrCB2LwCghInZz4Bi3MKmEq8Of4Aar6ZxLzND5khbHmJ7W/nQNniEreezGea
        wCg0C0n7LCQts5C0zELSsoCRZRWjSGppcW56brGhXnFibnFpXrpecn7uJkZgjG479nPzDsZL
        G4MPMQpwMCrx8P446h0vxJpYVlyZe4hRgoNZSYTX6ezpOCHelMTKqtSi/Pii0pzU4kOMpkDP
        TWSWEk3OB6aPvJJ4Q1NDcwtLQ3Njc2MzCyVx3g6BgzFCAumJJanZqakFqUUwfUwcnFINjB19
        OpOyZ8pV7PlnWt+VybrnZ07CFr1rjlIPVpuenVzhdUdvRvWFqwtvRJsHTFl2U379yVVa8zZb
        JdQmrCk7JdUo8PbvgQm/9k9sW/tbeFHRGeeI289n2tm42ukoM/DVJsfx/Lp65ER1ma5RWVzJ
        kpurfngsY16/259/hVhK0nxhzbNfo+q2z1NiKc5INNRiLipOBAAA5VOj5wIAAA==
X-CMS-MailID: 20200831094913eucas1p22f6c0f17f622f2e320eb6650359b1136
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20200830135409eucas1p2ceba4383b440bb9398136a42285f82c3
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20200830135409eucas1p2ceba4383b440bb9398136a42285f82c3
References: <20200830135200.24304-1-krzk@kernel.org>
        <CGME20200830135409eucas1p2ceba4383b440bb9398136a42285f82c3@eucas1p2.samsung.com>
        <20200830135200.24304-4-krzk@kernel.org>
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
>    arch/arm/boot/dts/exynos4210-origen.dt.yaml: rtc@10070000: clocks: [[5, 346]] is too short
>    arch/arm/boot/dts/exynos4210-origen.dt.yaml: rtc@10070000: clock-names: ['rtc'] is too short
>
> Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>

Confirmed, this workaround enables s3c-rtc driver operation on this board.

Tested-by: Marek Szyprowski <m.szyprowski@samsung.com>

> ---
>   arch/arm/boot/dts/exynos4210-origen.dts | 14 ++++++++++++++
>   1 file changed, 14 insertions(+)
>
> diff --git a/arch/arm/boot/dts/exynos4210-origen.dts b/arch/arm/boot/dts/exynos4210-origen.dts
> index 890525b10d22..747221bbb856 100644
> --- a/arch/arm/boot/dts/exynos4210-origen.dts
> +++ b/arch/arm/boot/dts/exynos4210-origen.dts
> @@ -100,6 +100,13 @@
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
>   	display-timings {
> @@ -286,6 +293,11 @@
>   				regulator-boot-on;
>   				regulator-always-on;
>   			};
> +
> +			EN32KHZ_AP {
> +				regulator-name = "EN32KHZ_AP";
> +				regulator-always-on;
> +			};
>   		};
>   	};
>   };
> @@ -331,6 +343,8 @@
>   
>   &rtc {
>   	status = "okay";
> +	clocks = <&clock CLK_RTC>, <&pmic_ap_clk>;
> +	clock-names = "rtc", "rtc_src";
>   };
>   
>   &tmu {

Best regards
-- 
Marek Szyprowski, PhD
Samsung R&D Institute Poland

