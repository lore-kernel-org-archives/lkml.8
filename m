Return-Path: <SRS0=1210=4J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2169DC35646
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Feb 2020 15:48:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DE43C206E2
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Feb 2020 15:48:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BRL12zNh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728723AbgBUPsa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Feb 2020 10:48:30 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:49516 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728103AbgBUPsa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Feb 2020 10:48:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1582300109;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=nMuXYm/rPXTbSbIyT257TjmGAho8shid8dR0IC6/tX8=;
        b=BRL12zNhBUbBlEmsB7jtiZ4SRb8DKEfBp8VStdEePZlYi8ofpcXb0iQLFlDYT7fXLGMLFn
        I/Fkly87QJEuqkhi9QTylWXSjrm/l6PebOiAengxXy1iJBOVeCLp03IahFYXowCaE6pJQl
        XIPuQ/H+FfoKm1yjV4jpQVgIWu6eNpU=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-273-A3WJsJVNMiKaRq9bIB9yvQ-1; Fri, 21 Feb 2020 10:48:27 -0500
X-MC-Unique: A3WJsJVNMiKaRq9bIB9yvQ-1
Received: by mail-qv1-f70.google.com with SMTP id r9so1612359qvs.19
        for <linux-kernel@vger.kernel.org>; Fri, 21 Feb 2020 07:48:27 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=nMuXYm/rPXTbSbIyT257TjmGAho8shid8dR0IC6/tX8=;
        b=Sp6K/Ic81aT9KX78nLmDLRWk+ib64prRwE8l96nLMq9NHjrVKwbov+P77Ne1FM6pfN
         we9jCJfPANcAa/YEjxbMKf+EA5W+vLmEn5gEtYYWLrTsPQ5VizhtQ1vM57YRwk/1MWO3
         k8dweqQUoqP4DI+2Delctoadc3Zc4Kec9PvKzfiH6UFfllzRA92jkeDho9WQKAjfS+lR
         vx4kaPB3x38wWt1g/NHiLTuTeg7kGCfVqBhzsqTaf0mbM0ht74F25BHSpsQRHCYPSxOP
         j8eaUeq11HqNNwhGteAdG3oNIx2Pynzs+fH60zyTuQP7h0pETn1WG56XbtBJaxqdwVt3
         zicg==
X-Gm-Message-State: APjAAAVZFCKqCqqefJYRQ3GLK5KnZLiIFGmKKhhWGkO/LYiftrYEjDuR
        Zgv43rnfCXiwYgQ+NfJzNhFlJF68/8JP7JwcMQvKbv7JpC9t6dKTk6OxuklE40lU1vviqng+lAa
        56sfc7RtxZ9O7+Yju4gIFdsnx
X-Received: by 2002:a05:620a:1326:: with SMTP id p6mr13887729qkj.50.1582300107004;
        Fri, 21 Feb 2020 07:48:27 -0800 (PST)
X-Google-Smtp-Source: APXvYqzZ5r0+jwSBeRkygk9EFdnmUIJfdBlfp8mfZ4GFs+3IU6OZoA6wUKcAnfNUKef1wSipRN9KMw==
X-Received: by 2002:a05:620a:1326:: with SMTP id p6mr13887707qkj.50.1582300106779;
        Fri, 21 Feb 2020 07:48:26 -0800 (PST)
Received: from redhat.com (bzq-109-67-14-209.red.bezeqint.net. [109.67.14.209])
        by smtp.gmail.com with ESMTPSA id o55sm1770202qtf.46.2020.02.21.07.48.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Feb 2020 07:48:25 -0800 (PST)
