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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 326F5C433E2
	for <linux-kernel@archiver.kernel.org>; Mon, 31 Aug 2020 13:13:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0414C206E3
	for <linux-kernel@archiver.kernel.org>; Mon, 31 Aug 2020 13:13:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="E23MQ2Ag"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726924AbgHaNNM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 31 Aug 2020 09:13:12 -0400
Received: from mailout2.w1.samsung.com ([210.118.77.12]:54570 "EHLO
        mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726446AbgHaNME (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Aug 2020 09:12:04 -0400
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20200831131201euoutp022b6f2db484b13c559df20aca9c831fe1~wXHQguPAV1825018250euoutp02m
        for <linux-kernel@vger.kernel.org>; Mon, 31 Aug 2020 13:12:01 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20200831131201euoutp022b6f2db484b13c559df20aca9c831fe1~wXHQguPAV1825018250euoutp02m
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1598879521;
        bh=ncNOftLh5euUDhPT2J9eGhVokTxah8I5H8Gds+tgwdA=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=E23MQ2AgwqlIrNPxx/Lk4Yqrs0DW424KOuK8UJWsYt5Ngl79W/aCr8HDJmbDiV2uk
         tsoHMfbF8LB6s9hQY0+7XT0oRJBv9uATuD/DLTYA7w0pBEQPhcZ2HSs5k1iZ6ZLfWp
         gvOxnXJvj84FTnuEWoC1G0OJLbIkdn37zLOXU0Jw=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20200831131201eucas1p2bb0e5cee31e3d7bb8f28293f76665f85~wXHQBbcay1390113901eucas1p2x;
        Mon, 31 Aug 2020 13:12:01 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges1new.samsung.com (EUCPMTA) with SMTP id DB.18.06456.027FC4F5; Mon, 31
        Aug 2020 14:12:00 +0100 (BST)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20200831131200eucas1p2e679a2b71a1ae544fea8d8331005b15b~wXHPjUVhC1390113901eucas1p2w;
        Mon, 31 Aug 2020 13:12:00 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20200831131200eusmtrp251988e81c61f607d5bfe5eccf3f4945b~wXHPibp8M2792527925eusmtrp2a;
        Mon, 31 Aug 2020 13:12:00 +0000 (GMT)
X-AuditID: cbfec7f2-7efff70000001938-44-5f4cf720ed7d
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id A1.08.06017.027FC4F5; Mon, 31
        Aug 2020 14:12:00 +0100 (BST)
Received: from [106.210.88.143] (unknown [106.210.88.143]) by
        eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20200831131159eusmtip1e26f9bc42782b3a26b5ba982b648f93b~wXHOMLasZ2543925439eusmtip1Z;
        Mon, 31 Aug 2020 13:11:59 +0000 (GMT)
Subject: Re: [RFT 10/10] arm64: dts: exynos: Enable Arizona interrupt
 controller in Exynos5433 TM2
To:     Krzysztof Kozlowski <krzk@kernel.org>,
        Kukjin Kim <kgene@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Lee Jones <lee.jones@linaro.org>,
        Sangbeom Kim <sbkim73@samsung.com>,
        Sylwester Nawrocki <s.nawrocki@samsung.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        alsa-devel@alsa-project.org
Cc:     Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Sylwester Nawrocki <snawrocki@kernel.org>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Inki Dae <inki.dae@samsung.com>
From:   Marek Szyprowski <m.szyprowski@samsung.com>
Message-ID: <84ec0795-2b7f-adde-4277-2238cede8c24@samsung.com>
Date:   Mon, 31 Aug 2020 15:11:58 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
        Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <20200829142501.31478-10-krzk@kernel.org>
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Brightmail-Tracker: H4sIAAAAAAAAA02SaUwTURSF82brUG19FJTrrjWuiShRySMaosZljEuMxiUmilUmQKRVO4Bi
        XEhRRASkRhQbF0IIkroXAqLFBREiSnEhqKhBLIobopbiEgUZR5R/Z875ztx7k8fTOis3gI8y
        xYhmkyFaz6mZoorvNeOHfV0QNvHbmxCS5rpNkdr7ZRS5mHWeJZmNTRx51NbMkhOewaSzyEqT
        k+UultR6WzlysCGDIQfc72lSU3NBRRq8txBpr02miMNdx5KHl49xJKvmKkX2lJaryM0Pe1ly
        P7+NIntfvaVJgSOTnt5PuOCxcEJpezYjlNieqwSHfR8nPKtzcsJHl0slFLe/YIWG/ZWUUJC7
        S0gvtCPB4xiyuNcq9bRwMToqTjRPCF2rjrx2ulG1ydp7a+dLC5eAUtUpyIcHPBn2/KpnU5Ca
        1+F8BK9/vqDkQIfbEKQfoZTAg8Du7qC7G9WHaxklONXVqLL8rbcisGY/VcmUHw4Hj/PJH8of
        J7NwyGln5YDG5xAkOlbImsNBkNKSwslag0PB6vzVxfA8g0fC9cx5st0Xr4GKqpeMgvjC7aNN
        jIz44GCos2uVPw6F4pZjtKIDoL7p5J+tAd/loTwvl1K2ngWnC4tVivaDd5WFf/Ug6CzpLiQi
        aHSdVSkfqQgeWrKQQk2FZ64fnDyZxmPh/OUJij0DvEleJNuAtfC4xVdZQgsHi47Qiq2B5CSd
        Qo8CW+W5f2Nv3HtAZyC9rcdlth7n2HqcY/s/NxsxdhQgxkrGCFEKMolbAiWDUYo1RQSu32h0
        oK6Heqej8ssl5H2wrgxhHul7axa3LQjTsYY4Kd5YhoCn9f6amdV31ug04Yb4baJ5Y5g5NlqU
        ytBAntEHaCblvF2twxGGGHGDKG4Szd0pxfsMSEAmTUfalCv9Uz8tyXE6r6bHtJ7p5ZvQ4g4Z
        PXXit8DdFYNLos5sJTvvGq80+7tjtn+m5gYX7Fi6ct38UUMlP21Gg+tD5EqE4hZ9V6cF+yzv
        E1/v2XV4SXVIFDtCe2p4Tp5ntqY5PzYxsXTu46S6Du3w0M8Lj4+x8CviN0+ag91H9VXL9IwU
        aQgaR5slw28aq32LpAMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrKKsWRmVeSWpSXmKPExsVy+t/xu7oK333iDZ5NlrboPXeSyeLKxUNM
        FhtnrGe1mPrwCZvF9S/PWS3mfZa1+L9tIrPF/CPnWC2ufH3PZjHp/gQWi/7Hr5ktzp/fwG5x
        /+tRRotvVzqYLDY9vsZqcXnXHDaLGef3MVm07j3CbnH4TTurxcUVX5gs2p++ZLbYvGkqs4OY
        x4bPTWwee78tYPHYOesuu8emVZ1sHneu7WHzeHfuHLvH9m8PWD3udx9n8ti8pN6jb8sqRo/P
        m+QCuKP0bIryS0tSFTLyi0tslaINLYz0DC0t9IxMLPUMjc1jrYxMlfTtbFJSczLLUov07RL0
        MvavfsheMJGn4v+jJrYGxh6uLkZODgkBE4mz066wdDFycQgJLGWU6Dp7gBEiISNxcloDK4Qt
        LPHnWhcbRNFbRonL66ewgCSEBVIkPu+5CdYtItDDKtG8tIcZxGEWWMco8XpzEytEyxZGiUX9
        /cwgLWwChhJdb0FmcXLwCthJTNzzF6iIg4NFQFXiwFRPkLCoQJzEmZ4XUCWCEidnPmEBKeEU
        MJO4tooPJMwMZM7b/JAZwpaX2P52DpQtLnHryXymCYxCs5B0z0LSMgtJyywkLQsYWVYxiqSW
        Fuem5xYb6RUn5haX5qXrJefnbmIEJpFtx35u2cHY9S74EKMAB6MSD2/AF594IdbEsuLK3EOM
        EhzMSiK8TmdPxwnxpiRWVqUW5ccXleakFh9iNAV6bSKzlGhyPjDB5ZXEG5oamltYGpobmxub
        WSiJ83YIHIwREkhPLEnNTk0tSC2C6WPi4JRqYJyg0p1dJ7spJXrHfpYbHk9mzPrQFlJ07eTj
        G3e6z9Tzx5hekZQ/EMCwwpLjzY/a0Jeznfm+iEU88P4o9sDUlnfmjQsXJs/2mqK+qLS83bsm
        4sjkpCbGF9a7XLUM3DkOKE6T4Ga8VjqN/82nxrgHX5Z0zV76NNi4ebt/SI+of4Eu455YY/U1
        TkosxRmJhlrMRcWJAGEJhoE4AwAA
X-CMS-MailID: 20200831131200eucas1p2e679a2b71a1ae544fea8d8331005b15b
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20200829142607eucas1p137f06c4bac607652e972f4c49d1a9982
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20200829142607eucas1p137f06c4bac607652e972f4c49d1a9982
References: <20200829142501.31478-1-krzk@kernel.org>
        <CGME20200829142607eucas1p137f06c4bac607652e972f4c49d1a9982@eucas1p1.samsung.com>
        <20200829142501.31478-10-krzk@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 29.08.2020 16:25, Krzysztof Kozlowski wrote:
> The Wolfson Arizona codec is interrupt controller which is required by
> bindings.  This fixes dtbs_check warnings like:
>
>    arch/arm64/boot/dts/exynos/exynos5433-tm2e.dt.yaml: wm5110-codec@0: 'interrupt-controller' is a required property
>    arch/arm64/boot/dts/exynos/exynos5433-tm2e.dt.yaml: wm5110-codec@0: '#interrupt-cells' is a required property
>
> Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>

Tested-by: Marek Szyprowski <m.szyprowski@samsung.com>

However I really wonder if it makes sense to expose this to DTS. Indeed, 
the main MFD device of the WM5110 chip is interrupt controller, but its 
interrupts are requested internally by the respective drivers.

> ---
>
> Not tested on HQ. Please kindly review and test.
>
> Best regards,
> Krzysztof
> ---
>   arch/arm64/boot/dts/exynos/exynos5433-tm2-common.dtsi | 2 ++
>   1 file changed, 2 insertions(+)
>
> diff --git a/arch/arm64/boot/dts/exynos/exynos5433-tm2-common.dtsi b/arch/arm64/boot/dts/exynos/exynos5433-tm2-common.dtsi
> index bab6c1addd5f..49cd55d6891c 100644
> --- a/arch/arm64/boot/dts/exynos/exynos5433-tm2-common.dtsi
> +++ b/arch/arm64/boot/dts/exynos/exynos5433-tm2-common.dtsi
> @@ -1242,6 +1242,8 @@
>   
>   		gpio-controller;
>   		#gpio-cells = <2>;
> +		interrupt-controller;
> +		#interrupt-cells = <2>;
>   
>   		wlf,micd-detect-debounce = <300>;
>   		wlf,micd-bias-start-time = <0x1>;

Best regards
-- 
Marek Szyprowski, PhD
Samsung R&D Institute Poland

