Return-Path: <SRS0=pQss=CP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4DA09C43461
	for <linux-kernel@archiver.kernel.org>; Sun,  6 Sep 2020 09:57:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0276D20C09
	for <linux-kernel@archiver.kernel.org>; Sun,  6 Sep 2020 09:57:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="X/xXQA7K"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728199AbgIFJ5i (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 6 Sep 2020 05:57:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725803AbgIFJ5b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Sep 2020 05:57:31 -0400
Received: from mail-pl1-x641.google.com (mail-pl1-x641.google.com [IPv6:2607:f8b0:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1FC92C061574
        for <linux-kernel@vger.kernel.org>; Sun,  6 Sep 2020 02:57:31 -0700 (PDT)
Received: by mail-pl1-x641.google.com with SMTP id r24so187654pls.1
        for <linux-kernel@vger.kernel.org>; Sun, 06 Sep 2020 02:57:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Q2SILnBIEirH4TWtGi68qehLBgXZt7pRjYM7YYT/J/Q=;
        b=X/xXQA7KjAXlhHEWXtOlnmdlGYZ82PRDubSws+IHO5QuygN1YWTfsEWWv5SLWMWDE1
         Po5lZUgnbS0tbOeomPRm7XYLcg35w4L1+nNrgCib6qYMo6e4JEWDdZk+eszaLhzSrMhJ
         BZ6VjPROaq5Pw50YFfMq9Jl1iU4vcVRqNX9sY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Q2SILnBIEirH4TWtGi68qehLBgXZt7pRjYM7YYT/J/Q=;
        b=KVVDCGY4ZRflSqvxljvR4khElIsv2lZ97V2vITN4afLKCtyUWuKWFgVH9sKojEnuRE
         8hI075mb2T7CVuHz90ShciqxUMmHxgXX8opzZ4UOIfzcRmVdqJ6GNvOUHJEXTmzAKp/C
         26YSlwx00ab50AUxLZtu8KdDW5Ac1ALSc9pdtoRP1oK1Zo4KKqHtqZTIMZbYLt/KUqRv
         MWKqydqWiagUX8n0C0eMhXcGiuVHbLXFjSHL3OPh57KXzEERIqo2LJ4EpTv8meI+YCUJ
         MCo0rnJQiv5P0giYIVImUaxPytD69TLnLzNPJ+/iH0Gqs60dgHaFIr+RxudtqM5K7H9q
         BPAA==
X-Gm-Message-State: AOAM530bBVrTI/hCh631yDBE4dzhxYZCuMYrUoKUih26MSlJiRwcHPAu
        fBHJt0LWfQ36gKjntZQIqb1Jxw==
X-Google-Smtp-Source: ABdhPJzkAJnCDVOKe7i/BgUKdpebHEmdjzLYkAdn6d/5GqTI6KIttjhyn3LSssnVUAOi2/4uPdrgXA==
X-Received: by 2002:a17:902:ee03:b029:d0:89f1:9e2b with SMTP id z3-20020a170902ee03b02900d089f19e2bmr13926305plb.7.1599386250044;
        Sun, 06 Sep 2020 02:57:30 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id w185sm12900952pfc.36.2020.09.06.02.57.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 06 Sep 2020 02:57:28 -0700 (PDT)
Date:   Sun, 6 Sep 2020 02:57:27 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Masahiro Yamada <masahiroy@kernel.org>
Cc:     Nick Desaulniers <ndesaulniers@google.com>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        stable <stable@vger.kernel.org>, Andy Lavr <andy.lavr@gmail.com>,
        Arvind Sankar <nivedita@alum.mit.edu>,
        Joe Perches <joe@perches.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Sami Tolvanen <samitolvanen@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Alexandru Ardelean <alexandru.ardelean@analog.com>,
        Yury Norov <yury.norov@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3] lib/string.c: implement stpcpy
Message-ID: <202009060256.7CE5620A56@keescook>
References: <20200825135838.2938771-1-ndesaulniers@google.com>
 <CAK7LNAQvQBhjYgSkvm-dVyNz2Jd2C2qAtfyRk-rngEDfjkc38g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAK7LNAQvQBhjYgSkvm-dVyNz2Jd2C2qAtfyRk-rngEDfjkc38g@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 27, 2020 at 12:58:35AM +0900, Masahiro Yamada wrote:
> On Tue, Aug 25, 2020 at 10:58 PM Nick Desaulniers
> <ndesaulniers@google.com> wrote:
> > [...]
> > +/**
> > + * stpcpy - copy a string from src to dest returning a pointer to the new end
> > + *          of dest, including src's %NUL-terminator. May overrun dest.
> > + * @dest: pointer to end of string being copied into. Must be large enough
> > + *        to receive copy.
> > + * @src: pointer to the beginning of string being copied from. Must not overlap
> > + *       dest.
> > + *
> > + * stpcpy differs from strcpy in a key way: the return value is the new
> > + * %NUL-terminated character. (for strcpy, the return value is a pointer to
> > + * src.
> 
> 
> return a pointer to src?
> 
> "man 3 strcpy" says:
> 
> The strcpy() and strncpy() functions return
> a pointer to the destination string *dest*.

Agreed; that's a typo.

-- 
Kees Cook
