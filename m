Return-Path: <SRS0=wYIT=CC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7EEA9C433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Aug 2020 09:32:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6589F20738
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Aug 2020 09:32:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729504AbgHXJcP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Aug 2020 05:32:15 -0400
Received: from mout.kundenserver.de ([212.227.126.135]:42443 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727979AbgHXJb7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Aug 2020 05:31:59 -0400
Received: from mail-qk1-f175.google.com ([209.85.222.175]) by
 mrelayeu.kundenserver.de (mreue012 [212.227.15.129]) with ESMTPSA (Nemesis)
 id 1Mmhs6-1ksanj0nG2-00jr41 for <linux-kernel@vger.kernel.org>; Mon, 24 Aug
 2020 11:31:57 +0200
Received: by mail-qk1-f175.google.com with SMTP id o64so646362qkb.10
        for <linux-kernel@vger.kernel.org>; Mon, 24 Aug 2020 02:31:57 -0700 (PDT)
X-Gm-Message-State: AOAM533v6SWiioqxbULtDg4BqOcTc4TY3R0RenIjEdid64IdsWLIoCOX
        pb1lmDDAawNZuBLueNg7hVWqUgu1sYZND2rf1JI=
X-Google-Smtp-Source: ABdhPJystfMSTfuUPFEBNm3xdo71/RSSgQxQfaXlBeE+UqaTU58CsAkPxILy9i4UtLKyOuYGBI8PdeyLKTEES0M2Zo4=
X-Received: by 2002:a37:6351:: with SMTP id x78mr3784606qkb.394.1598261516064;
 Mon, 24 Aug 2020 02:31:56 -0700 (PDT)
MIME-Version: 1.0
References: <CAK8P3a13N_wNORz_3cYHTN8t29pPrY+dJ+g+1Ga_MmG1TmrUQw@mail.gmail.com>
 <CAFmMkTGm3pMsBzEenYOsRbhOZKFhbHiZ5LxPyVmTdYTTRpKzVQ@mail.gmail.com>
 <CAK8P3a2_RV33kiJ0c34aopZ4iG7LYBR-u=-+BbC+Upyjh1T0Eg@mail.gmail.com>
 <CAFmMkTHqQO1Gj7VeXr4Y_Umb1KzZc2Pf=1pDQvPPpb_XeAFPqQ@mail.gmail.com>
 <20200819065721.GA1375436@lahna.fi.intel.com> <CAK8P3a0Bq-ucgC4Xue+B_HV97pTX8YRr4hYh1gfrfGBV_H1EUQ@mail.gmail.com>
 <20200819091123.GE1375436@lahna.fi.intel.com> <CAK8P3a19MLfQARXEWzCD-ySq4t9nsyryB+con33HsQ193+muMw@mail.gmail.com>
 <20200824082227.GU1375436@lahna.fi.intel.com> <CAK8P3a0==cZDHwZfqvCuvUg9jfjBOBG+AAomE9eqJ2xm-xNLvQ@mail.gmail.com>
 <20200824091542.GC1375436@lahna.fi.intel.com>
In-Reply-To: <20200824091542.GC1375436@lahna.fi.intel.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Mon, 24 Aug 2020 11:31:40 +0200
X-Gmail-Original-Message-ID: <CAK8P3a2ipcVLOzZ5jsDSmWkm=rsE7UQ8rgTU-o6me+vX+gVa9g@mail.gmail.com>
Message-ID: <CAK8P3a2ipcVLOzZ5jsDSmWkm=rsE7UQ8rgTU-o6me+vX+gVa9g@mail.gmail.com>
Subject: Re: [PATCH] mtd: spi-nor: intel-spi: Do not try to make the SPI flash
 chip writable
To:     Mika Westerberg <mika.westerberg@linux.intel.com>
Cc:     Daniel Gutson <daniel@eclypsium.com>,
        Tudor Ambarus <tudor.ambarus@microchip.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Boris Brezillon <bbrezillon@kernel.org>,
        linux-mtd <linux-mtd@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Alex Bazhaniuk <alex@eclypsium.com>,
        Richard Hughes <hughsient@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:9MRxlt0Co5Qo01nf04WGTXUzmZCIo6K9bDq3wim04WYi5XrZ6CE
 PbMjkFKybNuz2ibgHMd/zpbK1sklOCs6OpJF3ujMQ2Xurf7zzV0vBMi5EyxHmMW/grUlokm
 nIyiePVI8AaC13W5hv3pcxtfAdkN8ANRrFkVTVD/emBnA817EDcSWwtf+2y2OJVaHqUvC+L
 ylJiIO7E5TofA8hRtvD0w==
X-UI-Out-Filterresults: notjunk:1;V03:K0:Rwmn3vxa2Gk=:iXkpmQ4yLDYnBpCgaVdEOb
 X08T6Ooy4oQn6XKeWLG9HTBQ/L/kT2be9yq6Jy4/kc6tQ/io/UfMEYVPUqE3TdA9lgzempoD9
 AXVt9TPYFz/Atrlp6q82siJIWwz2j5M2TrHzKeoRpZkyMXGsd7AADQPnZrF4YZrpvcjk31os7
 4zTRRQo6L0WI5PO/04YgZBofUGG48fUp/3kVMCJZmQ82eal7jlfcFM9m+jjf5wE/fmu8K+rE2
 15JgemkunSNusFa7wQmz/5BZuruWysDAPgJ8eGlN7flke7w7/if67eX8DyucNgPtpR4yAbpFb
 UfDrVRHaiSaeMisQLSKMgw+Oc99yG25Jk95mDt2QaJBvM3bp/pEbovLwUibtqF9bRm3+OP6Sv
 hW3QlAhKkiqCIJSmRVy/JCscFk0OdFkBp0V/0UpeZ/2S2lChJjUsCxqg5AQlPj7QkL9upmD/7
 FQzXn/XHA66ZS2nOsHM5usLL0nqTHn2BD5bq2Lc3T2BFg8QS0GiMfGaWG9VMGqeWq80pDXJiw
 JePwbi386jB4u9tULim0RoFmDWrJ5/v3awUSL1KVXMdVt1Gzp4U/adpCnqH5SLEeawEoYN/BS
 qRaHBVqhcZa3wVYzXgi1EsgK0vhuKsJ48C2l7mBCKpnJ/UL/pKsmjAxvN4PYkIOiXe9Y/ZZyx
 ETZSBF1YC3DGIOn1LV74geDNGnsLWblAyb67ewwOoz7If2FXelI6AG77v9umXt5glOx2ayQZb
 gs9Wn7exvQMY4DmrYfiQndGJdAdpUEjHgQPinOtIDzu8OqLtsnEUOee9Orsl/KFdXPRdznwsb
 PR0vx+DxChrOPyFaYawgL3qsR53OqEvWaFyZLGjbjFiKxf6MR7DBoNrrUqPgy3dn74AR19uKL
 JxxmokeUv37hxNauTEOkjOC7WlIUQEiEOhRN/nvU5hm+mOhoiHAXZ+zbHmdAdYCvSvf4xe1v7
 dxzCvftKOfoMvNi4Vh4vxddcowYToKgGIrx30YfRaCLZ0tufm2VIl
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 24, 2020 at 11:15 AM Mika Westerberg
<mika.westerberg@linux.intel.com> wrote:
> On Mon, Aug 24, 2020 at 11:08:33AM +0200, Arnd Bergmann wrote:
> > On Mon, Aug 24, 2020 at 10:22 AM Mika Westerberg
> > <mika.westerberg@linux.intel.com> wrote:
> > > On Sat, Aug 22, 2020 at 06:06:03PM +0200, Arnd Bergmann wrote:
> > > > On Wed, Aug 19, 2020 at 11:11 AM Mika Westerberg
> > > >
> > > > The mtd core just checks both the permissions on the device node (which
> > > > default to 0600 without any special udev rules) and the MTD_WRITEABLE
> > > > on the underlying device that is controlled by the module parameter
> > > > in case of intel-spi{,-platform,-pci}.c.
> > >
> > > OK, thanks.
> > >
> > > Since we cannot really get rid of the module parameter (AFAIK there are
> > > users for it), I still think we should just make the "writeable" to
> > > apply to the PCI part as well. That should at least make it consistent,
> > > and it also solves Daniel's case.
> >
> > Can you explain Daniel's case then? I still don't understand what he
> > actually wants.
> >
> > As I keep repeating, the module parameter *does* apply to the pci
> > driver front-end since it determines whether the driver will disallow
> > writes to the mtd device without it. The only difference is that the pci
> > driver will attempt to set the hardware bit without checking the
> > module parameter first, while the platform driver does not. If the
> > module parameter is not set however, the state of the hardware
> > bit is never checked again.
>
> I think Daniel wants the PCI driver not to set the hardware bit by
> default (same as the platform driver).

Sure, but *why*?

    Arnd
