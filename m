Return-Path: <SRS0=mvbx=AL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B80BC433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jun 2020 15:24:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 551BA20663
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jun 2020 15:24:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="kYjGBml7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389405AbgF3PYk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Jun 2020 11:24:40 -0400
Received: from mailout2.samsung.com ([203.254.224.25]:10257 "EHLO
        mailout2.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389379AbgF3PYi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jun 2020 11:24:38 -0400
Received: from epcas5p2.samsung.com (unknown [182.195.41.40])
        by mailout2.samsung.com (KnoxPortal) with ESMTP id 20200630152436epoutp028bbc1ae87319cc418c23353374dbcfba~dW7Urv-RO1807318073epoutp02l
        for <linux-kernel@vger.kernel.org>; Tue, 30 Jun 2020 15:24:36 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20200630152436epoutp028bbc1ae87319cc418c23353374dbcfba~dW7Urv-RO1807318073epoutp02l
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1593530676;
        bh=PJsaZosZhVboh9xvS5edmokuNsTfJ9mFnkqdFYvcbb4=;
        h=From:To:Cc:In-Reply-To:Subject:Date:References:From;
        b=kYjGBml71GvdrID6X97yNrbbdKCyIrlcfps6jQdFKI6J6WSJAJZ1ictIMAVssN9cq
         e2srWPNH/CFR5DT1byY52rqBK2dnSvowttbP3tNSbpHXSBfQY7u1TcFBzx0UEVJVXP
         ub9r+FuytWNnBNgh0dNMfcGFrpz1BkiKSHZ7o2lg=
Received: from epsmges5p2new.samsung.com (unknown [182.195.42.74]) by
        epcas5p3.samsung.com (KnoxPortal) with ESMTP id
        20200630152436epcas5p3e8a810a0cd70bf63ad72397d8489cb1a~dW7UMWmvj1101211012epcas5p3j;
        Tue, 30 Jun 2020 15:24:36 +0000 (GMT)
Received: from epcas5p2.samsung.com ( [182.195.41.40]) by
        epsmges5p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
        EB.F0.09703.4395BFE5; Wed,  1 Jul 2020 00:24:36 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas5p1.samsung.com (KnoxPortal) with ESMTPA id
        20200630152435epcas5p1d7bff0effc267dc6ea9ceb116328de8f~dW7Tewm6S2994429944epcas5p18;
        Tue, 30 Jun 2020 15:24:35 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20200630152435epsmtrp2eb0c826c43a6ec29baa493396fd5b364~dW7Td9Rju3154931549epsmtrp2I;
        Tue, 30 Jun 2020 15:24:35 +0000 (GMT)
X-AuditID: b6c32a4a-4cbff700000025e7-b7-5efb5934833a
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        4C.6F.08382.3395BFE5; Wed,  1 Jul 2020 00:24:35 +0900 (KST)
Received: from alimakhtar02 (unknown [107.108.234.165]) by
        epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20200630152431epsmtip23448907310a2e22c34e9fa19291b14f1~dW7PZmFIC1451814518epsmtip2f;
        Tue, 30 Jun 2020 15:24:30 +0000 (GMT)
From:   "Alim Akhtar" <alim.akhtar@samsung.com>
To:     "'Krzysztof Kozlowski'" <krzk@kernel.org>,
        "'Rob Herring'" <robh+dt@kernel.org>,
        "'Kukjin Kim'" <kgene@kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-samsung-soc@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Cc:     "'Marek Szyprowski'" <m.szyprowski@samsung.com>,
        "'Bartlomiej Zolnierkiewicz'" <b.zolnierkie@samsung.com>,
        "'Sylwester Nawrocki'" <snawrocki@kernel.org>,
        "'Chanwoo Choi'" <cw00.choi@samsung.com>,
        "'Pankaj Dubey'" <pankaj.dubey@samsung.com>
In-Reply-To: <20200629204442.17336-1-krzk@kernel.org>
Subject: RE: [PATCH 1/4] arm64: dts: exynos: Add PWM interrupts on Exynos7
Date:   Tue, 30 Jun 2020 20:54:28 +0530
Message-ID: <001101d64ef2$8f824620$ae86d260$@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQE8Ci1xY1y92w75eesLer1AkuYEHgJddoA8qhH923A=
Content-Language: en-in
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrEKsWRmVeSWpSXmKPExsWy7bCmhq5J5O84g+dPuS02zljPanH9y3NW
        i/lHzrFa9D9+zWxx/vwGdotNj6+xWlzeNYfNYsb5fUwWa4/cZbdYtPULu0Xr3iPsFu1PXzI7
        8HhsWtXJ5rF5Sb1H35ZVjB6fN8kFsERx2aSk5mSWpRbp2yVwZRyecp+1YKZAxcGTy1gbGOfy
        djFyckgImEhcX7marYuRi0NIYDejRPPpR+wQzidGibnLnzNCON8YJX5u/8sC09IzrRuqai+j
        RMfs31DOG0aJyefWsIJUsQnoSuxY3AY2WESgnUli7/7lYA6zwE9GiaYNB8GqOAVMJRYtmM4M
        YgsLeEm8uv4QzGYRUJXY9GARkM3BwStgKTFzWx1ImFdAUOLkzCdgZzALyEtsfzuHGeIkBYmf
        T5eBjRQRsJJ4+/oHM0SNuMTRnz1QNXs4JBq3WkHYLhJHLu+AigtLvDq+hR3ClpL4/G4vG8ha
        CYFsiZ5dxhDhGoml845BfW8vceDKHBaQEmYBTYn1u/QhNvFJ9P5+wgTRySvR0SYEUa0q0fzu
        KlSntMTE7m5WCNtD4lP/FaYJjIqzkPw1C8lfs5DcPwth2QJGllWMkqkFxbnpqcWmBUZ5qeV6
        xYm5xaV56XrJ+bmbGMHJSstrB+PDBx/0DjEycTAeYpTgYFYS4T1t8CtOiDclsbIqtSg/vqg0
        J7X4EKM0B4uSOK/SjzNxQgLpiSWp2ampBalFMFkmDk6pBib3z5N4lAP8PX70K4h7yXgXFETm
        /fwo/mHuQ6Hr7reKHI6yLHr7JtTp0fsnD+Z+7K00kt5QlhjnrHV18i/fPOd7oclVrCdyv3db
        vK8quL7IseWslIBvy+pFywO9DirlPr6+XDhEffJK0a8LmvOeXH4st3lm/NonAjMzVm+0E5dY
        8LmmuLw5zPvNs7UBU6ezfg8OvGy9ZrbBi82CXDzXyy7HrP/u/lAnYnmZr06mgPTy+2cfharM
        mXTi0hwhVmlz14he62X7JMV/dxgU2ixVD5Xly2ZsdGV4HypuLXnsmE/+6ltfTC6/6b6ioW8V
        m2TwU6F7ZlTsmujnbqp7G/jYVcPW5sc/8Htv3lG6gEV0nxJLcUaioRZzUXEiAG3EFqLFAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprKIsWRmVeSWpSXmKPExsWy7bCSvK5x5O84gxUnpSw2zljPanH9y3NW
        i/lHzrFa9D9+zWxx/vwGdotNj6+xWlzeNYfNYsb5fUwWa4/cZbdYtPULu0Xr3iPsFu1PXzI7
        8HhsWtXJ5rF5Sb1H35ZVjB6fN8kFsERx2aSk5mSWpRbp2yVwZRyecp+1YKZAxcGTy1gbGOfy
        djFyckgImEj0TOtm72Lk4hAS2M0o8bDzMSNEQlri+sYJ7BC2sMTKf8+hil4xSjR//MQEkmAT
        0JXYsbiNDcQWEehlkjj53gSkiFngN6PE04sXWCE62hglVl08wgJSxSlgKrFowXRmEFtYwEvi
        1fWHYDaLgKrEpgeLgGwODl4BS4mZ2+pAwrwCghInZz5hAQkzC+hJtG0EO45ZQF5i+9s5zBDH
        KUj8fLqMFeIGK4m3r38wQ9SISxz92cM8gVF4FpJJsxAmzUIyaRaSjgWMLKsYJVMLinPTc4sN
        CwzzUsv1ihNzi0vz0vWS83M3MYJjTktzB+P2VR/0DjEycTAeYpTgYFYS4T1t8CtOiDclsbIq
        tSg/vqg0J7X4EKM0B4uSOO+NwoVxQgLpiSWp2ampBalFMFkmDk6pBiZjBS/XwyYzI3fmzemp
        Z5x5YcH89UEPSle9tiidzeX5jnHSbN36TOkMUZb1p05OiD6m/KXMrUuoctXvpDOJ6rv+y7eX
        eB4+9jt9dn3uwUm2J12yNDbzenxfZ6Smtq5m5g1Wp30RRTIlS848Py75SSYkSOD/K5uU29c5
        3xx+J/bJ5025sfOdX2LV2499v9EeFxPb9Pp34G+BWpfcOxvynXYsnB61TrNrvc3kzFXSd5vv
        HRVd1OERa/cgYKHxF+V/q/g4YudZs3Jc32RnLJzcahPt1F3TlLV/ok+o0enIs01fpq/IjBHu
        PP5or+f7VRfPb5gYpKn5dOfKvzumro3sKvZjYtAtY+pk/xx92t/aNlyJpTgj0VCLuag4EQAv
        8BuPKAMAAA==
X-CMS-MailID: 20200630152435epcas5p1d7bff0effc267dc6ea9ceb116328de8f
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 105P
X-CMS-RootMailID: 20200629205534epcas5p33eb7cbdff4aee986d2e509e0c79cf952
References: <CGME20200629205534epcas5p33eb7cbdff4aee986d2e509e0c79cf952@epcas5p3.samsung.com>
        <20200629204442.17336-1-krzk@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Krzysztof,

> -----Original Message-----
> From: Krzysztof Kozlowski <krzk@kernel.org>
> Sent: 30 June 2020 02:15
> To: Rob Herring <robh+dt@kernel.org>; Kukjin Kim <kgene@kernel.org>;
> Krzysztof Kozlowski <krzk@kernel.org>; devicetree@vger.kernel.org;
linux-arm-
> kernel@lists.infradead.org; linux-samsung-soc@vger.kernel.org; linux-
> kernel@vger.kernel.org
> Cc: Marek Szyprowski <m.szyprowski@samsung.com>; Bartlomiej Zolnierkiewicz
> <b.zolnierkie@samsung.com>; Sylwester Nawrocki <snawrocki@kernel.org>;
> Alim Akhtar <alim.akhtar@samsung.com>; Chanwoo Choi
> <cw00.choi@samsung.com>; Pankaj Dubey <pankaj.dubey@samsung.com>
> Subject: [PATCH 1/4] arm64: dts: exynos: Add PWM interrupts on Exynos7
> 
> Add required interrupts to PWM node on Exynos7.  This fixes DT schema
> warning:
> 
>     pwm@136c0000: 'interrupts' is a required property
> 
> Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
> 
> ---
> 
> Not tested
> ---
>  arch/arm64/boot/dts/exynos/exynos7.dtsi | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/exynos/exynos7.dtsi
> b/arch/arm64/boot/dts/exynos/exynos7.dtsi
> index f590891efe25..523547b3d539 100644
> --- a/arch/arm64/boot/dts/exynos/exynos7.dtsi
> +++ b/arch/arm64/boot/dts/exynos/exynos7.dtsi
> @@ -581,6 +581,11 @@
>  		pwm: pwm@136c0000 {
>  			compatible = "samsung,exynos4210-pwm";
>  			reg = <0x136c0000 0x100>;
> +			interrupts = <GIC_SPI 444 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 445 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 446 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 447 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 448 IRQ_TYPE_LEVEL_HIGH>;
PWM IRQs are from 449 ~ 453 for PWM[0] ~ PWM[4] on this SoC.
444 ~ 447 are for HSI2C and 448 is for ADC.
Please see the exynos7.dtsi
Also drivers/pwm/pwm-samsung.c does not uses interrupt at all, still we need
interrupts property to be added here?

>  			samsung,pwm-outputs = <0>, <1>, <2>, <3>;
>  			#pwm-cells = <3>;
>  			clocks = <&clock_peric0 PCLK_PWM>;
> --
> 2.17.1


