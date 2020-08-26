Return-Path: <SRS0=kGB5=CE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_2 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B60AC433E1
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Aug 2020 13:54:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 000CD208E4
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Aug 2020 13:54:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=tq-group.com header.i=@tq-group.com header.b="CN37Jl22"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730545AbgHZNyx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Aug 2020 09:54:53 -0400
Received: from mx1.tq-group.com ([62.157.118.193]:18337 "EHLO mx1.tq-group.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730575AbgHZNyq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Aug 2020 09:54:46 -0400
IronPort-SDR: 4qZEJQfbxShC9ygBEgk8Bq0woVrWk10KVvg60Pk6LDwUzH88EDTbmntil5v6zOkSa0vdLEo3Wv
 oMMTG0Je0e+Lfy8DEtQ+he48QvbIt60OrqHuVwJPjsMswWzBskxYWUEnacYGbkqGy8b47bOtDR
 BPO6OOI9xGEcx+4B4G4Tp3NLmSeKZGirGv71UshA/6bFXQQFRjCM9PaYpRo4O8FaxHeCwqwC4B
 6fLrtIueUdyr48buvs0fsGiu5QRR9uLcSKUxjPCS+HMXB25cnmtCQTlcBnUmYQDJEDRXHqc1cQ
 9XU=
X-IronPort-AV: E=Sophos;i="5.76,355,1592863200"; 
   d="scan'208";a="13610172"
Received: from unknown (HELO tq-pgp-pr1.tq-net.de) ([192.168.6.15])
  by mx1-pgp.tq-group.com with ESMTP; 26 Aug 2020 15:54:44 +0200
Received: from mx1.tq-group.com ([192.168.6.7])
  by tq-pgp-pr1.tq-net.de (PGP Universal service);
  Wed, 26 Aug 2020 15:54:44 +0200
X-PGP-Universal: processed;
        by tq-pgp-pr1.tq-net.de on Wed, 26 Aug 2020 15:54:44 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1598450084; x=1629986084;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=oyBCdI37qgrjRW4ghqxsqRMW6f2Kj9dxEiEcFm2sbnA=;
  b=CN37Jl22/apgtqmLB84TILsD4PXVk9tulsTP69yGaKuAB3gWKo0vDP1m
   fLuNLcNd7keJBu0/jdTUILSZnxarNLOklw7AvbpCVNAaSAnsoCB3gW49i
   clmoaUCH/OGp1x6FV3UE5hoGeThyuAf5hoFApigKkA1iLqPuj1ObRiuJZ
   hyHZPZKkEdaA1eV+7ftFH11xlhwPll8xwofnQs7WjYViCNzD8rcDf62sv
   a59tWmJY+UdO+/MvxaW92vNedDZ1dFe8NqBUA2G8Ps2Bi0fuCoYGuaX4T
   p/DoRrZSpR56y247TeaMjkSAUAA4e4CxOK5jOufFCSv9LZeN32JjpqTmw
   g==;
IronPort-SDR: fQCFrSQyelniZqboToTRYXgqlViufbT06V39C9FC1eWA3/HJ3YSpykrd7ggg4fxhTZh54mvkvO
 f3RI+rODB/e0R9GxJmUK+RWrvrt7GyfVibTkuDE6eGSiXreBJ4LXDWTot8fKaAL99l2uQk8zJB
 EGGHWYKd9EdDymqI59FszoD2emXI/P47GlqMkAfmvbL8rJGYEICkP2wp0/RLZqfG+99MFTx4Wd
 qTUkozq4EdeoUCx5ko6M3pRrqNC+50ipRyrFqbk1DXzRjkr6tOIH11vjHRPbplBjxJYdS5XnQw
 /3w=
X-IronPort-AV: E=Sophos;i="5.76,355,1592863200"; 
   d="scan'208";a="13610171"
Received: from vtuxmail01.tq-net.de ([10.115.0.20])
  by mx1.tq-group.com with ESMTP; 26 Aug 2020 15:54:44 +0200
Received: from schifferm-ubuntu4.tq-net.de (schifferm-ubuntu4.tq-net.de [10.117.49.26])
        by vtuxmail01.tq-net.de (Postfix) with ESMTPA id 71109280065;
        Wed, 26 Aug 2020 15:54:44 +0200 (CEST)
Message-ID: <9eb72c6561333661599411e49072928385629999.camel@ew.tq-group.com>
Subject: Re: (EXT) Re: [PATCH] of: skip disabled CPU nodes
From:   Matthias Schiffer <matthias.schiffer@ew.tq-group.com>
To:     Frank Rowand <frowand.list@gmail.com>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>
Date:   Wed, 26 Aug 2020 15:54:42 +0200
In-Reply-To: <4dd06b79-1402-d7cf-9676-1f9a9526da12@gmail.com>
References: <20200826120254.8902-1-matthias.schiffer@ew.tq-group.com>
         <4dd06b79-1402-d7cf-9676-1f9a9526da12@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2020-08-26 at 08:01 -0500, Frank Rowand wrote:
> On 2020-08-26 07:02, Matthias Schiffer wrote:
> > Allow disabling CPU nodes using status = "disabled".
> > 
> > This allows a bootloader to change the number of available CPUs
> > (for
> > example when a common DTS is used for SoC variants with different
> > numbers
> > of cores) without deleting the nodes altogether (which may require
> > additional fixups where the CPU nodes are referenced, e.g. a
> > cooling
> > map).
> > 
> > Signed-off-by: Matthias Schiffer <matthias.schiffer@ew.tq-group.com
> > >
> > ---
> >  drivers/of/base.c | 2 ++
> >  1 file changed, 2 insertions(+)
> > 
> > diff --git a/drivers/of/base.c b/drivers/of/base.c
> > index ea44fea99813..d547e9deced1 100644
> > --- a/drivers/of/base.c
> > +++ b/drivers/of/base.c
> > @@ -796,6 +796,8 @@ struct device_node *of_get_next_cpu_node(struct
> > device_node *prev)
> >  		of_node_put(node);
> >  	}
> >  	for (; next; next = next->sibling) {
> > +		if (!__of_device_is_available(next))
> > +			continue;
> >  		if (!(of_node_name_eq(next, "cpu") ||
> >  		      __of_node_is_type(next, "cpu")))
> >  			continue;
> > 
> 
> The original implementation of of_get_next_cpu_node() had
> that check, but status disabled for cpu nodes has different
> semantics than other nodes, and the check broke some systems.
> The check was removed by c961cb3be906 "of: Fix cpu node
> iterator to not ignore disabled cpu nodes".
> 
> It would be useful to document that difference in the
> header comment of of_get_next_cpu_node().
> 
> -Frank

Hmm, I see. This difference in behaviour is quite unfortunate, as I'm
currently looking for a way to *really* disable a CPU core.

In arch/arm64/boot/dts/freescale/imx8mn.dtsi (and other variants of the
i.MX8M), there are 4 CPU nodes for the full-featured quad-core version.
The reduced single- and dual-core versions are currently handled in
NXP's U-Boot fork by deleting the additional nodes.

Not doing so causes the kernel to hang for a while when trying to
online the non-existent cores during boot (at least in linux-imx 5.4 -
I have not checked a more recent mainline kernel yet), but the deletion
is non-trivial to do without leaving dangling phandle references.

Kind regards,
Matthias

