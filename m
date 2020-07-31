Return-Path: <SRS0=S/iQ=BK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF41DC433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Jul 2020 14:38:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9339B2177B
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Jul 2020 14:38:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728840AbgGaOip (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 Jul 2020 10:38:45 -0400
Received: from mail3-relais-sop.national.inria.fr ([192.134.164.104]:9719 "EHLO
        mail3-relais-sop.national.inria.fr" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726353AbgGaOip (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Jul 2020 10:38:45 -0400
X-IronPort-AV: E=Sophos;i="5.75,418,1589234400"; 
   d="scan'208";a="355717043"
Received: from abo-173-121-68.mrs.modulonet.fr (HELO hadrien) ([85.68.121.173])
  by mail3-relais-sop.national.inria.fr with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 31 Jul 2020 16:38:42 +0200
Date:   Fri, 31 Jul 2020 16:38:42 +0200 (CEST)
From:   Julia Lawall <julia.lawall@inria.fr>
X-X-Sender: jll@hadrien
To:     Markus Elfring <Markus.Elfring@web.de>
cc:     Julia Lawall <julia.lawall@inria.fr>,
        Denis Efremov <efremov@linux.com>,
        Coccinelle <cocci@systeme.lip6.fr>,
        Gilles Muller <Gilles.Muller@lip6.fr>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Michal Marek <michal.lkml@markovi.net>,
        Nicolas Palix <nicolas.palix@imag.fr>,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: Re: [v4] coccinelle: api: add kvfree script
In-Reply-To: <06eaa1fe-5047-89f7-3995-a38d80030e7f@web.de>
Message-ID: <alpine.DEB.2.22.394.2007311637570.2455@hadrien>
References: <75532a99-4498-c64a-de34-c9033782aa9e@web.de> <alpine.DEB.2.22.394.2007302125580.2548@hadrien> <96a71d0e-ae6f-9355-b02a-b1a084376f1e@web.de> <alpine.DEB.2.22.394.2007311044340.2439@hadrien> <06eaa1fe-5047-89f7-3995-a38d80030e7f@web.de>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On Fri, 31 Jul 2020, Markus Elfring wrote:

> >>>>> +msg = "WARNING: kmalloc is used to allocate this memory at line %s" % (k[0].line)
> >>>>> +coccilib.org.print_todo(p[0], msg)
> >>>>
> >>>> * I find the diagnostic text insufficient.
> >>>
> >>> I also find the message not very informative.
> >>
> >> Is it interesting how quick such views can change?
> >
> > Yes.  If one looks at something in context, one and understand it better
> > than the extract that you provided.
>
> Should the provided information (and its intention) be understandable from
> the diagnostic message alone already?

It is understandable from the message and from the positions that are
indicated.  That's good enough.

julia
