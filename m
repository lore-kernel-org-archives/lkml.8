Return-Path: <SRS0=b2Mh=CK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.7 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D853C433E2
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Sep 2020 10:29:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CF2F72083B
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Sep 2020 10:29:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="dwzkL3xL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726678AbgIAK3Q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 1 Sep 2020 06:29:16 -0400
Received: from mailout2.w1.samsung.com ([210.118.77.12]:40528 "EHLO
        mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726105AbgIAK3K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Sep 2020 06:29:10 -0400
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20200901102907euoutp0249230345fa3015c946f9c2c5011543e7~woiUanjRT0852908529euoutp02U
        for <linux-kernel@vger.kernel.org>; Tue,  1 Sep 2020 10:29:07 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20200901102907euoutp0249230345fa3015c946f9c2c5011543e7~woiUanjRT0852908529euoutp02U
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1598956148;
        bh=k5vdeDzHjYYiOBpxPyP+677nyH6MYEa+gndR4S5JbNE=;
        h=Subject:To:From:Date:In-Reply-To:References:From;
        b=dwzkL3xLJlfl31qqABS7DDFgnH2zY7t3hJEEZQV7nZeyixFXUInT7MIM4NL032WGu
         HdIyc5QCVkibeHUGuz1wPWRkpVKpdafs6Qgi4grqEn43HDvYs9xtl2zpd0Cd/50yUk
         W+mBpP2KFooY/1HkfkQy0Jw/qSU5Z5zsiCRZ1pSs=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20200901102907eucas1p25fc8fbd96345364cfa6246fe9d750c7a~woiUNy6FR0806608066eucas1p2-;
        Tue,  1 Sep 2020 10:29:07 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges3new.samsung.com (EUCPMTA) with SMTP id 46.A8.06318.3722E4F5; Tue,  1
        Sep 2020 11:29:07 +0100 (BST)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20200901102907eucas1p1fce2d1ab4aa01b0627d715f046653c55~woiTu-ADu2026520265eucas1p1A;
        Tue,  1 Sep 2020 10:29:07 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20200901102907eusmtrp2fbedb8238049e1949d0fb4a4b333c7ae~woiTuJucu3227932279eusmtrp2f;
        Tue,  1 Sep 2020 10:29:07 +0000 (GMT)
X-AuditID: cbfec7f5-371ff700000018ae-2a-5f4e22732de5
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id EF.B5.06314.3722E4F5; Tue,  1
        Sep 2020 11:29:07 +0100 (BST)
Received: from [106.210.123.115] (unknown [106.210.123.115]) by
        eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20200901102906eusmtip177a377bbd9f4ff37849a2fde134ace8c~woiSpHjga0106201062eusmtip1z;
        Tue,  1 Sep 2020 10:29:05 +0000 (GMT)
Subject: Re: [PATCH 2/2] dt-bindings: sound: odroid: Use
 unevaluatedProperties
To:     Krzysztof Kozlowski <krzk@kernel.org>,
        Sangbeom Kim <sbkim73@samsung.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>, alsa-devel@alsa-project.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
From:   Sylwester Nawrocki <s.nawrocki@samsung.com>
Message-ID: <30b8ea43-c2d0-5ddf-dc16-a8fe80d47c38@samsung.com>
Date:   Tue, 1 Sep 2020 12:29:05 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
        Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20200830112633.6732-2-krzk@kernel.org>
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrIKsWRmVeSWpSXmKPExsWy7djPc7rFSn7xBl1zNSyuXDzEZDH14RM2
        i/lHzrFanD+/gd3i25UOJovLu+awWbTuPcJucXHFFyYHDo8Nn5vYPHbOusvusWlVJ5tH35ZV
        jB6fN8kFsEZx2aSk5mSWpRbp2yVwZdw9toal4DdzxcWOHrYGxo3MXYwcHBICJhJbNhZ0MXJx
        CAmsYJS49vMpG4TzhVHi5/NV7BDOZ0aJby9/AzmcYB1v1lyFSixnlPj0/ysThPORUeLl5Q8s
        IFXCAgESjxvXs4AkRASmMEmcPrmGFSTBJmAo0Xu0jxHE5hWwk3jS2gsWZxFQkXh1uokZxBYV
        iJPYevwqE0SNoMTJmU/AhnICrV7y4yUbiM0sIC5x68l8JghbXmL72znMIMskBDaxS6x4upwJ
        4lYXiYkreqBsYYlXx7dA/SAj8X/nfCaIhmZGiZ7dt9khnAmMEvePL2CEqLKWuHPuFxsonJgF
        NCXW79KHCDtKbH4zBxp8fBI33gpCHMEnMWnbdKgwr0RHmxBEtYrE71XToU6Qkuh+8p8FwvaQ
        2HVpB/sERsVZSN6cheS1WUhem4VwwwJGllWM4qmlxbnpqcXGeanlesWJucWleel6yfm5mxiB
        Cen0v+NfdzDu+5N0iFGAg1GJh3fFN594IdbEsuLK3EOMEhzMSiK8TmdPxwnxpiRWVqUW5ccX
        leakFh9ilOZgURLnNV70MlZIID2xJDU7NbUgtQgmy8TBKdXAKDKHYZWIx8QT1k9NAi15Dmbv
        NfDfP0Hhvmjt55+/I/66Bz9Y9JEtVIbftduwi9Hm3h3P5s7DHzZkmV3K1zjx0v//CZn68A77
        7R+nms+9fOdE9hm+L2mbNtzTvq78eq3Rcw3RSzorHq48uZmX9W7Gdb4TRz5+VRC59d9IbW53
        puWrt9e3l3H5KimxFGckGmoxFxUnAgCARsoTRAMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrOIsWRmVeSWpSXmKPExsVy+t/xu7rFSn7xBs9mcFtcuXiIyWLqwyds
        FvOPnGO1OH9+A7vFtysdTBaXd81hs2jde4Td4uKKL0wOHB4bPjexeeycdZfdY9OqTjaPvi2r
        GD0+b5ILYI3SsynKLy1JVcjILy6xVYo2tDDSM7S00DMysdQzNDaPtTIyVdK3s0lJzcksSy3S
        t0vQy7h7bA1LwW/miosdPWwNjBuZuxg5OSQETCTerLnK3sXIxSEksJRRov/gSdYuRg6ghJTE
        /BYliBphiT/Xutggat4zSiy9eRysWVjAT2LPzSdgCRGBKUwSt749hZq0kVHi157f7CBVbAKG
        Er1H+xhBbF4BO4knrb2sIDaLgIrEq9NNYJNEBeIkHvf+Z4aoEZQ4OfMJC4jNCXTekh8v2UBs
        ZgF1iT/zLjFD2OISt57MZ4Kw5SW2v53DPIFRcBaS9llIWmYhaZmFpGUBI8sqRpHU0uLc9Nxi
        Q73ixNzi0rx0veT83E2MwEjbduzn5h2MlzYGH2IU4GBU4uEN+OITL8SaWFZcmXuIUYKDWUmE
        1+ns6Tgh3pTEyqrUovz4otKc1OJDjKZAz01klhJNzgcmgbySeENTQ3MLS0NzY3NjMwslcd4O
        gYMxQgLpiSWp2ampBalFMH1MHJxSDYw1f9/MqRT49qvh8bb3us33rU/ZSx5JqHtVV7Ro9l2n
        s85nHhpXr3syTSZQgSNZ/HKZy5s552N01gbF2Sxfu3tqlppst92si8LHezYcz0zzvqv4fKr9
        otU75T7N6U7bcchZ0nPhi+Ckqfo/Wp5bX0yMMT0dXx62YZHJN031rxv0Vf7EPyu7kHheiaU4
        I9FQi7moOBEAXT6ly8oCAAA=
X-CMS-MailID: 20200901102907eucas1p1fce2d1ab4aa01b0627d715f046653c55
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20200830112645eucas1p2e94b4e40ef019afd643461a634d1cdfe
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20200830112645eucas1p2e94b4e40ef019afd643461a634d1cdfe
References: <20200830112633.6732-1-krzk@kernel.org>
        <CGME20200830112645eucas1p2e94b4e40ef019afd643461a634d1cdfe@eucas1p2.samsung.com>
        <20200830112633.6732-2-krzk@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 30.08.2020 13:26, Krzysztof Kozlowski wrote:
> Additional properties or nodes actually might appear (e.g.
> assigned-clocks) so use unevaluatedProperties to fix dtbs_check warnings
> like:
> 
>   arch/arm/boot/dts/exynos5422-odroidxu3.dt.yaml: sound:
>     'assigned-clock-parents', 'assigned-clock-rates', 'assigned-clocks' do not match any of the regexes: 'pinctrl-[0-9]+'
> 
> Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>

Reviewed-by: Sylwester Nawrocki <s.nawrocki@samsung.com>

