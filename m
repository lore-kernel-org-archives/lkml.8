Return-Path: <SRS0=shi3=4A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53DEAC2BA83
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Feb 2020 07:30:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 212BF206DB
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Feb 2020 07:30:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="d8Mo/GUN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728368AbgBLHaJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Feb 2020 02:30:09 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:24031 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728192AbgBLHaI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Feb 2020 02:30:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1581492606;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=4x1as1g2yZr98MHN4k/1ke02no9RwRCiPwFENwA3Qiw=;
        b=d8Mo/GUNFX0H05JyVXWOlL6p6UHNn/y6qt+JRP00GAsTP/6lMOSXrYpEc5fA8+VNXfQeBP
        suBBTXujg2t0aW86Hp7EW/ukZVO0HMnuzMXT8xGqLAZdL2UYPIkyMGrBa807VR1oWJ/YlZ
        GN4gSs8PeRZEqUmCHu3Xo81e8NJmAxc=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-29-Hadk0rR6NpqdmnIcbRd3gA-1; Wed, 12 Feb 2020 02:30:05 -0500
X-MC-Unique: Hadk0rR6NpqdmnIcbRd3gA-1
Received: by mail-qt1-f198.google.com with SMTP id x8so699007qtq.14
        for <linux-kernel@vger.kernel.org>; Tue, 11 Feb 2020 23:30:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=4x1as1g2yZr98MHN4k/1ke02no9RwRCiPwFENwA3Qiw=;
        b=sSFggiOShQhUT3LaFyrKGZN+BFo218ScmQMbAgHJg42FFw3mq/gTKUHbSIZT5cI5jP
         Zrcqq/QhWflXhEPk9ysMGPTerrnwx8p9jitzua1koc3e1jVZI46QjsiYjZwl+UTcip3R
         UZUGpsodvyUf59U/9tWRoqN18zJKkE4D+tAR3kZXM7Swmk3P+CC+Q/kS/ZWGO2eJYFZl
         eJ3jUTyTTiQ48cyFCCko6QobQ3KEPvJrtvjhvLhsHsOTTmPCgLyFFferATM7wQWINp+v
         LH/BKZ018MSxAA6rxI7RLniPC8PvNPi9OuyEKRsv8dIW2GEhtKGXb30L6big4AxR1KLn
         o/Zw==
X-Gm-Message-State: APjAAAVMd0kMOTVV4iFV1okJDR/ihX9Ct0S4eQs1Y8CrkjL97CFECa45
        BF4/aCYs+ayh9pxBDxRO8rSX9a9cOcKfZ88pzNmFQh6oAoKRHFH2xxTBw7uZvmsbxtoxV0DujsF
        LMRCOBdzgoUZBbgpM6bNlUllE
X-Received: by 2002:ac8:969:: with SMTP id z38mr17806309qth.203.1581492603951;
        Tue, 11 Feb 2020 23:30:03 -0800 (PST)
X-Google-Smtp-Source: APXvYqwBSlkyW/UAB2wFI1BlviEOXV5VuXHDYwkwFSa1AA0YFbOLTQt3Gy0zGbRq/HqurS0H3MZ2ew==
X-Received: by 2002:ac8:969:: with SMTP id z38mr17806294qth.203.1581492603714;
        Tue, 11 Feb 2020 23:30:03 -0800 (PST)
Received: from redhat.com (bzq-79-176-41-183.red.bezeqint.net. [79.176.41.183])
        by smtp.gmail.com with ESMTPSA id n4sm3602146qti.55.2020.02.11.23.30.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Feb 2020 23:30:02 -0800 (PST)
Date:   Wed, 12 Feb 2020 02:29:58 -0500
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     "Liu, Jing2" <jing2.liu@linux.intel.com>
Cc:     Zha Bin <zhabin@linux.alibaba.com>, linux-kernel@vger.kernel.org,
        jasowang@redhat.com, slp@redhat.com,
        virtio-dev@lists.oasis-open.org, qemu-devel@nongnu.org,
        gerry@linux.alibaba.com, chao.p.peng@linux.intel.com
Subject: Re: [virtio-dev] Re: [PATCH v2 2/5] virtio-mmio: refactor common
 functionality
Message-ID: <20200212022842-mutt-send-email-mst@kernel.org>
References: <cover.1581305609.git.zhabin@linux.alibaba.com>
 <0268807dc26ecdf5620de9000758d05ca0b21f3f.1581305609.git.zhabin@linux.alibaba.com>
 <20200211061758-mutt-send-email-mst@kernel.org>
 <787bac48-3fd0-316a-a99a-8c93154dc8e2@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <787bac48-3fd0-316a-a99a-8c93154dc8e2@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 12, 2020 at 10:58:13AM +0800, Liu, Jing2 wrote:
