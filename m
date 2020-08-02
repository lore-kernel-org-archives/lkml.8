Return-Path: <SRS0=HA/2=BM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A65BC433DF
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Aug 2020 07:09:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3FC242076B
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Aug 2020 07:09:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726965AbgHBHJH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 2 Aug 2020 03:09:07 -0400
Received: from mail3-relais-sop.national.inria.fr ([192.134.164.104]:10315
        "EHLO mail3-relais-sop.national.inria.fr" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725880AbgHBHJH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Aug 2020 03:09:07 -0400
X-IronPort-AV: E=Sophos;i="5.75,425,1589234400"; 
   d="scan'208";a="355791197"
Received: from abo-173-121-68.mrs.modulonet.fr (HELO hadrien) ([85.68.121.173])
  by mail3-relais-sop.national.inria.fr with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 02 Aug 2020 09:09:04 +0200
Date:   Sun, 2 Aug 2020 09:09:04 +0200 (CEST)
From:   Julia Lawall <julia.lawall@inria.fr>
X-X-Sender: jll@hadrien
To:     Markus Elfring <Markus.Elfring@web.de>
cc:     Denis Efremov <efremov@linux.com>,
        Coccinelle <cocci@systeme.lip6.fr>,
        Gilles Muller <Gilles.Muller@lip6.fr>,
        Julia Lawall <julia.lawall@inria.fr>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Michal Marek <michal.lkml@markovi.net>,
        Nicolas Palix <nicolas.palix@imag.fr>,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: Re: [PATCH v6] coccinelle: api: add kvfree script
In-Reply-To: <3aea12cf-68dc-e140-936f-cfefb2adbc8f@web.de>
Message-ID: <alpine.DEB.2.22.394.2008020907220.2531@hadrien>
References: <3aea12cf-68dc-e140-936f-cfefb2adbc8f@web.de>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-429177205-1596352144=:2531"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-429177205-1596352144=:2531
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT



On Sun, 2 Aug 2020, Markus Elfring wrote:

> …
> > +++ b/scripts/coccinelle/api/kvfree.cocci
> …
> > +@choice@
> > +expression E, E1;
> > +position kok, vok;
> > +@@
> > +
> > +(
> …
> > +|
> > +  E = \(kmalloc\|kzalloc\|krealloc\|kcalloc\|kmalloc_node\|kzalloc_node\|
> > +        kmalloc_array\|kmalloc_array_node\|kcalloc_node\)(...)@kok
> > +  ... when != E = E1
> > +      when any
> > +  if (\(!E\|E == NULL\)) {
> …
>
> Can the SmPL code exclusion specification be incomplete here?
>
> How do you think about to check also if the memory is passed to any function
> (or macro) calls before the shown detection of a null pointer?

It seems both extremely unlikely and not relevant to the question at hand.
Passing E to another function will not change the value of E itself.
Passing &E to another function could change E, but it would be very
unusual to do that, and doesn't seem worth checking for.

julia
--8323329-429177205-1596352144=:2531--