Date:   Fri, 21 Feb 2020 10:48:15 -0500
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Halil Pasic <pasic@linux.ibm.com>
Cc:     David Gibson <david@gibson.dropbear.id.au>,
        Christoph Hellwig <hch@lst.de>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Jason Wang <jasowang@redhat.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Robin Murphy <robin.murphy@arm.com>,
        linux-s390@vger.kernel.org,
        virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org,
        Janosch Frank <frankja@linux.ibm.com>,
        Viktor Mihajlovski <mihajlov@linux.ibm.com>,
        Cornelia Huck <cohuck@redhat.com>,
        Ram Pai <linuxram@us.ibm.com>,
        Thiago Jung Bauermann <bauerman@linux.ibm.com>,
        "Lendacky, Thomas" <Thomas.Lendacky@amd.com>,
        Michael Mueller <mimu@linux.ibm.com>
Subject: Re: [PATCH 1/2] mm: move force_dma_unencrypted() to mem_encrypt.h
Message-ID: <20200221104724-mutt-send-email-mst@kernel.org>
References: <20200220160606.53156-1-pasic@linux.ibm.com>
 <20200220160606.53156-2-pasic@linux.ibm.com>
 <20200220161146.GA12709@lst.de>
 <4369f099-e4e4-4a58-b38b-642cf53ccca6@de.ibm.com>
 <20200220163135.GA13192@lst.de>
 <20200221032727.GC2298@umbus.fritz.box>
 <20200221140639.54928efe.pasic@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200221140639.54928efe.pasic@linux.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 21, 2020 at 02:06:39PM +0100, Halil Pasic wrote:
> On Fri, 21 Feb 2020 14:27:27 +1100
> David Gibson <david@gibson.dropbear.id.au> wrote:
> 
> > On Thu, Feb 20, 2020 at 05:31:35PM +0100, Christoph Hellwig wrote:
> > > On Thu, Feb 20, 2020 at 05:23:20PM +0100, Christian Borntraeger wrote:
> > > > >From a users perspective it makes absolutely perfect sense to use the
> > > > bounce buffers when they are NEEDED. 
> > > > Forcing the user to specify iommu_platform just because you need bounce buffers
> > > > really feels wrong. And obviously we have a severe performance issue
> > > > because of the indirections.
> > > 
> > > The point is that the user should not have to specify iommu_platform.
> > > We need to make sure any new hypervisor (especially one that might require
> > > bounce buffering) always sets it,
> > 
> > So, I have draft qemu patches which enable iommu_platform by default.
> > But that's really because of other problems with !iommu_platform, not
> > anything to do with bounce buffering or secure VMs.
> > 
> > The thing is that the hypervisor *doesn't* require bounce buffering.
> > In the POWER (and maybe s390 as well) models for Secure VMs, it's the
> > *guest*'s choice to enter secure mode, so the hypervisor has no reason
> > to know whether the guest needs bounce buffering.  As far as the
> > hypervisor and qemu are concerned that's a guest internal detail, it
> > just expects to get addresses it can access whether those are GPAs
> > (iommu_platform=off) or IOVAs (iommu_platform=on).
> 
> I very much agree!
> 
> > 
> > > as was a rather bogus legacy hack
> > 
> > It was certainly a bad idea, but it was a bad idea that went into a
> > public spec and has been widely deployed for many years.  We can't
> > just pretend it didn't happen and move on.
> > 
> > Turning iommu_platform=on by default breaks old guests, some of which
> > we still care about.  We can't (automatically) do it only for guests
> > that need bounce buffering, because the hypervisor doesn't know that
> > ahead of time.
> 
> Turning iommu_platform=on for virtio-ccw makes no sense whatsover,
> because for CCW I/O there is no such thing as IOMMU and the addresses
> are always physical addresses.

Fix the name then. The spec calls is ACCESS_PLATFORM now, which
makes much more sense.

> > 
> > > that isn't extensibe for cases that for example require bounce buffering.
> > 
> > In fact bounce buffering isn't really the issue from the hypervisor
> > (or spec's) point of view.  It's the fact that not all of guest memory
> > is accessible to the hypervisor.  Bounce buffering is just one way the
> > guest might deal with that.
> > 
> 
> Agreed.
> 
> Regards,
> Halil
> 
> 
> 


