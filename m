Return-Path: <SRS0=f73W=7K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 930B2C433E1
	for <linux-kernel@archiver.kernel.org>; Thu, 28 May 2020 19:07:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6B71A208A7
	for <linux-kernel@archiver.kernel.org>; Thu, 28 May 2020 19:07:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="TRXdzlLI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406187AbgE1THM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 May 2020 15:07:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2406108AbgE1TG7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 May 2020 15:06:59 -0400
Received: from mail-pg1-x542.google.com (mail-pg1-x542.google.com [IPv6:2607:f8b0:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF13AC08C5C6
        for <linux-kernel@vger.kernel.org>; Thu, 28 May 2020 12:06:58 -0700 (PDT)
Received: by mail-pg1-x542.google.com with SMTP id u5so36153pgn.5
        for <linux-kernel@vger.kernel.org>; Thu, 28 May 2020 12:06:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=D0Z0uljIaa9E7sK/osUj/lAD10bbouNo4XeXPu5yFDM=;
        b=TRXdzlLIM4wpBQ8hPBW7hxSfD0Jr4goyv9wU1EAFBC9KRmAlbBDFHKjVr2prIT0/kf
         wlKqKe16cBDzsbYLavX6WUYXtgU9L32Fyu+x2HEOrk539fgCJ+GOXs77TbH1Q4WyTPur
         Cxh7L4qfwu1ht8DnmFW077Zbp7hmeSa6n4hw1ETzlcTDC3asc4tkufKSCToWUBrdccR3
         RUEsaMjZCZCuP0PdRyYYqzea+lRHHow61ShzPBSRTXCC46askwaFgZ3iT/H25lIPY8Jk
         BtHtwkCCoJdBn9AQNncLhhtlTvn58iJ1SJryfEu/WWBz/eJzcMTeipoRVWYgJxG00lLe
         4HZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=D0Z0uljIaa9E7sK/osUj/lAD10bbouNo4XeXPu5yFDM=;
        b=TgzZ3P9gqpkOs3QpjmAfj8GDW+vM9UkzU9aVLcVpIBOVeX4SRkXtGh5Gji9hxUVbCV
         6t8KCz/2kzdGGrpJ45fK73amM83DGErcvI+Y4is/oyjuPuyTrIp5ProDk5pgnRyChGDh
         gXgG6gjtU974uTLfuOeC6JWJOnA4f5yaJPlQ0cGUABvtBgmKZNFpokZ5BOQqN37yBIu9
         6zvWJAN9iaHHCfS1iV4bz1N05SYOjBR4+OL06XsecB2NpHiuf1K9O1/cnkokxaTZgwdD
         C3h/YQl1wKenFymdioERmphRpEumAYpjofw5PmnXNVarOqxDguO70ZwoztxwqEsshLl3
         xmoA==
X-Gm-Message-State: AOAM532Unn1WQ2PRayXxxseFQLd//Fi7d2ycAUFGCShOlfP6B73M/cJZ
        EGqz20LgnT51h1F2GvGEfjBikzOoQp8UK9I0hMbWKg==
X-Google-Smtp-Source: ABdhPJzjdonwSCmxhwOgf6j5Q3qfjEg4fja6HZmRRq1xYAcjAb2iKvsWyznkcVzMWdm1slQXc6yF3mCz826Aodt1kn4=
X-Received: by 2002:a63:f00d:: with SMTP id k13mr4503675pgh.263.1590692818044;
 Thu, 28 May 2020 12:06:58 -0700 (PDT)
MIME-Version: 1.0
References: <20200526173117.155339-1-ndesaulniers@google.com>
 <2f58c2a4-0f37-d507-7767-00161c6b5d98@arm.com> <CAKwvOd=Oy_OfRbL6-q-3CAHxWBNBKE+HkfNfgCiP726u+4dU1Q@mail.gmail.com>
 <34f261f7-c4b5-a628-9a4c-eb97b75fba52@arm.com> <CAKwvOdn1W4C5HRJEch5PS-Atcmysh0UD+VZX_wi8tviGwhmM7Q@mail.gmail.com>
 <CAKwvOd=Zxm9TDPNd4Qvn6Ru==FLasiP1xWXMM7ji08VWRjBu2g@mail.gmail.com>
 <VI1PR08MB319868AFBEDCD0925C53701AF88E0@VI1PR08MB3198.eurprd08.prod.outlook.com>
 <20200528094154.GB2961@gaia>
In-Reply-To: <20200528094154.GB2961@gaia>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Thu, 28 May 2020 12:06:46 -0700
Message-ID: <CAKwvOdkBr9Y+J0ZgZT8RR60Kh-kG7Q_annQU+s=+RXg=qeLFNQ@mail.gmail.com>
Subject: Re: [PATCH] arm64: vdso32: force vdso32 to be compiled as -marm
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Peter Smith <Peter.Smith@arm.com>,
        Will Deacon <will@kernel.org>
Cc:     Robin Murphy <Robin.Murphy@arm.com>,
        Naohiro Aota <naohiro.aota@wdc.com>,
        Stephen Boyd <swboyd@google.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Manoj Gupta <manojgupta@google.com>,
        Luis Lozano <llozano@google.com>,
        Nathan Chancellor <natechancellor@gmail.com>,
        Vincenzo Frascino <Vincenzo.Frascino@arm.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Kristof Beyls <Kristof.Beyls@arm.com>,
        Victor Campos <Victor.Campos@arm.com>,
        "david.spickett@linaro.org" <david.spickett@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 28, 2020 at 12:20 AM Will Deacon <will@kernel.org> wrote:
> > Yes, I know that :)

Right, I forgot; you wrote the 64b one. :)

