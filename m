Return-Path: <SRS0=Cjtw=7V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9165BC433E1
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jun 2020 01:33:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 68D7E2075A
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jun 2020 01:33:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="B5UxJNKy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728629AbgFHBdX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 7 Jun 2020 21:33:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727972AbgFHBdV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 7 Jun 2020 21:33:21 -0400
Received: from mail-qt1-x844.google.com (mail-qt1-x844.google.com [IPv6:2607:f8b0:4864:20::844])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67988C08C5C3
        for <linux-kernel@vger.kernel.org>; Sun,  7 Jun 2020 18:33:21 -0700 (PDT)
Received: by mail-qt1-x844.google.com with SMTP id e16so13531241qtg.0
        for <linux-kernel@vger.kernel.org>; Sun, 07 Jun 2020 18:33:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=lWjZ0ATSaEye0Bi2OFiSChYlU/sVI6QI0KBmWOw2/ME=;
        b=B5UxJNKy+Gku93rPNEm+OScpi1AgEe9k+fedHSTZjhSZKs+0NOi77JqT3RVE7UJQHz
         gX8Nd82uP8BI34gepu9gQsaTgthEVw1ScOJ+vV5HRSOIMVZUEBJtHAvRnz4u5RbNWpYq
         TASQxquIYZ+4NleP6+w1br6oU0gJcj07/F7gg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=lWjZ0ATSaEye0Bi2OFiSChYlU/sVI6QI0KBmWOw2/ME=;
        b=lu0diHPkrXNMfJj7rdM7tcXkZDeb9f1SCIT17Qk8SE2zXUO0WpiprJgyR+G5kwlSbC
         wP1kN+T5+33Oil/D/yMsd5NqKU/xN72FiyYIuY3wqaOLJm5KphtzASsLVClu+OZrF3B7
         kH0ArgPH2ZkEeaC1ZKzaxV8eA0kZa5b/5CAqILIPOymzL1pewDxqYddjJLJniFeafpZz
         +nxI4dTxVk3yudwFgtmGIrDgfLTp5LWvv5jxcTsAiot6L7S7QvWEDJOhHLom1ZDA6il1
         G9L75fOH6c2qU9D/DvCbczwM46ldAZ0PLaX58zbAlymFdij635ckm5Vzzm51XknpO4uU
         y2mA==
X-Gm-Message-State: AOAM5308E7EgOpZ6/gcOiDnw1UaHok8OWCPGbY765xHhxZI4Zt3Ph7qv
        qmM18x/te1jVz0+5Qt7WR3jYs8Qp5O//wTrkmU48dA==
X-Google-Smtp-Source: ABdhPJw4OhRhvJvUEtwywNu0NEGhO7Zgx4/6suiIs89J/Z3riECqRRbSUeDB2bVSSaqL0ISmU4q4EcJtUtS32ixDf8U=
X-Received: by 2002:aed:21a4:: with SMTP id l33mr17978554qtc.72.1591580000574;
 Sun, 07 Jun 2020 18:33:20 -0700 (PDT)
MIME-Version: 1.0
References: <20200526105811.30784-1-stevensd@chromium.org> <20200526105811.30784-2-stevensd@chromium.org>
 <20200604145620-mutt-send-email-mst@kernel.org> <CAD=HUj74mKs5AfcViD3CBva86E0Hvg_pmYChAJe3ny8jtnZ8Tw@mail.gmail.com>
 <20200606160155-mutt-send-email-mst@kernel.org>
