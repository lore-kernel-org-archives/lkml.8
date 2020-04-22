Return-Path: <SRS0=eifh=6G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF909C55181
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Apr 2020 03:33:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8931920575
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Apr 2020 03:33:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="M81xgS/H"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726431AbgDVDdb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Apr 2020 23:33:31 -0400
Received: from mailout3.samsung.com ([203.254.224.33]:62690 "EHLO
        mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726324AbgDVDda (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Apr 2020 23:33:30 -0400
Received: from epcas1p1.samsung.com (unknown [182.195.41.45])
        by mailout3.samsung.com (KnoxPortal) with ESMTP id 20200422033327epoutp03a94b406cf23166739f2308a9651a9898~IBttcg0Ux0765307653epoutp03R
        for <linux-kernel@vger.kernel.org>; Wed, 22 Apr 2020 03:33:27 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20200422033327epoutp03a94b406cf23166739f2308a9651a9898~IBttcg0Ux0765307653epoutp03R
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1587526407;
        bh=rHRFhOm3d5X3uCzrv6JCkr/Ga5lu4G0lQQo0a8i9lGI=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=M81xgS/HNgOmemFKY2ZaGxzmRXpYDVCxjf63pnw2CJEN2qzFlZvbpTd3oviGy8AKX
         c/b+eJ6PW/LntiNaAUGVPWp4uSfQN0fTjL5v5QtujzJ1erZg2qKK4gV9AVQrOSIQeb
         pOYvYO1GZuC1HXN5cbjPHZJe+nkWeePp7CzqiHmw=
Received: from epsnrtp4.localdomain (unknown [182.195.42.165]) by
        epcas1p3.samsung.com (KnoxPortal) with ESMTP id
        20200422033326epcas1p3445abb3dc8e8ea5ea94bdd7414615af1~IBtsd99P20666006660epcas1p38;
        Wed, 22 Apr 2020 03:33:26 +0000 (GMT)
Received: from epsmges1p4.samsung.com (unknown [182.195.40.153]) by
        epsnrtp4.localdomain (Postfix) with ESMTP id 496Qxw042jzMqYkZ; Wed, 22 Apr
        2020 03:33:24 +0000 (GMT)
Received: from epcas1p1.samsung.com ( [182.195.41.45]) by
        epsmges1p4.samsung.com (Symantec Messaging Gateway) with SMTP id
        E1.AC.04744.30BBF9E5; Wed, 22 Apr 2020 12:33:23 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20200422033323epcas1p173c1775e4f262ad67fd6cf5b3c03e48d~IBtpafPcC3085130851epcas1p12;
        Wed, 22 Apr 2020 03:33:23 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20200422033323epsmtrp2871297e58febd5706787c9a36d57c39e~IBtpZmnzm1058110581epsmtrp2k;
        Wed, 22 Apr 2020 03:33:23 +0000 (GMT)
X-AuditID: b6c32a38-26bff70000001288-08-5e9fbb03869c
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        FA.90.04024.30BBF9E5; Wed, 22 Apr 2020 12:33:23 +0900 (KST)
Received: from [10.113.221.211] (unknown [10.113.221.211]) by
        epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20200422033323epsmtip20a692321730c3e5cfb52e70ae63cba61~IBtpL78Lg2768627686epsmtip2O;
        Wed, 22 Apr 2020 03:33:23 +0000 (GMT)
Subject: Re: [PATCH] drm/exynos: Delete an error message in three functions
To:     Markus Elfring <Markus.Elfring@web.de>,
        dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>,
        Joonyoung Shim <jy0922.shim@samsung.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Kukjin Kim <kgene@kernel.org>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Seung-Woo Kim <sw0312.kim@samsung.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        kernel-janitors@vger.kernel.org,
        Tang Bin <tangbin@cmss.chinamobile.com>
From:   Inki Dae <inki.dae@samsung.com>
Message-ID: <a088b8e7-869b-8f8f-b9a1-9b68de7b714c@samsung.com>
Date:   Wed, 22 Apr 2020 12:38:24 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
        Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <57b725ed-f705-b5e1-0da6-3d16801c7c85@web.de>
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrFJsWRmVeSWpSXmKPExsWy7bCmri7z7vlxBiufWFn0njvJZPF/20Rm
        iytf37NZvLh3kcVi6y1pi/7Hr5ktzp/fwG5xtukNu8Wmx9dYLS7vmsNmMeP8PqCGWc9ZLWZM
        fslm8fF/M7MDn8f56b1sHnu/LWDx2LSqk81j+7cHrB73u48zeWxeUu/Rt2UVo8fnTXIet59t
        YwngjMq2yUhNTEktUkjNS85PycxLt1XyDo53jjc1MzDUNbS0MFdSyEvMTbVVcvEJ0HXLzAG6
        XUmhLDGnFCgUkFhcrKRvZ1OUX1qSqpCRX1xiq5RakJJTYFmgV5yYW1yal66XnJ9rZWhgYGQK
        VJiQnbHu/HTWgjsiFWvf5TYwNgp2MXJySAiYSDy79p21i5GLQ0hgB6PEmtmT2CCcT4wSCw7+
        ZodwvjFKPNx1jA2mpamrBaplL6PE3GlTWUASQgLvGSWOH6oGsYUFvCWmr5kE1i0isJhZYtG2
        vYwgCWaBYoneo0tYQWw2AVWJiSvug03lFbCT+NS7iB3EZgGKXzw8DSjOwSEqECFx+msiRImg
        xMmZT8B2cQpYScycvJgNYqS4xK0n85kgbHmJ5q2zmUH2SgisY5c4cfULI8TVLhK9C7ewQtjC
        Eq+Ob2GHsKUkPr/bywbR0MwoMXHGaSYIp4NR4u7j6ywQVcYS+5dOZgK5iFlAU2L9Ln2IsKLE
        zt9zoR7jk3j3tYcVpERCgFeio00IokRJ4tjFG1A3SEhcWDIRGooeEqsv7mGawKg4C8lvs5D8
        MwvJP7MQFi9gZFnFKJZaUJybnlpsWGCCHNubGMHpWstiB+Oecz6HGAU4GJV4eG+cnxcnxJpY
        VlyZe4hRgoNZSYR3w0OgEG9KYmVValF+fFFpTmrxIUZTYMhPZJYSTc4H5pK8knhDUyNjY2ML
        E0MzU0NDJXHeqddz4oQE0hNLUrNTUwtSi2D6mDg4pRoYm35a2nlOX2d4b3XLglmXJc+XFZmE
        PJ16aotNdoXlkZ+Od0s2tCl/uL4qZRbr7wDbG0tbtq15ITOVTdN/esVck0DBkK+H3Lpb93jH
        eXmdOmOgsqXg+mmhMrt3K+P2W3Bfnrjv0Q7f0Ltf9C6xm06dks9gNvP5078rq1v6py1aZM52
        5cv2R/p33yqxFGckGmoxFxUnAgDVZBnj7QMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrBIsWRmVeSWpSXmKPExsWy7bCSvC7z7vlxBrcuylj0njvJZPF/20Rm
        iytf37NZvLh3kcVi6y1pi/7Hr5ktzp/fwG5xtukNu8Wmx9dYLS7vmsNmMeP8PqCGWc9ZLWZM
        fslm8fF/M7MDn8f56b1sHnu/LWDx2LSqk81j+7cHrB73u48zeWxeUu/Rt2UVo8fnTXIet59t
        YwngjOKySUnNySxLLdK3S+DKWHd+OmvBHZGKte9yGxgbBbsYOTkkBEwkmrpaWLsYuTiEBHYz
        Shx59oOxi5EDKCEhsWUrB4QpLHH4cDFEyVtGib39rawgvcIC3hLT10xiB0mICCxllph8+B07
        SIJZoFhi24c17BAdvYwSR4/vZwJJsAmoSkxccZ8NxOYVsJP41LsIrIEFKH7x8DSwuKhAhMTz
        7TcYIWoEJU7OfMICYnMKWEnMnLyYDWKBusSfeZeYIWxxiVtP5jNB2PISzVtnM09gFJqFpH0W
        kpZZSFpmIWlZwMiyilEytaA4Nz232LDAMC+1XK84Mbe4NC9dLzk/dxMjOD61NHcwXl4Sf4hR
        gINRiYf3xvl5cUKsiWXFlbmHGCU4mJVEeDc8BArxpiRWVqUW5ccXleakFh9ilOZgURLnfZp3
        LFJIID2xJDU7NbUgtQgmy8TBKdXAuOxgZ6v0sZ1rZI+X7Mo5fi7uZd2DKc9TllrwlWRGiZz+
        dO9hatZP3dqVU7um5DQvXbbbI/nGGgEzjnVXC/wsSjo39ifKtzn5bNl019SwVzd5d+X/fyHW
        n20dpI22r5yh9kx7qkn7DbfNzsVhIcbCyn79M+apCK3bu/HBwqm7fv1YeOPY9pdC35VYijMS
        DbWYi4oTAd2g5qjLAgAA
X-CMS-MailID: 20200422033323epcas1p173c1775e4f262ad67fd6cf5b3c03e48d
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20200405121842epcas1p4c947a40c70881e72c38d6c9cc75c60d5
References: <CGME20200405121842epcas1p4c947a40c70881e72c38d6c9cc75c60d5@epcas1p4.samsung.com>
        <57b725ed-f705-b5e1-0da6-3d16801c7c85@web.de>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Markus Elfring,

20. 4. 5. 오후 9:18에 Markus Elfring 이(가) 쓴 글:
> From: Markus Elfring <elfring@users.sourceforge.net>
> Date: Sun, 5 Apr 2020 14:10:09 +0200
> 
> The function “platform_get_irq” can log an error already.
> Thus omit redundant messages for the exception handling in the
> calling functions.
> 
> This issue was detected by using the Coccinelle software.

Picked it up.

Thanks,
Inki Dae.

> 
> Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
> ---
>  drivers/gpu/drm/exynos/exynos_drm_dsi.c     | 4 +---
>  drivers/gpu/drm/exynos/exynos_drm_rotator.c | 4 +---
>  drivers/gpu/drm/exynos/exynos_drm_scaler.c  | 4 +---
>  3 files changed, 3 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/gpu/drm/exynos/exynos_drm_dsi.c b/drivers/gpu/drm/exynos/exynos_drm_dsi.c
> index e080aa92338c..a00c6dd16c8a 100644
> --- a/drivers/gpu/drm/exynos/exynos_drm_dsi.c
> +++ b/drivers/gpu/drm/exynos/exynos_drm_dsi.c
> @@ -1813,10 +1813,8 @@ static int exynos_dsi_probe(struct platform_device *pdev)
>  	}
> 
>  	dsi->irq = platform_get_irq(pdev, 0);
> -	if (dsi->irq < 0) {
> -		dev_err(dev, "failed to request dsi irq resource\n");
> +	if (dsi->irq < 0)
>  		return dsi->irq;
> -	}
> 
>  	irq_set_status_flags(dsi->irq, IRQ_NOAUTOEN);
>  	ret = devm_request_threaded_irq(dev, dsi->irq, NULL,
> diff --git a/drivers/gpu/drm/exynos/exynos_drm_rotator.c b/drivers/gpu/drm/exynos/exynos_drm_rotator.c
> index dafa87b82052..2d94afba031e 100644
> --- a/drivers/gpu/drm/exynos/exynos_drm_rotator.c
> +++ b/drivers/gpu/drm/exynos/exynos_drm_rotator.c
> @@ -293,10 +293,8 @@ static int rotator_probe(struct platform_device *pdev)
>  		return PTR_ERR(rot->regs);
> 
>  	irq = platform_get_irq(pdev, 0);
> -	if (irq < 0) {
> -		dev_err(dev, "failed to get irq\n");
> +	if (irq < 0)
>  		return irq;
> -	}
> 
>  	ret = devm_request_irq(dev, irq, rotator_irq_handler, 0, dev_name(dev),
>  			       rot);
> diff --git a/drivers/gpu/drm/exynos/exynos_drm_scaler.c b/drivers/gpu/drm/exynos/exynos_drm_scaler.c
> index 93c43c8d914e..ce1857138f89 100644
> --- a/drivers/gpu/drm/exynos/exynos_drm_scaler.c
> +++ b/drivers/gpu/drm/exynos/exynos_drm_scaler.c
> @@ -502,10 +502,8 @@ static int scaler_probe(struct platform_device *pdev)
>  		return PTR_ERR(scaler->regs);
> 
>  	irq = platform_get_irq(pdev, 0);
> -	if (irq < 0) {
> -		dev_err(dev, "failed to get irq\n");
> +	if (irq < 0)
>  		return irq;
> -	}
> 
>  	ret = devm_request_threaded_irq(dev, irq, NULL,	scaler_irq_handler,
>  					IRQF_ONESHOT, "drm_scaler", scaler);
> --
> 2.26.0
> 
> 
> 
