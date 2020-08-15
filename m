Return-Path: <SRS0=qJsj=BZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.6 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1FF2C433E1
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Aug 2020 22:01:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7CFF0205CB
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Aug 2020 22:01:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="PeLFqURv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729689AbgHOWBZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 15 Aug 2020 18:01:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728798AbgHOVva (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Aug 2020 17:51:30 -0400
Received: from mail-pl1-x644.google.com (mail-pl1-x644.google.com [IPv6:2607:f8b0:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7835C061350
        for <linux-kernel@vger.kernel.org>; Fri, 14 Aug 2020 19:00:35 -0700 (PDT)
Received: by mail-pl1-x644.google.com with SMTP id k13so4954243plk.13
        for <linux-kernel@vger.kernel.org>; Fri, 14 Aug 2020 19:00:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=elMrilSLXI6b7aYlKVZpaKDCZnCipuhXfzdMESlljx4=;
        b=PeLFqURvd92pEiF6Mj5L1v1twm8KmHeCGT5FIUueuiePqXC/2SmG8X8wnJdCAvoIMF
         KBT1wvqHoqpL5j0WDX0ITEnjU+oLOV3CiB72ng3+Obta5Y7ld8+oYs4EO/mBUzjiyFvi
         z0uWLCjbBqWiMYG+AQi4Vw2rbLXCjmg86TOHvoZzdgZS2eHot7znULGD970HG2GgHWTS
         YHBgZCv60OtMpqCL+406elAO7tlZMekOZ3JwLSlD9NXsv9gftMbi/I41LKy7I7cZiloO
         iBZ3LenMuMHyqsmaKE3teY8bEw1j3TCBYD/bdFSe3gq1So0jmDCnm44iPKDgGjeqUfxb
         3ecw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=elMrilSLXI6b7aYlKVZpaKDCZnCipuhXfzdMESlljx4=;
        b=UW0wRWvlfn0BquPXc4o30EgC+RhsUhIcdFz+Iy3F6EiltlnxaTfHz36CRfl/4Y+lO9
         +ms6aBHsdNQnPenzESkX8lv9dDpZdDuTKhmpOqx7rVN2v4euRMjIqlPflQ/2uhwyVqxm
         QMMrSMp9Dv7Arzq9RHaU4o6ZyL2mnzNC0/GErq73joF0oI1jebpEZqX1rmOHB1yTf/Oh
         inGr9WXXWJ/3ygSspmGIVs+JpuBVWM9a+7K+IfyXu/ki/MV7e8AOHBxlOL8t+I84SDB4
         qbT/vZbvOuBQckAvw36Rtj5ZANbKitLM+z56QF71TRSOoVxn1DIL7r6rhWx2oXJdnEZL
         ZMOw==
X-Gm-Message-State: AOAM531b79BPgAEiATT2kG6i2oaqFzXM7Ea2w/UEds+N7XWToblfBhZk
        5jZ133x+ZJhoB5QpPcBEGwfIYxE2gEg2Ubhy6pj2EQ==
X-Google-Smtp-Source: ABdhPJwaOHL0rmpbix09Dt9ThyyA5ar4WG4bAXv4Vl84QpdBQ0LTKX4e8nB5NFzkcS+KwDHRsirpMdgZVcKrmcAqpxs=
X-Received: by 2002:a17:902:8509:: with SMTP id bj9mr3855029plb.179.1597456834421;
 Fri, 14 Aug 2020 19:00:34 -0700 (PDT)
MIME-Version: 1.0
References: <20200815002417.1512973-1-ndesaulniers@google.com> <562003af51ca0b08f2108147b8d6e75cec18f3fd.camel@perches.com>
In-Reply-To: <562003af51ca0b08f2108147b8d6e75cec18f3fd.camel@perches.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Fri, 14 Aug 2020 19:00:22 -0700
Message-ID: <CAKwvOdn8PdK-3Xhm-JFG-=1djoPPEMcANjXarGpLUTkahJoFJw@mail.gmail.com>
Subject: Re: [PATCH] lib/string.c: implement stpcpy
To:     Joe Perches <joe@perches.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        =?UTF-8?B?RMOhdmlkIEJvbHZhbnNrw70=?= <david.bolvansky@gmail.com>,
        Eli Friedman <efriedma@quicinc.com>,
        "# 3.4.x" <stable@vger.kernel.org>,
        Sami Tolvanen <samitolvanen@google.com>,
        Tony Luck <tony.luck@intel.com>,
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

On Fri, Aug 14, 2020 at 5:52 PM Joe Perches <joe@perches.com> wrote:
>
> On Fri, 2020-08-14 at 17:24 -0700, Nick Desaulniers wrote:
> > LLVM implemented a recent "libcall optimization" that lowers calls to
> > `sprintf(dest, "%s", str)` where the return value is used to
> > `stpcpy(dest, str) - dest`. This generally avoids the machinery involved
> > in parsing format strings.
> []
> > diff --git a/include/linux/string.h b/include/linux/string.h
> []
> > @@ -31,6 +31,9 @@ size_t strlcpy(char *, const char *, size_t);
> >  #ifndef __HAVE_ARCH_STRSCPY
> >  ssize_t strscpy(char *, const char *, size_t);
> >  #endif
> > +#ifndef __HAVE_ARCH_STPCPY
> > +extern char *stpcpy(char *__restrict, const char *__restrict__);
>
> Why use two different forms for __restrict and __restrict__?
> Any real reason to use __restrict__ at all?

Bah, sorry, I recently enabled some setting in my ~/.vimrc to help me
find my cursor better:
" highlight cursor
set cursorline
set cursorcolumn

Turns out this makes it pretty difficult to see underscores, or the
lack thereof.  Will fix up.

>
> It's used nowhere else in the kernel.
>
> $ git grep -w -P '__restrict_{0,2}'
> scripts/genksyms/keywords.c:    // According to rth, c99 defines "_Bool", __restrict", __restrict__", "restrict".  KAO
> scripts/genksyms/keywords.c:    { "__restrict__", RESTRICT_KEYW },
>
>


-- 
Thanks,
~Nick Desaulniers
