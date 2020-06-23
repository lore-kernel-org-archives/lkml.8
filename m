Return-Path: <SRS0=AM+j=AE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 223DEC433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 00:51:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F36F020706
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 00:51:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="FjAEsgqZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732235AbgFWAvf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Jun 2020 20:51:35 -0400
Received: from hqnvemgate26.nvidia.com ([216.228.121.65]:18765 "EHLO
        hqnvemgate26.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731750AbgFWAve (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Jun 2020 20:51:34 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate26.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5ef152090000>; Mon, 22 Jun 2020 17:51:21 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Mon, 22 Jun 2020 17:51:34 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Mon, 22 Jun 2020 17:51:34 -0700
Received: from [10.2.59.206] (10.124.1.5) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Tue, 23 Jun
 2020 00:51:26 +0000
Subject: Re: [RESEND PATCH 1/3] nouveau: fix migrate page regression
To:     Ralph Campbell <rcampbell@nvidia.com>,
        <nouveau@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>
CC:     Jerome Glisse <jglisse@redhat.com>, Christoph Hellwig <hch@lst.de>,
        "Jason Gunthorpe" <jgg@mellanox.com>,
        Ben Skeggs <bskeggs@redhat.com>
References: <20200622233854.10889-1-rcampbell@nvidia.com>
 <20200622233854.10889-2-rcampbell@nvidia.com>
From:   John Hubbard <jhubbard@nvidia.com>
Message-ID: <53751f8e-d901-df2e-a2e0-1b1484b31b81@nvidia.com>
Date:   Mon, 22 Jun 2020 17:51:26 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <20200622233854.10889-2-rcampbell@nvidia.com>
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL105.nvidia.com (172.20.187.12) To
 HQMAIL107.nvidia.com (172.20.187.13)
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1592873481; bh=M5JpDj0By/NXP/evMyGItwbU3cOrKr1W3Gf6kJ1yhow=;
        h=X-PGP-Universal:Subject:To:CC:References:From:Message-ID:Date:
         User-Agent:MIME-Version:In-Reply-To:X-Originating-IP:
         X-ClientProxiedBy:Content-Type:Content-Language:
         Content-Transfer-Encoding;
        b=FjAEsgqZOHCD5Y2lJ3rJvBJxyTDAAT7f2T2k3awy8TT3tw62KkqIEfBAVdDk7X0ar
         S9zdWi7YdDIsMwxtqRzep7bFKp83t1o2SgpFzjUvqkVeBfRG+OzDeRIdCcnACQhzYK
         zmrntuXB+iqInv0bFRNBVrUZ7cM8pvDhm3liuq+RROLpo+cdLteh0+SVXWYoqnjNqq
         vjCr/EvEFNCNO3I9kLzBFP1be2wa+1UaXCU6izslR7s/gfanxexhEL/jQv7WS8VCXU
         lR8/fxc36R9kwQdJE/HJKQnJQ79XUVBiqMz8zcY+4DvD5VLEuL0QdQMf4U+9Ak9m0K
         wmFk/TWgZw4Tg==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020-06-22 16:38, Ralph Campbell wrote:
> The patch to add zero page migration to GPU memory inadvertantly included

inadvertently

> part of a future change which broke normal page migration to GPU memory
> by copying too much data and corrupting GPU memory.
> Fix this by only copying one page instead of a byte count.
> 
> Fixes: 9d4296a7d4b3 ("drm/nouveau/nouveau/hmm: fix migrate zero page to GPU")
> Signed-off-by: Ralph Campbell <rcampbell@nvidia.com>
> ---
>   drivers/gpu/drm/nouveau/nouveau_dmem.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/nouveau/nouveau_dmem.c b/drivers/gpu/drm/nouveau/nouveau_dmem.c
> index e5c230d9ae24..cc9993837508 100644
> --- a/drivers/gpu/drm/nouveau/nouveau_dmem.c
> +++ b/drivers/gpu/drm/nouveau/nouveau_dmem.c
> @@ -550,7 +550,7 @@ static unsigned long nouveau_dmem_migrate_copy_one(struct nouveau_drm *drm,
>   					 DMA_BIDIRECTIONAL);
>   		if (dma_mapping_error(dev, *dma_addr))
>   			goto out_free_page;
> -		if (drm->dmem->migrate.copy_func(drm, page_size(spage),
> +		if (drm->dmem->migrate.copy_func(drm, 1,
>   			NOUVEAU_APER_VRAM, paddr, NOUVEAU_APER_HOST, *dma_addr))
>   			goto out_dma_unmap;
>   	} else {
>


I Am Not A Nouveau Expert, nor is it really clear to me how
page_size(spage) came to contain something other than a page's worth of
byte count, but this fix looks accurate to me. It's better for
maintenance, too, because the function never intends to migrate "some
number of bytes". It intends to migrate exactly one page.

Hope I'm not missing something fundamental, but:

Reviewed-by: John Hubbard <jhubbard@nvidia.com


thanks,
-- 
John Hubbard
NVIDIA
