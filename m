Return-Path: <SRS0=sqB7=5R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E2D5C2D0F0
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Apr 2020 19:10:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 28808206F6
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Apr 2020 19:10:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732540AbgDATKl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Apr 2020 15:10:41 -0400
Received: from mout.kundenserver.de ([212.227.126.131]:60071 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732148AbgDATKl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Apr 2020 15:10:41 -0400
Received: from mail-qt1-f175.google.com ([209.85.160.175]) by
 mrelayeu.kundenserver.de (mreue012 [212.227.15.129]) with ESMTPSA (Nemesis)
 id 1MnFps-1is2yA2r7k-00jHcO; Wed, 01 Apr 2020 21:10:38 +0200
Received: by mail-qt1-f175.google.com with SMTP id g7so1052952qtj.13;
        Wed, 01 Apr 2020 12:10:38 -0700 (PDT)
X-Gm-Message-State: ANhLgQ1NtBAI5jn3L+6sckOI2t+jc5w6d1L4V6RAw5WLOt2FsYq0f+OQ
        quss2rgxVEqt8fzAl8h9VIA/sz6Dq0KdYVK8VSs=
X-Google-Smtp-Source: ADFU+vtyMLvr7Dgw6oe+zlZkRyvlCk0FigXkPEVlKpn5w9aHowMBBgNSkrRsc1vRQgMl4vxdrLwn99ZYxeSm7ctuNe8=
X-Received: by 2002:ac8:d8e:: with SMTP id s14mr12105068qti.204.1585768237437;
 Wed, 01 Apr 2020 12:10:37 -0700 (PDT)
MIME-Version: 1.0
References: <20200306130731.938808030702@mail.baikalelectronics.ru>
 <20200306153246.9373B80307C4@mail.baikalelectronics.ru> <20200401150612.addu2gzahrarpgep@ubsrv2.baikal.int>
In-Reply-To: <20200401150612.addu2gzahrarpgep@ubsrv2.baikal.int>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Wed, 1 Apr 2020 21:10:20 +0200
X-Gmail-Original-Message-ID: <CAK8P3a0+3xqLa9-Xsu-WWd5XZZ=4mPzwHhOmGSc9y9W=92L9Uw@mail.gmail.com>
Message-ID: <CAK8P3a0+3xqLa9-Xsu-WWd5XZZ=4mPzwHhOmGSc9y9W=92L9Uw@mail.gmail.com>
Subject: Re: [PATCH 0/6] soc: Add Baikal-T1 SoC APB/AXI EHB and L2-cache drivers
To:     Sergey Semin <Sergey.Semin@baikalelectronics.ru>
List-Id: <soc.lore.kernel.org>
Cc:     Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>,
        Maxim Kaurkin <Maxim.Kaurkin@baikalelectronics.ru>,
        Pavel Parkhomenko <Pavel.Parkhomenko@baikalelectronics.ru>,
        Ramil Zaripov <Ramil.Zaripov@baikalelectronics.ru>,
        Ekaterina Skachko <Ekaterina.Skachko@baikalelectronics.ru>,
        Vadim Vlasov <V.Vlasov@baikalelectronics.ru>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Paul Burton <paulburton@kernel.org>,
        Ralf Baechle <ralf@linux-mips.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Olof Johansson <olof@lixom.net>, SoC Team <soc@kernel.org>,
        DTML <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:eGV4YgcVYPCaWqXSd/ieWLRacwsOh12zVSTHFYmv6XWKhgKd8Nw
 31/IDeS0b9jh++OOEhg6plu3z3oy22MqWAjwKvFNIVVhlNbsCtJwreRE2m3I0MZwYdY2dxI
 mVADWzLhaqvpFTIFAdsmOqzuB6GXyHqPAwBphZmnUlsGKQSWv8wbOvqcLBAVxHEqpuDDjZS
 ij0beb3//8ai8iPj3faTg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:MQNZw/2uLik=:gR+gJWCbIcpYfxvKXdggJ6
 Yn97LfIDC8XENqH+8vdvcsdP2UQzf6YvORNvxHTjGa+UTBTpPra84p4lKf/pqOuOZNOyIRBjY
 vtPHGI2ACIIARb4TXDnRqhUDbXtbuTLxrIfpUJc4AFxY2rIdRCQsllW8FdW0XgXmcXxKmG4Xj
 W5P6S9qo7dertgMtIhawvcOZutp57nUWaTc4/wxXk7M95TmAu2UmRcRe7ISoBbXWnbuXWh3DT
 k721ot4uitdQDOEd83n0EHDCPKChn7IjgJ9W8cmoQzWpDQFkX7jmrBoLvh4HOgrQZlaxHGOd5
 k4mlMpSNzqE7KBxjy5tVRE759lIsPixrDwR3BT+REjfqkWwPEZN77ePFWCmD6iodZmPL9OHxa
 HKSRk4kx+7mF02b6jEa2nMU8+IVUhk9iTy4PNDIPgRXqKLhxKXVZVHKhT7cCJyF12IVeQjiDb
 3+v5IsjuDyNZR1Gmk136ZzW70q3v1CxByt1+c/RE2eeb/BYwDBJezaiXBb0rdgtfETdV5xGK3
 hAvlLqNjASfT1iad7f8oCC+PAqILuRt/xwppTf4ZKGgYZnibR1F7GaTAYgTzpJ3CgNrM7Kelu
 Ib2330oEANVfTuPPvgD8Rpm2S3HszTUVDwZCSK0vIiPqC+skAqKyhQ8nC2UZR7ablzNN/k12M
 x/jlh92ioIer4Jp5D3syL7YaRSvbYV+E+B6hFau+QebNpsgv5qBhyAqin4xX5Djr3MEbPByWR
 CPSQOBR2vE4VIIz/Tu4EIdyolXCJHNKAO3+zxANY8ZlekFq13sdvI5qjP7WIZEI1vaWDqwV7b
 qWZx76KdvyuhlpcFB/7cekDJcbGFZwCLkO1VHZ80iCxHfE5ixc=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 1, 2020 at 5:06 PM Sergey Semin
<Sergey.Semin@baikalelectronics.ru> wrote:
> On Fri, Mar 06, 2020 at 04:19:47PM +0100, Arnd Bergmann wrote:
> > On Fri, Mar 6, 2020 at 2:07 PM <Sergey.Semin@baikalelectronics.ru> wrote:
> > >
> > > From: Serge Semin <fancer.lancer@gmail.com>
> > >
> > > Aside from PCIe/SATA/DDR/I2C/CPU-reboot specific settings the Baikal-T1
> > > system controller provides three vendor-specific blocks. In particular
> > > there are two Errors Handler Blocks to detect and report an info regarding
> > > any problems discovered on the AXI and APB buses. These are the main buses
> > > utilized by the SoC devices to interact with each other. In addition there
> > > is a way to tune the MIPS P5600 CM2 L2-cache up by setting the Tag/Data/WS
> > > L2-to-RAM latencies. All of this functionality is implemented in the
> > > APB/AXI EHB and L2-cache control block drivers to be a part of the kernel soc
> > > subsystem (as being specific to the Baikal-T1 SoC) and introduced in the
> > > framework of this patchset.
> > >
> > > This patchset is rebased and tested on the mainline Linux kernel 5.6-rc4:
> > > commit 98d54f81e36b ("Linux 5.6-rc4").
> >
> > I have no objection to the drivers, but I wonder if these should be
> > in drivers/bus and drivers/memory instead of drivers/soc, which have
> > similar drivers already. The driver for the L2 cache is not really a
> > memory controller driver, but it may be close enough, and we
> > already have a couple of different things in there.
> >

> Regarding l2 driver. Do you really think that L2 cache should be in
> drivers/memory? First there is no any cache-related drivers in that
> subsystem (at least I couldn't find any). Second the Baikal-T1
> L2-cache-RAM config block has just indirect connection with RAM.
> The block just tunes the L2-cache<->RAM stall clock cycles up on
> WS/Tag/Data RAM IO-operations. This config seems more SoC-specific,
> than memory-like. Do you think that the driver should still be in
> drivers/memory?

Either way could work, and both locations are a bit of a dumping
ground for different kinds of drivers. My preference would be
drivers/memory, but if anyone has a strong opinion the other way,
drivers/soc would be acceptable as well.

> On the other hand the block is part of the System Controller. I could
> just embed the l2-cache driver functionality into the System Controller
> MFD driver. Though honestly IMHO the functionality should live in
> a dedicated driver and drivers/soc is a better place for it. I also have
> doubts this part will be well accepted by Lee (drivers/mfd maintainer).
>
> So what do you think?

If you make it a combined driver with the system controller,
drivers/soc would be the most logical place. drivers/mfd should
only be used for a multiplexer with child drivers doing the
actual functionality.

        Arnd
