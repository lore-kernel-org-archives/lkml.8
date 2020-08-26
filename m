Return-Path: <SRS0=kGB5=CE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25E0BC433E1
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Aug 2020 19:27:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EB0FC207DF
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Aug 2020 19:27:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1598470026;
	bh=KGOdbQmIJi7o1tlNGdM8FAC/KmxlTK4U1WWqtOMCrZM=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=HQW8qER+RQHMoUtkWTgE8bfiFYAGEwMRdcG6dEvi/HX49v4awZkHN3ePqEPiUCafo
	 gPFur++QONogYCV6umpx8/Vhc6eX6l3txpPEiYV1XMjjUhGP4tJdPzJ+t6B+oYnPJ3
	 lCTa7ATIj8obiTPPyVp6Du+8NyRq07n863JkMyFY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727015AbgHZT1D (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Aug 2020 15:27:03 -0400
Received: from mail.kernel.org ([198.145.29.99]:45196 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726767AbgHZT1A (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Aug 2020 15:27:00 -0400
Received: from mail-ot1-f50.google.com (mail-ot1-f50.google.com [209.85.210.50])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D072A207DF;
        Wed, 26 Aug 2020 19:26:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598470019;
        bh=KGOdbQmIJi7o1tlNGdM8FAC/KmxlTK4U1WWqtOMCrZM=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=nFP3iWj4keKWo3HERvkn+CWyt3kbRaF4qAWIFIku2557d8HB561rdkA0OQ8QcdWQa
         ebIn7sl3kW7TDCZpCazwYA5BXtJCcrFBz9TTscDS8ShpTauxTx1btoKv/oZkxAVPXC
         PqUG2spOOBe5CjqcF2R2s3nwu8fUBseDr/+brmNE=
Received: by mail-ot1-f50.google.com with SMTP id 5so2440759otp.12;
        Wed, 26 Aug 2020 12:26:59 -0700 (PDT)
X-Gm-Message-State: AOAM532up6Q0zSU7ZHQYD5J1QPpTwyLgL1OzQfxG96plxTSm5eGFQpKU
        PtdLoakTIIdsqXEFxkUSlXijBdc5iqh65Fe3/Q==
X-Google-Smtp-Source: ABdhPJzS0HL3diG1Pr6q8/q+50/IZRPxHCzfJ2A4zsqmXS0JLJ8OtyYkAWDQZj55GIybf0Q2WCWou5H2n9U7Uv/COto=
X-Received: by 2002:a9d:7f84:: with SMTP id t4mr11193418otp.192.1598470019192;
 Wed, 26 Aug 2020 12:26:59 -0700 (PDT)
MIME-Version: 1.0
References: <20200826120254.8902-1-matthias.schiffer@ew.tq-group.com>
 <4dd06b79-1402-d7cf-9676-1f9a9526da12@gmail.com> <9eb72c6561333661599411e49072928385629999.camel@ew.tq-group.com>
 <ac64852a-7f2a-6005-f914-268670cd4f95@gmail.com>
In-Reply-To: <ac64852a-7f2a-6005-f914-268670cd4f95@gmail.com>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Wed, 26 Aug 2020 13:26:47 -0600
X-Gmail-Original-Message-ID: <CAL_Jsq+1LsTBdVaODVfmB0eme2jMpNL4VgKk-OM7rQWyyF0Jbw@mail.gmail.com>
Message-ID: <CAL_Jsq+1LsTBdVaODVfmB0eme2jMpNL4VgKk-OM7rQWyyF0Jbw@mail.gmail.com>
Subject: Re: (EXT) Re: [PATCH] of: skip disabled CPU nodes
To:     Frank Rowand <frowand.list@gmail.com>
Cc:     Matthias Schiffer <matthias.schiffer@ew.tq-group.com>,
        devicetree@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 26, 2020 at 8:47 AM Frank Rowand <frowand.list@gmail.com> wrote:
>
> Hi Rob,
>
> On 2020-08-26 08:54, Matthias Schiffer wrote:
> > On Wed, 2020-08-26 at 08:01 -0500, Frank Rowand wrote:
> >> On 2020-08-26 07:02, Matthias Schiffer wrote:
> >>> Allow disabling CPU nodes using status = "disabled".
> >>>
> >>> This allows a bootloader to change the number of available CPUs
> >>> (for
> >>> example when a common DTS is used for SoC variants with different
> >>> numbers
> >>> of cores) without deleting the nodes altogether (which may require
> >>> additional fixups where the CPU nodes are referenced, e.g. a
> >>> cooling
> >>> map).
> >>>
> >>> Signed-off-by: Matthias Schiffer <matthias.schiffer@ew.tq-group.com
> >>>>
> >>> ---
> >>>  drivers/of/base.c | 2 ++
> >>>  1 file changed, 2 insertions(+)
> >>>
> >>> diff --git a/drivers/of/base.c b/drivers/of/base.c
> >>> index ea44fea99813..d547e9deced1 100644
> >>> --- a/drivers/of/base.c
> >>> +++ b/drivers/of/base.c
> >>> @@ -796,6 +796,8 @@ struct device_node *of_get_next_cpu_node(struct
> >>> device_node *prev)
> >>>             of_node_put(node);
> >>>     }
> >>>     for (; next; next = next->sibling) {
> >>> +           if (!__of_device_is_available(next))
> >>> +                   continue;
> >>>             if (!(of_node_name_eq(next, "cpu") ||
> >>>                   __of_node_is_type(next, "cpu")))
> >>>                     continue;
> >>>
> >>
> >> The original implementation of of_get_next_cpu_node() had
> >> that check, but status disabled for cpu nodes has different
> >> semantics than other nodes, and the check broke some systems.
> >> The check was removed by c961cb3be906 "of: Fix cpu node
> >> iterator to not ignore disabled cpu nodes".
> >>
> >> It would be useful to document that difference in the
> >> header comment of of_get_next_cpu_node().
> >>
> >> -Frank
> >
> > Hmm, I see. This difference in behaviour is quite unfortunate, as I'm
> > currently looking for a way to *really* disable a CPU core.
> >
> > In arch/arm64/boot/dts/freescale/imx8mn.dtsi (and other variants of the
> > i.MX8M), there are 4 CPU nodes for the full-featured quad-core version.
> > The reduced single- and dual-core versions are currently handled in
> > NXP's U-Boot fork by deleting the additional nodes.
> >
> > Not doing so causes the kernel to hang for a while when trying to
> > online the non-existent cores during boot (at least in linux-imx 5.4 -
> > I have not checked a more recent mainline kernel yet), but the deletion
> > is non-trivial to do without leaving dangling phandle references.
>
> Any thoughts on implementing another universal property that means
> something like "the hardware described by this node does not exist
> or is so broken that you better not use it".

There's a couple of options:

The DT spec defines 'fail' value for status. We could use that instead
of 'disabled'.

The spec behavior with cpu 'disabled' is only on PPC AFAIK. On
arm/arm64 (probably riscv now too) we've never followed it where we
online 'disabled' CPUs. So we could just make the check conditional on
!IS_ENABLED(CONFIG_PPC). This would need some spec update.

> Matthias, if Rob thinks that is a good idea, then you should start
> with a new proposal that is also sent to
> devicetree-spec@vger.kernel.org <devicetree-spec@vger.kernel.org>
>
> -Frank
>
> >
> > Kind regards,
> > Matthias
> >
>
