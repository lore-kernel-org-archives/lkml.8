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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0AF92C433E2
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Sep 2020 12:27:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B26B52084D
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Sep 2020 12:27:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="aUJ6JE3G"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730136AbgIDM1i (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 4 Sep 2020 08:27:38 -0400
Received: from mailout1.w1.samsung.com ([210.118.77.11]:44302 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728588AbgIDM1f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Sep 2020 08:27:35 -0400
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20200904122732euoutp01209a1105488aebd6d5bf8cdfc1d3c868~xlFkQ_l8X1327913279euoutp01f
        for <linux-kernel@vger.kernel.org>; Fri,  4 Sep 2020 12:27:32 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20200904122732euoutp01209a1105488aebd6d5bf8cdfc1d3c868~xlFkQ_l8X1327913279euoutp01f
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1599222452;
        bh=tdB0xJYiSpTmY+yS8kf5mZPVCvh6k64z90bTTJ9+2Gk=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=aUJ6JE3GbU0LDfw0Vh8NL0zJuGUp/Gkb4ZDoqZUX9Yg4y6kGKm2gxi7pprcFHdQ3E
         VUeyYRCEsOdGQCjGK6H1aaaebobPbVB3eR5f8eBULMhlg1VlyA6qxHPjP3+8vXQ6GA
         lZxgWhZbYRo0XRXonOE8CE+njCasnNWGLdUWmD9s=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20200904122732eucas1p115d52aac35c0031ffd76584c3c87a8ad~xlFjlRYKd2359523595eucas1p1w;
        Fri,  4 Sep 2020 12:27:32 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges2new.samsung.com (EUCPMTA) with SMTP id 3C.2C.05997.4B2325F5; Fri,  4
        Sep 2020 13:27:32 +0100 (BST)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20200904122731eucas1p180b68e5a1dc7e6e7de9013f74fdc12f5~xlFjQyAY42360023600eucas1p16;
        Fri,  4 Sep 2020 12:27:31 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20200904122731eusmtrp26ac2db7190b441c18107c680224dc581~xlFjQC1mH3222832228eusmtrp2u;
        Fri,  4 Sep 2020 12:27:31 +0000 (GMT)
X-AuditID: cbfec7f4-65dff7000000176d-96-5f5232b4e408
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id 5E.F4.06314.3B2325F5; Fri,  4
        Sep 2020 13:27:31 +0100 (BST)
Received: from [106.210.88.143] (unknown [106.210.88.143]) by
        eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20200904122731eusmtip225af98693c912cb6279e2dbb2e3a764f~xlFioM5OW1419314193eusmtip2E;
        Fri,  4 Sep 2020 12:27:31 +0000 (GMT)
Subject: Re: [PATCH v9 14/32] drm: omapdrm: fix common struct sg_table
 related issues
From:   Marek Szyprowski <m.szyprowski@samsung.com>
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
Message-ID: <ee9f6526-3050-9624-f9ba-e39bacceb19e@samsung.com>
Date:   Fri, 4 Sep 2020 14:27:35 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
        Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <c3173e34-7d78-4f39-8a64-bbbd4814b3c0@samsung.com>
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Brightmail-Tracker: H4sIAAAAAAAAA01Se0hTcRjtt3t3d6fO7mblh0nBCKMo0+qPS4pp+MeFCCSil/i45U2tbdqm
        mUEpTUqnPSwsnT3MLLWWSzMfk16rHDYalhrLijIlLVqLnGYxMrer5X/nnO8cvvPBR2KyEWEQ
        ma7K4tQqViEnfPCWzl+2lc2rNyeF1VvF9Albl4BuLDcK6cmWUozuHXMSdP3NpwK66kEEXVRa
        I6JdvQMCumnwlZDuMV0g6Effh4S08XI/Ee3HGC4ZEHNvvApnKgsrhEzr+Ach877YImDu1OQx
        b/4MYsxZey1iOl7nE8zJ5huIsdhbBcxo06I4v50+kSmcIv0Ap14VleyTVjrkRJk3Qw6O3m/C
        8lHBYh0Sk0CthdtXT2E65EPKqDoE7uE+EU9cCN46rkxPRhG8u+7EZiI9xy/i/KAWwe1rIwKe
        OBGU/azBPa4AahtUNX73JggqHHQOHeExzaNeIbg/YfASjHIjKC75jDwuCRUFxZXnRB6MU0vg
        m7nOq8+nEqHz2Uec90ihq2LIi8XUenBXPiE8GKMWg/ZuJcbjQOgfuuytBFQRCRPdfdPFY+F3
        RRHB4wD4YmkW8TgYJttnAloEA7ZbIp6UIOg5Wo54VwS8tf2eSpNTK5aB0bSKl2Og2nJF5JGB
        8ge7Q8qX8IczLecxXpZA4TEZ7w4BvaXh39pH3S+x00iun3WaftY5+lnn6P/vrUL4DRTIZWuU
        qZxmtYrLCdWwSk22KjV0d4ayCU39n/WPxdWGTO5dZkSRSO4nsTvjkmRC9oAmV2lGQGLyeZIN
        z62JMkkKm3uIU2ckqbMVnMaMFpK4PFCypvpzgoxKZbO4fRyXyalnpgJSHJSPEgo2bm9XfYuP
        aXGQbgO7JSdSq+ivy1zXmBESnfhpbLjMKO3O6NrqziksWPiwd/+KTdIg7eGsbWWRMZac6OFy
        l3/omPZFfIT43FJrpqlPujdK9bgtWKhsc7hdhxUPLHMXrJXt2nHXt+JrrK9uMm/P7jnJp9Js
        Rxo68n6k14f5xmFyXJPGhi/H1Br2L6jrpoF7AwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrFIsWRmVeSWpSXmKPExsVy+t/xe7qbjYLiDea2Gln0njvJZLFxxnpW
        i//bJjJbXPn6ns1i5eqjTBYL9ltbdE5cwm7x5cpDJotNj6+xWlzeNYfN4uCHJ6wW6+ffYnPg
        8Vgzbw2jx95vC1g8ZnfMZPXY/u0Bq8f97uNMHpuX1Hvc/veY2WPyjeWMHrtvNrB59G1Zxehx
        /MZ2Jo/Pm+QCeKL0bIryS0tSFTLyi0tslaINLYz0DC0t9IxMLPUMjc1jrYxMlfTtbFJSczLL
        Uov07RL0MiY+ec9YsFqt4vO+TcwNjC3yXYycHBICJhKX2+eydDFycQgJLGWUmL+7mRUiISNx
        cloDlC0s8edaFxtE0VtGiVsvFrCBJIQFwiUOT5nODGKzCRhKdL2FKBIRuMYo0fjmBZjDLPCP
        UeLV/CusEO13mCR+HL3FAtLCK2An0T17GjuIzSKgIvHu0ApGEFtUIE7iTM8LNogaQYmTM5+A
        1XMK2Ev8mX0ELM4sYCYxb/NDZghbXqJ562woW1zi1pP5TBMYhWYhaZ+FpGUWkpZZSFoWMLKs
        YhRJLS3OTc8tNtQrTswtLs1L10vOz93ECIz3bcd+bt7BeGlj8CFGAQ5GJR7eG+8D4oVYE8uK
        K3MPMUpwMCuJ8DqdPR0nxJuSWFmVWpQfX1Sak1p8iNEU6LmJzFKiyfnAVJRXEm9oamhuYWlo
        bmxubGahJM7bIXAwRkggPbEkNTs1tSC1CKaPiYNTqoHR33C50JXvMd0NFy3aj+zsDjAr31l9
        2SrhCqNK04STM9MLEmMye3/Lsx9c8F/1sW/fsxumf0JD9c60swYqMC7lq3iV6NF9W6lvCs/e
        +x/mX83hbGHycl0kEp0fyWtWuUl0r+x1NW7uMHN5tRyjnhkMF/edNVXfVrLAenOY8Od/N5N2
        VL6Mj1BiKc5INNRiLipOBACo0QHODQMAAA==
X-CMS-MailID: 20200904122731eucas1p180b68e5a1dc7e6e7de9013f74fdc12f5
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
        <c3173e34-7d78-4f39-8a64-bbbd4814b3c0@samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi again,

On 04.09.2020 14:06, Marek Szyprowski wrote:
> Hi Tomi,
>
> On 02.09.2020 10:00, Tomi Valkeinen wrote:
>> On 01/09/2020 22:33, Robin Murphy wrote:
>>> On 2020-08-26 07:32, Marek Szyprowski wrote:
>>>> The Documentation/DMA-API-HOWTO.txt states that the dma_map_sg() 
>>>> function
>>>> returns the number of the created entries in the DMA address space.
>>>> However the subsequent calls to the dma_sync_sg_for_{device,cpu}() and
>>>> dma_unmap_sg must be called with the original number of the entries
>>>> passed to the dma_map_sg().
>>>>
>>>> struct sg_table is a common structure used for describing a 
>>>> non-contiguous
>>>> memory buffer, used commonly in the DRM and graphics subsystems. It
>>>> consists of a scatterlist with memory pages and DMA addresses (sgl 
>>>> entry),
>>>> as well as the number of scatterlist entries: CPU pages (orig_nents 
>>>> entry)
>>>> and DMA mapped pages (nents entry).
>>>>
>>>> It turned out that it was a common mistake to misuse nents and 
>>>> orig_nents
>>>> entries, calling DMA-mapping functions with a wrong number of 
>>>> entries or
>>>> ignoring the number of mapped entries returned by the dma_map_sg()
>>>> function.
>>>>
>>>> Fix the code to refer to proper nents or orig_nents entries. This 
>>>> driver
>>>> checks for a buffer contiguity in DMA address space, so it should test
>>>> sg_table->nents entry.
>>>>
>>>> Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
>>>> ---
>>>>    drivers/gpu/drm/omapdrm/omap_gem.c | 6 +++---
>>>>    1 file changed, 3 insertions(+), 3 deletions(-)
>>>>
>>>> diff --git a/drivers/gpu/drm/omapdrm/omap_gem.c 
>>>> b/drivers/gpu/drm/omapdrm/omap_gem.c
>>>> index ff0c4b0c3fd0..a7a9a0afe2b6 100644
>>>> --- a/drivers/gpu/drm/omapdrm/omap_gem.c
>>>> +++ b/drivers/gpu/drm/omapdrm/omap_gem.c
>>>> @@ -48,7 +48,7 @@ struct omap_gem_object {
>>>>         *   OMAP_BO_MEM_DMA_API flag set)
>>>>         *
>>>>         * - buffers imported from dmabuf (with the 
>>>> OMAP_BO_MEM_DMABUF flag set)
>>>> -     *   if they are physically contiguous (when sgt->orig_nents 
>>>> == 1)
>>>> +     *   if they are physically contiguous (when sgt->nents == 1)
>>> Hmm, if this really does mean *physically* contiguous - i.e. if 
>>> buffers might be shared between
>>> DMA-translatable and non-DMA-translatable devices - then these 
>>> changes might not be appropriate. If
>>> not and it only actually means DMA-contiguous, then it would be good 
>>> to clarify the comments to that
>>> effect.
>>>
>>> Can anyone familiar with omapdrm clarify what exactly the case is 
>>> here? I know that IOMMUs might be
>>> involved to some degree, and I've skimmed the interconnect chapters 
>>> of enough OMAP TRMs to be scared
>>> by the reference to the tiler aperture in the context below :)
>> DSS (like many other IPs in OMAP) does not have any MMU/PAT, and can 
>> only use contiguous buffers
>> (contiguous in the RAM).
>>
>> There's a special case with TILER (which is not part of DSS but of 
>> the memory subsystem, but it's
>> still handled internally by the omapdrm driver), which has a PAT. PAT 
>> can create a contiguous view
>> of scattered pages, and DSS can then use this contiguous view ("tiler 
>> aperture", which to DSS looks
>> just like normal contiguous memory).
>>
>> Note that omapdrm does not use dma_map_sg() & co. mentioned in the 
>> patch description.
>>
>> If there's no MMU/PAT, is orig_nents always the same as nents? Or can 
>> we have multiple physically
>> contiguous pages listed separately in the sgt (so orig_nents > 1) but 
>> as the pages form one big
>> contiguous area, nents == 1?
>
> Well, when DMA-mapping API is properly used, the difference between 
> nents and orig_nents is only when the scatterlist have been mapped for 
> DMA.
>
> For the mentioned case, even if the creator of the buffer used only 
> the pages that are consecutive in the physical memory, he is free to 
> chose either to set nents/orig_nents to 1 and length to n*PAGE_SIZE or 
> set nents/orig_nents to n and length to PAGE_SIZE for each. Then the 
> buffer chunks might be merged, but this is done by the DMA-mapping 
> code. For your case, without any call to DMA-mapping, you can only 
> assume that the buffer is contiguous in physical memory if orig_nents 
> is 1.
>
> I've changed the use of nents to orig_nents to make things consistent 
> - this code operates only on the unmapped buffers. I want to ensure 
> that anyone who will potentially copy this code, won't make the 
> nents/orig_nents mistake in the future.

I've just noticed that I've read my patch (the diff) in the reverse 
order, I'm sorry. The omapdrm code is right, this patch should be dropped.

Best regards
-- 
Marek Szyprowski, PhD
Samsung R&D Institute Poland

