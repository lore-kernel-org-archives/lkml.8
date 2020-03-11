Return-Path: <SRS0=Ktsx=44=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 330F9C0044D
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Mar 2020 22:44:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 25339206E7
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Mar 2020 22:44:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="bj/AQ/Qc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387476AbgCKWoo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Mar 2020 18:44:44 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:34988 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387411AbgCKWon (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Mar 2020 18:44:43 -0400
Received: by mail-wr1-f68.google.com with SMTP id d5so4525052wrc.2
        for <linux-kernel@vger.kernel.org>; Wed, 11 Mar 2020 15:44:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=QeeVZpCysBLeBcff3DdO0j5CS9fOGStZhIzASGNoSMk=;
        b=bj/AQ/QcbhLyB8amYbmO2G+4QoHnBpQ+wv/2gXDJiJN1o2Z6z41VLd+S1msCev3kE/
         jxF7gneBkOD8j1NF4mRy/v66QrDfXtozOJ6giil05/t1oLEkNOIBnTQzC/XJ4MN3PNVO
         Uc2D9YTr0VROIIapZKBVvBwx/+eExIWAPjYfo1T8hSmYdJktupEmFPSPGoUp/lctf+zd
         4OgqE4sQL48w8ayxdK1MTnkbPZhCPzDvNTfMS7OOUyApAea3Djl36m+J6NkWLrt18eSF
         yWNFepulKsPsueVWoU5M8tFOfAj0hgjFglfjCJqIfKxzo7dUux65U5wFMdDxNjm0ciSA
         AmaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=QeeVZpCysBLeBcff3DdO0j5CS9fOGStZhIzASGNoSMk=;
        b=A5khJonFHQyEBAcx15zu4v1Q44iIBtnrMYWMWp3U/nch3KF9MoHCp1iJsNV4GMFRKH
         5n3wzSTvYojQ+gdG3TNKTFyfvsvfalOsBQfwo/HzIu6pibnjwI71IWZHZzDQDt5RDKd7
         /dNTZvXE6pmT3IzkrEdQydW64JQ2gCjKoRnOCXP0OWv9uf3hxr6HL08svd+DbEIBnRbG
         uOsSLPBlX5bS59CMMrko6OY0WQE2GF+chiVJK2DQO5AGUiPlWLMcJAJiRUUqh3Si+woh
         jdzsbUMgUXJZVOilKgvVQG2aNxgpVxhuz1dsiZ+zH/chPTPilTvl+riT5WVhV97QhISU
         EunQ==
X-Gm-Message-State: ANhLgQ2u6JGqRFJCrkNHBaMxdzqdLUXptvZOz9lgr28PyudjDHoJLba4
        WaC17/tVNSjTq5DMDaM5Sz4o+r4S5myruoM+76q8VQ==
X-Google-Smtp-Source: ADFU+vvRF8pVr4qGIYY8Vh+Y3Xi1B9aZ5b+ZyHUrUCRc5/9PrDOZSstCwaoSgzVTpnhA0c8AxNkEplh/H8511uk/tD4=
X-Received: by 2002:a5d:628c:: with SMTP id k12mr6779929wru.237.1583966681000;
 Wed, 11 Mar 2020 15:44:41 -0700 (PDT)
MIME-Version: 1.0
References: <20200228232736.182780-1-rammuthiah@google.com> <20200301023025-mutt-send-email-mst@kernel.org>
In-Reply-To: <20200301023025-mutt-send-email-mst@kernel.org>
From:   Ram Muthiah <rammuthiah@google.com>
Date:   Wed, 11 Mar 2020 15:44:14 -0700
Message-ID: <CA+CXyWu9AfPbb_BVb9bh9Q_82XfavTGy+M11+6GEGCjeCetThw@mail.gmail.com>
Subject: Re: [PATCH RESEND] virtio: virtio_pci_legacy: Remove default y from Kconfig
To:     "Michael S. Tsirkin" <mst@redhat.com>
Cc:     Jason Wang <jasowang@redhat.com>,
        virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, kernel-team@android.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Feb 29, 2020 at 11:32 PM Michael S. Tsirkin <mst@redhat.com> wrote:
>
> On Fri, Feb 28, 2020 at 03:27:36PM -0800, Ram Muthiah wrote:
> > The legacy pci driver should no longer be default enabled. QEMU has
> > implemented support for Virtio 1 for virtio-pci since June 2015
> > on SHA dfb8e184db75.
> >
> > Signed-off-by: Ram Muthiah <rammuthiah@google.com>
>
> I see little reason to do this: y is safer and will boot on more
> hypervisors, so people that aren't sure should enable it.
>

In that case, would it be reasonable to fold VIRTIO_PCI_LEGACY
into VIRTIO_PCI?

The result would boot more hypervisors as well and remove the
CONFIG in the process.

> > ---
> >  drivers/virtio/Kconfig | 6 ------
> >  1 file changed, 6 deletions(-)
> >
> > diff --git a/drivers/virtio/Kconfig b/drivers/virtio/Kconfig
> > index 078615cf2afc..eacd0b90d32b 100644
> > --- a/drivers/virtio/Kconfig
> > +++ b/drivers/virtio/Kconfig
> > @@ -26,7 +26,6 @@ config VIRTIO_PCI
> >
> >  config VIRTIO_PCI_LEGACY
> >       bool "Support for legacy virtio draft 0.9.X and older devices"
> > -     default y
> >       depends on VIRTIO_PCI
> >       ---help---
> >            Virtio PCI Card 0.9.X Draft (circa 2014) and older device support.
> > @@ -36,11 +35,6 @@ config VIRTIO_PCI_LEGACY
> >         If disabled, you get a slightly smaller, non-transitional driver,
> >         with no legacy compatibility.
> >
> > -          So look out into your driveway.  Do you have a flying car?  If
> > -          so, you can happily disable this option and virtio will not
> > -          break.  Otherwise, leave it set.  Unless you're testing what
> > -          life will be like in The Future.
> > -
> >         If unsure, say Y.
> >
> >  config VIRTIO_PMEM
> > --
> > 2.25.0.265.gbab2e86ba0-goog
>
