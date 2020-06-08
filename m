Return-Path: <SRS0=Cjtw=7V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 917EFC433E1
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jun 2020 06:01:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 632262076A
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jun 2020 06:01:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RbwZ3So2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728916AbgFHGBB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Jun 2020 02:01:01 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:26392 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728343AbgFHGA6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Jun 2020 02:00:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1591596057;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=qV8rF1/p3MMAv+wx7e3r1Z9xxn/0nhBh79pwnRKPuUs=;
        b=RbwZ3So2vfFdWKpn+RkvjU22flcyCkk9OB13xoTG+5HCs/bojZZoFT/CccQjuLq8PA8dVw
        kgXwaSUwEqiikCzEPpy4SGmRExr65/Wi6zQPyCGD5WnlrV/hzrizyJbBjAtUiR+gfA/iVs
        5Js0gRj1Trd3jw6JYB8Mhima33KvlS0=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-282-nvlsdkegOzeH-P-VI8txJg-1; Mon, 08 Jun 2020 02:00:52 -0400
X-MC-Unique: nvlsdkegOzeH-P-VI8txJg-1
Received: by mail-wr1-f71.google.com with SMTP id p10so6720260wrn.19
        for <linux-kernel@vger.kernel.org>; Sun, 07 Jun 2020 23:00:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=qV8rF1/p3MMAv+wx7e3r1Z9xxn/0nhBh79pwnRKPuUs=;
        b=MJfnZv3Iw35CjtpXS1KC7ao1kbbfKSLEEc2DqdkDkLnEsPATsL5+R5i1lEqq6VUgo1
         sRzCUU6Bb+VakvVN8p70AKQcVZBBOjWrNe43NnvZF5gwRXUit5n/OwbC05bVHnlKrwKI
         4RjoaCd29ubMS7dUblkANrt/6/6Xy9W+cc7KzNAK9zpIT+tT1VD/nzfyC/oOXKy3c4HE
         +Siq/GPkvcCkS9/7eAzqhA8jeg7XmpKKnjEDE/PCQAvN6ubof0tZMBwBsRsZ5GO4gUya
         ZzWK7eFFprZ7koyeF8H5rrUtgC/q/iuK/v7mCua1PJYg6lg2zqhOnGF8TrmtbxU6+RxR
         Bhdw==
X-Gm-Message-State: AOAM531AkdhKpEfbtgUZp05/QBXkW7V4jr/hVj1eNGLSm+V89MeWn8f8
        Au7E5MzGWbZTMUqWVSCc4TEzXLrE4CYa1QfsqoTjCuCmb0osHESjB9BB2MWA/efSV5fogDcvTAw
        6/iuo7Orpl0GxqkwtenlPycpS
X-Received: by 2002:a05:6000:10cf:: with SMTP id b15mr21274510wrx.214.1591596051340;
        Sun, 07 Jun 2020 23:00:51 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzWwJuu90GiCa8Q3NNZkxIe2jccFeKD/lqncyqyhq/gOI8E1jgXUiYlIT9zREhMBPq6kfSAAA==
X-Received: by 2002:a05:6000:10cf:: with SMTP id b15mr21274481wrx.214.1591596051013;
        Sun, 07 Jun 2020 23:00:51 -0700 (PDT)
Received: from redhat.com (bzq-109-64-41-91.red.bezeqint.net. [109.64.41.91])
        by smtp.gmail.com with ESMTPSA id v19sm20932997wml.26.2020.06.07.23.00.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 07 Jun 2020 23:00:50 -0700 (PDT)
Date:   Mon, 8 Jun 2020 02:00:47 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     David Stevens <stevensd@chromium.org>
Cc:     Gerd Hoffmann <kraxel@redhat.com>, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        Jason Wang <jasowang@redhat.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        open list <linux-kernel@vger.kernel.org>,
        ML dri-devel <dri-devel@lists.freedesktop.org>,
        "open list:VIRTIO GPU DRIVER" 
        <virtualization@lists.linux-foundation.org>,
        Linux Media Mailing List <linux-media@vger.kernel.org>,
        "moderated list:DMA BUFFER SHARING FRAMEWORK" 
        <linaro-mm-sig@lists.linaro.org>, virtio-dev@lists.oasis-open.org
