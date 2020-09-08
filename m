Return-Path: <SRS0=o+hd=CR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EAE58C433E2
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Sep 2020 17:24:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B83F020768
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Sep 2020 17:24:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="ICQDvF+r"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732002AbgIHRYb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Sep 2020 13:24:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731778AbgIHRVf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Sep 2020 13:21:35 -0400
Received: from mail-pj1-x1041.google.com (mail-pj1-x1041.google.com [IPv6:2607:f8b0:4864:20::1041])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A86C7C061573
        for <linux-kernel@vger.kernel.org>; Tue,  8 Sep 2020 10:21:34 -0700 (PDT)
Received: by mail-pj1-x1041.google.com with SMTP id b17so67819pji.1
        for <linux-kernel@vger.kernel.org>; Tue, 08 Sep 2020 10:21:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=6Hzyipkee9UZGhxSyMM2F47dHct0fHx90e1igtsMR4E=;
        b=ICQDvF+rwQXw9SGy3OdF3Xe7X+JJXBClYZolg9y7azAxjM9u12FMxe1tgzwLDBGXra
         RcnF7npll1c3cLCooYxBYa2hGL9tW7D0T9RWJ6sVWa4vP6UMRy+BxSaH/PSGDQeebuN7
         ctcRWFqccr4xPAMN0LHP8f07qDFD+6RScmbbo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=6Hzyipkee9UZGhxSyMM2F47dHct0fHx90e1igtsMR4E=;
        b=FknVlkuJO6W5qOsn4K8KGqCgKu9XyGtPPyXWjbz1AoBRN+sIevYwReYvBxhyRJpMSw
         w5ZKP2lDmOXgHjkoQDky/JwMsBtznEcngLzI3/RCgSCrT1IJYkIwhS3IJs0Ip6NG/IxI
         sdfF+iSsz3CP53vIBx9OEOTpx6F6JM99nu7kyHHZUuB4TXist1g7BdFdnr8FsJVNsxos
         WckuiIdWmAg+f+DozNw+eeGG6PC9wJLMVe7oNQUSKUAIPpc8eLmgJ0HeOM7CWwaPQZkB
         l/NwSkntER9rsPqhgglTMVlnhafKIMK95Q5pqPUvp91sU13NFaK3JMMLhVAJxlhOxJPL
         pNaQ==
X-Gm-Message-State: AOAM531LbNwQjLFDcv0wB8bG0ztTaHUILc7e/CXEMld5f+T8jNsFaumD
        uEcNIjAH9o6Cx8UwxmlPTgA3tQ==
X-Google-Smtp-Source: ABdhPJwSh8nnIY0DMAgQFgjrXSr6HtOzK23wIPkfujtWaueHiCI0KrW9jJaoGTUWHiEyVtRDHNt0hQ==
X-Received: by 2002:a17:90b:1216:: with SMTP id gl22mr120500pjb.121.1599585694210;
        Tue, 08 Sep 2020 10:21:34 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id c1sm26685pfi.136.2020.09.08.10.21.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Sep 2020 10:21:33 -0700 (PDT)
Date:   Tue, 8 Sep 2020 10:21:32 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Marco Elver <elver@google.com>
Cc:     Arvind Sankar <nivedita@alum.mit.edu>,
        the arch/x86 maintainers <x86@kernel.org>,
        kasan-dev <kasan-dev@googlegroups.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Andrey Konovalov <andreyknvl@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Alexander Potapenko <glider@google.com>
Subject: Re: [RFC PATCH 1/2] lib/string: Disable instrumentation
Message-ID: <202009081021.8E5957A1F@keescook>
References: <20200905222323.1408968-1-nivedita@alum.mit.edu>
 <20200905222323.1408968-2-nivedita@alum.mit.edu>
 <CANpmjNMnU03M0UJiLaHPkRipDuOZht0c9S3d40ZupQVNZLR+RA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CANpmjNMnU03M0UJiLaHPkRipDuOZht0c9S3d40ZupQVNZLR+RA@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 08, 2020 at 11:39:11AM +0200, Marco Elver wrote:
> On Sun, 6 Sep 2020 at 00:23, Arvind Sankar <nivedita@alum.mit.edu> wrote:
> >
> > String functions can be useful in early boot, but using instrumented
> > versions can be problematic: eg on x86, some of the early boot code is
> > executing out of an identity mapping rather than the kernel virtual
> > addresses. Accessing any global variables at this point will lead to a
> > crash.
> >
> > Tracing and KCOV are already disabled, and CONFIG_AMD_MEM_ENCRYPT will
> > additionally disable KASAN and stack protector.
> >
> > Additionally disable GCOV, UBSAN, KCSAN, STACKLEAK_PLUGIN and branch
> > profiling, and make it unconditional to allow safe use of string
> > functions.
> >
> > Signed-off-by: Arvind Sankar <nivedita@alum.mit.edu>
> > ---
> >  lib/Makefile | 11 +++++++----
> >  1 file changed, 7 insertions(+), 4 deletions(-)
> >
> > diff --git a/lib/Makefile b/lib/Makefile
> > index a4a4c6864f51..5e421769bbc6 100644
> > --- a/lib/Makefile
> > +++ b/lib/Makefile
> > @@ -8,7 +8,6 @@ ccflags-remove-$(CONFIG_FUNCTION_TRACER) += $(CC_FLAGS_FTRACE)
> >  # These files are disabled because they produce lots of non-interesting and/or
> >  # flaky coverage that is not a function of syscall inputs. For example,
> >  # rbtree can be global and individual rotations don't correlate with inputs.
> > -KCOV_INSTRUMENT_string.o := n
> >  KCOV_INSTRUMENT_rbtree.o := n
> >  KCOV_INSTRUMENT_list_debug.o := n
> >  KCOV_INSTRUMENT_debugobjects.o := n
> > @@ -20,12 +19,16 @@ KCOV_INSTRUMENT_fault-inject.o := n
> >  # them into calls to themselves.
> >  CFLAGS_string.o := -ffreestanding
> >
> > -# Early boot use of cmdline, don't instrument it
> > -ifdef CONFIG_AMD_MEM_ENCRYPT
> > +# Early boot use of string functions, disable instrumentation
> > +GCOV_PROFILE_string.o := n
> > +KCOV_INSTRUMENT_string.o := n
> >  KASAN_SANITIZE_string.o := n
> > +UBSAN_SANITIZE_string.o := n
> > +KCSAN_SANITIZE_string.o := n
> 
> Ouch.
> 
> We have found manifestations of bugs in lib/string.c functions, e.g.:
>   https://groups.google.com/forum/#!msg/syzkaller-bugs/atbKWcFqE9s/x7AtoVoBAgAJ
>   https://groups.google.com/forum/#!msg/syzkaller-bugs/iGBUm-FDhkM/chl05uEgBAAJ
> 
> Is there any way this can be avoided?

Agreed: I would like to keep this instrumentation; it's a common place
to find bugs, security issues, etc.

-- 
Kees Cook
