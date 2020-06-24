Return-Path: <SRS0=sD2I=AF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5CF45C433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jun 2020 19:42:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3AFE62077D
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jun 2020 19:42:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406182AbgFXTmj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Jun 2020 15:42:39 -0400
Received: from mail3-relais-sop.national.inria.fr ([192.134.164.104]:28390
        "EHLO mail3-relais-sop.national.inria.fr" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2404915AbgFXTmi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Jun 2020 15:42:38 -0400
X-IronPort-AV: E=Sophos;i="5.75,276,1589234400"; 
   d="scan'208";a="352641912"
Received: from abo-173-121-68.mrs.modulonet.fr (HELO hadrien) ([85.68.121.173])
  by mail3-relais-sop.national.inria.fr with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 24 Jun 2020 21:42:34 +0200
Date:   Wed, 24 Jun 2020 21:42:34 +0200 (CEST)
From:   Julia Lawall <julia.lawall@inria.fr>
X-X-Sender: jll@hadrien
To:     Denis Efremov <efremov@linux.com>
cc:     cocci@systeme.lip6.fr, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4] coccinelle: misc: add array_size_dup script to detect
 missed overflow checks
In-Reply-To: <20200622221056.34241-1-efremov@linux.com>
Message-ID: <alpine.DEB.2.22.394.2006242142240.2433@hadrien>
References: <20200615102045.4558-1-efremov@linux.com> <20200622221056.34241-1-efremov@linux.com>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On Tue, 23 Jun 2020, Denis Efremov wrote:

> Detect an opencoded expression that is used before or after
> array_size()/array3_size()/struct_size() to compute the same size.
>
> Signed-off-by: Denis Efremov <efremov@linux.com>

Applied, thanks.

julia

