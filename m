Return-Path: <SRS0=ysYr=B3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A45F5C433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Aug 2020 22:45:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7D0AD2063A
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Aug 2020 22:45:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="fFw7iaFI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730830AbgHQWpP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Aug 2020 18:45:15 -0400
Received: from terminus.zytor.com ([198.137.202.136]:48771 "EHLO
        mail.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730732AbgHQWpK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Aug 2020 18:45:10 -0400
Received: from hanvin-mobl2.amr.corp.intel.com (jfdmzpr03-ext.jf.intel.com [134.134.139.72])
        (authenticated bits=0)
        by mail.zytor.com (8.15.2/8.15.2) with ESMTPSA id 07HMiW422418579
        (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NO);
        Mon, 17 Aug 2020 15:44:32 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.zytor.com 07HMiW422418579
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2020072401; t=1597704275;
        bh=UcsjupZ0JA2RpPNCd/O00y25ozkP4PEzUv+SeMit95Y=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=fFw7iaFIjOTNkyvMiTi6MGZ1QKRqloYm27Hjeqslbjuje3JHcveUFWxZ13s0xYxGL
         Pq1ExKfPYkv2sexFEJB1hIocLvmRNjVJtwloT35gujDTd+OXSRHE1cnLSD9IYBA9Vu
         fzJXyAfOqRLkIZ/xT9bMfg9qbVD/DSfoEC4Z7LDmT07itHKLK5rdn0/7/vG+vwrjtz
         DFO/Zq97GNALaq2XrP26/hUvUSLd9XpcnOAClKJ13Cd15ifmv/qAT1F7rtvPbSx53E
         zHhqVOWOP6IWH5Hvg+pP/m4sJM3HmN83qsYrwv0pLaMkD+Ei3kbgruX0KTVvmZxPcG
         iyP2A+4BGi7gg==
Subject: Re: [PATCH 0/4] -ffreestanding/-fno-builtin-* patches
To:     Nick Desaulniers <ndesaulniers@google.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>
Cc:     Michal Marek <michal.lkml@markovi.net>,
        linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org,
        Kees Cook <keescook@chromium.org>,
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
        Ard Biesheuvel <ardb@kernel.org>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Daniel Kiper <daniel.kiper@oracle.com>,
        Bruce Ashfield <bruce.ashfield@gmail.com>,
        Marco Elver <elver@google.com>,
        Vamshi K Sthambamkadi <vamshi.k.sthambamkadi@gmail.com>,
        Andi Kleen <ak@suse.de>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        =?UTF-8?B?RMOhdmlkIEJvbHZhbnNrw70=?= <david.bolvansky@gmail.com>,
        Eli Friedman <efriedma@quicinc.com>
References: <20200817220212.338670-1-ndesaulniers@google.com>
From:   "H. Peter Anvin" <hpa@zytor.com>
Message-ID: <fae91af3-4e08-a929-e5c3-25271ad7324b@zytor.com>
Date:   Mon, 17 Aug 2020 15:44:31 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <20200817220212.338670-1-ndesaulniers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020-08-17 15:02, Nick Desaulniers wrote:
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

This is arguably exactly the wrong way around.

The way this *should* be done is by opt-in, not opt-out, which by almost
definition ends up being a game of whack-a-mole, like in this case
stpcpy(). Furthermore, it is unlikely that people will remember what
options to flip when and if stpcpy() happens to be implemented in the
kernel.

The problem here is twofold:

1. The user would be expected to know what kind of the optimizations the
compiler can do on what function, which is private knowledge to the
compiler.

2. The only way to override -fno-builtin is by a header file with macros
overriding the function names with __builtin, but that doesn't tell the
compiler proper anything about the execution environment.

So the Right Thing is for the compiler authors to change the way
-ffreestanding works.  -ffreestanding means, by definition, that there
are no library calls (other than libgcc or whatever else is supplied
with the compiler) that the compiler can call. That is currently an
all-or-nothing choice, or at least one choice per C standard implemented.

Instead, a compile job with -ffreestanding should be able to provide a
list of standard C functions that the compiler may call, and thus the
compiler actually can do the right thing depending on which exact
functions it would consider calling. This list is probably most easily
supplied in the form of a header file with #pragma directives.

	-hpa


