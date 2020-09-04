Return-Path: <SRS0=2gBQ=CN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6F1AC433E2
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Sep 2020 20:39:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 982CE208FE
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Sep 2020 20:39:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728082AbgIDUjT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 4 Sep 2020 16:39:19 -0400
Received: from mail3-relais-sop.national.inria.fr ([192.134.164.104]:6772 "EHLO
        mail3-relais-sop.national.inria.fr" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726618AbgIDUjR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Sep 2020 16:39:17 -0400
X-IronPort-AV: E=Sophos;i="5.76,359,1592863200"; 
   d="scan'208";a="358135169"
Received: from abo-173-121-68.mrs.modulonet.fr (HELO hadrien) ([85.68.121.173])
  by mail3-relais-sop.national.inria.fr with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 04 Sep 2020 22:39:16 +0200
Date:   Fri, 4 Sep 2020 22:39:16 +0200 (CEST)
From:   Julia Lawall <julia.lawall@inria.fr>
X-X-Sender: jll@hadrien
To:     Denis Efremov <efremov@linux.com>
cc:     cocci@systeme.lip6.fr, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] coccinelle: misc: add excluded_middle.cocci script
In-Reply-To: <20200902151859.403354-1-efremov@linux.com>
Message-ID: <alpine.DEB.2.22.394.2009042236360.2425@hadrien>
References: <20200902151859.403354-1-efremov@linux.com>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On Wed, 2 Sep 2020, Denis Efremov wrote:

> Check for "!A || A && B" condition. It's equivalent to
> "!A || B" condition.
>
> Signed-off-by: Denis Efremov <efremov@linux.com>
> ---
>  scripts/coccinelle/misc/excluded_middle.cocci | 40 +++++++++++++++++++
>  1 file changed, 40 insertions(+)
>  create mode 100644 scripts/coccinelle/misc/excluded_middle.cocci
>
> diff --git a/scripts/coccinelle/misc/excluded_middle.cocci b/scripts/coccinelle/misc/excluded_middle.cocci
> new file mode 100644
> index 000000000000..1b8c20f13966
> --- /dev/null
> +++ b/scripts/coccinelle/misc/excluded_middle.cocci
> @@ -0,0 +1,40 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +///
> +/// Condition "!A || A && B" is equalent to "!A || B".

As was noted, there is a spelling mistake here.

> +///
> +// Confidence: High
> +// Copyright: (C) 2020 Denis Efremov ISPRAS
> +// Options: --no-includes --include-headers
> +
> +virtual patch
> +virtual context
> +virtual org
> +virtual report
> +
> +@r depends on !patch@
> +expression A, B;
> +position p;
> +@@
> +
> +* !A || (A && B)@p

In org mode, the token with the position variable gets highlighted in
color.  It would be more meaningful to put the position variable on the &&
operator.

> +
> +@depends on patch@
> +expression A, B;
> +@@
> +
> +  !A ||
> +-      (A &&
> +             B
> +-      )

I found it better to say

- (A && B)
+ B

There are some cases where B should be moved one space to the left and by
removing B and adding it back again that will happen.  I didn't see any
case where the result was less good.

> +@script:python depends on report@
> +p << r.p;
> +@@
> +
> +coccilib.report.print_report(p[0], "WARNING condition !A || A && B is equivalent to !A || B")
> +
> +@script:python depends on org@
> +p << r.p;
> +@@
> +
> +coccilib.org.print_todo(p[0], "WARNING condition !A || A && B is equivalent to !A || B")

I'm not sure that you need the word condition, but up to you.

julia
