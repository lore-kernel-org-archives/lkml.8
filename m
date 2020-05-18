Return-Path: <SRS0=RE5T=7A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8BFABC433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 18 May 2020 14:07:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 631FC207D3
	for <linux-kernel@archiver.kernel.org>; Mon, 18 May 2020 14:07:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="y9jCMQ+B"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727999AbgEROHf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 May 2020 10:07:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727006AbgEROHf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 May 2020 10:07:35 -0400
Received: from mail-io1-xd44.google.com (mail-io1-xd44.google.com [IPv6:2607:f8b0:4864:20::d44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D632C061A0C
        for <linux-kernel@vger.kernel.org>; Mon, 18 May 2020 07:07:35 -0700 (PDT)
Received: by mail-io1-xd44.google.com with SMTP id w25so10617113iol.12
        for <linux-kernel@vger.kernel.org>; Mon, 18 May 2020 07:07:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=88kserzSxBEIDjdSt5lOO0U4rUg4np+0t0E9MSvOSs4=;
        b=y9jCMQ+BCO5bCs8V3KsG5KK/VGobVsgkQjY5AVz6q9lOYoUJM+8UK0wcbWXbI8xF3J
         prvbfUFKweWoR6i7a/sKx8hd+VDVivXpCogr+13TXNGWTzBZpoaT3G04gbQTXtnAwNKm
         b2zIgm05cKPpwTzQZBzWTIfeMmi6lp+iJJXuFHrQJEVyf70Wd/i8BU+zd33WziDDBQrr
         1aDDD33/n5PpFBKnqs55DxtGDOKC++20oqW8SMvEt6g64DqxmPH3Ynmu/dkM2TvOboRT
         smliBL1UFi7+UPGOT4cDY3LUQc1+4WEkr22dkDohlTcdglusE9AOIuhVsW1qLQbe12qf
         X+2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=88kserzSxBEIDjdSt5lOO0U4rUg4np+0t0E9MSvOSs4=;
        b=UPUKqhhCAD4dNv8j9OssCXNfsJ3kxCVSvId3NOPb6+4HNsXyChnElCG1dsAtB6qbe5
         UIXJY6kkKDZ7nBtiQdbqRA8CBFx6ZmanGq7axpTw3X7ikiy3glxoUkGoZ/ZzQrgOFp+Z
         k12y0mdDiZtAhYevIZzQpABnb6RS1HxfIXudvIUnfbi7DP5eoWSfsVT3g172b1PjPeVY
         7wiIHWq8fo1quyVvrAUB05F3Jz4l2/DMZly7PWG6zfoR442lXuVPtNnZaI7V1dRHJMkX
         3/RsH7NST+tjsWVemW18MTSxQPtvJtw7qQKqR1PkmN8VqUuNKxQPPJX5kUseIcr8ULtI
         /y8A==
X-Gm-Message-State: AOAM533MWhfHaVViBgaEJ4rZ7DiW4fN10RG5h73PB3L9m91LM440ZbW6
        NTGBejok3xqMGYLJcP+9XeTDIQe+SYFzj+YZwDHx4w==
X-Google-Smtp-Source: ABdhPJz7TVBqL0o8reZpmOjcpmNU0hBkhjlx8exFERPwwjlGWCDBsQrggYZf+B/u4J3tppWJHADctBPzuEotkI8yI7U=
X-Received: by 2002:a6b:7c45:: with SMTP id b5mr14815810ioq.31.1589810854135;
 Mon, 18 May 2020 07:07:34 -0700 (PDT)
MIME-Version: 1.0
References: <20200514075942.10136-1-brgl@bgdev.pl> <20200514075942.10136-11-brgl@bgdev.pl>
 <CAK8P3a0XgJtZNKePZUUpzADO25-JZKyDiVHFS_yuHRXTjvjDwg@mail.gmail.com>
In-Reply-To: <CAK8P3a0XgJtZNKePZUUpzADO25-JZKyDiVHFS_yuHRXTjvjDwg@mail.gmail.com>
From:   Bartosz Golaszewski <brgl@bgdev.pl>
Date:   Mon, 18 May 2020 16:07:23 +0200
Message-ID: <CAMRc=MeVyNzTWw_hk=J9kX1NE9reCE_O4P3wrNpMMc9z4xA_DA@mail.gmail.com>
Subject: Re: [PATCH v3 10/15] net: ethernet: mtk-eth-mac: new driver
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Jonathan Corbet <corbet@lwn.net>, Rob Herring <robh+dt@kernel.org>,
        "David S . Miller" <davem@davemloft.net>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        John Crispin <john@phrozen.org>,
        Sean Wang <sean.wang@mediatek.com>,
        Mark Lee <Mark-MC.Lee@mediatek.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Fabien Parent <fparent@baylibre.com>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        Edwin Peer <edwin.peer@broadcom.com>,
        DTML <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Networking <netdev@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "moderated list:ARM/Mediatek SoC..." 
        <linux-mediatek@lists.infradead.org>,
        Stephane Le Provost <stephane.leprovost@mediatek.com>,
        Pedro Tsai <pedro.tsai@mediatek.com>,
        Andrew Perepech <andrew.perepech@mediatek.com>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

pt., 15 maj 2020 o 15:32 Arnd Bergmann <arnd@arndb.de> napisa=C5=82(a):
>
> On Thu, May 14, 2020 at 10:00 AM Bartosz Golaszewski <brgl@bgdev.pl> wrot=
e:
> > +static int mtk_mac_ring_pop_tail(struct mtk_mac_ring *ring,
> > +                                struct mtk_mac_ring_desc_data *desc_da=
ta)
>
> I took another look at this function because of your comment on the locki=
ng
> the descriptor updates, which seemed suspicious as the device side does n=
ot
> actually use the locks to access them
>
> > +{
> > +       struct mtk_mac_ring_desc *desc =3D &ring->descs[ring->tail];
> > +       unsigned int status;
> > +
> > +       /* Let the device release the descriptor. */
> > +       dma_rmb();
> > +       status =3D desc->status;
> > +       if (!(status & MTK_MAC_DESC_BIT_COWN))
> > +               return -1;
>
> The dma_rmb() seems odd here, as I don't see which prior read
> is being protected by this.
>
> > +       desc_data->len =3D status & MTK_MAC_DESC_MSK_LEN;
> > +       desc_data->flags =3D status & ~MTK_MAC_DESC_MSK_LEN;
> > +       desc_data->dma_addr =3D ring->dma_addrs[ring->tail];
> > +       desc_data->skb =3D ring->skbs[ring->tail];
> > +
> > +       desc->data_ptr =3D 0;
> > +       desc->status =3D MTK_MAC_DESC_BIT_COWN;
> > +       if (status & MTK_MAC_DESC_BIT_EOR)
> > +               desc->status |=3D MTK_MAC_DESC_BIT_EOR;
> > +
> > +       /* Flush writes to descriptor memory. */
> > +       dma_wmb();
>
> The comment and the barrier here seem odd as well. I would have expected
> a barrier after the update to the data pointer, and only a single store
> but no read of the status flag instead of the read-modify-write,
> something like
>
>       desc->data_ptr =3D 0;
>       dma_wmb(); /* make pointer update visible before status update */
>       desc->status =3D MTK_MAC_DESC_BIT_COWN | (status & MTK_MAC_DESC_BIT=
_EOR);
>
> > +       ring->tail =3D (ring->tail + 1) % MTK_MAC_RING_NUM_DESCS;
> > +       ring->count--;
>
> I would get rid of the 'count' here, as it duplicates the information
> that is already known from the difference between head and tail, and you
> can't update it atomically without holding a lock around the access to
> the ring. The way I'd do this is to have the head and tail pointers
> in separate cache lines, and then use READ_ONCE/WRITE_ONCE
> and smp barriers to access them, with each one updated on one
> thread but read by the other.
>

Your previous solution seems much more reliable though. For instance
in the above: when we're doing the TX cleanup (we got the TX ready
irq, we're iterating over descriptors until we know there are no more
packets scheduled (count =3D=3D 0) or we encounter one that's still owned
by DMA), a parallel TX path can schedule new packets to be sent and I
don't see how we can atomically check the count (understood as a
difference between tail and head) and run a new iteration (where we'd
modify the head or tail) without risking the other path getting in the
way. We'd have to always check the descriptor.

I experimented a bit with this and couldn't come up with anything that
would pass any stress test.

On the other hand: spin_lock_bh() works fine and I like your approach
from the previous e-mail - except for the work for updating stats as
we could potentially lose some stats when we're updating in process
context with RX/TX paths running in parallel in napi context but that
would be rare enough to overlook it.

I hope v4 will be good enough even with spinlocks. :)

Bart
