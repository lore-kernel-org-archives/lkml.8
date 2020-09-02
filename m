Return-Path: <SRS0=728o=CL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9399C433E2
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Sep 2020 15:26:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B602F20826
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Sep 2020 15:26:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="B27NRa3E"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728251AbgIBP0i (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 2 Sep 2020 11:26:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728104AbgIBPYD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Sep 2020 11:24:03 -0400
Received: from mail-lj1-x242.google.com (mail-lj1-x242.google.com [IPv6:2a00:1450:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3B0FC061245
        for <linux-kernel@vger.kernel.org>; Wed,  2 Sep 2020 08:24:00 -0700 (PDT)
Received: by mail-lj1-x242.google.com with SMTP id t23so6422965ljc.3
        for <linux-kernel@vger.kernel.org>; Wed, 02 Sep 2020 08:24:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=bJN9g6XHl5Af9t91iN2fWoTn9p9DZy7KzM/HvdtvOCA=;
        b=B27NRa3Emoa6Of1Zl798T2u8PZyV4PzMDRi1aFFxgH3bJL8gVNZ0eKQU4Q+bsO2jhu
         Pyk8CrEucMA1dyaw6rbtbcNuL72qx+9D2e+2SyY7gZEwjpSGbTPS4rhlBSUgAZFxes6v
         VuolUOvPo13s+AwoIjD/vQ/I5onYCFlkWg/m4QekMnYAq8qbxGgTEa/hiDouKd+PpOmH
         bpa5Qdb8oHX/+kRuVVoLTRY37rY5oHBgJqBDomy0hyUIl4cx6/ph1N/AZYmVSoKohi6b
         cps/kELm0dQ4OOJa68LXEQnNzUeOZ2xDxWQtSY+OSqNwWNkUAQvhqp7kiR1oFlRCZUut
         AhCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=bJN9g6XHl5Af9t91iN2fWoTn9p9DZy7KzM/HvdtvOCA=;
        b=kipJcGK+rWahvIktv/RyFEpZbShZsYvSJp069odVNP6ALbqcD0CxlDz93/LqXPQBtD
         koQYahfC1DDbPjELlxO8EU8m1we1jT93x5SSRYdUta13yOuFVPcIoJ9dhC4rUKGms52Z
         3mFXe7UL/e4YYvc8xONFKmBiN5whPWp75NFSIpPXgc2BieQ2uEzpkYbid1oyz+7KAogQ
         NWEzjgDxV/qPXJAg02zeivFtiwpCGv+RjBqkhQU7d6YZHAdrttJlpapxgagxXDAO5DNH
         37sh9FDY/7jgiMxn8eOLtfYcCTbYG/HuDJlL4AjOp8IXtI7jcKfyWwd3YvmAawSvKYJi
         16CA==
X-Gm-Message-State: AOAM532srKXc74Vo8BEJLepOGu8Av95c4SviFYF17ylxF19vJFkP8eTq
        1qonqzos1smZcEA5pvmojQqgVaJ+65q56BFOcEQ=
X-Google-Smtp-Source: ABdhPJznxOwyVo+IaOPagU1IMiceEoVK9/Q2lz2grZrBudqtOPUJsvHNLofThyHfOAhXPIvpRP2DTvRVNfvp+dRTaeQ=
X-Received: by 2002:a2e:8844:: with SMTP id z4mr3407333ljj.124.1599060238830;
 Wed, 02 Sep 2020 08:23:58 -0700 (PDT)
MIME-Version: 1.0
References: <20200902151859.403354-1-efremov@linux.com>
In-Reply-To: <20200902151859.403354-1-efremov@linux.com>
From:   Jim Davis <jim.epost@gmail.com>
Date:   Wed, 2 Sep 2020 08:23:47 -0700
Message-ID: <CA+r1ZhiNx+3n_u+TR==fM8jwJHNr1JdH8ijayo5hW9wvam1zJg@mail.gmail.com>
Subject: Re: [Cocci] [PATCH] coccinelle: misc: add excluded_middle.cocci script
To:     Denis Efremov <efremov@linux.com>
Cc:     Julia Lawall <julia.lawall@inria.fr>, cocci@systeme.lip6.fr,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 2, 2020 at 8:19 AM Denis Efremov <efremov@linux.com> wrote:
>
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

s/equalent/equivalent/

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
> +
> +@depends on patch@
> +expression A, B;
> +@@
> +
> +  !A ||
> +-      (A &&
> +             B
> +-      )
> +
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
> --
> 2.26.2
>
> _______________________________________________
> Cocci mailing list
> Cocci@systeme.lip6.fr
> https://systeme.lip6.fr/mailman/listinfo/cocci



-- 
Jim
