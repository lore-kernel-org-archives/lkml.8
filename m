Return-Path: <SRS0=728o=CL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE74BC433E6
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Sep 2020 07:24:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8FD4D20826
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Sep 2020 07:24:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727041AbgIBHYE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 2 Sep 2020 03:24:04 -0400
Received: from mail2-relais-roc.national.inria.fr ([192.134.164.83]:16036 "EHLO
        mail2-relais-roc.national.inria.fr" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726130AbgIBHYD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Sep 2020 03:24:03 -0400
X-IronPort-AV: E=Sophos;i="5.76,359,1592863200"; 
   d="scan'208";a="465666314"
Received: from abo-173-121-68.mrs.modulonet.fr (HELO hadrien) ([85.68.121.173])
  by mail2-relais-roc.national.inria.fr with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 02 Sep 2020 09:24:00 +0200
Date:   Wed, 2 Sep 2020 09:24:00 +0200 (CEST)
From:   Julia Lawall <julia.lawall@inria.fr>
X-X-Sender: jll@hadrien
To:     Markus Elfring <Markus.Elfring@web.de>
cc:     Denis Efremov <efremov@linux.com>,
        Coccinelle <cocci@systeme.lip6.fr>, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org,
        Gilles Muller <Gilles.Muller@lip6.fr>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Julia Lawall <julia.lawall@inria.fr>,
        Kees Cook <keescook@chromium.org>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Michal Marek <michal.lkml@markovi.net>,
        Nicolas Palix <nicolas.palix@imag.fr>
Subject: Re: [PATCH] coccinelle: ifnullfree: add vfree(), kvfree*()
 functions
In-Reply-To: <99e82f65-e02e-988a-4e78-4d438ff8e28e@web.de>
Message-ID: <alpine.DEB.2.22.394.2009020921500.2528@hadrien>
References: <99e82f65-e02e-988a-4e78-4d438ff8e28e@web.de>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-1962328576-1599031440=:2528"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-1962328576-1599031440=:2528
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT



On Wed, 2 Sep 2020, Markus Elfring wrote:

> …
> > +++ b/scripts/coccinelle/free/ifnullfree.cocci
> > @@ -20,8 +20,14 @@ expression E;
> >  - if (E != NULL)
> >  (
> >    kfree(E);
> > +|
> > +  kvfree(E);
> >  |
> >    kfree_sensitive(E);
> > +|
> > +  kvfree_sensitive(E, ...);
> > +|
> > +  vfree(E);
> >  |
> >    debugfs_remove(E);
> >  |
>
> Would you ever get into the development mood to move the source code search
> specification “(E);” out of the SmPL disjunction (as it happened for the rule “r”)?
>
>
> > @@ -42,9 +48,10 @@ position p;
> >  @@
> >
> >  * if (E != NULL)
> > -*	\(kfree@p\|kfree_sensitive@p\|debugfs_remove@p\|debugfs_remove_recursive@p\|
> > +*	\(kfree@p\|kvfree@p\|kfree_sensitive@p\|kvfree_sensitive@p\|vfree@p\|
> > +*         debugfs_remove@p\|debugfs_remove_recursive@p\|
> >  *         usb_free_urb@p\|kmem_cache_destroy@p\|mempool_destroy@p\|
> > -*         dma_pool_destroy@p\)(E);
> > +*         dma_pool_destroy@p\)(E, ...);
> …
>
> How do you think about to attach the position variable to the opening parenthesis
> instead of each function name?
>
> +*         dma_pool_destroy\)(@p E, ...);

While it probably impacts few people, this is a really bad idea for org
mode, because org mode colors the thing that the position variable is
attached to.  Having the ( colored would not be very visible.

But even for report mode, this is probably not a good idea for the rare
case where the function name and the argument list are on different lines.

julia

>
>
> Would the number of function call parameters influence such SmPL code any more?
>
> Regards,
> Markus
>
--8323329-1962328576-1599031440=:2528--
