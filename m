Return-Path: <SRS0=Cjtw=7V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0795BC433E0
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jun 2020 18:36:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CF58D2063A
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jun 2020 18:36:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725968AbgFHSge (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Jun 2020 14:36:34 -0400
Received: from mail2-relais-roc.national.inria.fr ([192.134.164.83]:61224 "EHLO
        mail2-relais-roc.national.inria.fr" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725280AbgFHSge (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Jun 2020 14:36:34 -0400
X-IronPort-AV: E=Sophos;i="5.73,487,1583190000"; 
   d="scan'208";a="453622896"
Received: from abo-173-121-68.mrs.modulonet.fr (HELO hadrien) ([85.68.121.173])
  by mail2-relais-roc.national.inria.fr with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 08 Jun 2020 20:36:32 +0200
Date:   Mon, 8 Jun 2020 20:36:31 +0200 (CEST)
From:   Julia Lawall <julia.lawall@inria.fr>
X-X-Sender: jll@hadrien
To:     Markus Elfring <Markus.Elfring@web.de>
cc:     Denis Efremov <efremov@linux.com>,
        Coccinelle <cocci@systeme.lip6.fr>,
        Gilles Muller <Gilles.Muller@lip6.fr>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Michal Marek <michal.lkml@markovi.net>,
        Nicolas Palix <nicolas.palix@imag.fr>,
        kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/4] coccinelle: api: extend memdup_user rule with
 vmemdup_user()
In-Reply-To: <6c9c6a4c-c305-ddab-8a1b-e4dc448d643f@web.de>
Message-ID: <alpine.DEB.2.21.2006082035580.3136@hadrien>
References: <6c9c6a4c-c305-ddab-8a1b-e4dc448d643f@web.de>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-1412814973-1591641392=:3136"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-1412814973-1591641392=:3136
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT



On Mon, 8 Jun 2020, Markus Elfring wrote:

> …
> +++ b/scripts/coccinelle/api/memdup_user.cocci
> @@ -39,6 +39,28 @@ …
> …
> > +@depends on patch@
> > +expression from,to,size;
> > +identifier l1,l2;
> > +@@
> > +
> > +-  to = \(kvmalloc\|kvzalloc\)(size,\(GFP_KERNEL\|GFP_USER\));
> > ++  to = vmemdup_user(from,size);
>
> I suggest to combine the desired adjustment with the previous SmPL rule
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
> How does the SmPL asterisk functionality fit to the operation
> modes “org” and “report”?

Make coccicheck uses --no-show-diff for org and report modes, so the * has
no effect in those cases.

julia
--8323329-1412814973-1591641392=:3136--
