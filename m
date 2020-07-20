Return-Path: <SRS0=bl3x=A7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-22.6 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DBDA0C433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jul 2020 19:28:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B15BF20773
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jul 2020 19:28:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="q87Rwtko"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730572AbgGTT2O (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Jul 2020 15:28:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729092AbgGTT2N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jul 2020 15:28:13 -0400
Received: from mail-pg1-x542.google.com (mail-pg1-x542.google.com [IPv6:2607:f8b0:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4344FC0619D2
        for <linux-kernel@vger.kernel.org>; Mon, 20 Jul 2020 12:28:13 -0700 (PDT)
Received: by mail-pg1-x542.google.com with SMTP id n5so10761296pgf.7
        for <linux-kernel@vger.kernel.org>; Mon, 20 Jul 2020 12:28:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=qQtHutRKhkC0xmSMdXzm89kbzbrbZVJj4BoYmmxXY+o=;
        b=q87Rwtko9DSoJjwynLK7R/BbSPDvRnR8BKOcJLnYSKi7HHsC+P9x24MHhIT+0PEKHU
         tSHzBU5D6A+frU+7xj6EuBPWB12k7JDwWjz/R7tUIRNBOCKb+po5KsBqZPGKDStJLAIy
         00BUhLT04M2DAcC8Mk2n74OuakYxuGpMPQrtIE6DHVJHgm3923LLTaCmGLJo6IdVkYqU
         lUQZVxs53zif0UeVOU+lNbuqUdduUfD/FvkALom69lTYsYXhEEni3R6gG9FJrIGnOYI2
         J31lRErv7EtFsAY/Ew84JV3Jx5UUUC98nd5dc79NTQZr6aHijOoCgm1MPDRRbnDP9NRU
         xwkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=qQtHutRKhkC0xmSMdXzm89kbzbrbZVJj4BoYmmxXY+o=;
        b=jWhWSCCbHWZyghuMK2n7/Irtf87CQaelG6o3d1LNNWZd+WbD7EWupGeV+ER9kmgHyu
         yiypRbaPnlh5kjhWvKqLqbTjoQmOrhPTSaSKZ6gjwphJaCJof6CHCFrQ+hmaBkhrXvTr
         jwEQvcuwb27rY6ip4Qzq/cLqXRrwWVTnDYSTkFHbgl0Az9YH7ZpAPgl7TuS62PxhqfUW
         GS/tB4ty93gzBHZ4qsiazYd2wPRTLYvkBs5T13tp/gHAHgh2JysZO/8uATTBI3RKyRsQ
         x+kzTfn/215BDlGYBD73x6JDWRoQ1gQnlT5qlyRYNVtFFcZmQU43TUE/fQJOXMKPLuUY
         NFsw==
X-Gm-Message-State: AOAM5338rDel+TXmkYo6X3tOBqjwHYLbsmauE5Sq4lw9r7PJVxqCbbr8
        0XXE732zqUi86rI0Wn9MIyzHO9Wyw+xqi5GVeGOtyA==
X-Google-Smtp-Source: ABdhPJzCsfFoC2NdvIYvDcuiG8wlDUFE5SqYwVslyIPvcRoGFzLwaEG/QUA8VizT6cx8yciLMPp4G+3FiFH7q6FVbH4=
X-Received: by 2002:a62:86cc:: with SMTP id x195mr20778276pfd.39.1595273292322;
 Mon, 20 Jul 2020 12:28:12 -0700 (PDT)
MIME-Version: 1.0
References: <20200720181237.3015826-1-maskray@google.com> <20200720181646.GA6160@ubuntu-n2-xlarge-x86>
In-Reply-To: <20200720181646.GA6160@ubuntu-n2-xlarge-x86>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Mon, 20 Jul 2020 12:28:01 -0700
Message-ID: <CAKwvOd=tF7j-mTHMKvvmRkxjFZ-a2ah2+4zLY527WtebZzum8Q@mail.gmail.com>
Subject: Re: [PATCH] Makefile: Fix GCC_TOOLCHAIN_DIR prefix for Clang cross compilation
To:     Fangrui Song <maskray@google.com>
Cc:     Masahiro Yamada <masahiroy@kernel.org>,
        Michal Marek <michal.lkml@markovi.net>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        Nathan Chancellor <natechancellor@gmail.com>,
        Manoj Gupta <manojgupta@google.com>,
        Jian Cai <jiancai@google.com>, Bill Wendling <morbo@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 20, 2020 at 11:16 AM Nathan Chancellor
<natechancellor@gmail.com> wrote:
>
> On Mon, Jul 20, 2020 at 11:12:22AM -0700, Fangrui Song wrote:
> > When CROSS_COMPILE is set (e.g. aarch64-linux-gnu-), if
> > $(CROSS_COMPILE)elfedit is found at /usr/bin/aarch64-linux-gnu-,
> > GCC_TOOLCHAIN_DIR will be set to /usr/bin/.  --prefix= will be set to
> > /usr/bin/ and Clang as of 11 will search for both
> > $(prefix)aarch64-linux-gnu-$needle and $(prefix)$needle.
> >
> > GCC searchs for $(prefix)aarch64-linux-gnu/$version/$needle,
> > $(prefix)aarch64-linux-gnu/$needle and $(prefix)$needle. In practice,
> > $(prefix)aarch64-linux-gnu/$needle rarely contains executables.
> >
> > To better model how GCC's -B/--prefix takes in effect in practice, newer
> > Clang only searches for $(prefix)$needle and for example it will find

"newer Clang" requires the reader to recall that "Clang as of 11" was
the previous frame of reference. I think it would be clearer to:
1. call of clang-12 as having a difference in behavior.
2. explicitly link to the commit, ie:
Link: https://github.com/llvm/llvm-project/commit/3452a0d8c17f7166f479706b293caf6ac76ffd90

> > /usr/bin/as instead of /usr/bin/aarch64-linux-gnu-as.

That's a common source of pain (for example, when cross compiling
without having the proper cross binutils installed, it's common to get
spooky errors about unsupported configs or host binutils not
recognizing flags specific to cross building).

/usr/bin/as: unrecognized option '-EL'

being the most common.  So in that case, I'm actually very happy with
the llvm change if it solves that particularly common pain point.

> >
> > Set --prefix= to $(GCC_TOOLCHAIN_DIR)$(CROSS_COMPILE)
> > (/usr/bin/aarch64-linux-gnu-) so that newer Clang can find the
> > appropriate cross compiling GNU as (when -no-integrated-as is in
> > effect).
> >
> > Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
> > Signed-off-by: Fangrui Song <maskray@google.com>
> > Link: https://github.com/ClangBuiltLinux/linux/issues/1099
>
> Sorry that I did not pay attention before but this needs
>
> Cc: stable@vger.kernel.org

Agreed.  This change to llvm will blow up all of our CI jobs that
cross compile if not backported to stable.

>
> in the body so that it gets automatically backported into all of our
> stable branches. I am not sure if Masahiro is okay with adding that
> after the fact or if he will want a v2.
>
> I am fine with having my signed-off-by on the patch but I did not really
> do much :) I am fine with having that downgraded to

Not a big deal, but there's only really two cases I can think of where
it's appropriate to attach someone else's "SOB" to a patch:
1. It's their patch that you're resending on their behalf, possibly as
part of a larger series.
2. You're a maintainer, and...well I guess that's also case 1 above.

Reported-by is more appropriate, and you can include the tags
collected from this thread.  Please ping me internally for help
sending a v2, if needed.

>
> Reviewed-by: Nathan Chancellor <natechancellor@gmail.com>
> Tested-by: Nathan Chancellor <natechancellor@gmail.com>

I tested with this llvm pre- and post-
https://github.com/llvm/llvm-project/commit/3452a0d8c17f7166f479706b293caf6ac76ffd90.
I also tested downstream Android kernel builds with
3452a0d8c17f7166f479706b293caf6ac76ffd90. Builds that don't make use
of CROSS_COMPILE (native host targets) are obviously unaffected.  We
might see this issue pop up a few more times internally if the patch
isn't picked up by stable, or if those downstream kernel trees don't
rebase on stable kernel trees as often as they refresh their
toolchain.

Tested-by: Nick Desaulniers <ndesaulniers@google.com>

>
> if people find it odd.
>
> Thanks for sending this along!
>
> Cheers,
> Nathan
>
> > ---
> >  Makefile | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/Makefile b/Makefile
> > index 0b5f8538bde5..3ac83e375b61 100644
> > --- a/Makefile
> > +++ b/Makefile
> > @@ -567,7 +567,7 @@ ifneq ($(shell $(CC) --version 2>&1 | head -n 1 | grep clang),)
> >  ifneq ($(CROSS_COMPILE),)
> >  CLANG_FLAGS  += --target=$(notdir $(CROSS_COMPILE:%-=%))
> >  GCC_TOOLCHAIN_DIR := $(dir $(shell which $(CROSS_COMPILE)elfedit))
> > -CLANG_FLAGS  += --prefix=$(GCC_TOOLCHAIN_DIR)
> > +CLANG_FLAGS  += --prefix=$(GCC_TOOLCHAIN_DIR)$(CROSS_COMPILE)
> >  GCC_TOOLCHAIN        := $(realpath $(GCC_TOOLCHAIN_DIR)/..)
> >  endif
> >  ifneq ($(GCC_TOOLCHAIN),)
> > --
> > 2.28.0.rc0.105.gf9edc3c819-goog
> >
>
> --

-- 
Thanks,
~Nick Desaulniers
