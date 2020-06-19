Return-Path: <SRS0=bWCJ=AA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0FD08C433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jun 2020 19:33:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E91752158C
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jun 2020 19:33:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389348AbgFSTdB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Jun 2020 15:33:01 -0400
Received: from mail2-relais-roc.national.inria.fr ([192.134.164.83]:41533 "EHLO
        mail2-relais-roc.national.inria.fr" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2389320AbgFSTdB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Jun 2020 15:33:01 -0400
X-IronPort-AV: E=Sophos;i="5.75,256,1589234400"; 
   d="scan'208";a="455700223"
Received: from abo-173-121-68.mrs.modulonet.fr (HELO hadrien) ([85.68.121.173])
  by mail2-relais-roc.national.inria.fr with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 19 Jun 2020 21:32:59 +0200
Date:   Fri, 19 Jun 2020 21:32:58 +0200 (CEST)
From:   Julia Lawall <julia.lawall@inria.fr>
X-X-Sender: jll@hadrien
To:     Denis Efremov <efremov@linux.com>
cc:     cocci@systeme.lip6.fr, linux-kernel@vger.kernel.org
Subject: Re: [Cocci] [PATCH] coccinelle: api/kstrdup: fix coccinelle
 position
In-Reply-To: <20200619132307.16612-1-efremov@linux.com>
Message-ID: <alpine.DEB.2.22.394.2006192132410.2456@hadrien>
References: <20200619132307.16612-1-efremov@linux.com>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On Fri, 19 Jun 2020, Denis Efremov wrote:

> There is a typo in rule r2. Position p1 should be attached to kzalloc()
> call.

Clearly.  Thanks.  Applied.

julia


>
> Fixes: 29a36d4dec6c ("scripts/coccinelle: improve the coverage of some semantic patches")
> Signed-off-by: Denis Efremov <efremov@linux.com>
> ---
>  scripts/coccinelle/api/kstrdup.cocci | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/scripts/coccinelle/api/kstrdup.cocci b/scripts/coccinelle/api/kstrdup.cocci
> index 19f2645e6076..3c6dc5469ee4 100644
> --- a/scripts/coccinelle/api/kstrdup.cocci
> +++ b/scripts/coccinelle/api/kstrdup.cocci
> @@ -66,7 +66,7 @@ position p1,p2;
>
>  *   x = strlen(from) + 1;
>      ... when != \( x = E1 \| from = E1 \)
> -*   to = \(kmalloc@p1\|kzalloc@p2\)(x,flag);
> +*   to = \(kmalloc@p1\|kzalloc@p1\)(x,flag);
>      ... when != \(x = E2 \| from = E2 \| to = E2 \)
>      if (to==NULL || ...) S
>      ... when != \(x = E3 \| from = E3 \| to = E3 \)
> --
> 2.26.2
>
> _______________________________________________
> Cocci mailing list
> Cocci@systeme.lip6.fr
> https://systeme.lip6.fr/mailman/listinfo/cocci
>
