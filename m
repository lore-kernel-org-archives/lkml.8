Return-Path: <SRS0=s8dx=5M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69224C2D0E8
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Mar 2020 07:55:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 389C920705
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Mar 2020 07:55:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="PGHu6+2x"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726739AbgC0HzC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Mar 2020 03:55:02 -0400
Received: from mailout1.w1.samsung.com ([210.118.77.11]:55890 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726106AbgC0HzB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Mar 2020 03:55:01 -0400
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20200327075459euoutp0104059cf95321e77d64a26dbbbdd9d11a~AGgoSj2Zy3213732137euoutp01i
        for <linux-kernel@vger.kernel.org>; Fri, 27 Mar 2020 07:54:59 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20200327075459euoutp0104059cf95321e77d64a26dbbbdd9d11a~AGgoSj2Zy3213732137euoutp01i
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1585295699;
        bh=z1HB+a2qhYgTi5psfgO327+TLpLmqqORAQ8t3hMr+4s=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=PGHu6+2xAqunnTSXd/Z1DhUHy2JZ7MvQD7wXJrQvRm4X7l9Ilz2jdIOV275EchnNz
         Z6SsIX9TyYuCVFAI0RL91bkkJEdvB8StFmV5z+Xk/9L4xS/lSVZse6pAmSumFtCA5T
         gqBhbj7JXtPLqrXLCeDiEqszKUqMZ2l8rAzeg73U=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20200327075459eucas1p15028095be1e584ef018f9f643fb28385~AGgoGAgdi1028910289eucas1p10;
        Fri, 27 Mar 2020 07:54:59 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges2new.samsung.com (EUCPMTA) with SMTP id EE.F7.60679.351BD7E5; Fri, 27
        Mar 2020 07:54:59 +0000 (GMT)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20200327075458eucas1p2f1011560c5d2d2a754d2394f56367ebb~AGgnpxqYO2341923419eucas1p2B;
        Fri, 27 Mar 2020 07:54:58 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20200327075458eusmtrp1306bab2f7f80c8d8227c3d1005172c66~AGgnpKhq40785107851eusmtrp1J;
        Fri, 27 Mar 2020 07:54:58 +0000 (GMT)
X-AuditID: cbfec7f4-0cbff7000001ed07-5d-5e7db153be82
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id E4.96.07950.251BD7E5; Fri, 27
        Mar 2020 07:54:58 +0000 (GMT)
Received: from [106.210.88.143] (unknown [106.210.88.143]) by
        eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20200327075458eusmtip2688beca08bcbebe789e8e2c522cf21ea~AGgnFrzNo2875428754eusmtip2F;
        Fri, 27 Mar 2020 07:54:58 +0000 (GMT)
Subject: Re: [v4,1/3] drm/prime: use dma length macro when mapping sg
To:     Shane Francis <bigbeeshane@gmail.com>,
        dri-devel@lists.freedesktop.org
Cc:     airlied@linux.ie, linux-kernel@vger.kernel.org,
        amd-gfx-request@lists.freedesktop.org, alexander.deucher@amd.com,
        christian.koenig@amd.com
From:   Marek Szyprowski <m.szyprowski@samsung.com>
Message-ID: <4aef60ff-d9e4-d3d0-1a28-8c2dc3b94271@samsung.com>
Date:   Fri, 27 Mar 2020 08:54:53 +0100
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:68.0) Gecko/20100101
        Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20200325090741.21957-2-bigbeeshane@gmail.com>
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrLKsWRmVeSWpSXmKPExsWy7djP87rBG2vjDNZ0cFj0njvJZDHtzm5W
        i3X/brJYNO7sY7J4ex/IvfL1PZvF5V1z2BzYPVov/WXz2DnrLrvH9m8PWD3udx9n8vi8SS6A
        NYrLJiU1J7MstUjfLoEr4+LWWYwF1+Urjn3rZ21gvCnVxcjJISFgIvFg+TOmLkYuDiGBFYwS
        Uy6dY4ZwvjBK7P9+gwXC+cwosXLFKXaYlmkfDzNCJJYzSkz8/g2q6j2jxI7uDhaQKmEBV4md
        Ta2MILaIgJfEm5Ob2UGKmAUmMUq8WnUHLMEmYCjR9baLDcTmFbCTmPG0EcxmEVCVWPpkOxOI
        LSoQI3HxcD8rRI2gxMmZT8AWcApYS6xZeRcsziwgL9G8dTYzhC0ucevJfLCPJATWsUvsn/Sc
        EeJuF4m1byCKJASEJV4d3wL1j4zE6ck9LBANzYwSD8+tZYdwehglLjfNgOq2lrhz7hfQeRxA
        KzQl1u/Shwg7Sjy7cpIZJCwhwCdx460gxBF8EpO2TYcK80p0tAlBVKtJzDq+Dm7twQuXmCcw
        Ks1C8tosJO/MQvLOLIS9CxhZVjGKp5YW56anFhvlpZbrFSfmFpfmpesl5+duYgQmotP/jn/Z
        wbjrT9IhRgEORiUeXo2Wmjgh1sSy4srcQ4wSHMxKIrxPI4FCvCmJlVWpRfnxRaU5qcWHGKU5
        WJTEeY0XvYwVEkhPLEnNTk0tSC2CyTJxcEo1MGbkyzFF1P4/v+preqbdUTGhZ2yce4z1Hip8
        ll4aXPVwR36nvob7kk9+uaevBM04mO2qfPi5QeSESTKrMsr//5o78VfE2fMs+81m3o3eHr7g
        BsuulH7raebA8Fdfccl4wsXsqV+6Engu/I7Rvq12tviq7rfnZwPknn+V5j6kvX/Hlj3fjF4+
        +q3EUpyRaKjFXFScCAA3mCMhQAMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrLIsWRmVeSWpSXmKPExsVy+t/xe7pBG2vjDC6vULfoPXeSyWLand2s
        Fuv+3WSxaNzZx2Tx9j6Qe+XrezaLy7vmsDmwe7Re+svmsXPWXXaP7d8esHrc7z7O5PF5k1wA
        a5SeTVF+aUmqQkZ+cYmtUrShhZGeoaWFnpGJpZ6hsXmslZGpkr6dTUpqTmZZapG+XYJexsWt
        sxgLrstXHPvWz9rAeFOqi5GTQ0LARGLax8OMXYxcHEICSxklvny/xgiRkJE4Oa2BFcIWlvhz
        rYsNxBYSeMsocfG4PYgtLOAqsbOpFaxeRMBL4s3Jzewgg5gFJjFKnJq5lRWiwUpi0qw2ZhCb
        TcBQoustxCBeATuJGU8bwWwWAVWJpU+2M4HYogIxEj/3dLFA1AhKnJz5BMzmFLCWWLPyLthM
        ZgEziXmbHzJD2PISzVtnQ9niEreezGeawCg0C0n7LCQts5C0zELSsoCRZRWjSGppcW56brGR
        XnFibnFpXrpecn7uJkZg1G079nPLDsaud8GHGAU4GJV4eDVaauKEWBPLiitzDzFKcDArifA+
        jQQK8aYkVlalFuXHF5XmpBYfYjQFem4is5Rocj4wIeSVxBuaGppbWBqaG5sbm1koifN2CByM
        ERJITyxJzU5NLUgtgulj4uCUamCc/phr+VIZ9y32ab9mVE08e0f7v1qX03kzoXdCU2L8vb70
        BvknmQllz/1ytkFw/vTYK3EFRw7vOMO6oiK4ZMoR49K5ytnKPh08Sbt3MFttefrflKOk4ESW
        uvnEr8wTdCVkY+qaZecfnLun9iN77t5K9Z1lx7zyzm2sOfLuSNgt0z0Taj+sYBBQYinOSDTU
        Yi4qTgQA51PgodACAAA=