> ---
> Changes in v2:
>  - python rules moved next to SmPL patterns
>  - assignment operator used
>  - struct_size patterns fixed to check only E3, since
>    E1, E2 are sizeofs of a structure and a member
>    of a structure
> Changes in v3:
>  - s/overlow/overflow/ typo fixed (thanks, Markus)
>  - \(&E1\|&E2\) changed to &\(E1\|E2\)
>  - print strings breaks removed
> Changes in v4:
>  - duplicates warning removed
>  - python2 compatability in report&&org modes added
>  - s/down the code/later/ warning changed
>  - \(E1\|E2\|subE1\|subE2\) patterns simplified to \(subE1\|subE2\)
>
>  scripts/coccinelle/misc/array_size_dup.cocci | 209 +++++++++++++++++++
>  1 file changed, 209 insertions(+)
>  create mode 100644 scripts/coccinelle/misc/array_size_dup.cocci
>
> diff --git a/scripts/coccinelle/misc/array_size_dup.cocci b/scripts/coccinelle/misc/array_size_dup.cocci
> new file mode 100644
> index 000000000000..d3d635b2d4fc
> --- /dev/null
> +++ b/scripts/coccinelle/misc/array_size_dup.cocci
> @@ -0,0 +1,209 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +///
> +/// Check for array_size(), array3_size(), struct_size() duplicates.
> +/// Three types of patterns for these functions:
> +///  1. An opencoded expression is used before array_size() to compute the same size
> +///  2. An opencoded expression is used after array_size() to compute the same size
> +/// From security point of view only first case is relevant. These functions
> +/// perform arithmetic overflow check. Thus, if we use an opencoded expression
> +/// before a call to the *_size() function we can miss an overflow.
> +///
> +// Confidence: High
> +// Copyright: (C) 2020 Denis Efremov ISPRAS
> +// Options: --no-includes --include-headers --no-loops
> +
> +virtual context
> +virtual report
> +virtual org
> +
> +@as@
> +expression E1, E2;
> +@@
> +
> +array_size(E1, E2)
> +
> +@as_next@
> +expression subE1 <= as.E1;
> +expression subE2 <= as.E2;
> +expression as.E1, as.E2, E3;
> +assignment operator aop;
> +position p1, p2;
> +@@
> +
> +* E1 * E2@p1
> +  ... when != \(subE1\|subE2\) aop E3
> +      when != &\(subE1\|subE2\)
> +* array_size(E1, E2)@p2
> +
> +@script:python depends on report@
> +p1 << as_next.p1;
> +p2 << as_next.p2;
> +@@
> +
> +msg = "WARNING: array_size is used later (line %s) to compute the same size" % (p2[0].line)
> +coccilib.report.print_report(p1[0], msg)
> +
> +@script:python depends on org@
> +p1 << as_next.p1;
> +p2 << as_next.p2;
> +@@
> +
> +msg = "WARNING: array_size is used later (line %s) to compute the same size" % (p2[0].line)
> +coccilib.org.print_todo(p1[0], msg)
> +
> +@as_prev@
> +expression subE1 <= as.E1;
> +expression subE2 <= as.E2;
> +expression as.E1, as.E2, E3;
> +assignment operator aop;
> +position p1, p2;
> +@@
> +
> +* array_size(E1, E2)@p1
> +  ... when != \(subE1\|subE2\) aop E3
> +      when != &\(subE1\|subE2\)
> +* E1 * E2@p2
> +
> +@script:python depends on report@
> +p1 << as_prev.p1;
> +p2 << as_prev.p2;
> +@@
> +
> +msg = "WARNING: array_size is already used (line %s) to compute the same size" % (p1[0].line)
> +coccilib.report.print_report(p2[0], msg)
> +
> +@script:python depends on org@
> +p1 << as_prev.p1;
> +p2 << as_prev.p2;
> +@@
> +
> +msg = "WARNING: array_size is already used (line %s) to compute the same size" % (p1[0].line)
> +coccilib.org.print_todo(p2[0], msg)
> +
> +@as3@
> +expression E1, E2, E3;
> +@@
> +
> +array3_size(E1, E2, E3)
> +
> +@as3_next@
> +expression subE1 <= as3.E1;
> +expression subE2 <= as3.E2;
> +expression subE3 <= as3.E3;
> +expression as3.E1, as3.E2, as3.E3, E4;
> +assignment operator aop;
> +position p1, p2;
> +@@
> +
> +* E1 * E2 * E3@p1
> +  ... when != \(subE1\|subE2\|subE3\) aop E4
> +      when != &\(subE1\|subE2\|subE3\)
> +* array3_size(E1, E2, E3)@p2
> +
> +@script:python depends on report@
> +p1 << as3_next.p1;
> +p2 << as3_next.p2;
> +@@
> +
> +msg = "WARNING: array3_size is used later (line %s) to compute the same size" % (p2[0].line)
> +coccilib.report.print_report(p1[0], msg)
> +
> +@script:python depends on org@
> +p1 << as3_next.p1;
> +p2 << as3_next.p2;
> +@@
> +
> +msg = "WARNING: array3_size is used later (line %s) to compute the same size" % (p2[0].line)
> +coccilib.org.print_todo(p1[0], msg)
> +
> +@as3_prev@
> +expression subE1 <= as3.E1;
> +expression subE2 <= as3.E2;
> +expression subE3 <= as3.E3;
> +expression as3.E1, as3.E2, as3.E3, E4;
> +assignment operator aop;
> +position p1, p2;
> +@@
> +
> +* array3_size(E1, E2, E3)@p1
> +  ... when != \(subE1\|subE2\|subE3\) aop E4
> +      when != &\(subE1\|subE2\|subE3\)
> +* E1 * E2 * E3@p2
> +
> +@script:python depends on report@
> +p1 << as3_prev.p1;
> +p2 << as3_prev.p2;
> +@@
> +
> +msg = "WARNING: array3_size is already used (line %s) to compute the same size" % (p1[0].line)
> +coccilib.report.print_report(p2[0], msg)
> +
> +@script:python depends on org@
> +p1 << as3_prev.p1;
> +p2 << as3_prev.p2;
> +@@
> +
> +msg = "WARNING: array3_size is already used (line %s) to compute the same size" % (p1[0].line)
> +coccilib.org.print_todo(p2[0], msg)
> +
> +@ss@
> +expression E1, E2, E3;
> +@@
> +
> +struct_size(E1, E2, E3)
> +
> +@ss_next@
> +expression subE3 <= ss.E3;
> +expression ss.E1, ss.E2, ss.E3, E4;
> +assignment operator aop;
> +position p1, p2;
> +@@
> +
> +* E1 * E2 + E3@p1
> +  ... when != subE3 aop E4
> +      when != &subE3
> +* struct_size(E1, E2, E3)@p2
> +
> +@script:python depends on report@
> +p1 << ss_next.p1;
> +p2 << ss_next.p2;
> +@@
> +
> +msg = "WARNING: struct_size is used later (line %s) to compute the same size" % (p2[0].line)
> +coccilib.report.print_report(p1[0], msg)
> +
> +@script:python depends on org@
> +p1 << ss_next.p1;
> +p2 << ss_next.p2;
> +@@
> +
> +msg = "WARNING: struct_size is used later (line %s) to compute the same size" % (p2[0].line)
> +coccilib.org.print_todo(p1[0], msg)
> +
> +@ss_prev@
> +expression subE3 <= ss.E3;
> +expression ss.E1, ss.E2, ss.E3, E4;
> +assignment operator aop;
> +position p1, p2;
> +@@
> +
> +* struct_size(E1, E2, E3)@p1
> +  ... when != subE3 aop E4
> +      when != &subE3
> +* E1 * E2 + E3@p2
> +
> +@script:python depends on report@
> +p1 << ss_prev.p1;
> +p2 << ss_prev.p2;
> +@@
> +
> +msg = "WARNING: struct_size is already used (line %s) to compute the same size" % (p1[0].line)
> +coccilib.report.print_report(p2[0], msg)
> +
> +@script:python depends on org@
> +p1 << ss_prev.p1;
> +p2 << ss_prev.p2;
> +@@
> +
> +msg = "WARNING: struct_size is already used (line %s) to compute the same size" % (p1[0].line)
> +coccilib.org.print_todo(p2[0], msg)
> --
> 2.26.2
>
>
