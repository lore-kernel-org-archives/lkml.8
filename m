Return-Path: <SRS0=w5GM=A4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81922C433E2
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jul 2020 20:56:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 662EE2076A
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jul 2020 20:56:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726818AbgGQU4H (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Jul 2020 16:56:07 -0400
Received: from mail3-relais-sop.national.inria.fr ([192.134.164.104]:50613
        "EHLO mail3-relais-sop.national.inria.fr" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726393AbgGQU4G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jul 2020 16:56:06 -0400
X-IronPort-AV: E=Sophos;i="5.75,364,1589234400"; 
   d="scan'208";a="354705512"
Received: from abo-173-121-68.mrs.modulonet.fr (HELO hadrien) ([85.68.121.173])
  by mail3-relais-sop.national.inria.fr with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 17 Jul 2020 22:56:05 +0200
Date:   Fri, 17 Jul 2020 22:56:05 +0200 (CEST)
From:   Julia Lawall <julia.lawall@inria.fr>
X-X-Sender: jll@hadrien
To:     Denis Efremov <efremov@linux.com>
cc:     linux-kernel@vger.kernel.org, cocci@systeme.lip6.fr
Subject: Re: [Cocci] [PATCH v2 1/4] coccinelle: api: extend memdup_user
 transformation with GFP_USER
In-Reply-To: <20200608150038.223747-2-efremov@linux.com>
Message-ID: <alpine.DEB.2.22.394.2007172255560.2837@hadrien>
References: <20200608150038.223747-1-efremov@linux.com> <20200608150038.223747-2-efremov@linux.com>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On Mon, 8 Jun 2020, Denis Efremov wrote:

> Match GFP_USER and optional __GFP_NOWARN allocations with
> memdup_user.cocci rule.
> Commit 6c2c97a24f09 ("memdup_user(): switch to GFP_USER") switched
> memdup_user() from GFP_KERNEL to GFP_USER. In almost all cases it
> is still a good idea to recommend memdup_user() for GFP_KERNEL
> allocations. The motivation behind altering memdup_user() to GFP_USER:
> https://lkml.org/lkml/2018/1/6/333
>
> Signed-off-by: Denis Efremov <efremov@linux.com>

Applied.

> ---
>  scripts/coccinelle/api/memdup_user.cocci | 8 ++++++--
>  1 file changed, 6 insertions(+), 2 deletions(-)
>
> diff --git a/scripts/coccinelle/api/memdup_user.cocci b/scripts/coccinelle/api/memdup_user.cocci
> index c809ab10bbce..cadcc2e87881 100644
> --- a/scripts/coccinelle/api/memdup_user.cocci
> +++ b/scripts/coccinelle/api/memdup_user.cocci
> @@ -20,7 +20,9 @@ expression from,to,size;
>  identifier l1,l2;
>  @@
>
> --  to = \(kmalloc\|kzalloc\)(size,GFP_KERNEL);
> +-  to = \(kmalloc\|kzalloc\)
> +		(size,\(GFP_KERNEL\|GFP_USER\|
> +		      \(GFP_KERNEL\|GFP_USER\)|__GFP_NOWARN\));
>  +  to = memdup_user(from,size);
>     if (
>  -      to==NULL
> @@ -43,7 +45,9 @@ position p;
>  statement S1,S2;
>  @@
>
> -*  to = \(kmalloc@p\|kzalloc@p\)(size,GFP_KERNEL);
> +*  to = \(kmalloc@p\|kzalloc@p\)
> +		(size,\(GFP_KERNEL\|GFP_USER\|
> +		      \(GFP_KERNEL\|GFP_USER\)|__GFP_NOWARN\));
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
