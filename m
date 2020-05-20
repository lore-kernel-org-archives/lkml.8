Return-Path: <SRS0=sqqi=7C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5E28C433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 20 May 2020 05:33:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7D768206C3
	for <linux-kernel@archiver.kernel.org>; Wed, 20 May 2020 05:33:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="R7UwtBOL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726829AbgETFdG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 May 2020 01:33:06 -0400
Received: from mailout1.samsung.com ([203.254.224.24]:35605 "EHLO
        mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726439AbgETFdG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 May 2020 01:33:06 -0400
Received: from epcas1p4.samsung.com (unknown [182.195.41.48])
        by mailout1.samsung.com (KnoxPortal) with ESMTP id 20200520053303epoutp0138ba0f958432ca68d86e0b93009d7904~QpaHmJIro2406824068epoutp01B
        for <linux-kernel@vger.kernel.org>; Wed, 20 May 2020 05:33:03 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20200520053303epoutp0138ba0f958432ca68d86e0b93009d7904~QpaHmJIro2406824068epoutp01B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1589952783;
        bh=C6AurNYTbyjZQ7T4M/l1gdlhyEAt+u9mfH4DDB785aE=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=R7UwtBOLlFhsue8KW3W1ICeuQK3ekWrmxMpHksRwgNi87kmIMGOlDLLBOQEi88ODd
         vDZ7a67Bj7ExaMK65tn1hGcogqnfTmAHFKsbFSnE+hrKlBk3U6/JLcmDsgzKtYPCZN
         xX0aO8ZTVBghv8JPIRFuGStj81oByElikpSYATFs=
Received: from epsnrtp4.localdomain (unknown [182.195.42.165]) by
        epcas1p2.samsung.com (KnoxPortal) with ESMTP id
        20200520053302epcas1p2b87745894423cce46640ae01c47407b4~QpaGiX5NB2310723107epcas1p2I;
        Wed, 20 May 2020 05:33:02 +0000 (GMT)
Received: from epsmges1p3.samsung.com (unknown [182.195.40.152]) by
        epsnrtp4.localdomain (Postfix) with ESMTP id 49RhGz3PSrzMqYkl; Wed, 20 May
        2020 05:32:59 +0000 (GMT)
Received: from epcas1p1.samsung.com ( [182.195.41.45]) by
        epsmges1p3.samsung.com (Symantec Messaging Gateway) with SMTP id
        F1.E9.04648.801C4CE5; Wed, 20 May 2020 14:32:56 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20200520053255epcas1p10e6fb129b98c5a2627e0387033025be5~QpaAyzNlM1276212762epcas1p1P;
        Wed, 20 May 2020 05:32:55 +0000 (GMT)
Received: from epsmgms1p2.samsung.com (unknown [182.195.42.42]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20200520053255epsmtrp1c0f6234ee815c486e6cf8bec572fa4e3~QpaAx-cLc2704527045epsmtrp1N;
        Wed, 20 May 2020 05:32:55 +0000 (GMT)
X-AuditID: b6c32a37-1f3ff70000001228-97-5ec4c108b7a8
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        A4.D4.25866.701C4CE5; Wed, 20 May 2020 14:32:55 +0900 (KST)
Received: from [10.113.221.211] (unknown [10.113.221.211]) by
        epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20200520053255epsmtip21e4b5ba59df548e58e79e419319e67c4~QpaAcQh_90205302053epsmtip2k;
        Wed, 20 May 2020 05:32:55 +0000 (GMT)
Subject: Re: [PATCH v2] drm/exynos: Remove dev_err() on platform_get_irq()
 failure
To:     Tamseel Shams <m.shams@samsung.com>, jy0922.shim@samsung.com,
        sw0312.kim@samsung.com, kyungmin.park@samsung.com,
        airlied@linux.ie, daniel@ffwll.ch
Cc:     dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org,
        shaik.ameer@samsung.com, krzk@kernel.org, alim.akhtar@samsung.com
From:   Inki Dae <inki.dae@samsung.com>
Message-ID: <fa372f07-abba-a296-c315-e9769fb43623@samsung.com>
Date:   Wed, 20 May 2020 14:38:16 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
        Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20200519104904.59246-1-m.shams@samsung.com>
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrNJsWRmVeSWpSXmKPExsWy7bCmri7HwSNxBm0PxSx6z51ksngwbxub
        xf9tE5ktrnx9z2bx4t5FFovz5zewW5xtesNusenxNVaLy7vmsFnMOL+PyeJu62J2iyMPd7Nb
        zJj8ks2B12PvtwUsHptWdbJ5bP/2gNXjfvdxJo/NS+o9+rasYvT4vEkugD0q2yYjNTEltUgh
        NS85PyUzL91WyTs43jne1MzAUNfQ0sJcSSEvMTfVVsnFJ0DXLTMH6FolhbLEnFKgUEBicbGS
        vp1NUX5pSapCRn5xia1SakFKToFlgV5xYm5xaV66XnJ+rpWhgYGRKVBhQnbG/glKBUekKq7e
        3sHewPhXtIuRk0NCwESic8Yqxi5GLg4hgR2MEnNenGeCcD4xSlw/28gGUiUk8JlRon2pbRcj
        B1jHzKkJEDW7GCVe7ZzECuG8Z5S4tPkIE0iDsECIxOS7G8DGigjMYpRY/KyZBSTBLHCRUaJ7
        RRCIzSagKjFxxX2wDbwCdhI7ru1hBbFZgOKdbXdZQbaJCkRInP6aCFEiKHFy5hOwMZwClhIf
        +9azQowUl7j1ZD4ThC0v0bx1NjPIXgmBIxwSHU8uMEL86SKxY+s0NghbWOLV8S3sELaUxMv+
        NnaIhmZGiYkzTjNBOB2MEncfX2eBqDKW2L90MhPIRcwCmhLrd+lDhBUldv6eywixmU/i3dce
        VkgQ8Up0tAlBlChJHLt4A+oGCYkLSyZC3eAh8fX2MrYJjIqzkPw2C8k/s5D8Mwth8QJGllWM
        YqkFxbnpqcWGBcbIkb2JEZyQtcx3MG4453OIUYCDUYmH98bOw3FCrIllxZW5hxglOJiVRHgn
        vDgUJ8SbklhZlVqUH19UmpNafIjRFBjyE5mlRJPzgdkiryTe0NTI2NjYwsTQzNTQUEmcd+r1
        nDghgfTEktTs1NSC1CKYPiYOTqkGRg3r6ka9Zf0eGW1NHd+vz4/okm11v7xA6VtNa2SclOj1
        eyaGHZsPvqnk3bd+QvjXr69eZxr37Txnxf/4kNKj6bN6fs079zzBRSqPjTU0pp/1p8jO7UfS
        QhMeJHY7nPm26PvW2z8mtLWmr5u1S+HG4iYG5yn3rRWit16d9852BgdzcMrSji0LY5RYijMS
        DbWYi4oTAZqnRKHeAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprNIsWRmVeSWpSXmKPExsWy7bCSvC77wSNxBgvOGlr0njvJZPFg3jY2
        i//bJjJbXPn6ns3ixb2LLBbnz29gtzjb9IbdYtPja6wWl3fNYbOYcX4fk8Xd1sXsFkce7ma3
        mDH5JZsDr8febwtYPDat6mTz2P7tAavH/e7jTB6bl9R79G1ZxejxeZNcAHsUl01Kak5mWWqR
        vl0CV8b+CUoFR6Qqrt7ewd7A+Fe0i5GDQ0LARGLm1IQuRi4OIYEdjBIL3v5hg4hLSGzZygFh
        CkscPlwMUfKWUWLm67MsXYycHMICIRKT725gBLFFBGYxSrR9rAaxmQUuMkps3Z8H0dDDKPF6
        +yomkASbgKrExBX32UBsXgE7iR3X9rCC2CxA8c62u2C2qECExPPtNxghagQlTs58AraMU8BS
        4mPfelaIBeoSf+ZdYoawxSVuPZnPBGHLSzRvnc08gVFoFpL2WUhaZiFpmYWkZQEjyypGydSC
        4tz03GLDAqO81HK94sTc4tK8dL3k/NxNjOD409Lawbhn1Qe9Q4xMHIyHGCU4mJVEeCe8OBQn
        xJuSWFmVWpQfX1Sak1p8iFGag0VJnPfrrIVxQgLpiSWp2ampBalFMFkmDk6pBiaHXNZY8eWK
        Pw21pZIydu1zzK9ad3vf6gXl5efU2AyDrxufCL5R3ixnvnFa9fYXJtsfvlx543jU2tV5YjO4
        j9yqDsgvvW3lMv8368WZrx0+H1V3OPpz0ymjqynbsm8f15eT378udf4j0/R7WpdjG0Om7X78
        2sFzfeINNxsuVul/dVePOtpYul1wn/d+b911vlUXf4Ww/nsl8cOlt503wGz36b0H5q9ULTZP
        90x1sXyl2v2iac2laRlbJwhvTf4ru3L3UsXaOefSr/DnX+s6bHegMPRf2yzel3Fs6ToZLhde
        +HyzOi+Z7frb/vPy0M+vy8+FRrnMWKq+RP773neL3NOWr1f5sm7tad1W9kffPLe3KbEUZyQa
        ajEXFScCAECGCTcuAwAA
X-CMS-MailID: 20200520053255epcas1p10e6fb129b98c5a2627e0387033025be5
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20200519110323epcas5p23b9472d505f5ba58d033fa468cb9969d
References: <CGME20200519110323epcas5p23b9472d505f5ba58d033fa468cb9969d@epcas5p2.samsung.com>
        <20200519104904.59246-1-m.shams@samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Tamseel,

Same patch[1] has been merged. So could you re-post this patch after rebasing it on top of exynos-drm-next branch?
After rebase, only g2d part would be valid.

Thanks,
Inki Dae

[1] https://git.kernel.org/pub/scm/linux/kernel/git/daeinki/drm-exynos.git/commit/?h=exynos-drm-next&id=fdd79b0db1899f915f489e744a06846284fa3f1e

20. 5. 19. 오후 7:49에 Tamseel Shams 이(가) 쓴 글:
> platform_get_irq() will call dev_err() itself on failure,
> so there is no need for the driver to also do this.
> This is detected by coccinelle.
> 
> Also removing unnecessary curly braces around if () statement.
> 
> Signed-off-by: Tamseel Shams <m.shams@samsung.com>
> ---
> Fixed review comment by joe@perches.com
> 
>  drivers/gpu/drm/exynos/exynos_drm_dsi.c     | 4 +---
>  drivers/gpu/drm/exynos/exynos_drm_g2d.c     | 1 -
>  drivers/gpu/drm/exynos/exynos_drm_rotator.c | 4 +---
>  drivers/gpu/drm/exynos/exynos_drm_scaler.c  | 4 +---
>  4 files changed, 3 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/gpu/drm/exynos/exynos_drm_dsi.c b/drivers/gpu/drm/exynos/exynos_drm_dsi.c
> index 902938d2568f..958e2c6a6702 100644
> --- a/drivers/gpu/drm/exynos/exynos_drm_dsi.c
> +++ b/drivers/gpu/drm/exynos/exynos_drm_dsi.c
> @@ -1809,10 +1809,8 @@ static int exynos_dsi_probe(struct platform_device *pdev)
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
> diff --git a/drivers/gpu/drm/exynos/exynos_drm_g2d.c b/drivers/gpu/drm/exynos/exynos_drm_g2d.c
> index fcee33a43aca..03be31427181 100644
> --- a/drivers/gpu/drm/exynos/exynos_drm_g2d.c
> +++ b/drivers/gpu/drm/exynos/exynos_drm_g2d.c
> @@ -1498,7 +1498,6 @@ static int g2d_probe(struct platform_device *pdev)
>  
>  	g2d->irq = platform_get_irq(pdev, 0);
>  	if (g2d->irq < 0) {
> -		dev_err(dev, "failed to get irq\n");
>  		ret = g2d->irq;
>  		goto err_put_clk;
>  	}
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
> 
