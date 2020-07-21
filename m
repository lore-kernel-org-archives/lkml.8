Return-Path: <SRS0=jpuI=BA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7787CC433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jul 2020 09:58:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 545C320729
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jul 2020 09:58:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729048AbgGUJ66 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Jul 2020 05:58:58 -0400
Received: from mail2-relais-roc.national.inria.fr ([192.134.164.83]:25483 "EHLO
        mail2-relais-roc.national.inria.fr" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726415AbgGUJ65 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jul 2020 05:58:57 -0400
X-IronPort-AV: E=Sophos;i="5.75,378,1589234400"; 
   d="scan'208";a="460637932"
Received: from abo-173-121-68.mrs.modulonet.fr (HELO hadrien) ([85.68.121.173])
  by mail2-relais-roc.national.inria.fr with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 21 Jul 2020 11:58:55 +0200
Date:   Tue, 21 Jul 2020 11:58:55 +0200 (CEST)
From:   Julia Lawall <julia.lawall@inria.fr>
X-X-Sender: jll@hadrien
To:     Markus Elfring <Markus.Elfring@web.de>
cc:     Denis Efremov <efremov@linux.com>,
        Coccinelle <cocci@systeme.lip6.fr>,
        Gilles Muller <Gilles.Muller@lip6.fr>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Michal Marek <michal.lkml@markovi.net>,
        Nicolas Palix <nicolas.palix@imag.fr>,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: Re: [PATCH v3 2/3] coccinelle: api: extend memdup_user rule with
 vmemdup_user()
In-Reply-To: <e3d2ffb9-2a47-3d77-0501-9d48845435bd@web.de>
Message-ID: <alpine.DEB.2.22.394.2007211158310.2487@hadrien>
References: <e3d2ffb9-2a47-3d77-0501-9d48845435bd@web.de>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-577759684-1595325535=:2487"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-577759684-1595325535=:2487
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT



On Tue, 21 Jul 2020, Markus Elfring wrote:

> …
> > +++ b/scripts/coccinelle/api/memdup_user.cocci
> > @@ -39,6 +39,28 @@ …
> …
> > +@depends on patch@
> > +expression from,to,size;
> > +identifier l1,l2;
> > +@@
> > +
> > +-  to = \(kvmalloc\|kvzalloc\)(size,\(GFP_KERNEL\|GFP_USER\));
> > ++  to = vmemdup_user(from,size);
>
> I propose to combine the desired adjustment with the previous SmPL rule
> by using another disjunction.
>
>
> > +@rv depends on !patch@
> > +expression from,to,size;
> > +position p;
> > +statement S1,S2;
> > +@@
> > +
> > +*  to = \(kvmalloc@p\|kvzalloc@p\)(size,\(GFP_KERNEL\|GFP_USER\));
> > +   if (to==NULL || ...) S1
> > +   if (copy_from_user(to, from, size) != 0)
> > +   S2
>
> * Can it be helpful to omit the SmPL asterisk functionality from
>   the operation modes “org” and “report”?
>
> * Should the operation mode “context” work without an extra position metavariable?

This is fine as is in all three aspects.

julia
--8323329-577759684-1595325535=:2487--
