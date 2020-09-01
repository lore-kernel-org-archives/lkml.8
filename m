Return-Path: <SRS0=b2Mh=CK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50328C433E2
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Sep 2020 20:15:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3C3472078B
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Sep 2020 20:15:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728893AbgIAUPU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 1 Sep 2020 16:15:20 -0400
Received: from foss.arm.com ([217.140.110.172]:49554 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727103AbgIAUPO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Sep 2020 16:15:14 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0E2BE1063;
        Tue,  1 Sep 2020 13:15:14 -0700 (PDT)
Received: from [10.57.40.122] (unknown [10.57.40.122])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 5F1043F66F;
        Tue,  1 Sep 2020 13:15:11 -0700 (PDT)
Subject: Re: [PATCH v9 29/32] rapidio: fix common struct sg_table related
 issues
To:     Marek Szyprowski <m.szyprowski@samsung.com>,
        dri-devel@lists.freedesktop.org, iommu@lists.linux-foundation.org,
        linaro-mm-sig@lists.linaro.org, linux-kernel@vger.kernel.org
Cc:     Christoph Hellwig <hch@lst.de>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        linux-arm-kernel@lists.infradead.org,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Matt Porter <mporter@kernel.crashing.org>,
        Alexandre Bounine <alex.bou9@gmail.com>
References: <20200826063316.23486-1-m.szyprowski@samsung.com>
 <CGME20200826063545eucas1p22eb2c7a643a299f3e1696b4c5bae0694@eucas1p2.samsung.com>
 <20200826063316.23486-30-m.szyprowski@samsung.com>
From:   Robin Murphy <robin.murphy@arm.com>
Message-ID: <5beb988a-099b-1247-b3d5-257de44b9ab5@arm.com>
Date:   Tue, 1 Sep 2020 21:15:10 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <20200826063316.23486-30-m.szyprowski@samsung.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020-08-26 07:33, Marek Szyprowski wrote:
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

Reviewed-by: Robin Murphy <robin.murphy@arm.com>

> Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
> ---
>   drivers/rapidio/devices/rio_mport_cdev.c | 11 ++++-------
>   1 file changed, 4 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/rapidio/devices/rio_mport_cdev.c b/drivers/rapidio/devices/rio_mport_cdev.c
> index a30342942e26..89eb3d212652 100644
> --- a/drivers/rapidio/devices/rio_mport_cdev.c
> +++ b/drivers/rapidio/devices/rio_mport_cdev.c
> @@ -573,8 +573,7 @@ static void dma_req_free(struct kref *ref)
>   			refcount);
>   	struct mport_cdev_priv *priv = req->priv;
>   
> -	dma_unmap_sg(req->dmach->device->dev,
> -		     req->sgt.sgl, req->sgt.nents, req->dir);
> +	dma_unmap_sgtable(req->dmach->device->dev, &req->sgt, req->dir, 0);
>   	sg_free_table(&req->sgt);
>   	if (req->page_list) {
>   		unpin_user_pages(req->page_list, req->nr_pages);
> @@ -814,7 +813,6 @@ rio_dma_transfer(struct file *filp, u32 transfer_mode,
>   	struct mport_dev *md = priv->md;
>   	struct dma_chan *chan;
>   	int ret;
> -	int nents;
>   
>   	if (xfer->length == 0)
>   		return -EINVAL;
> @@ -930,15 +928,14 @@ rio_dma_transfer(struct file *filp, u32 transfer_mode,
>   				xfer->offset, xfer->length);
>   	}
>   
> -	nents = dma_map_sg(chan->device->dev,
> -			   req->sgt.sgl, req->sgt.nents, dir);
> -	if (nents == 0) {
> +	ret = dma_map_sgtable(chan->device->dev, &req->sgt, dir, 0);
> +	if (ret) {
>   		rmcd_error("Failed to map SG list");
>   		ret = -EFAULT;
>   		goto err_pg;
>   	}
>   
> -	ret = do_dma_request(req, xfer, sync, nents);
> +	ret = do_dma_request(req, xfer, sync, req->sgt.nents);
>   
>   	if (ret >= 0) {
>   		if (sync == RIO_TRANSFER_ASYNC)
> 
