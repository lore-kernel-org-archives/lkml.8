Return-Path: <SRS0=idZ5=4V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9015CC3F2C6
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Mar 2020 01:26:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 669F72073B
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Mar 2020 01:26:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hDossmiP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387478AbgCDB0U (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Mar 2020 20:26:20 -0500
Received: from mail-vs1-f67.google.com ([209.85.217.67]:42034 "EHLO
        mail-vs1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727985AbgCDB0R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Mar 2020 20:26:17 -0500
Received: by mail-vs1-f67.google.com with SMTP id w142so103300vsw.9
        for <linux-kernel@vger.kernel.org>; Tue, 03 Mar 2020 17:26:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=O9pD7eTKayKhsYYKw3enP3Cpnqb80umNsGJzDDGsAM4=;
        b=hDossmiPT5ZsYw2/No/UnWGjFk7tvNCv2mxERrWzKJ2udcQ1LHSUgCZqbpDPpatSe9
         CsS5IBrOxI5WqEGk50OMnXk1qi7Cx2xaGwn8Y4MCD7gDL88s5hhhs0bmJEcU8zvNhcp0
         N26ZpQs0UrOayJeWh70iaWxvSBb0pAwI9eYzx4CmScF4n2uJqX0vbIzcCyLA2eQ/JPH7
         f3F0f/pr3vlw+oZU9kDCRH5y3Xe9HE6a5Cce2mMuDa5Wj0KbxrLs3aLSgXR2ju2HpGJa
         +duer7EVx2x02EhR1KTZpXzldgOj/IJzlYFsZ/83uEtuv68D4/4xX99ZyNwvmDf+U9zb
         Q76Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=O9pD7eTKayKhsYYKw3enP3Cpnqb80umNsGJzDDGsAM4=;
        b=R5yGl6dlPm2rSml0Lyu7AIdpyP4NSuIbH/ktuc6wHBjUb3gd3s8FxvDMPL5hfQG/Dp
         toQXxxcHpOvburrV7QEU/NMcsNX/uOKaBWrwNJ1N+Fr8r0rkYvZTKcswISfOByyFcVG4
         RjypcSbE5fCXdhpbAq7pyJJbsphJW8uai73RHirkrwWRUOhjIqtFnICB2zG6fA9UPGNA
         JPSyfU/+gZURKMOe/9hl7pX7JOMjMQS6n97R2X3amv7qfD0R4VD1Xkwx/gYegSWgt2wX
         tkQdhaj8vUDIN6TaoaeJeO3etYOsZaXTtue43cSvHuj/LkLb9GtE3HeF2JghBvy7kXFd
         wiXA==
X-Gm-Message-State: ANhLgQ2JVPHykW2QSi34+l9LiopiDFycAlt6Hm4vmgCf1Ej0mh0iY9PK
        OJtEQ+jA23v0oWCB/CipGS3QaIt8oI72CLUsxvt5ejgq
X-Google-Smtp-Source: ADFU+vvZ3G3hJoK+Tptnc6CvVgnHyEoMJ1j7yGPugaq8jQK47/UHTWvcE0MhTcvOFbyI14sWscWpUpwzm4wI4D7mpZQ=
X-Received: by 2002:a67:f1ca:: with SMTP id v10mr471335vsm.180.1583285175252;
 Tue, 03 Mar 2020 17:26:15 -0800 (PST)
MIME-Version: 1.0
References: <20200227210454.18217-1-alistair.francis@wdc.com>
 <20200228095748.uu4sqkz6y477eabc@sirius.home.kraxel.org> <CAKmqyKOTjyRL9vxZrZW8Q+yBM0n-Nw-o-Cn3dUDDfAAa7Nswrg@mail.gmail.com>
 <20200303062437.tjoje5huts6oldrv@sirius.home.kraxel.org>
In-Reply-To: <20200303062437.tjoje5huts6oldrv@sirius.home.kraxel.org>
From:   Alistair Francis <alistair23@gmail.com>
Date:   Tue, 3 Mar 2020 17:18:34 -0800
Message-ID: <CAKmqyKPEtbDr1kmnyz6FtfU567xxgmxn+F=zH_h8k_m1EN9b5A@mail.gmail.com>
Subject: Re: [PATCH] drm/bochs: Remove vga write
To:     Gerd Hoffmann <kraxel@redhat.com>
Cc:     Alistair Francis <alistair.francis@wdc.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        dri-devel@lists.freedesktop.org,
        virtualization@lists.linux-foundation.org,
        Daniel Vetter <daniel@ffwll.ch>, airlied@linux.ie,
        Khem Raj <raj.khem@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 2, 2020 at 10:24 PM Gerd Hoffmann <kraxel@redhat.com> wrote:
>
> On Mon, Mar 02, 2020 at 02:14:02PM -0800, Alistair Francis wrote:
> > On Fri, Feb 28, 2020 at 1:57 AM Gerd Hoffmann <kraxel@redhat.com> wrote:
> > >
> > > On Thu, Feb 27, 2020 at 01:04:54PM -0800, Alistair Francis wrote:
> > > > The QEMU model for the Bochs display has no VGA memory section at offset
> > > > 0x400 [1]. By writing to this register Linux can create a write to
> > > > unassigned memory which depending on machine and architecture can result
> > > > in a store fault.
> > > >
> > > > I don't see any reference to this address at OSDev [2] or in the Bochs
> > > > source code.
> > > >
> > > > Removing this write still allows graphics to work inside QEMU with
> > > > the bochs-display.
> > >
> > > It's not that simple.  The driver also handles the qemu stdvga (-device
> > > VGA, -device secondary-vga) which *does* need the vga port write.
> > > There is no way for the guest to figure whenever the device is
> > > secondary-vga or bochs-display.
> > >
> > > So how about fixing things on the host side?  Does qemu patch below
> > > help?
> >
> > That patch looks like it will fix the problem, but it doesn't seem
> > like the correct fix. I would rather avoid adding a large chunk of
> > dummy I/O to handle the two devices.
>
> It's just a single handler for the parent mmio region, so we have a
> defined default action instead of undefined behavior.
>
> Patch just posted to qemu-devel, lets see what others think ...

Thanks, let's wait and see what happens.

>
> > > Maybe another possible approach is to enable/disable vga access per
> > > arch.  On x86 this doesn't cause any problems.  I guess you are on
> > > risc-v?
> >
> > I would prefer this option. I do see this on RISC-V, but I suspect the
> > issue will appear on other architectures (although how they handle I/O
> > failures in QEMU is a different story).
> >
> > Can I just do the VGA write if x86?
>
> I know ppc needs it too.  Not sure about other architectures.  I'd
> suggest to do it the other way around: blacklist known-problematic
> archs.

Argh, that is a little uglier. Let's circle back after receiving
feedback on the QEMU patch.

Alistair

>
> cheers,
>   Gerd
>
