Return-Path: <SRS0=Oudi=B7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 891CAC433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Aug 2020 15:37:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 634A12063A
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Aug 2020 15:37:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728123AbgHUPhx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Aug 2020 11:37:53 -0400
Received: from mail2-relais-roc.national.inria.fr ([192.134.164.83]:18487 "EHLO
        mail2-relais-roc.national.inria.fr" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728020AbgHUPht (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Aug 2020 11:37:49 -0400
X-IronPort-AV: E=Sophos;i="5.76,337,1592863200"; 
   d="scan'208";a="464247096"
Received: from abo-173-121-68.mrs.modulonet.fr (HELO hadrien) ([85.68.121.173])
  by mail2-relais-roc.national.inria.fr with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 21 Aug 2020 17:37:20 +0200
Date:   Fri, 21 Aug 2020 17:37:20 +0200 (CEST)
From:   Julia Lawall <julia.lawall@inria.fr>
X-X-Sender: jll@hadrien
To:     Alex Dewar <alex.dewar90@gmail.com>
cc:     Gilles Muller <Gilles.Muller@lip6.fr>,
        Nicolas Palix <nicolas.palix@imag.fr>,
        Michal Marek <michal.lkml@markovi.net>,
        Luis Chamberlain <mcgrof@kernel.org>, cocci@systeme.lip6.fr,
        linux-kernel@vger.kernel.org
Subject: Re: [Cocci] [PATCH] coccinelle: add patch rule for
 dma_alloc_coherent
In-Reply-To: <20200820235600.326346-1-alex.dewar90@gmail.com>
Message-ID: <alpine.DEB.2.22.394.2008211737070.2486@hadrien>
References: <20200820235600.326346-1-alex.dewar90@gmail.com>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On Fri, 21 Aug 2020, Alex Dewar wrote:

> Commit dfd32cad146e ("dma-mapping: remove dma_zalloc_coherent()")
> removed the definition of dma_zalloc_coherent() and also removed the
> corresponding patch rule for replacing instances of dma_alloc_coherent +
> memset in zalloc-simple.cocci (though left the report rule).
>
> Add a new patch rule to remove unnecessary calls to memset after
> allocating with dma_alloc_coherent. While we're at it, fix a couple of
> typos.

Applied, thanks!

julia

>
> Fixes: dfd32cad146e ("dma-mapping: remove dma_zalloc_coherent()")
> Signed-off-by: Alex Dewar <alex.dewar90@gmail.com>
> ---
>  scripts/coccinelle/api/alloc/zalloc-simple.cocci | 16 +++++++++++++---
>  1 file changed, 13 insertions(+), 3 deletions(-)
>
> diff --git a/scripts/coccinelle/api/alloc/zalloc-simple.cocci b/scripts/coccinelle/api/alloc/zalloc-simple.cocci
> index 26cda3f48f01..b3d0c3c230c1 100644
> --- a/scripts/coccinelle/api/alloc/zalloc-simple.cocci
> +++ b/scripts/coccinelle/api/alloc/zalloc-simple.cocci
> @@ -127,6 +127,16 @@ statement S;
>    if ((x==NULL) || ...) S
>  - memset((T2)x,0,E1);
>
> +@depends on patch@
> +type T, T2;
> +expression x;
> +expression E1,E2,E3,E4;
> +statement S;
> +@@
> +  x = (T)dma_alloc_coherent(E1, E2, E3, E4);
> +  if ((x==NULL) || ...) S
> +- memset((T2)x, 0, E2);
> +
>  //----------------------------------------------------------
>  //  For org mode
>  //----------------------------------------------------------
> @@ -199,9 +209,9 @@ statement S;
>  position p;
>  @@
>
> - x = (T)dma_alloc_coherent@p(E2,E1,E3,E4);
> + x = (T)dma_alloc_coherent@p(E1,E2,E3,E4);
>   if ((x==NULL) || ...) S
> - memset((T2)x,0,E1);
> + memset((T2)x,0,E2);
>
>  @script:python depends on org@
>  p << r2.p;
> @@ -217,7 +227,7 @@ p << r2.p;
>  x << r2.x;
>  @@
>
> -msg="WARNING: dma_alloc_coherent use in %s already zeroes out memory,  so memset is not needed" % (x)
> +msg="WARNING: dma_alloc_coherent used in %s already zeroes out memory, so memset is not needed" % (x)
>  coccilib.report.print_report(p[0], msg)
>
>  //-----------------------------------------------------------------
> --
> 2.28.0
>
> _______________________________________________
> Cocci mailing list
> Cocci@systeme.lip6.fr
> https://systeme.lip6.fr/mailman/listinfo/cocci
>
