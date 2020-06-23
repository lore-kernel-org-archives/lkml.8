Return-Path: <SRS0=AM+j=AE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D70DCC433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 19:07:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B223F207D0
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 19:07:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Hn1m1wMP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387418AbgFWTH0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Jun 2020 15:07:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733220AbgFWTHY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Jun 2020 15:07:24 -0400
Received: from mail-pj1-x1041.google.com (mail-pj1-x1041.google.com [IPv6:2607:f8b0:4864:20::1041])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2660C061573
        for <linux-kernel@vger.kernel.org>; Tue, 23 Jun 2020 12:07:24 -0700 (PDT)
Received: by mail-pj1-x1041.google.com with SMTP id i12so1877820pju.3
        for <linux-kernel@vger.kernel.org>; Tue, 23 Jun 2020 12:07:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=foArJGEFHbq2CUkeNohFktSwokoiUliHVNviiUOydPU=;
        b=Hn1m1wMPGdnWl5k4FyQEZrBFQ06ybgYh2uFTrWdVH3QYBCrfg1mjRiO99pTT4lC04Q
         gQnguIRYYHY9t4RgxZDwILl4CO7/D+R8cun339ZFwEo4Nfq0Fd1J//DjrWJOBxbylUKf
         aig9YYCD41mhWlJhaqBWu6k0HOyOVNJRNVB5w2XiqY7mxRU5tfymls+/bIlWHcyygwK3
         He6hDYXG7ZR8eqQULwP5K8/hOULzNT1V2tjS147QQqlu8qJEan7mrzKTs/zhJUznzm1U
         VYlfMxVq8zuOkaR5sUDmtYh2TmiMtOSckDcgiENSPLRdfbuEtMokMWJ/1cdu7chOfetG
         dtMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=foArJGEFHbq2CUkeNohFktSwokoiUliHVNviiUOydPU=;
        b=hRiwqlSlWhAuznlgW8CMg1C2U5ozACo7hjx0ED3RYCQ/xdWsAszNLKfRG0YBfccDFn
         /r7AarAvCrSqA0w9HPExp5W5IznVLSKwoQ7Qc2Hnn9JYJjrgfjC9iWXy1sqjFL2e5Org
         FxA+sB4p7KDmfmy+pQp7hg8fcmxN10IKddtPohsVDRw+ak92B/lUDNSB2oezHNgOP1zI
         sK4tfdJBSp/gH1ab8nKX35b1G3nvYsq8On+mZpNTcxWKi8DaNMO+tjlYcPjZ/e03cIxI
         svpsQJT3QhRoB30qDRw81JiwAZ/NLmZAkHDMJdpp1kY9uf09B262Uu8bxXfqFHg7BOeO
         /kOA==
X-Gm-Message-State: AOAM530ZUcpKvKeV6N1hSTPrealceeBHExdLm2+q19iyZAnZw6vYkDu4
        b7Ly4886TIxRCUn8MuLKVm1TTqzrpmhDxADIrsFgdQ==
X-Google-Smtp-Source: ABdhPJyLfjsO4Y+1LGoTdcNYGM9hDe/pQHb4MMT4+OhQzz8NOOeWgI/8Vf4ioIYigrTS4e9jw8WHmiAMtBC2SqD0sgk=
X-Received: by 2002:a17:90a:1e:: with SMTP id 30mr23051885pja.25.1592939243862;
 Tue, 23 Jun 2020 12:07:23 -0700 (PDT)
MIME-Version: 1.0
References: <20200622190149.GL32200@zn.tnic> <B4D00859-000A-4F8C-8CFB-45B9BBCCA16D@amacapital.net>
 <20200623102831.GB32590@zn.tnic> <CALCETrXfaEr9OGc5EDpxnhRZxFk5YZBBNVH-N32Eg8V8diwqXg@mail.gmail.com>
 <20200623184726.GI32590@zn.tnic>
In-Reply-To: <20200623184726.GI32590@zn.tnic>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Tue, 23 Jun 2020 12:07:13 -0700
Message-ID: <CAKwvOdnt+8RR=1JPjDNaVY8T1K7wmqFjSGM7XNUUGRb=t1hiWQ@mail.gmail.com>
Subject: Re: [PATCH 2/2] selftests/fpu: Add an FPU selftest
To:     Borislav Petkov <bp@alien8.de>
Cc:     Andy Lutomirski <luto@kernel.org>, X86 ML <x86@kernel.org>,
        jpa@kernelbug.mail.kapsi.fi, Dave Hansen <dave.hansen@intel.com>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 23, 2020 at 11:47 AM Borislav Petkov <bp@alien8.de> wrote:
>
> On Tue, Jun 23, 2020 at 11:22:53AM -0700, Andy Lutomirski wrote:
> > See that same atrocious bug report.  It's the insane interaction
> > between -mno-sse2 and -mpreferred-stack-boundary.  So you need to
> > cc-option them both?  Or just stick with a compiler version check, I
> > guess.

Yeah, IIRC, this was fixed in GCC 7.1. See also
c868868f6b6a5272350781f9a19b3a5ba1c00b02
00db297106e81770e7c4319014a67896053b5a22 (this one for details about GCC 7.1)
e8a170ff9a3576730e43c0dbdd27b7cd3dc56848

>
> Yes, it was the interaction. This below seems to work. Note the "-msse"
> in the first argument of cc-option which causes the compiler to error
> out with
>
> /dev/null:1:0: error: -mpreferred-stack-boundary=3 is not between 4 and 12
>
> Adding Nick for the clang side.
>
> @Nick: I'm simply going to add -msse2 with cc-option.

You already have a conditional below for CC_IS_GCC; just add an else
and unconditionally add -msse2.  You *should* use -msse2 for GCC 7.1+
IMO.

Note that Clang has -mstack-alignment=8 whereas GCC has
-mpreferred-stack-boundary=3.  (Clang is a value in bytes, GCC is 2^X
bytes)

I recommend a version check for GCC < 7.1, or simply disabling the
self test if the version of GCC used is older than 7.1.  Mixing stack
alignments is a recipe for GPF with SSE when the caller has a smaller
stack alignment than the callee and is also unspecified behavior.  It
might work today, but as soon as someone perturbs the stack of the
call chain, you'll likely see a GPF due to non-16B aligned stack when
using SSE with stack operands in the caller.

>
> Anyway, lemme test this thing a bit more.
>
> Thx.
>
> ---
>
> # CFLAGS for compiling floating point code inside the kernel. x86/Makefile turns
> # off the generation of FPU/SSE* instructions for kernel proper but FPU_FLAGS
> # get appended last to CFLAGS and thus override those previous compiler options.
> #
> FPU_CFLAGS := -mhard-float -msse
> FPU_CFLAGS += $(call cc-option,-msse2,)
> ifdef CONFIG_CC_IS_GCC
> # Stack alignment mismatch, proceed with caution.
> # GCC < 7.1 cannot compile code using `double` and -mpreferred-stack-boundary=3
> # (8B stack alignment).

^ looks familiar ;)

> # See https://gcc.gnu.org/bugzilla/show_bug.cgi?id=53383
> FPU_CFLAGS += $(call cc-option,-msse -mpreferred-stack-boundary=3,-mpreferred-stack-boundary=4)
> endif
>
> obj-$(CONFIG_TEST_FPU) += test_fpu.o
> CFLAGS_test_fpu.o += $(FPU_CFLAGS)
>
> --
> Regards/Gruss,
>     Boris.
>
> https://people.kernel.org/tglx/notes-about-netiquette



-- 
Thanks,
~Nick Desaulniers
