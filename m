Return-Path: <SRS0=F+sq=6U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9382DC47254
	for <linux-kernel@archiver.kernel.org>; Wed,  6 May 2020 00:36:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 66E6520721
	for <linux-kernel@archiver.kernel.org>; Wed,  6 May 2020 00:36:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="B2S8YZ9Y"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729636AbgEFAgG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 May 2020 20:36:06 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:30500 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729159AbgEFAgG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 May 2020 20:36:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1588725364;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=r91Vkwfhs72eGh8CvePPOMPccAs5FlSl4oINL7pVMtM=;
        b=B2S8YZ9YpsJxk0dU1tuvqRWFLlvnG05snT+ctckM4l+S93opYg/vqogpXcU8bDR00995ic
        4ykSOwMxIsQgh6FfowCCKrPx9yuf3JeeC7nJt/I3DleiU+5VUZBehEsqu0z9vu1wG9uw9/
        7KJZfQaeXy9d+8y7NmPhab8ZI0T3MA8=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-42-KTib6Q1VPsGEJ_CoRZuPlg-1; Tue, 05 May 2020 20:36:02 -0400
X-MC-Unique: KTib6Q1VPsGEJ_CoRZuPlg-1
Received: by mail-wm1-f70.google.com with SMTP id j5so221564wmi.4
        for <linux-kernel@vger.kernel.org>; Tue, 05 May 2020 17:36:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=r91Vkwfhs72eGh8CvePPOMPccAs5FlSl4oINL7pVMtM=;
        b=d68TNCVmyHcNCpK3rYbaLgB/gIBBY7OtmFgUW7nzwNEjYHb1xamIy/g8F9XJ3fUxgZ
         CUCiKx+UMVNWdwn0GXocdoJncX4vlZRHcYTIj+nNI9dieeR9V9WFoFgxSXvB3hNLhRSK
         BfNbgiEuB476SVs7lc74W5Huax6LNLlxho511M7g0dvOXEJln8bLPu6Z+/EcZqMv2W+o
         nbNBQcqRAfmUjCoBeRkw5bVq38xDGj8oIsu0mB1164m+QmSG1ml0ZiI3SnW8ylMuHX+c
         ArgzGzvUPZ3wO8YeTHAFFhXg25wkE4U1EwI8voZ9oxk/Zio2Pieg2BSdMdJMxpiZYhwb
         1Mhg==
X-Gm-Message-State: AGi0PuZwLoSaPLo+HrX6yy0N22SxEP763GLPyeLYrdUzWOe3WtlT6tcm
        ez+bHPCbPnIsnZanz2jLGI/qTI5xRpGxV9V3M7vhU0L9gsOvPtotFzBgpDcFcOQuKD/3EQk6zOL
        4JG89gB0l3Q8xQrPRyrToaUvJ
X-Received: by 2002:a7b:c104:: with SMTP id w4mr1282106wmi.8.1588725361510;
        Tue, 05 May 2020 17:36:01 -0700 (PDT)
X-Google-Smtp-Source: APiQypJVVkRFF30e3828oYhwtuf5lvADu5CEQ19rZWzkiBLQtxSA06mataKgIXrW8PxWj1Hy8UMH4g==
X-Received: by 2002:a7b:c104:: with SMTP id w4mr1282093wmi.8.1588725361342;
        Tue, 05 May 2020 17:36:01 -0700 (PDT)
Received: from redhat.com (bzq-109-66-7-121.red.bezeqint.net. [109.66.7.121])
        by smtp.gmail.com with ESMTPSA id g186sm506141wme.7.2020.05.05.17.36.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 May 2020 17:36:00 -0700 (PDT)
Date:   Tue, 5 May 2020 20:35:58 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     YueHaibing <yuehaibing@huawei.com>
Cc:     jasowang@redhat.com, virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH -next] vdpasim: remove unused variable 'ret'
Message-ID: <20200505203544-mutt-send-email-mst@kernel.org>
References: <20200410115422.42308-1-yuehaibing@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200410115422.42308-1-yuehaibing@huawei.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 10, 2020 at 07:54:22PM +0800, YueHaibing wrote:
> drivers/vdpa/vdpa_sim/vdpa_sim.c:92:6: warning:
>  variable ‘ret’ set but not used [-Wunused-but-set-variable]
> 
> Signed-off-by: YueHaibing <yuehaibing@huawei.com>
> ---

Either this, or BUG_ON.  Jason?

>  drivers/vdpa/vdpa_sim/vdpa_sim.c | 15 +++++++--------
>  1 file changed, 7 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/vdpa/vdpa_sim/vdpa_sim.c b/drivers/vdpa/vdpa_sim/vdpa_sim.c
> index 7957d2d41fc4..01c456f7c1f7 100644
> --- a/drivers/vdpa/vdpa_sim/vdpa_sim.c
> +++ b/drivers/vdpa/vdpa_sim/vdpa_sim.c
> @@ -89,15 +89,14 @@ static struct vdpasim *dev_to_sim(struct device *dev)
>  static void vdpasim_queue_ready(struct vdpasim *vdpasim, unsigned int idx)
>  {
>  	struct vdpasim_virtqueue *vq = &vdpasim->vqs[idx];
> -	int ret;
>  
> -	ret = vringh_init_iotlb(&vq->vring, vdpasim_features,
> -				VDPASIM_QUEUE_MAX, false,
> -				(struct vring_desc *)(uintptr_t)vq->desc_addr,
> -				(struct vring_avail *)
> -				(uintptr_t)vq->driver_addr,
> -				(struct vring_used *)
> -				(uintptr_t)vq->device_addr);
> +	vringh_init_iotlb(&vq->vring, vdpasim_features,
> +			  VDPASIM_QUEUE_MAX, false,
> +			  (struct vring_desc *)(uintptr_t)vq->desc_addr,
> +			  (struct vring_avail *)
> +			  (uintptr_t)vq->driver_addr,
> +			  (struct vring_used *)
> +			  (uintptr_t)vq->device_addr);
>  }
>  
>  static void vdpasim_vq_reset(struct vdpasim_virtqueue *vq)
> -- 
> 2.17.1
> 

