Return-Path: <SRS0=5pK+=BB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1576BC433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jul 2020 06:02:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D9D5E207DD
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jul 2020 06:02:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728259AbgGVGCl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Jul 2020 02:02:41 -0400
Received: from mail3-relais-sop.national.inria.fr ([192.134.164.104]:3090 "EHLO
        mail3-relais-sop.national.inria.fr" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727084AbgGVGCk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jul 2020 02:02:40 -0400
X-IronPort-AV: E=Sophos;i="5.75,381,1589234400"; 
   d="scan'208";a="354990745"
Received: from abo-173-121-68.mrs.modulonet.fr (HELO hadrien) ([85.68.121.173])
  by mail3-relais-sop.national.inria.fr with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 22 Jul 2020 08:02:37 +0200
Date:   Wed, 22 Jul 2020 08:02:37 +0200 (CEST)
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
In-Reply-To: <0b326e2b-723c-3482-c0ef-5d6592a9c6cb@web.de>
Message-ID: <alpine.DEB.2.22.394.2007220801590.2918@hadrien>
References: <e3d2ffb9-2a47-3d77-0501-9d48845435bd@web.de> <alpine.DEB.2.22.394.2007211158310.2487@hadrien> <0b326e2b-723c-3482-c0ef-5d6592a9c6cb@web.de>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-416411769-1595397758=:2918"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-416411769-1595397758=:2918
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT



On Wed, 22 Jul 2020, Markus Elfring wrote:

> >>> +@depends on patch@
> >>> +expression from,to,size;
> >>> +identifier l1,l2;
> >>> +@@
> >>> +
> >>> +-  to = \(kvmalloc\|kvzalloc\)(size,\(GFP_KERNEL\|GFP_USER\));
> >>> ++  to = vmemdup_user(from,size);
> >>
> >> I propose to combine the desired adjustment with the previous SmPL rule
> >> by using another disjunction.
>
> How do you think about to check run time characteristics for
> the following SmPL script sketches?
>
> A)
> @R1@
> @@
> // Change something
>
> @R2@
> @@
> // Change another thing
>
>
> B)
> @Replacement_with_disjunction@
> @@
> (
> // R1: Change something
> |
> // R2: Change another thing
> )

Markus, you are welcome to try this since you are concerned about it.
But it doesn't matter.

julia

>
>
> >>> +@rv depends on !patch@
> >>> +expression from,to,size;
> >>> +position p;
> >>> +statement S1,S2;
> >>> +@@
> >>> +
> >>> +*  to = \(kvmalloc@p\|kvzalloc@p\)(size,\(GFP_KERNEL\|GFP_USER\));
> >>> +   if (to==NULL || ...) S1
> >>> +   if (copy_from_user(to, from, size) != 0)
> >>> +   S2
> >>
> >> * Can it be helpful to omit the SmPL asterisk functionality from
> >>   the operation modes “org” and “report”?
> >>
> >> * Should the operation mode “context” work without an extra position metavariable?
> >
> > This is fine as is in all three aspects.
>
> Is every technique from the Coccinelle software required for
> each operation mode in such data processing approaches?
>
> Regards,
> Markus
>
--8323329-416411769-1595397758=:2918--
