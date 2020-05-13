Return-Path: <SRS0=g10L=63=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02A30C2D0F8
	for <linux-kernel@archiver.kernel.org>; Wed, 13 May 2020 01:40:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D113F206B7
	for <linux-kernel@archiver.kernel.org>; Wed, 13 May 2020 01:40:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="dLZDjCh1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731983AbgEMBkd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 May 2020 21:40:33 -0400
Received: from mailout2.samsung.com ([203.254.224.25]:36813 "EHLO
        mailout2.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731894AbgEMBkd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 May 2020 21:40:33 -0400
Received: from epcas1p3.samsung.com (unknown [182.195.41.47])
        by mailout2.samsung.com (KnoxPortal) with ESMTP id 20200513014029epoutp02fedd115c563a35702c92863076d9545f~OcuD0s4u10813408134epoutp02O
        for <linux-kernel@vger.kernel.org>; Wed, 13 May 2020 01:40:29 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20200513014029epoutp02fedd115c563a35702c92863076d9545f~OcuD0s4u10813408134epoutp02O
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1589334029;
        bh=khld6DxiKDVHnWg0T4dvVfR+FPu+GqRwwXzMI65JZ4g=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=dLZDjCh1jMLHkmBv8KOPCy9T2uPIJjMRsu35bjavHRGvzfk+NTguIHe1PM2rqoufv
         z5KvtAMVhKcTDYeaDFSUQry1CGI7TRwxMGbxMW8wCYxb8+tqyKq/oNbmQfVWHL0zrq
         SbIGQRQXHgoy/tdjW/qS0J7qLcLWtjPCrNAy4idY=
Received: from epsnrtp2.localdomain (unknown [182.195.42.163]) by
        epcas1p1.samsung.com (KnoxPortal) with ESMTP id
        20200513014027epcas1p16f2c0a059340e4b8128992f517414e9a~OcuB-e5Jj2277822778epcas1p1V;
        Wed, 13 May 2020 01:40:27 +0000 (GMT)
Received: from epsmges1p5.samsung.com (unknown [182.195.40.157]) by
        epsnrtp2.localdomain (Postfix) with ESMTP id 49MHRq31PnzMqYl1; Wed, 13 May
        2020 01:40:23 +0000 (GMT)
Received: from epcas1p3.samsung.com ( [182.195.41.47]) by
        epsmges1p5.samsung.com (Symantec Messaging Gateway) with SMTP id
        0E.89.04658.2005BBE5; Wed, 13 May 2020 10:40:18 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20200513014017epcas1p15eb1a5dafc3d09e8d7c87dce1e66ec68~Oct5D3g3K0201102011epcas1p1J;
        Wed, 13 May 2020 01:40:17 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20200513014017epsmtrp250b64ffbd7b8331e069bc0509db8fd57~Oct5CgUdx1543715437epsmtrp2X;
        Wed, 13 May 2020 01:40:17 +0000 (GMT)
X-AuditID: b6c32a39-a99ff70000001232-b1-5ebb50028228
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        D8.9C.18461.1005BBE5; Wed, 13 May 2020 10:40:17 +0900 (KST)
Received: from [10.113.221.211] (unknown [10.113.221.211]) by
        epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20200513014017epsmtip1dd56dc0bc6f2f812fc78772d8157bc08~Oct4xc0wA2184121841epsmtip1k;
        Wed, 13 May 2020 01:40:17 +0000 (GMT)
Subject: Re: [PATCH] drm/exynos: dsi: Remove bridge node reference in error
 handling path in probe function
To:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        jy0922.shim@samsung.com, sw0312.kim@samsung.com,
        kyungmin.park@samsung.com, airlied@linux.ie, daniel@ffwll.ch,
        kgene@kernel.org, krzk@kernel.org
Cc:     dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org
From:   Inki Dae <inki.dae@samsung.com>
Message-ID: <2fd735eb-842f-07ba-6635-a9a86f5a9704@samsung.com>
Date:   Wed, 13 May 2020 10:45:34 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
        Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20200510154833.238320-1-christophe.jaillet@wanadoo.fr>
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA01TfUwTZxzOe3e9Hsya85T5CzqFS0iUpcIBhUPFmNmY8yNZEzBTY6gXegFC
        v9YrKGaJoGwDFLUaYkHJMKnZJI5qAYU6XMaITlCwGwECClswzK9AWAPqFt16HGb89zy/PM/7
        Ps/7QeFMiIylCu1uyWUXrSwZTdz4eX2SHjPdyk0+dnYtX9N3D+PbfmrQ8P/e8OD8wOw0yT8d
        CxF828gq/vTEC5zv77+m5R8ce6nlAxODGv634EWS9/bfxnjvuWfkVp3QOddICIGmKlK4Ofe7
        Rhg/cRcTWnxHhVOtTUgIB9YI4cd+jYnaX7S5QBItkitOsuc5LIX2/Cx2V7Z5m9mQnszpuUw+
        g42zizYpizXuNum3F1ojidm4EtFaHBmZRFlmk7ZsdjmK3VJcgUN2Z7GS02J1Zjo3yKJNLrbn
        b8hz2DZyyckphojwYFHBH++akdO75nBNzwxRhr6GahRFAZ0GL8ev49UommLodgSTvreESv5C
        0HbzPK6oGHoOQXl36XvH6OTogqgTwdCFPzUqmUbw6FsvWY0oajltg9YGSpmvoO8j8PueIoXg
        tB/BiV9ezS9L0gng+W6cVLCO3gLTf4cxBROReZkvoFUWiqH3Qu+sqEqWwb26J4SCo2gjfFnX
        jRSM0yth5Mk3mIrXwvG2C/N9gH5IQU1wEKmxjVB3NUyoeDk8v9uqVXEshKc6SdVwHIHH24up
        pBLB44mhBUcq/Hj5HKYkwun14A8mqeN46PinYSHFUpiaPalRJEDroPIrRpWwcCc0vJAB4KHP
        Q6pYgCvDY8QZFF+/qFv9oj71i/rU/79xIyKa0IeSU7blSzLnNCy+7gCaf86Jme3oTt/uLkRT
        iF2i23s0mMtoxBK51NaFgMLZFbqKwo5cRmcRS49ILofZVWyV5C5kiJy8B4+NyXNEPofdbeYM
        KampqXwal27gOHalrnbImsvQ+aJbKpIkp+R678OoqNgytFX3caPltLCar0iJf8Dd/0TYuSyk
        H6sa6Pks/XBIG/N5F/d6JLifKTd+n5Fn/mCTrC9pas6ZuXQq+MWvOaNHpARmILq53JSxp+OH
        T2sPTJahhOzK9lt9mrSpixU9vd3GHVXw1njosi2UxOC2pfv8jeseZQVrKlZf+mimtsU59yaa
        JeQCkUvEXbL4H/VOilfkAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrIIsWRmVeSWpSXmKPExsWy7bCSnC5jwO44g5MPhS16z51ksth6cC6r
        xf9tE5ktrnx9z2bx4t5FFoutt6Qt+h+/ZrY4f34Du8XZpjfsFpseX2O1uLxrDpvFjPP7mCxm
        TH7J5sDrsffbAhaPTas62Ty2f3vA6nG/+ziTx+Yl9R59W1YxenzeJOfx+e561gCOKC6blNSc
        zLLUIn27BK6Mh//WMRbMkKvoPfWRpYGxXaKLkZNDQsBE4vaz2yxdjFwcQgK7GSU+n29m62Lk
        AEpISGzZygFhCkscPlwMUfKWUeLpslVMIHFhgVyJLXM5QMaICJxhlJi6MROkhllgPaPErqdP
        2SEapjNKnL3WzwJSxSagKjFxxX02EJtXwE7i/a/PTCA2C1C8YckmdhBbVCBC4vn2G4wQNYIS
        J2c+AevlFHCRaJ15BCzOLKAu8WfeJWYIW1zi1pP5TBC2vETz1tnMExiFZiFpn4WkZRaSlllI
        WhYwsqxilEwtKM5Nzy02LDDMSy3XK07MLS7NS9dLzs/dxAiORS3NHYzbV33QO8TIxMF4iFGC
        g1lJhLclc2ecEG9KYmVValF+fFFpTmrxIUZpDhYlcd4bhQvjhATSE0tSs1NTC1KLYLJMHJxS
        DUw7bm3xddy1KuoIh5/Y7t5/FrqHUoK8q2VYL9vJCstqXFy80PvHz2MLInjKHC8IMh+4t/Nj
        dcTuTbumBZ83nzPLvmD76YmOS1//kp9UfmGxxIcV78wam26uV91zTzD+79Z3YXdmxzz91rHj
        3bFXMrO7avZ/vmE9Z2OJZtOadLk1HTM7VokERi4R1KnxFJJ+93R1gl6vr9ibOhNfr1VSl+/s
        Sr4TMMfCKWUL/4OGXn3+aQJC3k2TpitNitvBsaXtDcfr/Xo62rVrSlJN5S8z/NQ6Olv3g5nz
        yug7a2QXHzZu/r+jROH9dbsNLgIHq17vuVCi1H5gt7DzbENGZ8/NG/8cPz+nyar7+rq4M5fW
        zC+qU2Ipzkg01GIuKk4EAA4Kjj40AwAA
X-CMS-MailID: 20200513014017epcas1p15eb1a5dafc3d09e8d7c87dce1e66ec68
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20200510154858epcas1p42c2585167b74f13b712676b7dfc09481
References: <CGME20200510154858epcas1p42c2585167b74f13b712676b7dfc09481@epcas1p4.samsung.com>
        <20200510154833.238320-1-christophe.jaillet@wanadoo.fr>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

20. 5. 11. 오전 12:48에 Christophe JAILLET 이(가) 쓴 글:
> 'exynos_dsi_parse_dt()' takes a reference to 'dsi->in_bridge_node'.
> This must be released in the error handling path.
> 
> This patch is similar to commit 70505c2ef94b ("drm/exynos: dsi: Remove bridge node reference in removal")
> which fixed the issue in the remove function.
> 
> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
> ---
> A Fixes tag could be required, but I've not been able to figure out which
> one to use.
> 
> I think that moving 'exynos_dsi_parse_dt()' in the probe could simplify
> the error handling in the probe function. However, I don't know this code
> well enough to play this game. So better safe than sorry.
> So I've kept the logic in place and added goto everywhere. :(

You could move exynos_dsi_parse_dt() call to the end of the probe function to handle the error simply.
dsi->in_bridge_node is accessed in bind function and the probe function is called before the bind call.

Could you rework and post it again?

Thanks,
Inki Dae

> ---
>  drivers/gpu/drm/exynos/exynos_drm_dsi.c | 28 ++++++++++++++++++-------
>  1 file changed, 20 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/gpu/drm/exynos/exynos_drm_dsi.c b/drivers/gpu/drm/exynos/exynos_drm_dsi.c
> index 902938d2568f..2aa74c3dc733 100644
> --- a/drivers/gpu/drm/exynos/exynos_drm_dsi.c
> +++ b/drivers/gpu/drm/exynos/exynos_drm_dsi.c
> @@ -1770,14 +1770,17 @@ static int exynos_dsi_probe(struct platform_device *pdev)
>  	if (ret) {
>  		if (ret != -EPROBE_DEFER)
>  			dev_info(dev, "failed to get regulators: %d\n", ret);
> -		return ret;
> +		goto err_put_in_bridge_node;
>  	}
>  
>  	dsi->clks = devm_kcalloc(dev,
>  			dsi->driver_data->num_clks, sizeof(*dsi->clks),
>  			GFP_KERNEL);
> -	if (!dsi->clks)
> -		return -ENOMEM;
> +	if (!dsi->clks) {
> +		ret = -ENOMEM;
> +		goto err_put_in_bridge_node;
> +	}
> +
>  
>  	for (i = 0; i < dsi->driver_data->num_clks; i++) {
>  		dsi->clks[i] = devm_clk_get(dev, clk_names[i]);
> @@ -1791,7 +1794,8 @@ static int exynos_dsi_probe(struct platform_device *pdev)
>  
>  			dev_info(dev, "failed to get the clock: %s\n",
>  					clk_names[i]);
> -			return PTR_ERR(dsi->clks[i]);
> +			ret = PTR_ERR(dsi->clks[i]);
> +			goto err_put_in_bridge_node;
>  		}
>  	}
>  
> @@ -1799,19 +1803,22 @@ static int exynos_dsi_probe(struct platform_device *pdev)
>  	dsi->reg_base = devm_ioremap_resource(dev, res);
>  	if (IS_ERR(dsi->reg_base)) {
>  		dev_err(dev, "failed to remap io region\n");
> -		return PTR_ERR(dsi->reg_base);
> +		ret = PTR_ERR(dsi->reg_base);
> +		goto err_put_in_bridge_node;
>  	}
>  
>  	dsi->phy = devm_phy_get(dev, "dsim");
>  	if (IS_ERR(dsi->phy)) {
>  		dev_info(dev, "failed to get dsim phy\n");
> -		return PTR_ERR(dsi->phy);
> +		ret = PTR_ERR(dsi->phy);
> +		goto err_put_in_bridge_node;
>  	}
>  
>  	dsi->irq = platform_get_irq(pdev, 0);
>  	if (dsi->irq < 0) {
>  		dev_err(dev, "failed to request dsi irq resource\n");
> -		return dsi->irq;
> +		ret = dsi->irq;
> +		goto err_put_in_bridge_node;
>  	}
>  
>  	irq_set_status_flags(dsi->irq, IRQ_NOAUTOEN);
> @@ -1820,7 +1827,7 @@ static int exynos_dsi_probe(struct platform_device *pdev)
>  					dev_name(dev), dsi);
>  	if (ret) {
>  		dev_err(dev, "failed to request dsi irq\n");
> -		return ret;
> +		goto err_put_in_bridge_node;
>  	}
>  
>  	platform_set_drvdata(pdev, &dsi->encoder);
> @@ -1828,6 +1835,11 @@ static int exynos_dsi_probe(struct platform_device *pdev)
>  	pm_runtime_enable(dev);
>  
>  	return component_add(dev, &exynos_dsi_component_ops);
> +
> +err_put_in_bridge_node:
> +	of_node_put(dsi->in_bridge_node);
> +
> +	return ret;
>  }
>  
>  static int exynos_dsi_remove(struct platform_device *pdev)
> 
