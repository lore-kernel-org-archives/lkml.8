Return-Path: <SRS0=CVC0=7X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5CC08C433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jun 2020 15:08:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 34750206F4
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jun 2020 15:08:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bG11DR7V"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729996AbgFJPIL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Jun 2020 11:08:11 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:46507 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726081AbgFJPIL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Jun 2020 11:08:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1591801689;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ZvS3pY4wDKLBE9EMwiJvGN8pCoUxnpSAds/EiWZ00f4=;
        b=bG11DR7Vv3sqnZiWt66IkQQlhtwrsUfI55jkUcL+4JnB2cqwpXmXInQvC/0aaM5pC5Roid
        Lcrz633uCy98fwECjS+O9QQyHMWFFKEj/4ax42J3GVO34FAVt6PX9vD9afQ8gHh+eRKuym
        5lw493H8+4gFUqVFeFN9Qeng7/Nyg8Y=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-296-0dqJsZELM4ubqtkjtWUt9w-1; Wed, 10 Jun 2020 11:08:07 -0400
X-MC-Unique: 0dqJsZELM4ubqtkjtWUt9w-1
Received: by mail-wm1-f69.google.com with SMTP id k185so475587wme.8
        for <linux-kernel@vger.kernel.org>; Wed, 10 Jun 2020 08:08:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=ZvS3pY4wDKLBE9EMwiJvGN8pCoUxnpSAds/EiWZ00f4=;
        b=MHicpIxvkmzlMztrse+bM3ObuvkhSL4vATELuSBICfu1otAb9dgl+2M8mQIUZsyy1a
         cKbI07BzVrUplBXwEz2FOk6x6MQ4Am3eSt9EGy3rOan0Q4xe/qJt2FGUo40Nd8tPPvpR
         XojFVykSHkuv4Mzl854XwpMhZsKDPAmYUTbxFLxYlFoZlrUkB3zfu8GV56NVbGzOV6SR
         jcYQngk5QfkIubU0sKF53DmVb7S5u+MO/wJik5aulrvS/NSfjXqUp7jC2LwBA4UQ2+MI
         aGbCbFmV6qK+RSr+B1CqjGzpF4QRULHuKtsT9J6qqE6wzN7FJkGAf5Kdvnta7UnZj5Na
         gcow==
X-Gm-Message-State: AOAM533OTe5TgQBXDV9DuInMXD898ZXPM1wZIi9AR3NczY4JzCgdCcsv
        7udnaObiaWvWlXKrSOhkbuWSpZpUzndLTUN+GevaI9W1mHIOAPybSMaVooBJ2lujTVOcrfOkYWU
        7y2XqudwnT9AprqZ2V0FfTubf
X-Received: by 2002:a05:6000:1104:: with SMTP id z4mr4211610wrw.272.1591801686261;
        Wed, 10 Jun 2020 08:08:06 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxSwDALN5Pur0obQjyi2Uc0HobQX48dqJRmEevxPLOFxJwcAkmH8xWT1y5vRmc5DFWcLholqg==
X-Received: by 2002:a05:6000:1104:: with SMTP id z4mr4211584wrw.272.1591801685999;
        Wed, 10 Jun 2020 08:08:05 -0700 (PDT)
Received: from redhat.com ([212.92.121.57])
        by smtp.gmail.com with ESMTPSA id j4sm42126wma.7.2020.06.10.08.08.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Jun 2020 08:08:05 -0700 (PDT)
Date:   Wed, 10 Jun 2020 11:08:02 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>
Cc:     linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        virtualization@lists.linux-foundation.org, netdev@vger.kernel.org,
        Jason Wang <jasowang@redhat.com>
Subject: Re: [PATCH RFC v7 03/14] vhost: use batched get_vq_desc version
Message-ID: <20200610105829-mutt-send-email-mst@kernel.org>
References: <20200610113515.1497099-1-mst@redhat.com>
 <20200610113515.1497099-4-mst@redhat.com>
 <035e82bcf4ade0017641c5b457d0c628c5915732.camel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <035e82bcf4ade0017641c5b457d0c628c5915732.camel@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 10, 2020 at 04:29:29PM +0200, Eugenio Pérez wrote:
