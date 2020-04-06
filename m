Return-Path: <SRS0=Zj89=5W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 072C3C2BA19
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Apr 2020 13:55:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BFD2E21D79
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Apr 2020 13:55:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FKO6nZ4/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728514AbgDFNzd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Apr 2020 09:55:33 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:53476 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728446AbgDFNzd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Apr 2020 09:55:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1586181331;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=4JbffD6uHYn0Xws8gEnJhH/ASm7vL5TTpW7bpIjfQF0=;
        b=FKO6nZ4/z3L/WVcnS5lXJgx77phqfkvab8uAbXMvYjU3DVbE/MwnF0N19jcAifVEBqXINj
        vGG0q7tuJBoK2OJJI2lN43I3m+RT1954LciLKCh8YWu4mmb4N2Hw/768QPgf7EUnMq2iRp
        Cs0raJx4VO5f6zzOrT/af1K4tRQhWwk=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-400--U-sHeqqNUySlH474rquSw-1; Mon, 06 Apr 2020 09:55:30 -0400
X-MC-Unique: -U-sHeqqNUySlH474rquSw-1
Received: by mail-wm1-f72.google.com with SMTP id f8so4926185wmh.4
        for <linux-kernel@vger.kernel.org>; Mon, 06 Apr 2020 06:55:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=4JbffD6uHYn0Xws8gEnJhH/ASm7vL5TTpW7bpIjfQF0=;
        b=Hujp5Mnh5cLTjRlizRYYBvc9W4xJGPQO83FtKM1ud82P8GSC8uaZE732A4t/i2l97s
         ytMVsqM5MEY/zAIH6Pha2Eyqb50m3CADuKYeuMHbOfumNaRwOx5BGvv9Fdg741CD+cyQ
         CBbqO9qgr9WOt/PqurR3Rj5rSTzTZavWjqyB0g6gbtkaogrBPnFcZVYdBHpQjfCokBpt
         o0jUepq0Ddy3zd0s2hI6Y17OYdgHRchJL9S6XMVYc7v0gXGNt9N2jSOIbB82aZ102PFX
         xYqzlJXklwEuZY/dgqk5nv0a9KOpgdf9S3id/nEhRjNeYo9wNZlsh2un89kyS5NKCyoN
         Cz3A==
X-Gm-Message-State: AGi0PuYuuB1glTUVWDM/GrDywvEaw3mFUuwwkWa43OXgIyiruJ8cn+AY
        cdt0Q60pwBsvyp8v9hT4kkl26Rzoo4656D1P0Gt/gvWF6aCrtfkmb3IR45xTHxCZcFLsWKuTQxH
        EALOQh0iTRbnMBNBbC9YvyW2g
X-Received: by 2002:a5d:4d09:: with SMTP id z9mr602255wrt.292.1586181328771;
        Mon, 06 Apr 2020 06:55:28 -0700 (PDT)
X-Google-Smtp-Source: APiQypJMOX8DPPm6vlwNHfWsSuz0mrVkzWpGk7TU+nZhYELINvwWAIdcv57+eCeK2DYp6J7Z3YNU5w==
X-Received: by 2002:a5d:4d09:: with SMTP id z9mr602237wrt.292.1586181328553;
        Mon, 06 Apr 2020 06:55:28 -0700 (PDT)
Received: from redhat.com (bzq-79-176-51-222.red.bezeqint.net. [79.176.51.222])
        by smtp.gmail.com with ESMTPSA id w204sm25954947wma.1.2020.04.06.06.55.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Apr 2020 06:55:28 -0700 (PDT)
Date:   Mon, 6 Apr 2020 09:55:25 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Jason Wang <jasowang@redhat.com>
Cc:     linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        virtualization@lists.linux-foundation.org, netdev@vger.kernel.org
Subject: Re: [PATCH] vhost: force spec specified alignment on types
Message-ID: <20200406095424-mutt-send-email-mst@kernel.org>
References: <20200406124931.120768-1-mst@redhat.com>
 <045c84ed-151e-a850-9c72-5079bd2775e6@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <045c84ed-151e-a850-9c72-5079bd2775e6@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 06, 2020 at 09:34:00PM +0800, Jason Wang wrote:
