Return-Path: <SRS0=pusq=BO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E884C433E0
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Aug 2020 20:46:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3DD2C22B45
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Aug 2020 20:46:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728044AbgHDUqy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Aug 2020 16:46:54 -0400
Received: from mout.kundenserver.de ([212.227.126.131]:34757 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726545AbgHDUqy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Aug 2020 16:46:54 -0400
Received: from mail-qt1-f181.google.com ([209.85.160.181]) by
 mrelayeu.kundenserver.de (mreue011 [212.227.15.129]) with ESMTPSA (Nemesis)
 id 1M4rkF-1k4RPY1btf-002313 for <linux-kernel@vger.kernel.org>; Tue, 04 Aug
 2020 22:46:51 +0200
Received: by mail-qt1-f181.google.com with SMTP id s23so32044309qtq.12
        for <linux-kernel@vger.kernel.org>; Tue, 04 Aug 2020 13:46:51 -0700 (PDT)
X-Gm-Message-State: AOAM533lzrJu/Di3qgol87upK+4KjAVJ/O7ZTGh6N8oCEhozwWDq7/kP
        DQfpv6pbfSj/LxBnec91x8Rq7lKbn04hK+OpH00=
X-Google-Smtp-Source: ABdhPJyfKXtZ9bJdr5vNevE8picmWjXgaqtGeRUJwUyWZhYZoWFf+rYjINp1Q7InTjlAu2JhmVavHTYiCQ3CxRC9qDM=
X-Received: by 2002:ac8:688e:: with SMTP id m14mr23733224qtq.7.1596574010244;
 Tue, 04 Aug 2020 13:46:50 -0700 (PDT)
MIME-Version: 1.0
References: <20200804135817.5495-1-daniel.gutson@eclypsium.com>
 <CAK8P3a0_fJ0BfD5Qvxdo0s7CbjPWaGA8QTgYhbXR=omafOHH4Q@mail.gmail.com>
 <CAFmMkTHEm8k+5GZkVJbDZMEhMwpsqVKRb-hGskSpBstdLRuFyA@mail.gmail.com>
 <CAK8P3a27bTYyn3N+tX=i_6f4KrQkOmkUA1zUQfvCW7qw6smSkQ@mail.gmail.com> <CAFmMkTF9eVm0tpOKEy2rzdX=Scr3RwqHDFy_i24R3F5ok-4=eA@mail.gmail.com>
In-Reply-To: <CAFmMkTF9eVm0tpOKEy2rzdX=Scr3RwqHDFy_i24R3F5ok-4=eA@mail.gmail.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Tue, 4 Aug 2020 22:46:34 +0200
X-Gmail-Original-Message-ID: <CAK8P3a3mf8_Y4DWe3WuBO-Xo0N4Jj=-rrtFzD6w0TriGZPu1_g@mail.gmail.com>
Message-ID: <CAK8P3a3mf8_Y4DWe3WuBO-Xo0N4Jj=-rrtFzD6w0TriGZPu1_g@mail.gmail.com>
Subject: Re: [PATCH] mtd: spi-nor: intel-spi: Do not try to make the SPI flash
 chip writable
To:     Daniel Gutson <daniel@eclypsium.com>
Cc:     Tudor Ambarus <tudor.ambarus@microchip.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Boris Brezillon <bbrezillon@kernel.org>,
        linux-mtd <linux-mtd@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Alex Bazhaniuk <alex@eclypsium.com>,
        Richard Hughes <hughsient@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:0S9TMgZo/mnlFxy49h/RbsO1Aq1qoNkWDjat11AnV1WQiXl0kBQ
 jHs8uUbp6BwQXfT8HS+G/LDsdFxB8u9r5bYc8S+zvPscW5Vd/VHd6j9sO6GRC6KcrenDZQH
 +euTWcfIdLVNEUor1sToNC0f7xu7kGXyBeZ2LEK6ZObDqeeJPguGMIwLtSfo0+f5A5y4VEW
 H+lID/jNrKeMjBmKeYBZw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:0Ty7GXGzy5U=:VgmdVWutpR1O235UZIRn1L
 Kx4oby2OzgVA6aMDm10Lj0p/rijOSPRbqVeNvBwtc57D9Yg3QBYfmX5NLH6GDUQf7RITNh7L/
 c1WPZIfsF2XwJYWc5S8TyE7WgzdOS1AFfoS7lTxm56NCYq3ck8hGZDB2NkbAKJpz72T5mOB7R
 fW6EofHzA/IeVSYEBaAyhzm7uLzQNroP1Z+YZ7dNN+Kl7Xw2arzWmF1uvITW3RXHqemVZbSsj
 KfdFRzD+Wa2Ic3j6wfhRiqtrod0I49zdt+G8h107xBbm2EsE05dYILWd9HKjJg4dV607hfA8g
 gmJOHrl/6ffUYYyNUVMeNQ+oAF8D+nMZ2sDm4j+QkMRxfM6HLF3LosfHA9JWjdwT00gRc0gdb
 Q5FfxaYjdxlhVjfcD2KPqXvNoKDegaiGlCCtgnRRk12iDzvqnDv45utor0ksSEeFDJ5EIc6rO
 CNSfYE7e2XRhIlKSiV8Wb66gbCdQV3JL5CZ2TRBb7r2v3RkBt8N5BLOFhTbAm1UTy5wQllErF
 3Y3cr6IalcKHt1AVlp+CLLhVPE94LU3rDmv0QCQYl1BIoIXoMYdq8bg0FJbNOYr0GXmTQt05V
 dJGSAP/lBE7JAoWEj8GvzxSzmQ7N7ayOLEOQXrc8ZIhtCVr2i0Tf6LM9GJGrAx/i6gDH+tFvl
 Y9BXxoJAD00NHNLIWBoW00MpU92IhyHgymh3auWLwqNasaMRRNmYjWKgwUBSvGhYnwarYOmwM
 GF3g4nKF7/mi0AnSW7CLW6g934bVdVhG48PW1GWYMf1dh5XZJrdYF9hWEtH4+qoSgF54qCyq2
 dmpjZyTDNUo54XyUCD3b2EHrdbyuRamxf0WDFWF1ztBwfgy8iVAwqBPn5P99sAnAOuqH+Z4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 4, 2020 at 9:57 PM Daniel Gutson <daniel@eclypsium.com> wrote:
> On Tue, Aug 4, 2020 at 4:06 PM Arnd Bergmann <arnd@arndb.de> wrote:
> > On Tue, Aug 4, 2020 at 5:49 PM Daniel Gutson <daniel@eclypsium.com> wrote:
> > > On Tue, Aug 4, 2020 at 12:21 PM Arnd Bergmann <arnd@arndb.de> wrote:
> > >> On Tue, Aug 4, 2020 at 3:58 PM Daniel Gutson
> > >> <daniel.gutson@eclypsium.com> wrote:
> > >
> > > What about just saying
> > >
> > > "This patch removes the attempt by the intel-spi-pci driver to
> > > make the chip always writable."
> >
> > Yes, that is much better, though it still sounds like it would at the
> > moment allow writing to the device from software without also
> > setting the module parameter. I would say something like
> >
> > "Disallow overriding the write protection in the PCI driver
> > with a module parameter and instead honor the current
> > state of the write protection as set by the firmware."
>
> But wait, Mika, the author of the file, asked earlier not to remove
> the module parameter of intel-spi, and just remove the unconditional
> attempt to turn the chip writable in intle-spi-pci.

Yes, and I think that is fine (aside from the inconsistency with bay trail
that you have not commented on), but that only touches the hardware
write-protection, which doesn't really have any effect unless user
space also configures the driver module to allow writing to the
mtd device.

> So I'm not touching intel-pci, just removing that code from
> intel-spi-pci without adding a new module parameter.
>
> Are you aligned on this?

One of us is still very confused about what the driver does.
You seem to have gone back to saying that without the
change a user could just write to the device even without
passing the module parameter to intel-spi.ko?

Maybe you should start by explaining what scenario you
actually want to prevent here. Is it

a) the hardware write-protect bit getting changed, which
    introduces the possibility of corrupting the flash even
    if nothing tries to write to it,

b) root users setting the device writable with the intention
   of writing to it even though firmware has politely asked
   for this not to be done (by setting the write-protect bit
   but not preventing it from being disabled again), or

c) a writeable mtd device showing up even without
    the module parameter being set at all?

I thought the initial patch was about c) which turned out
to be a non-issue, and then the later patch being about b).

     Arnd
