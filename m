Return-Path: <SRS0=5bHT=BN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51699C433E0
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Aug 2020 13:21:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 31EFF20738
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Aug 2020 13:21:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726857AbgHCNVT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Aug 2020 09:21:19 -0400
Received: from mail3-relais-sop.national.inria.fr ([192.134.164.104]:45952
        "EHLO mail3-relais-sop.national.inria.fr" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725948AbgHCNVS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Aug 2020 09:21:18 -0400
X-IronPort-AV: E=Sophos;i="5.75,430,1589234400"; 
   d="scan'208";a="355862004"
Received: from clt-128-93-177-162.vpn.inria.fr ([128.93.177.162])
  by mail3-relais-sop.national.inria.fr with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 03 Aug 2020 15:21:15 +0200
Date:   Mon, 3 Aug 2020 15:21:15 +0200 (CEST)
From:   Julia Lawall <julia.lawall@inria.fr>
X-X-Sender: julia@hadrien
To:     Markus Elfring <Markus.Elfring@web.de>
cc:     Denis Efremov <efremov@linux.com>,
        Gilles Muller <Gilles.Muller@lip6.fr>,
        Julia Lawall <julia.lawall@inria.fr>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Michal Marek <michal.lkml@markovi.net>,
        Nicolas Palix <nicolas.palix@imag.fr>,
        Coccinelle <cocci@systeme.lip6.fr>, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] coccinelle: api: add kvmalloc script
In-Reply-To: <cd186837-3753-436a-b1f6-7e1dfe5ff5e0@web.de>
Message-ID: <alpine.DEB.2.22.394.2008031519520.27678@hadrien>
References: <cd186837-3753-436a-b1f6-7e1dfe5ff5e0@web.de>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-183462625-1596460875=:27678"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-183462625-1596460875=:27678
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT



On Mon, 3 Aug 2020, Markus Elfring wrote:

> …
> > +++ b/scripts/coccinelle/api/kvmalloc.cocci
> …
> > +@opportunity depends on !patch@
> > +expression E, E1, size;
> > +position p;
> > +@@
> > +
> > +(
> …
> > +|
> > +* E = \(kmalloc\|kzalloc\|kcalloc\|kmalloc_node\|kzalloc_node\|
> > +*       kmalloc_array\|kmalloc_array_node\|kcalloc_node\)(..., size, ...)
> > +  ... when != E = E1
> > +      when != size = E1
> > +      when any
> > +* if (\(!E\|E == NULL\))@p {

Actually, you shouldn't need both E == NULL and !E.  E == NULL should be
sufficient.

julia

> …
>
> I suggest to extend the SmPL code exclusion specification so that
> pointer dereferences will be filtered out before the shown null pointer detection.
>
>
> > +@depends on patch@
> > +expression E, E1, flags, size, node;
> > +identifier x;
> > +type T;
> > +@@
> > +
> > +(
> > +- if (\(size <= E1\|size < E1\|size == E1\|size > E1\))
>
> This condition check is repeated a few times.
> Thus I imagine that the usage of another metavariable with a SmPL constraint
> can eventually be helpful.
>
> +binary operator bo = {<=, <, ==, >};
> …
> +-if (size bo E1)
>
>
>
> > +-    E = kmalloc(size, flags);
> > +- else
> > +-    E = vmalloc(size);
>
> Will it be interesting to support also the use of conditional operators
> by another part of a SmPL disjunction?
>
> -E = (…) ? kmalloc(size, flags) : vmalloc(size);
>
>
> > ++ E = kvmalloc(size, flags);
> > +|
> > +- E = kmalloc(size, flags | __GFP_NOWARN);
> > +- if (\(!E\|E == NULL\))
> > +-   E = vmalloc(size);
> > ++ E = kvmalloc(size, flags);
>
> This source code replacement line is repeated. Thus I imagine
> that it would be nice if such SmPL code duplication could be avoided
> by the application of another SmPL disjunction.
> Unfortunately, the software “Coccinelle 1.0.8-00146-g04f36d53” presents
> the error message “15: no available token to attach to” then.
> Would you like to adjust anything in this area?
>
> Regards,
> Markus
>
--8323329-183462625-1596460875=:27678--
