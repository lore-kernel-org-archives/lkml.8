Return-Path: <SRS0=dnKw=BT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52A79C433E0
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Aug 2020 11:25:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 31ADA206A2
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Aug 2020 11:25:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726291AbgHILZv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 9 Aug 2020 07:25:51 -0400
Received: from mail3-relais-sop.national.inria.fr ([192.134.164.104]:50937
        "EHLO mail3-relais-sop.national.inria.fr" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726009AbgHILZi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Aug 2020 07:25:38 -0400
X-IronPort-AV: E=Sophos;i="5.75,453,1589234400"; 
   d="scan'208";a="356217592"
Received: from abo-173-121-68.mrs.modulonet.fr (HELO hadrien) ([85.68.121.173])
  by mail3-relais-sop.national.inria.fr with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 09 Aug 2020 13:25:35 +0200
Date:   Sun, 9 Aug 2020 13:25:34 +0200 (CEST)
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
Subject: Re: [PATCH] Coccinelle: Reduce duplicate code for patch rules of
 memdup_user.cocci
In-Reply-To: <b5c83a17-e04f-2d10-9506-12c50b3de9b9@web.de>
Message-ID: <alpine.DEB.2.22.394.2008091324530.2450@hadrien>
References: <1ae3eefe-fa5a-a497-f00b-5638f4191e90@web.de> <b5c83a17-e04f-2d10-9506-12c50b3de9b9@web.de>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On Sun, 9 Aug 2020, Markus Elfring wrote:

> From: Markus Elfring <elfring@users.sourceforge.net>
> Date: Sun, 9 Aug 2020 11:11:20 +0200
>
> Another patch rule was added. A bit of code was copied from a previous
> SmPL rule for this change specification.
>
> * Thus reduce duplicate code by using another SmPL disjunction.

I don't care about this issue.

>
> * Increase the precision a bit for desired source code adjustments.

This gives no information.  If you explain the improvement in an
understandable way, I will consider whether it is useful to take the
patch.

julia

> Fixes: 9c568dbd677bcfc975220d3157c89c48669a23e3 ("coccinelle: api: extend memdup_user rule with vmemdup_user()")
> Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
> ---
>  scripts/coccinelle/api/memdup_user.cocci | 44 +++++++++---------------
>  1 file changed, 16 insertions(+), 28 deletions(-)
>
> diff --git a/scripts/coccinelle/api/memdup_user.cocci b/scripts/coccinelle/api/memdup_user.cocci
> index e01e95108405..7cf698b4e925 100644
> --- a/scripts/coccinelle/api/memdup_user.cocci
> +++ b/scripts/coccinelle/api/memdup_user.cocci
> @@ -27,34 +27,22 @@ expression from,to,size;
>  identifier l1,l2;
>  position p : script:python() { relevant(p) };
>  @@
> -
> --  to = \(kmalloc@p\|kzalloc@p\)
> --		(size,\(GFP_KERNEL\|GFP_USER\|
> --		      \(GFP_KERNEL\|GFP_USER\)|__GFP_NOWARN\));
> -+  to = memdup_user(from,size);
> -   if (
> --      to==NULL
> -+      IS_ERR(to)
> -                 || ...) {
> -   <+... when != goto l1;
> --  -ENOMEM
> -+  PTR_ERR(to)
> -   ...+>
> -   }
> --  if (copy_from_user(to, from, size) != 0) {
> --    <+... when != goto l2;
> --    -EFAULT
> --    ...+>
> --  }
> -
> -@depends on patch@
> -expression from,to,size;
> -identifier l1,l2;
> -position p : script:python() { relevant(p) };
> -@@
> -
> --  to = \(kvmalloc@p\|kvzalloc@p\)(size,\(GFP_KERNEL\|GFP_USER\));
> -+  to = vmemdup_user(from,size);
> + to =
> +(
> +-     \(kmalloc@p\|kzalloc@p\)
> ++     memdup_user
> +      (
> +-      size, \( \(GFP_KERNEL\|GFP_USER\) \| \(GFP_KERNEL\|GFP_USER\)|__GFP_NOWARN \)
> ++      from, size
> +      )
> +|
> +-     \(kvmalloc@p\|kvzalloc@p\)
> ++     vmemdup_user
> +      (
> +-      size, \(GFP_KERNEL\|GFP_USER\)
> ++      from, size
> +      )
> +);
>     if (
>  -      to==NULL
>  +      IS_ERR(to)
> --
> 2.28.0
>
>
