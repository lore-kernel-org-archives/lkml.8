Return-Path: <SRS0=HA/2=BM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7171C433E0
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Aug 2020 06:25:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 76A952076B
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Aug 2020 06:25:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Q/XP8a2T"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725992AbgHBGZv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 2 Aug 2020 02:25:51 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:43708 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725823AbgHBGZv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Aug 2020 02:25:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1596349549;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=S6OYCdbGW3vcu3y+tw3bsh0JBnWwiCW5p61nwH6OSdk=;
        b=Q/XP8a2T99FM3ItA1jY9At27hJM5likCSB7In+3kCCjIblwiiHTtUYPDkNyDkU8KSCdfqw
        tWVDnSxZwR5dvizcJwStq2JRvagJrevSlpLW/2A6yUQ5qLuYMOf4Am7Xy5J4xnMif57nmC
        yPW6x8R8BQZ3Y+dNEui2joeLnpeJQ6Q=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-391-5WKU_gxoP_61H7iCsJI9EA-1; Sun, 02 Aug 2020 02:25:47 -0400
X-MC-Unique: 5WKU_gxoP_61H7iCsJI9EA-1
Received: by mail-wr1-f70.google.com with SMTP id z12so10358815wrl.16
        for <linux-kernel@vger.kernel.org>; Sat, 01 Aug 2020 23:25:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=S6OYCdbGW3vcu3y+tw3bsh0JBnWwiCW5p61nwH6OSdk=;
        b=gLOiBfgPxeA0Nbx7ieF8cupm7Y2E5Ib9KsU9iA0RT+Z4g8AOWjuSMPTyMeQvOMWqrz
         Ls2x2GFgkArR0yPhzuklZ8N5G9Km9KylW9TwEIc5cYOsLR9aBiS9SLpUY3R3I02/fKiP
         ZLCq+4olZdutlf3DTwxmNglK5+xUElkbhceROo+wZeMP7LXne1wkooqtC95zIQ9zC8sd
         J0zcmZ8QhjCrjZJSNvqD1T1iP8aFuIiKglHthpfgsjxz9yWPOGEy2pObG3f7LMbPwjZV
         bvn83P0K/iv+g0RWHC3NzBFYdgx8z1IEft5l4eDGQvCBGlY4KI6QOvUq+rkTEohi6c2C
         LwDA==
X-Gm-Message-State: AOAM5305tBgv9xGhQN8u/a/+J24/FBSYnQ4x64voOOrO0LFZV+sSUXC8
        pNnO0D3fyaJ6trOF/4Rd6jFg9dcX3BdB088yvpNoStaB30vccBi7n6nvdkcF/kOdMlcWRkanilo
        Y76vTzBcpLZZ/quK0QmJ7gswq
X-Received: by 2002:a7b:c154:: with SMTP id z20mr11102332wmi.118.1596349545808;
        Sat, 01 Aug 2020 23:25:45 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJynZI0DXpqHK+lKgKMB/Q7mJUqK4kYuqt49mPCgR78Fj5Qunpo174be0PRlqdzVRrBirQfRJw==
X-Received: by 2002:a7b:c154:: with SMTP id z20mr11102318wmi.118.1596349545515;
        Sat, 01 Aug 2020 23:25:45 -0700 (PDT)
Received: from redhat.com (bzq-79-179-105-63.red.bezeqint.net. [79.179.105.63])
        by smtp.gmail.com with ESMTPSA id 68sm19668139wra.39.2020.08.01.23.25.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 01 Aug 2020 23:25:44 -0700 (PDT)
Date:   Sun, 2 Aug 2020 02:25:42 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Mao Wenan <wenan.mao@linux.alibaba.com>
Cc:     jasowang@redhat.com, virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: Re: [PATCH -next v2] virtio_net: Avoid loop in virtnet_poll
Message-ID: <20200802022521-mutt-send-email-mst@kernel.org>
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

Looks good:
Acked-by: Michael S. Tsirkin <mst@redhat.com>

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

