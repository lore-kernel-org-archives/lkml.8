Return-Path: <SRS0=vQOp=CM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B319C433E9
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Sep 2020 17:28:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 354F220716
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Sep 2020 17:28:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RkokC5+P"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728677AbgICR2z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Sep 2020 13:28:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726025AbgICR2w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Sep 2020 13:28:52 -0400
Received: from mail-qv1-xf43.google.com (mail-qv1-xf43.google.com [IPv6:2607:f8b0:4864:20::f43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22BC9C061244
        for <linux-kernel@vger.kernel.org>; Thu,  3 Sep 2020 10:28:51 -0700 (PDT)
Received: by mail-qv1-xf43.google.com with SMTP id h1so1679071qvo.9
        for <linux-kernel@vger.kernel.org>; Thu, 03 Sep 2020 10:28:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=8bZzDR/YHw07CdeBNRtY2rjnE2ZQYtI7F2JutfxZiS8=;
        b=RkokC5+PPGG1dRii6Zvc5xrGwiwUEgGscZApE/8av5PsVuhN5JZTK53A6UbH8JmgZ1
         G7zovtq49nlqn8mycdQDi4bFbvt9moQE8JpmxVTaSSAuBXLTJpDu2XrNxgzCA5SRO4ai
         Gm682I9EauQ8wTqFD34CyR8nBS60L6OtX1NrRGf8u5L0lXjjQNijWIWaXjVS1kLbAO2a
         Y+F5AlvRTVsaBuGxAlH4tMCT7NBdqpHab/UqiIDF9geqSWuJ9lT0yf+nU0dCMLd0tBUL
         a1X8OxhoVgeLLEiuX2I7kPAUibRFuJj6TcyGnsssIe8AKjeCz5syu+y2si7m6mmHUJYR
         zT1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=8bZzDR/YHw07CdeBNRtY2rjnE2ZQYtI7F2JutfxZiS8=;
        b=F472+sNkdsynnN6tXNNdJwnwvzmp/jPp0Xvq69/bH0w31iye2JgErKuzJKHwWeWDI8
         tpENNd5ILG1YO2PjmvYlnD+PtMdMwdJJt5TuOMmILOTTS4QbXXt/7zJ0PFfeU5kXBc9B
         CD4rU2bFS+LOilzavHOeZkjTON5fWAwQhJgsh0j0MLxRM6mzs/JZMAU1CYKS1XxsZBT2
         vtPXJamafBm2r4ixyov46J/AWfMpXgT33TuVRGpjgYowqkQwuI5Ir/EWFO+S3mUNOMfe
         rwlH5HO0xvMf/sMCoIMoi/xIj1fMteMRTDcSI+0zr4WkdGEwJbVePaY9LU0bohYHbAO+
         1wNQ==
X-Gm-Message-State: AOAM530RiDuA7BUqiuLJ457uxer+nTdAp8fq3ldX09ETyPwru2SNqUGV
        sWwIIeDPTxxBe8R1gfcmT28=
X-Google-Smtp-Source: ABdhPJyBej8f8Uu40qUTrxGaFJR98LaNTuwXT7yAcSFTy2UkOXNE39aZ4wTLhrb1crsKnIu9BSSzDQ==
X-Received: by 2002:a0c:c98d:: with SMTP id b13mr2731192qvk.1.1599154130174;
        Thu, 03 Sep 2020 10:28:50 -0700 (PDT)
Received: from ubuntu-n2-xlarge-x86 ([2604:1380:45d1:2600::1])
        by smtp.gmail.com with ESMTPSA id 64sm2698328qko.117.2020.09.03.10.28.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Sep 2020 10:28:49 -0700 (PDT)
Date:   Thu, 3 Sep 2020 10:28:47 -0700
From:   Nathan Chancellor <natechancellor@gmail.com>
To:     Sedat Dilek <sedat.dilek@gmail.com>
Cc:     Nick Desaulniers <ndesaulniers@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Kees Cook <keescook@chromium.org>,
        Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
        Marco Elver <elver@google.com>,
        Andrey Konovalov <andreyknvl@google.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Clang-Built-Linux ML <clang-built-linux@googlegroups.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Alexei Starovoitov <ast@kernel.org>,
        Will Deacon <will@kernel.org>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 0/7] set clang minimum version to 10.0.1
Message-ID: <20200903172847.GA1928336@ubuntu-n2-xlarge-x86>
References: <20200902225911.209899-1-ndesaulniers@google.com>
 <CA+icZUXCLyGmYCnHSBJ+8s5QdbPRr+fsfpW43M7pYFEDFOOdJA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+icZUXCLyGmYCnHSBJ+8s5QdbPRr+fsfpW43M7pYFEDFOOdJA@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 03, 2020 at 04:06:43PM +0200, Sedat Dilek wrote:
> On Thu, Sep 3, 2020 at 12:59 AM Nick Desaulniers
> <ndesaulniers@google.com> wrote:
> >
> > Adds a compile time #error to compiler-clang.h setting the effective
> > minimum supported version to clang 10.0.1. A separate patch has already
> > been picked up into the Documentation/ tree also confirming the version.
> >
> > Next are a series of reverts. One for 32b arm is a partial revert.
> >
> > Then Marco suggested fixes to KASAN docs.
> >
> > Finally, improve the warning for GCC too as per Kees.
> >
> > Patches after 001 are new for v2.
> >
> > v3 just collects tags and fixes typos in a few commit messages.
> >
> 
> Through which Git tree is this patch-series going through?
> Do the new LLVM/Clang maintainers already have their own Git tree @
> git.kernel.org?

I would say this should go through either Andrew or Masahiro. We do not
have a formal git tree plus I believe there are other things that need
to happen before we can push stuff to Linus.

> Is this patch-series material for Linux v5.9 or v5.10?
> 
> - Sedat -

Given that this is not a regression or a bug fix, it should go into 5.10
in my opinion.

Cheers,
Nathan