Subject: Re: [PATCH v4 1/3] virtio: add dma-buf support for exported objects
Message-ID: <20200608015728-mutt-send-email-mst@kernel.org>
References: <20200526105811.30784-1-stevensd@chromium.org>
 <20200526105811.30784-2-stevensd@chromium.org>
 <20200604145620-mutt-send-email-mst@kernel.org>
 <CAD=HUj74mKs5AfcViD3CBva86E0Hvg_pmYChAJe3ny8jtnZ8Tw@mail.gmail.com>
 <20200606160155-mutt-send-email-mst@kernel.org>
 <CAD=HUj5Jn+grQVfxmPSSnERdGwnu8RceDsdpWpoxXH+WL4k+qw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAD=HUj5Jn+grQVfxmPSSnERdGwnu8RceDsdpWpoxXH+WL4k+qw@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 08, 2020 at 10:33:09AM +0900, David Stevens wrote:
> On Sun, Jun 7, 2020 at 5:04 AM Michael S. Tsirkin <mst@redhat.com> wrote:
> >
> > On Fri, Jun 05, 2020 at 10:28:42AM +0900, David Stevens wrote:
> > > On Fri, Jun 5, 2020 at 4:05 AM Michael S. Tsirkin <mst@redhat.com> wrote:
> > > >
> > > > On Tue, May 26, 2020 at 07:58:09PM +0900, David Stevens wrote:
> > > > > This change adds a new flavor of dma-bufs that can be used by virtio
> > > > > drivers to share exported objects. A virtio dma-buf can be queried by
> > > > > virtio drivers to obtain the UUID which identifies the underlying
> > > > > exported object.
> > > > >
> > > > > Signed-off-by: David Stevens <stevensd@chromium.org>
> > > >
> > > > Is this just for graphics? If yes I'd rather we put it in the graphics
> > > > driver. We can always move it later ...
> > >
> > > As stated in the cover letter, this will be used by virtio-video.
> > >
> > > The proposed virtio-video patches: https://markmail.org/thread/p5d3k566srtdtute
> > > The patch which imports these dma-bufs (slightly out of data, uses v3
> > > of this patch set): https://markmail.org/thread/j4xlqaaim266qpks
> > >
> > > > > ---
> > > > >  drivers/virtio/Makefile         |  2 +-
> > > > >  drivers/virtio/virtio.c         |  6 +++
> > > > >  drivers/virtio/virtio_dma_buf.c | 89 +++++++++++++++++++++++++++++++++
> > > > >  include/linux/virtio.h          |  1 +
> > > > >  include/linux/virtio_dma_buf.h  | 58 +++++++++++++++++++++
> > > > >  5 files changed, 155 insertions(+), 1 deletion(-)
> > > > >  create mode 100644 drivers/virtio/virtio_dma_buf.c
> > > > >  create mode 100644 include/linux/virtio_dma_buf.h
> > > > >
> > > > > diff --git a/drivers/virtio/Makefile b/drivers/virtio/Makefile
> > > > > index 29a1386ecc03..ecdae5b596de 100644
> > > > > --- a/drivers/virtio/Makefile
> > > > > +++ b/drivers/virtio/Makefile
> > > > > @@ -1,5 +1,5 @@
> > > > >  # SPDX-License-Identifier: GPL-2.0
> > > > > -obj-$(CONFIG_VIRTIO) += virtio.o virtio_ring.o
> > > > > +obj-$(CONFIG_VIRTIO) += virtio.o virtio_ring.o virtio_dma_buf.o
> > > > >  obj-$(CONFIG_VIRTIO_MMIO) += virtio_mmio.o
> > > > >  obj-$(CONFIG_VIRTIO_PCI) += virtio_pci.o
> > > > >  virtio_pci-y := virtio_pci_modern.o virtio_pci_common.o
> > > > > diff --git a/drivers/virtio/virtio.c b/drivers/virtio/virtio.c
> > > > > index a977e32a88f2..5d46f0ded92d 100644
> > > > > --- a/drivers/virtio/virtio.c
> > > > > +++ b/drivers/virtio/virtio.c
> > > > > @@ -357,6 +357,12 @@ int register_virtio_device(struct virtio_device *dev)
> > > > >  }
> > > > >  EXPORT_SYMBOL_GPL(register_virtio_device);
> > > > >
> > > > > +bool is_virtio_device(struct device *dev)
> > > > > +{
> > > > > +     return dev->bus == &virtio_bus;
> > > > > +}
> > > > > +EXPORT_SYMBOL_GPL(is_virtio_device);
> > > > > +
> > > > >  void unregister_virtio_device(struct virtio_device *dev)
> > > > >  {
> > > > >       int index = dev->index; /* save for after device release */
> > > > > diff --git a/drivers/virtio/virtio_dma_buf.c b/drivers/virtio/virtio_dma_buf.c
> > > > > new file mode 100644
> > > > > index 000000000000..23e3399b11ed
> > > > > --- /dev/null
> > > > > +++ b/drivers/virtio/virtio_dma_buf.c
> > > > > @@ -0,0 +1,89 @@
> > > > > +// SPDX-License-Identifier: GPL-2.0-or-later
> > > > > +/*
> > > > > + * dma-bufs for virtio exported objects
> > > > > + *
> > > > > + * Copyright (C) 2020 Google, Inc.
> > > > > + */
> > > > > +
> > > > > +#include <linux/virtio_dma_buf.h>
> > > > > +
> > > > > +/**
> > > > > + * virtio_dma_buf_export - Creates a new dma-buf for a virtio exported object
> > > > > + *
> > > > > + * This wraps dma_buf_export() to allow virtio drivers to create a dma-buf
> > > > > + * for an virtio exported object that can be queried by other virtio drivers
> > > > > + * for the object's UUID.
> > > > > + */
> > > > > +struct dma_buf *virtio_dma_buf_export(
> > > > > +             const struct virtio_dma_buf_export_info *virtio_exp_info)
> > > > > +{
> > > > > +     struct dma_buf_export_info exp_info;
> > > > > +
> > > > > +     if (!virtio_exp_info->ops
> > > > > +             || virtio_exp_info->ops->ops.attach != &virtio_dma_buf_attach
> > > > > +             || !virtio_exp_info->ops->get_uuid) {
> > > > > +             return ERR_PTR(-EINVAL);
> > > > > +     }
> > > > > +
> > > > > +     exp_info.exp_name = virtio_exp_info->exp_name;
> > > > > +     exp_info.owner = virtio_exp_info->owner;
> > > > > +     exp_info.ops = &virtio_exp_info->ops->ops;
> > > > > +     exp_info.size = virtio_exp_info->size;
> > > > > +     exp_info.flags = virtio_exp_info->flags;
> > > > > +     exp_info.resv = virtio_exp_info->resv;
> > > > > +     exp_info.priv = virtio_exp_info->priv;
> > > > > +     BUILD_BUG_ON(sizeof(struct virtio_dma_buf_export_info)
> > > > > +                  != sizeof(struct dma_buf_export_info));
> > > >
> > > > This is the only part that gives me pause. Why do we need this hack?
> > > > What's wrong with just using dma_buf_export_info directly,
> > > > and if you want the virtio ops, just using container_off?
> > >
> > > This approach provides a more explicit type signature and a little
> > > more type safety, I think. If others don't think it's a worthwhile
> > > tradeoff, I can remove it.
> > >
> > > -David
> >
> > The cost is that if dma_buf_export_info changes even slightly, we get
> > weird crashes.
> 
> I'm not sure I understand what types of changes you're referring to.
> As this is written, virtio-dma-buf is just another client of the
> dma-buf API. If this were rewritten to use dma-buf directly, then
> whatever code calls virtio_dma_buf_export would become a client of the
> dma-buf API. If the semantics of existing fields in the dma-buf API
> were changed and virtio-dma-buf wasn't updated, then yes, you could
> get weird crashes from virtio-dma-buf.
> However, the same problem would
> exist if virtio_dma_buf_export used dma-buf directly - changes to
> dma-buf's semantics could cause weird crashes if the caller of
> virtio_dma_buf_export wasn't updated properly. The only potential
> source of problems I see is if virtio_dma_buf_export_info wasn't
> updated properly, but virtio_dma_buf_export_info is dead simple, so I
> don't know if that's really a problem.
> 
> -David

I think you can get weird crashes if fields in dma buf are reordered, or
if a field size changes.  You have a build bug catching overall struct
size changes but that can remain the same due do compiler padding or
such.

-- 
MST

