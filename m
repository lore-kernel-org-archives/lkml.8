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
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5FD9C433E6
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jul 2020 00:22:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8D86C21582
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jul 2020 00:22:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="S1Oj3K94"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726803AbgGNAWS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Jul 2020 20:22:18 -0400
Received: from mailout4.samsung.com ([203.254.224.34]:34860 "EHLO
        mailout4.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726742AbgGNAWR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jul 2020 20:22:17 -0400
Received: from epcas1p2.samsung.com (unknown [182.195.41.46])
        by mailout4.samsung.com (KnoxPortal) with ESMTP id 20200714002214epoutp044afc549dbe6faa7e020b773867193353~hdpcsEpB52684826848epoutp045
        for <linux-kernel@vger.kernel.org>; Tue, 14 Jul 2020 00:22:14 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20200714002214epoutp044afc549dbe6faa7e020b773867193353~hdpcsEpB52684826848epoutp045
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1594686134;
        bh=AgsE0+XswZ7hYE3JDCUW8hh6WbLrJaftKzeFkqjIQNc=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=S1Oj3K94TJrnETjy52/DjVbt7LfqpNgWVRxb0grCGRIDPHdMgA1Csu5RNNmUJoiRq
         U3Bxn5PMP5MlIJJe/ETRUf/60smNPGqV3F6CldFttPOM9SF8vR9bqpG72s6Ngzm7P8
         bnXP89jtuPtgYq9g0aYAGOQwBaEgDi3wfNHmLw1M=
Received: from epsnrtp3.localdomain (unknown [182.195.42.164]) by
        epcas1p3.samsung.com (KnoxPortal) with ESMTP id
        20200714002212epcas1p35e688c85a1bc2e40955499da2ad93762~hdpa_V2Q20085300853epcas1p3M;
        Tue, 14 Jul 2020 00:22:12 +0000 (GMT)
Received: from epsmges1p3.samsung.com (unknown [182.195.40.155]) by
        epsnrtp3.localdomain (Postfix) with ESMTP id 4B5Lmt1FkXzMqYks; Tue, 14 Jul
        2020 00:22:06 +0000 (GMT)
Received: from epcas1p1.samsung.com ( [182.195.41.45]) by
        epsmges1p3.samsung.com (Symantec Messaging Gateway) with SMTP id
        53.20.29173.DAAFC0F5; Tue, 14 Jul 2020 09:22:06 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas1p4.samsung.com (KnoxPortal) with ESMTPA id
        20200714002205epcas1p44e1d003b5d60efb8148aa596e4cb8d38~hdpT_7pW_0618706187epcas1p48;
        Tue, 14 Jul 2020 00:22:05 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20200714002205epsmtrp12dcbda1e4b1cf55e988bbf32359607c9~hdpT_Dzcp2665626656epsmtrp1d;
        Tue, 14 Jul 2020 00:22:05 +0000 (GMT)
X-AuditID: b6c32a37-9cdff700000071f5-30-5f0cfaad2f95
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        E6.EE.08382.DAAFC0F5; Tue, 14 Jul 2020 09:22:05 +0900 (KST)
Received: from [10.113.221.211] (unknown [10.113.221.211]) by
        epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20200714002205epsmtip2cb49aa13a900bde1e88c05781c20e6dc~hdpTrN5q12212122121epsmtip28;
        Tue, 14 Jul 2020 00:22:05 +0000 (GMT)
Subject: Re: [PATCH v7 07/36] drm: exynos: use common helper for a
 scatterlist contiguity check
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
Message-ID: <90332e7a-aa0e-3dd9-91cc-cdf87533f403@samsung.com>
Date:   Tue, 14 Jul 2020 09:28:04 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
        Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200619103636.11974-8-m.szyprowski@samsung.com>
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrPJsWRmVeSWpSXmKPExsWy7bCmru66XzzxBtsOMVn0njvJZLFxxnpW
        i//bJjJbXPn6ns1i5eqjTBYL9ltbfLnykMli0+NrrBaXd81hs5hxfh+Txdojd9ktDn54wmox
        Y/JLNgdejzXz1jB67P22gMVj+7cHrB73u48zeWxeUu9x+99jZo/JN5Yzeuy+2cDm0bdlFaPH
        501yAVxR2TYZqYkpqUUKqXnJ+SmZeem2St7B8c7xpmYGhrqGlhbmSgp5ibmptkouPgG6bpk5
        QLcrKZQl5pQChQISi4uV9O1sivJLS1IVMvKLS2yVUgtScgosC/SKE3OLS/PS9ZLzc60MDQyM
        TIEKE7Izvm6/zVrQz1sxdcs1xgbGU1xdjBwcEgImEt/fKXYxcnEICexglFjQeZ8dwvnEKPFu
        +QdmCOcbo8SNd99Yuxg5wTombZzECpHYyyix4m07lPOeUeL8uwYmkCphgUSJ3pP32EBsEYEt
        jBLNU91AipgFdjBJXPq+mQUkwSagKjFxxX2wIl4BO4kTz3rBbBag+O+X28EGiQpESBzvnswO
        USMocXLmE7BeTqD6z3cOg8WZBcQlbj2ZzwRhy0s0b50NdreEwB0OiZVPD7JA3O0isfToPSYI
        W1ji1fEt7BC2lMTL/jZ2iIZmRomJM04zQTgdjBJ3H1+H6jaW2L90MhMozJgFNCXW79KHCCtK
        7Pw9lxFiM5/Eu689rJBg5ZXoaBOCKFGSOHbxBiOELSFxYclENgjbQ+LMvTksExgVZyH5bRaS
        f2Yh+WcWwuIFjCyrGMVSC4pz01OLDQuMkeN7EyM4ZWuZ72Cc9vaD3iFGJg7GQ4wSHMxKIrzR
        opzxQrwpiZVVqUX58UWlOanFhxhNgaE9kVlKNDkfmDXySuINTY2MjY0tTAzNTA0NlcR5/51l
        jxcSSE8sSc1OTS1ILYLpY+LglGpgMmsJ0Sl14Z1fkuCx/uupRzZOV22fp9/ldG6YfyPbaJHB
        LIlJ70ViIpffWqArahhyIrHxg2fO/c/vVz+02qqzkmvJ548P/rBJxOrzqjyS1/1xl0dDo+1d
        7CLt8hV31Brm7w2unu/J6/nq3jNHtcaePzPWT/qUVC+x2kJH1yz7+9+j09eKxDloylY/4W7b
        43Xh1GFzW7klwnqzvdIzKn7Nv/H79hbRycJaZoyO5Y/OrJJf9NXriRnTdyvfWaxOOjVN6r8F
        2DpX3l0tGCNcovxcuGx7RnWNYb3IMf931498WZbT47ik7Icnx/tNffsjbuqtu3bylvjear4E
        7ZNP91l96mZrfse38eHdhimKTnL/lViKMxINtZiLihMBA/4EPWIEAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrLIsWRmVeSWpSXmKPExsWy7bCSvO7aXzzxBvdn8Fr0njvJZLFxxnpW
        i//bJjJbXPn6ns1i5eqjTBYL9ltbfLnykMli0+NrrBaXd81hs5hxfh+Txdojd9ktDn54wmox
        Y/JLNgdejzXz1jB67P22gMVj+7cHrB73u48zeWxeUu9x+99jZo/JN5Yzeuy+2cDm0bdlFaPH
        501yAVxRXDYpqTmZZalF+nYJXBlft99mLejnrZi65RpjA+Mpri5GTg4JAROJSRsnsXYxcnEI
        CexmlFh0qhnI4QBKSEhs2coBYQpLHD5cDFHyllFix8FNzCC9wgKJErNvnmcCSYgIbGGUeLbi
        MCOIwyywg0li+75/TBAtRxkl7jyZAdbCJqAqMXHFfTYQm1fATuLEs14wmwUo/vvldiYQW1Qg
        QqLl/h92iBpBiZMzn7CA2JxA9Z/vHAaLMwuoS/yZd4kZwhaXuPVkPhOELS/RvHU28wRGoVlI
        2mchaZmFpGUWkpYFjCyrGCVTC4pz03OLDQsM81LL9YoTc4tL89L1kvNzNzGCY1RLcwfj9lUf
        9A4xMnEwHmKU4GBWEuGNFuWMF+JNSaysSi3Kjy8qzUktPsQozcGiJM57o3BhnJBAemJJanZq
        akFqEUyWiYNTqoFJR+LXCl32zauNDyjL++d/er9MatoFiXm+k+z0fbRqEutuz+ytnrJe1OuP
        2ZsIlihrjTdH2ab3B2dNbKjbcfaBsx5fAZ/rKe7bTvxsl35KXUxeXdV9e0N/1puAKMvT/Id+
        uzP/qL4ub/P+kbygxumV+/a2FMWcPKRge6qTQ1B9j1C1XJnPp5aVl++cjNHIfG5xPGSu6Ka3
        PjdOPOM/vzJq6XmhjZ/6G3+4hqRv5JIOXiemueP46vy4V7lzjz2PdJ1mdZbNacnelLsJ2c/f
        6foEtH7lkrKapFyhfOqxc+sUNb4fdXWfH1jw7b54ZnPAcyc5Q82fLVKlTBN/7efve6N0/DOj
        LCe3UW9+Gt/BV01KLMUZiYZazEXFiQAuYyq3QAMAAA==
X-CMS-MailID: 20200714002205epcas1p44e1d003b5d60efb8148aa596e4cb8d38
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20200619103657eucas1p24bff92408adbd4715130fb47595a6187
References: <20200619103636.11974-1-m.szyprowski@samsung.com>
        <CGME20200619103657eucas1p24bff92408adbd4715130fb47595a6187@eucas1p2.samsung.com>
        <20200619103636.11974-8-m.szyprowski@samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



20. 6. 19. 오후 7:36에 Marek Szyprowski 이(가) 쓴 글:
> Use common helper for checking the contiguity of the imported dma-buf.
> 
> Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>

Acked-by : Inki Dae <inki.dae@samsung.com>

Thanks,
Inki Dae

> ---
>  drivers/gpu/drm/exynos/exynos_drm_gem.c | 23 +++--------------------
>  1 file changed, 3 insertions(+), 20 deletions(-)
> 
> diff --git a/drivers/gpu/drm/exynos/exynos_drm_gem.c b/drivers/gpu/drm/exynos/exynos_drm_gem.c
> index efa476858db5..1716a023bca0 100644
> --- a/drivers/gpu/drm/exynos/exynos_drm_gem.c
> +++ b/drivers/gpu/drm/exynos/exynos_drm_gem.c
> @@ -431,27 +431,10 @@ exynos_drm_gem_prime_import_sg_table(struct drm_device *dev,
>  {
>  	struct exynos_drm_gem *exynos_gem;
>  
> -	if (sgt->nents < 1)
> +	/* check if the entries in the sg_table are contiguous */
> +	if (drm_prime_get_contiguous_size(sgt) < attach->dmabuf->size) {
> +		DRM_ERROR("buffer chunks must be mapped contiguously");
>  		return ERR_PTR(-EINVAL);
> -
> -	/*
> -	 * Check if the provided buffer has been mapped as contiguous
> -	 * into DMA address space.
> -	 */
> -	if (sgt->nents > 1) {
> -		dma_addr_t next_addr = sg_dma_address(sgt->sgl);
> -		struct scatterlist *s;
> -		unsigned int i;
> -
> -		for_each_sg(sgt->sgl, s, sgt->nents, i) {
> -			if (!sg_dma_len(s))
> -				break;
> -			if (sg_dma_address(s) != next_addr) {
> -				DRM_ERROR("buffer chunks must be mapped contiguously");
> -				return ERR_PTR(-EINVAL);
> -			}
> -			next_addr = sg_dma_address(s) + sg_dma_len(s);
> -		}
>  	}
>  
>  	exynos_gem = exynos_drm_gem_init(dev, attach->dmabuf->size);
> 