X-CMS-MailID: 20200327075458eucas1p2f1011560c5d2d2a754d2394f56367ebb
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20200327075458eucas1p2f1011560c5d2d2a754d2394f56367ebb
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20200327075458eucas1p2f1011560c5d2d2a754d2394f56367ebb
References: <20200325090741.21957-2-bigbeeshane@gmail.com>
        <CGME20200327075458eucas1p2f1011560c5d2d2a754d2394f56367ebb@eucas1p2.samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi All,

On 2020-03-25 10:07, Shane Francis wrote:
> As dma_map_sg can reorganize scatter-gather lists in a
> way that can cause some later segments to be empty we should
> always use the sg_dma_len macro to fetch the actual length.
>
> This could now be 0 and not need to be mapped to a page or
> address array
>
> Signed-off-by: Shane Francis <bigbeeshane@gmail.com>
> Reviewed-by: Michael J. Ruhl <michael.j.ruhl@intel.com>
This patch landed in linux-next 20200326 and it causes a kernel panic on 
various Exynos SoC based boards.
> ---
>   drivers/gpu/drm/drm_prime.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/drm_prime.c b/drivers/gpu/drm/drm_prime.c
> index 86d9b0e45c8c..1de2cde2277c 100644
> --- a/drivers/gpu/drm/drm_prime.c
> +++ b/drivers/gpu/drm/drm_prime.c
> @@ -967,7 +967,7 @@ int drm_prime_sg_to_page_addr_arrays(struct sg_table *sgt, struct page **pages,
>   
>   	index = 0;
>   	for_each_sg(sgt->sgl, sg, sgt->nents, count) {
> -		len = sg->length;
> +		len = sg_dma_len(sg);
>   		page = sg_page(sg);
>   		addr = sg_dma_address(sg);
>   

Sorry, but this code is wrong :(

The scatterlist elements (sg) describes memory chunks in physical memory 
and in the DMA (IO virtual) space. However in general, you cannot assume 
1:1 mapping between them. If you access sg_page(sg) (basically 
sg->page), you must match it with sg->length. When you access 
sg_dma_address(sg) (again, in most cases it is sg->dma_address), then 
you must match it with sg_dma_len(sg). The sg->dma_address might not be 
the dma address of the sg->page.

In some cases (when IOMMU is available, it performs aggregation of the 
scatterlist chunks and a few other, minor requirements), the whole 
scatterlist might be mapped into contiguous DMA address space and filled 
only to the first sg element.

The proper way to iterate over a scatterlists to get both the pages and 
the DMA addresses assigned to them is:

int drm_prime_sg_to_page_addr_arrays(struct sg_table *sgt, struct page 
**pages,
                                      dma_addr_t *addrs, int max_entries)
{
         unsigned count;
         struct scatterlist *sg;
         struct page *page;
         u32 page_len, page_index;
         dma_addr_t addr;
         u32 dma_len, dma_index;

         page_index = 0;
         dma_index = 0;
         for_each_sg(sgt->sgl, sg, sgt->nents, count) {
                 page_len = sg->length;
                 page = sg_page(sg);
                 dma_len = sg_dma_len(sg);
                 addr = sg_dma_address(sg);

                 while (pages && page_len > 0) {
                         if (WARN_ON(page_index >= max_entries))
                                 return -1;
                         pages[page_index] = page;
                         page++;
                         page_len -= PAGE_SIZE;
                         page_index++;
                 }

                 while (addrs && dma_len > 0) {
                         if (WARN_ON(dma_index >= max_entries))
                                 return -1;
                         addrs[dma_index] = addr;
                         addr += PAGE_SIZE;
                         dma_len -= PAGE_SIZE;
                         dma_index++;
                 }
         }

         return 0;
}

I will send a patch in a few minutes with the above fixed code.

Best regards
-- 
Marek Szyprowski, PhD
Samsung R&D Institute Poland

