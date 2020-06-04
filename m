Return-Path: <SRS0=TsDl=7R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52BFAC433E0
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Jun 2020 20:58:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 39B812077D
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Jun 2020 20:58:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729991AbgFDU6A (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Jun 2020 16:58:00 -0400
Received: from mail3-relais-sop.national.inria.fr ([192.134.164.104]:18801
        "EHLO mail3-relais-sop.national.inria.fr" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729848AbgFDU5r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Jun 2020 16:57:47 -0400
X-IronPort-AV: E=Sophos;i="5.73,472,1583190000"; 
   d="scan'208";a="350629662"
Received: from abo-173-121-68.mrs.modulonet.fr (HELO hadrien) ([85.68.121.173])
  by mail3-relais-sop.national.inria.fr with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 04 Jun 2020 22:57:18 +0200
Date:   Thu, 4 Jun 2020 22:57:18 +0200 (CEST)
From:   Julia Lawall <julia.lawall@inria.fr>
X-X-Sender: jll@hadrien
To:     Denis Efremov <efremov@linux.com>
cc:     Joe Perches <joe@perches.com>, cocci@systeme.lip6.fr,
        linux-kernel@vger.kernel.org
Subject: Re: [Cocci] [PATCH v2] coccinelle: api: add kzfree script
In-Reply-To: <20200604204846.15897-1-efremov@linux.com>
Message-ID: <alpine.DEB.2.21.2006042254240.2577@hadrien>
References: <20200604140805.111613-1-efremov@linux.com> <20200604204846.15897-1-efremov@linux.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On Thu, 4 Jun 2020, Denis Efremov wrote:

> Check for memset()/memset_explicit() with 0 followed by
> kfree()/vfree()/kvfree().
>
> Signed-off-by: Denis Efremov <efremov@linux.com>
> ---
> Changes in v2:
> - memset_explicit() added
> - kvfree_sensitive() added
> - forall added to r1
> - ... between memset and kfree added
>   Unfortunately, it doesn't work as I would expect it to in "patch"
>   mode. I've added my comment about it in the rule. It can be safely
>   removed from the patch if I misunderstood something.
>
> Another "strange" behaviour that I faced that r2 rule works only if I
> write 2 expression lines:
> expression *E;
> expression size;
> If I try to use a single line "expression *E, size;" then r2 matches nothing.

The parser for metavariables is not so smart.  Everything to the left of
the first metavariable name is the type.  Everything after is the list of
metavariables of that type.  So if you put them together you require size
to be a pointer.

On the other hand, do you really require E to be a pointer?  If you do
that, it will have to find the type of E.  If E refers to a structure
field, then the type might not be available in the current function, and
you may need command line argments like --all-includes or
--recursive-includes.  Is avoiding transforming the case where E is not
verified to be a pointer a concern?

julia

>
>  scripts/coccinelle/api/kzfree.cocci | 65 +++++++++++++++++++++++++++++
>  1 file changed, 65 insertions(+)
>  create mode 100644 scripts/coccinelle/api/kzfree.cocci
>
> diff --git a/scripts/coccinelle/api/kzfree.cocci b/scripts/coccinelle/api/kzfree.cocci
> new file mode 100644
> index 000000000000..5c7e4bb13bb7
> --- /dev/null
> +++ b/scripts/coccinelle/api/kzfree.cocci
> @@ -0,0 +1,65 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +///
> +/// Use kzfree, kvfree_sensitive rather than memset or
> +/// memset_explicit with 0 followed by kfree
> +///
> +// Confidence: High
> +// Copyright: (C) 2020 Denis Efremov ISPRAS
> +// Options: --no-includes --include-headers
> +//
> +// Keywords: kzfree, kvfree_sensitive
> +//
> +
> +virtual context
> +virtual patch
> +virtual org
> +virtual report
> +
> +
> +// Ignore kzfree definition
> +// Ignore kasan test
> +@r depends on !patch && !(file in "lib/test_kasan.c") && !(file in "mm/slab_common.c") forall@
> +expression *E;
> +position p;
> +@@
> +
> +* \(memset\|memset_explicit\)(E, 0, ...);
> +  ... when != E
> +      when strict
> +* \(kfree\|vfree\|kvfree\)(E)@p;
> +
> +@r1 depends on patch && !(file in "lib/test_kasan.c") && !(file in "mm/slab_common.c")@
> +expression *E;
> +expression size;
> +@@
> +
> +- \(memset\|memset_explicit\)(E, 0, size);
> +/// Unfortunately, it doesn't work as in !patch mode.
> +/// spatch (v1.0.8) should patch 4 functions in linux 5.7 with this rule
> +/// and uncommented "when" lines. With only "... when != E" line 2 functions
> +/// are patched, none with "when strict". 3 functions patch is produced by the
> +/// rule with "when" lines commented out.
> +//  ... when != E
> +//      when strict
> +(
> +- kfree(E);
> ++ kzfree(E);
> +|
> +- vfree(E);
> ++ kvfree_sensitive(E, size);
> +|
> +- kvfree(E);
> ++ kvfree_sensitive(E, size);
> +)
> +
> +@script:python depends on report@
> +p << r.p;
> +@@
> +
> +coccilib.report.print_report(p[0], "WARNING opportunity for kzfree/kvfree_sensitive")
> +
> +@script:python depends on org@
> +p << r.p;
> +@@
> +
> +coccilib.org.print_todo(p[0], "WARNING opportunity for kzfree/kvfree_sensitive")
> --
> 2.26.2
>
> _______________________________________________
> Cocci mailing list
> Cocci@systeme.lip6.fr
> https://systeme.lip6.fr/mailman/listinfo/cocci
>
