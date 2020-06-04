Return-Path: <SRS0=TsDl=7R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27278C433E0
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Jun 2020 14:15:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 085212063A
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Jun 2020 14:15:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728902AbgFDOPb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Jun 2020 10:15:31 -0400
Received: from mail2-relais-roc.national.inria.fr ([192.134.164.83]:58819 "EHLO
        mail2-relais-roc.national.inria.fr" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728496AbgFDOPb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Jun 2020 10:15:31 -0400
X-IronPort-AV: E=Sophos;i="5.73,472,1583190000"; 
   d="scan'208";a="453003555"
Received: from abo-173-121-68.mrs.modulonet.fr (HELO hadrien) ([85.68.121.173])
  by mail2-relais-roc.national.inria.fr with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 04 Jun 2020 16:15:29 +0200
Date:   Thu, 4 Jun 2020 16:15:29 +0200 (CEST)
From:   Julia Lawall <julia.lawall@inria.fr>
X-X-Sender: jll@hadrien
To:     Denis Efremov <efremov@linux.com>
cc:     cocci@systeme.lip6.fr, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] coccinelle: api: add kzfree script
In-Reply-To: <20200604140805.111613-1-efremov@linux.com>
Message-ID: <alpine.DEB.2.21.2006041614300.2577@hadrien>
References: <20200604140805.111613-1-efremov@linux.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On Thu, 4 Jun 2020, Denis Efremov wrote:

> Check for memset() with 0 followed by kfree().
>
> Signed-off-by: Denis Efremov <efremov@linux.com>
> ---
> Patches:
> 1. kzfree in drivers/w1 https://lkml.org/lkml/2020/6/4/438
> 2. kzfree in drivers/iommu/ https://lkml.org/lkml/2020/6/4/421
> 3. kzfree in drivers/scsi/ https://lkml.org/lkml/2020/6/4/442
>
>  scripts/coccinelle/api/kzfree.cocci | 53 +++++++++++++++++++++++++++++
>  1 file changed, 53 insertions(+)
>  create mode 100644 scripts/coccinelle/api/kzfree.cocci
>
> diff --git a/scripts/coccinelle/api/kzfree.cocci b/scripts/coccinelle/api/kzfree.cocci
> new file mode 100644
> index 000000000000..c6b8f7676af4
> --- /dev/null
> +++ b/scripts/coccinelle/api/kzfree.cocci
> @@ -0,0 +1,53 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +///
> +/// Use kzfree rather than memset with 0 followed by kfree
> +///
> +// Confidence: High
> +// Copyright: (C) 2020 Denis Efremov ISPRAS
> +// Options: --no-includes --include-headers
> +//
> +// Keywords: kzfree
> +//
> +
> +virtual context
> +virtual org
> +virtual report
> +virtual patch
> +
> +// Ignore kzfree definition
> +// Ignore kasan test
> +@r depends on !patch && !(file in "lib/test_kasan.c") && !(file in "mm/slab_common.c")@
> +expression E;
> +position p;
> +@@
> +
> +(
> +* memset(E, 0, ...);
> +|
> +* memset(E, '\0', ...);
> +)

You shouldn't need both cases.  0 should be enough.

Did you try ... here but find that some subexpressions of E could be
modified in between?

julia

> +* kfree(E)@p;
> +
> +@r1 depends on patch && !(file in "lib/test_kasan.c") && !(file in "mm/slab_common.c")@
> +expression E;
> +@@
> +
> +(
> +- memset(E, 0, ...);
> +|
> +- memset(E, '\0', ...);
> +)
> +- kfree(E);
> ++ kzfree(E);
> +
> +@script:python depends on report@
> +p << r.p;
> +@@
> +
> +coccilib.report.print_report(p[0], "WARNING opportunity for kzfree")
> +
> +@script:python depends on org@
> +p << r.p;
> +@@
> +
> +coccilib.org.print_todo(p[0], "WARNING opportunity for kzfree")
> --
> 2.26.2
>
>
