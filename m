Return-Path: <SRS0=PjrZ=CH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1870C433E6
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Aug 2020 13:23:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A4E4D214DB
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Aug 2020 13:23:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728269AbgH2NXv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 29 Aug 2020 09:23:51 -0400
Received: from mail3-relais-sop.national.inria.fr ([192.134.164.104]:47697
        "EHLO mail3-relais-sop.national.inria.fr" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728180AbgH2NKf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Aug 2020 09:10:35 -0400
X-IronPort-AV: E=Sophos;i="5.76,359,1592863200"; 
   d="scan'208";a="357585620"
Received: from abo-173-121-68.mrs.modulonet.fr (HELO hadrien) ([85.68.121.173])
  by mail3-relais-sop.national.inria.fr with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 29 Aug 2020 15:09:57 +0200
Date:   Sat, 29 Aug 2020 15:09:57 +0200 (CEST)
From:   Julia Lawall <julia.lawall@inria.fr>
X-X-Sender: jll@hadrien
To:     Markus Elfring <Markus.Elfring@web.de>
cc:     Denis Efremov <efremov@linux.com>,
        Coccinelle <cocci@systeme.lip6.fr>,
        Michal Marek <michal.lkml@markovi.net>,
        Kees Cook <keescook@chromium.org>,
        Gilles Muller <Gilles.Muller@lip6.fr>,
        Nicolas Palix <nicolas.palix@imag.fr>,
        kernel-janitors@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [Cocci] [RFC PATCH] coccinelle: api: add flex_array_size.cocci
 script
In-Reply-To: <b131add2-f494-d129-f83f-ef2c6de7a849@web.de>
Message-ID: <alpine.DEB.2.22.394.2008291507400.3629@hadrien>
References: <b131add2-f494-d129-f83f-ef2c6de7a849@web.de>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On Sat, 29 Aug 2020, Markus Elfring wrote:

> > Suggest flex_array_size() wrapper to compute the size of a
> > flexible array member in a structure. The macro additionally
> > checks for integer overflows.
>
> Can the following script variant for the semantic patch language help
> to clarify any software development ideas and remaining open issues?

A patch proposal needs to say what it is doing and why.  You haven't
provided either information.

What changes have you made as compared to the original proposal, and why
have you made them?  Removing newlines and adding spaces, as done in
decl_flex, is not something I am interested in.

julia

>
>
> virtual context, patch, report, org
>
> @decl_flex@
> identifier name, array, size;
> type TA, TS;
> @@
>  struct name {
>  ...
>  TS size;
>  ...
> (TA array[];
> |TA array[ \( 0 \| 1 \) ];
> )
>  };
>
> @ptr_flex@
> identifier decl_flex.name, instance;
> @@
>  struct name *instance;
>
> @struct_flex@
> identifier decl_flex.name, instance;
> @@
>  struct name instance;
>
> @ptr_flex_size depends on !patch@
> identifier decl_flex.array, decl_flex.size, ptr_flex.instance;
> type decl_flex.TA;
> position p;
> @@
> *instance->size *@p \( sizeof(TA) \| sizeof(*instance->array) \)
>
> @depends on patch exists@
> identifier decl_flex.array, decl_flex.size, ptr_flex.instance;
> type decl_flex.TA;
> @@
> (
> -sizeof(TA)
> |
> -sizeof(*instance->array)
> )
> - *
> +flex_array_size(instance, array,
>  instance->size
> +)
>
> @struct_flex_size depends on !patch@
> identifier decl_flex.array, decl_flex.size, struct_flex.instance;
> type decl_flex.TA;
> position p;
> @@
> *instance->size *@p \( sizeof(TA) \| sizeof(*instance->array) \)
>
> @depends on patch exists@
> identifier decl_flex.array, decl_flex.size, struct_flex.instance;
> type decl_flex.TA;
> @@
> (
> -sizeof(TA)
> |
> -sizeof(*instance->array)
> )
> - *
> +flex_array_size(instance, array,
>  instance->size
> +)
>
> @func_arg_flex_size depends on !patch@
> identifier decl_flex.name, decl_flex.array, decl_flex.size, func, instance;
> type decl_flex.TA;
> position p;
> @@
>  func(..., struct name *instance, ...) {
>  ... when any
> *instance->size *@p \( sizeof(TA) \| sizeof(*instance->array) \)
>  ...
>  }
>
> @depends on patch exists@
> identifier decl_flex.name, decl_flex.array, decl_flex.size, func, instance;
> type decl_flex.TA;
> @@
>  func(..., struct name *instance, ...) {
>  ... when any
> (
> -sizeof(TA)
> |
> -sizeof(*instance->array)
> )
> - *
> +flex_array_size(instance, array,
>  instance->size
> +)
>  ...
>  }
>
> @script:python depends on report@
> p << ptr_flex_size.p;
> @@
> coccilib.report.print_report(p[0], "WARNING opportunity for flex_array_size")
>
> @script:python depends on org@
> p << ptr_flex_size.p;
> @@
> coccilib.org.print_todo(p[0], "WARNING opportunity for flex_array_size")
>
> @script:python depends on report@
> p << struct_flex_size.p;
> @@
> coccilib.report.print_report(p[0], "WARNING opportunity for flex_array_size")
>
> @script:python depends on org@
> p << struct_flex_size.p;
> @@
> coccilib.org.print_todo(p[0], "WARNING opportunity for flex_array_size")
>
> @script:python depends on report@
> p << func_arg_flex_size.p;
> @@
> coccilib.report.print_report(p[0], "WARNING opportunity for flex_array_size")
>
> @script:python depends on org@
> p << func_arg_flex_size.p;
> @@
> coccilib.org.print_todo(p[0], "WARNING opportunity for flex_array_size")
>
>
> Regards,
> Markus
> _______________________________________________
> Cocci mailing list
> Cocci@systeme.lip6.fr
> https://systeme.lip6.fr/mailman/listinfo/cocci
>
