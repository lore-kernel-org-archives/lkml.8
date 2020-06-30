Return-Path: <SRS0=mvbx=AL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4429EC433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jun 2020 10:09:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 183FC20826
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jun 2020 10:09:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="Y6QZ8UAJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732282AbgF3KJ0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Jun 2020 06:09:26 -0400
Received: from mailout1.w1.samsung.com ([210.118.77.11]:53590 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732165AbgF3KJZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jun 2020 06:09:25 -0400
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20200630100923euoutp01df73c6e42c8cebc8dd67f391f89e2645~dSoGbB9Xw0680906809euoutp01U
        for <linux-kernel@vger.kernel.org>; Tue, 30 Jun 2020 10:09:23 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20200630100923euoutp01df73c6e42c8cebc8dd67f391f89e2645~dSoGbB9Xw0680906809euoutp01U
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1593511763;
        bh=vvk/bkZo2eYBjVnTWyH4skPDFVB5Ke9h14iiIXjhEXU=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=Y6QZ8UAJu1kM16CoOkQFFrPQlbW5RBVsqg8KNYF/cNnGPWRHKOIl+514EQQtT0l3S
         Na05LsGuSzWKtOiBmUJkw0ruf5JRX0Ny7uamkpeP3VtrOGZNPqGvam7e68yDb9WglC
         PMzb7PdKPRtASCvJi4Za6Z9TXlcZVV/rPTJTHldY=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20200630100923eucas1p21c0d910fd8e3ff9fade0ea1ad648fd91~dSoGJnirx2923529235eucas1p2t;
        Tue, 30 Jun 2020 10:09:23 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges2new.samsung.com (EUCPMTA) with SMTP id BF.EF.05997.35F0BFE5; Tue, 30
        Jun 2020 11:09:23 +0100 (BST)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20200630100922eucas1p2c7ae3d8210cc71045c779d8ea7f13f5e~dSoFsp6Nx1098410984eucas1p2Z;
        Tue, 30 Jun 2020 10:09:22 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20200630100922eusmtrp188ff4077e68e12838763b86609dce3a4~dSoFr9DJW1318213182eusmtrp1E;
        Tue, 30 Jun 2020 10:09:22 +0000 (GMT)
X-AuditID: cbfec7f4-65dff7000000176d-5d-5efb0f53dd60
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id A1.52.06314.25F0BFE5; Tue, 30
        Jun 2020 11:09:22 +0100 (BST)
Received: from [106.210.88.143] (unknown [106.210.88.143]) by
        eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20200630100922eusmtip2b526e8bbd87e76e84575cdde2a4ed8dc~dSoFECbdZ3075530755eusmtip2N;
        Tue, 30 Jun 2020 10:09:22 +0000 (GMT)
Subject: Re: [RFT 2/3] arm64: dts: exynos: Add unit address to soc node on
 Exynos5433
To:     Krzysztof Kozlowski <krzk@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Kukjin Kim <kgene@kernel.org>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Sylwester Nawrocki <snawrocki@kernel.org>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Pankaj Dubey <pankaj.dubey@samsung.com>
From:   Marek Szyprowski <m.szyprowski@samsung.com>
Message-ID: <1c087737-5aa5-4232-69f3-26ac999a13a1@samsung.com>
Date:   Tue, 30 Jun 2020 12:09:22 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
        Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <20200629193338.29540-2-krzk@kernel.org>
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrHKsWRmVeSWpSXmKPExsWy7djPc7rB/L/jDE5vFbR4MG8bm8XGGetZ
        La5/ec5qMf/IOVaL/sevmS3On9/AbrHp8TVWi8u75rBZzDi/j8li0dYv7Bate4+wW7Q/fcns
        wOOxaVUnm8fmJfUefVtWMXp83iQXwBLFZZOSmpNZllqkb5fAlfHj9y/mgt/sFT27L7A1MG5m
        62Lk5JAQMJGY3byXpYuRi0NIYAWjRMP0h4wQzhdGiX/nXrBDOJ8ZJSbtmMgK0zJ98R12EFtI
        YDmjxM3n3BBF7xkl9l0/DjZXWCBc4tCqbiaQhIjALCaJtv33wEYxC2xjlDg25QnYKDYBQ4mu
        t11gHbwCdhIHZn1kArFZBFQlfqy/C7ZCVCBWom/pAqgaQYmTM58AXcvBwSlgKrHkmBJImFlA
        XmL72znMELa4xK0n85kgLr3ELvGuywzCdpHYsGgS1NPCEq+Ob2GHsGUkTk/uAQeAhEAzo8TD
        c2vZIZweRonLTTMYIaqsJe6c+8UGsphZQFNi/S59iLCjxP+bb8HukRDgk7jxVhDiBj6JSdum
        M0OEeSU62oQgqtUkZh1fB7f24IVLzBMYlWYheWwWkm9mIflmFsLeBYwsqxjFU0uLc9NTi43y
        Usv1ihNzi0vz0vWS83M3MQJT1el/x7/sYNz1J+kQowAHoxIPb8K5n3FCrIllxZW5hxglOJiV
        RHidzp6OE+JNSaysSi3Kjy8qzUktPsQozcGiJM5rvOhlrJBAemJJanZqakFqEUyWiYNTqoEx
        d5nEPa2Im+/cxVWf1zVHBa8Q+e3k4VPqWXx3aX7ZEu5Z5qyfLv4qsXr2jusRwwE/2VyxZZve
        8TmyPDGozlis/qhY/8HKlTvCPvkkhFtaKeb7mAYEmDusdPNMXBcXevUmx+XdWnP4++7rZ4XP
        /pWseOqSuOjEHPbFq1lSnJRcDT4vZrCfWabEUpyRaKjFXFScCAAGNH+pUQMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrEIsWRmVeSWpSXmKPExsVy+t/xe7pB/L/jDF5MNLZ4MG8bm8XGGetZ
        La5/ec5qMf/IOVaL/sevmS3On9/AbrHp8TVWi8u75rBZzDi/j8li0dYv7Bate4+wW7Q/fcns
        wOOxaVUnm8fmJfUefVtWMXp83iQXwBKlZ1OUX1qSqpCRX1xiqxRtaGGkZ2hpoWdkYqlnaGwe
        a2VkqqRvZ5OSmpNZllqkb5egl/Hj9y/mgt/sFT27L7A1MG5m62Lk5JAQMJGYvvgOexcjF4eQ
        wFJGiQPti6ASMhInpzWwQtjCEn+udbFBFL1llPg38SRYkbBAuMShVd1MIAkRgVlMEgf2PGYE
        cZgFtjFK3L/SBtWymVFi+dFr7CAtbAKGEl1vu8DaeQXsJA7M+sgEYrMIqEr8WH8XrEZUIFbi
        270tUDWCEidnPmHpYuTg4BQwlVhyTAkkzCxgJjFv80NmCFteYvvbOVC2uMStJ/OZJjAKzULS
        PQtJyywkLbOQtCxgZFnFKJJaWpybnltsqFecmFtcmpeul5yfu4kRGJ/bjv3cvIPx0sbgQ4wC
        HIxKPLwJ537GCbEmlhVX5h5ilOBgVhLhdTp7Ok6INyWxsiq1KD++qDQntfgQoynQbxOZpUST
        84GpI68k3tDU0NzC0tDc2NzYzEJJnLdD4GCMkEB6YklqdmpqQWoRTB8TB6dUA6PuheqqrwVd
        Gl9ElOf8XeUomWxy/X3cl/x2k8MCr/+lWCYKOWf4X5ianff/m8Ee5x/TUk6piir4e3IwfE7e
        uVVGkN2hWlShbOHDw43PhXzF/LZNjpzPN8PzVmfcb1Pxe0FTPZriXx7O+Oo3f9LyoJk3bqtv
        qDieX7Z3Tcd7ZbYjxoLPFs2/G6PEUpyRaKjFXFScCACVNFfb5QIAAA==
X-CMS-MailID: 20200630100922eucas1p2c7ae3d8210cc71045c779d8ea7f13f5e
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20200629193354eucas1p20f5d1811033f3ce3189a5d4682b759f7
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20200629193354eucas1p20f5d1811033f3ce3189a5d4682b759f7
References: <20200629193338.29540-1-krzk@kernel.org>
        <CGME20200629193354eucas1p20f5d1811033f3ce3189a5d4682b759f7@eucas1p2.samsung.com>
        <20200629193338.29540-2-krzk@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 29.06.2020 21:33, Krzysztof Kozlowski wrote:
> Add @0 unit address to 'soc' node match its 'reg' property and silence
> DTC warning:
>
>      Warning (unit_address_vs_reg): /soc: node has a reg or ranges property, but no unit name
>
> Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
Tested-by: Marek Szyprowski <m.szyprowski@samsung.com>
> ---
>
> Not tested on HW.
> ---
>   arch/arm64/boot/dts/exynos/exynos5433.dtsi | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/arch/arm64/boot/dts/exynos/exynos5433.dtsi b/arch/arm64/boot/dts/exynos/exynos5433.dtsi
> index 6721966140f4..ebe089469b5f 100644
> --- a/arch/arm64/boot/dts/exynos/exynos5433.dtsi
> +++ b/arch/arm64/boot/dts/exynos/exynos5433.dtsi
> @@ -256,7 +256,7 @@
>   		cpu_on = <0xC4000003>;
>   	};
>   
> -	soc: soc {
> +	soc: soc@0 {
>   		compatible = "simple-bus";
>   		#address-cells = <1>;
>   		#size-cells = <1>;

Best regards
-- 
Marek Szyprowski, PhD
Samsung R&D Institute Poland

