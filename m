Return-Path: <SRS0=OCv1=CF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_2 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4960C433E3
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Aug 2020 07:10:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A108F20786
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Aug 2020 07:10:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=tq-group.com header.i=@tq-group.com header.b="mBNBSYeh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727823AbgH0HKy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Aug 2020 03:10:54 -0400
Received: from mx1.tq-group.com ([62.157.118.193]:10903 "EHLO mx1.tq-group.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726123AbgH0HKx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Aug 2020 03:10:53 -0400
IronPort-SDR: yAinwcX2cCEO4+JYSsZAnSZVow9K+EXg/qtccYjOqFlUOYwjBluXiuaF5k6R3gzN/UWnL/iT3q
 1tWWpqDqP3H/E6TQwPaLvIYxUWlRdNvn8PtmRJmAuDZbiZKqpl/XiYlW3SXMztmf70DDsldCJy
 AKaJLLgFycV4BtoZo3k6Bi55JWYJb/KG0zv4F1+KZdVL7k4wnmc7SZqBtVLmy3RNJ4OBmlLqj/
 uf5pM1htVu93wf0DSyhcUKS/FEEhamH1NWitWsa2dCDdjYEqOlO+ysuJPlg2+OgpDmXG18j3xH
 vTU=
X-IronPort-AV: E=Sophos;i="5.76,358,1592863200"; 
   d="scan'208";a="13618338"
Received: from unknown (HELO tq-pgp-pr1.tq-net.de) ([192.168.6.15])
  by mx1-pgp.tq-group.com with ESMTP; 27 Aug 2020 09:10:51 +0200
Received: from mx1.tq-group.com ([192.168.6.7])
  by tq-pgp-pr1.tq-net.de (PGP Universal service);
  Thu, 27 Aug 2020 09:10:51 +0200
X-PGP-Universal: processed;
        by tq-pgp-pr1.tq-net.de on Thu, 27 Aug 2020 09:10:51 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1598512251; x=1630048251;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=xXOxLC3BdznWqny8YpTk2yIBPWxEpNFBh+biUoffHDg=;
  b=mBNBSYehf6JlNJ+DNKrJaGTAMOINbNY6mKPhVIazjkYz5Qk4PfcVoPk0
   PW3itPEBk+NnmALVubX8lzd4QvxzYFT9WZiDUCySZm4uCzwFndAYWmTth
   DCh5tYZ5/io+ogrLYyWt5Eh1oT//vEZmrmqk8+vC5wJ7Z1+0ds/L9i+BA
   OqaBAV0fRpr0uUAErhO7HSeKq9AYXKAq+ehVuMaC21wSq5FLq+dq/39Ti
   mqtRwbdrfNKMEbP16PvpNc9wwJ3XC4u044F+wxMSi0YAkvGYLrkc/3Iw3
   GgqT2fuRvxXG9hVZJdNdByAM/9zewqpVjeWzu9nFlOupkk4DCKqEbmnrg
   Q==;
IronPort-SDR: B3DP9B8sACzyKKNq8PJO6mVfwl6O1xOuyAK969Yp/M9eXYNY9qDNQY/BPr6oKzlU86TnMAGOzV
 oIMBvIQusk7FbAc6hQllYYiBZYFquLQFYDIzKQDSiOFBzKxFQIvwQH40zf7/jLn4+0ms9iZuP3
 vPDpzWUYxi5emb8zRPzNKL3pCBD6/NgQC8kXzVmevZ2J3RAxRHFb6VvTPQfrWoDQFleNfA4OWl
 mOchBpVBTta/JR/4+/PJi9eCW7q6uPMcCELtCZCebcl2B1V85HXedTI8FMz9mwH7BkLX/7opV/
 Ris=
X-IronPort-AV: E=Sophos;i="5.76,358,1592863200"; 
   d="scan'208";a="13618337"
Received: from vtuxmail01.tq-net.de ([10.115.0.20])
  by mx1.tq-group.com with ESMTP; 27 Aug 2020 09:10:51 +0200
Received: from schifferm-ubuntu4.tq-net.de (schifferm-ubuntu4.tq-net.de [10.117.49.26])
        by vtuxmail01.tq-net.de (Postfix) with ESMTPA id 54249280065;
        Thu, 27 Aug 2020 09:10:51 +0200 (CEST)
Message-ID: <d7dc1017818e935acf9ba838080bcc3c11b30888.camel@ew.tq-group.com>
Subject: Re: (EXT) Re: (EXT) Re: [PATCH] of: skip disabled CPU nodes
From:   Matthias Schiffer <matthias.schiffer@ew.tq-group.com>
To:     Rob Herring <robh+dt@kernel.org>
Cc:     devicetree@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Frank Rowand <frowand.list@gmail.com>
Date:   Thu, 27 Aug 2020 09:10:49 +0200
In-Reply-To: <CAL_Jsq+1LsTBdVaODVfmB0eme2jMpNL4VgKk-OM7rQWyyF0Jbw@mail.gmail.com>
References: <20200826120254.8902-1-matthias.schiffer@ew.tq-group.com>
         <4dd06b79-1402-d7cf-9676-1f9a9526da12@gmail.com>
         <9eb72c6561333661599411e49072928385629999.camel@ew.tq-group.com>
         <ac64852a-7f2a-6005-f914-268670cd4f95@gmail.com>
         <CAL_Jsq+1LsTBdVaODVfmB0eme2jMpNL4VgKk-OM7rQWyyF0Jbw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2020-08-26 at 13:26 -0600, Rob Herring wrote:
> On Wed, Aug 26, 2020 at 8:47 AM Frank Rowand <frowand.list@gmail.com>
> wrote:
> > 
> > Hi Rob,
> > 
> > On 2020-08-26 08:54, Matthias Schiffer wrote:
> > > On Wed, 2020-08-26 at 08:01 -0500, Frank Rowand wrote:
> > > > On 2020-08-26 07:02, Matthias Schiffer wrote:
> > > > > Allow disabling CPU nodes using status = "disabled".
> > > > > 
> > > > > This allows a bootloader to change the number of available
> > > > > CPUs
> > > > > (for
> > > > > example when a common DTS is used for SoC variants with
> > > > > different
> > > > > numbers
> > > > > of cores) without deleting the nodes altogether (which may
> > > > > require
> > > > > additional fixups where the CPU nodes are referenced, e.g. a
> > > > > cooling
> > > > > map).
> > > > > 
> > > > > Signed-off-by: Matthias Schiffer <
> > > > > matthias.schiffer@ew.tq-group.com
> > > > > > 
> > > > > 
> > > > > ---
> > > > >  drivers/of/base.c | 2 ++
> > > > >  1 file changed, 2 insertions(+)
> > > > > 
> > > > > diff --git a/drivers/of/base.c b/drivers/of/base.c
> > > > > index ea44fea99813..d547e9deced1 100644
> > > > > --- a/drivers/of/base.c
> > > > > +++ b/drivers/of/base.c
> > > > > @@ -796,6 +796,8 @@ struct device_node
> > > > > *of_get_next_cpu_node(struct
> > > > > device_node *prev)
> > > > >             of_node_put(node);
> > > > >     }
> > > > >     for (; next; next = next->sibling) {
> > > > > +           if (!__of_device_is_available(next))
> > > > > +                   continue;
> > > > >             if (!(of_node_name_eq(next, "cpu") ||
> > > > >                   __of_node_is_type(next, "cpu")))
> > > > >                     continue;
> > > > > 
> > > > 
> > > > The original implementation of of_get_next_cpu_node() had
> > > > that check, but status disabled for cpu nodes has different
> > > > semantics than other nodes, and the check broke some systems.
> > > > The check was removed by c961cb3be906 "of: Fix cpu node
> > > > iterator to not ignore disabled cpu nodes".
> > > > 
> > > > It would be useful to document that difference in the
> > > > header comment of of_get_next_cpu_node().
> > > > 
> > > > -Frank
> > > 
> > > Hmm, I see. This difference in behaviour is quite unfortunate, as
> > > I'm
> > > currently looking for a way to *really* disable a CPU core.
> > > 
> > > In arch/arm64/boot/dts/freescale/imx8mn.dtsi (and other variants
> > > of the
> > > i.MX8M), there are 4 CPU nodes for the full-featured quad-core
> > > version.
> > > The reduced single- and dual-core versions are currently handled
> > > in
> > > NXP's U-Boot fork by deleting the additional nodes.
> > > 
> > > Not doing so causes the kernel to hang for a while when trying to
> > > online the non-existent cores during boot (at least in linux-imx
> > > 5.4 -
> > > I have not checked a more recent mainline kernel yet), but the
> > > deletion
> > > is non-trivial to do without leaving dangling phandle references.
> > 
> > Any thoughts on implementing another universal property that means
> > something like "the hardware described by this node does not exist
> > or is so broken that you better not use it".
> 
> There's a couple of options:
> 
> The DT spec defines 'fail' value for status. We could use that
> instead
> of 'disabled'.
> 
> The spec behavior with cpu 'disabled' is only on PPC AFAIK. On
> arm/arm64 (probably riscv now too) we've never followed it where we
> online 'disabled' CPUs. So we could just make the check conditional
> on
> !IS_ENABLED(CONFIG_PPC). This would need some spec update.

On ARM(64), the "disabled" status on CPUs doesn't have any effect. I
assume this changed with the mentioned commit c961cb3be906 "of: Fix cpu
node iterator to not ignore disabled cpu nodes", as reverting it gives
me the desired behaviour of considering the disabled CPUs non-existent.

So it seems that we already changed the interpretation in a non-
compatible way once (back in v4.20), and somehow PPC has yet another
different behaviour?

How do we get out of this mess? Is going back to the v4.19 logic for
non-PPC platforms an acceptable regression fix, or would this be
considered another breaking change?



> 
> > Matthias, if Rob thinks that is a good idea, then you should start
> > with a new proposal that is also sent to
> > devicetree-spec@vger.kernel.org <devicetree-spec@vger.kernel.org>
> > 
> > -Frank
> > 
> > > 
> > > Kind regards,
> > > Matthias
> > > 

