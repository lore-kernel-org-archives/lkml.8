Return-Path: <SRS0=QAx1=7P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D178C433DF
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jun 2020 13:24:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7CE94206E2
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jun 2020 13:24:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726922AbgFBNYh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Jun 2020 09:24:37 -0400
Received: from mail2-relais-roc.national.inria.fr ([192.134.164.83]:34921 "EHLO
        mail2-relais-roc.national.inria.fr" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726130AbgFBNYh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Jun 2020 09:24:37 -0400
X-IronPort-AV: E=Sophos;i="5.73,464,1583190000"; 
   d="scan'208";a="452548787"
Received: from abo-173-121-68.mrs.modulonet.fr (HELO hadrien) ([85.68.121.173])
  by mail2-relais-roc.national.inria.fr with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 02 Jun 2020 15:24:35 +0200
Date:   Tue, 2 Jun 2020 15:24:35 +0200 (CEST)
From:   Julia Lawall <julia.lawall@inria.fr>
X-X-Sender: jll@hadrien
To:     Denis Efremov <efremov@linux.com>
cc:     Joe Perches <joe@perches.com>, linux-kernel@vger.kernel.org
Subject: Re: [Cocci] [PATCH 1/2] Coccinelle: extend memdup_user transformation
 with GFP_USER
In-Reply-To: <20200530205348.5812-2-efremov@linux.com>
Message-ID: <alpine.DEB.2.21.2006021523420.4634@hadrien>
References: <20200530205348.5812-1-efremov@linux.com> <20200530205348.5812-2-efremov@linux.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On Sat, 30 May 2020, Denis Efremov wrote:

> Match GFP_USER allocations with memdup_user.cocci rule.
> Commit 6c2c97a24f09 ("memdup_user(): switch to GFP_USER") switched
> memdup_user() from GFP_KERNEL to GFP_USER. In most cases it is still
> a good idea to use memdup_user() for GFP_KERNEL allocations. The
> motivation behind altering memdup_user() to GFP_USER is here:
> https://lkml.org/lkml/2018/1/6/333

Thanks for the patch series.  I will test them and try to push them to
Linus shortly.

julia


>
> Signed-off-by: Denis Efremov <efremov@linux.com>
> ---
>  scripts/coccinelle/api/memdup_user.cocci | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/scripts/coccinelle/api/memdup_user.cocci b/scripts/coccinelle/api/memdup_user.cocci
> index c809ab10bbce..49f487e6a5c8 100644
> --- a/scripts/coccinelle/api/memdup_user.cocci
> +++ b/scripts/coccinelle/api/memdup_user.cocci
> @@ -20,7 +20,7 @@ expression from,to,size;
>  identifier l1,l2;
>  @@
>
> --  to = \(kmalloc\|kzalloc\)(size,GFP_KERNEL);
> +-  to = \(kmalloc\|kzalloc\)(size,\(GFP_KERNEL\|GFP_USER\));
>  +  to = memdup_user(from,size);
>     if (
>  -      to==NULL
> @@ -43,7 +43,7 @@ position p;
>  statement S1,S2;
>  @@
>
> -*  to = \(kmalloc@p\|kzalloc@p\)(size,GFP_KERNEL);
> +*  to = \(kmalloc@p\|kzalloc@p\)(size,\(GFP_KERNEL\|GFP_USER\));
>     if (to==NULL || ...) S1
>     if (copy_from_user(to, from, size) != 0)
>     S2
> --
> 2.26.2
>
> _______________________________________________
> Cocci mailing list
> Cocci@systeme.lip6.fr
> https://systeme.lip6.fr/mailman/listinfo/cocci
>
