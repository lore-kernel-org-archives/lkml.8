Return-Path: <SRS0=4zup=3T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2BC05C2D0DB
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Jan 2020 19:55:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F1002214AF
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Jan 2020 19:55:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="DI34Wepw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727313AbgA3Tzb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Jan 2020 14:55:31 -0500
Received: from mail-pg1-f193.google.com ([209.85.215.193]:46298 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726267AbgA3Tza (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Jan 2020 14:55:30 -0500
Received: by mail-pg1-f193.google.com with SMTP id z124so2176476pgb.13
        for <linux-kernel@vger.kernel.org>; Thu, 30 Jan 2020 11:55:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=pdsu7RCBoLcVOhLco/AVEx3fQJcXVrKTb9CxbekR3XM=;
        b=DI34WepwXxsfZeW+FSgwROgBDBxak/LrfIeoJFt868CvBtLxqjUhcxo4gex8XV+usX
         5snhM9WM5Auls6RoqhenMBXP3Celv5ymwtrYJ5qpv9kH9PRebunl/KP7I3PjL4yqfs/z
         WPYAA19iWATbE6kVlcEfpF9cLBR7SI7XZ51xOP70l9nLXIxlw6mXPH33ZIR3B7xXVZOT
         +CuDdFqOmmac6rbDbqQKNsjDNzm5lXDVyfZgD5i4WrlkQzuzoWt5DFPXs9EYvBEAjcHZ
         5SqQIBCo1SKFNFDRu8k8ZwlJUi5HPXCnObZ+DnT6mhFo2zm9Z5T31+N+TkHZMwpP3EBR
         UJXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=pdsu7RCBoLcVOhLco/AVEx3fQJcXVrKTb9CxbekR3XM=;
        b=XmOHljsNnNd/RZeRR4MyWRVpXfvPv5tthCGb/M6FvSAVmN//EP8v+0T7kDvCeMzJzM
         SYUvQ5AHrFf/lplsTDRcH/Yq7SHXGLHhKTiewEba/BOSySBrKlqqRkCh98TGfTGicUnn
         WY13yVK5EcdEZrajDLp7ExwjiEJQ9E5wb9sLbm1oMFQSOH+RZkpm5ejmLcVjqwLiAEvt
         NDxohdv7v3CECAOc0j5FJnbCqyucwPz+u3IsfSGGqLtQ1Vg0wPm/DFsI2Jw5Bi1tAwtt
         tWulEN7ryMjA0c/tC/X33AO6ymdwTJKT0/JOGriR9ZsQqQxCKrlfFj3st6mzb23/oX9c
         z0HA==
X-Gm-Message-State: APjAAAXmhcYyYZLrG/NzgQYBXUulwacbmz7hKbhLbvhelrRtomsQmefz
        M2sVYvvSsWRnmpK6B4XmdsWLGosg1oCh8+jm7bilIw==
X-Google-Smtp-Source: APXvYqw8k2aC1UM+gBdhOrs5MjUUN9JfLGAfIAxV2TmfEid43hv0iF4Y2HMsBRUHCIPpJPJWBz+DxywnBx15gs0eVA8=
X-Received: by 2002:a63:1d5f:: with SMTP id d31mr6466014pgm.159.1580414128461;
 Thu, 30 Jan 2020 11:55:28 -0800 (PST)
MIME-Version: 1.0
References: <20191211192742.95699-1-brendanhiggins@google.com>
 <20191211192742.95699-3-brendanhiggins@google.com> <20200109162303.35f4f0a3@xps13>
 <CAFd5g47VLB6zOJsSySAYrJie8hj-OkvOC89-z2b9xMBZ2bxvYA@mail.gmail.com>
 <20200125162803.5a2375d7@xps13> <20200130205030.0f58cb02@xps13>
In-Reply-To: <20200130205030.0f58cb02@xps13>
From:   Brendan Higgins <brendanhiggins@google.com>
Date:   Thu, 30 Jan 2020 11:55:17 -0800
Message-ID: <CAFd5g4736RQLyy-4wNmhLP1qigX7VgYTPSGh-dZGcM5NCeiO=g@mail.gmail.com>
Subject: Re: [PATCH v1 2/7] mtd: rawnand: add unspecified HAS_IOMEM dependency
To:     Miquel Raynal <miquel.raynal@bootlin.com>
Cc:     Jeff Dike <jdike@addtoit.com>, Richard Weinberger <richard@nod.at>,
        Anton Ivanov <anton.ivanov@cambridgegreys.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Boris Brezillon <bbrezillon@kernel.org>,
        Piotr Sroka <piotrs@cadence.com>,
        linux-um <linux-um@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        David Gow <davidgow@google.com>, linux-mtd@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 30, 2020 at 11:50 AM Miquel Raynal
<miquel.raynal@bootlin.com> wrote:
>
> Hello,
>
> Miquel Raynal <miquel.raynal@bootlin.com> wrote on Sat, 25 Jan 2020
> 16:28:03 +0100:
>
> > Hi Brendan,
> >
> > Brendan Higgins <brendanhiggins@google.com> wrote on Fri, 24 Jan 2020
> > 18:12:12 -0800:
> >
> > > On Thu, Jan 9, 2020 at 7:23 AM Miquel Raynal <miquel.raynal@bootlin.com> wrote:
> > > >
> > > > Hi Brendan,
> > > >
> > > > Brendan Higgins <brendanhiggins@google.com> wrote on Wed, 11 Dec 2019
> > > > 11:27:37 -0800:
> > > >
> > > > > Currently CONFIG_MTD_NAND_CADENCE implicitly depends on
> > > > > CONFIG_HAS_IOMEM=y; consequently, on architectures without IOMEM we get
> > > > > the following build error:
> > > > >
> > > > > ld: drivers/mtd/nand/raw/cadence-nand-controller.o: in function `cadence_nand_dt_probe.cold.31':
> > > > > drivers/mtd/nand/raw/cadence-nand-controller.c:2969: undefined reference to `devm_platform_ioremap_resource'
> > > > > ld: drivers/mtd/nand/raw/cadence-nand-controller.c:2977: undefined reference to `devm_ioremap_resource'
> > > > >
> > > > > Fix the build error by adding the unspecified dependency.
> > > > >
> > > > > Reported-by: Brendan Higgins <brendanhiggins@google.com>
> > > > > Signed-off-by: Brendan Higgins <brendanhiggins@google.com>
> > > > > ---
> > > >
> > > > Sorry for the delay.
> > > >
> > > > Acked-by: Miquel Raynal <miquel.raynal@bootlin.com>
> > >
> > > It looks like my change has not been applied to nand/next; is this the
> > > branch it should be applied to? I have also verified that this patch
> > > isn't in linux-next as of Jan 24th.
> > >
> > > Is mtd/linux the correct tree for this? Or do I need to reach out to
> > > someone else?
> >
> > When I sent my Acked-by I supposed someone else would pick the patch,
> > but there is actually no dependency with all the other patches so I
> > don't know why I did it... Sorry about that. I'll take it anyway in my
> > PR for 5.6.
>
> It is applied on top of mtd/next since a few days, it will be part of
> the 5.6 PR.
>
> Sorry for the delay.

No worries.

Thanks!
