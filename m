Return-Path: <SRS0=qJsj=BZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-19.6 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58742C433E1
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Aug 2020 21:52:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 33114204FD
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Aug 2020 21:52:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="opWbEJLA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729194AbgHOVwy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 15 Aug 2020 17:52:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729110AbgHOVwf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Aug 2020 17:52:35 -0400
Received: from mail-ej1-x642.google.com (mail-ej1-x642.google.com [IPv6:2a00:1450:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D79DC061348
        for <linux-kernel@vger.kernel.org>; Fri, 14 Aug 2020 17:53:41 -0700 (PDT)
Received: by mail-ej1-x642.google.com with SMTP id m22so11679847eje.10
        for <linux-kernel@vger.kernel.org>; Fri, 14 Aug 2020 17:53:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=cE/B8jLj1zvXZ+mvl87f60vua1FqTOB1sidvPP/WOgw=;
        b=opWbEJLAX5qZbFpaKKZsvc/e8RNL/4tGU/5+gViPNL//IDiQoQtBlTLSzzmrl1XfSN
         7gIxERT+8ExdXmKG1LZPDzPWMkzQTReXKx0ITYiliKFUjkIt6i85mEChVWopekn4wAGj
         gfiBKSUqnKRTjekrpQOpCDJwSnJi5XmbQtbdar7ObT4lW8YvuI/aTPsZkMlLbGps1t2p
         bO2tf5mNlVMAsRothforYyk+YoS5Z+5q/+DAG+Dh+tT6ki+L/aTkg+EW8W9a1CJKuB4A
         g8ceSac41Bcdsa2UCT/3ODU+9pbD/lXNdVzCH3EyG+f9Sd7/CsWbnqwKtbPqC1BPyPJ+
         xgvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=cE/B8jLj1zvXZ+mvl87f60vua1FqTOB1sidvPP/WOgw=;
        b=A91T7hD1+s6vpi6GyGVCvBTRTp3e/RFInT5iy+7fMh21ZSRdxRpwC6lWl+0CCsoPn+
         tsqFig4fJNEYdN1x/TCIiGBHODju1/RraIMWpaBqqayV0HUqPcd+22bz3gmPKBuoRyTx
         Tb3RVSQBmhEkFmKDR5oGM+NG3i0/DsYiHwbhqlTIP5lZHXKAHPXBuawrC25luPT7Mq9a
         WDywHdHuVj0/Q6ZfedBvEFCbC5NeFIJYRn1UCyRKye6jy5KP3jmZKz129yKrWEtlal5I
         76If48ZkPeze3W11C0Z0BBuL48XI7fWCLa866UIV2/SlZk0tNckVlcAqwHIUcp0RyWDV
         ORWQ==
X-Gm-Message-State: AOAM533+aUPVrsdxkTkWjx5G/69FqrMqRVVv3TATbFSFB5e02Vbi0zG2
        +q0i30cKmZU0Zwi5DTOwzhTKsA9kgWX2SZw62EJ3EQ==
X-Google-Smtp-Source: ABdhPJzVdWTzcJE2teGLvr5U2+nBzfXqIXCSwMxtlViqGl33Ab6EWKq2Qh8BYAtrIE7u/XqSAtchMB3OFImFW3GdQCQ=
X-Received: by 2002:a17:906:2356:: with SMTP id m22mr4835600eja.124.1597452819358;
 Fri, 14 Aug 2020 17:53:39 -0700 (PDT)
MIME-Version: 1.0
References: <20200815002417.1512973-1-ndesaulniers@google.com>
In-Reply-To: <20200815002417.1512973-1-ndesaulniers@google.com>
From:   Sami Tolvanen <samitolvanen@google.com>
Date:   Fri, 14 Aug 2020 17:53:28 -0700
Message-ID: <CABCJKue4ikLs9NuxkhwxZUMZzgD10mVXnwt4=_8euXer8gzOQQ@mail.gmail.com>
Subject: Re: [PATCH] lib/string.c: implement stpcpy
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        =?UTF-8?B?RMOhdmlkIEJvbHZhbnNrw70=?= <david.bolvansky@gmail.com>,
        Eli Friedman <efriedma@quicinc.com>, stable@vger.kernel.org,
        Joe Perches <joe@perches.com>, Tony Luck <tony.luck@intel.com>,
        Yury Norov <yury.norov@gmail.com>,
        Daniel Axtens <dja@axtens.net>,
        Arvind Sankar <nivedita@alum.mit.edu>,
        Dan Williams <dan.j.williams@intel.com>,
        "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Kees Cook <keescook@chromium.org>,
        Alexandru Ardelean <alexandru.ardelean@analog.com>,
        LKML <linux-kernel@vger.kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Nick,

On Fri, Aug 14, 2020 at 5:24 PM Nick Desaulniers
<ndesaulniers@google.com> wrote:
>
> LLVM implemented a recent "libcall optimization" that lowers calls to
> `sprintf(dest, "%s", str)` where the return value is used to
> `stpcpy(dest, str) - dest`. This generally avoids the machinery involved
> in parsing format strings.
>
> `stpcpy` is just like `strcpy` except:
> 1. it returns the pointer to the new tail of `dest`. This allows you to
>    chain multiple calls to `stpcpy` in one statement.
> 2. it requires the parameters not to overlap.  Calling `sprintf` with
>    overlapping arguments was clarified in ISO C99 and POSIX.1-2001 to be
>    undefined behavior.
>
> `stpcpy` was first standardized in POSIX.1-2008.
>
> Implement this so that we don't observe linkage failures due to missing
> symbol definitions for `stpcpy`.
>
> Similar to last year's fire drill with:
> commit 5f074f3e192f ("lib/string.c: implement a basic bcmp")
>
> This optimization was introduced into clang-12.
>
> Cc: stable@vger.kernel.org
> Link: https://bugs.llvm.org/show_bug.cgi?id=47162
> Link: https://github.com/ClangBuiltLinux/linux/issues/1126
> Link: https://man7.org/linux/man-pages/man3/stpcpy.3.html
> Link: https://pubs.opengroup.org/onlinepubs/9699919799/functions/stpcpy.html
> Link: https://reviews.llvm.org/D85963
> Reported-by: Sami Tolvanen <samitolvanen@google.com>
> Signed-off-by: Nick Desaulniers <ndesaulniers@google.com>
> ---
>  include/linux/string.h |  3 +++
>  lib/string.c           | 23 +++++++++++++++++++++++
>  2 files changed, 26 insertions(+)

Thank you for the patch! I can confirm that this fixes the build for
me with ToT Clang.

Tested-by: Sami Tolvanen <samitolvanen@google.com>

Sami
