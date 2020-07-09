Return-Path: <SRS0=8wH5=AU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5AF57C433DF
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jul 2020 07:13:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3024820674
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jul 2020 07:13:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="sZRLTwD6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726251AbgGIHNz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Jul 2020 03:13:55 -0400
Received: from mailout1.w1.samsung.com ([210.118.77.11]:56865 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726183AbgGIHNy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jul 2020 03:13:54 -0400
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20200709071352euoutp017172d90f82f069c71c4b56c6aaea99b5~gBCavaqnj3063430634euoutp01k
        for <linux-kernel@vger.kernel.org>; Thu,  9 Jul 2020 07:13:52 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20200709071352euoutp017172d90f82f069c71c4b56c6aaea99b5~gBCavaqnj3063430634euoutp01k
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1594278832;
        bh=SYehp1Ieyfb/zjUHumRssxNYKvRphjEhs6jVF/Hb15Y=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=sZRLTwD6P7PmCwQxg5lvA7kTfIpUBqlFORBGD/KTAgvS9+/9gi6LDIjlgVytn5nqi
         ehHTDgD0hf887a+FNMT0jvghcFTqDHEOCsGMrFoH+/lfh+JaQp8edqroS2jykN6q0s
         DLqLAlhCopJrxKRPIiCbdZ/klzl/JBqVqTQK+y7k=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20200709071352eucas1p18e916829b70dc0283917086c58734f10~gBCambvAO0641506415eucas1p1Q;
        Thu,  9 Jul 2020 07:13:52 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges2new.samsung.com (EUCPMTA) with SMTP id FE.7D.05997.0B3C60F5; Thu,  9
        Jul 2020 08:13:52 +0100 (BST)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20200709071351eucas1p28d1160e5e01645f9b453815c1e5f7b9e~gBCaWh2NO3268632686eucas1p2R;
        Thu,  9 Jul 2020 07:13:51 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20200709071351eusmtrp26ce7404010835a9cb51df6e0ddf0786b~gBCaV7URf1669816698eusmtrp2k;
        Thu,  9 Jul 2020 07:13:51 +0000 (GMT)
X-AuditID: cbfec7f4-677ff7000000176d-61-5f06c3b0cdf4
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id 06.B0.06314.FA3C60F5; Thu,  9
        Jul 2020 08:13:51 +0100 (BST)
Received: from [106.210.88.143] (unknown [106.210.88.143]) by
        eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20200709071351eusmtip20e53821d81c791cb0bb235d1760b24ed~gBCaHTS4Z2984929849eusmtip2X;
        Thu,  9 Jul 2020 07:13:51 +0000 (GMT)
Subject: Re: [PATCH 5/6] phy: exynos5-usbdrd: use correct format for
 structure description
To:     Vinod Koul <vkoul@kernel.org>,
        Kishon Vijay Abraham I <kishon@ti.com>
Cc:     linux-kernel@vger.kernel.org
From:   Marek Szyprowski <m.szyprowski@samsung.com>
Message-ID: <ca185eed-32e4-a92e-0d97-ec5ff54de948@samsung.com>
Date:   Thu, 9 Jul 2020 09:13:53 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
        Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200708132809.265967-5-vkoul@kernel.org>
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFuplleLIzCtJLcpLzFFi42LZduzned0Nh9niDV7dZrO48LSHzeLyrjls
        FjvvnGB2YPbYtKqTzeP4je1MHp83yQUwR3HZpKTmZJalFunbJXBl3Nk7mbFgvUBFy4d/LA2M
        23i7GDk4JARMJB5NzO5i5OIQEljBKLHlaC87hPOFUeJ2408o5zOjxKqJM1i6GDnBOhY1rWCE
        SCxnlGi//YoFwnnPKDHnxCV2kCphgRiJVRePsIHYIgKeErf232EFsZkFFCR+3dsEZrMJGEp0
        ve0Cq+EVsJPYcvUYWJxFQEXi6aPVYLaoQJzE+pfbmSBqBCVOznwCdgWngLlEy41pLBAz5SW2
        v53DDGGLS9x6Mp8J5CAJgf9sElMWNrFCnO0iMftxFxOELSzx6vgWdghbRuL/TpiGZkaJh+fW
        skM4PYwSl5tmMEJUWUvcOfeLDRRkzAKaEut36UOEHSW23pzLCglJPokbbwUhjuCTmLRtOjNE
        mFeio00IolpNYtbxdXBrD164xDyBUWkWktdmIXlnFpJ3ZiHsXcDIsopRPLW0ODc9tdgoL7Vc
        rzgxt7g0L10vOT93EyMwkZz+d/zLDsZdf5IOMQpwMCrx8L7YxBovxJpYVlyZe4hRgoNZSYTX
        6ezpOCHelMTKqtSi/Pii0pzU4kOM0hwsSuK8xotexgoJpCeWpGanphakFsFkmTg4pRoYyyrT
        VvF3bmZ+MEOV0drvaeriWfwzvfY8FXuX+GljPdOhL4+ORsxcMnNH1YENb0Nf/rmo3V24UOPw
        iTSTXFmmYKMt6UczG0IbZeOmPFs7x7NyqqdQ4puIKrF9AdvCJhVe+pIuH7VhuuiEkJPLT8a7
        lhvM0Cx86zZlw5SlWhJKq5z62as/LQo8pMRSnJFoqMVcVJwIABHF6EAgAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrAIsWRmVeSWpSXmKPExsVy+t/xe7rrD7PFG1zeYmxx4WkPm8XlXXPY
        LHbeOcHswOyxaVUnm8fxG9uZPD5vkgtgjtKzKcovLUlVyMgvLrFVija0MNIztLTQMzKx1DM0
        No+1MjJV0rezSUnNySxLLdK3S9DLuLN3MmPBeoGKlg//WBoYt/F2MXJySAiYSCxqWsHYxcjF
        ISSwlFFi/ZxbzBAJGYmT0xpYIWxhiT/Xutggit4ySuxauRisSFggRmL5o/MsILaIgKfErf13
        wBqYBRQkft3bxArRsJ1RYsKRCWBFbAKGEl1vQSZxcvAK2ElsuXoMrIFFQEXi6aPVYLaoQJzE
        8i3z2SFqBCVOznwC1sspYC7RcmMaC8QCM4l5mx8yQ9jyEtvfzoGyxSVuPZnPNIFRaBaS9llI
        WmYhaZmFpGUBI8sqRpHU0uLc9NxiQ73ixNzi0rx0veT83E2MwNjZduzn5h2MlzYGH2IU4GBU
        4uF9sYk1Xog1say4MvcQowQHs5IIr9PZ03FCvCmJlVWpRfnxRaU5qcWHGE2BnpvILCWanA+M
        67ySeENTQ3MLS0NzY3NjMwslcd4OgYMxQgLpiSWp2ampBalFMH1MHJxSDYxJz9pSlA5ubNTm
        +B9vnsjeGS76Yq3FooUTygr1nzkJXzW1OpV+WujqCyX1ax+vbeVydritt/HsuiAzfVPWdV0H
        NhrkqpqZG7jkrV7TcibLdv7MjgBlx5f7Mh/9MTF5qhNQyVohcNGM9dd20QPhmbIH6hafr70Q
        VtZy9rFcRO/P3LTWxKjX1UosxRmJhlrMRcWJAGU0U9uzAgAA
X-CMS-MailID: 20200709071351eucas1p28d1160e5e01645f9b453815c1e5f7b9e
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20200708132837eucas1p192b7ac2bfd4dc1def0a18c9cdff01cac
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20200708132837eucas1p192b7ac2bfd4dc1def0a18c9cdff01cac
References: <20200708132809.265967-1-vkoul@kernel.org>
        <CGME20200708132837eucas1p192b7ac2bfd4dc1def0a18c9cdff01cac@eucas1p1.samsung.com>
        <20200708132809.265967-5-vkoul@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 08.07.2020 15:28, Vinod Koul wrote:
> We get warning with W=1 build:
> drivers/phy/samsung/phy-exynos5-usbdrd.c:211: warning: Function
> parameter or member 'phys' not described in 'exynos5_usbdrd_phy'
> drivers/phy/samsung/phy-exynos5-usbdrd.c:211: warning: Function
> parameter or member 'vbus' not described in 'exynos5_usbdrd_phy'
> drivers/phy/samsung/phy-exynos5-usbdrd.c:211: warning: Function
> parameter or member 'vbus_boost' not described in 'exynos5_usbdrd_phy'
>
> These members are provided with description but format is not quite
> right resulting in above warnings
>
> Cc: Marek Szyprowski <m.szyprowski@samsung.com>
> Signed-off-by: Vinod Koul <vkoul@kernel.org>
Acked-by: Marek Szyprowski <m.szyprowski@samsung.com>
> ---
>   drivers/phy/samsung/phy-exynos5-usbdrd.c | 6 +++---
>   1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/phy/samsung/phy-exynos5-usbdrd.c b/drivers/phy/samsung/phy-exynos5-usbdrd.c
> index eb06ce9f748f..bfb0e8914103 100644
> --- a/drivers/phy/samsung/phy-exynos5-usbdrd.c
> +++ b/drivers/phy/samsung/phy-exynos5-usbdrd.c
> @@ -180,14 +180,14 @@ struct exynos5_usbdrd_phy_drvdata {
>    * @utmiclk: clock for utmi+ phy
>    * @itpclk: clock for ITP generation
>    * @drv_data: pointer to SoC level driver data structure
> - * @phys[]: array for 'EXYNOS5_DRDPHYS_NUM' number of PHY
> + * @phys: array for 'EXYNOS5_DRDPHYS_NUM' number of PHY
>    *	    instances each with its 'phy' and 'phy_cfg'.
>    * @extrefclk: frequency select settings when using 'separate
>    *	       reference clocks' for SS and HS operations
>    * @ref_clk: reference clock to PHY block from which PHY's
>    *	     operational clocks are derived
> - * vbus: VBUS regulator for phy
> - * vbus_boost: Boost regulator for VBUS present on few Exynos boards
> + * @vbus: VBUS regulator for phy
> + * @vbus_boost: Boost regulator for VBUS present on few Exynos boards
>    */
>   struct exynos5_usbdrd_phy {
>   	struct device *dev;

Best regards
-- 
Marek Szyprowski, PhD
Samsung R&D Institute Poland

