Return-Path: <SRS0=qsSF=76=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F17D7C433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jun 2020 20:30:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CBDD020853
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jun 2020 20:30:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726940AbgFQUas (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Jun 2020 16:30:48 -0400
Received: from mail2-relais-roc.national.inria.fr ([192.134.164.83]:29316 "EHLO
        mail2-relais-roc.national.inria.fr" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726496AbgFQUas (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Jun 2020 16:30:48 -0400
X-IronPort-AV: E=Sophos;i="5.73,523,1583190000"; 
   d="scan'208";a="455255405"
Received: from abo-173-121-68.mrs.modulonet.fr (HELO hadrien) ([85.68.121.173])
  by mail2-relais-roc.national.inria.fr with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 17 Jun 2020 22:30:43 +0200
Date:   Wed, 17 Jun 2020 22:30:43 +0200 (CEST)
From:   Julia Lawall <julia.lawall@inria.fr>
X-X-Sender: jll@hadrien
To:     Denis Efremov <efremov@linux.com>
cc:     Kees Cook <keescook@chromium.org>, cocci@systeme.lip6.fr,
        linux-kernel@vger.kernel.org
Subject: Re: [Cocci] [PATCH] coccinelle: misc: add array_size_dup script to
 detect missed overlow checks
In-Reply-To: <20200615102045.4558-1-efremov@linux.com>
Message-ID: <alpine.DEB.2.22.394.2006172229550.3083@hadrien>
References: <20200615102045.4558-1-efremov@linux.com>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On Mon, 15 Jun 2020, Denis Efremov wrote:

> Detect an opencoded expression that is used before or after
> array_size()/array3_size()/struct_size() to compute the same size.

This would benefit from the assignemnt operator metavariables as well.

Also, it could be better to put the python rules up next the SmPL pattern
matching rules that they are associated with.

julia


>
> Cc: Kees Cook <keescook@chromium.org>
> Signed-off-by: Denis Efremov <efremov@linux.com>
> ---
>  scripts/coccinelle/misc/array_size_dup.cocci | 347 +++++++++++++++++++
>  1 file changed, 347 insertions(+)
>  create mode 100644 scripts/coccinelle/misc/array_size_dup.cocci
>
> diff --git a/scripts/coccinelle/misc/array_size_dup.cocci b/scripts/coccinelle/misc/array_size_dup.cocci
> new file mode 100644
> index 000000000000..08919a938754
> --- /dev/null
> +++ b/scripts/coccinelle/misc/array_size_dup.cocci
> @@ -0,0 +1,347 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +///
> +/// Check for array_size(), array3_size(), struct_size() duplicates.
> +/// Three types of patterns for these functions:
> +///  1. An opencoded expression is used before array_size() to compute the same size
> +///  2. An opencoded expression is used after array_size() to compute the same size
> +///  3. Consecutive calls of array_size() with the same values
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
> +expression as.E1;
> +expression subE2 <= as.E2;
> +expression as.E2;
> +expression E3;
> +position p1, p2;
> +@@
> +
> +* E1 * E2@p1
> +  ... when != \(E1\|E2\|subE1\|subE2\)=E3
> +      when != \(E1\|E2\|subE1\|subE2\)+=E3
> +      when != \(E1\|E2\|subE1\|subE2\)-=E3
> +      when != \(E1\|E2\|subE1\|subE2\)*=E3
> +      when != \(&E1\|&E2\|&subE1\|&subE2\)
> +* array_size(E1, E2)@p2
> +
> +@as_prev@
> +expression subE1 <= as.E1;
> +expression as.E1;
> +expression subE2 <= as.E2;
> +expression as.E2;
> +expression E3;
> +position p1, p2;
> +@@
> +
> +* array_size(E1, E2)@p1
> +  ... when != \(E1\|E2\|subE1\|subE2\)=E3
> +      when != \(E1\|E2\|subE1\|subE2\)+=E3
> +      when != \(E1\|E2\|subE1\|subE2\)-=E3
> +      when != \(E1\|E2\|subE1\|subE2\)*=E3
> +      when != \(&E1\|&E2\|&subE1\|&subE2\)
> +* E1 * E2@p2
> +
> +@as_dup@
> +expression subE1 <= as.E1;
> +expression as.E1;
> +expression subE2 <= as.E2;
> +expression as.E2;
> +expression E3;
> +position p1, p2;
> +@@
> +
> +* array_size(E1, E2)@p1
> +  ... when != \(E1\|E2\|subE1\|subE2\)=E3
> +      when != \(E1\|E2\|subE1\|subE2\)+=E3
> +      when != \(E1\|E2\|subE1\|subE2\)-=E3
> +      when != \(E1\|E2\|subE1\|subE2\)*=E3
> +      when != \(&E1\|&E2\|&subE1\|&subE2\)
> +* array_size(E1, E2)@p2
> +
> +@as3@
> +expression E1, E2, E3;
> +@@
> +
> +array3_size(E1, E2, E3)
> +
> +@as3_next@
> +expression subE1 <= as3.E1;
> +expression as3.E1;
> +expression subE2 <= as3.E2;
> +expression as3.E2;
> +expression subE3 <= as3.E3;
> +expression as3.E3;
> +expression E4;
> +position p1, p2;
> +@@
> +
> +* E1 * E2 * E3@p1
> +  ... when != \(E1\|E2\|E3\|subE1\|subE2\|subE3\)=E4
> +      when != \(E1\|E2\|E3\|subE1\|subE2\|subE3\)+=E4
> +      when != \(E1\|E2\|E3\|subE1\|subE2\|subE3\)-=E4
> +      when != \(E1\|E2\|E3\|subE1\|subE2\|subE3\)*=E4
> +      when != \(&E1\|&E2\|&E3\|&subE1\|&subE2\|&subE3\)
> +* array3_size(E1, E2, E3)@p2
> +
> +@as3_prev@
> +expression subE1 <= as3.E1;
> +expression as3.E1;
> +expression subE2 <= as3.E2;
> +expression as3.E2;
> +expression subE3 <= as3.E3;
> +expression as3.E3;
> +expression E4;
> +position p1, p2;
> +@@
> +
> +* array3_size(E1, E2, E3)@p1
> +  ... when != \(E1\|E2\|E3\|subE1\|subE2\|subE3\)=E4
> +      when != \(E1\|E2\|E3\|subE1\|subE2\|subE3\)+=E4
> +      when != \(E1\|E2\|E3\|subE1\|subE2\|subE3\)-=E4
> +      when != \(E1\|E2\|E3\|subE1\|subE2\|subE3\)*=E4
> +      when != \(&E1\|&E2\|&E3\|&subE1\|&subE2\|&subE3\)
> +* E1 * E2 * E3@p2
> +
> +@as3_dup@
> +expression subE1 <= as3.E1;
> +expression as3.E1;
> +expression subE2 <= as3.E2;
> +expression as3.E2;
> +expression subE3 <= as3.E3;
> +expression as3.E3;
> +expression E4;
> +position p1, p2;
> +@@
> +
> +* array3_size(E1, E2, E3)@p1
> +  ... when != \(E1\|E2\|E3\|subE1\|subE2\|subE3\)=E4
> +      when != \(E1\|E2\|E3\|subE1\|subE2\|subE3\)+=E4
> +      when != \(E1\|E2\|E3\|subE1\|subE2\|subE3\)-=E4
> +      when != \(E1\|E2\|E3\|subE1\|subE2\|subE3\)*=E4
> +      when != \(&E1\|&E2\|&E3\|&subE1\|&subE2\|&subE3\)
> +* array3_size(E1, E2, E3)@p2
> +
> +@ss@
> +expression E1, E2, E3;
> +@@
> +
> +struct_size(E1, E2, E3)
> +
> +@ss_next@
> +expression subE1 <= ss.E1;
> +expression ss.E1;
> +expression subE2 <= ss.E2;
> +expression ss.E2;
> +expression subE3 <= ss.E3;
> +expression ss.E3;
> +expression E4;
> +position p1, p2;
> +@@
> +
> +* E1 * E2 + E3@p1
> +  ... when != \(E1\|E2\|E3\|subE1\|subE2\|subE3\)=E4
> +      when != \(E1\|E2\|E3\|subE1\|subE2\|subE3\)+=E4
> +      when != \(E1\|E2\|E3\|subE1\|subE2\|subE3\)-=E4
> +      when != \(E1\|E2\|E3\|subE1\|subE2\|subE3\)*=E4
> +      when != \(&E1\|&E2\|&E3\|&subE1\|&subE2\|&subE3\)
> +* struct_size(E1, E2, E3)@p2
> +
> +@ss_prev@
> +expression subE1 <= ss.E1;
> +expression ss.E1;
> +expression subE2 <= ss.E2;
> +expression ss.E2;
> +expression subE3 <= ss.E3;
> +expression ss.E3;
> +expression E4;
> +position p1, p2;
> +@@
> +
> +* struct_size(E1, E2, E3)@p1
> +  ... when != \(E1\|E2\|E3\|subE1\|subE2\|subE3\)=E4
> +      when != \(E1\|E2\|E3\|subE1\|subE2\|subE3\)+=E4
> +      when != \(E1\|E2\|E3\|subE1\|subE2\|subE3\)-=E4
> +      when != \(E1\|E2\|E3\|subE1\|subE2\|subE3\)*=E4
> +      when != \(&E1\|&E2\|&E3\|&subE1\|&subE2\|&subE3\)
> +* E1 * E2 + E3@p2
> +
> +@ss_dup@
> +expression subE1 <= ss.E1;
> +expression ss.E1;
> +expression subE2 <= ss.E2;
> +expression ss.E2;
> +expression subE3 <= ss.E3;
> +expression ss.E3;
> +expression E4;
> +position p1, p2;
> +@@
> +
> +* struct_size(E1, E2, E3)@p1
> +  ... when != \(E1\|E2\|E3\|subE1\|subE2\|subE3\)=E4
> +      when != \(E1\|E2\|E3\|subE1\|subE2\|subE3\)+=E4
> +      when != \(E1\|E2\|E3\|subE1\|subE2\|subE3\)-=E4
> +      when != \(E1\|E2\|E3\|subE1\|subE2\|subE3\)*=E4
> +      when != \(&E1\|&E2\|&E3\|&subE1\|&subE2\|&subE3\)
> +* struct_size(E1, E2, E3)@p2
> +
> +@script:python depends on report@
> +p1 << as_next.p1;
> +p2 << as_next.p2;
> +@@
> +
> +msg = "WARNING: array_size is used down the code (line %s) to compute the same size" % (p2[0].line)
> +coccilib.report.print_report(p1[0], msg)
> +
> +@script:python depends on org@
> +p1 << as_next.p1;
> +p2 << as_next.p2;
> +@@
> +
> +msg = "WARNING: array_size is used down the code (line %s) to compute the same size" % (p2[0].line)
> +coccilib.org.print_todo(p1[0], msg)
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
> +@script:python depends on report@
> +p1 << as_dup.p1;
> +p2 << as_dup.p2;
> +@@
> +
> +msg = "WARNING: same array_size (line %s)" % (p1[0].line)
> +coccilib.report.print_report(p2[0], msg)
> +
> +@script:python depends on org@
> +p1 << as_dup.p1;
> +p2 << as_dup.p2;
> +@@
> +
> +msg = "WARNING: same array_size (line %s)" % (p1[0].line)
> +coccilib.org.print_todo(p2[0], msg)
> +
> +
> +@script:python depends on report@
> +p1 << as3_next.p1;
> +p2 << as3_next.p2;
> +@@
> +
> +msg = "WARNING: array3_size is used down the code (line %s) to compute the same size" % (p2[0].line)
> +coccilib.report.print_report(p1[0], msg)
> +
> +@script:python depends on org@
> +p1 << as3_next.p1;
> +p2 << as3_next.p2;
> +@@
> +
> +msg = "WARNING: array3_size is used down the code (line %s) to compute the same size" % (p2[0].line)
> +coccilib.org.print_todo(p1[0], msg)
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
> +@script:python depends on report@
> +p1 << as3_dup.p1;
> +p2 << as3_dup.p2;
> +@@
> +
> +msg = "WARNING: same array3_size (line %s)" % (p1[0].line)
> +coccilib.report.print_report(p2[0], msg)
> +
> +@script:python depends on org@
> +p1 << as3_dup.p1;
> +p2 << as3_dup.p2;
> +@@
> +
> +msg = "WARNING: same array3_size (line %s)" % (p1[0].line)
> +coccilib.org.print_todo(p2[0], msg)
> +
> +
> +@script:python depends on report@
> +p1 << ss_next.p1;
> +p2 << ss_next.p2;
> +@@
> +
> +msg = "WARNING: struct_size is used down the code (line %s) to compute the same size" % (p2[0].line)
> +coccilib.report.print_report(p1[0], msg)
> +
> +@script:python depends on org@
> +p1 << ss_next.p1;
> +p2 << ss_next.p2;
> +@@
> +
> +msg = "WARNING: struct_size is used down the code (line %s) to compute the same size" % (p2[0].line)
> +coccilib.org.print_todo(p1[0], msg)
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
> +
> +@script:python depends on report@
> +p1 << ss_dup.p1;
> +p2 << ss_dup.p2;
> +@@
> +
> +msg = "WARNING: same struct_size (line %s)" % (p1[0].line)
> +coccilib.report.print_report(p2[0], msg)
> +
> +@script:python depends on org@
> +p1 << ss_dup.p1;
> +p2 << ss_dup.p2;
> +@@
> +
> +msg = "WARNING: same struct_size (line %s)" % (p1[0].line)
> +coccilib.org.print_todo(p2[0], msg)
> --
> 2.26.2
>
> _______________________________________________
> Cocci mailing list
> Cocci@systeme.lip6.fr
> https://systeme.lip6.fr/mailman/listinfo/cocci
>
