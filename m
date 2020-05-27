Return-Path: <SRS0=UR55=7J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E4D4C433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 27 May 2020 20:15:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F0FF82073B
	for <linux-kernel@archiver.kernel.org>; Wed, 27 May 2020 20:15:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="iOS01wcS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728337AbgE0UPC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 May 2020 16:15:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726946AbgE0UPA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 May 2020 16:15:00 -0400
Received: from mail-pl1-x643.google.com (mail-pl1-x643.google.com [IPv6:2607:f8b0:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0FB5C05BD1E
        for <linux-kernel@vger.kernel.org>; Wed, 27 May 2020 13:15:00 -0700 (PDT)
Received: by mail-pl1-x643.google.com with SMTP id y11so2310258plt.12
        for <linux-kernel@vger.kernel.org>; Wed, 27 May 2020 13:15:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=FfdtyyVLKdq4NOXXZJIyNw3sD+oufFVMDv2SJ2Qrq/A=;
        b=iOS01wcS1koYPOrmLcJdGte4hEdREZewrFPmwl/ApUOoPSbaa6h1EGPT+K5AzRcK0q
         1IwXjAPfTKsALyRr4GzqzFCVp+xdSFzkrIzwgiSbVtTJsCrxvqHPVVzZcM/NAp6PU3Vb
         dHxxD1ZX+D45FuEy6e3b2MV3QvQEDGYnfyfF0dmosVnDcQn4kqwk6Ea2HjPYVf/2VVnv
         J1spBnWL7rCAOGDrnPQ+F1Q7dL2kCiEp1hB94bxNcc8WiUysLnCVr8BR9ee++3la2qUl
         RwqF89loSOdPVzMUkoJZAM2EtcxsvAUn2GssB5F7zLAEsMkiWm6+hQJyqq3MAtMLmYUS
         K0lA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=FfdtyyVLKdq4NOXXZJIyNw3sD+oufFVMDv2SJ2Qrq/A=;
        b=Za+1G/mO7VMeUKWjTJ+ds/sh3ercg/LzuBSKqqN90IU2cqq0uSOM2PaIwjCEe7avW0
         9IynM7ET8BR015Nu8BVO05AVQujTaZbk34shYPgffRxsrkznkI80+6MqWA2COW0/8Zh0
         LlvpOLBDikgMl4XsOxe9yHReGu2x4tFKbK4cYjsM5fWjyVPozBWJ3lZu9863odeKzLai
         9EsDus+5KzCZVH2srYvjnZ8K5oIkL0v1fqXW2Zjw/RYVFKMtpw6xjGC89PZrXasPhebX
         FdFLtFgfb8yKtFFCU8qmJpEwc41UPfl74yIvu6H9b/ebKA2O2gfKBr0ndu/8kydI1Ifw
         XCGA==
X-Gm-Message-State: AOAM533zUM8F5ug3Ou9YKtIXpOhoBvQxpZF+UUpy8TGPhEhC9Y4Tg59+
        lVR3DHRUnppbl8yJt/PZogGM0hhPXwmpm0f/9WXr3g==
X-Google-Smtp-Source: ABdhPJxkmmUDLdBND/oo7tPsXbQ7K5srOsr7qRUdoa5Z7H024vJyqnQlLqDUWZ9ULjMDKkGRQvhC0J39xq0J1s/D86s=
X-Received: by 2002:a17:90a:4e8c:: with SMTP id o12mr89158pjh.25.1590610499964;
 Wed, 27 May 2020 13:14:59 -0700 (PDT)
MIME-Version: 1.0
References: <20200526173117.155339-1-ndesaulniers@google.com>
 <2f58c2a4-0f37-d507-7767-00161c6b5d98@arm.com> <CAKwvOd=Oy_OfRbL6-q-3CAHxWBNBKE+HkfNfgCiP726u+4dU1Q@mail.gmail.com>
 <34f261f7-c4b5-a628-9a4c-eb97b75fba52@arm.com>
In-Reply-To: <34f261f7-c4b5-a628-9a4c-eb97b75fba52@arm.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Wed, 27 May 2020 13:14:48 -0700
Message-ID: <CAKwvOdn1W4C5HRJEch5PS-Atcmysh0UD+VZX_wi8tviGwhmM7Q@mail.gmail.com>
Subject: Re: [PATCH] arm64: vdso32: force vdso32 to be compiled as -marm
To:     Robin Murphy <robin.murphy@arm.com>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Naohiro Aota <naohiro.aota@wdc.com>,
        Stephen Boyd <swboyd@google.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Manoj Gupta <manojgupta@google.com>,
        Luis Lozano <llozano@google.com>,
        Nathan Chancellor <natechancellor@gmail.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Kristof Beyls <Kristof.Beyls@arm.com>, victor.campos@arm.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 27, 2020 at 12:28 PM Robin Murphy <robin.murphy@arm.com> wrote:
>
> On 2020-05-27 18:55, Nick Desaulniers wrote:
> > On Wed, May 27, 2020 at 6:45 AM Robin Murphy <robin.murphy@arm.com> wrote:
> >>
> >> On 2020-05-26 18:31, Nick Desaulniers wrote:
> >>> Custom toolchains that modify the default target to -mthumb cannot
> >>> compile the arm64 compat vdso32, as
> >>> arch/arm64/include/asm/vdso/compat_gettimeofday.h
> >>> contains assembly that's invalid in -mthumb.  Force the use of -marm,
> >>> always.
> >>
> >> FWIW, this seems suspicious - the only assembly instructions I see there
> >> are SWI(SVC), MRRC, and a MOV, all of which exist in Thumb for the
> >> -march=armv7a baseline that we set.
> >>
> >> On a hunch, I've just bodged "VDSO_CFLAGS += -mthumb" into my tree and
> >> built a Thumb VDSO quite happily with Ubuntu 19.04's
> >> gcc-arm-linux-gnueabihf. What was the actual failure you saw?
> >
> >  From the link in the commit message: `write to reserved register 'R7'`
> > https://godbolt.org/z/zwr7iZ
> > IIUC r7 is reserved for the frame pointer in THUMB?
>
> It can be, if you choose to build with frame pointers and the common
> frame pointer ABI for Thumb code that uses r7. However it can also be
> for other things like the syscall number in the Arm syscall ABI too.

Ah, right, with -fomit-frame-pointer, this error also goes away.  Not
sure if we prefer either:
- build the compat vdso as -marm always or
- disable frame pointers for the vdso (does this have unwinding implications?)
- other?

> I
> take it Clang has decided that writing syscall wrappers with minimal
> inline asm is not a thing people deserve to do without arbitrary other
> restrictions?

Was the intent not obvious? We would have gotten away with it, too, if
wasn't for you meddling kids and your stupid dog! /s
https://www.youtube.com/watch?v=hXUqwuzcGeU
Anyways, this seems to explain more the intentions:
https://reviews.llvm.org/D76848#1945810
+ Victor, Kristof (ARM)
-- 
Thanks,
~Nick Desaulniers
