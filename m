Return-Path: <SRS0=wESH=6W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC536C47257
	for <linux-kernel@archiver.kernel.org>; Fri,  8 May 2020 20:39:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CEA6421775
	for <linux-kernel@archiver.kernel.org>; Fri,  8 May 2020 20:39:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727812AbgEHUj6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 May 2020 16:39:58 -0400
Received: from mout.kundenserver.de ([217.72.192.73]:55753 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727082AbgEHUj5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 May 2020 16:39:57 -0400
Received: from mail-qt1-f178.google.com ([209.85.160.178]) by
 mrelayeu.kundenserver.de (mreue108 [212.227.15.145]) with ESMTPSA (Nemesis)
 id 1N3sVq-1j6aQV1w8G-00zopu for <linux-kernel@vger.kernel.org>; Fri, 08 May
 2020 22:39:55 +0200
Received: by mail-qt1-f178.google.com with SMTP id l18so1632878qtp.0
        for <linux-kernel@vger.kernel.org>; Fri, 08 May 2020 13:39:55 -0700 (PDT)
X-Gm-Message-State: AGi0PuZtVGxIntlF+PwL/909y3L6niEuHhhDqfOmGzi1853zJ7dgaFFQ
        DMA/K6PZGDx36zLhnnTnMXhiq0+IS4osMGGfvzg=
X-Google-Smtp-Source: APiQypJqGYAN6piCEtJFLWyr7FP9Ysx6dFxrJEMX6KwbmW3NMEUJg8U7dnBX0X60dDOa7c1uRhBNON+W79cF/bQT4e4=
X-Received: by 2002:ac8:490a:: with SMTP id e10mr2828914qtq.7.1588970394325;
 Fri, 08 May 2020 13:39:54 -0700 (PDT)
MIME-Version: 1.0
References: <20200508144017.3501418-1-arnd@arndb.de> <20200508144017.3501418-2-arnd@arndb.de>
 <20200508150041.GI19158@mellanox.com> <CAK8P3a1vCx=XibDdoDqG9obpCFx0JCibAvcKFh6E7_NR_hJ03A@mail.gmail.com>
 <20200508190439.GK19158@mellanox.com>
In-Reply-To: <20200508190439.GK19158@mellanox.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Fri, 8 May 2020 22:39:38 +0200
X-Gmail-Original-Message-ID: <CAK8P3a17yDS4EsSbNibYdhXm5qh=hRBqGx6eHH0bq_Wuv_GG0w@mail.gmail.com>
Message-ID: <CAK8P3a17yDS4EsSbNibYdhXm5qh=hRBqGx6eHH0bq_Wuv_GG0w@mail.gmail.com>
Subject: Re: [PATCH 2/2] nouveau: fix dependencies for DEVICE_PRIVATE
To:     Jason Gunthorpe <jgg@mellanox.com>
Cc:     Ben Skeggs <bskeggs@redhat.com>,
        Felix Kuehling <Felix.Kuehling@amd.com>,
        Christoph Hellwig <hch@lst.de>,
        John Hubbard <jhubbard@nvidia.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Dan Williams <dan.j.williams@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        ML nouveau <nouveau@lists.freedesktop.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:PgtWMWnUG67DbRB1dbL1S9Sfc6LCsgcC5PMEPRXdD9/bZ1KcmlL
 sDqBg6FSZ9HCR6j5P5hAYQAniVSJQpHxpa7IUEqGsSsICuASjcU6dTN1Pc762mGq8aCXTCv
 77o8EFAxIAaDm0e2G6BuyyC9uDFfmkm683LY6A/C8KIcds7c+m2dLIPs526l9w3zzD6MJps
 rNds46uMZEnqwPzRLU0qw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:8gKhqtq3DiM=:/5LHjdjmTPWsSsVZ/Ha7lt
 m2CtgdNqLStZ5POGo/1Dso5ueArlSHJfpJKUqHJPDWB6MRKz5oF8LTtnkjqBjgwp0AZ5gYZyN
 TLvGzEKoOLtLd0xGeyEAVjpey8OZznPCTMPXAMh5e1U4VOri2N4wxli3WDjHKpCvZbU0dpjjs
 dHIldRjiJufMNigQHpq70irOBsQL1S+v+qTNZ+a7jNa4RuOmg7b0oeciO+BcjZNYSHH8LfdzI
 BgY8shhpv9Tr+JG/DkycyVPOSsfsiJFtaZ5DIZ8SpLTrt92Q5wkWFYRK30o8FOJ8XV96jxmBy
 N9XB86M4tntmCwdhpEZR7dxcQ4rtZi118cIwMoAAYTavTswFIMYcPCmzBjEh2c2+5CfOMBTGs
 xvzLe3sjQjDtlq2v8vzTt8tDn7FqEgrfaZklekkPdF4D/lII5PVCX+SEXIbp7bb3/SblEqNWb
 AErdXfYGwFehnTO63OXRfbHg7m2FAWtWSj0Vy49oD5pHdoDPEJBvTUEfIaYTLQ9R3xg8ol1Fn
 gGjlJnCLl3ELpHFz8xqZ0A3HahN7wDqfevHbGscwU5xv6TiZdP6axdFMzSks5alYzzzpjl9mq
 g331e/HGvCNR1rBLO+UBywKW+UtnVX5rZZ/g2vHf5ela7seOMrXJtAIxcdftuM5mrZxMBFh/y
 6HIUpSuh5qws7YhCMA7XY0OxJwp7TuqgtQJbOpkWYegTxCGQ5t2LQTH/cq+xyr2F04crAVpBh
 Lw9WGAV9ghSUG2Pw2OXN2byc7KXnyAOveiPUCJKpFU4fXrDmmcwBZ5d5UozSfJwDgIqfRCK+S
 bAgVPx7fhn3+/NYn24MfbW0KavoQaVqo1u0kMrVpD4Un1j3OAI=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 8, 2020 at 9:04 PM Jason Gunthorpe <jgg@mellanox.com> wrote:
>
> On Fri, May 08, 2020 at 05:05:03PM +0200, Arnd Bergmann wrote:
> > On Fri, May 8, 2020 at 5:00 PM Jason Gunthorpe <jgg@mellanox.com> wrote:
> > >
> > > On Fri, May 08, 2020 at 04:40:09PM +0200, Arnd Bergmann wrote:
> > > > CONFIG_DEVICE_PRIVATE cannot be selected in configurations
> > > > without ZONE_DEVICE:
> > >
> > > It is kind of unfortunate to lift dependencies from DEVICE_PRIVATE
> > > into the users, is this really how kconfig is supposed to work or is
> > > something else wrong here?
> >
> > Usually the problem is trying to use 'select' for something that can
> > be done with 'depends on'. I have actually no idea what
> > CONFIG_DEVICE_PRIVATE does, as it lacks a help text
> > and is a rather generic term.
>
> It is a sub mode of ZONE_DEVICE, ie DEVICE_PRIVATE turns on a certain
> kind of ZONE_DEVICE page.
>
> Both ZONE_DEVICE and DEVICE_PRIVATE are APIs families drivers use,
> there is no reason for a user to select either of these directly.

Ok, then how about making ZONE_DEVICE a hidden symbol and adding
something like

config ZONE_DEVICE_POSSIBLE
        def_bool y
        depends on MEMORY_HOTPLUG
        depends on MEMORY_HOTREMOVE
        depends on SPARSEMEM_VMEMMAP
        depends on ARCH_HAS_PTE_DEVMAP

then drivers that want it can do

config FOO
        tristate "user visible option"
        depends on ZONE_DEVICE_POSSIBLE
        select ZONE_DEVICE

      Arnd