On Thu, May 28, 2020 at 2:41 AM Catalin Marinas <catalin.marinas@arm.com> wrote:
>
> On Thu, May 28, 2020 at 09:05:08AM +0100, Peter Smith wrote:
> > I suggest using Arm if you need a frame pointer, and disable the
> > frame pointer if you want/need to use Thumb. My understanding is that
> > runtime unwinding using the frame pointer in Thumb is already difficult
> > due to Arm and Thumb functions using different registers for the frame
> > pointer.
>
> IIRC from the Thumb-2 kernel porting days, even in the absence of
> ARM/Thumb interworking, the Thumb-2 frame pointer was pretty useless for
> unwinding since it points to the bottom of the current stack frame (the
> reason I think is that some LDR/STR instructions with negative indexing
> are not available). So finding the previous frame pointer was not
> possible and had to rely on the exception unwinding information.

Eureka!  That's it!  Implicit state of -fomit-frame-pointer.

Ok, forgetting ARCH=arm64 for a second, for ARCH=arm we have the
choice CONFIG_THUMB2_KERNEL.  Regardless of which is chosen, we
*always* explicitly set -mthumb or -marm, but we never rely on
implicit defaults.  Again for ARCH=arm, we have a choice of unwinders,
or at least we do when *not* targeting thumb.  If we select
CONFIG_THUMB2_KERNEL, then CONFIG_UNWINDER_FRAME_POINTER cannot be
selected.

arch/arm/Kconfig.debug:
  57 config UNWINDER_FRAME_POINTER
  58   bool "Frame pointer unwinder"
  59   depends on !THUMB2_KERNEL
...

CONFIG_UNWINDER_FRAME_POINTER selects CONFIG_FRAME_POINTER which sets
-fno-omit-frame-pointer.  Otherwise, it looks like the choice of
-f{no-}omit-frame-pointer is left unspecified, relying on compiler
defaults.

And that's just for ARCH=arm.  Returning to ARCH=arm64, and the compat
vdso in particular, it doesn't look like we ever set
-f{no-}omit-frame-pointer either, so again we're looking at the
compiler defaults.

And when we look at the default behavior for the implicit state of
-f{no-}omit-frame-pointer, we find differences.

Here's a test case you can play around with:
https://godbolt.org/z/0oY39t

For Clang, can you tell what the default state is if left off?
For GCC, can you tell what the default state is if left off?
Do they match?
Is this specific to -mthumb?
(Bonus: what happens when you remove `-O2`?)

Answers:
-fno-omit-frame-pointer
-fomit-frame-pointer
No.
No.
-fno-omit-frame-pointer in GCC (-fomit-frame-pointer is an optimization)

Deja vu, I fixed a very similar discrepancy reported by Linus not too long ago.
https://reviews.llvm.org/D74698
Looking at the relevant logic in Clang:
https://github.com/llvm/llvm-project/blob/58beb76b7bd2f7caa1df461b9db6629521c3b60b/clang/lib/Driver/ToolChains/Clang.cpp#L527-L591
Noticely absent are arm, thumb, aarch64, and big endian variants,
specifically here:
https://github.com/llvm/llvm-project/blob/58beb76b7bd2f7caa1df461b9db6629521c3b60b/clang/lib/Driver/ToolChains/Clang.cpp#L556-L571

I should fix that in Clang.

That should also speed up our 32b ARM kernels that select
CONFIG_THUMB2_KERNEL (ie. CrOS veyron-minnie platform, rk3288).
Shouldn't make a difference for 64b ARM kernels since those select
frame pointers.  Though I am curious about the userspaces now for CrOS
and Android...

On Thu, May 28, 2020 at 1:05 AM Peter Smith <Peter.Smith@arm.com> wrote:
> > Hope this helps

Always, m8, you're the expert.

So r11 will be the frame pointer for arm and thumb according to latest
aapcs, but the compilers haven't yet made any changes related to this,
and can still use r7 in a bunch of cases (-mthumb
--target=arm-linux-gnueabi being the most relevant one for our
discussion).

> On Thu, May 28, 2020 at 12:20 AM Will Deacon <will@kernel.org> wrote:
> your
> patch is papering over a deeper issue.

Ah, your right.  Sorry, I was wrong.  I owe you (another) beer?  I'm
going into debt over these and will have to take out a loan, soon!
-- 
Thanks,
~Nick Desaulniers
