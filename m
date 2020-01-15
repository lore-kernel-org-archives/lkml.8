Return-Path: <SRS0=7RkH=3E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E368C33CB1
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jan 2020 13:49:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2327F222C3
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jan 2020 13:49:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BJHXhFBi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728915AbgAONtZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Jan 2020 08:49:25 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:23325 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726574AbgAONtY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jan 2020 08:49:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1579096163;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=79M15GKwGi7t6ysWJj36dJhzxgOaifGqu7osrGbl4Jk=;
        b=BJHXhFBinMPoncxwuRgLeMnYLek2AAbW2dtf2xovxoM33t97bsSDS4XAhLp+tIB2zQXFJa
        VQ0J2fOWZ3h+OZ8zBqwbzp6gBEp6lC/ftNGelg8hOE2Wlu/MrG3IXhEXqsOVbVituajFmL
        Q15kB5Cgac2OGkZqCgEEtw5ZaKQlnmw=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-205-pIFh2sBbMNK1YzwIrLB8Mg-1; Wed, 15 Jan 2020 08:49:21 -0500
X-MC-Unique: pIFh2sBbMNK1YzwIrLB8Mg-1
Received: by mail-qv1-f72.google.com with SMTP id ce17so11079467qvb.5
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jan 2020 05:49:21 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=79M15GKwGi7t6ysWJj36dJhzxgOaifGqu7osrGbl4Jk=;
        b=aPbMqiwRyrOcS49/nwVV7PVBWlZyC/P71atJXV6PrFc7M5522fPHknd0IaofyIPHHQ
         gcALVcT+A3MzDwhZfANQf08SbPj0O/uBWwVgLRecb8XLWYPiVlK712IdnwVXq9mh3Ivw
         Vp16xwK4dCXtXdW29cUkbotE2IYneqjl4yDBDfEdJD8mv9ZN0qvcgdQb3Yyeq7Cf3N/7
         0qBvvKQvmYJq1fvjRNHM3YYV/jDP1nFkRryrfu+OFwQ2ehLvi0d/mBbzT5PB01hNw4Ov
         U7mgtaPtJ2Mjv8Rs2ewwTgcgB/2d7YfDyqzsbNvLaKKVQHTDNu/kJkaUyh/8gk0j/Dre
         bFjw==
X-Gm-Message-State: APjAAAUVcFnR+9wuJPPJDelAcqhYKYaGboi2mjMwBKaM7PgX0+BEg29W
        Abim7t71f58udx1h5oyCWmytmByZ/bC6GESx0vJV5PXDrxwfoIaOdMHUkIi7RjC1fkG18QvNo8u
        p0n0ODlntHr1+eiHN+7++QIkI
X-Received: by 2002:a37:a685:: with SMTP id p127mr23744221qke.449.1579096161383;
        Wed, 15 Jan 2020 05:49:21 -0800 (PST)
X-Google-Smtp-Source: APXvYqz42YoUKeG+vAxd7NWuh+eaZw45fe1oAMfHmK2nDoiIOLa/QZBznhzSgF9fNTakPe1VYtTTdg==
X-Received: by 2002:a37:a685:: with SMTP id p127mr23744193qke.449.1579096161132;
        Wed, 15 Jan 2020 05:49:21 -0800 (PST)
Received: from redhat.com (bzq-79-183-34-164.red.bezeqint.net. [79.183.34.164])
        by smtp.gmail.com with ESMTPSA id x27sm8332400qkx.81.2020.01.15.05.49.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jan 2020 05:49:20 -0800 (PST)
Date:   Wed, 15 Jan 2020 08:49:16 -0500
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Clement Leger <cleger@kalray.eu>
Cc:     Jason Wang <jasowang@redhat.com>,
        virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] virtio_ring: Use workqueue to execute virtqueue callback
Message-ID: <20200115084601-mutt-send-email-mst@kernel.org>
References: <20200115120535.17454-1-cleger@kalray.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200115120535.17454-1-cleger@kalray.eu>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 15, 2020 at 01:05:35PM +0100, Clement Leger wrote:
> Currently, in vring_interrupt, the vq callbacks are called directly.
> However, these callbacks are not meant to be executed in IRQ context.
> They do not return any irq_return_t value and some of them can do
> locking (rpmsg_recv_done -> rpmsg_recv_single -> mutex_lock).

That's a bug in rpmsg. Pls fix there.

> When compiled with DEBUG_ATOMIC_SLEEP, the kernel will spit out warnings
> when such case shappen.
> 
> In order to allow calling these callbacks safely (without sleeping in
> IRQ context), execute them in a workqueue if needed.
> 
> Signed-off-by: Clement Leger <cleger@kalray.eu>

If applied this would slow data path handling of VQ events
significantly. Teaching callbacks to return irqreturn_t
might be a good idea, though it's not an insignificant
amount of work.


> ---
>  drivers/virtio/virtio_ring.c | 20 ++++++++++++++++++--
>  1 file changed, 18 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
> index 867c7ebd3f10..0e4d0e5ca227 100644
> --- a/drivers/virtio/virtio_ring.c
> +++ b/drivers/virtio/virtio_ring.c
> @@ -183,6 +183,9 @@ struct vring_virtqueue {
>  	/* DMA, allocation, and size information */
>  	bool we_own_ring;
>  
> +	/* Work struct for vq callback handling */
> +	struct work_struct work;
> +
>  #ifdef DEBUG
>  	/* They're supposed to lock for us. */
>  	unsigned int in_use;
> @@ -2029,6 +2032,16 @@ static inline bool more_used(const struct vring_virtqueue *vq)
>  	return vq->packed_ring ? more_used_packed(vq) : more_used_split(vq);
>  }
>  
> +static void vring_work_handler(struct work_struct *work_struct)
> +{
> +	struct vring_virtqueue *vq = container_of(work_struct,
> +						  struct vring_virtqueue,
> +						  work);
> +	pr_debug("virtqueue callback for %p (%p)\n", vq, vq->vq.callback);
> +
> +	vq->vq.callback(&vq->vq);
> +}
> +
>  irqreturn_t vring_interrupt(int irq, void *_vq)
>  {
>  	struct vring_virtqueue *vq = to_vvq(_vq);
> @@ -2041,9 +2054,8 @@ irqreturn_t vring_interrupt(int irq, void *_vq)
>  	if (unlikely(vq->broken))
>  		return IRQ_HANDLED;
>  
> -	pr_debug("virtqueue callback for %p (%p)\n", vq, vq->vq.callback);
>  	if (vq->vq.callback)
> -		vq->vq.callback(&vq->vq);
> +		schedule_work(&vq->work);
>  
>  	return IRQ_HANDLED;
>  }
> @@ -2110,6 +2122,8 @@ struct virtqueue *__vring_new_virtqueue(unsigned int index,
>  					vq->split.avail_flags_shadow);
>  	}
>  
> +	INIT_WORK(&vq->work, vring_work_handler);
> +
>  	vq->split.desc_state = kmalloc_array(vring.num,
>  			sizeof(struct vring_desc_state_split), GFP_KERNEL);
>  	if (!vq->split.desc_state) {
> @@ -2179,6 +2193,8 @@ void vring_del_virtqueue(struct virtqueue *_vq)
>  {
>  	struct vring_virtqueue *vq = to_vvq(_vq);
>  
> +	cancel_work_sync(&vq->work);
> +
>  	if (vq->we_own_ring) {
>  		if (vq->packed_ring) {
>  			vring_free_queue(vq->vq.vdev,
> -- 
> 2.15.0.276.g89ea799

