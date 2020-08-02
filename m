Return-Path: <SRS0=HA/2=BM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D240EC433DF
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Aug 2020 06:26:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A8D1E2076B
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Aug 2020 06:26:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="N/4hoMMp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726398AbgHBG0Y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 2 Aug 2020 02:26:24 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:40987 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726086AbgHBG0X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Aug 2020 02:26:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1596349582;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=qtRwpw8KaYzbjOwsQk1RkKr/x7ohfyLS11IO8SCvDmU=;
        b=N/4hoMMpDntozC/YLWPXOkpRUJTYUKEOJOp9DZItDedN2u1EpEtfaEYBm4bC6/s0TBBcVD
        nTMkoDusDNtI/qv6r3OV+uodw5ztcGQtgRwFck28rcLF3tKw/KO1y+nXx+NH8wVzinVpNH
        55GlVNjbqvAalZhM7s/aErU6mt+ffJw=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-407-hDRp6D5HPTC2_LWrmqykQg-1; Sun, 02 Aug 2020 02:26:20 -0400
X-MC-Unique: hDRp6D5HPTC2_LWrmqykQg-1
Received: by mail-wr1-f72.google.com with SMTP id e14so6862687wrr.7
        for <linux-kernel@vger.kernel.org>; Sat, 01 Aug 2020 23:26:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=qtRwpw8KaYzbjOwsQk1RkKr/x7ohfyLS11IO8SCvDmU=;
        b=JbkVGo8P0gL/9j7KAmLw6wHxhXzh3Rf6f6PkfYPg2n+ZvnqURLXTMmOZvK/IUAKwbe
         ue5bBmXC2FEiL7uAGyKjN8wuNm6t24J1YmebfIF0VkTe3EoptggwZ84NGQzfOyfRew+5
         4gnv4Vf/7XUbpuENk2uu1E1VMZMt64DNTj7yQlzNPTPSpNbpKFnNqzlNz+NIb0B7ngKr
         9tynrs08hjZJa+JIMDjbjndLygJh49QntukpmUXsD5BCevoiRjiQoMs3qjmRKhu04QBh
         VV6Pbs5KaogJH3CuKKqDTufYKl6r97NjGi9yF/j6ITVp5H1KP1rfZ0ZODy0AK4it/1BU
         lxCg==
X-Gm-Message-State: AOAM530EsV21WM857MnAGzR7zW2NSzFZj6StXkVMxY7TSws6EDnWoBiK
        /8QCoyeIIkw+WxoECQBaTg1DNPXr8blmH4RsetLMM2vaq9SobLpz+2xQZbo/oZuaiN/tX80DaDb
        iYpXilppU2D0kiddfrpH4YQgY
X-Received: by 2002:a7b:ca5a:: with SMTP id m26mr10442559wml.27.1596349579713;
        Sat, 01 Aug 2020 23:26:19 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzvAvq/rmcOFNmC2cQwRvUGwvvyAevu+DIBOVOyEZmkvs+orMCEXN40U/UCKI6wBOhbPYCqoA==
X-Received: by 2002:a7b:ca5a:: with SMTP id m26mr10442550wml.27.1596349579514;
        Sat, 01 Aug 2020 23:26:19 -0700 (PDT)
Received: from redhat.com (bzq-79-179-105-63.red.bezeqint.net. [79.179.105.63])
        by smtp.gmail.com with ESMTPSA id 65sm20037688wre.6.2020.08.01.23.26.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 01 Aug 2020 23:26:18 -0700 (PDT)
Date:   Sun, 2 Aug 2020 02:26:16 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Mao Wenan <wenan.mao@linux.alibaba.com>
Cc:     jasowang@redhat.com, virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: Re: [PATCH -next v2] virtio_net: Avoid loop in virtnet_poll
Message-ID: <20200802022549-mutt-send-email-mst@kernel.org>
References: <20200802003818-mutt-send-email-mst@kernel.org>
 <1596347793-55894-1-git-send-email-wenan.mao@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1596347793-55894-1-git-send-email-wenan.mao@linux.alibaba.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Just noticed the subject is wrong: this is no longer
a virtio_net patch.

On Sun, Aug 02, 2020 at 01:56:33PM +0800, Mao Wenan wrote:
> The loop may exist if vq->broken is true,
> virtqueue_get_buf_ctx_packed or virtqueue_get_buf_ctx_split
> will return NULL, so virtnet_poll will reschedule napi to
> receive packet, it will lead cpu usage(si) to 100%.
> 
> call trace as below:
> virtnet_poll
> 	virtnet_receive
> 		virtqueue_get_buf_ctx
> 			virtqueue_get_buf_ctx_packed
> 			virtqueue_get_buf_ctx_split
> 	virtqueue_napi_complete
> 		virtqueue_poll           //return true
> 		virtqueue_napi_schedule //it will reschedule napi
> 
> To fix this, return false if vq is broken in virtqueue_poll.
> 
> Signed-off-by: Mao Wenan <wenan.mao@linux.alibaba.com>
> ---
>  v1->v2: fix it in virtqueue_poll suggested by Michael S. Tsirkin <mst@redhat.com>
>  drivers/virtio/virtio_ring.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
> index 58b96ba..4f7c73e 100644
> --- a/drivers/virtio/virtio_ring.c
> +++ b/drivers/virtio/virtio_ring.c
> @@ -1960,6 +1960,9 @@ bool virtqueue_poll(struct virtqueue *_vq, unsigned last_used_idx)
>  {
>  	struct vring_virtqueue *vq = to_vvq(_vq);
>  
> +	if (unlikely(vq->broken))
> +		return false;
> +
>  	virtio_mb(vq->weak_barriers);
>  	return vq->packed_ring ? virtqueue_poll_packed(_vq, last_used_idx) :
>  				 virtqueue_poll_split(_vq, last_used_idx);
> -- 
> 1.8.3.1