In-Reply-To: <20200606160155-mutt-send-email-mst@kernel.org>
From:   David Stevens <stevensd@chromium.org>
Date:   Mon, 8 Jun 2020 10:33:09 +0900
Message-ID: <CAD=HUj5Jn+grQVfxmPSSnERdGwnu8RceDsdpWpoxXH+WL4k+qw@mail.gmail.com>
Subject: Re: [PATCH v4 1/3] virtio: add dma-buf support for exported objects
To:     "Michael S. Tsirkin" <mst@redhat.com>
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
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jun 7, 2020 at 5:04 AM Michael S. Tsirkin <mst@redhat.com> wrote:
>
> On Fri, Jun 05, 2020 at 10:28:42AM +0900, David Stevens wrote:
> > On Fri, Jun 5, 2020 at 4:05 AM Michael S. Tsirkin <mst@redhat.com> wrote:
> > >
> > > On Tue, May 26, 2020 at 07:58:09PM +0900, David Stevens wrote:
> > > > This change adds a new flavor of dma-bufs that can be used by virtio
> > > > drivers to share exported objects. A virtio dma-buf can be queried by
> > > > virtio drivers to obtain the UUID which identifies the underlying
> > > > exported object.
> > > >
> > > > Signed-off-by: David Stevens <stevensd@chromium.org>
> > >
> > > Is this just for graphics? If yes I'd rather we put it in the graphics
> > > driver. We can always move it later ...
> >
> > As stated in the cover letter, this will be used by virtio-video.
> >
> > The proposed virtio-video patches: https://markmail.org/thread/p5d3k566srtdtute
> > The patch which imports these dma-bufs (slightly out of data, uses v3
> > of this patch set): https://markmail.org/thread/j4xlqaaim266qpks
> >
> > > > ---
> > > >  drivers/virtio/Makefile         |  2 +-
> > > >  drivers/virtio/virtio.c         |  6 +++
> > > >  drivers/virtio/virtio_dma_buf.c | 89 +++++++++++++++++++++++++++++++++
> > > >  include/linux/virtio.h          |  1 +
> > > >  include/linux/virtio_dma_buf.h  | 58 +++++++++++++++++++++
> > > >  5 files changed, 155 insertions(+), 1 deletion(-)
> > > >  create mode 100644 drivers/virtio/virtio_dma_buf.c
> > > >  create mode 100644 include/linux/virtio_dma_buf.h
> > > >
> > > > diff --git a/drivers/virtio/Makefile b/drivers/virtio/Makefile
> > > > index 29a1386ecc03..ecdae5b596de 100644
> > > > --- a/drivers/virtio/Makefile
> > > > +++ b/drivers/virtio/Makefile
> > > > @@ -1,5 +1,5 @@
> > > >  # SPDX-License-Identifier: GPL-2.0
> > > > -obj-$(CONFIG_VIRTIO) += virtio.o virtio_ring.o
> > > > +obj-$(CONFIG_VIRTIO) += virtio.o virtio_ring.o virtio_dma_buf.o
> > > >  obj-$(CONFIG_VIRTIO_MMIO) += virtio_mmio.o
> > > >  obj-$(CONFIG_VIRTIO_PCI) += virtio_pci.o
> > > >  virtio_pci-y := virtio_pci_modern.o virtio_pci_common.o
> > > > diff --git a/drivers/virtio/virtio.c b/drivers/virtio/virtio.c
> > > > index a977e32a88f2..5d46f0ded92d 100644
> > > > --- a/drivers/virtio/virtio.c
> > > > +++ b/drivers/virtio/virtio.c
> > > > @@ -357,6 +357,12 @@ int register_virtio_device(struct virtio_device *dev)
> > > >  }
> > > >  EXPORT_SYMBOL_GPL(register_virtio_device);
> > > >
> > > > +bool is_virtio_device(struct device *dev)
> > > > +{
> > > > +     return dev->bus == &virtio_bus;
> > > > +}
> > > > +EXPORT_SYMBOL_GPL(is_virtio_device);
> > > > +
> > > >  void unregister_virtio_device(struct virtio_device *dev)
> > > >  {
> > > >       int index = dev->index; /* save for after device release */
> > > > diff --git a/drivers/virtio/virtio_dma_buf.c b/drivers/virtio/virtio_dma_buf.c
> > > > new file mode 100644
> > > > index 000000000000..23e3399b11ed
> > > > --- /dev/null
> > > > +++ b/drivers/virtio/virtio_dma_buf.c
> > > > @@ -0,0 +1,89 @@
> > > > +// SPDX-License-Identifier: GPL-2.0-or-later
> > > > +/*
> > > > + * dma-bufs for virtio exported objects
> > > > + *
> > > > + * Copyright (C) 2020 Google, Inc.
> > > > + */
> > > > +
> > > > +#include <linux/virtio_dma_buf.h>
> > > > +
> > > > +/**
> > > > + * virtio_dma_buf_export - Creates a new dma-buf for a virtio exported object
> > > > + *
> > > > + * This wraps dma_buf_export() to allow virtio drivers to create a dma-buf
> > > > + * for an virtio exported object that can be queried by other virtio drivers
> > > > + * for the object's UUID.
> > > > + */
> > > > +struct dma_buf *virtio_dma_buf_export(
> > > > +             const struct virtio_dma_buf_export_info *virtio_exp_info)
> > > > +{
> > > > +     struct dma_buf_export_info exp_info;
> > > > +
> > > > +     if (!virtio_exp_info->ops
> > > > +             || virtio_exp_info->ops->ops.attach != &virtio_dma_buf_attach
> > > > +             || !virtio_exp_info->ops->get_uuid) {
> > > > +             return ERR_PTR(-EINVAL);
> > > > +     }
> > > > +
> > > > +     exp_info.exp_name = virtio_exp_info->exp_name;
> > > > +     exp_info.owner = virtio_exp_info->owner;
> > > > +     exp_info.ops = &virtio_exp_info->ops->ops;
> > > > +     exp_info.size = virtio_exp_info->size;
> > > > +     exp_info.flags = virtio_exp_info->flags;
> > > > +     exp_info.resv = virtio_exp_info->resv;
> > > > +     exp_info.priv = virtio_exp_info->priv;
> > > > +     BUILD_BUG_ON(sizeof(struct virtio_dma_buf_export_info)
> > > > +                  != sizeof(struct dma_buf_export_info));
> > >
> > > This is the only part that gives me pause. Why do we need this hack?
> > > What's wrong with just using dma_buf_export_info directly,
> > > and if you want the virtio ops, just using container_off?
> >
> > This approach provides a more explicit type signature and a little
> > more type safety, I think. If others don't think it's a worthwhile
> > tradeoff, I can remove it.
> >
> > -David
>
> The cost is that if dma_buf_export_info changes even slightly, we get
> weird crashes.

I'm not sure I understand what types of changes you're referring to.
As this is written, virtio-dma-buf is just another client of the
dma-buf API. If this were rewritten to use dma-buf directly, then
whatever code calls virtio_dma_buf_export would become a client of the
dma-buf API. If the semantics of existing fields in the dma-buf API
were changed and virtio-dma-buf wasn't updated, then yes, you could
get weird crashes from virtio-dma-buf. However, the same problem would
exist if virtio_dma_buf_export used dma-buf directly - changes to
dma-buf's semantics could cause weird crashes if the caller of
virtio_dma_buf_export wasn't updated properly. The only potential
source of problems I see is if virtio_dma_buf_export_info wasn't
updated properly, but virtio_dma_buf_export_info is dead simple, so I
don't know if that's really a problem.

-David
