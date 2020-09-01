Return-Path: <SRS0=b2Mh=CK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.7 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D926DC433E2
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Sep 2020 08:13:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id ADFCE206CD
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Sep 2020 08:13:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="tYij/ArO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726479AbgIAINd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 1 Sep 2020 04:13:33 -0400
Received: from mailout2.w1.samsung.com ([210.118.77.12]:38654 "EHLO
        mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726124AbgIAINa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Sep 2020 04:13:30 -0400
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20200901081329euoutp021f956f3735b1efcf47307ff4a2baf541~wmr4c5Nr11278412784euoutp02m
        for <linux-kernel@vger.kernel.org>; Tue,  1 Sep 2020 08:13:29 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20200901081329euoutp021f956f3735b1efcf47307ff4a2baf541~wmr4c5Nr11278412784euoutp02m
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1598948009;
        bh=HrJw4tMrj/wa0rQeF/R+5iE55yvrRVl3qzH988ABYIM=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=tYij/ArOhg5qvVWaP/5y1a8g3yzv5OXb6lhEZVqTd+fbK+Io9C2L2kCZVwQ7Dz269
         p3MLlV8Xrl28LEaobxAKta+dUO072+UvHoBtulRqb0BTmK5ZcRVfsSVqoeMCxxT+3R
         c3sU8j/Q+LcP8mk6npaRxlAr5X7pMTEQhvrQ4dJQ=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20200901081328eucas1p13635dccf551d8d38fc37e7fea038612e~wmr4Eqx0b0795907959eucas1p1j;
        Tue,  1 Sep 2020 08:13:28 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges2new.samsung.com (EUCPMTA) with SMTP id 5F.38.05997.8A20E4F5; Tue,  1
        Sep 2020 09:13:28 +0100 (BST)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20200901081328eucas1p2247362a68145a3da8454a0ff9f65fe48~wmr3oHgjo2342523425eucas1p2c;
        Tue,  1 Sep 2020 08:13:28 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20200901081328eusmtrp1a21614f8190529ca35787bc21097112d~wmr3nUzWn2882728827eusmtrp1D;
        Tue,  1 Sep 2020 08:13:28 +0000 (GMT)
X-AuditID: cbfec7f4-677ff7000000176d-d0-5f4e02a807fb
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id 69.B0.06017.8A20E4F5; Tue,  1
        Sep 2020 09:13:28 +0100 (BST)
Received: from [106.210.88.143] (unknown [106.210.88.143]) by
        eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20200901081327eusmtip2a71be29eeaa9adab47e8f8bc98434711~wmr27ORPe2760827608eusmtip2M;
        Tue,  1 Sep 2020 08:13:27 +0000 (GMT)
Subject: Re: [PATCH 11/13] ARM: dts: exynos: Silence SATA PHY warning in
 Exynos5250 Arndale
To:     Krzysztof Kozlowski <krzk@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Kukjin Kim <kgene@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Sylwester Nawrocki <snawrocki@kernel.org>
From:   Marek Szyprowski <m.szyprowski@samsung.com>
Message-ID: <800d8fa8-7fd4-6221-f8be-ef422e5642d9@samsung.com>
Date:   Tue, 1 Sep 2020 10:13:28 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
        Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <20200901075417.22481-12-krzk@kernel.org>
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrIKsWRmVeSWpSXmKPExsWy7djPc7ormPziDc4tUrLYOGM9q8X8I+dY
        Lfofv2a2OH9+A7vFpsfXWC0u75rDZjHj/D4mi9a9R9gt2p++ZHbg9Ni0qpPNY/OSeo++LasY
        PT5vkgtgieKySUnNySxLLdK3S+DK2Pazm7HgHW9F14Lp7A2MG7m7GDk5JARMJF5te8rexcjF
        ISSwglFi8YyLrBDOF0aJzwcOsEA4nxklGl4vZoRp2fB1IxtEYjmjRM/aK1At7xklVs1sYgGp
        EhaIlfjfuhhssAhI++XJ15hBEswCqRK73x5jBbHZBAwlut52sYHYvAJ2EmsmbwOzWQRUJBZ+
        +wFWLyoQJ3Hs1CMWiBpBiZMzn4DZnAJmEs3P90LNlJfY/nYOlC0ucevJfCaQxRICm9glGn7t
        YoK420Xi2r27rBC2sMSr41vYIWwZidOTe1ggGpoZJR6eW8sO4fQAnd00A+pra4k7534BnccB
        tEJTYv0ufYiwo8Tn69PBwhICfBI33gpCHMEnMWnbdGaIMK9ER5sQRLWaxKzj6+DWHrxwiXkC
        o9IsJK/NQvLOLCTvzELYu4CRZRWjeGppcW56arFRXmq5XnFibnFpXrpecn7uJkZgQjr97/iX
        HYy7/iQdYhTgYFTi4Q344hMvxJpYVlyZe4hRgoNZSYTX6ezpOCHelMTKqtSi/Pii0pzU4kOM
        0hwsSuK8xotexgoJpCeWpGanphakFsFkmTg4pRoYZ5xK/q9WskHe78PBNREbmQRn+kQ5lP45
        f913oe3bzVrXj744emztUVO25PcrBR4scNOK6uNUlHGM2/rYaOmZxG+bL805OIdBdIP3mfsO
        svJOB8QkNxkfkrmxoKbsakn/Fp3O26/ZFPVqZTe+nlMlvL/sx7/Z8sLSDxa0xoe2G1y338Dv
        6Beho8RSnJFoqMVcVJwIAIi64f9EAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrMIsWRmVeSWpSXmKPExsVy+t/xe7ormPziDfatY7fYOGM9q8X8I+dY
        Lfofv2a2OH9+A7vFpsfXWC0u75rDZjHj/D4mi9a9R9gt2p++ZHbg9Ni0qpPNY/OSeo++LasY
        PT5vkgtgidKzKcovLUlVyMgvLrFVija0MNIztLTQMzKx1DM0No+1MjJV0rezSUnNySxLLdK3
        S9DL2Pazm7HgHW9F14Lp7A2MG7m7GDk5JARMJDZ83cjWxcjFISSwlFHi88Q1zBAJGYmT0xpY
        IWxhiT/XuqCK3jJKzH0yCaxIWCBW4n/rYnaQhIjAZ0aJZ42bwBLMAqkSE5umMkF0bGGU+HJ9
        A1iCTcBQoustyChODl4BO4k1k7eB2SwCKhILv/0AqxEViJM40/MCqkZQ4uTMJywgNqeAmUTz
        871QC8wk5m1+CGXLS2x/OwfKFpe49WQ+0wRGoVlI2mchaZmFpGUWkpYFjCyrGEVSS4tz03OL
        jfSKE3OLS/PS9ZLzczcxAiNw27GfW3Ywdr0LPsQowMGoxMMb8MUnXog1say4MvcQowQHs5II
        r9PZ03FCvCmJlVWpRfnxRaU5qcWHGE2BnpvILCWanA9MDnkl8YamhuYWlobmxubGZhZK4rwd
        AgdjhATSE0tSs1NTC1KLYPqYODilGhinCdx7dITpu9PTOra615azIrY8bYs/K7qrYrHn3yzm
        8zIy2o87WczfLxDTSGINEkvYcjeIz6TaYrrfzTm1FotLj/FvunzZ+F61i1f19tDOxR+n53rt
        NbJ505+x+Zj2Z77et43zOSYY28ncfnUwfc2Txz7Tc2z3VNbGhRxvf8ws2TZ1/clbrpJKLMUZ
        iYZazEXFiQDcRqbP1gIAAA==
X-CMS-MailID: 20200901081328eucas1p2247362a68145a3da8454a0ff9f65fe48
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20200901075518eucas1p252ef2b85cf5e1a83d88f8de2dd4a8196
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20200901075518eucas1p252ef2b85cf5e1a83d88f8de2dd4a8196
References: <20200901075417.22481-1-krzk@kernel.org>
        <CGME20200901075518eucas1p252ef2b85cf5e1a83d88f8de2dd4a8196@eucas1p2.samsung.com>
        <20200901075417.22481-12-krzk@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Krzysztof,

On 01.09.2020 09:54, Krzysztof Kozlowski wrote:
> The SATA PHY in Exynos5250 SoCs has two interfaces and two device nodes:
> 1. sata-phy@12170000
> 2. i2c-9/i2c@38
>
> The first node represents the actual SATA PHY device with phy-cells.
> The second represents additional I2C interface, needed by the driver
> to communicate with the SATA PHY device.  It is not a PHY-provider in
> the terms of dtschema so rename it to silence dtbs_check warning:
>
>    arch/arm/boot/dts/exynos5250-arndale.dt.yaml: sata-phy@38: '#phy-cells' is a required property
>      From schema: lib/python3.6/site-packages/dtschema/schemas/phy/phy-provider.yaml
>
> Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
> ---
>   arch/arm/boot/dts/exynos5250-arndale.dts | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/arch/arm/boot/dts/exynos5250-arndale.dts b/arch/arm/boot/dts/exynos5250-arndale.dts
> index f2bcce167b2d..3c401c82905c 100644
> --- a/arch/arm/boot/dts/exynos5250-arndale.dts
> +++ b/arch/arm/boot/dts/exynos5250-arndale.dts
> @@ -544,7 +544,7 @@
>   	samsung,i2c-max-bus-freq = <40000>;
>   	samsung,i2c-slave-addr = <0x38>;
>   
> -	sata_phy_i2c: sata-phy@38 {
> +	sata_phy_i2c: sata-phy-i2c@38 {
>   		compatible = "samsung,exynos-sataphy-i2c";
>   		reg = <0x38>;
>   	};

I'm not against the rename, but frankly, the above node and all i2c 
parameters should be moved to exynos5250.dtsi. This is a SoC internal 
things (the same way as hdmiphy in exynos4.dtsi), so the board dts 
should only contain information like status = "enabled" for i2c_8 and 
hdmi_i2c_phy nodes. No need to duplicate it here and in smdk5250.dts.

Best regards
-- 
Marek Szyprowski, PhD
Samsung R&D Institute Poland

