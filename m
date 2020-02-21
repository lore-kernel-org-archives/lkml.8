Return-Path: <SRS0=1210=4J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F392C35656
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Feb 2020 15:57:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 254B3206EF
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Feb 2020 15:57:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YjQiAcNd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729050AbgBUP5A (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Feb 2020 10:57:00 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:46106 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728364AbgBUP5A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Feb 2020 10:57:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1582300618;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=IY1e+IpasDBKdBXY1MmSfqqA042+XMPMI9OlNKO0Qbs=;
        b=YjQiAcNdwGqSjWHyeaFiuQ3Vp5vdMOv5xVG/2nxRd/KusIADYVqfpEcqmWZMiiBUYffU3N
        7jc7ModfpV3on9eykBXEiYVaazD61SevICvV8mptnAgh8dtqmCB0n66mXWsfNil3pImYdQ
        gam9E6T2Aeco9u7UlT+7xIPCgHYJPiI=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-249-gPrtvfyRP5ynZYTlct9CwQ-1; Fri, 21 Feb 2020 10:56:57 -0500
X-MC-Unique: gPrtvfyRP5ynZYTlct9CwQ-1
Received: by mail-qv1-f72.google.com with SMTP id s5so1631598qvr.15
        for <linux-kernel@vger.kernel.org>; Fri, 21 Feb 2020 07:56:57 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=IY1e+IpasDBKdBXY1MmSfqqA042+XMPMI9OlNKO0Qbs=;
        b=nzOoLhuxOD1RP2DPVJKL8a45YHOdV3k1U/GKbLyaLT0ac+57m7k2eA4M2pdAMv6pkN
         x61MAtC5z+R7w2i4GZkbB7kjkDY4qKV2em2cRmM1yX3SpjNVbDcHAehaBPNes8Pm7Xs1
         SzbMbsDxJKWzrfuUc8gC3I3jb05rhtgH7FdO5J8BEMdUXofj91D+Fut+LGFeiV6R/EUl
         YHx7QQn/anBl5pA0OI+mMONzKCevdc6HfdN+TKm2PtQEIpaweWIY1qNZtiHwfXdJro5V
         T0rN4fpUx0ohJccWxgs2qI6Myr/ueck6UBq1jJ0f7Bp5yax6lTRy4HYjMGuJuaIRORum
         bhsw==
X-Gm-Message-State: APjAAAVpTeb/2cqJuixwK+BhMU5mEDYIyG+OjFpojW2mwmGDGUkCa26Z
        U5BaPnKZ+wAOgpcSAHnyOjJWBccTiYDegQZTM/kK+NdVgZnPnGrOaSK6iB6CAfl6yPaw3QgxRsH
        +zGVbYCMNYksAx8aEry87v8Rh
X-Received: by 2002:a37:903:: with SMTP id 3mr34303245qkj.388.1582300616576;
        Fri, 21 Feb 2020 07:56:56 -0800 (PST)
X-Google-Smtp-Source: APXvYqw7hKwRKDnx5YP1WMu4iLdwz2u2ubysXuXBnyyriKxZbi7qofpxbarVNM7JFowLgzZ6blC18w==
X-Received: by 2002:a37:903:: with SMTP id 3mr34303200qkj.388.1582300616024;
        Fri, 21 Feb 2020 07:56:56 -0800 (PST)
Received: from redhat.com (bzq-109-67-14-209.red.bezeqint.net. [109.67.14.209])
        by smtp.gmail.com with ESMTPSA id k50sm1707012qtc.90.2020.02.21.07.56.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Feb 2020 07:56:54 -0800 (PST)
Date:   Fri, 21 Feb 2020 10:56:45 -0500
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Halil Pasic <pasic@linux.ibm.com>
Cc:     Jason Wang <jasowang@redhat.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Christoph Hellwig <hch@lst.de>, linux-s390@vger.kernel.org,
        virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Janosch Frank <frankja@linux.ibm.com>,
        Viktor Mihajlovski <mihajlov@linux.ibm.com>,
        Cornelia Huck <cohuck@redhat.com>,
        Ram Pai <linuxram@us.ibm.com>,
        Thiago Jung Bauermann <bauerman@linux.ibm.com>,
        David Gibson <david@gibson.dropbear.id.au>,
        "Lendacky, Thomas" <Thomas.Lendacky@amd.com>,
        Michael Mueller <mimu@linux.ibm.com>
Subject: Re: [PATCH 2/2] virtio: let virtio use DMA API when guest RAM is
 protected
Message-ID: <20200221104901-mutt-send-email-mst@kernel.org>
References: <20200220160606.53156-1-pasic@linux.ibm.com>
 <20200220160606.53156-3-pasic@linux.ibm.com>
 <20200220154904-mutt-send-email-mst@kernel.org>
 <20200221141230.13eebc35.pasic@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200221141230.13eebc35.pasic@linux.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 21, 2020 at 02:12:30PM +0100, Halil Pasic wrote:
> On Thu, 20 Feb 2020 15:55:14 -0500
> "Michael S. Tsirkin" <mst@redhat.com> wrote:
> 
> > On Thu, Feb 20, 2020 at 05:06:06PM +0100, Halil Pasic wrote:
> > > Currently the advanced guest memory protection technologies (AMD SEV,
> > > powerpc secure guest technology and s390 Protected VMs) abuse the
> > > VIRTIO_F_IOMMU_PLATFORM flag to make virtio core use the DMA API, which
> > > is in turn necessary, to make IO work with guest memory protection.
> > > 
> > > But VIRTIO_F_IOMMU_PLATFORM a.k.a. VIRTIO_F_ACCESS_PLATFORM is really a
> > > different beast: with virtio devices whose implementation runs on an SMP
> > > CPU we are still fine with doing all the usual optimizations, it is just
> > > that we need to make sure that the memory protection mechanism does not
> > > get in the way. The VIRTIO_F_ACCESS_PLATFORM mandates more work on the
> > > side of the guest (and possibly he host side as well) than we actually
> > > need.
> > > 
> > > An additional benefit of teaching the guest to make the right decision
> > > (and use DMA API) on it's own is: removing the need, to mandate special
> > > VM configuration for guests that may run with protection. This is
> > > especially interesting for s390 as VIRTIO_F_IOMMU_PLATFORM pushes all
> > > the virtio control structures into the first 2G of guest memory:
> > > something we don't necessarily want to do per-default.
> > > 
> > > Signed-off-by: Halil Pasic <pasic@linux.ibm.com>
> > > Tested-by: Ram Pai <linuxram@us.ibm.com>
> > > Tested-by: Michael Mueller <mimu@linux.ibm.com>
> > 
> > This might work for you but it's fragile, since without
> > VIRTIO_F_ACCESS_PLATFORM hypervisor assumes it gets
> > GPA's, not DMA addresses.
> > 
> 
> Thanks for your constructive approach. I do want the hypervisor to
> assume it gets GPA's. My train of thought was that the guys that need
> to use IOVA's that are not GPA's when force_dma_unencrypted() will have
> to to specify VIRTIO_F_ACCESS_PLATFORM (at the device) anyway, because
> otherwise it won't work. But I see your point: in case of a
> mis-configuration and provided the DMA API returns IOVA's one could end
> up trying to touch wrong memory locations. But this should be similar to
> what would happen if DMA ops are not used, and memory is not made accessible.
> 
> > 
> > 
> > IOW this looks like another iteration of:
> > 
> > 	virtio: Support encrypted memory on powerpc secure guests
> > 
> > which I was under the impression was abandoned as unnecessary.
> 
> Unnecessary for powerpc because they do normal PCI. In the context of
> CCW there are only guest physical addresses (CCW I/O has no concept of
> IOMMU or IOVAs).
> 
> > 
> > 
> > To summarize, the necessary conditions for a hack along these lines
> > (using DMA API without VIRTIO_F_ACCESS_PLATFORM) are that we detect that:
> > 
> >   - secure guest mode is enabled - so we know that since we don't share
> >     most memory regular virtio code won't
> >     work, even though the buggy hypervisor didn't set VIRTIO_F_ACCESS_PLATFORM
> 
> force_dma_unencrypted(&vdev->dev) is IMHO exactly about this.
> 
> >   - DMA API is giving us addresses that are actually also physical
> >     addresses
> 
> In case of s390 this is given.
> I talked with the power people before
> posting this, and they ensured me they can are willing to deal with
> this. I was hoping to talk abut this with the AMD SEV people here (hence
> the cc).

We'd need a part of DMA API that promises this though. Platform
maintainers aren't going to go out of their way to do the
right thing just for virtio, and I can't track all arches
to make sure they don't violate virtio requirements.

> 
> >   - Hypervisor is buggy and didn't enable VIRTIO_F_ACCESS_PLATFORM
> > 
> 
> I don't get this point. The argument where the hypervisor is buggy is a
> bit hard to follow for me. If hypervisor is buggy we have already lost
> anyway most of the time, or?

If VIRTIO_F_ACCESS_PLATFORM is set then things just work.  If
VIRTIO_F_ACCESS_PLATFORM is clear device is supposed to have access to
all of memory.  You can argue in various ways but it's easier to just
declare a behaviour that violates this a bug. Which might still be worth
working around, for various reasons.


> > I don't see how this patch does this.
> 
> I do get your point. I don't know of a good way to check that DMA API
> is giving us addresses that are actually physical addresses, and the
> situation you describe definitely has some risk to it.

One way would be to extend the DMA API with such an API.

Another would be to make virtio always use DMA API
and hide the logic in there.
This second approach is not easy, in particular since DMA API adds
a bunch of overhead which we need to find ways to
measure and mitigate.


> 
> Let me comment on other ideas that came up. I would be very happy to go
> with the best one. Thank you very much.
> 
> Regards,
> Halil
> 
> > 
> > 
> > > ---
> > >  drivers/virtio/virtio_ring.c | 3 +++
> > >  1 file changed, 3 insertions(+)
> > > 
> > > diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
> > > index 867c7ebd3f10..fafc8f924955 100644
> > > --- a/drivers/virtio/virtio_ring.c
> > > +++ b/drivers/virtio/virtio_ring.c
> > > @@ -243,6 +243,9 @@ static bool vring_use_dma_api(struct virtio_device *vdev)
> > >  	if (!virtio_has_iommu_quirk(vdev))
> > >  		return true;
> > >  
> > > +	if (force_dma_unencrypted(&vdev->dev))
> > > +		return true;
> > > +
> > >  	/* Otherwise, we are left to guess. */
> > >  	/*
> > >  	 * In theory, it's possible to have a buggy QEMU-supposed
> > > -- 
> > > 2.17.1
> > 

