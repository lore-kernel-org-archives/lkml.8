Return-Path: <SRS0=2gBQ=CN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF5C8C43461
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Sep 2020 12:06:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 91DD420791
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Sep 2020 12:06:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="YEaZg+6l"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730073AbgIDMGd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 4 Sep 2020 08:06:33 -0400
Received: from mailout2.w1.samsung.com ([210.118.77.12]:34920 "EHLO
        mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726171AbgIDMG0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Sep 2020 08:06:26 -0400
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20200904120624euoutp025e1cf19fd19e541c844f90fba3ebc74d~xkzGzPEC30249602496euoutp02I
        for <linux-kernel@vger.kernel.org>; Fri,  4 Sep 2020 12:06:24 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20200904120624euoutp025e1cf19fd19e541c844f90fba3ebc74d~xkzGzPEC30249602496euoutp02I
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1599221184;
        bh=Qccqpantv7098Ml50UgCDVb3Loq7kp7xS5fhoTvi36M=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=YEaZg+6l213lcAk7DJd8UCrcVPHaJN2zlFOMWO74+trcPWik7pu96yBc3o3RTQqml
         V0RR/7BouGuL07K5B7XEzuqP6RHFyKxzDAHx8OtwKhEGd6M4DtUHQgLPHfoW5TQu/3
         AhRmCEqcOpwJT1td6L7EjzM9Sx8whTdG5d7FwmM4=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20200904120623eucas1p175c50404f752feafabc1b8942433a493~xkzGacciI2432424324eucas1p1o;
        Fri,  4 Sep 2020 12:06:23 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges1new.samsung.com (EUCPMTA) with SMTP id 08.A3.06456.FBD225F5; Fri,  4
        Sep 2020 13:06:23 +0100 (BST)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20200904120623eucas1p1666abb8d389a9ceb81e94634244b51e8~xkzF53qTN1694916949eucas1p10;
        Fri,  4 Sep 2020 12:06:23 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20200904120623eusmtrp2a7eaad4ecb7497abdb5d6d8686dd8cbf~xkzF4olnt1972019720eusmtrp2y;
        Fri,  4 Sep 2020 12:06:23 +0000 (GMT)
X-AuditID: cbfec7f2-7efff70000001938-27-5f522dbf6e40
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id 60.22.06314.FBD225F5; Fri,  4
        Sep 2020 13:06:23 +0100 (BST)
Received: from [106.210.88.143] (unknown [106.210.88.143]) by
        eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20200904120622eusmtip1b95156e4bf33013e8f0d5c3aa0deeba2~xkzFQfLJX2905129051eusmtip1_;
        Fri,  4 Sep 2020 12:06:22 +0000 (GMT)
Subject: Re: [PATCH v9 14/32] drm: omapdrm: fix common struct sg_table
 related issues
To:     Tomi Valkeinen <tomi.valkeinen@ti.com>,
        Robin Murphy <robin.murphy@arm.com>,
        dri-devel@lists.freedesktop.org, iommu@lists.linux-foundation.org,
        linaro-mm-sig@lists.linaro.org, linux-kernel@vger.kernel.org
Cc:     Christoph Hellwig <hch@lst.de>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        linux-arm-kernel@lists.infradead.org,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>
From:   Marek Szyprowski <m.szyprowski@samsung.com>
Message-ID: <c3173e34-7d78-4f39-8a64-bbbd4814b3c0@samsung.com>
Date:   Fri, 4 Sep 2020 14:06:26 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
        Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <e3f8d1d2-9c33-78be-56e6-ad214c7fb84c@ti.com>
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Brightmail-Tracker: H4sIAAAAAAAAA01SfUhTcRTtt/e2vclmr1V66UNraVCRJkW8ssQi4v0V4T9BkOuVj81yJpua
        mqBklKmzUkSdlXON2tQcmaltlWTkXCuTtDFdH5paaYiiWfaB5vay/O/cc87lnAuXwKSf+CuI
        +MRkVp3IJMgEfnhj24+Xm1s2x8i3/LJuo7QdDh51p8zCp2Ybr2BU99SYgDLXPOVR+pZI6uIV
        o5D62t3Po+oHXHyqy3pVQD0eH+RTlspeQbSYrr1ei+iH3/Q4XZFbzqebvvXx6ff5dh5915hF
        e2YGMLrYfQvRtp5sAV3YUI1ou7uJR0/WBx0UH/bbFccmxKey6vCoo37K6rY+LKlzXdrUNTPK
        RoWr85CIAHIbOMe+CPOQHyElTQh6K0cxryAlvyJ4WZzJCZMIciafYPMbRq0L44RbCIa6unFu
        GENQ2GIQel1LyUOgvzPucy0jXQgeTdcKvANG/kaQXzCMvC4BGQF5o3kCL5aQUfC2d8LH42QI
        aF90+vjlZCy0PfuAc54l4Cgf9GERuROM5xw+P0YGQ869CozDgdA7WMnzhgF5kYCfZifiiu+D
        7pEHOIeXwoi9QcjhVTB7f34hB0F/x20hNxQg6Dpb9nc7Et50/JyrRMxFbACLNZyj94DBXiX0
        0kD6g3t0CVfCH4oaSzGOlkDueSnnXg86e92/2Medr7DLSKZbcJpuwTm6Befo/ufqEV6NAtkU
        jUrBaiIS2dNhGkalSUlUhB0/papHc+/nnLFPNKOpV8daEUkgmVjiHjsol/KZVE26qhUBgcmW
        Sfa+cMZKJXFMegarPiVXpySwmla0ksBlgZKthuEjUlLBJLMnWTaJVc+rPEK0IhvxemrfVTXt
        dg2pS6ZvZ9lNO5h1ARNn22PkHzOedwa7HCVpJncoowwpP/H99Sbh5WDbvciYA3HRnu03RZmX
        YtudjqLDyZ7KZu2aG56Co3bzBVtN/K7pc2U7v1jrihpEoWszpixo+5nzdYqhgP0m2ydlqnhx
        aWEaHjKwSDT7ucAQJMM1SiZiI6bWMH8Aykz8TXoDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrFIsWRmVeSWpSXmKPExsVy+t/xu7r7dYPiDQ5uErLoPXeSyWLjjPWs
        Fv+3TWS2uPL1PZvFytVHmSwW7Le26Jy4hN3iy5WHTBabHl9jtbi8aw6bxcEPT1gt1s+/xebA
        47Fm3hpGj73fFrB4zO6Yyeqx/dsDVo/73ceZPDYvqfe4/e8xs8fkG8sZPXbfbGDz6NuyitHj
        +I3tTB6fN8kF8ETp2RTll5akKmTkF5fYKkUbWhjpGVpa6BmZWOoZGpvHWhmZKunb2aSk5mSW
        pRbp2yXoZaw69oC54IJyxde5KxkbGPtkuxg5OSQETCSW9F5j7mLk4hASWMoosa/lFTtEQkbi
        5LQGVghbWOLPtS42iKK3jBK3j39mBkkIC4RLHJ4yHaxbROAao0TjmxdgVcwC/xglXs2/wgrR
        spxJ4ue3jYwgLWwChhJdb0FmcXLwCthJ3L31CSzOIqAi0Xv2AlhcVCBO4kzPC6gaQYmTM5+w
        gNicAlYSS1pOgtUzC5hJzNv8kBnClpdo3jobyhaXuPVkPtMERqFZSNpnIWmZhaRlFpKWBYws
        qxhFUkuLc9Nziw31ihNzi0vz0vWS83M3MQLjfduxn5t3MF7aGHyIUYCDUYmH98b7gHgh1sSy
        4srcQ4wSHMxKIrxOZ0/HCfGmJFZWpRblxxeV5qQWH2I0BXpuIrOUaHI+MBXllcQbmhqaW1ga
        mhubG5tZKInzdggcjBESSE8sSc1OTS1ILYLpY+LglGpg1Kmp6z/cUOmV5MzO+lclc499ReFK
        EYkDS/5tz5sjwDH7/Z45b/1SzOd5JgYGzNwbKNfKXfj0TtU9jTeFdjdf9nziYpR5vd/2y8r/
        cyV1wzzM6uYatk0UXedwfmoM25eyP9vFjxutnvFB4cCLXK/nuVOKPj4/l+L6U2Pj7zPNc077
        bssJ+LX2oBJLcUaioRZzUXEiADp1tTkNAwAA
X-CMS-MailID: 20200904120623eucas1p1666abb8d389a9ceb81e94634244b51e8
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20200826063536eucas1p2e29d2b061b8b74c06c9ea61ad6737ba2
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20200826063536eucas1p2e29d2b061b8b74c06c9ea61ad6737ba2
References: <20200826063316.23486-1-m.szyprowski@samsung.com>
        <CGME20200826063536eucas1p2e29d2b061b8b74c06c9ea61ad6737ba2@eucas1p2.samsung.com>
        <20200826063316.23486-15-m.szyprowski@samsung.com>
        <7298cc55-c550-0b41-3f3c-8eebed845848@arm.com>
        <e3f8d1d2-9c33-78be-56e6-ad214c7fb84c@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Tomi,

On 02.09.2020 10:00, Tomi Valkeinen wrote:
> On 01/09/2020 22:33, Robin Murphy wrote:
>> On 2020-08-26 07:32, Marek Szyprowski wrote:
>>> The Documentation/DMA-API-HOWTO.txt states that the dma_map_sg() function
>>> returns the number of the created entries in the DMA address space.
>>> However the subsequent calls to the dma_sync_sg_for_{device,cpu}() and
>>> dma_unmap_sg must be called with the original number of the entries
>>> passed to the dma_map_sg().
>>>
>>> struct sg_table is a common structure used for describing a non-contiguous
>>> memory buffer, used commonly in the DRM and graphics subsystems. It
>>> consists of a scatterlist with memory pages and DMA addresses (sgl entry),
>>> as well as the number of scatterlist entries: CPU pages (orig_nents entry)
>>> and DMA mapped pages (nents entry).
>>>
>>> It turned out that it was a common mistake to misuse nents and orig_nents
>>> entries, calling DMA-mapping functions with a wrong number of entries or
>>> ignoring the number of mapped entries returned by the dma_map_sg()
>>> function.
>>>
>>> Fix the code to refer to proper nents or orig_nents entries. This driver
>>> checks for a buffer contiguity in DMA address space, so it should test
>>> sg_table->nents entry.
>>>
>>> Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
>>> ---
>>>    drivers/gpu/drm/omapdrm/omap_gem.c | 6 +++---
>>>    1 file changed, 3 insertions(+), 3 deletions(-)
>>>
>>> diff --git a/drivers/gpu/drm/omapdrm/omap_gem.c b/drivers/gpu/drm/omapdrm/omap_gem.c
>>> index ff0c4b0c3fd0..a7a9a0afe2b6 100644
>>> --- a/drivers/gpu/drm/omapdrm/omap_gem.c
>>> +++ b/drivers/gpu/drm/omapdrm/omap_gem.c
>>> @@ -48,7 +48,7 @@ struct omap_gem_object {
>>>         *   OMAP_BO_MEM_DMA_API flag set)
>>>         *
>>>         * - buffers imported from dmabuf (with the OMAP_BO_MEM_DMABUF flag set)
>>> -     *   if they are physically contiguous (when sgt->orig_nents == 1)
>>> +     *   if they are physically contiguous (when sgt->nents == 1)
>> Hmm, if this really does mean *physically* contiguous - i.e. if buffers might be shared between
>> DMA-translatable and non-DMA-translatable devices - then these changes might not be appropriate. If
>> not and it only actually means DMA-contiguous, then it would be good to clarify the comments to that
>> effect.
>>
>> Can anyone familiar with omapdrm clarify what exactly the case is here? I know that IOMMUs might be
>> involved to some degree, and I've skimmed the interconnect chapters of enough OMAP TRMs to be scared
>> by the reference to the tiler aperture in the context below :)
> DSS (like many other IPs in OMAP) does not have any MMU/PAT, and can only use contiguous buffers
> (contiguous in the RAM).
>
> There's a special case with TILER (which is not part of DSS but of the memory subsystem, but it's
> still handled internally by the omapdrm driver), which has a PAT. PAT can create a contiguous view
> of scattered pages, and DSS can then use this contiguous view ("tiler aperture", which to DSS looks
> just like normal contiguous memory).
>
> Note that omapdrm does not use dma_map_sg() & co. mentioned in the patch description.
>
> If there's no MMU/PAT, is orig_nents always the same as nents? Or can we have multiple physically
> contiguous pages listed separately in the sgt (so orig_nents > 1) but as the pages form one big
> contiguous area, nents == 1?

Well, when DMA-mapping API is properly used, the difference between 
nents and orig_nents is only when the scatterlist have been mapped for DMA.

For the mentioned case, even if the creator of the buffer used only the 
pages that are consecutive in the physical memory, he is free to chose 
either to set nents/orig_nents to 1 and length to n*PAGE_SIZE or set 
nents/orig_nents to n and length to PAGE_SIZE for each. Then the buffer 
chunks might be merged, but this is done by the DMA-mapping code. For 
your case, without any call to DMA-mapping, you can only assume that the 
buffer is contiguous in physical memory if orig_nents is 1.

I've changed the use of nents to orig_nents to make things consistent - 
this code operates only on the unmapped buffers. I want to ensure that 
anyone who will potentially copy this code, won't make the 
nents/orig_nents mistake in the future.

If you don't like it, we can drop this patch, because it won't change 
the way the driver works.

Best regards
-- 
Marek Szyprowski, PhD
Samsung R&D Institute Poland

