Return-Path: <SRS0=s8dx=5M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF4E2C2D0E8
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Mar 2020 08:27:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7E17C20716
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Mar 2020 08:27:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="rRckQl94"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726360AbgC0I1G (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Mar 2020 04:27:06 -0400
Received: from mailout2.w1.samsung.com ([210.118.77.12]:59632 "EHLO
        mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726027AbgC0I1G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Mar 2020 04:27:06 -0400
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20200327082703euoutp02a3c13d041cdb1ffd5bfc4839ceee8a13~AG8oIC55X0945009450euoutp02r
        for <linux-kernel@vger.kernel.org>; Fri, 27 Mar 2020 08:27:03 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20200327082703euoutp02a3c13d041cdb1ffd5bfc4839ceee8a13~AG8oIC55X0945009450euoutp02r
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1585297623;
        bh=yGWBOufUxku4IhmbLqCqqlEYPBzcAimXwzgI3OivfXg=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=rRckQl94I6smlBkOWMrSWwjBt8fwCNMGEx3VUl6hGLkh1nNmktcXHCa+4YPS6DPsZ
         tZKHBN0V8vBY8Y02r5VIh/JFz1XoX1gmmS3dxCzIRFHczzh9hKLxPaZMK8lwhBfWsW
         ulENfCrSnjI8nA9JPRB2MAo4ASWZzWXDU6uAN3/w=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20200327082703eucas1p27f8dc42535f02ae2b52a28a6a9ba18f2~AG8n5opL22925829258eucas1p2H;
        Fri, 27 Mar 2020 08:27:03 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges3new.samsung.com (EUCPMTA) with SMTP id 4D.1B.60698.6D8BD7E5; Fri, 27
        Mar 2020 08:27:03 +0000 (GMT)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20200327082702eucas1p1a66dd059480c9d02b8f0f3ab225db2c3~AG8nnDuUv0224402244eucas1p1E;
        Fri, 27 Mar 2020 08:27:02 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20200327082702eusmtrp14497470c3746c2d72d1d49362fe81b49~AG8nmF_cw2917329173eusmtrp1G;
        Fri, 27 Mar 2020 08:27:02 +0000 (GMT)
X-AuditID: cbfec7f5-a29ff7000001ed1a-6c-5e7db8d6f7e4
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id 14.9A.08375.6D8BD7E5; Fri, 27
        Mar 2020 08:27:02 +0000 (GMT)
Received: from [106.210.88.143] (unknown [106.210.88.143]) by
        eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20200327082702eusmtip2c58d0cb7c1200f78bf59a94e46baf639~AG8nCMe8W1711417114eusmtip2B;
        Fri, 27 Mar 2020 08:27:02 +0000 (GMT)
Subject: Re: [v4,1/3] drm/prime: use dma length macro when mapping sg
From:   Marek Szyprowski <m.szyprowski@samsung.com>
To:     Shane Francis <bigbeeshane@gmail.com>,
        dri-devel@lists.freedesktop.org
Cc:     airlied@linux.ie, linux-kernel@vger.kernel.org,
        amd-gfx-request@lists.freedesktop.org, alexander.deucher@amd.com,
        christian.koenig@amd.com
Message-ID: <6aa0e294-9007-287a-ffb7-e3fbe50e2321@samsung.com>
Date:   Fri, 27 Mar 2020 09:26:57 +0100
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:68.0) Gecko/20100101
        Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <4aef60ff-d9e4-d3d0-1a28-8c2dc3b94271@samsung.com>
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrFKsWRmVeSWpSXmKPExsWy7djP87rXd9TGGfw4zmjRe+4kk8W0O7tZ
        Ldb9u8li0bizj8ni7X0g98rX92wWl3fNYXNg92i99JfNY+esu+we2789YPW4332cyePzJrkA
        1igum5TUnMyy1CJ9uwSujN8nu9gLPilWXNns0sD4QqaLkYNDQsBEov2iaxcjF4eQwApGibf7
        77NAOF8YJU5suQ7lfGaUaJh9mamLkROs49H7dYwQieWMEgfO/WeGcN4zSix8t4sZpEpYwFVi
        Z1MrI4jNJmAo0fW2iw3EFhHwknhzcjM7SAOzwCRGiVer7oAV8QrYSfTMPApWxCKgKjFlxxGw
        QaICMRIXD/ezQtQISpyc+YQFxOYUsJfYOuk2WC+zgLxE89bZzBC2uMStJ/OhTl3HLrFmgySE
        7SIxZ9FhRghbWOLV8S3sELaMxOnJPWB/Sgg0M0o8PLeWHcLpYZS43DQDqsNa4s65X2ygIGMW
        0JRYv0sfIuwosWBWAxskJPkkbrwVhLiBT2LStunMEGFeiY42IYhqNYlZx9fBrT144RLzBEal
        WUg+m4Xkm1lIvpmFsHcBI8sqRvHU0uLc9NRi47zUcr3ixNzi0rx0veT83E2MwBR0+t/xrzsY
        9/1JOsQowMGoxMPb0FYTJ8SaWFZcmXuIUYKDWUmE92kkUIg3JbGyKrUoP76oNCe1+BCjNAeL
        kjiv8aKXsUIC6YklqdmpqQWpRTBZJg5OqQbGCTODpjscMMnSOOSw4JHlj6/nMt83H50s8XTH
        4dP7DkZeEFu/urTsbyvLlC7fFBNfMflFyg9Fb740vCzZGvL94KL2G0IZU3ZP7jpYt8L8p+ZV
        o093Ny311Tm33y9W82zMhR0nr82T3vYnYWrc+iX/6n5Yupw49Z77+N5a0wzunVf1tH/+nBV2
        R0SJpTgj0VCLuag4EQAUQGQhPQMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrNIsWRmVeSWpSXmKPExsVy+t/xe7rXdtTGGSx+pGPRe+4kk8W0O7tZ
        Ldb9u8li0bizj8ni7X0g98rX92wWl3fNYXNg92i99JfNY+esu+we2789YPW4332cyePzJrkA
        1ig9m6L80pJUhYz84hJbpWhDCyM9Q0sLPSMTSz1DY/NYKyNTJX07m5TUnMyy1CJ9uwS9jN8n
        u9gLPilWXNns0sD4QqaLkZNDQsBE4tH7dYwgtpDAUkaJCe95IeIyEienNbBC2MISf651sXUx
        cgHVvGWUmL+5iQUkISzgKrGzqRWsmU3AUKLrLUgRJ4eIgJfEm5Ob2UEamAUmMUqcmrkVaBIH
        UHe+xIWfZiA1vAJ2Ej0zj4LVswioSkzZcYQZxBYViJH4uaeLBaJGUOLkzCdgNqeAvcTWSbfB
        djELmEnM2/yQGcKWl2jeOhvKFpe49WQ+0wRGoVlI2mchaZmFpGUWkpYFjCyrGEVSS4tz03OL
        DfWKE3OLS/PS9ZLzczcxAiNu27Gfm3cwXtoYfIhRgINRiYdXo6UmTog1say4MvcQowQHs5II
        79NIoBBvSmJlVWpRfnxRaU5q8SFGU6DnJjJLiSbnA5NBXkm8oamhuYWlobmxubGZhZI4b4fA
        wRghgfTEktTs1NSC1CKYPiYOTqkGRoVbGozijapWEu/NU083N383kF7yOUsgOfmjnvPbJW1b
        fNv7tI4Zql3unCH6NC+nrkxIaTHDuYlqb0oXhpssOtA4YeHZyzP3C701j4gur1x4miHdw9aE
        P0tcYKI/Z2OG+nz1S+quvO0svNU31M+da967JkN3mt/K56mZ75bO/a1RYbzv4wIjJZbijERD
        Leai4kQAXEY+Z84CAAA=
X-CMS-MailID: 20200327082702eucas1p1a66dd059480c9d02b8f0f3ab225db2c3
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20200327082702eucas1p1a66dd059480c9d02b8f0f3ab225db2c3
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20200327082702eucas1p1a66dd059480c9d02b8f0f3ab225db2c3
References: <20200325090741.21957-2-bigbeeshane@gmail.com>
        <4aef60ff-d9e4-d3d0-1a28-8c2dc3b94271@samsung.com>
        <CGME20200327082702eucas1p1a66dd059480c9d02b8f0f3ab225db2c3@eucas1p1.samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020-03-27 08:54, Marek Szyprowski wrote:
> On 2020-03-25 10:07, Shane Francis wrote:
>> As dma_map_sg can reorganize scatter-gather lists in a
>> way that can cause some later segments to be empty we should
>> always use the sg_dma_len macro to fetch the actual length.
>>
>> This could now be 0 and not need to be mapped to a page or
>> address array
>>
>> Signed-off-by: Shane Francis <bigbeeshane@gmail.com>
>> Reviewed-by: Michael J. Ruhl <michael.j.ruhl@intel.com>
> This patch landed in linux-next 20200326 and it causes a kernel panic 
> on various Exynos SoC based boards.
>> ---
>>   drivers/gpu/drm/drm_prime.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/gpu/drm/drm_prime.c b/drivers/gpu/drm/drm_prime.c
>> index 86d9b0e45c8c..1de2cde2277c 100644
>> --- a/drivers/gpu/drm/drm_prime.c
>> +++ b/drivers/gpu/drm/drm_prime.c
>> @@ -967,7 +967,7 @@ int drm_prime_sg_to_page_addr_arrays(struct 
>> sg_table *sgt, struct page **pages,
>>         index = 0;
>>       for_each_sg(sgt->sgl, sg, sgt->nents, count) {
>> -        len = sg->length;
>> +        len = sg_dma_len(sg);
>>           page = sg_page(sg);
>>           addr = sg_dma_address(sg);
>
> Sorry, but this code is wrong :(
>
> The scatterlist elements (sg) describes memory chunks in physical 
> memory and in the DMA (IO virtual) space. However in general, you 
> cannot assume 1:1 mapping between them. If you access sg_page(sg) 
> (basically sg->page), you must match it with sg->length. When you 
> access sg_dma_address(sg) (again, in most cases it is 
> sg->dma_address), then you must match it with sg_dma_len(sg). The 
> sg->dma_address might not be the dma address of the sg->page.
>
> In some cases (when IOMMU is available, it performs aggregation of the 
> scatterlist chunks and a few other, minor requirements), the whole 
> scatterlist might be mapped into contiguous DMA address space and 
> filled only to the first sg element.
>
> The proper way to iterate over a scatterlists to get both the pages 
> and the DMA addresses assigned to them is:
>
> int drm_prime_sg_to_page_addr_arrays(struct sg_table *sgt, struct page 
> **pages,
>                                      dma_addr_t *addrs, int max_entries)
> {
>         unsigned count;
>         struct scatterlist *sg;
>         struct page *page;
>         u32 page_len, page_index;
>         dma_addr_t addr;
>         u32 dma_len, dma_index;
>
>         page_index = 0;
>         dma_index = 0;
>         for_each_sg(sgt->sgl, sg, sgt->nents, count) {
>                 page_len = sg->length;
>                 page = sg_page(sg);
>                 dma_len = sg_dma_len(sg);
>                 addr = sg_dma_address(sg);
>
>                 while (pages && page_len > 0) {
>                         if (WARN_ON(page_index >= max_entries))
>                                 return -1;
>                         pages[page_index] = page;
>                         page++;
>                         page_len -= PAGE_SIZE;
>                         page_index++;
>                 }
>
>                 while (addrs && dma_len > 0) {
>                         if (WARN_ON(dma_index >= max_entries))
>                                 return -1;
>                         addrs[dma_index] = addr;
>                         addr += PAGE_SIZE;
>                         dma_len -= PAGE_SIZE;
>                         dma_index++;
>                 }
>         }
>
>         return 0;
> }
>
> I will send a patch in a few minutes with the above fixed code.

Here is the fix: https://patchwork.freedesktop.org/patch/359081/

Best regards
-- 
Marek Szyprowski, PhD
Samsung R&D Institute Poland