> 
> On 2/11/2020 7:19 PM, Michael S. Tsirkin wrote:
> > On Mon, Feb 10, 2020 at 05:05:18PM +0800, Zha Bin wrote:
> > > From: Liu Jiang <gerry@linux.alibaba.com>
> > > 
> > > Common functionality is refactored into virtio_mmio_common.h
> > > in order to MSI support in later patch set.
> > > 
> > > Signed-off-by: Liu Jiang <gerry@linux.alibaba.com>
> > > Co-developed-by: Zha Bin <zhabin@linux.alibaba.com>
> > > Signed-off-by: Zha Bin <zhabin@linux.alibaba.com>
> > > Co-developed-by: Jing Liu <jing2.liu@linux.intel.com>
> > > Signed-off-by: Jing Liu <jing2.liu@linux.intel.com>
> > > Co-developed-by: Chao Peng <chao.p.peng@linux.intel.com>
> > > Signed-off-by: Chao Peng <chao.p.peng@linux.intel.com>
> > What does this proliferation of header files achieve?
> > common with what?
> 
> We're considering that the virtio mmio structure is useful for virtio mmio
> msi file so refactor out.

I would not put msi in a separate file either.

> e.g. to get the base of virtio_mmio_device from struct msi_desc *desc.
> 
> Jing
> 
> 
> > > ---
> > >   drivers/virtio/virtio_mmio.c        | 21 +--------------------
> > >   drivers/virtio/virtio_mmio_common.h | 31 +++++++++++++++++++++++++++++++
> > >   2 files changed, 32 insertions(+), 20 deletions(-)
> > >   create mode 100644 drivers/virtio/virtio_mmio_common.h
> > > 
> > > diff --git a/drivers/virtio/virtio_mmio.c b/drivers/virtio/virtio_mmio.c
> > > index 1733ab97..41e1c93 100644
> > > --- a/drivers/virtio/virtio_mmio.c
> > > +++ b/drivers/virtio/virtio_mmio.c
> > > @@ -61,13 +61,12 @@
> > >   #include <linux/io.h>
> > >   #include <linux/list.h>
> > >   #include <linux/module.h>
> > > -#include <linux/platform_device.h>
> > >   #include <linux/slab.h>
> > >   #include <linux/spinlock.h>
> > > -#include <linux/virtio.h>
> > >   #include <linux/virtio_config.h>
> > >   #include <uapi/linux/virtio_mmio.h>
> > >   #include <linux/virtio_ring.h>
> > > +#include "virtio_mmio_common.h"
> > > @@ -77,24 +76,6 @@
> > > -#define to_virtio_mmio_device(_plat_dev) \
> > > -	container_of(_plat_dev, struct virtio_mmio_device, vdev)
> > > -
> > > -struct virtio_mmio_device {
> > > -	struct virtio_device vdev;
> > > -	struct platform_device *pdev;
> > > -
> > > -	void __iomem *base;
> > > -	unsigned long version;
> > > -
> > > -	/* a list of queues so we can dispatch IRQs */
> > > -	spinlock_t lock;
> > > -	struct list_head virtqueues;
> > > -
> > > -	unsigned short notify_base;
> > > -	unsigned short notify_multiplier;
> > > -};
> > > -
> > >   struct virtio_mmio_vq_info {
> > >   	/* the actual virtqueue */
> > >   	struct virtqueue *vq;
> > > diff --git a/drivers/virtio/virtio_mmio_common.h b/drivers/virtio/virtio_mmio_common.h
> > > new file mode 100644
> > > index 0000000..90cb304
> > > --- /dev/null
> > > +++ b/drivers/virtio/virtio_mmio_common.h
> > > @@ -0,0 +1,31 @@
> > > +/* SPDX-License-Identifier: GPL-2.0-or-later */
> > > +#ifndef _DRIVERS_VIRTIO_VIRTIO_MMIO_COMMON_H
> > > +#define _DRIVERS_VIRTIO_VIRTIO_MMIO_COMMON_H
> > > +/*
> > > + * Virtio MMIO driver - common functionality for all device versions
> > > + *
> > > + * This module allows virtio devices to be used over a memory-mapped device.
> > > + */
> > > +
> > > +#include <linux/platform_device.h>
> > > +#include <linux/virtio.h>
> > > +
> > > +#define to_virtio_mmio_device(_plat_dev) \
> > > +	container_of(_plat_dev, struct virtio_mmio_device, vdev)
> > > +
> > > +struct virtio_mmio_device {
> > > +	struct virtio_device vdev;
> > > +	struct platform_device *pdev;
> > > +
> > > +	void __iomem *base;
> > > +	unsigned long version;
> > > +
> > > +	/* a list of queues so we can dispatch IRQs */
> > > +	spinlock_t lock;
> > > +	struct list_head virtqueues;
> > > +
> > > +	unsigned short notify_base;
> > > +	unsigned short notify_multiplier;
> > > +};
> > > +
> > > +#endif
> > > -- 
> > > 1.8.3.1
> > 
> > ---------------------------------------------------------------------
> > To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
> > For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org
> > 

