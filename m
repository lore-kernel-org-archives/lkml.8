Return-Path: <SRS0=dAmO=AZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 073BCC433E3
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jul 2020 00:21:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D40B92186A
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jul 2020 00:21:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="Y7ylizgD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726150AbgGNAV4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Jul 2020 20:21:56 -0400
Received: from mailout3.samsung.com ([203.254.224.33]:36863 "EHLO
        mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726364AbgGNAV4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jul 2020 20:21:56 -0400
Received: from epcas1p3.samsung.com (unknown [182.195.41.47])
        by mailout3.samsung.com (KnoxPortal) with ESMTP id 20200714002150epoutp033ff885326c598ed7821e7a9bf75055cf~hdpGYUmX52730127301epoutp03G
        for <linux-kernel@vger.kernel.org>; Tue, 14 Jul 2020 00:21:50 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20200714002150epoutp033ff885326c598ed7821e7a9bf75055cf~hdpGYUmX52730127301epoutp03G
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1594686110;
        bh=+mqRRzsx68sT5HNUBgxNUOcPMOMHNR+M/R+C4nGZ6Ho=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=Y7ylizgD6w+6oPihFFA/4D6IyUm3HeyfMcztSHk6IFr/yT/ryoUx7RI80yQ+lTV5v
         7CZqAF7DM9jF1NCw8Q9p6GhcP5aVgtXZKE5XXul83GYVO3Ks9vUrm+y+suuxNmxeaV
         ZEIx3y4nzQ22hLRiEX9GwomyTgcdljpBroCXeYSk=
Received: from epsnrtp3.localdomain (unknown [182.195.42.164]) by
        epcas1p2.samsung.com (KnoxPortal) with ESMTP id
        20200714002150epcas1p2dc932b7ae2e53320fed7fa32b14cb4a1~hdpFrGRFr2100721007epcas1p2n;
        Tue, 14 Jul 2020 00:21:50 +0000 (GMT)
Received: from epsmges1p3.samsung.com (unknown [182.195.40.155]) by
        epsnrtp3.localdomain (Postfix) with ESMTP id 4B5LmS2nRJzMqYkV; Tue, 14 Jul
        2020 00:21:44 +0000 (GMT)
Received: from epcas1p3.samsung.com ( [182.195.41.47]) by
        epsmges1p3.samsung.com (Symantec Messaging Gateway) with SMTP id
        8F.DF.29173.49AFC0F5; Tue, 14 Jul 2020 09:21:40 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas1p4.samsung.com (KnoxPortal) with ESMTPA id
        20200714002138epcas1p4e8c368ef787360733d5b129330a8dde4~hdo7DRUrM1996919969epcas1p46;
        Tue, 14 Jul 2020 00:21:38 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20200714002138epsmtrp14bdc94481119d14744d2b8ed49b61304~hdo7CT-tm2665626656epsmtrp1K;
        Tue, 14 Jul 2020 00:21:38 +0000 (GMT)
X-AuditID: b6c32a37-f5587a80000071f5-b9-5f0cfa949ccc
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        FE.DE.08382.29AFC0F5; Tue, 14 Jul 2020 09:21:38 +0900 (KST)
Received: from [10.113.221.211] (unknown [10.113.221.211]) by
        epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20200714002138epsmtip2e41830c74e5ea8f42d8189e90b25c568~hdo6zjyON2223922239epsmtip2r;
        Tue, 14 Jul 2020 00:21:38 +0000 (GMT)
Subject: Re: [PATCH v7 08/36] drm: exynos: fix common struct sg_table
 related issues
To:     Marek Szyprowski <m.szyprowski@samsung.com>,
        dri-devel@lists.freedesktop.org, iommu@lists.linux-foundation.org,
        linaro-mm-sig@lists.linaro.org, linux-kernel@vger.kernel.org
Cc:     Christoph Hellwig <hch@lst.de>,
        Robin Murphy <robin.murphy@arm.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        linux-arm-kernel@lists.infradead.org,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Seung-Woo Kim <sw0312.kim@samsung.com>,
        linux-samsung-soc@vger.kernel.org
From:   Inki Dae <inki.dae@samsung.com>
Message-ID: <c57efc3e-2229-44df-f7a1-d3dce31213a0@samsung.com>
Date:   Tue, 14 Jul 2020 09:27:34 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
        Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200619103636.11974-9-m.szyprowski@samsung.com>
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrNJsWRmVeSWpSXmKPExsWy7bCmvu7UXzzxBo+yLHrPnWSy2DhjPavF
        /20TmS2ufH3PZrFy9VEmiwX7rS2+XHnIZLHp8TVWi8u75rBZzDi/j8li7ZG77BYHPzxhtZgx
        +SWbA6/HmnlrGD32flvA4rH92wNWj/vdx5k8Ni+p97j97zGzx+Qbyxk9dt9sYPPo27KK0ePz
        JrkArqhsm4zUxJTUIoXUvOT8lMy8dFsl7+B453hTMwNDXUNLC3MlhbzE3FRbJRefAF23zByg
        05UUyhJzSoFCAYnFxUr6djZF+aUlqQoZ+cUltkqpBSk5BZYFesWJucWleel6yfm5VoYGBkam
        QIUJ2Rlrp2xmLvgqUjG1x6yBcaZgFyMnh4SAicSRhYdZuhi5OIQEdjBKzHzcC+V8YpQ4/OoR
        lPONUeLtmtWMXYwcYC2H290g4nsZJabuXcMM4bxnlDjwYhIzSJGwQJjE9f/yICtEBLYwSjRP
        BWtgFtjBJHHp+2YWkASbgKrExBX32UBsXgE7icfPzoPZLEDxHYcWMoPYogIREse7J7ND1AhK
        nJz5BKyXE6h+4/8tYPXMAuISt57MZ4Kw5SWat84GO0hC4AaHRPeTZawQV7tIHG12hvhZWOLV
        8S3sELaUxMv+NnaI+mZGiYkzTjNBOB2MEncfX2eBqDKW2L90MhPIIGYBTYn1u/QhwooSO3/P
        ZYRYzCfx7msP1C5eiY42IYgSJYljF28wQtgSEheWTGSDsD0k/h+cxj6BUXEWktdmIXlnFpJ3
        ZiEsXsDIsopRLLWgODc9tdiwwBg5sjcxglO1lvkOxmlvP+gdYmTiYDzEKMHBrCTCGy3KGS/E
        m5JYWZValB9fVJqTWnyI0RQY2BOZpUST84HZIq8k3tDUyNjY2MLE0MzU0FBJnPffWfZ4IYH0
        xJLU7NTUgtQimD4mDk6pBqajLIWPmufenrZQ+teXB4wS1zijT3QceeX106H5pZPumnq21JyL
        U6TUre+yf7l0dZLoYbs5W+f67mGpf+wcVSe3Ov/IFMs+4x2cB+v/Lm5mn2UgKbRr56l/D11m
        l6zw3C9U+DBrbQ3zmZrMWP9ptS8vnVu5fkNgX+hX79+n7eYmJUvzvKq8Vbbt2NkJZUXvVbtD
        jmr9zp298YKps5FUMEtO//7S/ylMMY4q+l9YM9usQncqKrT//uGe1qy0+3Ogp82HN9yGCWdE
        IxffcT/uMSPwfNQ63oyXvBcEPs4S/XXuV/HJP4HPmEQk34jO31Fo6M+y6DlXh2a1QoiZqKXg
        Qr+CT8yTzaxEVNpqf3G+7VBiKc5INNRiLipOBABh9b7/XgQAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrNIsWRmVeSWpSXmKPExsWy7bCSvO6kXzzxBmemy1n0njvJZLFxxnpW
        i//bJjJbXPn6ns1i5eqjTBYL9ltbfLnykMli0+NrrBaXd81hs5hxfh+Txdojd9ktDn54wmox
        Y/JLNgdejzXz1jB67P22gMVj+7cHrB73u48zeWxeUu9x+99jZo/JN5Yzeuy+2cDm0bdlFaPH
        501yAVxRXDYpqTmZZalF+nYJXBlrp2xmLvgqUjG1x6yBcaZgFyMHh4SAicThdrcuRi4OIYHd
        jBKbX59hhohLSGzZygFhCkscPlwMUfKWUWL/gx/sXYycHMICYRInOm6ygiREBLYwSjxbcZgR
        xGEW2MEksX3fPyaIlqOMEleWTWAGaWETUJWYuOI+G4jNK2An8fjZeTCbBSi+49BCsBpRgQiJ
        lvt/2CFqBCVOznzCAmJzAtVv/L8FrJ5ZQF3iz7xLzBC2uMStJ/OZIGx5ieats5knMArNQtI+
        C0nLLCQts5C0LGBkWcUomVpQnJueW2xYYJiXWq5XnJhbXJqXrpecn7uJERyfWpo7GLev+qB3
        iJGJg/EQowQHs5IIb7QoZ7wQb0piZVVqUX58UWlOavEhRmkOFiVx3huFC+OEBNITS1KzU1ML
        UotgskwcnFINTCUbVLOOnnvgvlDOXm3jDymeRh7t30oW08/zdRR/3vC9KqDzmJzJ745p4uIX
        uM/nnecI6DXsae+ZLqEg0ZzVlarLudPQ8axCYqzQncTHWfrb757+JZbFsfdHX87JxXGbNnYo
        fnNgZa2v9lDm0Wm6UsoVu+3l01L/c8f6XykVJ4ictebZ9vDoLmGXo6V/n/gyTqwoqZrtdfHP
        3LteCz0kVLyjmkwlRWb+mmRZ7zyjks+vZPbkiPvNa5/cmWbeLiN/c/uVqW4uq3e0dVucseDp
        5miIr3eSqUqNDuYTCl925OmD1R9aozetu6BT87lhneKU7cwNFvandkYc/Gsdtn7z0o/H1E9P
        OpEhWPx6efVPJZbijERDLeai4kQAxeoWsD4DAAA=
X-CMS-MailID: 20200714002138epcas1p4e8c368ef787360733d5b129330a8dde4
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20200619103658eucas1p1c3236e2de2798c2d8c02279a9263e9a9
References: <20200619103636.11974-1-m.szyprowski@samsung.com>
        <CGME20200619103658eucas1p1c3236e2de2798c2d8c02279a9263e9a9@eucas1p1.samsung.com>
        <20200619103636.11974-9-m.szyprowski@samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



20. 6. 19. 오후 7:36에 Marek Szyprowski 이(가) 쓴 글:
> The Documentation/DMA-API-HOWTO.txt states that the dma_map_sg() function
> returns the number of the created entries in the DMA address space.
> However the subsequent calls to the dma_sync_sg_for_{device,cpu}() and
> dma_unmap_sg must be called with the original number of the entries
> passed to the dma_map_sg().
> 
> struct sg_table is a common structure used for describing a non-contiguous
> memory buffer, used commonly in the DRM and graphics subsystems. It
> consists of a scatterlist with memory pages and DMA addresses (sgl entry),
> as well as the number of scatterlist entries: CPU pages (orig_nents entry)
> and DMA mapped pages (nents entry).
> 
> It turned out that it was a common mistake to misuse nents and orig_nents
> entries, calling DMA-mapping functions with a wrong number of entries or
> ignoring the number of mapped entries returned by the dma_map_sg()
> function.
> 
> To avoid such issues, lets use a common dma-mapping wrappers operating
> directly on the struct sg_table objects and use scatterlist page
> iterators where possible. This, almost always, hides references to the
> nents and orig_nents entries, making the code robust, easier to follow
> and copy/paste safe.
> 
> Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>

Acked-by : Inki Dae <inki.dae@samsung.com>

Thanks,
Inki Dae

> ---
>  drivers/gpu/drm/exynos/exynos_drm_g2d.c | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/gpu/drm/exynos/exynos_drm_g2d.c b/drivers/gpu/drm/exynos/exynos_drm_g2d.c
> index fcee33a43aca..7014a8cd971a 100644
> --- a/drivers/gpu/drm/exynos/exynos_drm_g2d.c
> +++ b/drivers/gpu/drm/exynos/exynos_drm_g2d.c
> @@ -395,8 +395,8 @@ static void g2d_userptr_put_dma_addr(struct g2d_data *g2d,
>  		return;
>  
>  out:
> -	dma_unmap_sg(to_dma_dev(g2d->drm_dev), g2d_userptr->sgt->sgl,
> -			g2d_userptr->sgt->nents, DMA_BIDIRECTIONAL);
> +	dma_unmap_sgtable(to_dma_dev(g2d->drm_dev), g2d_userptr->sgt,
> +			  DMA_BIDIRECTIONAL, 0);
>  
>  	pages = frame_vector_pages(g2d_userptr->vec);
>  	if (!IS_ERR(pages)) {
> @@ -511,10 +511,10 @@ static dma_addr_t *g2d_userptr_get_dma_addr(struct g2d_data *g2d,
>  
>  	g2d_userptr->sgt = sgt;
>  
> -	if (!dma_map_sg(to_dma_dev(g2d->drm_dev), sgt->sgl, sgt->nents,
> -				DMA_BIDIRECTIONAL)) {
> +	ret = dma_map_sgtable(to_dma_dev(g2d->drm_dev), sgt,
> +			      DMA_BIDIRECTIONAL, 0);
> +	if (ret) {
>  		DRM_DEV_ERROR(g2d->dev, "failed to map sgt with dma region.\n");
> -		ret = -ENOMEM;
>  		goto err_sg_free_table;
>  	}
>  
> 
