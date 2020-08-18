Return-Path: <SRS0=faA3=B4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B988C433E1
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Aug 2020 19:25:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D353E2075E
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Aug 2020 19:25:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="WmSIlBtC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726773AbgHRTZD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Aug 2020 15:25:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726682AbgHRTY7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Aug 2020 15:24:59 -0400
Received: from mail-pj1-x1042.google.com (mail-pj1-x1042.google.com [IPv6:2607:f8b0:4864:20::1042])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73264C061389
        for <linux-kernel@vger.kernel.org>; Tue, 18 Aug 2020 12:24:59 -0700 (PDT)
Received: by mail-pj1-x1042.google.com with SMTP id mt12so9854503pjb.4
        for <linux-kernel@vger.kernel.org>; Tue, 18 Aug 2020 12:24:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=kFeSutuGf3xw6mwr4dd80pO6ztRTSBecGX8+DwTwSdM=;
        b=WmSIlBtCjefOEEctRBNhcCgMoZXnSJx8HtD5fvZbdik6lJgW1rd13/4c/PNRJwTnpj
         Bvzg3g1m6mPzHZII1dfho8iEGO6I1+5irFAPTvBY5Fm0Pb0tomkEFPmh/Y0EqnVwsQpo
         Mhw8k5UYPf4oW++qErDVWgzPAL4CI9bdZEq4M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=kFeSutuGf3xw6mwr4dd80pO6ztRTSBecGX8+DwTwSdM=;
        b=mAIrCFiUcH62djGFOGXB7bHz/quvXDi5+KO9noCysFbRhy91CSP5Ir3iCbapB8hkV3
         pOXq8aYc1+0GGD1ShPEK2/BKvoJ0AnWCHE6L6r8TnCzmvWOJkF+p4kyatFWKFPhccTOl
         6wDClnM54QKUDONpTxmzkFv9ZnUt7HfZSBt/hZymSyDwPKUq+Caq7di/1KyaQkSwxCwV
         fvI6OIPj8gBLXubPJaNcCLdEDbjtiDJbLJ7FJqt4TyW8AXadDoILHSjRfe9j+GRyMFdM
         2pkTm2oAPRs5SM5TLGO9dsT2xygRvQuW1C9TVopvM5JEEvltTye+sKCCMSRoWCFZk0eo
         BLew==
X-Gm-Message-State: AOAM533lRG1FAHo8uA+Y46t0bqajQWm0AkC5UXNMC9qujZuE9eXIa2xP
        0DmJZtj3LDseZrK27nRwRCOG0w==
X-Google-Smtp-Source: ABdhPJw5UQYI+NLZMAZmmwgDoUzNceE5PeWTfBTX6LGMuj+LwXWQD1iB6z7sFjn8bclMN9V8uUCfIQ==
X-Received: by 2002:a17:90b:684:: with SMTP id m4mr1172948pjz.4.1597778699059;
        Tue, 18 Aug 2020 12:24:59 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id x28sm25848722pfj.73.2020.08.18.12.24.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Aug 2020 12:24:58 -0700 (PDT)
Date:   Tue, 18 Aug 2020 12:24:57 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     Masahiro Yamada <masahiroy@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Michal Marek <michal.lkml@markovi.net>,
        linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org,
        Tony Luck <tony.luck@intel.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Joe Perches <joe@perches.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Daniel Axtens <dja@axtens.net>,
        Arvind Sankar <nivedita@alum.mit.edu>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Alexandru Ardelean <alexandru.ardelean@analog.com>,
        Yury Norov <yury.norov@gmail.com>, x86@kernel.org,
        "H . Peter Anvin" <hpa@zytor.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Daniel Kiper <daniel.kiper@oracle.com>,
        Bruce Ashfield <bruce.ashfield@gmail.com>,
        Marco Elver <elver@google.com>,
        Vamshi K Sthambamkadi <vamshi.k.sthambamkadi@gmail.com>,
        Andi Kleen <ak@suse.de>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        =?iso-8859-1?Q?D=E1vid_Bolvansk=FD?= <david.bolvansky@gmail.com>,
        Eli Friedman <efriedma@quicinc.com>
Subject: Re: [PATCH 4/4] x86: don't build CONFIG_X86_32 as -ffreestanding
Message-ID: <202008181224.096C2926E@keescook>
References: <20200817220212.338670-1-ndesaulniers@google.com>
 <20200817220212.338670-5-ndesaulniers@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200817220212.338670-5-ndesaulniers@google.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 17, 2020 at 03:02:12PM -0700, Nick Desaulniers wrote:
> -ffreestanding typically inhibits "libcall optimizations" where calls to
> certain library functions can be replaced by the compiler in certain
> cases to calls to other library functions that may be more efficient.
> This can be problematic for embedded targets that don't provide full
> libc implementations.
> 
> -ffreestanding inhibits all such optimizations, which is the safe
> choice, but generally we want the optimizations that are performed. The
> Linux kernel does implement a fair amount of libc routines. Instead of
> -ffreestanding (which makes more sense in smaller images like kexec's
> purgatory image), prefer -fno-builtin-* flags to disable the compiler
> from emitting calls to functions which may not be defined.
> 
> If you see a linkage failure due to a missing symbol that's typically
> defined in a libc, and not explicitly called from the source code, then
> the compiler may have done such a transform.  You can either implement
> such a function (ie. in lib/string.c) or disable the transform outright
> via -fno-builtin-* flag (where * is the name of the library routine, ie.
> -fno-builtin-bcmp).
> 
> i386_defconfig build+boot tested with GCC and Clang. Removes a pretty
> old TODO from the codebase.
> 
> Fixes: 6edfba1b33c7 ("x86_64: Don't define string functions to builtin")
> Suggested-by: Arvind Sankar <nivedita@alum.mit.edu>
> Signed-off-by: Nick Desaulniers <ndesaulniers@google.com>

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
