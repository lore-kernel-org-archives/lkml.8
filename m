Return-Path: <SRS0=2gBQ=CN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79EECC2BC84
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Sep 2020 07:02:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4B415206D4
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Sep 2020 07:02:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="Ss8Um3kc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728163AbgIDHCg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 4 Sep 2020 03:02:36 -0400
Received: from mailout2.w1.samsung.com ([210.118.77.12]:60201 "EHLO
        mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726089AbgIDHCX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Sep 2020 03:02:23 -0400
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20200904070221euoutp02763c5e95763b3b7c8dc83b23ca990315~xgpoegmHw2871628716euoutp02n
        for <linux-kernel@vger.kernel.org>; Fri,  4 Sep 2020 07:02:21 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20200904070221euoutp02763c5e95763b3b7c8dc83b23ca990315~xgpoegmHw2871628716euoutp02n
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1599202941;
        bh=GElZ8nRDfQZGXdl9mZOXUOC0do4xtZsOVmmu33lDiM0=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=Ss8Um3kcvL9aAuiO3NyE8TCk8wZzPyarLqfRiyNGdo+Pvni/wv4zakkbpF8TIIm5m
         ju6tL7H/A7k5LiM9hCK+WqMzNSbShCnsxsSzsOawkFA2DCx8mxPhA4QjIoWis8SkSQ
         cWPcNfM5KSMk53jOZNsBE1eZkfWhKP3Pb3xd4tjM=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20200904070220eucas1p1cd894fc5775cdc872bb05e062c97d089~xgpoMIp9k2108221082eucas1p1q;
        Fri,  4 Sep 2020 07:02:20 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges3new.samsung.com (EUCPMTA) with SMTP id 10.9D.06318.C76E15F5; Fri,  4
        Sep 2020 08:02:20 +0100 (BST)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20200904070220eucas1p29c63e03c10163f153b70e37d4a4ad0d9~xgpn2m7vZ2350823508eucas1p2b;
        Fri,  4 Sep 2020 07:02:20 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20200904070220eusmtrp1283f3745cee48ad685fb9c5a9616cbbd~xgpn16HNu1044210442eusmtrp1U;
        Fri,  4 Sep 2020 07:02:20 +0000 (GMT)
X-AuditID: cbfec7f5-371ff700000018ae-cb-5f51e67c62ba
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id 17.16.06017.C76E15F5; Fri,  4
        Sep 2020 08:02:20 +0100 (BST)
Received: from [106.210.88.143] (unknown [106.210.88.143]) by
        eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20200904070219eusmtip1403d55af07f71eb3aeefb19e701bf38a~xgpnXYF1g3186731867eusmtip1X;
        Fri,  4 Sep 2020 07:02:19 +0000 (GMT)
Subject: Re: [PATCH v2 2/3] ARM: dts: exynos: Add assigned clock parent to
 CMU in Exynos4412 Odroid
To:     Krzysztof Kozlowski <krzk@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Kukjin Kim <kgene@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Sylwester Nawrocki <snawrocki@kernel.org>
From:   Marek Szyprowski <m.szyprowski@samsung.com>
Message-ID: <d5468bf5-516f-58a8-4544-fe7fc377e7b1@samsung.com>
Date:   Fri, 4 Sep 2020 09:02:23 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
        Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <20200903181425.5015-2-krzk@kernel.org>
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrGKsWRmVeSWpSXmKPExsWy7djPc7o1zwLjDeYeMrSYf+Qcq0X/49fM
        FufPb2C32PT4GqvF5V1z2CxmnN/HZNG69wi7RfvTl8wOHB6bVnWyeWxeUu/xeZNcAHMUl01K
        ak5mWWqRvl0CV8bdN4dYCvbzVDR9Ps7WwLiGq4uRk0NCwETi9Pm5rF2MXBxCAisYJS7NOMkM
        khAS+MIocWaaLUTiM6PEv5/TmGA6Zk6fA9WxnFHiV+trNgjnPaPEhY2r2UGqhAVSJbYtaGQB
        SYiAtF+efA1sLrOArsT0d2/AbDYBQ4mut11sIDavgJ3E/VUTweIsAioSnz9fAVsnKhAncezU
        IxaIGkGJkzOfgNmcQGfsuPWVFWKmvMT2t3Og5otL3HoynwlksYTAKnaJ5dtOsUHc7SLxc1M3
        O4QtLPHq+BYoW0bi9OQeFoiGZkaJh+fWskM4PUBnN81ghKiylrhz7hfQJA6gFZoS63fpQ4Qd
        JQ5d7WECCUsI8EnceCsIcQSfxKRt05khwrwSHW1CENVqErOOr4Nbe/DCJeYJjEqzkLw2C8k7
        s5C8Mwth7wJGllWM4qmlxbnpqcXGeanlesWJucWleel6yfm5mxiBqef0v+NfdzDu+5N0iFGA
        g1GJh/fG+4B4IdbEsuLK3EOMEhzMSiK8TmdPxwnxpiRWVqUW5ccXleakFh9ilOZgURLnNV70
        MlZIID2xJDU7NbUgtQgmy8TBKdXAyGGyqM0178BixZs1y4InJLgt+mvS4XHOSv2de/VUn808
        gdbdX72K/7sVHbRSWTrrTJVd2pz/mZ/3CytZJp0x23rzit23w6Zy2vG7gptiK/hS/xyRv1xr
        yvNqjtSOZlvlUt37H99fYl/9snqWumgOy/zYooBe8Wn3vgtxbn/30GRinUHX9PPMSizFGYmG
        WsxFxYkAM3gMkDkDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrBIsWRmVeSWpSXmKPExsVy+t/xu7o1zwLjDX41ilvMP3KO1aL/8Wtm
        i/PnN7BbbHp8jdXi8q45bBYzzu9jsmjde4Tdov3pS2YHDo9NqzrZPDYvqff4vEkugDlKz6Yo
        v7QkVSEjv7jEVina0MJIz9DSQs/IxFLP0Ng81srIVEnfziYlNSezLLVI3y5BL+Pum0MsBft5
        Kpo+H2drYFzD1cXIySEhYCIxc/oc1i5GLg4hgaWMEgsb1zNDJGQkTk5rYIWwhSX+XOtigyh6
        yyix/8sjoAQHh7BAqsTcHmOQuIjAZ0aJZ42bwJqZBXQlpr97wwzRsJFRYvGqX4wgCTYBQ4mu
        tyCTODl4Bewk7q+aCNbAIqAi8fnzFSYQW1QgTuJMzwuoGkGJkzOfsIDYnECn7rj1lRVigZnE
        vM0PoZbJS2x/OwfKFpe49WQ+0wRGoVlI2mchaZmFpGUWkpYFjCyrGEVSS4tz03OLjfSKE3OL
        S/PS9ZLzczcxAmNt27GfW3Ywdr0LPsQowMGoxMN7431AvBBrYllxZe4hRgkOZiURXqezp+OE
        eFMSK6tSi/Lji0pzUosPMZoCPTeRWUo0OR+YBvJK4g1NDc0tLA3Njc2NzSyUxHk7BA7GCAmk
        J5akZqemFqQWwfQxcXBKNTDGaFhcmHLf6e4G98tlaxVi13I/kHU6uW7XRZ2cGzvZc38Xx/2d
        fuyPn16s21tn6w+fuFcxTNqYO4nD+Mah9xF1//QVe0+rt15Y532ctarzldYmW/Z8BdZbD3lf
        /PmzteP8tGuRaRbMa4KV+y44lotf/Rdy1c50ZrTBSgOxidpbc/LSK9vMz21RYinOSDTUYi4q
        TgQA3vADQMsCAAA=
X-CMS-MailID: 20200904070220eucas1p29c63e03c10163f153b70e37d4a4ad0d9
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20200903181440eucas1p251f5f467fdacf8d74d3c20418052eb38
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20200903181440eucas1p251f5f467fdacf8d74d3c20418052eb38
References: <20200903181425.5015-1-krzk@kernel.org>
        <CGME20200903181440eucas1p251f5f467fdacf8d74d3c20418052eb38@eucas1p2.samsung.com>
        <20200903181425.5015-2-krzk@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Krzysztof,

On 03.09.2020 20:14, Krzysztof Kozlowski wrote:
> Commit 68605101460e ("ARM: dts: exynos: Add support for audio over HDMI
> for Odroid X/X2/U3") added assigned clocks under Clock Management Unit.
>
> However the dtschema expects "clocks" property if "assigned-clocks" are
> used.  Add reference to input clock, the parent used in
> "assigned-clock-parents" to silence the dtschema warnings:
>
>    arch/arm/boot/dts/exynos4412-odroidu3.dt.yaml: clock-controller@10030000: 'clocks' is a dependency of 'assigned-clocks'
>
> Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
> ---
>   arch/arm/boot/dts/exynos4412-odroid-common.dtsi | 1 +
>   1 file changed, 1 insertion(+)
>
> diff --git a/arch/arm/boot/dts/exynos4412-odroid-common.dtsi b/arch/arm/boot/dts/exynos4412-odroid-common.dtsi
> index ca3c78e0966c..9375df064076 100644
> --- a/arch/arm/boot/dts/exynos4412-odroid-common.dtsi
> +++ b/arch/arm/boot/dts/exynos4412-odroid-common.dtsi
> @@ -120,6 +120,7 @@
>   };
>   
>   &clock {
> +	clocks = <&clock CLK_FOUT_EPLL>;

This should be one of xusbxti or xxti, because this is the proper input 
clock for the clock controller. However in case of Exynos4, those clocks 
needs much more cleanup. For the historical reasons, they don't use 
generic 'fixed-clock' property, but the custom one and they are no 
instantiated by clock framework, but the exynos4 clock driver...

>   	assigned-clocks = <&clock CLK_FOUT_EPLL>;
>   	assigned-clock-rates = <45158401>;
>   };

Best regards
-- 
Marek Szyprowski, PhD
Samsung R&D Institute Poland

