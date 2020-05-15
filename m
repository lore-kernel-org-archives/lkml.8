Return-Path: <SRS0=BsgQ=65=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74506C433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 15 May 2020 10:13:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4FC302073E
	for <linux-kernel@archiver.kernel.org>; Fri, 15 May 2020 10:13:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="U8Kfc/Di"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728287AbgEOKNy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 May 2020 06:13:54 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:53035 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727999AbgEOKNx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 May 2020 06:13:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1589537632;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=jyQOE3+SkaVkSO/7md1YvnjZQrQMGjMiOYyHXoqnMIo=;
        b=U8Kfc/DipQjc7ow4wXknFPEt+5Paz6C71kxQnekIxXaLXL6WaC4SCgaYGY+T5+jz6e7L3w
        wAbkerXv6qexFSPVCWKIRxsN8YpyHicccX7vEARd2EAlQ/TfVI1fB/9zq8ynq4jkCPIKFr
        NGpAAT9dUMiuwTQqfBRiEGqlz/UAN9Y=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-78-w3BMy0_SM1mEjilMgqtsgA-1; Fri, 15 May 2020 06:13:50 -0400
X-MC-Unique: w3BMy0_SM1mEjilMgqtsgA-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id DBF8A18FE863;
        Fri, 15 May 2020 10:13:48 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-115-145.ams2.redhat.com [10.36.115.145])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 7A9535F72E;
        Fri, 15 May 2020 10:13:48 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
        id 484C416E16; Fri, 15 May 2020 12:13:47 +0200 (CEST)
Date:   Fri, 15 May 2020 12:13:47 +0200
From:   Gerd Hoffmann <kraxel@redhat.com>
To:     Marek Szyprowski <m.szyprowski@samsung.com>
Cc:     dri-devel@lists.freedesktop.org, iommu@lists.linux-foundation.org,
        linaro-mm-sig@lists.linaro.org, linux-kernel@vger.kernel.org,
        Christoph Hellwig <hch@lst.de>,
        Robin Murphy <robin.murphy@arm.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        linux-arm-kernel@lists.infradead.org,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        linux-media@vger.kernel.org
Subject: Re: [PATCH v5 30/38] dmabuf: fix common struct sg_table related
 issues
Message-ID: <20200515101347.sbdiriypovujohkm@sirius.home.kraxel.org>
References: <20200513132114.6046-1-m.szyprowski@samsung.com>
 <20200513133245.6408-1-m.szyprowski@samsung.com>
 <CGME20200513133318eucas1p1dd6c1ac6a777874c115070d8b5197f34@eucas1p1.samsung.com>
 <20200513133245.6408-30-m.szyprowski@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200513133245.6408-30-m.szyprowski@samsung.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> diff --git a/drivers/dma-buf/udmabuf.c b/drivers/dma-buf/udmabuf.c
> index acb26c6..89e293b 100644
> --- a/drivers/dma-buf/udmabuf.c
> +++ b/drivers/dma-buf/udmabuf.c
> @@ -63,10 +63,9 @@ static struct sg_table *get_sg_table(struct device *dev, struct dma_buf *buf,
>  					GFP_KERNEL);
>  	if (ret < 0)
>  		goto err;
> -	if (!dma_map_sg(dev, sg->sgl, sg->nents, direction)) {
> -		ret = -EINVAL;
> +	ret = dma_map_sgtable(dev, sg, direction, 0);
> +	if (ret < 0)
>  		goto err;
> -	}
>  	return sg;
>  
>  err:
> @@ -78,7 +77,7 @@ static struct sg_table *get_sg_table(struct device *dev, struct dma_buf *buf,
>  static void put_sg_table(struct device *dev, struct sg_table *sg,
>  			 enum dma_data_direction direction)
>  {
> -	dma_unmap_sg(dev, sg->sgl, sg->nents, direction);
> +	dma_unmap_sgtable(dev, sg, direction, 0);
>  	sg_free_table(sg);
>  	kfree(sg);
>  }

Easy straightforward conversation.

Acked-by: Gerd Hoffmann <kraxel@redhat.com>

take care,
  Gerd

