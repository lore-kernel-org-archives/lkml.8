Return-Path: <SRS0=b2Mh=CK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98265C433E6
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Sep 2020 10:08:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 73DE020C56
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Sep 2020 10:08:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726384AbgIAKIy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 1 Sep 2020 06:08:54 -0400
Received: from mail3-relais-sop.national.inria.fr ([192.134.164.104]:60874
        "EHLO mail3-relais-sop.national.inria.fr" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725949AbgIAKIw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Sep 2020 06:08:52 -0400
X-IronPort-AV: E=Sophos;i="5.76,359,1592863200"; 
   d="scan'208";a="357781665"
Received: from abo-173-121-68.mrs.modulonet.fr (HELO hadrien) ([85.68.121.173])
  by mail3-relais-sop.national.inria.fr with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 01 Sep 2020 12:08:43 +0200
Date:   Tue, 1 Sep 2020 12:08:43 +0200 (CEST)
From:   Julia Lawall <julia.lawall@inria.fr>
X-X-Sender: jll@hadrien
To:     Denis Efremov <efremov@linux.com>
cc:     cocci@systeme.lip6.fr, linux-kernel@vger.kernel.org,
        Kees Cook <keescook@chromium.org>,
        "Gustavo A . R . Silva" <gustavoars@kernel.org>
Subject: Re: [PATCH v3] coccinelle: misc: add uninitialized_var.cocci
 script
In-Reply-To: <20200901094812.428896-1-efremov@linux.com>
Message-ID: <alpine.DEB.2.22.394.2009011208260.2533@hadrien>
References: <20200811210127.11889-1-efremov@linux.com> <20200901094812.428896-1-efremov@linux.com>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On Tue, 1 Sep 2020, Denis Efremov wrote:

> uninitialized_var() macro was removed from the sources [1] and
> other warning-silencing tricks were deprecated [2]. The purpose of this
> cocci script is to prevent new occurrences of uninitialized_var()
> open-coded variants.
>
> [1] commit 63a0895d960a ("compiler: Remove uninitialized_var() macro")
> [2] commit 4b19bec97c88 ("docs: deprecated.rst: Add uninitialized_var()")

Thanks!  I find that much more understandable.

julia

>
> Cc: Kees Cook <keescook@chromium.org>
> Cc: Gustavo A. R. Silva <gustavoars@kernel.org>
> Signed-off-by: Denis Efremov <efremov@linux.com>
> ---
> Changes in v2:
>  - Documentation cited in the script's description
>  - kernel.org link added to the diagnostics messages
>  - "T *var = &var;" pattern removed
>  - "var =@p var", "var =@p *(&(var))" patterns added
> Changes in v3:
>  - commit's description changed
>
>  .../coccinelle/misc/uninitialized_var.cocci   | 51 +++++++++++++++++++
>  1 file changed, 51 insertions(+)
>  create mode 100644 scripts/coccinelle/misc/uninitialized_var.cocci
>
> diff --git a/scripts/coccinelle/misc/uninitialized_var.cocci b/scripts/coccinelle/misc/uninitialized_var.cocci
> new file mode 100644
> index 000000000000..8fa845cefe11
> --- /dev/null
> +++ b/scripts/coccinelle/misc/uninitialized_var.cocci
> @@ -0,0 +1,51 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +///
> +/// Please, don't reintroduce uninitialized_var().
> +/// From Documentation/process/deprecated.rst:
> +///  For any compiler warnings about uninitialized variables, just add
> +///  an initializer. Using warning-silencing tricks is dangerous as it
> +///  papers over real bugs (or can in the future), and suppresses unrelated
> +///  compiler warnings (e.g. "unused variable"). If the compiler thinks it
> +///  is uninitialized, either simply initialize the variable or make compiler
> +///  changes. Keep in mind that in most cases, if an initialization is
> +///  obviously redundant, the compiler's dead-store elimination pass will make
> +///  sure there are no needless variable writes.
> +///
> +// Confidence: High
> +// Copyright: (C) 2020 Denis Efremov ISPRAS
> +// Options: --no-includes --include-headers
> +//
> +
> +virtual context
> +virtual report
> +virtual org
> +
> +@r@
> +identifier var;
> +type T;
> +position p;
> +@@
> +
> +(
> +* T var =@p var;
> +|
> +* T var =@p *(&(var));
> +|
> +* var =@p var
> +|
> +* var =@p *(&(var))
> +)
> +
> +@script:python depends on report@
> +p << r.p;
> +@@
> +
> +coccilib.report.print_report(p[0],
> +  "WARNING this kind of initialization is deprecated (https://www.kernel.org/doc/html/latest/process/deprecated.html#uninitialized-var)")
> +
> +@script:python depends on org@
> +p << r.p;
> +@@
> +
> +coccilib.org.print_todo(p[0],
> +  "WARNING this kind of initialization is deprecated (https://www.kernel.org/doc/html/latest/process/deprecated.html#uninitialized-var)")
> --
> 2.26.2
>
>
