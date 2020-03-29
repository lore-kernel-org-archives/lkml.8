Return-Path: <SRS0=I467=5O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 675B7C43331
	for <linux-kernel@archiver.kernel.org>; Sun, 29 Mar 2020 12:36:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 30A7220714
	for <linux-kernel@archiver.kernel.org>; Sun, 29 Mar 2020 12:36:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JizUFo5c"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728126AbgC2MgU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 29 Mar 2020 08:36:20 -0400
Received: from us-smtp-delivery-74.mimecast.com ([216.205.24.74]:26709 "EHLO
        us-smtp-delivery-74.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727985AbgC2MgU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Mar 2020 08:36:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1585485378;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=hwBJNIszh6TC6VU12FXZ4Vd7wn8RSesK/NNxIOU/Few=;
        b=JizUFo5cFKkxzL4LRZrTJcKZhdhom9B/wprXZek6ztCFTHLJBLf3oiAVqYApwdTXvr3XMR
        pCQErbFBu9G295U3KXPz016IbylfFJanPWcEp+JGcBV4bIauOJ7WcI1iF88KBqHSUB6bVS
        Gv5+hxsNRXGtxYnMLdIXdhQ4vD+5SKM=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-309-MZ2_qOXaNPGOa1LwY9B53Q-1; Sun, 29 Mar 2020 08:36:16 -0400
X-MC-Unique: MZ2_qOXaNPGOa1LwY9B53Q-1
Received: by mail-wr1-f71.google.com with SMTP id f15so8461918wrt.4
        for <linux-kernel@vger.kernel.org>; Sun, 29 Mar 2020 05:36:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=hwBJNIszh6TC6VU12FXZ4Vd7wn8RSesK/NNxIOU/Few=;
        b=ohLxCFgz7Ook8G6OTWrj61gLp6qilHPz5vYpCjhM+P0P8qujTOsR48f5eHVAJ8118y
         zaBSEf65axj/z6Kgedb9gYBauqIS2UY15mUQJc1Fy9NvnPia0cHVSb3rKZvotY6U0goN
         qV9IlBCMxjrgPuknRmF45tjmSKyF+3a9qjbleC9Tggk43DSYdYnB+8qcbVXPbjyiBB6t
         1BoCU2i1qn+2ggq06eHoeoiz82137Y6NNZRPrH14LFn8l5sgPcxshB0rDd6sOucxUrKQ
         rA62/X1auNb+8IIVwWFt3oYg1p5xr1aiarxVVZHrLFDHpYa93CCLn5M8cv29K/iOEOb2
         ejBw==
X-Gm-Message-State: ANhLgQ39olCXmVfvmZAVVc3UyqMOW40N7mQMXlpSWIprGUdoIHw8c6an
        F1qeLr2ByV5/32Wy4bfVe9L4VnBlaNhVQa+S3RklSodf6Cco6x7qLz2dnxgr+pYMPsbl1X3q1Xg
        96QrId9wrqfRe3bkw4/UmVaL0
X-Received: by 2002:a1c:f70a:: with SMTP id v10mr8143939wmh.72.1585485375627;
        Sun, 29 Mar 2020 05:36:15 -0700 (PDT)
X-Google-Smtp-Source: ADFU+vuI9saIsl2zcWQGqaeDKgmx/oMIL5wQ54Rlrl1U1iP0jFOdf2pPLW21ixwNKW8n8TFOnKAcZQ==
X-Received: by 2002:a1c:f70a:: with SMTP id v10mr8143921wmh.72.1585485375355;
        Sun, 29 Mar 2020 05:36:15 -0700 (PDT)
Received: from redhat.com (bzq-79-183-139-129.red.bezeqint.net. [79.183.139.129])
        by smtp.gmail.com with ESMTPSA id b187sm17230248wmc.14.2020.03.29.05.36.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 29 Mar 2020 05:36:14 -0700 (PDT)
Date:   Sun, 29 Mar 2020 08:36:12 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>
Cc:     "virtualization@lists.linux-foundation.org" 
        <virtualization@lists.linux-foundation.org>,
        Halil Pasic <pasic@linux.ibm.com>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        kvm list <kvm@vger.kernel.org>,
        Cornelia Huck <cohuck@redhat.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 4/6] tools/virtio: Make --reset reset ring idx
Message-ID: <20200329083047-mutt-send-email-mst@kernel.org>
References: <20200329113359.30960-1-eperezma@redhat.com>
 <20200329113359.30960-5-eperezma@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200329113359.30960-5-eperezma@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Mar 29, 2020 at 01:33:57PM +0200, Eugenio Pérez wrote:
