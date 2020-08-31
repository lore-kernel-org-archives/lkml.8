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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 088E1C43461
	for <linux-kernel@archiver.kernel.org>; Mon, 31 Aug 2020 09:25:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D6D812073A
	for <linux-kernel@archiver.kernel.org>; Mon, 31 Aug 2020 09:25:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="GgiI1R1E"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728290AbgHaJZR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 31 Aug 2020 05:25:17 -0400
Received: from mailout2.w1.samsung.com ([210.118.77.12]:48704 "EHLO
        mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727918AbgHaJZP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Aug 2020 05:25:15 -0400
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20200831092512euoutp026f4eff86a7f90fd0a04f24f7c7b440a6~wUBOdvs7z2685326853euoutp02g
        for <linux-kernel@vger.kernel.org>; Mon, 31 Aug 2020 09:25:12 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20200831092512euoutp026f4eff86a7f90fd0a04f24f7c7b440a6~wUBOdvs7z2685326853euoutp02g
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1598865912;
        bh=27ver/+sncw91cQvHNYvzmH/OzPk0oFElsklYtQMeAA=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=GgiI1R1Eurn8EHu2lyl7oshDlHogzPFprD3uHwnPWB7MzE9ogcfNGtirnXAj0NHSd
         Z8oxzlnTFa8DcftH6dDGZJ+lG97QbSUOE98NevUcYaY4Yy+r68qd+9tzRFQ48KTfJr
         SNCeCEeauaNN4bRkkrvtricWwUP0u22Gt3fNRQEY=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20200831092512eucas1p112a0bb336cc057cac47bc1f009f7fbfc~wUBOA1upE1108311083eucas1p1s;
        Mon, 31 Aug 2020 09:25:12 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges1new.samsung.com (EUCPMTA) with SMTP id 95.54.06456.8F1CC4F5; Mon, 31
        Aug 2020 10:25:12 +0100 (BST)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20200831092512eucas1p1d6ea26db5585f850165ea13477f25b50~wUBNuMt-x1108311083eucas1p1r;
        Mon, 31 Aug 2020 09:25:12 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20200831092512eusmtrp2b9426955777d764c605f82c77aabdffb~wUBNteigB1806518065eusmtrp2q;
        Mon, 31 Aug 2020 09:25:12 +0000 (GMT)
X-AuditID: cbfec7f2-809ff70000001938-e3-5f4cc1f8cdbc
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id F1.38.06017.7F1CC4F5; Mon, 31
        Aug 2020 10:25:12 +0100 (BST)
Received: from [106.210.88.143] (unknown [106.210.88.143]) by
        eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20200831092511eusmtip1e983ea2b263177fe9219a4bf7a4a4945~wUBNJZG_c1160911609eusmtip1B;
        Mon, 31 Aug 2020 09:25:11 +0000 (GMT)
Subject: Re: [RFT 14/33] ARM: dts: exynos: Replace deprecated GPIO spi-gpio
 properties in Universal C210
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
Message-ID: <d2237c0f-a52f-df61-b3c6-841a1b8bd5dc@samsung.com>
Date:   Mon, 31 Aug 2020 11:25:11 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
        Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <20200830135200.24304-14-krzk@kernel.org>
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrMKsWRmVeSWpSXmKPExsWy7djPc7o/DvrEG6z9JGaxccZ6Vov5R86x
        WrRef8xu0f/4NbPF+fMb2C02Pb7GanF51xw2ixnn9zFZtO49wm6x5cxtNov2py+ZHbg9jh5o
        ZPbYtKqTzaNl/SY2j81L6j36tqxi9Pi8SS6ALYrLJiU1J7MstUjfLoEr48cRgYL9nBX3mlay
        NzC+YO9i5OSQEDCROPf9O2MXIxeHkMAKRonzx64xQThfGCW+v5rEBFIlJPCZUeLuiQCYjj07
        HkB1LGeUWDjvASuE855R4sWu5WAdwgJZEqd//AQbJSJwhkni77crzCAJZoFUid1vj7GC2GwC
        hhJdb7vYQGxeATuJHYu/soDYLAKqEq+vPQYbJCoQJ3Hs1CMWiBpBiZMzn4DZnAJmEtP2/2SB
        mCkvsf3tHKj54hK3nswHWywhcIld4vf6eUwQd7tIzNt6ig3CFpZ4dXwLNARkJP7vhGloZpR4
        eG4tO4TTwyhxuWkGI0SVtcSdc7+AujmAVmhKrN+lDxF2lLg66R8jSFhCgE/ixltBiCP4JCZt
        m84MEeaV6GgTgqhWk5h1fB3c2oMXLjFPYFSaheS1WUjemYXknVkIexcwsqxiFE8tLc5NTy02
        zEst1ytOzC0uzUvXS87P3cQITFqn/x3/tIPx66WkQ4wCHIxKPLw/jnrHC7EmlhVX5h5ilOBg
        VhLhdTp7Ok6INyWxsiq1KD++qDQntfgQozQHi5I4r/Gil7FCAumJJanZqakFqUUwWSYOTqkG
        RtF3+/TvNW7Uipysy7nuxbNX0bP3LL17yNDVUeakXhc/e8qNngnHO2aG6tcG8714I+TENid1
        sezuUJHUoFkHGE9cPbpW587+tJC2sKoeTZffy/vnyBy1br9o5LWYceLOFfKss7i9Ky63SVwI
        PLFPMvTdvGnd7/dFtUpu9A9dI7ytultGaRsPuxJLcUaioRZzUXEiAFk9dipWAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrKIsWRmVeSWpSXmKPExsVy+t/xu7o/DvrEG9w4wWSxccZ6Vov5R86x
        WrRef8xu0f/4NbPF+fMb2C02Pb7GanF51xw2ixnn9zFZtO49wm6x5cxtNov2py+ZHbg9jh5o
        ZPbYtKqTzaNl/SY2j81L6j36tqxi9Pi8SS6ALUrPpii/tCRVISO/uMRWKdrQwkjP0NJCz8jE
        Us/Q2DzWyshUSd/OJiU1J7MstUjfLkEv48cRgYL9nBX3mlayNzC+YO9i5OSQEDCR2LPjASOI
        LSSwlFFi4g9/iLiMxMlpDawQtrDEn2tdbF2MXEA1bxklPi+/wwySEBbIkjj94ycTSEJE4ByT
        xMyF/WBTmQVSJSY2TWWC6NjCKHH2xV2wFWwChhJdb0FGcXLwCthJ7Fj8lQXEZhFQlXh97TET
        iC0qECdxpucFVI2gxMmZT8BqOAXMJKbt/8kCscBMYt7mh8wQtrzE9rdzoGxxiVtP5jNNYBSa
        haR9FpKWWUhaZiFpWcDIsopRJLW0ODc9t9hIrzgxt7g0L10vOT93EyMwSrcd+7llB2PXu+BD
        jAIcjEo8vD+OescLsSaWFVfmHmKU4GBWEuF1Ons6Tog3JbGyKrUoP76oNCe1+BCjKdBzE5ml
        RJPzgQkkryTe0NTQ3MLS0NzY3NjMQkmct0PgYIyQQHpiSWp2ampBahFMHxMHp1QDY1CeWKac
        Xuejrta12l9ulfuIzJkhd2Dbzpc3pT588pWJ1GlkKd5ZvefvQ55d0zISi6bc048OfcH15Pvp
        14l9y52LbP6Z67tEnzVL0mqZ+Xrdjg3K1+akRH5wfmN4UyZ/69uznuoz24/PmnpIJ2ajoLUq
        1/uKhc2RLcH/v6S8uCypv3jFtFgHNyWW4oxEQy3mouJEAMWjBkjoAgAA
X-CMS-MailID: 20200831092512eucas1p1d6ea26db5585f850165ea13477f25b50
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20200830135440eucas1p2e72db4f3b1ee2c20119c56ea9f2cd8ae
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20200830135440eucas1p2e72db4f3b1ee2c20119c56ea9f2cd8ae
References: <20200830135200.24304-1-krzk@kernel.org>
        <CGME20200830135440eucas1p2e72db4f3b1ee2c20119c56ea9f2cd8ae@eucas1p2.samsung.com>
        <20200830135200.24304-14-krzk@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 30.08.2020 15:51, Krzysztof Kozlowski wrote:
> "gpio-sck" and "gpio-mosi" are deprecated so update the DTS to fix
> dtbs_checks warnings like:
>
>    arch/arm/boot/dts/exynos4210-universal_c210.dt.yaml: spi-lcd:
>      gpio-sck: False schema does not allow [[85, 1, 0]]
>
> Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
Tested-by: Marek Szyprowski <m.szyprowski@samsung.com>
> ---
>   arch/arm/boot/dts/exynos4210-universal_c210.dts | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/arch/arm/boot/dts/exynos4210-universal_c210.dts b/arch/arm/boot/dts/exynos4210-universal_c210.dts
> index 3509fdf8f245..279f0f8f86ed 100644
> --- a/arch/arm/boot/dts/exynos4210-universal_c210.dts
> +++ b/arch/arm/boot/dts/exynos4210-universal_c210.dts
> @@ -124,8 +124,8 @@
>   		#address-cells = <1>;
>   		#size-cells = <0>;
>   
> -		gpio-sck = <&gpy3 1 GPIO_ACTIVE_HIGH>;
> -		gpio-mosi = <&gpy3 3 GPIO_ACTIVE_HIGH>;
> +		sck-gpios = <&gpy3 1 GPIO_ACTIVE_HIGH>;
> +		mosi-gpios = <&gpy3 3 GPIO_ACTIVE_HIGH>;
>   		num-chipselects = <1>;
>   		cs-gpios = <&gpy4 3 GPIO_ACTIVE_LOW>;
>   

Best regards
-- 
Marek Szyprowski, PhD
Samsung R&D Institute Poland

