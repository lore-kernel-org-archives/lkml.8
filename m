Return-Path: <SRS0=8grS=CJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.7 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B92DBC433E2
	for <linux-kernel@archiver.kernel.org>; Mon, 31 Aug 2020 08:31:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 926CB207DA
	for <linux-kernel@archiver.kernel.org>; Mon, 31 Aug 2020 08:31:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="qYhcRYUO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728419AbgHaIbj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 31 Aug 2020 04:31:39 -0400
Received: from mailout1.w1.samsung.com ([210.118.77.11]:56281 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728413AbgHaIbe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Aug 2020 04:31:34 -0400
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20200831083132euoutp01e7e94eff10731bf5c1106fa517914ac8~wTSXkzOci1946019460euoutp01C
        for <linux-kernel@vger.kernel.org>; Mon, 31 Aug 2020 08:31:32 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20200831083132euoutp01e7e94eff10731bf5c1106fa517914ac8~wTSXkzOci1946019460euoutp01C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1598862692;
        bh=stR3Rlc8efnX4TpYSCsE2Dh94LH6yqg/9Gvu5Jw7zKg=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=qYhcRYUOUoMoNrXWP5xHfF4w+kvuk1P1xz3JzouSpaDn2ECb/VXPqV1G38ELGLmDo
         YEV6mCD+cFLLSkAkbAcuYdq0Oj5Rogn3TuBwVTUDcZTollLNiMBmehLqQA5NCvCMLK
         DLDqw1sglaLOs4gLB7WKv11th1pVmnck4KNjL7bA=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20200831083132eucas1p2d4e3f3b9386669f32e5d83b706f7108c~wTSXR4Nzi2714127141eucas1p21;
        Mon, 31 Aug 2020 08:31:32 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges3new.samsung.com (EUCPMTA) with SMTP id 1D.23.06318.465BC4F5; Mon, 31
        Aug 2020 09:31:32 +0100 (BST)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20200831083131eucas1p26aa32fb23609c5f581aa06135dd6f9b3~wTSWqVBH02711427114eucas1p2z;
        Mon, 31 Aug 2020 08:31:31 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20200831083131eusmtrp2fb11b6d16fd33ac324e0f55e4a2f64ec~wTSWpZQK-1725017250eusmtrp23;
        Mon, 31 Aug 2020 08:31:31 +0000 (GMT)
X-AuditID: cbfec7f5-38bff700000018ae-04-5f4cb56444bf
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id 7F.CF.06017.365BC4F5; Mon, 31
        Aug 2020 09:31:31 +0100 (BST)
Received: from [106.210.88.143] (unknown [106.210.88.143]) by
        eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20200831083131eusmtip11bfa2991a42d6ff4c433d765e3604b42~wTSV_v7L10983709837eusmtip1_;
        Mon, 31 Aug 2020 08:31:31 +0000 (GMT)
Subject: Re: [PATCH 23/33] ARM: dts: exynos: Remove empty camera pinctrl
 configuration in Odroid X/U3
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
Message-ID: <c9daff05-dca7-f1b1-8cfe-46b185bf60dd@samsung.com>
Date:   Mon, 31 Aug 2020 10:31:30 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
        Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <20200830135200.24304-23-krzk@kernel.org>
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrCKsWRmVeSWpSXmKPExsWy7djP87opW33iDbYfkrfYOGM9q8X8I+dY
        LVqvP2a36H/8mtni/PkN7BabHl9jtbi8aw6bxYzz+5gsWvceYbfYcuY2m0X705fMDtweRw80
        MntsWtXJ5tGyfhObx+Yl9R59W1YxenzeJBfAFsVlk5Kak1mWWqRvl8CVcXLdPuaCCZwVDZP3
        MTcw7mTvYuTkkBAwkfi0pBfI5uIQEljBKLFjfyMThPOFUaJz0hMo5zOjxIxNr1lhWiZ8m8YM
        YgsJLGeUuLFXEaLoPaPEnslLmEASwgLpEm8vHGUGSYgInGGS+PvtClgHs0CqxO63x8AmsQkY
        SnS97WIDsXkF7CR6d/4Ei7MIqEocXHQFzBYViJM4duoRC0SNoMTJmU/AbE4BM4k9y8+xQ8yU
        l9j+dg7UfHGJW0/mg50tIXCJXWLVnWlMEGe7SCzvmM8IYQtLvDq+BRoCMhL/d8I0NDNKPDy3
        lh3C6WGUuNw0A6rDWuLOuV9Ap3IArdCUWL9LHyLsKDFhzkZ2kLCEAJ/EjbeCEEfwSUzaNp0Z
        Iswr0dEmBFGtJjHr+Dq4tQcvXGKewKg0C8lrs5C8MwvJO7MQ9i5gZFnFKJ5aWpybnlpsnJda
        rlecmFtcmpeul5yfu4kRmLZO/zv+dQfjvj9JhxgFOBiVeHh/HPWOF2JNLCuuzD3EKMHBrCTC
        63T2dJwQb0piZVVqUX58UWlOavEhRmkOFiVxXuNFL2OFBNITS1KzU1MLUotgskwcnFINjJHy
        T9J9DKQaZJP17F1/bik4vt3rfGhItdGnvKYvb7eu3HF3c4K7Qo75Ye7qycZlLfWLY7Yl/l5X
        +3qPodgq7tkXwqSkn5xgNI/hTtVUarifvUpT8ErcVKX8G3P5nD90e9atNmat3vBwcXWUy9Iz
        XQ8Tp5135InIKzXfdS8nO1m80fTZucBmJZbijERDLeai4kQAblUcOVcDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrOIsWRmVeSWpSXmKPExsVy+t/xu7rJW33iDU7MNLDYOGM9q8X8I+dY
        LVqvP2a36H/8mtni/PkN7BabHl9jtbi8aw6bxYzz+5gsWvceYbfYcuY2m0X705fMDtweRw80
        MntsWtXJ5tGyfhObx+Yl9R59W1YxenzeJBfAFqVnU5RfWpKqkJFfXGKrFG1oYaRnaGmhZ2Ri
        qWdobB5rZWSqpG9nk5Kak1mWWqRvl6CXcXLdPuaCCZwVDZP3MTcw7mTvYuTkkBAwkZjwbRpz
        FyMXh5DAUkaJ7X8+MkMkZCROTmtghbCFJf5c62KDKHrLKHH4/ksWkISwQLrE2wtHwbpFBM4x
        Scxc2A82llkgVWJi01QmiI4tjBK3246BjWUTMJToegsyipODV8BOonfnT7AVLAKqEgcXXQGz
        RQXiJM70vICqEZQ4OfMJ2DZOATOJPcvPQS0wk5i3+SEzhC0vsf3tHChbXOLWk/lMExiFZiFp
        n4WkZRaSlllIWhYwsqxiFEktLc5Nzy020itOzC0uzUvXS87P3cQIjNRtx35u2cHY9S74EKMA
        B6MSD++Po97xQqyJZcWVuYcYJTiYlUR4nc6ejhPiTUmsrEotyo8vKs1JLT7EaAr03ERmKdHk
        fGASySuJNzQ1NLewNDQ3Njc2s1AS5+0QOBgjJJCeWJKanZpakFoE08fEwSnVwBinJd5gU8T7
        6tHJPo8vR/aYfTfj+uzCGMj86u1TlecGvDeYbBRvJqj7/5p9RcJ0kaLahH/5ytWnrjb1134t
        tTlzMrkyNc/u6IGHDjFvWR30p0h0WkhcWPjH1y3Q2zPp0m/N/BLD0++CDvA/nKd2Qzru5/mH
        1+ruszA85Zj5Z6XiRZsv7bPe8SqxFGckGmoxFxUnAgB7kYEM6gIAAA==
X-CMS-MailID: 20200831083131eucas1p26aa32fb23609c5f581aa06135dd6f9b3
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20200830135508eucas1p21ad0d4f6a2ef78f854fc74750db3fa2a
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20200830135508eucas1p21ad0d4f6a2ef78f854fc74750db3fa2a
References: <20200830135200.24304-1-krzk@kernel.org>
        <CGME20200830135508eucas1p21ad0d4f6a2ef78f854fc74750db3fa2a@eucas1p2.samsung.com>
        <20200830135200.24304-23-krzk@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Krzysztof,

On 30.08.2020 15:51, Krzysztof Kozlowski wrote:
> The camera's pinctrl configuration is simply empty and not effective.
> Remove it to fix dtbs_check warning:
>
>    arch/arm/boot/dts/exynos4412-odroidx.dt.yaml: camera: pinctrl-0: True is not of type 'array'
>
> Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>

I think that this was intentional to properly enable support for 
mem-2-mem mode in Exynos4-IS (FIMC), but I'm not sure what are the 
default values if no pinctrl properties are provided. Sylwester, could 
you comment?

> ---
>   arch/arm/boot/dts/exynos4412-odroid-common.dtsi | 2 --
>   1 file changed, 2 deletions(-)
>
> diff --git a/arch/arm/boot/dts/exynos4412-odroid-common.dtsi b/arch/arm/boot/dts/exynos4412-odroid-common.dtsi
> index a5c1ce1e396c..6d3576e21ffa 100644
> --- a/arch/arm/boot/dts/exynos4412-odroid-common.dtsi
> +++ b/arch/arm/boot/dts/exynos4412-odroid-common.dtsi
> @@ -136,8 +136,6 @@
>   
>   &camera {
>   	status = "okay";
> -	pinctrl-names = "default";
> -	pinctrl-0 = <>;
>   };
>   
>   &clock {

Best regards
-- 
Marek Szyprowski, PhD
Samsung R&D Institute Poland

