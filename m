Return-Path: <SRS0=rtH4=AH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97A26C433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jun 2020 20:18:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7290E20720
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jun 2020 20:18:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="FrkG7xHD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725957AbgFZUSt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Jun 2020 16:18:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725780AbgFZUSt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Jun 2020 16:18:49 -0400
Received: from mail-pf1-x444.google.com (mail-pf1-x444.google.com [IPv6:2607:f8b0:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B536C03E979
        for <linux-kernel@vger.kernel.org>; Fri, 26 Jun 2020 13:18:49 -0700 (PDT)
Received: by mail-pf1-x444.google.com with SMTP id f9so5104975pfn.0
        for <linux-kernel@vger.kernel.org>; Fri, 26 Jun 2020 13:18:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=/DjWbdB6QR6F3h1vBMYs8FI30xxDOIUG4fAHYu8nECU=;
        b=FrkG7xHDJ0hpKYFzhPGuCwru1szypTYOGi5hD5lbAfuGgT1pRq6kqZRC1RYyGXQ4Cx
         dBBF0DZ0m//3+/ZhtdALlqhCmQJr+DsmxShR47yHKzFznf60VL/beb/6bYpfKhHVdEyz
         yh40AuQXBaVxjsQclGj9K/76x2HjcqutOZc2Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=/DjWbdB6QR6F3h1vBMYs8FI30xxDOIUG4fAHYu8nECU=;
        b=paqyWCiuq8pPumeUkvsAnLtHOM6kI373p4z75KUtPNkUTNPRcZukysMPjKiwJHXpX1
         oLVuZgNu2BnCxPJ3nKQuyDCbFL1EQ0gR1wVWnI3cuHqlLsMYm6mzHkCdQo1y9wScSXts
         Q41LFLmjYyBFxQ0HRBcOLbWgYjiF2cubMDGCuBlxFlZrtX6560W+LxwqwJnMz2ByB2ml
         M5iOdJkdrrFzr4/EJxEPKmiNwDfFZTbtp1I9Ge/rFoo838THt8MDyexvr6WwZ6nMJTYK
         D/lsGoZZUBt0PaM50U3ovqx33Xbl3LA2wyhdjtslBrQmytdaF3L1rIWyBB1h815CICI1
         DNSw==
X-Gm-Message-State: AOAM532FOOeA0QuxNdUPHn/MDuHD8W9kepCHZevGQS/StrhT6Qeqvn5A
        WdjhnKO6Hiuz8Yjzr68GBtyrSw==
X-Google-Smtp-Source: ABdhPJwYJkgs+qfqxsrtQQlApXR25CpCAIB9YF/4D3mpyg8KTrXfQyU2bY8skxNl8rMJC5c6opRIug==
X-Received: by 2002:a62:1ad6:: with SMTP id a205mr4256254pfa.109.1593202728953;
        Fri, 26 Jun 2020 13:18:48 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id c141sm11968090pfc.167.2020.06.26.13.18.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Jun 2020 13:18:47 -0700 (PDT)
Date:   Fri, 26 Jun 2020 13:18:46 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Masahiro Yamada <masahiroy@kernel.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>, X86 ML <x86@kernel.org>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] kbuild: Provide way to actually disable stack protector
Message-ID: <202006261314.B6856AA96@keescook>
References: <202006221201.3641ED037E@keescook>
 <CAK7LNAQL=XF+xvsRNTEGXtY7J-fx5FJKpMuScoxLt8SDKGB3_Q@mail.gmail.com>
 <202006222234.FBCEAD7F@keescook>
 <CAK7LNARRU7j_aSgZreuR-jyFYAipaJwZjUwzmE9RcohgKJvS8w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAK7LNARRU7j_aSgZreuR-jyFYAipaJwZjUwzmE9RcohgKJvS8w@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jun 27, 2020 at 04:04:33AM +0900, Masahiro Yamada wrote:
> On Tue, Jun 23, 2020 at 2:37 PM Kees Cook <keescook@chromium.org> wrote:
> >
> > On Tue, Jun 23, 2020 at 11:33:53AM +0900, Masahiro Yamada wrote:
> > > Is it OK to not patch syscall_x32.c ?
> >
> > Good question. Peter? (It seems all the syscall_*.c files are just a
> > table, not code -- why do they need any instrumentation changes?)

I'd still like to know the answer to this one...

> Is it useful when we know
> DISABLE_STACKPROTECTOR = -fno-stack-protector  ?

I'm fine with that. My point was the using _REMOVE isn't going to work
for some compiler builds.

> I'd rather want to apply this patch
> https://patchwork.kernel.org/patch/11628493/
> and hard-code -fno-stack-protector where necessary.

That's fine. I will send a separate fix for arch/x86/entry/Makefile.

> cc-flags-y comes after KBUILD_CFLAGS
> so that -fno-stack-protector can negate -fstack-protector(-strong)

Okay, good.

-- 
Kees Cook