> 
> On 2020/4/6 下午8:50, Michael S. Tsirkin wrote:
> > The ring element addresses are passed between components with different
> > alignments assumptions. Thus, if guest/userspace selects a pointer and
> > host then gets and dereferences it, we might need to decrease the
> > compiler-selected alignment to prevent compiler on the host from
> > assuming pointer is aligned.
> > 
> > This actually triggers on ARM with -mabi=apcs-gnu - which is a
> > deprecated configuration, but it seems safer to handle this
> > generally.
> > 
> > I verified that the produced binary is exactly identical on x86.
> > 
> > Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> > ---
> > 
> > This is my preferred way to handle the ARM incompatibility issues
> > (in preference to kconfig hacks).
> > I will push this into next now.
> > Comments?
> 
> 
> I'm not sure if it's too late to fix. It would still be still problematic
> for the userspace that is using old uapi headers?
> 
> Thanks

It's not a problem in userspace. The problem is when
userspace/guest uses 2 byte alignment and passes it to kernel
assuming 8 byte alignment. The fix is for host not to
make these assumptions.

> 
> > 
> >   drivers/vhost/vhost.h            |  6 ++---
> >   include/uapi/linux/virtio_ring.h | 41 ++++++++++++++++++++++++--------
> >   2 files changed, 34 insertions(+), 13 deletions(-)
> > 
> > diff --git a/drivers/vhost/vhost.h b/drivers/vhost/vhost.h
> > index cc82918158d2..a67bda9792ec 100644
> > --- a/drivers/vhost/vhost.h
> > +++ b/drivers/vhost/vhost.h
> > @@ -74,9 +74,9 @@ struct vhost_virtqueue {
> >   	/* The actual ring of buffers. */
> >   	struct mutex mutex;
> >   	unsigned int num;
> > -	struct vring_desc __user *desc;
> > -	struct vring_avail __user *avail;
> > -	struct vring_used __user *used;
> > +	vring_desc_t __user *desc;
> > +	vring_avail_t __user *avail;
> > +	vring_used_t __user *used;
> >   	const struct vhost_iotlb_map *meta_iotlb[VHOST_NUM_ADDRS];
> >   	struct vhost_desc *descs;
> > diff --git a/include/uapi/linux/virtio_ring.h b/include/uapi/linux/virtio_ring.h
> > index 559f42e73315..cd6e0b2eaf2f 100644
> > --- a/include/uapi/linux/virtio_ring.h
> > +++ b/include/uapi/linux/virtio_ring.h
> > @@ -118,16 +118,6 @@ struct vring_used {
> >   	struct vring_used_elem ring[];
> >   };
> > -struct vring {
> > -	unsigned int num;
> > -
> > -	struct vring_desc *desc;
> > -
> > -	struct vring_avail *avail;
> > -
> > -	struct vring_used *used;
> > -};
> > -
> >   /* Alignment requirements for vring elements.
> >    * When using pre-virtio 1.0 layout, these fall out naturally.
> >    */
> > @@ -164,6 +154,37 @@ struct vring {
> >   #define vring_used_event(vr) ((vr)->avail->ring[(vr)->num])
> >   #define vring_avail_event(vr) (*(__virtio16 *)&(vr)->used->ring[(vr)->num])
> > +/*
> > + * The ring element addresses are passed between components with different
> > + * alignments assumptions. Thus, we might need to decrease the compiler-selected
> > + * alignment, and so must use a typedef to make sure the __aligned attribute
> > + * actually takes hold:
> > + *
> > + * https://gcc.gnu.org/onlinedocs//gcc/Common-Type-Attributes.html#Common-Type-Attributes
> > + *
> > + * When used on a struct, or struct member, the aligned attribute can only
> > + * increase the alignment; in order to decrease it, the packed attribute must
> > + * be specified as well. When used as part of a typedef, the aligned attribute
> > + * can both increase and decrease alignment, and specifying the packed
> > + * attribute generates a warning.
> > + */
> > +typedef struct vring_desc __attribute__((aligned(VRING_DESC_ALIGN_SIZE)))
> > +	vring_desc_t;
> > +typedef struct vring_avail __attribute__((aligned(VRING_AVAIL_ALIGN_SIZE)))
> > +	vring_avail_t;
> > +typedef struct vring_used __attribute__((aligned(VRING_USED_ALIGN_SIZE)))
> > +	vring_used_t;
> > +
> > +struct vring {
> > +	unsigned int num;
> > +
> > +	vring_desc_t *desc;
> > +
> > +	vring_avail_t *avail;
> > +
> > +	vring_used_t *used;
> > +};
> > +
> >   static inline void vring_init(struct vring *vr, unsigned int num, void *p,
> >   			      unsigned long align)
> >   {

