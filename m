Return-Path: <SRS0=aTFg=AS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99E8CC433DF
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jul 2020 09:35:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 792EE2065F
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jul 2020 09:35:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="vRfz3EUo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728037AbgGGJf6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Jul 2020 05:35:58 -0400
Received: from mailout1.w1.samsung.com ([210.118.77.11]:49043 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726467AbgGGJf6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jul 2020 05:35:58 -0400
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20200707093556euoutp014d632799f9dd4d89fecef70d344cc2a1~fbr5HPjTF1120911209euoutp01n
        for <linux-kernel@vger.kernel.org>; Tue,  7 Jul 2020 09:35:56 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20200707093556euoutp014d632799f9dd4d89fecef70d344cc2a1~fbr5HPjTF1120911209euoutp01n
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1594114556;
        bh=UaS1/ITQJEn5fzjhXvRGacaHKocR55iPkkA8Q61E4zg=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=vRfz3EUo9Tjq7ny2909hVlYWNBll5vpWfDvav/VRG1+2rUDe8FSttTR9JUq4+wpXz
         rkD2t1Vmk5K/pPI2SGIYisji5p/jt03xQSY1CvGsyR0TlmfVnyLoULXhSmUAT6HQKQ
         MVMR6jJzW9JAQeWwo6DHDRqPPPkLqW2/ci6/Rddg=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20200707093556eucas1p1d5b7ff583698c44c3bfcf3ee1b574c9b~fbr4xHpRb1102211022eucas1p1k;
        Tue,  7 Jul 2020 09:35:56 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges2new.samsung.com (EUCPMTA) with SMTP id A1.C6.05997.CF1440F5; Tue,  7
        Jul 2020 10:35:56 +0100 (BST)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20200707093555eucas1p1edecb0332b868d481c2ebc9fbb263c16~fbr4dVOuR0885708857eucas1p1P;
        Tue,  7 Jul 2020 09:35:55 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20200707093555eusmtrp208bfcf2442c01c25f64aa2d741da976e~fbr4cnV7u0591605916eusmtrp2O;
        Tue,  7 Jul 2020 09:35:55 +0000 (GMT)
X-AuditID: cbfec7f4-677ff7000000176d-aa-5f0441fcfade
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id 0E.B8.06314.BF1440F5; Tue,  7
        Jul 2020 10:35:55 +0100 (BST)
Received: from [106.210.85.205] (unknown [106.210.85.205]) by
        eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20200707093553eusmtip1363a8004048520f85cd2bf8b03612ded~fbr2RJ7o02299222992eusmtip1v;
        Tue,  7 Jul 2020 09:35:53 +0000 (GMT)
Subject: Re: [PATCH v7 07/36] drm: exynos: use common helper for a
 scatterlist contiguity check
To:     Marek Szyprowski <m.szyprowski@samsung.com>,
        dri-devel@lists.freedesktop.org, iommu@lists.linux-foundation.org,
        linaro-mm-sig@lists.linaro.org, linux-kernel@vger.kernel.org
Cc:     linux-samsung-soc@vger.kernel.org,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        David Airlie <airlied@linux.ie>,
        Seung-Woo Kim <sw0312.kim@samsung.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Christoph Hellwig <hch@lst.de>,
        linux-arm-kernel@lists.infradead.org
From:   Andrzej Hajda <a.hajda@samsung.com>
Message-ID: <8e25b060-2901-6d8d-f5ee-9f7cc0f02b77@samsung.com>
Date:   Tue, 7 Jul 2020 11:35:52 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
        Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200619103636.11974-8-m.szyprowski@samsung.com>
Content-Transfer-Encoding: 7bit
Content-Language: en-GB
X-Brightmail-Tracker: H4sIAAAAAAAAA02SfSxVcRjH+51zz7nHzeW42P1NTdy1rLZI+uMszVJWZyut/uiPbOjgzEtc
        usdLknnJxBWrjBCFeU+j6yJqlNfJUFIhLwkttRvN1eZ6KcfR8t/n+T7P832e57cfgcqGMCsi
        UBnOqpRMsAKXiBq6lgcOrrqKvA+1ruyk0vt7EOppTg1GDS3N41Tl406EKmx1pvRDUwilmf6A
        Ue+a83EqZ6AFoZ50jIupVwszGJWTOYcfN6arH1YDuvH3Z4yeTOtG6LqSOPrT+jRKZw6XA/r5
        SDxOZ2irAL2osT5v5CE55scGB0ayKgeXy5KA+dwhPCxBei1ek43Gg2aJGhgRkDwCOzQZiBpI
        CBlZAWCDYXwr0AO4oO7BhWARwFL1240MsdmyVEQKejmADwYTMN5KRs4DuNQWxLM5ycD0ngmc
        ZwtSC+DNrFN8A0pmIXC6oQXlEzi5H67VjeC8qZR0gerKo7wsIvfChamiTU9L0gvWzDUiPEtJ
        M9iTOyPi2WijfHGsXcwzSu6Bjbp8VGA5TNRXYvwsSC6L4WxZHybc6QbLClKBwObwe7dWLPBu
        +KfpESJwHJysSEKF5hQA62ubUCHhDMf6DZuLohtL1zQ7CLIrHF4fBcKjmMBhnZmwgwm813Af
        FWQpTEmWCdW2cLKvfstQDkvfLOF3gCJv22V5267J23ZN3v+5hUBUBeRsBBfiz3KHlWyUPceE
        cBFKf3vf0BAN2Phrvevd+megedWnDZAEUBhLU3DUW4YxkVx0SBuABKqwkJ7o6/WSSf2Y6Ous
        KtRbFRHMcm1gFyFSyKVOxXOeMtKfCWevsGwYq/qXRQgjq3jgH3ZBnOih9XX/eLrJUnXR9/WL
        NNPz9V+CgF4+avdNtHyOauem1DbFZsG6wTnvrxPKpBs69G72DuTWSmnyDz/TLmBiLS9pcRrx
        vGRj2Gd1lbkdc+akT21nQW6/bZz7r59JMWcdZ+dzozvdXiqq7RLX3sfGaHVRsTOalWKDn3ty
        qkLEBTCOB1AVx/wFBrgTCmcDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrJIsWRmVeSWpSXmKPExsVy+t/xu7q/HVniDZ79MbXoPXeSyWLjjPWs
        Fle+vmezWLn6KJPFgv3WFl+uPGSy2PT4GqvF5V1z2CxmnN/HZLH2yF12i4MfnrBazJj8ks2B
        x2PNvDWMHtu/PWD1uN99nMlj85J6j9v/HjN7TL6xnNFj980GNo++LasYPT5vkgvgjNKzKcov
        LUlVyMgvLrFVija0MNIztLTQMzKx1DM0No+1MjJV0rezSUnNySxLLdK3S9DLeD/zCltBI29F
        w6ZpzA2Mu7i6GDk4JARMJL4uFOhi5OIQEljKKHHj8huWLkZOoLi4xO75b5khbGGJP9e62CCK
        3jJKbF6wC6xIWCBRYvbN80wgCRGBLYwSz1YcZgRxmAWmM0nc7PrBCtFylFHizpMZYLPYBDQl
        /m6+yQaym1fATqJrpRVImEVAReLDw4WsILaoQJzE8i3z2UFsXgFBiZMzn4Bt4wQq/3znMFic
        WcBMYt7mh8wQtrzE9rdzoGxxiaYvK1knMArNQtI+C0nLLCQts5C0LGBkWcUoklpanJueW2yo
        V5yYW1yal66XnJ+7iREYzduO/dy8g/HSxuBDjAIcjEo8vAlHmOOFWBPLiitzDzFKcDArifA6
        nT0dJ8SbklhZlVqUH19UmpNafIjRFOi5icxSosn5wESTVxJvaGpobmFpaG5sbmxmoSTO2yFw
        MEZIID2xJDU7NbUgtQimj4mDU6qBcYL380dtzu/uVHQwcsjNvbbNa7nkjTzxZIV9z1Z0C0XI
        HvV2T2O+stpmjqfTCy89lmuLnpTKL7vjK/u5L0/+r2lUZMIamYg94ht28qWwtn3W+Czp9tPA
        o4yh2fP4y/VuM0uuHD+QUsC+43dvlr9rdhlnUczVNXbzTgnIdBs6atncZ2fZ+aZdiaU4I9FQ
        i7moOBEAyQoJx/wCAAA=
X-CMS-MailID: 20200707093555eucas1p1edecb0332b868d481c2ebc9fbb263c16
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20200619103657eucas1p24bff92408adbd4715130fb47595a6187
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20200619103657eucas1p24bff92408adbd4715130fb47595a6187
References: <20200619103636.11974-1-m.szyprowski@samsung.com>
        <CGME20200619103657eucas1p24bff92408adbd4715130fb47595a6187@eucas1p2.samsung.com>
        <20200619103636.11974-8-m.szyprowski@samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 19.06.2020 12:36, Marek Szyprowski wrote:
> Use common helper for checking the contiguity of the imported dma-buf.
>
> Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
> ---
>   drivers/gpu/drm/exynos/exynos_drm_gem.c | 23 +++--------------------
>   1 file changed, 3 insertions(+), 20 deletions(-)
>
> diff --git a/drivers/gpu/drm/exynos/exynos_drm_gem.c b/drivers/gpu/drm/exynos/exynos_drm_gem.c
> index efa476858db5..1716a023bca0 100644
> --- a/drivers/gpu/drm/exynos/exynos_drm_gem.c
> +++ b/drivers/gpu/drm/exynos/exynos_drm_gem.c
> @@ -431,27 +431,10 @@ exynos_drm_gem_prime_import_sg_table(struct drm_device *dev,
>   {
>   	struct exynos_drm_gem *exynos_gem;
>   
> -	if (sgt->nents < 1)
> +	/* check if the entries in the sg_table are contiguous */
> +	if (drm_prime_get_contiguous_size(sgt) < attach->dmabuf->size) {
> +		DRM_ERROR("buffer chunks must be mapped contiguously");
>   		return ERR_PTR(-EINVAL);
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
>   	}


Reviewed-by <a.hajda@samsung.com>


Regards
Andrzej
>   
>   	exynos_gem = exynos_drm_gem_init(dev, attach->dmabuf->size);
