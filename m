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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98D2CC433E2
	for <linux-kernel@archiver.kernel.org>; Mon, 31 Aug 2020 09:49:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 721F0206EB
	for <linux-kernel@archiver.kernel.org>; Mon, 31 Aug 2020 09:49:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="JkiW+2eN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726527AbgHaJtn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 31 Aug 2020 05:49:43 -0400
Received: from mailout1.w1.samsung.com ([210.118.77.11]:33108 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726112AbgHaJtl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Aug 2020 05:49:41 -0400
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20200831094939euoutp0186072e9e3842247c4fd2562f54a4eaaa~wUWkm0SZF1973919739euoutp01T
        for <linux-kernel@vger.kernel.org>; Mon, 31 Aug 2020 09:49:39 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20200831094939euoutp0186072e9e3842247c4fd2562f54a4eaaa~wUWkm0SZF1973919739euoutp01T
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1598867379;
        bh=EJW8EYMTskqUU1YsQV+qNhAwG+zSHDXy31xsFkcy4AI=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=JkiW+2eNUWIG6e5jhWs4RLs0oXgOSpj58XQXURcqqqRms0o1OlYy5ktq5WOXRr5eL
         3TBvZLZHsnDy/fBaUtm1KS+RLlyc9akT9vufyMJv0jTMD+Qhadt6Mgzziupk2XbBu1
         LjbgR3yliInZxkKwQL6eYobv0JDDtM5Fpzqg2xXk=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20200831094939eucas1p23d4902804cd319dec7bf54d3c960982c~wUWkRRlj50257702577eucas1p24;
        Mon, 31 Aug 2020 09:49:39 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges3new.samsung.com (EUCPMTA) with SMTP id 45.20.06318.3B7CC4F5; Mon, 31
        Aug 2020 10:49:39 +0100 (BST)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20200831094939eucas1p2b161d8c902690b83130e792afa099816~wUWj4u0qc1971319713eucas1p2X;
        Mon, 31 Aug 2020 09:49:39 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20200831094938eusmtrp2d3570df0e69075b2b2813dfcc044096c~wUWj4Ka5s0051400514eusmtrp2q;
        Mon, 31 Aug 2020 09:49:38 +0000 (GMT)
X-AuditID: cbfec7f5-371ff700000018ae-fc-5f4cc7b368ea
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id BB.18.06314.2B7CC4F5; Mon, 31
        Aug 2020 10:49:38 +0100 (BST)
Received: from [106.210.88.143] (unknown [106.210.88.143]) by
        eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20200831094938eusmtip1eba73822856501d325cefa8447c7c4d9~wUWjTK54y2769427694eusmtip1f;
        Mon, 31 Aug 2020 09:49:38 +0000 (GMT)
Subject: Re: [PATCH 06/33] ARM: dts: exynos: Correct S3C RTC bindings and
 enable it in Universal C210
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
Message-ID: <3865eabe-7d20-0c5a-9458-0a49d7f3e292@samsung.com>
Date:   Mon, 31 Aug 2020 11:49:38 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
        Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <20200830135200.24304-6-krzk@kernel.org>
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrCKsWRmVeSWpSXmKPExsWy7djPc7qbj/vEGxzrEbXYOGM9q8X8I+dY
        LVqvP2a36H/8mtni/PkN7BabHl9jtbi8aw6bxYzz+5gsWvceYbfYcuY2m0X705fMDtweRw80
        MntsWtXJ5tGyfhObx+Yl9R59W1YxenzeJBfAFsVlk5Kak1mWWqRvl8CVcXP1GsaCS/wVp45/
        Z2lgPMTTxcjJISFgInGr6ydLFyMXh5DACkaJm1N72SCcL4wSF759ZodwPjNK/Ng8HSjDAday
        faILRHw5o8Tm3Quh2t8zSly694wZZK6wQLrEydsQo0QEzjBJ/P12BSzBLJAqsfvtMVYQm03A
        UKLrbRcbiM0rYCfRueMhC4jNIqAqsXvHbEYQW1QgTuLYqUcsEDWCEidnPgGzOQVMJa7dm8AC
        MVNeYvvbOVDzxSVuPZnPBLJYQuAau8SU9Q2sEJ+6SEzq6mOEsIUlXh3fwg5hy0j83wnT0Mwo
        8fDcWnYIp4dR4nLTDKgOa4k7536BA4BZQFNi/S59iLCjxNNvt5kh4cInceOtIMQRfBKTtk2H
        CvNKdLQJQVSrScw6vg5u7cELl5gnMCrNQvLaLCTvzELyziyEvQsYWVYxiqeWFuempxYb56WW
        6xUn5haX5qXrJefnbmIEpq3T/45/3cG470/SIUYBDkYlHt4fR73jhVgTy4orcw8xSnAwK4nw
        Op09HSfEm5JYWZValB9fVJqTWnyIUZqDRUmc13jRy1ghgfTEktTs1NSC1CKYLBMHp1QD445d
        2Q1Vsp3PF8x+4H9nX363NMcavf4v2mrCZ5c5zK+bXlXX075qRnGhOwf3e9bC80dle8O+i82b
        6rhXy0rYLkzkyY16E/nn+fEn23db+6knek+351kiPXcj46po61MrH8ScD89WzHozaa5r7/SS
        E4uPTpkxOfGx0ZlDT8X+XSh2ZF/w8mLOJyWW4oxEQy3mouJEAIQhFAlXAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrGIsWRmVeSWpSXmKPExsVy+t/xu7qbjvvEG7z/a22xccZ6Vov5R86x
        WrRef8xu0f/4NbPF+fMb2C02Pb7GanF51xw2ixnn9zFZtO49wm6x5cxtNov2py+ZHbg9jh5o
        ZPbYtKqTzaNl/SY2j81L6j36tqxi9Pi8SS6ALUrPpii/tCRVISO/uMRWKdrQwkjP0NJCz8jE
        Us/Q2DzWyshUSd/OJiU1J7MstUjfLkEv4+bqNYwFl/grTh3/ztLAeIini5GDQ0LARGL7RJcu
        Ri4OIYGljBKT9z5m7mLkBIrLSJyc1sAKYQtL/LnWxQZR9JZRou3tf7AiYYF0iZO3e8ESIgLn
        mCRmLuxnB0kwC6RKTGyaygTRsZlR4srT5SwgCTYBQ4mutyCjODl4BewkOnc8BIuzCKhK7N4x
        mxHEFhWIkzjT8wKqRlDi5MwnYDWcAqYS1+5NYIFYYCYxb/NDZghbXmL72zlQtrjErSfzmSYw
        Cs1C0j4LScssJC2zkLQsYGRZxSiSWlqcm55bbKhXnJhbXJqXrpecn7uJERin24793LyD8dLG
        4EOMAhyMSjy8P456xwuxJpYVV+YeYpTgYFYS4XU6ezpOiDclsbIqtSg/vqg0J7X4EKMp0HMT
        maVEk/OBKSSvJN7Q1NDcwtLQ3Njc2MxCSZy3Q+BgjJBAemJJanZqakFqEUwfEwenVAOj8a64
        nul7pO4dczz0RPwf63zH3JSfApXz5L8mpM6vr6s/e1ZzX1R0/7KC6AqOwny+mK/vEq6XdBzM
        O/RzdahIwKV9lzrk9krGuZ00MHTNPXVkW5nygdAFAXKT+ZaI+Hqp3pBatMOYOeyqd6XPFav+
        ow/umjEXchvcuxG5uEAo1GRq1ZJ7PBpKLMUZiYZazEXFiQCVgY/O6QIAAA==
X-CMS-MailID: 20200831094939eucas1p2b161d8c902690b83130e792afa099816
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20200830135416eucas1p2359bfac5c025c5c470a736cc830969fe
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20200830135416eucas1p2359bfac5c025c5c470a736cc830969fe
References: <20200830135200.24304-1-krzk@kernel.org>
        <CGME20200830135416eucas1p2359bfac5c025c5c470a736cc830969fe@eucas1p2.samsung.com>
        <20200830135200.24304-6-krzk@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 30.08.2020 15:51, Krzysztof Kozlowski wrote:
> The S3C RTC requires 32768 Hz clock as input which is provided by PMIC.
> However there is no clock provided for the PMIC and the driver registers
> the clock as regulator.  This is an old driver which will not be updated
> so add a workaround - add a fixed-clock to fill missing clock phandle
> reference in S3C RTC.  The "clock" regulator in PMIC is already present
> and enabled.
>
> This allows to enable the S3C RTC and fixes dtbs_check warnings:
>
>    arch/arm/boot/dts/exynos4210-universal_c210.dt.yaml: rtc@10070000: clocks: [[5, 346]] is too short
>    arch/arm/boot/dts/exynos4210-universal_c210.dt.yaml: rtc@10070000: clock-names: ['rtc'] is too short
>
> Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>

Confirmed, this workaround enables s3c-rtc driver operation on this board.

Tested-by: Marek Szyprowski <m.szyprowski@samsung.com>

> ---
>   arch/arm/boot/dts/exynos4210-universal_c210.dts | 13 +++++++++++++
>   1 file changed, 13 insertions(+)
>
> diff --git a/arch/arm/boot/dts/exynos4210-universal_c210.dts b/arch/arm/boot/dts/exynos4210-universal_c210.dts
> index 99ce53b120ac..9479e41bdc2a 100644
> --- a/arch/arm/boot/dts/exynos4210-universal_c210.dts
> +++ b/arch/arm/boot/dts/exynos4210-universal_c210.dts
> @@ -39,6 +39,13 @@
>   			compatible = "samsung,clock-xusbxti";
>   			clock-frequency = <24000000>;
>   		};
> +
> +		pmic_ap_clk: pmic-ap-clk {
> +			/* Workaround for missing clock on PMIC */
> +			compatible = "fixed-clock";
> +			#clock-cells = <0>;
> +			clock-frequency = <32768>;
> +		};
>   	};
>   
>   	vemmc_reg: voltage-regulator {
> @@ -537,6 +544,12 @@
>   	status = "okay";
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

