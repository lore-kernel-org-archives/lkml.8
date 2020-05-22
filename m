Return-Path: <SRS0=AA2M=7E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78E94C433E1
	for <linux-kernel@archiver.kernel.org>; Fri, 22 May 2020 07:54:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5926A20823
	for <linux-kernel@archiver.kernel.org>; Fri, 22 May 2020 07:54:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Js0gHi2D"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728923AbgEVHyW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 May 2020 03:54:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728152AbgEVHyV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 May 2020 03:54:21 -0400
Received: from mail-oi1-x242.google.com (mail-oi1-x242.google.com [IPv6:2607:f8b0:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB9F7C061A0E
        for <linux-kernel@vger.kernel.org>; Fri, 22 May 2020 00:54:21 -0700 (PDT)
Received: by mail-oi1-x242.google.com with SMTP id 23so7348844oiq.8
        for <linux-kernel@vger.kernel.org>; Fri, 22 May 2020 00:54:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=HDvjesLpXeZbOqZwVDwcodT/WLJvvTdpPsS1Pe0Kvbc=;
        b=Js0gHi2DTQXexCVkMMsYhKEUAtqsQlbamMG8UNpINiLEKQLXsSUxNqSgvgPf14hal3
         Cr7pYIkHBer06P3K+5PRh4agENlFTgSahNc5+iggMr7ET47z/yWICl26a6zfOcGcrWZr
         GGhFLk0+IxVNvDfcDbY2RlgjIOIZTVtgYm1YDntFMLdfbs+GtT8Q6mqc/bVpj4lf8eHd
         vf6E0yIlumIhD9+RhHj3kVypUjknM861hAwo7tz+qajVzsmfqSvrvR7yitsY4yDPGAIV
         ugyi8jD7hPk7P3lObtJLvP6Y+QTjdAgUnFS0QwuzPWnXnlzqUnBX7hdPpuxe3jXn/+TT
         b0ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=HDvjesLpXeZbOqZwVDwcodT/WLJvvTdpPsS1Pe0Kvbc=;
        b=Wco6ARey6ebfHS4VObz68tgBdOY8ZXwHoZ/JmkOu1AUHneZy+Rjm6t1OObvxk5SBhG
         yvPQN8a20zt6rVyFJfrYwwCss22ezby7I+nsMNrtznQsHAW+bqICZDS4sy2g0CvFn3Z1
         DRCXuwKnoRumLDdQaJS/Bj07t2r9E42yx3TbaWuH8RXsr9XiToblSIm3lFjsQIHkILqA
         BIc71DUrodXFSPrs1Ke1VMewYwPaaMlcYsWel0UKUrkwrMrb2Icu6KyqZh2tgvp7a3BB
         6uNjkVYvU0WDbI8grWYvbQJdhcJxUBs5rmV+X05iAZu2+Un29lF9ef4ndDvsBxr4WJAf
         Y+ew==
X-Gm-Message-State: AOAM530mT6J5yRvbphEr3AaAaTUYQ+ex2ZMMcByAomkIeWpkLsp8T3TQ
        tPFrpIKXQSK18Q5nSc/4KoFMWj3GF7Y7L8focKmpSg==
X-Google-Smtp-Source: ABdhPJzpxaj9HyQhPfTgF5R8Pm35E6TnT6e1FhWP001/HepyJH8a5IroXY25wt0UAemMj/6k2gfyh6HP4yUtrM6aJ7Y=
X-Received: by 2002:aca:3254:: with SMTP id y81mr1737976oiy.172.1590134060936;
 Fri, 22 May 2020 00:54:20 -0700 (PDT)
MIME-Version: 1.0
References: <20200519182459.87166-1-elver@google.com> <20200521221133.GD6367@ovpn-112-192.phx2.redhat.com>
In-Reply-To: <20200521221133.GD6367@ovpn-112-192.phx2.redhat.com>
From:   Marco Elver <elver@google.com>
Date:   Fri, 22 May 2020 09:54:09 +0200
Message-ID: <CANpmjNOi4yx8guwUeYx_NZUEiNVtSXzWmW5Zq1DWJ2bvuwFTgw@mail.gmail.com>
Subject: Re: [PATCH] kasan: Disable branch tracing for core runtime
To:     Qian Cai <cai@lca.pw>
Cc:     Dmitry Vyukov <dvyukov@google.com>,
        Alexander Potapenko <glider@google.com>,
        Andrey Konovalov <andreyknvl@google.com>,
        LKML <linux-kernel@vger.kernel.org>,
        kasan-dev <kasan-dev@googlegroups.com>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        kernel test robot <rong.a.chen@intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 22 May 2020 at 00:11, Qian Cai <cai@lca.pw> wrote:
>
> On Tue, May 19, 2020 at 08:24:59PM +0200, 'Marco Elver' via kasan-dev wrote:
> > During early boot, while KASAN is not yet initialized, it is possible to
> > enter reporting code-path and end up in kasan_report(). While
> > uninitialized, the branch there prevents generating any reports,
> > however, under certain circumstances when branches are being traced
> > (TRACE_BRANCH_PROFILING), we may recurse deep enough to cause kernel
> > reboots without warning.
> >
> > To prevent similar issues in future, we should disable branch tracing
> > for the core runtime.
> >
> > Link: https://lore.kernel.org/lkml/20200517011732.GE24705@shao2-debian/
> > Reported-by: kernel test robot <rong.a.chen@intel.com>
> > Signed-off-by: Marco Elver <elver@google.com>
> > ---
> >  mm/kasan/Makefile  | 16 ++++++++--------
> >  mm/kasan/generic.c |  1 -
> >  2 files changed, 8 insertions(+), 9 deletions(-)
> >
> > diff --git a/mm/kasan/Makefile b/mm/kasan/Makefile
> > index 434d503a6525..de3121848ddf 100644
> > --- a/mm/kasan/Makefile
> > +++ b/mm/kasan/Makefile
> > @@ -15,14 +15,14 @@ CFLAGS_REMOVE_tags_report.o = $(CC_FLAGS_FTRACE)
> >
> >  # Function splitter causes unnecessary splits in __asan_load1/__asan_store1
> >  # see: https://gcc.gnu.org/bugzilla/show_bug.cgi?id=63533
> > -CFLAGS_common.o := $(call cc-option, -fno-conserve-stack -fno-stack-protector)
> > -CFLAGS_generic.o := $(call cc-option, -fno-conserve-stack -fno-stack-protector)
> > -CFLAGS_generic_report.o := $(call cc-option, -fno-conserve-stack -fno-stack-protector)
> > -CFLAGS_init.o := $(call cc-option, -fno-conserve-stack -fno-stack-protector)
> > -CFLAGS_quarantine.o := $(call cc-option, -fno-conserve-stack -fno-stack-protector)
> > -CFLAGS_report.o := $(call cc-option, -fno-conserve-stack -fno-stack-protector)
> > -CFLAGS_tags.o := $(call cc-option, -fno-conserve-stack -fno-stack-protector)
>
> mm/kasan/tags.c:15:9: warning: 'DISABLE_BRANCH_PROFILING' macro redefined [-Wmacro-redefined]
> #define DISABLE_BRANCH_PROFILING
>         ^
> <command line>:6:9: note: previous definition is here
> #define DISABLE_BRANCH_PROFILING 1
>         ^
>
> This?
>
> diff --git a/mm/kasan/tags.c b/mm/kasan/tags.c
> index 25b7734e7013..8a959fdd30e3 100644
> --- a/mm/kasan/tags.c
> +++ b/mm/kasan/tags.c
> @@ -12,7 +12,6 @@
>   */
>
>  #define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
> -#define DISABLE_BRANCH_PROFILING
>
>  #include <linux/export.h>
>  #include <linux/interrupt.h>
>

I missed this one, thanks! Added this to v2.

v2: https://lkml.kernel.org/r/20200522075207.157349-1-elver@google.com
