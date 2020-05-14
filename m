Return-Path: <SRS0=2JZx=64=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0436AC433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 14 May 2020 09:35:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CA9DA20671
	for <linux-kernel@archiver.kernel.org>; Thu, 14 May 2020 09:35:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KS5DzupN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726142AbgENJff (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 May 2020 05:35:35 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:44529 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725935AbgENJfe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 May 2020 05:35:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1589448933;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=MxlYjlDzOriDYwrln025WxRAPDTwzmlMvS6Zl9QdE7k=;
        b=KS5DzupNtCB1opNdI+IOSUOFZcCOOewkpyE9afcqgDJdjVUBrrPl+dFrUH16Lxl1OL+TiC
        nzq8jtVmPe/4tvdjoM+xtU2/flVTlGKX8kIgAXJ67pm1AeeToF2T3kiWw1urGzbd45XAeq
        sedL5EbRGGgQQVpSEOsh67ukWHmklR8=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-110-PC41rDd6OaCkWRSpFrHmLQ-1; Thu, 14 May 2020 05:35:31 -0400
X-MC-Unique: PC41rDd6OaCkWRSpFrHmLQ-1
Received: by mail-wm1-f70.google.com with SMTP id h6so13198163wmi.7
        for <linux-kernel@vger.kernel.org>; Thu, 14 May 2020 02:35:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=MxlYjlDzOriDYwrln025WxRAPDTwzmlMvS6Zl9QdE7k=;
        b=jxnsA3t3GB1/XrtFFQZ+5nkccslN3hMZEvx7GMotDsyz+xm7VK6y/6ilGAkcNVSuhM
         8KLqHZaak7ZLytk0ihKflDm+Rif+unQrv7Q7U0ZTQaP2XRaFsrM1QV4g445c+lNavYUe
         DaE3dE0+BpHgDGMuPDGyUmu1RNnAWT0fWVtLot+4uVUvoi8jBG0IfSIII5owwl/sWXj/
         Lr+puWw7r5iPBqvioD8yA8I/VhhFADDZ3JqJ4It7GJXMj2sv4rdT18QWU029LTqRLcRu
         NXGmOoKPpmdASiRzLxctN5s204LAsCHPaQI4cE+jqDgtngSAkdbG6OMY5ujnJSEq6W/9
         mdxw==
X-Gm-Message-State: AOAM532WHq1tI5Kz9FMU4xxzH904ZOiQunoRty9lQxc5vTWYzGHoaXbB
        dXr8TjWKFz4ZcZJRMSjcDpxgyLetmfOZn9RNMHAJufHMcpXf6gwYvculYlUoXpH07aQnJgvjVF0
        tdAXgYmpKmeiWIENsLlGrmkcl
X-Received: by 2002:a05:6000:1241:: with SMTP id j1mr4448999wrx.42.1589448930114;
        Thu, 14 May 2020 02:35:30 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxKDl1RC/zcgEoqR2ytd9DBbtwExDt1svBWxxRRKPgfIhZSnBzZb6Xx0itJ9CusOfpzdLTyhg==
X-Received: by 2002:a05:6000:1241:: with SMTP id j1mr4448969wrx.42.1589448929833;
        Thu, 14 May 2020 02:35:29 -0700 (PDT)
Received: from redhat.com (bzq-79-179-68-225.red.bezeqint.net. [79.179.68.225])
        by smtp.gmail.com with ESMTPSA id z11sm3069653wrr.32.2020.05.14.02.35.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 May 2020 02:35:29 -0700 (PDT)
Date:   Thu, 14 May 2020 05:35:27 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Jason Wang <jasowang@redhat.com>
Cc:     virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] vdpa_sim: do not reset IOTLB during device reset
Message-ID: <20200514053233-mutt-send-email-mst@kernel.org>
References: <20200514072549.29694-1-jasowang@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200514072549.29694-1-jasowang@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 14, 2020 at 03:25:49PM +0800, Jason Wang wrote:
> We reset IOTLB during device reset this breaks the assumption that the
> mapping needs to be controlled via vDPA DMA ops explicitly in a
> incremental way. So the networking will be broken after e.g a guest
> reset.
> 
> Fix this by not resetting the IOTLB during device reset.
> 
> Signed-off-by: Jason Wang <jasowang@redhat.com>


That's a bit weird, and can be a security risk if state
leaks between security domains through this.
And there's 0 chance any hardware implementation can
keep the translations around across resets - there
is simply nowhere to keep them.

IMHO we need a different way to make this work, simulator
needs to look like a hardware device as much as possible.


> ---
>  drivers/vdpa/vdpa_sim/vdpa_sim.c | 2 --
>  1 file changed, 2 deletions(-)
> 
> diff --git a/drivers/vdpa/vdpa_sim/vdpa_sim.c b/drivers/vdpa/vdpa_sim/vdpa_sim.c
> index 7957d2d41fc4..cc5525743a25 100644
> --- a/drivers/vdpa/vdpa_sim/vdpa_sim.c
> +++ b/drivers/vdpa/vdpa_sim/vdpa_sim.c
> @@ -119,8 +119,6 @@ static void vdpasim_reset(struct vdpasim *vdpasim)
>  	for (i = 0; i < VDPASIM_VQ_NUM; i++)
>  		vdpasim_vq_reset(&vdpasim->vqs[i]);
>  
> -	vhost_iotlb_reset(vdpasim->iommu);
> -
>  	vdpasim->features = 0;
>  	vdpasim->status = 0;
>  	++vdpasim->generation;
> -- 
> 2.20.1

