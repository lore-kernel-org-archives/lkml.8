Return-Path: <SRS0=728o=CL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF8CFC433E2
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Sep 2020 08:01:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B933F2087D
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Sep 2020 08:01:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="uCptm6F4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726637AbgIBIBT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 2 Sep 2020 04:01:19 -0400
Received: from fllv0015.ext.ti.com ([198.47.19.141]:39896 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726140AbgIBIBR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Sep 2020 04:01:17 -0400
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 08280pA7094762;
        Wed, 2 Sep 2020 03:00:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1599033651;
        bh=1bOhg2Pozz6rcMj1+uMvlXBX35wWMkgjDScBHdgjrGA=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=uCptm6F4IhHx1+0CT2rnCmC7OxX+/Xm05UrEQJBqEw8tEOO0a9Z3QZHXHM/N4/wdh
         GWSpcQdbbxmEnnfKvTmTB2/ylM3AvQKsmTc4oMmLfpmi0juS7j1s8G8y8OO3bwH+FJ
         nOoQOPwT33Ba4fTsS1SdhZFBfOpEFTOu/BScnvwo=
Received: from DFLE113.ent.ti.com (dfle113.ent.ti.com [10.64.6.34])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 08280p0X077629
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 2 Sep 2020 03:00:51 -0500
Received: from DFLE103.ent.ti.com (10.64.6.24) by DFLE113.ent.ti.com
 (10.64.6.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Wed, 2 Sep
 2020 03:00:51 -0500
Received: from fllv0040.itg.ti.com (10.64.41.20) by DFLE103.ent.ti.com
 (10.64.6.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Wed, 2 Sep 2020 03:00:51 -0500
Received: from [192.168.2.6] (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 08280mFG008004;
        Wed, 2 Sep 2020 03:00:48 -0500
Subject: Re: [PATCH v9 14/32] drm: omapdrm: fix common struct sg_table related
 issues
To:     Robin Murphy <robin.murphy@arm.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        <dri-devel@lists.freedesktop.org>,
        <iommu@lists.linux-foundation.org>,
        <linaro-mm-sig@lists.linaro.org>, <linux-kernel@vger.kernel.org>
CC:     Christoph Hellwig <hch@lst.de>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        <linux-arm-kernel@lists.infradead.org>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>
References: <20200826063316.23486-1-m.szyprowski@samsung.com>
 <CGME20200826063536eucas1p2e29d2b061b8b74c06c9ea61ad6737ba2@eucas1p2.samsung.com>
 <20200826063316.23486-15-m.szyprowski@samsung.com>
 <7298cc55-c550-0b41-3f3c-8eebed845848@arm.com>
From:   Tomi Valkeinen <tomi.valkeinen@ti.com>
Message-ID: <e3f8d1d2-9c33-78be-56e6-ad214c7fb84c@ti.com>
Date:   Wed, 2 Sep 2020 11:00:47 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <7298cc55-c550-0b41-3f3c-8eebed845848@arm.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 01/09/2020 22:33, Robin Murphy wrote:
> On 2020-08-26 07:32, Marek Szyprowski wrote:
>> The Documentation/DMA-API-HOWTO.txt states that the dma_map_sg() function
>> returns the number of the created entries in the DMA address space.
>> However the subsequent calls to the dma_sync_sg_for_{device,cpu}() and
>> dma_unmap_sg must be called with the original number of the entries
>> passed to the dma_map_sg().
>>
>> struct sg_table is a common structure used for describing a non-contiguous
>> memory buffer, used commonly in the DRM and graphics subsystems. It
>> consists of a scatterlist with memory pages and DMA addresses (sgl entry),
>> as well as the number of scatterlist entries: CPU pages (orig_nents entry)
>> and DMA mapped pages (nents entry).
>>
>> It turned out that it was a common mistake to misuse nents and orig_nents
>> entries, calling DMA-mapping functions with a wrong number of entries or
>> ignoring the number of mapped entries returned by the dma_map_sg()
>> function.
>>
>> Fix the code to refer to proper nents or orig_nents entries. This driver
>> checks for a buffer contiguity in DMA address space, so it should test
>> sg_table->nents entry.
>>
>> Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
>> ---
>>   drivers/gpu/drm/omapdrm/omap_gem.c | 6 +++---
>>   1 file changed, 3 insertions(+), 3 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/omapdrm/omap_gem.c b/drivers/gpu/drm/omapdrm/omap_gem.c
>> index ff0c4b0c3fd0..a7a9a0afe2b6 100644
>> --- a/drivers/gpu/drm/omapdrm/omap_gem.c
>> +++ b/drivers/gpu/drm/omapdrm/omap_gem.c
>> @@ -48,7 +48,7 @@ struct omap_gem_object {
>>        *   OMAP_BO_MEM_DMA_API flag set)
>>        *
>>        * - buffers imported from dmabuf (with the OMAP_BO_MEM_DMABUF flag set)
>> -     *   if they are physically contiguous (when sgt->orig_nents == 1)
>> +     *   if they are physically contiguous (when sgt->nents == 1)
> 
> Hmm, if this really does mean *physically* contiguous - i.e. if buffers might be shared between
> DMA-translatable and non-DMA-translatable devices - then these changes might not be appropriate. If
> not and it only actually means DMA-contiguous, then it would be good to clarify the comments to that
> effect.
> 
> Can anyone familiar with omapdrm clarify what exactly the case is here? I know that IOMMUs might be
> involved to some degree, and I've skimmed the interconnect chapters of enough OMAP TRMs to be scared
> by the reference to the tiler aperture in the context below :)

DSS (like many other IPs in OMAP) does not have any MMU/PAT, and can only use contiguous buffers
(contiguous in the RAM).

There's a special case with TILER (which is not part of DSS but of the memory subsystem, but it's
still handled internally by the omapdrm driver), which has a PAT. PAT can create a contiguous view
of scattered pages, and DSS can then use this contiguous view ("tiler aperture", which to DSS looks
just like normal contiguous memory).

Note that omapdrm does not use dma_map_sg() & co. mentioned in the patch description.

If there's no MMU/PAT, is orig_nents always the same as nents? Or can we have multiple physically
contiguous pages listed separately in the sgt (so orig_nents > 1) but as the pages form one big
contiguous area, nents == 1?

 Tomi

-- 
Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
