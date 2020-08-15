Return-Path: <SRS0=qJsj=BZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A14FBC433E1
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Aug 2020 22:01:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7C6C320639
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Aug 2020 22:01:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="b5j/+d/S"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729717AbgHOWBa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 15 Aug 2020 18:01:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728795AbgHOVva (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Aug 2020 17:51:30 -0400
Received: from mail-pj1-x1043.google.com (mail-pj1-x1043.google.com [IPv6:2607:f8b0:4864:20::1043])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA66DC061357
        for <linux-kernel@vger.kernel.org>; Fri, 14 Aug 2020 19:01:11 -0700 (PDT)
Received: by mail-pj1-x1043.google.com with SMTP id 2so5215812pjx.5
        for <linux-kernel@vger.kernel.org>; Fri, 14 Aug 2020 19:01:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=jI8e9DtJD9Qcgx42soPG9jHlS2DsiPdV0uXxPDuNotg=;
        b=b5j/+d/SR6xrSblNKYVjBhuIMIiKPO3YfhBxKHpYK+mnLaoiNYk2/l70QldOlzNKId
         XllwItmXSK+pdXDzxM6NCyQJ26LP/Y0CBwCkaLgoo0+g/iU7dIhvJ7sH8UJwinEN5JZB
         5bOUXjTYgSwZvSbAJ0VgX2pdbDwASMP+Uu8PEMPKu5PhfRlOTyQ+vQBf9e0M5iGv5+va
         N4eyu3w0s0UWdJBWXMKWnAuy+uwpRlh1r6AOiZrzW0zlnGaeSdvxKPxsmxoYzY+q84nl
         EY7q1xYyzOqSMrmqJsi2tN2AUz66JBki14TSgu6EaXSPk2aF9PXdIWjdWad2PD+tLD/X
         midg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=jI8e9DtJD9Qcgx42soPG9jHlS2DsiPdV0uXxPDuNotg=;
        b=ubP8ztFN6Z/jLnABROV7xgmyxXXPAygQV9OxCq21at6V/ff41U6xiOsfe9bZqH3cJR
         ktWiQTMGN3/oOBW8EunGHKdRh5tUscqFDrP6rBUJ5T7utwkXPUyeiEZZQApSGtGgH6T7
         pM2BOPf7HEaiBIX7otCP9g+qZ3EtyG1RuWi1ddTOIRNRJcsre8TO0vKvjBRNZAyrxRBb
         y6BDjIXh7imDlLGaTTeOg7AW/2b22Nlb8K1YP0AIFkN1Z4i0MgPDUhyWYK3mLQqs/UzQ
         F023k0fa3KG2+o0DKgKmUnjUJ6n/pxGaRjd9G6uMXShifVxF3LjbIJUCg8fAIFSZo2NY
         /s0A==
X-Gm-Message-State: AOAM533LK+gu3HUEr1RxqDETp6/n3WtpWhtdoCa19GNnX/+YDyPtjZhC
        ycHSNzwm86V1r+p5rqkKh3u5eDdQ1F2f1AcrZxCzIg==
X-Google-Smtp-Source: ABdhPJyAQGYDJaYF+g6h0fcKg+b0uima08cob63o0BSo/gSm3/zxH9KIbTIsnHhs2p7hpr6ZH7G3odV5U7Fn6ltoJnQ=
X-Received: by 2002:a17:90a:a10c:: with SMTP id s12mr4383536pjp.32.1597456871114;
 Fri, 14 Aug 2020 19:01:11 -0700 (PDT)
MIME-Version: 1.0
References: <20200815002417.1512973-1-ndesaulniers@google.com> <20200815013310.GA99152@rani.riverdale.lan>
In-Reply-To: <20200815013310.GA99152@rani.riverdale.lan>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Fri, 14 Aug 2020 19:00:59 -0700
Message-ID: <CAKwvOdkcq4TeFQ_Cw39DyA+N6rhyx2q9jpvN+Cv9n7x+MwijmA@mail.gmail.com>
Subject: Re: [PATCH] lib/string.c: implement stpcpy
To:     Arvind Sankar <nivedita@alum.mit.edu>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        =?UTF-8?B?RMOhdmlkIEJvbHZhbnNrw70=?= <david.bolvansky@gmail.com>,
        Eli Friedman <efriedma@quicinc.com>,
        "# 3.4.x" <stable@vger.kernel.org>,
        Sami Tolvanen <samitolvanen@google.com>,
        Joe Perches <joe@perches.com>, Tony Luck <tony.luck@intel.com>,
        Yury Norov <yury.norov@gmail.com>,
        Daniel Axtens <dja@axtens.net>,
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

On Fri, Aug 14, 2020 at 6:33 PM Arvind Sankar <nivedita@alum.mit.edu> wrote:
>
> On Fri, Aug 14, 2020 at 05:24:15PM -0700, Nick Desaulniers wrote:
> > +#ifndef __HAVE_ARCH_STPCPY
> > +/**
> > + * stpcpy - copy a string from src to dest returning a pointer to the new end
> > + *          of dest, including src's NULL terminator. May overrun dest.
> > + * @dest: pointer to end of string being copied into. Must be large enough
> > + *        to receive copy.
> > + * @src: pointer to the beginning of string being copied from. Must not overlap
> > + *       dest.
> > + *
> > + * stpcpy differs from strcpy in two key ways:
> > + * 1. inputs must not overlap.
> > + * 2. return value is the new NULL terminated character. (for strcpy, the
> > + *    return value is a pointer to src.
> > + */
> > +#undef stpcpy
> > +char *stpcpy(char *__restrict__ dest, const char *__restrict__ src)
> > +{
> > +     while ((*dest++ = *src++) != '\0')
> > +             /* nothing */;
> > +     return dest;
> > +}
> > +#endif
> > +
>
> Won't this return a pointer that's one _past_ the terminating NUL? I
> think you need the increments to be inside the loop body, rather than as
> part of the condition.

Yep, looks like I had a bug in my test program that masked this.
Thanks for triple checking.

>
> Nit: NUL is more correct than NULL to refer to the string terminator.

TIL.

-- 
Thanks,
~Nick Desaulniers