> Signed-off-by: Eugenio Pérez <eperezma@redhat.com>
> ---
>  drivers/virtio/virtio_ring.c | 18 ++++++++++++++++++
>  include/linux/virtio.h       |  2 ++
>  tools/virtio/linux/virtio.h  |  2 ++
>  tools/virtio/virtio_test.c   | 28 +++++++++++++++++++++++++++-
>  4 files changed, 49 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
> index 867c7ebd3f10..aba44ac3f0d6 100644
> --- a/drivers/virtio/virtio_ring.c
> +++ b/drivers/virtio/virtio_ring.c
> @@ -1810,6 +1810,24 @@ int virtqueue_add_inbuf_ctx(struct virtqueue *vq,
>  }
>  EXPORT_SYMBOL_GPL(virtqueue_add_inbuf_ctx);
>  
> +void virtqueue_reset_free_head(struct virtqueue *_vq)
> +{
> +	struct vring_virtqueue *vq = to_vvq(_vq);
> +
> +	// vq->last_used_idx = 0;
> +	vq->num_added = 0;
> +
> +	vq->split.queue_size_in_bytes = 0;
> +	vq->split.avail_flags_shadow = 0;
> +	vq->split.avail_idx_shadow = 0;
> +
> +	memset(vq->split.desc_state, 0, vq->split.vring.num *
> +			sizeof(struct vring_desc_state_split));
> +
> +	vq->free_head = 0;
> +}
> +EXPORT_SYMBOL_GPL(virtqueue_reset_free_head);
> +
>  /**
>   * virtqueue_kick_prepare - first half of split virtqueue_kick call.
>   * @_vq: the struct virtqueue

Add documentation please. When should this be called?
If it's just for testing, we can put this within some ifdef
that only triggers when building the test ...


> diff --git a/include/linux/virtio.h b/include/linux/virtio.h
> index 15f906e4a748..286a0048fbeb 100644
> --- a/include/linux/virtio.h
> +++ b/include/linux/virtio.h
> @@ -58,6 +58,8 @@ int virtqueue_add_sgs(struct virtqueue *vq,
>  		      void *data,
>  		      gfp_t gfp);
>  
> +void virtqueue_reset_free_head(struct virtqueue *vq);
> +
>  bool virtqueue_kick(struct virtqueue *vq);
>  
>  bool virtqueue_kick_prepare(struct virtqueue *vq);
> diff --git a/tools/virtio/linux/virtio.h b/tools/virtio/linux/virtio.h
> index b751350d4ce8..cf2e9ccf4de2 100644
> --- a/tools/virtio/linux/virtio.h
> +++ b/tools/virtio/linux/virtio.h
> @@ -43,6 +43,8 @@ int virtqueue_add_inbuf(struct virtqueue *vq,
>  			void *data,
>  			gfp_t gfp);
>  
> +void virtqueue_reset_free_head(struct virtqueue *vq);
> +
>  bool virtqueue_kick(struct virtqueue *vq);
>  
>  void *virtqueue_get_buf(struct virtqueue *vq, unsigned int *len);
> diff --git a/tools/virtio/virtio_test.c b/tools/virtio/virtio_test.c
> index 93d81cd64ba0..bf21ece30594 100644
> --- a/tools/virtio/virtio_test.c
> +++ b/tools/virtio/virtio_test.c
> @@ -49,6 +49,7 @@ struct vdev_info {
>  
>  static const struct vhost_vring_file no_backend = { .fd = -1 },
>  				     backend = { .fd = 1 };
> +static const struct vhost_vring_state null_state = {};
>  
>  bool vq_notify(struct virtqueue *vq)
>  {
> @@ -218,10 +219,33 @@ static void run_test(struct vdev_info *dev, struct vq_info *vq,
>  			}
>  
>  			if (reset) {
> +				struct vhost_vring_state s = { .index = 0 };
> +				int i;
> +				vq->vring.avail->idx = 0;
> +				vq->vq->num_free = vq->vring.num;
> +
> +				// Put everything in free lists.
> +				for (i = 0; i < vq->vring.num-1; i++)
> +					vq->vring.desc[i].next =
> +						cpu_to_virtio16(&dev->vdev,
> +								i + 1);
> +				vq->vring.desc[vq->vring.num-1].next = 0;
> +				virtqueue_reset_free_head(vq->vq);
> +


Hmm this is poking at internal vq format ...


> +				r = ioctl(dev->control, VHOST_GET_VRING_BASE,
> +					  &s);
> +				assert(!r);
> +
> +				s.num = 0;
> +				r = ioctl(dev->control, VHOST_SET_VRING_BASE,
> +					  &null_state);
> +				assert(!r);
> +
>  				r = ioctl(dev->control, VHOST_TEST_SET_BACKEND,
>  					  &backend);
>  				assert(!r);
>  
> +				started = completed;
>                                  while (completed > next_reset)
>  					next_reset += completed;
>  			}
> @@ -243,7 +267,9 @@ static void run_test(struct vdev_info *dev, struct vq_info *vq,
>  	test = 0;
>  	r = ioctl(dev->control, VHOST_TEST_RUN, &test);
>  	assert(r >= 0);
> -	fprintf(stderr, "spurious wakeups: 0x%llx\n", spurious);
> +	fprintf(stderr,
> +		"spurious wakeups: 0x%llx started=0x%lx completed=0x%lx\n",
> +		spurious, started, completed);
>  }
>  
>  const char optstring[] = "h";
> -- 
> 2.18.1

