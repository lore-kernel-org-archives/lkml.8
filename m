Return-Path: <SRS0=UR55=7J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8B71C433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 27 May 2020 18:59:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A10912073B
	for <linux-kernel@archiver.kernel.org>; Wed, 27 May 2020 18:59:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729120AbgE0S7X (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 May 2020 14:59:23 -0400
Received: from mout.kundenserver.de ([212.227.126.134]:45707 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727102AbgE0S7V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 May 2020 14:59:21 -0400
Received: from mail-qk1-f170.google.com ([209.85.222.170]) by
 mrelayeu.kundenserver.de (mreue010 [212.227.15.129]) with ESMTPSA (Nemesis)
 id 1Mt7Pt-1ilDnK0jbV-00tRV9 for <linux-kernel@vger.kernel.org>; Wed, 27 May
 2020 20:59:19 +0200
Received: by mail-qk1-f170.google.com with SMTP id 205so623970qkg.3
        for <linux-kernel@vger.kernel.org>; Wed, 27 May 2020 11:59:19 -0700 (PDT)
X-Gm-Message-State: AOAM533/SLAmROpdbotfwEIAUdXPgAfXxXxgPyotY1jzIi5YuaWwI9yQ
        2IuDfMS9axPe6+FQrNBW5uQPxtUGn8wZ8BS/Wkw=
X-Google-Smtp-Source: ABdhPJwUZo9PT+64uQNfEhYAUh6EMjx46W/CjGf3E5j/pAGPdqXoF+OEkPtr3QUDmPHsFl10qNOELffoBH74TxmMvjM=
X-Received: by 2002:a37:bc7:: with SMTP id 190mr5529182qkl.286.1590605958079;
 Wed, 27 May 2020 11:59:18 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1587485099.git.daniele.alessandrelli@intel.com>
 <13ca92165fab2827b6d439661e75f5b91ef083c2.1587485099.git.daniele.alessandrelli@intel.com>
 <20200501081002.GA1055721@kroah.com> <f60aece195cd0700728fc38b0398949a82b72fc3.camel@linux.intel.com>
 <20200524212851.GG1192@bug> <CAK8P3a225pqBfzQ19e6Gt0s_tYBp29xLb8EG==hhz=1wc7aVCA@mail.gmail.com>
 <ac0534138facc25c4cbcbbff68fc0ba3c2de87b6.camel@linux.intel.com>
 <CAK8P3a2MzqF3P8nY3hAUaAXhTV8ZGQd187UDbNV1GBdu+_z5-g@mail.gmail.com> <561ea2aabf919ef332ec0165351791f6148e8597.camel@linux.intel.com>
In-Reply-To: <561ea2aabf919ef332ec0165351791f6148e8597.camel@linux.intel.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Wed, 27 May 2020 20:59:01 +0200
X-Gmail-Original-Message-ID: <CAK8P3a0OK+BRF2t=8V6Pa95b6Ldcfn3AP1VM+GSsruGRVH=MXQ@mail.gmail.com>
Message-ID: <CAK8P3a0OK+BRF2t=8V6Pa95b6Ldcfn3AP1VM+GSsruGRVH=MXQ@mail.gmail.com>
Subject: Re: [PATCH 1/1] soc: keembay: Add Keem Bay IMR driver
To:     Daniele Alessandrelli <daniele.alessandrelli@linux.intel.com>
Cc:     "pavel@ucw.cz" <pavel@ucw.cz>, "robh@kernel.org" <robh@kernel.org>,
        "Murphy, Paul J" <paul.j.murphy@intel.com>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "Shevchenko, Andriy" <andriy.shevchenko@intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:AWX2wUqR2kfNfDdXRRZD3I66B3cnixv205haRH+gFX+t0c+scjc
 IOZext9ImKwLgc9W049SI14oMgS/vFBjpOsxS+RyrHCy3PVcQKBuIPGQvzAmp2hKzEfoEKO
 dPFNuhaLv30AXT00sCb9VKgfLRzfOBPhgouD36oDUWE1zothOpH7gLk/WNa7qa/+fmNJ4Dk
 +eczzgMTcJb5vBsRDEa/A==
X-UI-Out-Filterresults: notjunk:1;V03:K0:aFmOfK7SrQo=:MDf1lydSgGPLKryAQwW1NA
 kqYU93rOweYZn9Wb+OgsR1YdZlsgQKmIDgzPm3sq4HpDJtYR8lsYDqTFUn0ELzpht2X3qV4Lt
 01o9ZdXSPW1JTIAdIYYGrPYGLP1BrLIXhHEVerYbm5WTJ2bwVYpEI5IGT/GEnMzdB9qpsgOpg
 qyT3oVTWVZCKmCLSfabm78GSQEhcYs/3awsMScYcCovenHAZlLD7J5YsbScQ+LrY22/XL1hQK
 5HpFqk32Z2rqetrd7qLf5xaNxryismszFlczcDtuZSSthTMhr7RhPi7/Ey7bmW3bFyohpFW8h
 K/8CafWRIcA28LSWnD/4V6yQzwFmY3KvlL6EykN6aRqF9kjDdV2+h4LP4mhweYLgAfA8nchUD
 epw8Isv2CBIVD93hN+RlPnVyyiQBdiLGg1BdopT+iXRuU3voPq+/ADfQ3w+TsHQ28VSaBUCZu
 5P1mYk3D2I+QFt7nGKPKYx3GG14GO8Qm3KZYvT2xd7Sf33NQVxhNHqB7bcsvo3w2eftFao59B
 eRpaMVTiivY4nY8oRIRQgNZwpkIh2rm4+lbA+Pd1XlHUu2H+8D+iQQH/hRqjleV8BbIQ0TdxB
 wuH6jSST9WGbxQqkNoyEyX+VCmqAMzBjUO2OckEsz1eos5alGfeW1toMvCftTJTCKC54zYQRW
 07htbJ//9xB610+6CEOATkbzuuUNgUIrQe/QSXkmsFNFzwecloznu354j9tGXW6i0oEzL3x6k
 dATpmTnCTMeEZSSM5lM8rnvLXZBLp6KmhtG5vmSeG+fg4qGhm/EHoh5YqWWCeRJy66CN+JBq5
 QKMWZ7Dt0W9PRnS1wCGtZr0jrF1stPsdn77k9tfqtNwKj78tTo=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 27, 2020 at 7:43 PM Daniele Alessandrelli
<daniele.alessandrelli@linux.intel.com> wrote:
> On Wed, 2020-05-27 at 16:33 +0200, Arnd Bergmann wrote:
> > On Wed, May 27, 2020 at 3:31 PM Alessandrelli, Daniele <daniele.alessandrelli@intel.com> wrote:
> >
> > Adding it back later on with a loadable device driver should
> > not be a problem, as this is not a violation of the boot protocol.
>
> Cool, I'll try to do that then, thanks!
>
> I see two ways to do that though:
>
> 1. Create a device driver that gets a reference to the memory region
> from its DT node and then re-adds the memory to the pool of available
> memory.
>
> 2. Use a special "compatible" string for my memory region and create a
> driver to handle it.

I think the first approach is more common.

> However, I think that in the second case the driver must be builtin.
> Would that be okay?

It's better to avoid that.

> Also, from a quick look, it seems that I can re-add that memory back by
> calling memblock_free() (or a similar memblock_* function). Am I on the
> right track?

I'm not sure if memblock_free() works after early memory initialization
is complete, but I think there is some way to do it later. Maybe try
memblock_free() first, and then look for something else if it doesn't
work.

> > It seems that just reserving the u-boot area and optionally
> > freeing it later from a driver solves most of your problem.
> > I have one related question though: if the kernel itself is
> > protected, does that mean that any driver that does a DMA
> > to statically allocated memory inside of the kernel is broken
> > as well? I think this is something that a couple of USB drivers
> > do, though it is fairly rare. Does u-boot protect both only
> > the executable sections of the kernel or also data, and does
> > the hardware block both read and write on the IMR, or just
> > writes?
>
> Yes, you're very right. Drivers that do DMA transfers to statically
> allocated memory inside the kernel will be broken.
>
> We are currently seeing this with our eMMC driver.
>
> Current solution is to add the eMMC controller to the list of allowed
> "agents" for the IMR. This will reduce the level of protection, but
> since we expect to have only a few of these exceptions (since, as you
> pointed out, drivers that do DMA to static kernel memory seem to be
> quite rare), we think that there is still value in having the Kernel
> IMR.
>
> Do you see any issue with this?

I think you should try to fix the driver rather than making an
exception for it. Hot-pluggable drivers are a much more interesting
case I think, because on the one hand you have no idea what
users might want to plug in legitimately, but on the other hand
those are also the most likely attack vectors (driver bugs for
random USB drivers overwriting kernel memory when faced with
malicious hardware) that this feature is trying to prevent.

I also wonder whether we should do something in the normal
iommu code that prevents one from mapping a page that the
kernel would consider as protected (kernel .text, freed memory,
...) into the iommu in the first place.

        Arnd
