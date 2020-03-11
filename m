Return-Path: <SRS0=Ktsx=44=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B891C0044D
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Mar 2020 23:02:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7E94F20691
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Mar 2020 23:02:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VTU4olTS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731402AbgCKXCm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Mar 2020 19:02:42 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:42441 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1729739AbgCKXCm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Mar 2020 19:02:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1583967760;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=3mEzkj6XRFR4kWdQY1UH1Sim7j3oSUMmKUovhUqapmI=;
        b=VTU4olTSc8nF7xSAOiGKvhZCx7PYIwbWSxRehaaR/hiTjBibW2DSouZR74jARnNqZJidS5
        2TlIs+iMZyfvH24DKleULzUoeLopgR5Jau07H40w56dd24JYP0zCAGIevHQVjKe3Mwov43
        ForxQbOLXqPISq9SLQ4YDpV/h7nGISU=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-79-NlIRHvtrNy6gNi6RbMmXgw-1; Wed, 11 Mar 2020 19:02:38 -0400
X-MC-Unique: NlIRHvtrNy6gNi6RbMmXgw-1
Received: by mail-qk1-f197.google.com with SMTP id x126so2597851qka.1
        for <linux-kernel@vger.kernel.org>; Wed, 11 Mar 2020 16:02:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=3mEzkj6XRFR4kWdQY1UH1Sim7j3oSUMmKUovhUqapmI=;
        b=JvyKXzeB1EkqMfTAf9kxa6R3MfVb63XOWONAEhyic0eIsNK0w2lXhO1GFGzvYCdVWY
         c7gdP8RR+snLr3aZ5vtDKhgJ/eltcc4MTUrwLDwa3XeATy6t4HYUz/G2cn/xJ+ImTGOd
         aRistvEZEGKOXZTMV6Yslb5qYlQ9spP21Z8eD/iuJ23lecaPwbGnEzIc2pgDVBPAlomk
         EUeScpvk80tfeqomliHUSiryrjiFTASzTho0arcfm7Q0qIZ0owJkFpXFNigNvyVGcHWQ
         fA27vNjs5phAQEEIhrpIDVpxN9Lm9uO2r+vWqOICMecCwU4+q/QwDeWW9xIrq80yplyU
         nvHA==
X-Gm-Message-State: ANhLgQ3J/zmtYlIgJeolVyOL40qHWokcL8462kFifACDLco7axl2VBl0
        ahefqFlu0rxd1172L3Vxqwil3czsXCVOyuUxZ/juVpNa5AFFxGWvWOaOog8U+f5TcmmD5rN28S9
        dTJik1zDaYcNBwqC39ECZyUnF
X-Received: by 2002:ac8:351c:: with SMTP id y28mr4762168qtb.379.1583967758131;
        Wed, 11 Mar 2020 16:02:38 -0700 (PDT)
X-Google-Smtp-Source: ADFU+vt9gGn5giwkO4bGzbtjpN0RPLYVpYCPuXoRC/ZgpxaKmEVLwnuRv5b9G/2X1vioXdDnLOG7MQ==
X-Received: by 2002:ac8:351c:: with SMTP id y28mr4762149qtb.379.1583967757888;
        Wed, 11 Mar 2020 16:02:37 -0700 (PDT)
Received: from redhat.com (bzq-79-178-2-19.red.bezeqint.net. [79.178.2.19])
        by smtp.gmail.com with ESMTPSA id b8sm19471664qte.52.2020.03.11.16.02.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Mar 2020 16:02:37 -0700 (PDT)
Date:   Wed, 11 Mar 2020 19:02:32 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Ram Muthiah <rammuthiah@google.com>
Cc:     Jason Wang <jasowang@redhat.com>,
        virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, kernel-team@android.com
Subject: Re: [PATCH RESEND] virtio: virtio_pci_legacy: Remove default y from
 Kconfig
Message-ID: <20200311190026-mutt-send-email-mst@kernel.org>
References: <20200228232736.182780-1-rammuthiah@google.com>
 <20200301023025-mutt-send-email-mst@kernel.org>
 <CA+CXyWu9AfPbb_BVb9bh9Q_82XfavTGy+M11+6GEGCjeCetThw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+CXyWu9AfPbb_BVb9bh9Q_82XfavTGy+M11+6GEGCjeCetThw@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 11, 2020 at 03:44:14PM -0700, Ram Muthiah wrote:
> On Sat, Feb 29, 2020 at 11:32 PM Michael S. Tsirkin <mst@redhat.com> wrote:
> >
> > On Fri, Feb 28, 2020 at 03:27:36PM -0800, Ram Muthiah wrote:
> > > The legacy pci driver should no longer be default enabled. QEMU has
> > > implemented support for Virtio 1 for virtio-pci since June 2015
> > > on SHA dfb8e184db75.
> > >
> > > Signed-off-by: Ram Muthiah <rammuthiah@google.com>
> >
> > I see little reason to do this: y is safer and will boot on more
> > hypervisors, so people that aren't sure should enable it.
> >
> 
> In that case, would it be reasonable to fold VIRTIO_PCI_LEGACY
> into VIRTIO_PCI?
> 
> The result would boot more hypervisors as well and remove the
> CONFIG in the process.

This might break configurations relying on the flying car joke to be
there.


> > > ---
> > >  drivers/virtio/Kconfig | 6 ------
> > >  1 file changed, 6 deletions(-)
> > >
> > > diff --git a/drivers/virtio/Kconfig b/drivers/virtio/Kconfig
> > > index 078615cf2afc..eacd0b90d32b 100644
> > > --- a/drivers/virtio/Kconfig
> > > +++ b/drivers/virtio/Kconfig
> > > @@ -26,7 +26,6 @@ config VIRTIO_PCI
> > >
> > >  config VIRTIO_PCI_LEGACY
> > >       bool "Support for legacy virtio draft 0.9.X and older devices"
> > > -     default y
> > >       depends on VIRTIO_PCI
> > >       ---help---
> > >            Virtio PCI Card 0.9.X Draft (circa 2014) and older device support.
> > > @@ -36,11 +35,6 @@ config VIRTIO_PCI_LEGACY
> > >         If disabled, you get a slightly smaller, non-transitional driver,
> > >         with no legacy compatibility.
> > >
> > > -          So look out into your driveway.  Do you have a flying car?  If
> > > -          so, you can happily disable this option and virtio will not
> > > -          break.  Otherwise, leave it set.  Unless you're testing what
> > > -          life will be like in The Future.
> > > -
> > >         If unsure, say Y.
> > >
> > >  config VIRTIO_PMEM
> > > --
> > > 2.25.0.265.gbab2e86ba0-goog
> >

