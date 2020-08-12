Return-Path: <SRS0=ZArZ=BW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20303C433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Aug 2020 09:27:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 05ECB208A9
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Aug 2020 09:27:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727941AbgHLJ1r (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Aug 2020 05:27:47 -0400
Received: from mail3-relais-sop.national.inria.fr ([192.134.164.104]:9533 "EHLO
        mail3-relais-sop.national.inria.fr" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726601AbgHLJ1r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Aug 2020 05:27:47 -0400
X-IronPort-AV: E=Sophos;i="5.76,303,1592863200"; 
   d="scan'208";a="356403421"
Received: from abo-173-121-68.mrs.modulonet.fr (HELO hadrien) ([85.68.121.173])
  by mail3-relais-sop.national.inria.fr with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 12 Aug 2020 11:27:45 +0200
Date:   Wed, 12 Aug 2020 11:27:45 +0200 (CEST)
From:   Julia Lawall <julia.lawall@inria.fr>
X-X-Sender: jll@hadrien
To:     Markus Elfring <Markus.Elfring@web.de>
cc:     Denis Efremov <efremov@linux.com>,
        Coccinelle <cocci@systeme.lip6.fr>,
        Gilles Muller <Gilles.Muller@lip6.fr>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Michal Marek <michal.lkml@markovi.net>,
        Nicolas Palix <nicolas.palix@imag.fr>,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Kees Cook <keescook@chromium.org>
Subject: Re: [RFC PATCH] coccinelle: misc: add uninitialized_var.cocci
 script
In-Reply-To: <1b8537dd-8bf3-d3b6-4c10-af2fa623f1fe@web.de>
Message-ID: <alpine.DEB.2.22.394.2008121127120.2572@hadrien>
References: <1b8537dd-8bf3-d3b6-4c10-af2fa623f1fe@web.de>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On Wed, 12 Aug 2020, Markus Elfring wrote:

> > +@r@
> > +identifier var;
> > +type T;
> > +position p;
> > +@@
> > +
> > +(
> > +* T var@p = var;
> > +|
> > +* T var@p = *(&(var));
>
> I suggest to simplify such code for the semantic patch language a bit.
> Can an other variant be more succinct for the application of a SmPL disjunction?
>
> +*T var@p = \( var \| *(&(var)) \);

It's fine as is.

julia
