Return-Path: <SRS0=qsSF=76=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE984C433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jun 2020 20:08:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B126A207E8
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jun 2020 20:08:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726868AbgFQUIX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Jun 2020 16:08:23 -0400
Received: from mail3-relais-sop.national.inria.fr ([192.134.164.104]:46855
        "EHLO mail3-relais-sop.national.inria.fr" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726597AbgFQUIW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Jun 2020 16:08:22 -0400
X-IronPort-AV: E=Sophos;i="5.73,523,1583190000"; 
   d="scan'208";a="351904042"
Received: from abo-173-121-68.mrs.modulonet.fr (HELO hadrien) ([85.68.121.173])
  by mail3-relais-sop.national.inria.fr with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 17 Jun 2020 22:08:19 +0200
Date:   Wed, 17 Jun 2020 22:08:19 +0200 (CEST)
From:   Julia Lawall <julia.lawall@inria.fr>
X-X-Sender: jll@hadrien
To:     Denis Efremov <efremov@linux.com>
cc:     "Gustavo A. R. Silva" <garsilva@embeddedor.com>,
        Kees Cook <keescook@chromium.org>, cocci@systeme.lip6.fr,
        linux-kernel@vger.kernel.org
Subject: Re: [Cocci] [PATCH] coccinelle: misc: add array_size_dup script to
 detect missed overlow checks
In-Reply-To: <e34b7e26-6f07-19b6-39ad-e3bc939551fc@linux.com>
Message-ID: <alpine.DEB.2.22.394.2006172154040.3083@hadrien>
References: <20200615102045.4558-1-efremov@linux.com> <202006151123.3C2CB7782@keescook> <a28543e5-4f93-bf16-930b-42d7b24ab902@linux.com> <4dd9c371-0c37-a4bb-e957-3848cb1a13ff@embeddedor.com> <e34b7e26-6f07-19b6-39ad-e3bc939551fc@linux.com>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On Wed, 17 Jun 2020, Denis Efremov wrote:

>
> >
> > Awesome! I'll take a look into this. :)
> >
> Here is another script for your #83 ticket.
> Currently, it issues 598 warnings.
>
> // SPDX-License-Identifier: GPL-2.0-only
> ///
> /// Check for missing overflow checks in allocation functions.
> /// Low confidence because it's pointless to check for overflow
> /// relatively small allocations.
> ///
> // Confidence: Low
> // Copyright: (C) 2020 Denis Efremov ISPRAS
> // Options: --no-includes --include-headers
>
> virtual patch
> virtual context
> virtual org
> virtual report
>
> @depends on patch@
> expression E1, E2, E3, E4, size;
> @@
>
> (
> - size = E1 * E2;
> + size = array_size(E1, E2);
> |
> - size = E1 * E2 * E3;
> + size = array3_size(E1, E2, E3);
> |
> - size = E1 * E2 + E3;
> + size = struct_size(E1, E2, E3);

Should the arguments be checked to see if they have something to do with
arrays and structures?

> )
>   ... when != size = E4
>       when != size += E4
>       when != size -= E4
>       when != size *= E4

Here you can have a metavariable

assignment operator aop;

and then say size aop E4

It doesn't really look like an assignment any more, but it could be a
little safer.

julia

>       when != &size
>   \(kmalloc\|krealloc\|kzalloc\|kzalloc_node\|
>     vmalloc\|vzalloc\|vzalloc_node\|
>     kvmalloc\|kvzalloc\|kvzalloc_node\|
>     sock_kmalloc\|
>     f2fs_kmalloc\|f2fs_kzalloc\|f2fs_kvmalloc\|f2fs_kvzalloc\|
>     devm_kmalloc\|devm_kzalloc\)
>   (..., size, ...)
>
> @r depends on !patch@
> expression E1, E2, E3, E4, size;
> position p;
> @@
>
> (
> * size = E1 * E2;@p
> |
> * size = E1 * E2 * E3;@p
> |
> * size = E1 * E2 + E3;@p
> )
>   ... when != size = E4
>       when != size += E4
>       when != size -= E4
>       when != size *= E4
>       when != &size
> * \(kmalloc\|krealloc\|kzalloc\|kzalloc_node\|
>     vmalloc\|vzalloc\|vzalloc_node\|
>     kvmalloc\|kvzalloc\|kvzalloc_node\|
>     sock_kmalloc\|
>     f2fs_kmalloc\|f2fs_kzalloc\|f2fs_kvmalloc\|f2fs_kvzalloc\|
>     devm_kmalloc\|devm_kzalloc\)
>   (..., size, ...)
>
> @script:python depends on report@
> p << r.p;
> @@
>
> coccilib.report.print_report(p[0], "WARNING: missing overflow check")
>
> @script:python depends on org@
> p << r.p;
> @@
>
> coccilib.org.print_todo(p[0], "WARNING: missing overflow check")
> _______________________________________________
> Cocci mailing list
> Cocci@systeme.lip6.fr
> https://systeme.lip6.fr/mailman/listinfo/cocci
>
