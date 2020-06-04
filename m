Return-Path: <SRS0=TsDl=7R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2B4BC433E2
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Jun 2020 08:59:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8058D206C3
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Jun 2020 08:59:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="K2fjP8ko"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728259AbgFDI7d (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Jun 2020 04:59:33 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:40331 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726664AbgFDI7c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Jun 2020 04:59:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1591261169;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=WtpcAxuXjKPd+xNwjjUSXh6QNnhLy+bQzZ28Gv1mh5o=;
        b=K2fjP8koRi/mDx9Rx0VbKt0KVuea1h/Ql/59SGD65d5Yxs1nRT3Ztg45bwuRZuUVBLhV8y
        vwnplek9Ak4lviCK1B8iPXQ//DgA57q+yFRAOwykUcbpGPjP+Q5gcK7D+kLwzZwixsj1Hg
        4yCgDYJ0/VyaXPHLNwCV3/qlOrBAY+M=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-438-C1cj4PErNiWxXJwDYVw2Fg-1; Thu, 04 Jun 2020 04:59:27 -0400
X-MC-Unique: C1cj4PErNiWxXJwDYVw2Fg-1
Received: by mail-wr1-f70.google.com with SMTP id a4so2144789wrp.5
        for <linux-kernel@vger.kernel.org>; Thu, 04 Jun 2020 01:59:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=WtpcAxuXjKPd+xNwjjUSXh6QNnhLy+bQzZ28Gv1mh5o=;
        b=ZPD0njG/b5m/OzPn8ur3mj47+XyRA7SBLZhRoMPgbpCHQyj4Me95Ig+4WBUSWWRV+2
         VsVjHPi+V029TDDw6as59LTJ0N2HvpbvvOk+1nndRHZvStGt6KD3wvdcyw7DyE85cw+O
         Ia2IZkx6ru3rVCrkwZGrEqPejkidOKnUHJ8LmAhopbApXMTzuLgolKg9Qnm0u/74kEZ8
         c4dh7MHSKQVYNyLsmvRWCNnkxyvmajyQDPAwTOyq4UpN5tBvCesPf+OKrOv92Z/C957X
         r7V3RYkWDc1V6QYulpRhTo3nYfIE3pxndbMpquwGuvVVHzeaMTHZm4tr5VbJgLVmJ1T2
         n+WA==
X-Gm-Message-State: AOAM530U98xv7902020sjuvUo841nYBspRabLkGEtEstwWDx8yoVG6Vf
        OIxm7kzZfWYZkwl42HP/AYOZBvh11239e6srgasqwmIuwtryF8n6epcViYAsFiLPYMmMaxGgSsq
        kS+jtLv0JsVzm2//KMjfGA+tH
X-Received: by 2002:a7b:cd83:: with SMTP id y3mr2969356wmj.5.1591261166632;
        Thu, 04 Jun 2020 01:59:26 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyQVYOhaYqCqR2g6yBIim1YuvVtyZyB4PwbWTMfxoV4tzCD7LBQh4YsXfIK4thbfTeY+Hcx7Q==
X-Received: by 2002:a7b:cd83:: with SMTP id y3mr2969335wmj.5.1591261166347;
        Thu, 04 Jun 2020 01:59:26 -0700 (PDT)
Received: from redhat.com ([2a00:a040:185:f65:9a3b:8fff:fed3:ad8d])
        by smtp.gmail.com with ESMTPSA id h12sm6760861wro.80.2020.06.04.01.59.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Jun 2020 01:59:25 -0700 (PDT)
Date:   Thu, 4 Jun 2020 04:59:22 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Jason Wang <jasowang@redhat.com>
Cc:     linux-kernel@vger.kernel.org,
        Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>,
        kvm@vger.kernel.org, virtualization@lists.linux-foundation.org,
        netdev@vger.kernel.org
Subject: Re: [PATCH RFC 03/13] vhost: batching fetches
Message-ID: <20200604045830-mutt-send-email-mst@kernel.org>
References: <20200602130543.578420-1-mst@redhat.com>
 <20200602130543.578420-4-mst@redhat.com>
 <3323daa2-19ed-02de-0ff7-ab150f949fff@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <3323daa2-19ed-02de-0ff7-ab150f949fff@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 03, 2020 at 03:27:39PM +0800, Jason Wang wrote:
> 
> On 2020/6/2 下午9:06, Michael S. Tsirkin wrote:
> > With this patch applied, new and old code perform identically.
> > 
> > Lots of extra optimizations are now possible, e.g.
> > we can fetch multiple heads with copy_from/to_user now.
> > We can get rid of maintaining the log array.  Etc etc.
> > 
> > Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> > Signed-off-by: Eugenio Pérez <eperezma@redhat.com>
> > Link: https://lore.kernel.org/r/20200401183118.8334-4-eperezma@redhat.com
> > Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> > ---
> >   drivers/vhost/test.c  |  2 +-
> >   drivers/vhost/vhost.c | 47 ++++++++++++++++++++++++++++++++++++++-----
> >   drivers/vhost/vhost.h |  5 ++++-
> >   3 files changed, 47 insertions(+), 7 deletions(-)
> > 
> > diff --git a/drivers/vhost/test.c b/drivers/vhost/test.c
> > index 9a3a09005e03..02806d6f84ef 100644
> > --- a/drivers/vhost/test.c
> > +++ b/drivers/vhost/test.c
> > @@ -119,7 +119,7 @@ static int vhost_test_open(struct inode *inode, struct file *f)
> >   	dev = &n->dev;
> >   	vqs[VHOST_TEST_VQ] = &n->vqs[VHOST_TEST_VQ];
> >   	n->vqs[VHOST_TEST_VQ].handle_kick = handle_vq_kick;
> > -	vhost_dev_init(dev, vqs, VHOST_TEST_VQ_MAX, UIO_MAXIOV,
> > +	vhost_dev_init(dev, vqs, VHOST_TEST_VQ_MAX, UIO_MAXIOV + 64,
> >   		       VHOST_TEST_PKT_WEIGHT, VHOST_TEST_WEIGHT, NULL);
> >   	f->private_data = n;
> > diff --git a/drivers/vhost/vhost.c b/drivers/vhost/vhost.c
> > index 8f9a07282625..aca2a5b0d078 100644
> > --- a/drivers/vhost/vhost.c
> > +++ b/drivers/vhost/vhost.c
> > @@ -299,6 +299,7 @@ static void vhost_vq_reset(struct vhost_dev *dev,
> >   {
> >   	vq->num = 1;
> >   	vq->ndescs = 0;
> > +	vq->first_desc = 0;
> >   	vq->desc = NULL;
> >   	vq->avail = NULL;
> >   	vq->used = NULL;
> > @@ -367,6 +368,11 @@ static int vhost_worker(void *data)
> >   	return 0;
> >   }
> > +static int vhost_vq_num_batch_descs(struct vhost_virtqueue *vq)
> > +{
> > +	return vq->max_descs - UIO_MAXIOV;
> > +}
> 
> 
> 1 descriptor does not mean 1 iov, e.g userspace may pass several 1 byte
> length memory regions for us to translate.
> 


Yes but I don't see the relevance. This tells us how many descriptors to
batch, not how many IOVs.

> > +
> >   static void vhost_vq_free_iovecs(struct vhost_virtqueue *vq)
> >   {
> >   	kfree(vq->descs);
> > @@ -389,6 +395,9 @@ static long vhost_dev_alloc_iovecs(struct vhost_dev *dev)
> >   	for (i = 0; i < dev->nvqs; ++i) {
> >   		vq = dev->vqs[i];
> >   		vq->max_descs = dev->iov_limit;
> > +		if (vhost_vq_num_batch_descs(vq) < 0) {
> > +			return -EINVAL;
> > +		}
> >   		vq->descs = kmalloc_array(vq->max_descs,
> >   					  sizeof(*vq->descs),
> >   					  GFP_KERNEL);
> > @@ -1570,6 +1579,7 @@ long vhost_vring_ioctl(struct vhost_dev *d, unsigned int ioctl, void __user *arg
> >   		vq->last_avail_idx = s.num;
> >   		/* Forget the cached index value. */
> >   		vq->avail_idx = vq->last_avail_idx;
> > +		vq->ndescs = vq->first_desc = 0;
> >   		break;
> >   	case VHOST_GET_VRING_BASE:
> >   		s.index = idx;
> > @@ -2136,7 +2146,7 @@ static int fetch_indirect_descs(struct vhost_virtqueue *vq,
> >   	return 0;
> >   }
> > -static int fetch_descs(struct vhost_virtqueue *vq)
> > +static int fetch_buf(struct vhost_virtqueue *vq)
> >   {
> >   	unsigned int i, head, found = 0;
> >   	struct vhost_desc *last;
> > @@ -2149,7 +2159,11 @@ static int fetch_descs(struct vhost_virtqueue *vq)
> >   	/* Check it isn't doing very strange things with descriptor numbers. */
> >   	last_avail_idx = vq->last_avail_idx;
> > -	if (vq->avail_idx == vq->last_avail_idx) {
> > +	if (unlikely(vq->avail_idx == vq->last_avail_idx)) {
> > +		/* If we already have work to do, don't bother re-checking. */
> > +		if (likely(vq->ndescs))
> > +			return vq->num;
> > +
> >   		if (unlikely(vhost_get_avail_idx(vq, &avail_idx))) {
> >   			vq_err(vq, "Failed to access avail idx at %p\n",
> >   				&vq->avail->idx);
> > @@ -2240,6 +2254,24 @@ static int fetch_descs(struct vhost_virtqueue *vq)
> >   	return 0;
> >   }
> > +static int fetch_descs(struct vhost_virtqueue *vq)
> > +{
> > +	int ret = 0;
> > +
> > +	if (unlikely(vq->first_desc >= vq->ndescs)) {
> > +		vq->first_desc = 0;
> > +		vq->ndescs = 0;
> > +	}
> > +
> > +	if (vq->ndescs)
> > +		return 0;
> > +
> > +	while (!ret && vq->ndescs <= vhost_vq_num_batch_descs(vq))
> > +		ret = fetch_buf(vq);
> > +
> > +	return vq->ndescs ? 0 : ret;
> > +}
> > +
> >   /* This looks in the virtqueue and for the first available buffer, and converts
> >    * it to an iovec for convenient access.  Since descriptors consist of some
> >    * number of output then some number of input descriptors, it's actually two
> > @@ -2265,7 +2297,7 @@ int vhost_get_vq_desc(struct vhost_virtqueue *vq,
> >   	if (unlikely(log))
> >   		*log_num = 0;
> > -	for (i = 0; i < vq->ndescs; ++i) {
> > +	for (i = vq->first_desc; i < vq->ndescs; ++i) {
> >   		unsigned iov_count = *in_num + *out_num;
> >   		struct vhost_desc *desc = &vq->descs[i];
> >   		int access;
> > @@ -2311,14 +2343,19 @@ int vhost_get_vq_desc(struct vhost_virtqueue *vq,
> >   		}
> >   		ret = desc->id;
> > +
> > +		if (!(desc->flags & VRING_DESC_F_NEXT))
> > +			break;
> >   	}
> > -	vq->ndescs = 0;
> > +	vq->first_desc = i + 1;
> >   	return ret;
> >   err:
> > -	vhost_discard_vq_desc(vq, 1);
> > +	for (i = vq->first_desc; i < vq->ndescs; ++i)
> > +		if (!(vq->descs[i].flags & VRING_DESC_F_NEXT))
> > +			vhost_discard_vq_desc(vq, 1);
> >   	vq->ndescs = 0;
> >   	return ret;
> > diff --git a/drivers/vhost/vhost.h b/drivers/vhost/vhost.h
> > index 76356edee8e5..a67bda9792ec 100644
> > --- a/drivers/vhost/vhost.h
> > +++ b/drivers/vhost/vhost.h
> > @@ -81,6 +81,7 @@ struct vhost_virtqueue {
> >   	struct vhost_desc *descs;
> >   	int ndescs;
> > +	int first_desc;
> >   	int max_descs;
> >   	struct file *kick;
> > @@ -229,7 +230,7 @@ void vhost_iotlb_map_free(struct vhost_iotlb *iotlb,
> >   			  struct vhost_iotlb_map *map);
> >   #define vq_err(vq, fmt, ...) do {                                  \
> > -		pr_debug(pr_fmt(fmt), ##__VA_ARGS__);       \
> > +		pr_err(pr_fmt(fmt), ##__VA_ARGS__);       \
> 
> 
> Need a separate patch for this?
> 
> Thanks


Oh that's a debugging thing. I will drop it.

> 
> >   		if ((vq)->error_ctx)                               \
> >   				eventfd_signal((vq)->error_ctx, 1);\
> >   	} while (0)
> > @@ -255,6 +256,8 @@ static inline void vhost_vq_set_backend(struct vhost_virtqueue *vq,
> >   					void *private_data)
> >   {
> >   	vq->private_data = private_data;
> > +	vq->ndescs = 0;
> > +	vq->first_desc = 0;
> >   }
> >   /**

