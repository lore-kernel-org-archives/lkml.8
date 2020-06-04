Return-Path: <SRS0=TsDl=7R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F722C433E0
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Jun 2020 15:51:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2646020738
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Jun 2020 15:51:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729593AbgFDPvq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Jun 2020 11:51:46 -0400
Received: from mail3-relais-sop.national.inria.fr ([192.134.164.104]:37213
        "EHLO mail3-relais-sop.national.inria.fr" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729302AbgFDPvq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Jun 2020 11:51:46 -0400
X-IronPort-AV: E=Sophos;i="5.73,472,1583190000"; 
   d="scan'208";a="350605555"
Received: from abo-173-121-68.mrs.modulonet.fr (HELO hadrien) ([85.68.121.173])
  by mail3-relais-sop.national.inria.fr with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 04 Jun 2020 17:51:20 +0200
Date:   Thu, 4 Jun 2020 17:51:19 +0200 (CEST)
From:   Julia Lawall <julia.lawall@inria.fr>
X-X-Sender: jll@hadrien
To:     Denis Efremov <efremov@linux.com>
cc:     Julia Lawall <julia.lawall@inria.fr>, cocci@systeme.lip6.fr,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] coccinelle: api: add kzfree script
In-Reply-To: <a188acce-348b-b106-9180-708c3050ef8d@linux.com>
Message-ID: <alpine.DEB.2.21.2006041749520.2577@hadrien>
References: <20200604140805.111613-1-efremov@linux.com> <alpine.DEB.2.21.2006041614300.2577@hadrien> <a188acce-348b-b106-9180-708c3050ef8d@linux.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On Thu, 4 Jun 2020, Denis Efremov wrote:

>
>
> On 6/4/20 5:15 PM, Julia Lawall wrote:
> > Did you try ... here but find that some subexpressions of E could be
> > modified in between?
>
> Yes, I tried to use "... when != E = E1 when != &E" and results were bad.
> Now, I've tried forall and when strict. Here are examples:
>
> // forall added
> // Works well, suitable for v2. One additional catch in w1 driver.
> @r depends on !patch && !(file in "lib/test_kasan.c") && !(file in "mm/slab_common.c") forall@
> expression *E; // pointer. Results are equal as if we use E.
> position p;
> @@
>
> * memset(E, 0, ...);
>   ... when != E // Is it enough to match &E, E = E1?

Yes.

> * kfree(E)@p;
>
> //no forall, when strict
> //results are bad, too many false positives
> @r depends on !patch && !(file in "lib/test_kasan.c") && !(file in "mm/slab_common.c")@
> expression *E;
> position p;
> @@
>
> * memset(E, 0, ...);
>   ... when != E // E is not enough here
>       when strict

OK, it's reassonable.

> * kfree(E)@p;
>
> I guess that the difference is that "forall" requires that whole pattern should occur on
> every path, "when strict" states that kfree should be called on every path after memset.
> This results in missed uses of E in loops and under conditions. How can I state in this
> case that E should not occur at all (in all paths) in between memset, kfree even as a
> subexpression?
>
> // Doesn't work well
>   ... when != E
>       when != if (...) { ... E ... }
>       when != for(...;...;...) { ... E ... }

Could you send an example of some C code on which the result is not
suitable?

julia
