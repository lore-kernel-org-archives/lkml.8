Return-Path: <SRS0=RE5T=7A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E8D5C433E1
	for <linux-kernel@archiver.kernel.org>; Mon, 18 May 2020 04:58:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EB9BA2070A
	for <linux-kernel@archiver.kernel.org>; Mon, 18 May 2020 04:58:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="MmZzi/fo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726511AbgERE61 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 May 2020 00:58:27 -0400
Received: from mailout2.samsung.com ([203.254.224.25]:38447 "EHLO
        mailout2.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726040AbgERE60 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 May 2020 00:58:26 -0400
Received: from epcas1p3.samsung.com (unknown [182.195.41.47])
        by mailout2.samsung.com (KnoxPortal) with ESMTP id 20200518045823epoutp02bb62b0235f6e3fe6a4773db62439b79b~QBpSTkArP1897918979epoutp02n
        for <linux-kernel@vger.kernel.org>; Mon, 18 May 2020 04:58:23 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20200518045823epoutp02bb62b0235f6e3fe6a4773db62439b79b~QBpSTkArP1897918979epoutp02n
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1589777903;
        bh=2vKXIIAYOJgXhTtQivWEVpWzLzbMQ4ucMNU0uUTwl/U=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=MmZzi/foElZN65Xwgb+7uAHNZDSVtBp7834w3bfhDGim/dXViessWyDHK0CzGsh8/
         eAWpyge7LQPM3wc9BIpf48hE3w3ntiuJYP8o+NlrffMkjgATKu6vzgLElf+MFeYhsh
         rArozyONz5XD2mZS6cT1sUV2Cm/JhboBV2wn/3m4=
Received: from epsnrtp2.localdomain (unknown [182.195.42.163]) by
        epcas1p2.samsung.com (KnoxPortal) with ESMTP id
        20200518045822epcas1p210f4b5c58774a0d81bf33380b4a9e7fe~QBpRn_InW2079620796epcas1p2P;
        Mon, 18 May 2020 04:58:22 +0000 (GMT)
Received: from epsmges1p1.samsung.com (unknown [182.195.40.153]) by
        epsnrtp2.localdomain (Postfix) with ESMTP id 49QRbv2j2kzMqYkX; Mon, 18 May
        2020 04:58:19 +0000 (GMT)
Received: from epcas1p3.samsung.com ( [182.195.41.47]) by
        epsmges1p1.samsung.com (Symantec Messaging Gateway) with SMTP id
        23.9D.04402.BE512CE5; Mon, 18 May 2020 13:58:19 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas1p3.samsung.com (KnoxPortal) with ESMTPA id
        20200518045818epcas1p39ac7fcb92fd73391c1c3746c17e34b58~QBpN9eY0i3065630656epcas1p3x;
        Mon, 18 May 2020 04:58:18 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20200518045818epsmtrp1ba3d66b3ebbc2bea915377d691a1fd53~QBpN7x5dT1824518245epsmtrp13;
        Mon, 18 May 2020 04:58:18 +0000 (GMT)
X-AuditID: b6c32a35-753ff70000001132-eb-5ec215ebf79b
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        45.34.18461.AE512CE5; Mon, 18 May 2020 13:58:18 +0900 (KST)
Received: from [10.113.221.211] (unknown [10.113.221.211]) by
        epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20200518045818epsmtip132883eeffa5658720ed2b7a889712bea~QBpNpdb3G0973109731epsmtip1k;
        Mon, 18 May 2020 04:58:18 +0000 (GMT)
Subject: Re: [PATCH v2] drm/exynos: dsi: Remove bridge node reference in
 error handling path in probe function
To:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        jy0922.shim@samsung.com, sw0312.kim@samsung.com,
        kyungmin.park@samsung.com, airlied@linux.ie, daniel@ffwll.ch,
        kgene@kernel.org, krzk@kernel.org
Cc:     dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org
From:   Inki Dae <inki.dae@samsung.com>
Message-ID: <4555b0a8-b919-b5c1-cacb-1e6aec8a1aa8@samsung.com>
Date:   Mon, 18 May 2020 14:03:38 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
        Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20200516105736.269669-1-christophe.jaillet@wanadoo.fr>
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA01TfUgUaRzmnZmdHaXtplXrh0HpHAUapqOuTZfGcUUNfYBQXGXgNqyTK+7H
        MLMbeQRtdeeZ2tlixeppCVl4excrW9qHqGRRWaZGH9ZibbQSlZHZokVxHzsOcf73vM/z/N7n
        93s/KNw4RCZTZQ6XKDsEG0PGE53X0jIzxpP6irM855K4I4P9GNdxtVnH/dvpxbkHUxMk9+rZ
        PYLrCC3k6iLjODc01K7n7h58q+eCkUc67v6VJpLzDfVgnK/+Nfm9ge+ebiH4oP8wyV+cfq7j
        wzU3Mf58637+twt+xEeDi/jo04CukCoqz7eKQokop4gOi7OkzFFawGzcYl5jNuVlsRnsSm4F
        k+IQ7GIBs3ZTYca6MlusYyZlj2Bzx6hCQVGYzNX5stPtElOsTsVVwIhSiU1aKS1XBLvidpQu
        tzjt37FZWdmmmHFXubU6/Ide+idxb03nOOFB7+lqFEcBnQuVt1tRNYqnjPQlBF1tTbgqGOkP
        CEYez9WEaQS9wV91XysmPo9imtCNINx7TactJhC8H25AqiuBlqCr3zcjJNIDCAKtr2ZCcDqA
        oObWx5kQkl4C3rYwqWIDvRq6a/v1KiZi/MB0e6yAopLo7XBnStAs86C/YYxQ6Th6LZyIbFNp
        nF4AobFTmIYXw6GO33Gt0wcUfDptUe0Qs/sP8hqdAG9uXtBrOBle11Xq1c6APoTA67uDaYsq
        BE8jI4TmyoHeM/WYuhFOp0HgSqZGp8LlL81Iy50L76ZqdVqWAaoqjZqFgRv3HiMNAwy3ekkN
        8xC5fVJ/FKU2zhqscdY0jbOmafw/uAURfjRflBR7qaiwEjv7soNo5jGnmy6hY4Ob+hBNIWaO
        YbjoarFRJ+xRKux9CCicSTTsiPYUGw0lQsVPouw0y26bqPQhU+zYvXhyksUZ+xoOl5k1Zefk
        5HC5bJ6JZZkFhuMjtmIjXSq4xHJRlET5ax1GxSV70LK/j+1MH8119AQrF02u/2WfFyPSrQd2
        dG0efPlNW0fFyKexorpvb5nzcn88fTR0dv+pxZ4vLc8z/SfWp11+U783GzX8vPHDuoTDu0OS
        T3R2vrhYa7ellb/464emDQVPJgfCD+Wt/ubQ5lT3vvbJ6KOARx78c9XZqrbr+fHyUsvH0eh5
        hlCsApuOy4rwHy7gdrXiAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrIIsWRmVeSWpSXmKPExsWy7bCSnO4r0UNxBrPfGVv0njvJZLH14FxW
        i//bJjJbXPn6ns3ixb2LLBZbb0lb9D9+zWxx/vwGdouzTW/YLTY9vsZqcXnXHDaLGef3MVnM
        mPySzYHXY++3BSwem1Z1snls//aA1eN+93Emj81L6j36tqxi9Pi8Sc7j8931rAEcUVw2Kak5
        mWWpRfp2CVwZXfdXshf8E6no3vaapYHxg0AXIyeHhICJxPtfd5i6GLk4hAR2M0os2/aYsYuR
        AyghIbFlKweEKSxx+HAxRMlbRokp/xYzgfQKCxRI/F/7lhnEFhE4wygxdWMmSBGzwHpGiV1P
        n7JDdExnlNj6fCpYB5uAqsTEFffZQGxeATuJvT0n2UFsFqD4mW8bGEFsUYEIiefbbzBC1AhK
        nJz5hAXkCk4BF4lpj8NBwswC6hJ/5l1ihrDFJW49mc8EYctLNG+dzTyBUWgWku5ZSFpmIWmZ
        haRlASPLKkbJ1ILi3PTcYsMCw7zUcr3ixNzi0rx0veT83E2M4FjU0tzBuH3VB71DjEwcjIcY
        JTiYlUR4Iz/vixPiTUmsrEotyo8vKs1JLT7EKM3BoiTOe6NwYZyQQHpiSWp2ampBahFMlomD
        U6qByWTLEt21OScOXl33pjZsbWBl7eylVh8fOPwSq7zkFTJv54obH2f93pn5oirqSZXC/0/C
        aew56z31C/8Gphqs1+CXeRQWredXyqY7RyXl7/e0HuXlppKnt1/OOX/F0LlCTunBwYLW5Xzz
        /RcHJT7PrVmRf01HuuR68PrX33qiD4m9PPBRP31mgoqRpNfSPxJb32yfU7DA4IK32MS1xzaJ
        yQTk3WuKD+47ZLP5VNFrxh3fZJ/IsaUGZuXrb15v8c07//+drym7GQVnrMvff/ZBlsSc6VWT
        qlWmHf3y1aeA9YNf7dXPXlX3Tv/6e9fydt7vFQ/q0kIX5/FdTj669PnJDiVhnkcTtjVNOTHr
        nqnOqhQlluKMREMt5qLiRAAYCeXcNAMAAA==
X-CMS-MailID: 20200518045818epcas1p39ac7fcb92fd73391c1c3746c17e34b58
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20200516105750epcas1p2227417d4e2387a0f6aec4a96b1ba7ae4
References: <CGME20200516105750epcas1p2227417d4e2387a0f6aec4a96b1ba7ae4@epcas1p2.samsung.com>
        <20200516105736.269669-1-christophe.jaillet@wanadoo.fr>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



20. 5. 16. 오후 7:57에 Christophe JAILLET 이(가) 쓴 글:
> 'exynos_dsi_parse_dt()' takes a reference to 'dsi->in_bridge_node'.
> This must be released in the error handling path.

Picked it up.

Thanks,
Inki Dae

> 
> In order to do that, add an error handling path and move the
> 'exynos_dsi_parse_dt()' call from the beginning to the end of the probe
> function to ease the error handling path.
> This function only sets some variables which are used only in the
> 'transfer' function.
> 
> The call chain is:
>    .transfer
>     --> exynos_dsi_host_transfer
>       --> exynos_dsi_init
>         --> exynos_dsi_enable_clock  (use burst_clk_rate and esc_clk_rate)
>           --> exynos_dsi_set_pll     (use pll_clk_rate)
> 
> While at it, also handle cases where 'component_add()' fails.
> 
> This patch is similar to commit 70505c2ef94b ("drm/exynos: dsi: Remove bridge node reference in removal")
> which fixed the issue in the remove function.
> 
> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
> ---
> A Fixes tag could be required, but I've not been able to figure out which
> one to use.
> 
> v2: move around 'exynos_dsi_parse_dt' instead of adding many gotos
>     handle component_add failures
> ---
>  drivers/gpu/drm/exynos/exynos_drm_dsi.c | 20 +++++++++++++++-----
>  1 file changed, 15 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/gpu/drm/exynos/exynos_drm_dsi.c b/drivers/gpu/drm/exynos/exynos_drm_dsi.c
> index 902938d2568f..a9d24402fabf 100644
> --- a/drivers/gpu/drm/exynos/exynos_drm_dsi.c
> +++ b/drivers/gpu/drm/exynos/exynos_drm_dsi.c
> @@ -1759,10 +1759,6 @@ static int exynos_dsi_probe(struct platform_device *pdev)
>  	dsi->dev = dev;
>  	dsi->driver_data = of_device_get_match_data(dev);
>  
> -	ret = exynos_dsi_parse_dt(dsi);
> -	if (ret)
> -		return ret;
> -
>  	dsi->supplies[0].supply = "vddcore";
>  	dsi->supplies[1].supply = "vddio";
>  	ret = devm_regulator_bulk_get(dev, ARRAY_SIZE(dsi->supplies),
> @@ -1823,11 +1819,25 @@ static int exynos_dsi_probe(struct platform_device *pdev)
>  		return ret;
>  	}
>  
> +	ret = exynos_dsi_parse_dt(dsi);
> +	if (ret)
> +		return ret;
> +
>  	platform_set_drvdata(pdev, &dsi->encoder);
>  
>  	pm_runtime_enable(dev);
>  
> -	return component_add(dev, &exynos_dsi_component_ops);
> +	ret = component_add(dev, &exynos_dsi_component_ops);
> +	if (ret)
> +		goto err_disable_runtime;
> +
> +	return 0;
> +
> +err_disable_runtime:
> +	pm_runtime_disable(dev);
> +	of_node_put(dsi->in_bridge_node);
> +
> +	return ret;
>  }
>  
>  static int exynos_dsi_remove(struct platform_device *pdev)
> 
