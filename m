Return-Path: <SRS0=SogR=6O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2680C4724C
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Apr 2020 14:18:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 933F3206D9
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Apr 2020 14:18:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="ZwiFYpXp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726937AbgD3OSD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Apr 2020 10:18:03 -0400
Received: from mailout1.w1.samsung.com ([210.118.77.11]:47658 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726550AbgD3OSC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Apr 2020 10:18:02 -0400
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20200430141800euoutp016164f6d4bf5be8d599cfbc5260613e21~Knqwbkl5A1821218212euoutp01k
        for <linux-kernel@vger.kernel.org>; Thu, 30 Apr 2020 14:18:00 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20200430141800euoutp016164f6d4bf5be8d599cfbc5260613e21~Knqwbkl5A1821218212euoutp01k
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1588256280;
        bh=Z+oh5N3Ek1AghjVaQH7O5XlCcDcgpiLe+Q7GQMjj1mg=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=ZwiFYpXpEXy7rRHwsceOOMVvLVKLbB6qV9P9hoL4hLcaYJVb7hEjMgpafm7w7dXxd
         RXnzCrRuI5wQvyJw3glMO6Ixt7SR/+XDluztK8AZOevBqW5C3LPqv9yxVK1CioY179
         udu5fgIZIVyqc7PGyUIf+hq5H7J7ukV+K2kVS4B4=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20200430141800eucas1p2a3b0536d2ca46bbdd1d4968c735697e9~KnqwCUmmL1824518245eucas1p2p;
        Thu, 30 Apr 2020 14:18:00 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges1new.samsung.com (EUCPMTA) with SMTP id 6C.98.61286.81EDAAE5; Thu, 30
        Apr 2020 15:18:00 +0100 (BST)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20200430141759eucas1p102b34d44f2609df319407319579c51df~KnqvoafPg3210532105eucas1p15;
        Thu, 30 Apr 2020 14:17:59 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20200430141759eusmtrp25453ff865a35d48094f4735251daf6fd~Knqvns_Kh2413924139eusmtrp2t;
        Thu, 30 Apr 2020 14:17:59 +0000 (GMT)
X-AuditID: cbfec7f2-f0bff7000001ef66-6a-5eaade18456b
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id 01.2C.07950.71EDAAE5; Thu, 30
        Apr 2020 15:17:59 +0100 (BST)
Received: from [106.210.88.143] (unknown [106.210.88.143]) by
        eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20200430141758eusmtip23b7b53901a212a41ae18f56a0ee60c01~Knqu4Y9D80720207202eusmtip2T;
        Thu, 30 Apr 2020 14:17:58 +0000 (GMT)
Subject: Re: [Intel-gfx] [RFC 06/17] drm: i915: fix sg_table nents vs.
 orig_nents misuse
To:     Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>,
        dri-devel@lists.freedesktop.org, iommu@lists.linux-foundation.org,
        linaro-mm-sig@lists.linaro.org, linux-kernel@vger.kernel.org
Cc:     Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        David Airlie <airlied@linux.ie>,
        intel-gfx@lists.freedesktop.org, amd-gfx@lists.freedesktop.org,
        Christoph Hellwig <hch@lst.de>,
        Benjamin Gaignard <benjamin.gaignard@linaro.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        linux-arm-kernel@lists.infradead.org
From:   Marek Szyprowski <m.szyprowski@samsung.com>
Message-ID: <9ffdaa30-aaf2-f25b-9837-265d66a95a88@samsung.com>
Date:   Thu, 30 Apr 2020 16:17:58 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
        Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <88c841d0-c64c-f1db-b91a-2c4fe7097ccf@linux.intel.com>
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Brightmail-Tracker: H4sIAAAAAAAAA01Se0hTYRzlu3e7u65mt9Xw14OCUUFBmr24UIwe/nGJogdRZFnNuq1Ip+2m
        pkEt7cXSkiyWS6ZENZur1bTa1Bpb1HJDCa01TTNRUIdmtCkpZLndHv53zvnO+X6/8/GRuLRX
        OJs8pj7JatTKNDkhFjx7M9q0FD6b9y+rChF0UVMDRt+znhPRT25ZhXS+20vQ74eHCPpB1WuM
        vl1cjdEVzjV0+H0XRtu6/UK6pbaMoF3feoS0tyMkoj3jeetiGYvRgph2fz3BPB/5ImSMDduZ
        zisejKm+e5b5NN6NMyUBE2LqWrUEc7XGjJiQbd62KcnitYfZtGPZrCZBcVB8tLw5IMx0rj51
        3lGCadFYvA7FkECtBMfjH0IdEpNSqhLBi1IfwZMwAseXmj8khKDQdgHpEBmN3DApeN2EYOhn
        EI9cJaWGJhJVCyJ4BpUMlz7U4RHTTMqOwJ1/IUpwqg8DoyskirgIKhF0gzoigiWUAm4GKgQR
        LKAWQq/LEp0mo1JA79/JW6ZDQ2lP1BJDbYS3rZ3RKE7Nh4Knt3Eex0FbTznGdysioa52H4+T
        wPqwDPF4BgQ9NSIez4VfjohfPIELEHQ1PRTxpBBBS/6tP4k10N40RkQWwqnFYK1N4OX1cN/Z
        JuBfJRYCg9P5HWLh+jM9zssSuHxRyrsXgcHz6N9Y17tmvBjJDZOaGSa1MUxqY/g/twIJzCiO
        zeLSVSyXqGZz4jllOpelVsUfyki3oYnv5xv3fLej4eZUN6JIJJ8qIW3m/VKhMpvLTXcjIHH5
        TElXyoQkOazMzWM1GQc0WWks50ZzSIE8TrLiTn+KlFIpT7LHWTaT1fw9xciY2VpUGq7k9rSW
        hWv758hGTd7X1SWbJKuc142KpJxrpzcsc6QObLw066PgUHDEI9s62pwE0lz7qw6zLHvK5b3L
        g92KxsC2xbtI/5YdlmmbW7SyI7sdBcbiM1/rU+3aDn0jKE60Dwy3/lrhUOU0tg8OtKny/C+t
        3l51p9Gn91nnP+qTC7ijysQluIZT/gZP4h52egMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrFIsWRmVeSWpSXmKPExsVy+t/xe7ri91bFGSxeom3Re+4kk8XS9Y3s
        FhtnrGe1aDp0is3iytf3bBYrVx9lspg9YTOTxYL91hZfrjxkstj0+BqrxeVdc9gsDn54wmpx
        6u5ndovj/6oc+DzWzFvD6HHn2h42j+3fHrB6zDsZ6HG/+ziTx+Yl9R63/z1m9ph8Yzmjx+6b
        DWwefVtWMXp83iQXwB2lZ1OUX1qSqpCRX1xiqxRtaGGkZ2hpoWdkYqlnaGwea2VkqqRvZ5OS
        mpNZllqkb5eglzH/0g3Wgv1mFS07JzM1MP7S62Lk4JAQMJGYstyui5GLQ0hgKaPEl479TF2M
        nEBxGYmT0xpYIWxhiT/Xutggit4yStz6voYZJCEsECXRfnU3mC0isINR4vTbPJAiZoEXTBLH
        JrRDdfxjlPj+owOsik3AUKLrLcgoTg5eATuJqTcWsIDYLAKqEs8PrmEEOUlUIFai5aImRImg
        xMmZT8BKOAWcJU7cvA/WyixgJjFv80NmCFteonnrbChbXOLWk/lMExiFZiFpn4WkZRaSlllI
        WhYwsqxiFEktLc5Nzy020itOzC0uzUvXS87P3cQIjPdtx35u2cHY9S74EKMAB6MSDy/HplVx
        QqyJZcWVuYcYJTiYlUR4H8YChXhTEiurUovy44tKc1KLDzGaAv02kVlKNDkfmIrySuINTQ3N
        LSwNzY3Njc0slMR5OwQOxggJpCeWpGanphakFsH0MXFwSjUwFuSrak08FRaeeGXC9XNHdLrn
        ztzWVrNTPplDmaUj8eTGoL2eXExhxqIrv0xw28/6MWzOlYWZC50jbz9+1Kn6VuwN06FYhY6z
        Eqbqwq+WzOF5xml0gf/sPCuX6WUyLvPY8kPP8Cfcte3ftKJyWvCVuZ/3ly6fbpzHfv71m60C
        ii0x9ckWoq2iSizFGYmGWsxFxYkADKnRcQ0DAAA=
X-CMS-MailID: 20200430141759eucas1p102b34d44f2609df319407319579c51df
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20200428132025eucas1p21580e634500a3e85564551cddf168b4a
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20200428132025eucas1p21580e634500a3e85564551cddf168b4a
References: <20200428132005.21424-1-m.szyprowski@samsung.com>
        <CGME20200428132025eucas1p21580e634500a3e85564551cddf168b4a@eucas1p2.samsung.com>
        <20200428132005.21424-7-m.szyprowski@samsung.com>
        <88c841d0-c64c-f1db-b91a-2c4fe7097ccf@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi

On 28.04.2020 16:27, Tvrtko Ursulin wrote:
>
> On 28/04/2020 14:19, Marek Szyprowski wrote:
>> The Documentation/DMA-API-HOWTO.txt states that dma_map_sg returns the
>> numer of the created entries in the DMA address space. However the
>> subsequent calls to dma_sync_sg_for_{device,cpu} and dma_unmap_sg 
>> must be
>> called with the original number of entries passed to dma_map_sg. The
>> sg_table->nents in turn holds the result of the dma_map_sg call as 
>> stated
>> in include/linux/scatterlist.h. Adapt the code to obey those rules.
>>
>> Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
>> ---
>>   drivers/gpu/drm/i915/gem/i915_gem_dmabuf.c       | 13 +++++++------
>>   drivers/gpu/drm/i915/gem/i915_gem_internal.c     |  4 ++--
>>   drivers/gpu/drm/i915/gem/i915_gem_region.c       |  4 ++--
>>   drivers/gpu/drm/i915/gem/i915_gem_shmem.c        |  5 +++--
>>   drivers/gpu/drm/i915/gem/selftests/huge_pages.c  | 10 +++++-----
>>   drivers/gpu/drm/i915/gem/selftests/mock_dmabuf.c |  5 +++--
>>   drivers/gpu/drm/i915/gt/intel_ggtt.c             | 12 ++++++------
>>   drivers/gpu/drm/i915/i915_gem_gtt.c              | 12 +++++++-----
>>   drivers/gpu/drm/i915/i915_scatterlist.c          |  4 ++--
>>   drivers/gpu/drm/i915/selftests/scatterlist.c     |  8 ++++----
>>   10 files changed, 41 insertions(+), 36 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/i915/gem/i915_gem_dmabuf.c 
>> b/drivers/gpu/drm/i915/gem/i915_gem_dmabuf.c
>> index 7db5a79..d829852 100644
>> --- a/drivers/gpu/drm/i915/gem/i915_gem_dmabuf.c
>> +++ b/drivers/gpu/drm/i915/gem/i915_gem_dmabuf.c
>> @@ -36,21 +36,22 @@ static struct sg_table 
>> *i915_gem_map_dma_buf(struct dma_buf_attachment *attachme
>>           goto err_unpin_pages;
>>       }
>>   -    ret = sg_alloc_table(st, obj->mm.pages->nents, GFP_KERNEL);
>> +    ret = sg_alloc_table(st, obj->mm.pages->orig_nents, GFP_KERNEL);
>>       if (ret)
>>           goto err_free;
>>         src = obj->mm.pages->sgl;
>>       dst = st->sgl;
>> -    for (i = 0; i < obj->mm.pages->nents; i++) {
>> +    for (i = 0; i < obj->mm.pages->orig_nents; i++) {
>>           sg_set_page(dst, sg_page(src), src->length, 0);
>>           dst = sg_next(dst);
>>           src = sg_next(src);
>>       }
>>   -    if (!dma_map_sg_attrs(attachment->dev,
>> -                  st->sgl, st->nents, dir,
>> -                  DMA_ATTR_SKIP_CPU_SYNC)) {
>> +    st->nents = dma_map_sg_attrs(attachment->dev,
>> +                     st->sgl, st->orig_nents, dir,
>> +                     DMA_ATTR_SKIP_CPU_SYNC);
>> +    if (!st->nents) {
>>           ret = -ENOMEM;
>>           goto err_free_sg;
>>       }
>> @@ -74,7 +75,7 @@ static void i915_gem_unmap_dma_buf(struct 
>> dma_buf_attachment *attachment,
>>       struct drm_i915_gem_object *obj = 
>> dma_buf_to_obj(attachment->dmabuf);
>>         dma_unmap_sg_attrs(attachment->dev,
>> -               sg->sgl, sg->nents, dir,
>> +               sg->sgl, sg->orig_nents, dir,
>>                  DMA_ATTR_SKIP_CPU_SYNC);
>>       sg_free_table(sg);
>>       kfree(sg);
>> diff --git a/drivers/gpu/drm/i915/gem/i915_gem_internal.c 
>> b/drivers/gpu/drm/i915/gem/i915_gem_internal.c
>> index cbbff81..a8ebfdd 100644
>> --- a/drivers/gpu/drm/i915/gem/i915_gem_internal.c
>> +++ b/drivers/gpu/drm/i915/gem/i915_gem_internal.c
>> @@ -73,7 +73,7 @@ static int 
>> i915_gem_object_get_pages_internal(struct drm_i915_gem_object *obj)
>>       }
>>         sg = st->sgl;
>> -    st->nents = 0;
>> +    st->nents = st->orig_nents = 0;
>>       sg_page_sizes = 0;
>>         do {
>> @@ -94,7 +94,7 @@ static int 
>> i915_gem_object_get_pages_internal(struct drm_i915_gem_object *obj)
>>             sg_set_page(sg, page, PAGE_SIZE << order, 0);
>>           sg_page_sizes |= PAGE_SIZE << order;
>> -        st->nents++;
>> +        st->nents = st->orig_nents = st->nents + 1;
>>             npages -= 1 << order;
>>           if (!npages) {
>> diff --git a/drivers/gpu/drm/i915/gem/i915_gem_region.c 
>> b/drivers/gpu/drm/i915/gem/i915_gem_region.c
>> index 1515384..58ca560 100644
>> --- a/drivers/gpu/drm/i915/gem/i915_gem_region.c
>> +++ b/drivers/gpu/drm/i915/gem/i915_gem_region.c
>> @@ -53,7 +53,7 @@
>>       GEM_BUG_ON(list_empty(blocks));
>>         sg = st->sgl;
>> -    st->nents = 0;
>> +    st->nents = st->orig_nents = 0;
>>       sg_page_sizes = 0;
>>       prev_end = (resource_size_t)-1;
>>   @@ -78,7 +78,7 @@
>>                 sg->length = block_size;
>>   -            st->nents++;
>> +            st->nents = st->orig_nents = st->nents + 1;
>>           } else {
>>               sg->length += block_size;
>>               sg_dma_len(sg) += block_size;
>> diff --git a/drivers/gpu/drm/i915/gem/i915_gem_shmem.c 
>> b/drivers/gpu/drm/i915/gem/i915_gem_shmem.c
>> index 5d5d7ee..851a732 100644
>> --- a/drivers/gpu/drm/i915/gem/i915_gem_shmem.c
>> +++ b/drivers/gpu/drm/i915/gem/i915_gem_shmem.c
>> @@ -80,7 +80,7 @@ static int shmem_get_pages(struct 
>> drm_i915_gem_object *obj)
>>       noreclaim |= __GFP_NORETRY | __GFP_NOWARN;
>>         sg = st->sgl;
>> -    st->nents = 0;
>> +    st->nents = st->orig_nents = 0;
>>       sg_page_sizes = 0;
>>       for (i = 0; i < page_count; i++) {
>>           const unsigned int shrink[] = {
>> @@ -140,7 +140,8 @@ static int shmem_get_pages(struct 
>> drm_i915_gem_object *obj)
>>                   sg_page_sizes |= sg->length;
>>                   sg = sg_next(sg);
>>               }
>> -            st->nents++;
>> +            st->nents = st->orig_nents = st->nents + 1;
>
> A bit higher up, not shown in the patch, we have allocated a table via 
> sg_alloc_table giving it a pessimistic max nents, sometimes much 
> larger than the st->nents this loops will create. But orig_nents has 
> been now been overwritten. Will that leak memory come sg_table_free?

Indeed this will leak memory. I'm missed that sg_trim() will adjust 
nents and orig_nents.

I will drop those changes as they are only a creative (or hacky) way of 
using sg_table and scatterlists.

> As minimum it will nerf our i915_sg_trim optimization a bit lower 
> down, also not shown in the diff.
>
> > [...]

Best regards
-- 
Marek Szyprowski, PhD
Samsung R&D Institute Poland

