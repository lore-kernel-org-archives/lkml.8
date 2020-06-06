Return-Path: <SRS0=ne2O=7T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C22DCC433E0
	for <linux-kernel@archiver.kernel.org>; Sat,  6 Jun 2020 11:11:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8D2812074B
	for <linux-kernel@archiver.kernel.org>; Sat,  6 Jun 2020 11:11:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728745AbgFFLLt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 6 Jun 2020 07:11:49 -0400
Received: from mail2-relais-roc.national.inria.fr ([192.134.164.83]:20090 "EHLO
        mail2-relais-roc.national.inria.fr" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725831AbgFFLLt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 6 Jun 2020 07:11:49 -0400
X-IronPort-AV: E=Sophos;i="5.73,479,1583190000"; 
   d="scan'208";a="453305694"
Received: from abo-173-121-68.mrs.modulonet.fr (HELO hadrien) ([85.68.121.173])
  by mail2-relais-roc.national.inria.fr with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 06 Jun 2020 13:11:47 +0200
Date:   Sat, 6 Jun 2020 13:11:46 +0200 (CEST)
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
Subject: Re: coccinelle: api: add kvfree script
In-Reply-To: <51a176d4-8c59-5da1-b4d2-c97b17b691a7@web.de>
Message-ID: <alpine.DEB.2.21.2006061307020.2578@hadrien>
References: <99ed463c-b7ba-0400-7cf7-5bcc1992baef@web.de> <alpine.DEB.2.21.2006060944320.2578@hadrien> <51a176d4-8c59-5da1-b4d2-c97b17b691a7@web.de>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On Sat, 6 Jun 2020, Markus Elfring wrote:

> >>> +    E = \(kmalloc@kok\|kzalloc@kok\|krealloc@kok\|kcalloc@kok\|kmalloc_node@kok\|kzalloc_node@kok\|kmalloc_array@kok\|kmalloc_array_node@kok\|kcalloc_node@kok\)(...)
> >>
> >> I would prefer an other coding style here.
> >>
> >> * Items for such SmPL disjunctions can be specified also on multiple lines.
> >>
> >> * The semantic patch language supports further means to handle function name lists
> >>   in more convenient ways.
> >>   Would you like to work with customised constraints?
> >
> > Please don't follow this advice.
>
> I have got recurring understanding difficulties with such a response.
> Will quoted patch review issues clarified in any other ways?
>
>
> > Coccinelle is not able to optimize its search process according to
> > the information in constraints.  It will needlessly parse many files.
>
> The software supports also SmPL constraints for some reasons.
> Why should such functionality be used at all if the immediate reminder is
> there seem to be more important optimisation aspects to consider before?

If the number of functions is really large, constraints may be a better
idea.

If the names of the functions are not actually known, constraints may be a
better idea.

If it is desired to collect some statistics about the matching process,
constraints allow that.

If it is desired to reason about values, for example that a constant is
greater or less than some value, then constraints allow that.

If it is desired to avoid changing code in a particular function, then
constraints allow that.

So there are a lot of reasons why constraints are useful.  There are
likely even more.  But hiding information that could be apparent to the
SmPL compiler and could be used to improve the performance of the matching
process is not one of them.

julia