> On Wed, 2020-06-10 at 07:36 -0400, Michael S. Tsirkin wrote:
> > As testing shows no performance change, switch to that now.
> > 
> > Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> > Signed-off-by: Eugenio Pérez <eperezma@redhat.com>
> > Link: https://lore.kernel.org/r/20200401183118.8334-3-eperezma@redhat.com
> > Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> > ---
> >  drivers/vhost/test.c  |   2 +-
> >  drivers/vhost/vhost.c | 318 ++++++++----------------------------------
> >  drivers/vhost/vhost.h |   7 +-
> >  3 files changed, 65 insertions(+), 262 deletions(-)
> > 
> > diff --git a/drivers/vhost/test.c b/drivers/vhost/test.c
> > index 0466921f4772..7d69778aaa26 100644
> > --- a/drivers/vhost/test.c
> > +++ b/drivers/vhost/test.c
> > @@ -119,7 +119,7 @@ static int vhost_test_open(struct inode *inode, struct file *f)
> >  	dev = &n->dev;
> >  	vqs[VHOST_TEST_VQ] = &n->vqs[VHOST_TEST_VQ];
> >  	n->vqs[VHOST_TEST_VQ].handle_kick = handle_vq_kick;
> > -	vhost_dev_init(dev, vqs, VHOST_TEST_VQ_MAX, UIO_MAXIOV,
> > +	vhost_dev_init(dev, vqs, VHOST_TEST_VQ_MAX, UIO_MAXIOV + 64,
> >  		       VHOST_TEST_PKT_WEIGHT, VHOST_TEST_WEIGHT, true, NULL);
> >  
> >  	f->private_data = n;
> > diff --git a/drivers/vhost/vhost.c b/drivers/vhost/vhost.c
> > index 11433d709651..28f324fd77df 100644
> > --- a/drivers/vhost/vhost.c
> > +++ b/drivers/vhost/vhost.c
> > @@ -304,6 +304,7 @@ static void vhost_vq_reset(struct vhost_dev *dev,
> >  {
> >  	vq->num = 1;
> >  	vq->ndescs = 0;
> > +	vq->first_desc = 0;
> >  	vq->desc = NULL;
> >  	vq->avail = NULL;
> >  	vq->used = NULL;
> > @@ -372,6 +373,11 @@ static int vhost_worker(void *data)
> >  	return 0;
> >  }
> >  
> > +static int vhost_vq_num_batch_descs(struct vhost_virtqueue *vq)
> > +{
> > +	return vq->max_descs - UIO_MAXIOV;
> > +}
> > +
> >  static void vhost_vq_free_iovecs(struct vhost_virtqueue *vq)
> >  {
> >  	kfree(vq->descs);
> > @@ -394,6 +400,9 @@ static long vhost_dev_alloc_iovecs(struct vhost_dev *dev)
> >  	for (i = 0; i < dev->nvqs; ++i) {
> >  		vq = dev->vqs[i];
> >  		vq->max_descs = dev->iov_limit;
> > +		if (vhost_vq_num_batch_descs(vq) < 0) {
> > +			return -EINVAL;
> > +		}
> >  		vq->descs = kmalloc_array(vq->max_descs,
> >  					  sizeof(*vq->descs),
> >  					  GFP_KERNEL);
> > @@ -1610,6 +1619,7 @@ long vhost_vring_ioctl(struct vhost_dev *d, unsigned int ioctl, void __user *arg
> >  		vq->last_avail_idx = s.num;
> >  		/* Forget the cached index value. */
> >  		vq->avail_idx = vq->last_avail_idx;
> > +		vq->ndescs = vq->first_desc = 0;
> 
> This is not needed if it is done in vhost_vq_set_backend, as far as I can tell.
> 
> Actually, maybe it is even better to move `vq->avail_idx = vq->last_avail_idx;` line to vhost_vq_set_backend, it is part
> of the backend "set up" procedure, isn't it?
> 
> I tested with virtio_test + batch tests sent in 
> https://lkml.kernel.org/lkml/20200418102217.32327-1-eperezma@redhat.com/T/.

Ow did I forget to merge them for rc1?  Should I have? Maybe Linus won't
yell to hard at me if I merge them after rc1.


> I append here what I'm proposing in case it is clearer this way.
> 
> Thanks!
> 
> diff --git a/drivers/vhost/vhost.c b/drivers/vhost/vhost.c
> index 4d198994e7be..809ad2cd2879 100644
> --- a/drivers/vhost/vhost.c
> +++ b/drivers/vhost/vhost.c
> @@ -1617,9 +1617,6 @@ long vhost_vring_ioctl(struct vhost_dev *d, unsigned int ioctl, void __user *arg
>  			break;
>  		}
>  		vq->last_avail_idx = s.num;
> -		/* Forget the cached index value. */
> -		vq->avail_idx = vq->last_avail_idx;
> -		vq->ndescs = vq->first_desc = 0;
>  		break;
>  	case VHOST_GET_VRING_BASE:
>  		s.index = idx;
> diff --git a/drivers/vhost/vhost.h b/drivers/vhost/vhost.h
> index fed36af5c444..f4902dc808e4 100644
> --- a/drivers/vhost/vhost.h
> +++ b/drivers/vhost/vhost.h
> @@ -258,6 +258,7 @@ static inline void vhost_vq_set_backend(struct vhost_virtqueue *vq,
>  					void *private_data)
>  {
>  	vq->private_data = private_data;
> +	vq->avail_idx = vq->last_avail_idx;
>  	vq->ndescs = 0;
>  	vq->first_desc = 0;
>  }
> 

Seems like a nice cleanup, though it's harmless right?


-- 
MST

