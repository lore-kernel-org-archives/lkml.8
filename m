Return-Path: <SRS0=Zj89=5W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A56EC2BA1B
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Apr 2020 14:34:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 378F621473
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Apr 2020 14:34:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="D2cMUT1w"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728738AbgDFOet (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Apr 2020 10:34:49 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:52325 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728729AbgDFOes (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Apr 2020 10:34:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1586183686;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=IJvEdYDLaOnX9xJG3HxXlME2+2zcIWCbfErT4uuM1A8=;
        b=D2cMUT1wDYfBd8c4l2NM3orVyHRoYcUi1ZAEJ1/W9ZsktBX2vTRfyw1KpjhH24MC3VdQ75
        vXayMrwCISJyPRsWwelb94j5g3L0TGzil7KotQWiOcelHGVZ74ckyQERCINqFshU0JbJj2
        5usW0j6YCx2XS36vIX0gWEE6sVPt54E=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-226-phyq7vIUNwaBh-bnCapKkg-1; Mon, 06 Apr 2020 10:34:45 -0400
X-MC-Unique: phyq7vIUNwaBh-bnCapKkg-1
Received: by mail-wr1-f71.google.com with SMTP id h14so8439761wrr.12
        for <linux-kernel@vger.kernel.org>; Mon, 06 Apr 2020 07:34:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=IJvEdYDLaOnX9xJG3HxXlME2+2zcIWCbfErT4uuM1A8=;
        b=Bc8CHyC37VGGigSgJPgs+sc1luw6yLf4AyI9JzcoPtjukyBdoq1ZZBsqY5ldIswSHx
         x6XZx/admwL7r+G2UZZ8W1DuOlZpJ3W9OhSgqg5Ggm4rmsyA0oxKIgpOjW0nfh/U2d+h
         rOFV3AVTlddalxFYubVvDj0qFIsYcAzh/TF2QELQ577fPAyjVkxo5xENsCrBYz83X69a
         alVBvm5NSTVzgTEfLqc55EaTP12iyYOQsBTHUDKUa6lLBDwbOkgO/dzGjSf8Q7NTVTB5
         M1Qz+Ju34Gw8XipbCPPvUXisLJumANuCam5hpJ6OwtX5hh7sDXLLi3U/RFa5bKOVRM0e
         sUcA==
X-Gm-Message-State: AGi0PubzSm9/TL/F0GyMEuH2jEjgVOYa0kk13Qm4UODjix70zkEk9S4Z
        kpkPt9+pw84HaaP4zeZYduVKPJIWvmL2yV6nOxhr0IQoktVWr/TEKfIe8eSUbRuU7yleYd+rLYo
        enrHGpnc1+IM27YP5gLqFaffQ
X-Received: by 2002:a5d:468b:: with SMTP id u11mr10561960wrq.89.1586183683844;
        Mon, 06 Apr 2020 07:34:43 -0700 (PDT)
X-Google-Smtp-Source: APiQypKVC46xSuUV+b+SZgNesYPGvUEvVa9w1c6TmOn2m1iOj0U4q5Cbs3Io5eAGagoYg5SQI3CbzQ==
X-Received: by 2002:a5d:468b:: with SMTP id u11mr10561937wrq.89.1586183683607;
        Mon, 06 Apr 2020 07:34:43 -0700 (PDT)
Received: from redhat.com (bzq-79-176-51-222.red.bezeqint.net. [79.176.51.222])
        by smtp.gmail.com with ESMTPSA id o13sm4347586wrm.74.2020.04.06.07.34.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Apr 2020 07:34:43 -0700 (PDT)
Date:   Mon, 6 Apr 2020 10:34:40 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Jason Wang <jasowang@redhat.com>
Cc:     linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        virtualization@lists.linux-foundation.org, netdev@vger.kernel.org
Subject: Re: [PATCH] vhost: force spec specified alignment on types
Message-ID: <20200406102531-mutt-send-email-mst@kernel.org>
References: <20200406124931.120768-1-mst@redhat.com>
 <045c84ed-151e-a850-9c72-5079bd2775e6@redhat.com>
 <20200406095424-mutt-send-email-mst@kernel.org>
 <d171447e-eabc-60ab-6de7-41ac9b82d7d1@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <d171447e-eabc-60ab-6de7-41ac9b82d7d1@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 06, 2020 at 10:09:27PM +0800, Jason Wang wrote:
> 
> On 2020/4/6 下午9:55, Michael S. Tsirkin wrote:
> > On Mon, Apr 06, 2020 at 09:34:00PM +0800, Jason Wang wrote:
> > > On 2020/4/6 下午8:50, Michael S. Tsirkin wrote:
> > > > The ring element addresses are passed between components with different
> > > > alignments assumptions. Thus, if guest/userspace selects a pointer and
> > > > host then gets and dereferences it, we might need to decrease the
> > > > compiler-selected alignment to prevent compiler on the host from
> > > > assuming pointer is aligned.
> > > > 
> > > > This actually triggers on ARM with -mabi=apcs-gnu - which is a
> > > > deprecated configuration, but it seems safer to handle this
> > > > generally.
> > > > 
> > > > I verified that the produced binary is exactly identical on x86.
> > > > 
> > > > Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> > > > ---
> > > > 
> > > > This is my preferred way to handle the ARM incompatibility issues
> > > > (in preference to kconfig hacks).
> > > > I will push this into next now.
> > > > Comments?
> > > 
> > > I'm not sure if it's too late to fix. It would still be still problematic
> > > for the userspace that is using old uapi headers?
> > > 
> > > Thanks
> > It's not a problem in userspace. The problem is when
> > userspace/guest uses 2 byte alignment and passes it to kernel
> > assuming 8 byte alignment. The fix is for host not to
> > make these assumptions.
> 
> 
> Yes, but I meant when userspace is complied with apcs-gnu, then it still
> assumes 8 byte alignment?
> 
> Thanks


That's not a problem since with vhost userspace is doing the allocation.
So it can increase alignment with no bad effect.

I agree it's probably safest not to touch struct vring at all though.


> 
> > 
> > > >    drivers/vhost/vhost.h            |  6 ++---
> > > >    include/uapi/linux/virtio_ring.h | 41 ++++++++++++++++++++++++--------
> > > >    2 files changed, 34 insertions(+), 13 deletions(-)
> > > > 
> > > > diff --git a/drivers/vhost/vhost.h b/drivers/vhost/vhost.h
> > > > index cc82918158d2..a67bda9792ec 100644
> > > > --- a/drivers/vhost/vhost.h
> > > > +++ b/drivers/vhost/vhost.h
> > > > @@ -74,9 +74,9 @@ struct vhost_virtqueue {
> > > >    	/* The actual ring of buffers. */
> > > >    	struct mutex mutex;
> > > >    	unsigned int num;
> > > > -	struct vring_desc __user *desc;
> > > > -	struct vring_avail __user *avail;
> > > > -	struct vring_used __user *used;
> > > > +	vring_desc_t __user *desc;
> > > > +	vring_avail_t __user *avail;
> > > > +	vring_used_t __user *used;
> > > >    	const struct vhost_iotlb_map *meta_iotlb[VHOST_NUM_ADDRS];
> > > >    	struct vhost_desc *descs;
> > > > diff --git a/include/uapi/linux/virtio_ring.h b/include/uapi/linux/virtio_ring.h
> > > > index 559f42e73315..cd6e0b2eaf2f 100644
> > > > --- a/include/uapi/linux/virtio_ring.h
> > > > +++ b/include/uapi/linux/virtio_ring.h
> > > > @@ -118,16 +118,6 @@ struct vring_used {
> > > >    	struct vring_used_elem ring[];
> > > >    };
> > > > -struct vring {
> > > > -	unsigned int num;
> > > > -
> > > > -	struct vring_desc *desc;
> > > > -
> > > > -	struct vring_avail *avail;
> > > > -
> > > > -	struct vring_used *used;
> > > > -};
> > > > -
> > > >    /* Alignment requirements for vring elements.
> > > >     * When using pre-virtio 1.0 layout, these fall out naturally.
> > > >     */
> > > > @@ -164,6 +154,37 @@ struct vring {
> > > >    #define vring_used_event(vr) ((vr)->avail->ring[(vr)->num])
> > > >    #define vring_avail_event(vr) (*(__virtio16 *)&(vr)->used->ring[(vr)->num])
> > > > +/*
> > > > + * The ring element addresses are passed between components with different
> > > > + * alignments assumptions. Thus, we might need to decrease the compiler-selected
> > > > + * alignment, and so must use a typedef to make sure the __aligned attribute
> > > > + * actually takes hold:
> > > > + *
> > > > + * https://gcc.gnu.org/onlinedocs//gcc/Common-Type-Attributes.html#Common-Type-Attributes
> > > > + *
> > > > + * When used on a struct, or struct member, the aligned attribute can only
> > > > + * increase the alignment; in order to decrease it, the packed attribute must
> > > > + * be specified as well. When used as part of a typedef, the aligned attribute
> > > > + * can both increase and decrease alignment, and specifying the packed
> > > > + * attribute generates a warning.
> > > > + */
> > > > +typedef struct vring_desc __attribute__((aligned(VRING_DESC_ALIGN_SIZE)))
> > > > +	vring_desc_t;
> > > > +typedef struct vring_avail __attribute__((aligned(VRING_AVAIL_ALIGN_SIZE)))
> > > > +	vring_avail_t;
> > > > +typedef struct vring_used __attribute__((aligned(VRING_USED_ALIGN_SIZE)))
> > > > +	vring_used_t;
> > > > +
> > > > +struct vring {
> > > > +	unsigned int num;
> > > > +
> > > > +	vring_desc_t *desc;
> > > > +
> > > > +	vring_avail_t *avail;
> > > > +
> > > > +	vring_used_t *used;
> > > > +};
> > > > +
> > > >    static inline void vring_init(struct vring *vr, unsigned int num, void *p,
> > > >    			      unsigned long align)
> > > >    {

