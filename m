Return-Path: <SRS0=faA3=B4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.4 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 916C6C433E1
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Aug 2020 23:00:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 672FA20789
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Aug 2020 23:00:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="oejoDBdo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727079AbgHRXAD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Aug 2020 19:00:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726799AbgHRW76 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Aug 2020 18:59:58 -0400
Received: from mail-pj1-x1043.google.com (mail-pj1-x1043.google.com [IPv6:2607:f8b0:4864:20::1043])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F079C061389
        for <linux-kernel@vger.kernel.org>; Tue, 18 Aug 2020 15:59:58 -0700 (PDT)
Received: by mail-pj1-x1043.google.com with SMTP id ep8so210850pjb.3
        for <linux-kernel@vger.kernel.org>; Tue, 18 Aug 2020 15:59:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=J2pGygoF7KWIJaR/BRx/jtL9q1tfpvhnVW6lipaKLMs=;
        b=oejoDBdod/XT+qS47scwauhM7mYjpU0xiMBgXoVFwRvfIQGA4CTvTu3fRHibAUtHYd
         5ZnK/LUTYhDUsPwtLNERJIXEuV0Gke43W8JfC95l4XD/oiDTEkMVCtxPinAqBBD+m3l3
         kp6gsNCvw90h/jV0F+nSQNqISP54PMPFFV/fi1ST66IQrnHoqICZjF+ipxb6IoSisNRo
         ZYZQ+zVDIB8CxkfWs4lnk/xItWAQAOdPXOv9kfM63gpchjZoijeoA4gPkuLlWryvirhb
         pq1hYuuByYHQeONpW24gozAzS8d2sUaS4pE2K3iUlSOyFrqcAl69HC8XD695CdRECSmP
         UIuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=J2pGygoF7KWIJaR/BRx/jtL9q1tfpvhnVW6lipaKLMs=;
        b=k3LW+wwZakM0oNC0y3pJ+xtP6GT5pIQBx6lKUWFmqEe+8CT4y0Me99bBwH+vovwy1N
         Irxf4ILJbXCle1cdVSdcodFYSoOLYgiD/NGwlFLEijEhB76cw4k+99YYqrNIhdcub9qS
         tydcyqqHx6e1Zka7wYi60zVCaKAPfoMaMD7Hi+Ethv5YG+1vWpVs/PDU0UQFv3yeUxJP
         Uj1+cUrdeU6z5JRqUkkn6cRhZBqR8wtYXGNF0nNtQ7qAn9V9+gF/mrN0Hcf0gIRONK3Q
         svLD458Jeze4lC7UvrOmxHe3Wl/8JrtKK4EgzIsC4RGtpPn0+fgxPVupN/lsCkhGnJyw
         b09Q==
X-Gm-Message-State: AOAM533e7TkId47i2X9s1ZiXo3U5nr2gjmrNFszeDw/pGgcPc1/UN6D8
        TFTCHsJW5mY7ceIjoMGel/OVUeTfm6CX6W9CLvAPRQ==
X-Google-Smtp-Source: ABdhPJwyeBQmyXJbjojIwiTBW8Z6+brjMwpfKPi5od1b5IJVm8nNGkeI9fjV9jSy6PuHYv8OEzPr4TFc8zMzEV6noQI=
X-Received: by 2002:a17:902:7c8b:: with SMTP id y11mr16352038pll.119.1597791597450;
 Tue, 18 Aug 2020 15:59:57 -0700 (PDT)
MIME-Version: 1.0
References: <20200817220212.338670-1-ndesaulniers@google.com> <20200818222542.GA3254379@rani.riverdale.lan>
In-Reply-To: <20200818222542.GA3254379@rani.riverdale.lan>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Tue, 18 Aug 2020 15:59:45 -0700
Message-ID: <CAKwvOdmfiD1TNqRvFuX07BqonYzh1eKFE9mFmOpaSyrbR0d5Lw@mail.gmail.com>
Subject: Re: [PATCH 0/4] -ffreestanding/-fno-builtin-* patches
To:     Arvind Sankar <nivedita@alum.mit.edu>,
        Eli Friedman <efriedma@quicinc.com>
Cc:     Masahiro Yamada <masahiroy@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Michal Marek <michal.lkml@markovi.net>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Tony Luck <tony.luck@intel.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Joe Perches <joe@perches.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Daniel Axtens <dja@axtens.net>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Alexandru Ardelean <alexandru.ardelean@analog.com>,
        Yury Norov <yury.norov@gmail.com>,
        "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>,
        "H . Peter Anvin" <hpa@zytor.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Daniel Kiper <daniel.kiper@oracle.com>,
        Bruce Ashfield <bruce.ashfield@gmail.com>,
        Marco Elver <elver@google.com>,
        Vamshi K Sthambamkadi <vamshi.k.sthambamkadi@gmail.com>,
        Andi Kleen <ak@suse.de>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        =?UTF-8?B?RMOhdmlkIEJvbHZhbnNrw70=?= <david.bolvansky@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 18, 2020 at 3:25 PM Arvind Sankar <nivedita@alum.mit.edu> wrote:
>
> Another thing that needs to be fixed is that at least lib/string.c needs
> to be compiled with -ffreestanding.
>
> gcc-10 optimizes the generic memset implementation in there into a call
> to memset. Now that's on x86 which doesn't use the generic
> implementation, but this is just waiting to bite us.
>
> https://godbolt.org/z/6EhG15

I'll let you send the patch for that this time.  (It's too bad godbolt
doesn't have newer versions of GCC for cross compilation...cant test
aarch64 gcc-10, for example.)  It would be interesting for sure to see
resulting differences in disassembly observed in lib/string.o with
-ffreestanding.

But, oof, that's not good.  Certainly impressive and powerful loop
idiom recognition, but wouldn't you consider it a bug that this
optimization should probably first check that it's not replacing part
of a loop with a potentially recursive call to itself?

Admittedly, we've had the same shenanigans with memcpy implemented in
terms of calls to __builtin_memcpy being lowered to infinitely
recursive calls...which feels like the same kind of bug.  ("You wanted
infinite recursion in the kexec purgatory image, right?" "No,
compiler, I did not.")  example: https://godbolt.org/z/MzrTaM
(probably should fix this in both implementations; at the least I feel
like Clang's -Winfinite-recursion should try to help us out here).

Feels almost like it may be difficult to provide an implementation of
memset without stepping on a landmine.  One thing I'd be curious about
is whether all of lib/string.c would need -ffreestanding, or if you
could move just memset to its own TU then use -ffreestanding on that.
A free standing environment must always provide a core set of
functions like memset, memcpy, memcmp, memmove, according to
https://gcc.gnu.org/onlinedocs/gcc/Standards.html.  Maybe those four
should be in a separate TU compiled as -ffreestanding, so that they
can never be lowered to calls to themselves (potentially infinitely
recursive)?
-- 
Thanks,
~Nick Desaulniers
