Return-Path: <SRS0=pNjS=57=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC24CC38A2B
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Apr 2020 04:41:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 850C120857
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Apr 2020 04:41:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="OTB3RfMy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393089AbgDOEls (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Apr 2020 00:41:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388490AbgDOElp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Apr 2020 00:41:45 -0400
Received: from mail-ot1-x343.google.com (mail-ot1-x343.google.com [IPv6:2607:f8b0:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3EF2C061A0E
        for <linux-kernel@vger.kernel.org>; Tue, 14 Apr 2020 21:41:43 -0700 (PDT)
Received: by mail-ot1-x343.google.com with SMTP id l21so2126934otd.9
        for <linux-kernel@vger.kernel.org>; Tue, 14 Apr 2020 21:41:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=yuNggtIe2GcnI6FuGYRCP7sxE6PadkqmBj6CF6tR/Gs=;
        b=OTB3RfMyrdVJ7ygI0eAB6m89DfyK7Br1DSBVEoq2OJ7g7XFVWBZQPhOzgDy4S2LXTG
         AJMMYR4R29njK35OPsxHnQWrI4xuOC6YfmkFBSL5Y+FgN3f+0KpEoFSNwgomtJqP6l+t
         67AkaK6noIU47090e/BLlc5lXsENljKM6uNHv5jQ8a5ZPyksi5DuPEmiD3YDvILPQnSd
         FAtwGQFURFCCkodWA0D/g9A/wdDKxcAfw2dFzbvHNG6sP3CPa2rfBd08PS+4c+nmxokI
         DSYZFItuasCmP6x1Ah64Othz0RVdteA6jakPuTPC+ob5HEcxFBDDGgFT1q6KPNyyuJGY
         xFJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=yuNggtIe2GcnI6FuGYRCP7sxE6PadkqmBj6CF6tR/Gs=;
        b=fgSru8pc8W4QtndMXURu9LnJsumwiL18WnJrh7q6qbOzV5lUAbeaUKmowv3KBSlMIx
         SVJo7yuQ8zGVYk1GZBNSc1XJ7sKSDUJoikwv9gIPdm6/Pri0/U6FNyOU/HF87oFdEpZo
         ZAR4I1sENvy82lg0wmvw3ePQ+qzL7ya9WvFvXmXJYcoyeDxV8RuveFRLxaFY2QrK1ct7
         fobUtgNnBEYmGkDvMyDnnaZoUFZTfmEOIuXKk4Tj+Fufv6fAnin1E1uUt2o6+mfW+6bw
         hTkGC+AfFyki+CbEdEZ2OxtDUY/f5EzqXkOtIzyQnRua8xIJWG/7i5MCd+PpSs7mDX4k
         ZX8Q==
X-Gm-Message-State: AGi0PuaNTzH/L/5gamtf03eC+j/UeBw0/Iqe2lY/lcKxfnGpLnwy6gfD
        Sp+lZ4FJ5j01H2UAFmRHj6IpcJWcZbGKsM2DdqS2+A==
X-Google-Smtp-Source: APiQypLZVsuOAs/qV12E+s9L226LVjpTiUij81eio0cenUOY+4mpYMVYUEaDSaDyVC+DuicUwi+ryEMvkOkdej8Zuqw=
X-Received: by 2002:a05:6830:20c3:: with SMTP id z3mr15050625otq.102.1586925703073;
 Tue, 14 Apr 2020 21:41:43 -0700 (PDT)
MIME-Version: 1.0
References: <20200414134629.54567-1-orjan.eide@arm.com> <20200414141849.55654-1-orjan.eide@arm.com>
 <20200414142810.GA958163@kroah.com>
In-Reply-To: <20200414142810.GA958163@kroah.com>
From:   John Stultz <john.stultz@linaro.org>
Date:   Tue, 14 Apr 2020 21:41:31 -0700
Message-ID: <CALAqxLX-SUhHPH6ewt-s9cEMc8DtMTgXem=JruAkLofuJf1syg@mail.gmail.com>
Subject: Re: [PATCH] staging: android: ion: Skip sync if not mapped
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     =?UTF-8?Q?=C3=98rjan_Eide?= <orjan.eide@arm.com>, nd <nd@arm.com>,
        Anders Pedersen <anders.pedersen@arm.com>,
        Laura Abbott <labbott@redhat.com>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        =?UTF-8?B?QXJ2ZSBIasO4bm5ldsOlZw==?= <arve@android.com>,
        Todd Kjos <tkjos@android.com>,
        Martijn Coenen <maco@android.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Christian Brauner <christian@brauner.io>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        "Darren Hart (VMware)" <dvhart@infradead.org>,
        Lecopzer Chen <lecopzer.chen@mediatek.com>,
        Arnd Bergmann <arnd@arndb.de>,
        driverdevel <devel@driverdev.osuosl.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        "moderated list:DMA BUFFER SHARING FRAMEWORK" 
        <linaro-mm-sig@lists.linaro.org>,
        lkml <linux-kernel@vger.kernel.org>, linux-media@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 14, 2020 at 7:28 AM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> On Tue, Apr 14, 2020 at 04:18:47PM +0200, =C3=98rjan Eide wrote:
> > Only sync the sg-list of an Ion dma-buf attachment when the attachment
> > is actually mapped on the device.
> >
> > dma-bufs may be synced at any time. It can be reached from user space
> > via DMA_BUF_IOCTL_SYNC, so there are no guarantees from callers on when
> > syncs may be attempted, and dma_buf_end_cpu_access() and
> > dma_buf_begin_cpu_access() may not be paired.
> >
> > Since the sg_list's dma_address isn't set up until the buffer is used
> > on the device, and dma_map_sg() is called on it, the dma_address will b=
e
> > NULL if sync is attempted on the dma-buf before it's mapped on a device=
.
> >
> > Before v5.0 (commit 55897af63091 ("dma-direct: merge swiotlb_dma_ops
> > into the dma_direct code")) this was a problem as the dma-api (at least
> > the swiotlb_dma_ops on arm64) would use the potentially invalid
> > dma_address. How that failed depended on how the device handled physica=
l
> > address 0. If 0 was a valid address to physical ram, that page would ge=
t
> > flushed a lot, while the actual pages in the buffer would not get synce=
d
> > correctly. While if 0 is an invalid physical address it may cause a
> > fault and trigger a crash.
> >
> > In v5.0 this was incidentally fixed by commit 55897af63091 ("dma-direct=
:
> > merge swiotlb_dma_ops into the dma_direct code"), as this moved the
> > dma-api to use the page pointer in the sg_list, and (for Ion buffers at
> > least) this will always be valid if the sg_list exists at all.
> >
> > But, this issue is re-introduced in v5.3 with
> > commit 449fa54d6815 ("dma-direct: correct the physical addr in
> > dma_direct_sync_sg_for_cpu/device") moves the dma-api back to the old
> > behaviour and picks the dma_address that may be invalid.
> >
> > dma-buf core doesn't ensure that the buffer is mapped on the device, an=
d
> > thus have a valid sg_list, before calling the exporter's
> > begin_cpu_access.
> >
> > Signed-off-by: =C3=98rjan Eide <orjan.eide@arm.com>
> > ---
> >  drivers/staging/android/ion/ion.c | 12 ++++++++++++
> >  1 file changed, 12 insertions(+)
> >
> > Resubmit without disclaimer, sorry about that.
> >
> > This seems to be part of a bigger issue where dma-buf exporters assume
> > that their dma-buf begin_cpu_access and end_cpu_access callbacks have a
> > certain guaranteed behavior, which isn't ensured by dma-buf core.
> >
> > This patch fixes this in ion only, but it also needs to be fixed for
> > other exporters, either handled like this in each exporter, or in
> > dma-buf core before calling into the exporters.
> >
> > diff --git a/drivers/staging/android/ion/ion.c b/drivers/staging/androi=
d/ion/ion.c
> > index 38b51eace4f9..7b752ba0cb6d 100644
> > --- a/drivers/staging/android/ion/ion.c
> > +++ b/drivers/staging/android/ion/ion.c
>
> Now that we have the dma-buff stuff in the tree, do we even need the
> ion code in the kernel anymore?  Can't we delete it now?
>

I agree that we shouldn't be taking further (non-security/cleanup)
patches to the ION code.

I'd like to give developers a little bit of a transition period (I was
thinking a year, but really just one LTS release that has both would
do) where they can move their ION heaps over to dmabuf heaps and test
both against the same tree.

But I do think we can mark it as deprecated and let folks know that
around the end of the year it will be deleted.

That sound ok?

thanks
-john
