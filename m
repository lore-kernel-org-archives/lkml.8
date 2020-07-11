Return-Path: <SRS0=TDCE=AW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03834C433E0
	for <linux-kernel@archiver.kernel.org>; Sat, 11 Jul 2020 03:16:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CAE592075F
	for <linux-kernel@archiver.kernel.org>; Sat, 11 Jul 2020 03:16:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PfMMnvdN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727785AbgGKDQ2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Jul 2020 23:16:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726707AbgGKDQ1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jul 2020 23:16:27 -0400
Received: from mail-io1-xd43.google.com (mail-io1-xd43.google.com [IPv6:2607:f8b0:4864:20::d43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8E56C08C5DC
        for <linux-kernel@vger.kernel.org>; Fri, 10 Jul 2020 20:16:27 -0700 (PDT)
Received: by mail-io1-xd43.google.com with SMTP id l1so8106638ioh.5
        for <linux-kernel@vger.kernel.org>; Fri, 10 Jul 2020 20:16:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=GkOHcVJOetcedNhG2Fp97wnRClOZ55pcnECegxpPc+c=;
        b=PfMMnvdNLVcGGRphG4Kb+3GyucziOHVOF/TekxE0GjM7BSmJOtLdC31XSWW5UHrJCy
         2O3vQLU9Xq0hdVz9G7jhRr2HsB3X3jB0b/8q/NecU+SI6jIdneXXlNsq5jsZ5Rd7UdaG
         sKhRxSBdG2svPtzI2zaDfjuGhxu+hwlAMOhgWL8AST2VCmXUsMIjXkc8cfZ4ooa+VKq5
         NKMF6Ru759loI3dE92iwM9qpydgX9hpIDdyKcEfopwyjX73aapnjx/LLCYpNR8Lca7ha
         wVZ1pGWaUaP8rcHq1liEXHz/9+ihx3nd74abLJYSSL+DtXZp2YCgj+ZLHWLz8Jat+xpi
         x0DA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=GkOHcVJOetcedNhG2Fp97wnRClOZ55pcnECegxpPc+c=;
        b=jOg2jHSav1hf11Wk7XIcGozQVStYf+u89QnhjvsF/YD396W2HbdfNJ+4fIa/3v1jYh
         3K028ale37MsvykOHEM/IHGCW6DtnQw1j7sRYDX5SRUlod/GCPrC0xUPJb2dFM+NMPkO
         x+H3F4C1UbIPIYKaBdEs/yFtcCqtqR2rrDV9gb23QfrmTODZdfJQRdA1eR9b2XPOuSg8
         6L0eXQlDaySB+BdpUChw0YaplRYiVuI0cSP7gyxSeULHj4m5K+bZV+FvXf4MgBUiWc5K
         3MLwSR1YnSzAlzr3AT780PNzE+TXOjUmBey9BDE/E9tKSiLpc4SdQNrMuGBfd9eFqnRJ
         y4bg==
X-Gm-Message-State: AOAM531aeBCiZv4CHbjHynmK9UuUk4C4S/VEwbWnzckEvfNW4I6lB4om
        VOscUqLZ92lS9ugIVxUBx4g=
X-Google-Smtp-Source: ABdhPJyBnJLKwHPBwgf++/LUKWy/0IVVRlrLsNkURoWE7kda6xkFk8I0b9x3RGXfnwusOkVdEK3B0w==
X-Received: by 2002:a6b:f911:: with SMTP id j17mr48272074iog.96.1594437386880;
        Fri, 10 Jul 2020 20:16:26 -0700 (PDT)
Received: from Ryzen-9-3900X.localdomain ([107.152.99.41])
        by smtp.gmail.com with ESMTPSA id w10sm4308131ilo.10.2020.07.10.20.16.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Jul 2020 20:16:26 -0700 (PDT)
Date:   Fri, 10 Jul 2020 20:16:23 -0700
From:   Nathan Chancellor <natechancellor@gmail.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Nick Desaulniers <ndesaulniers@google.com>,
        Cesar Eduardo Barros <cesarb@cesarb.eti.br>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Masahiro Yamada <masahiroy@kernel.org>,
        clang-built-linux@googlegroups.com
Subject: Re: [PATCH] Restore gcc check in mips asm/unroll.h
Message-ID: <20200711031623.GA4441@Ryzen-9-3900X.localdomain>
References: <20200709221102.323356-1-cesarb@cesarb.eti.br>
 <CAHk-=wjUEmO4GiC9mCyzZ8_WS=ZWgfg6CnpxPSLq=uoF1F3Xyw@mail.gmail.com>
 <CAKwvOdnbtbetfN5zF51QOXVhrutE8ak4uPe82iY6g9f6gwk=Vg@mail.gmail.com>
 <CAHk-=whaqVGHSGstM4yHnJ+WkoHDBKWxMuZvgOYoxe9sYBOjEw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=whaqVGHSGstM4yHnJ+WkoHDBKWxMuZvgOYoxe9sYBOjEw@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 10, 2020 at 03:31:00PM -0700, Linus Torvalds wrote:
> On Fri, Jul 10, 2020 at 11:43 AM Nick Desaulniers
> <ndesaulniers@google.com> wrote:
> >
> > What I'd really like to see as a policy in the kernel going forward in
> > that ANY new commit that adds some hack or workaround for a specific
> > compiler version add a comment about which toolchain version was
> > problematic, that way when we drop support for that version years
> > later, we can drop whatever hacks and technical debt we've accumulated
> > to support that older version.
> 
> The problem is that at the time we find and fix things, it's often
> _very_ unclear which compiler versions are affected.
> 
> We also have the situation that a lot of distro compilers aren't
> necessarily completely "clean" versions, particularly for the
> "enterprise" ones that get stuck on some old version and then fix up
> their breakage by backporting fixes.

Indeed. I would say this is less common for most distributions with
clang, where they tend to stick closer to tip of tree, but it can still
happen. I guess there is not a really good solution for this but we
could just have a policy that as soon as you move away from the upstream
version, you are on your own.

> When it's some particular version of a compiler that supports a
> particular feature, that tends to be much more straightforward. But
> we've had bugs where it was very unclear when exactly the bug was
> fixed (fi it was fixed at all by the time we do the workaround).

As for putting a seal of approval on a minimum supported version of
LLVM/clang, I have my reservations. 0day keeps uncovering various issues
with its builds and clang's release model is different than from GCC's
so if we ever come across a compiler bug in an older version of clang,
we have basically no hope for getting it fixed. GCC supports older
series through bug fix releases for quite some time (GCC 7 was supported
for two and a half years), whereas with clang, they only see one
servicing release before the next major release (for example, clang
9.0.1 before clang 10.0.0) so it makes getting compiler fixes into the
hands of users much more difficult. I am trying to rectify that with
clang 10 though, where I have been testing that release against a bunch
of different configs both in tree and out of tree:
https://github.com/nathanchance/llvm-kernel-testing

However, I think at this point, we can say clang itself is in a good
position as of clang 9, certainly clang 10. I am less confident in
placing a minimum version on the LLVM tools such as lld though. For arm,
arm64, and x86_64, we are in fairly good shape as of clang 10 but I
think there is probably some more work/polishing to be done there; for
other architectures, it is worse. I suppose we would have to consider
the support model: under what cases is it acceptable to bump the minimum
required version versus inserting a bad compiler hack? As someone who is
not super familiar with the relationship between GCC and the kernel, it
appears to me that the general attitude towards compiler bugs has been
workaround it in the kernel while hoping that it gets fixed at some
point in GCC. We have been pretty aggressive about fixing the compiler
instead of inserting a workaround, which I feel like is the better
solution, but it makes supporting multiple versions of the compiler more
difficult (versus just saying use the latest). It is something that
needs to be discussed and agreed upon sooner rather than later though,
especially as we grow more and more polished.

There were some other thoughts that I had on our issue tracker here, if
anyone cares for them:

https://github.com/ClangBuiltLinux/linux/issues/941

Sorry for the brain dump and cheers,
Nathan
