Return-Path: <SRS0=dFdc=BX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0983CC433E1
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Aug 2020 15:41:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C6AF020829
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Aug 2020 15:41:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726901AbgHMPl3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Aug 2020 11:41:29 -0400
Received: from mout.kundenserver.de ([212.227.126.131]:48215 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726679AbgHMPl2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Aug 2020 11:41:28 -0400
Received: from mail-qt1-f173.google.com ([209.85.160.173]) by
 mrelayeu.kundenserver.de (mreue009 [212.227.15.129]) with ESMTPSA (Nemesis)
 id 1MLz3R-1kNV7k1PST-00I0Ew for <linux-kernel@vger.kernel.org>; Thu, 13 Aug
 2020 17:41:25 +0200
Received: by mail-qt1-f173.google.com with SMTP id v22so4676395qtq.8
        for <linux-kernel@vger.kernel.org>; Thu, 13 Aug 2020 08:41:25 -0700 (PDT)
X-Gm-Message-State: AOAM53023WOGA20bLKlx8JzwlZi4H5vsQEziMk+7XuJPCb8Xla85bUfB
        5fXQpCFBzAg1bhq/3K2EJUkbi4mmNxK2zoyiw1U=
X-Google-Smtp-Source: ABdhPJwBmHbur4R9QAEADlY4bGOU5Jt/LG8dUKhZzbWmRZKmKNVU9XmwD/IPUYWNtlm4yEdoEp1pVW6E6FaFtYVihzs=
X-Received: by 2002:ac8:688e:: with SMTP id m14mr5976151qtq.7.1597333284188;
 Thu, 13 Aug 2020 08:41:24 -0700 (PDT)
MIME-Version: 1.0
References: <20200804135817.5495-1-daniel.gutson@eclypsium.com>
 <CAK8P3a0_fJ0BfD5Qvxdo0s7CbjPWaGA8QTgYhbXR=omafOHH4Q@mail.gmail.com>
 <CAFmMkTHEm8k+5GZkVJbDZMEhMwpsqVKRb-hGskSpBstdLRuFyA@mail.gmail.com>
 <CAK8P3a27bTYyn3N+tX=i_6f4KrQkOmkUA1zUQfvCW7qw6smSkQ@mail.gmail.com>
 <CAFmMkTF9eVm0tpOKEy2rzdX=Scr3RwqHDFy_i24R3F5ok-4=eA@mail.gmail.com>
 <CAK8P3a3mf8_Y4DWe3WuBO-Xo0N4Jj=-rrtFzD6w0TriGZPu1_g@mail.gmail.com> <CAFmMkTFzmC=aY0gR6urLu-8Oq8aeHBUWi-TodG8XhXKCcC057A@mail.gmail.com>
In-Reply-To: <CAFmMkTFzmC=aY0gR6urLu-8Oq8aeHBUWi-TodG8XhXKCcC057A@mail.gmail.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Thu, 13 Aug 2020 17:41:07 +0200
X-Gmail-Original-Message-ID: <CAK8P3a13N_wNORz_3cYHTN8t29pPrY+dJ+g+1Ga_MmG1TmrUQw@mail.gmail.com>
Message-ID: <CAK8P3a13N_wNORz_3cYHTN8t29pPrY+dJ+g+1Ga_MmG1TmrUQw@mail.gmail.com>
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
X-Provags-ID: V03:K1:yYRwo/T7qD5jYkdy4a4BA5kceI6rHyB7iJnj7QET+1JZfQPqIPd
 whRpw9kNzk9hZ5+4NwVVu2HnQpEwj8xJLMnPiw/SSjE8dBLdYzpyUoGy/E+zBFb6SQTxqX/
 A1uSgaWhBWkAv3RcF78ImeaGfX3pDuDvn+eA3GZTE3CADBSfFvn5QvCOS7TbC5bY+qxl2Y5
 cGQUYladuMXCxqBxnAUpQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:PHUbVkQMu1o=:i1hoozi4LG1fQla+wh3QmW
 X6USbcd9AVhYFb+er0NiUG3zvfC4MeR6bpFXc8cZBwDqVYFpm3WMiMuTLV5G1p5prKxPc0Cwe
 FJfDNTj0B1GVvIlsZP3TjQrwmj2fLWKOlEWTWRfFsmt9P+yP2yseeI0x9EZVLwo9Cxre+Kuht
 csmdtRzXEmrni8cY6oUaQ0piNPsUnMhOQrD0UA5yk10wU5/5cRFbqx1PUgEPqxDVrHMoCauXg
 skHScRMZpQSs1+kf6D02r1F6iq4/ZzAbJxVXLlxFWN2eiZB0q9ltMhkTyPqlf1dJ+txezHc6F
 jlVtpYmwKCX/YgUhCcXi5Q2/y2afUkTqi/16N/zDwktUn06MINUzMzr6xBqFHSikN1NQDXxkt
 w702iE/n10S2BvSbBDeZz75S+zJ3eeUh+I6TRvZZEsYLyWajngPw60jvk2ZcCT+e1NV+d6vTx
 a8K+E9+fDb8Y+VZIysEKB/shAfyDgYr6d3ns07kR7KQnbLaZ3I9IC93VP9ogG5c/6tx6Rza5H
 4MJcxTa/u7ECUAsylVWzGO5OLg3DRiUvGfWF4pVcHilaopwqSD4Z9bfd41987LHFGKhLZrAsU
 NTJynTBo03ZDgrItL/Mx5C/E14graWqeShHvbMU7Dz7FDfro5+e1ggl5eVpcwgBDXEb7EGje6
 aBFGr39V2F3SoPFUej9yay7nvEi3We+MrrAXD5Wz1PUqB8PwHlrp/PewQ6LP8ixgRuEmB2BXl
 76DyX3rUv8NkdndPet6scXAn9jIzAY3E8b2xZklGFt0Ahyh6fDsybfbIAmWtxFkRa9tZ9yq35
 OJl41cm9IaC4cY7qc+HO7l20kElgvzWeUk+wERJHfPHTtf3Y81xyLX5m6GebdVvMNrAh/aG
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 4, 2020 at 11:26 PM Daniel Gutson <daniel@eclypsium.com> wrote:
> On Tue, Aug 4, 2020 at 5:46 PM Arnd Bergmann <arnd@arndb.de> wrote:
> > > But wait, Mika, the author of the file, asked earlier not to remove
> > > the module parameter of intel-spi, and just remove the unconditional
> > > attempt to turn the chip writable in intle-spi-pci.
> >
> > Yes, and I think that is fine (aside from the inconsistency with bay trail
> > that you have not commented on),
>
> There are two inconsistencies before any of my patches:
> 1) in intel-spi.c: uses the module parameter only for bay trail.
> 2) intel-spi.c uses a module parameter whereas intel-spi-pci doesn't

Neither of these matches what I see in the source code. Please
check again.

Once more: intel-spi.c has a module parameter that controls writing
to the device regardless of the back-end (platform or pci), purely
in software. The hardware write-protect setting where available
works in addition that and prevents writing even if the module
parameter is set to writeable.

> > but that only touches the hardware
> > write-protection, which doesn't really have any effect unless user
> > space also configures the driver module to allow writing to the
> > mtd device.
> >
> > > So I'm not touching intel-pci, just removing that code from
> > > intel-spi-pci without adding a new module parameter.
> > >
> > > Are you aligned on this?
> >
> > One of us is still very confused about what the driver does.
> > You seem to have gone back to saying that without the
> > change a user could just write to the device even without
> > passing the module parameter to intel-spi.ko?
>
> What I'm trying to say is that, if the BIOS is unlocked
> (no driver involvement here), the intel-spi-pci turns the
> chip writable even without changing the module parameter of intel-spi.
> This is because the attempt to turn the chip writable occurs in
> the probing of intel-spi-pci, that is, earlier than the intel-spi
> initialization.

My question was why you even care whether the hardware
bit is set to writeable if the driver disallows writing. I think the
answer is that you misread the driver.

       Arnd
