Return-Path: <SRS0=UR55=7J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.3 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B98C1C433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 27 May 2020 21:48:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8F8D920835
	for <linux-kernel@archiver.kernel.org>; Wed, 27 May 2020 21:48:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="WGjWZ9LY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727922AbgE0VsC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 May 2020 17:48:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726181AbgE0VsA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 May 2020 17:48:00 -0400
Received: from mail-pj1-x1043.google.com (mail-pj1-x1043.google.com [IPv6:2607:f8b0:4864:20::1043])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46A3CC05BD1E
        for <linux-kernel@vger.kernel.org>; Wed, 27 May 2020 14:48:00 -0700 (PDT)
Received: by mail-pj1-x1043.google.com with SMTP id k2so1134326pjs.2
        for <linux-kernel@vger.kernel.org>; Wed, 27 May 2020 14:48:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=uUE+yaVqbQ0I2ARdSwp4rhmwlgUiG1jizmnSZ18yQmk=;
        b=WGjWZ9LYIG4bhpnAggUwVyC39aV55gk1tlRF6BPT1tDi2QyyI33Yz+MDrB++C+10LA
         P/7SZQi/37ah/zsKAdZVNzCYRUgR3bIl5Mumr12a96S6GfMEofK/jLmxO5LdvjT2xpk7
         vtfFoy1/kfyZqE+oHe0T9wlPXFDD0R0+WaM/1mg72izQm8vu8q7YQxfNpOgGb0u9aRVE
         KzR+CT+hrHKXJ9iZBcwYzS3ikHiF1Gi7d9UcLl/iVHgohcBWN/+HobXQclYwYY1umXvC
         U6IR5LiY7Z+dtOL6ohXAvujCJxMNrd+uTD8l47hlTFJFg7Ay1R5qazeFpToOj8K8gS+0
         8NyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=uUE+yaVqbQ0I2ARdSwp4rhmwlgUiG1jizmnSZ18yQmk=;
        b=BtBt2Pp78PgjO+iowijLZSiReuvSWpn2vOh4Y6u7hqmmycwt/541a42vfMs+XCr/Ww
         9Taca3BNXWxxy2cUH0lJ4DzvVW37jawL3IUF/x5dp+J5lRpQ+Fj0eNzZkIgjZYhO67d3
         hlYGRio1D9U2xpQSRWSo0QiC3oIBVbmFbppfsBGaihNLhvcW0ST78c8wf/ruTBFtmsaS
         HnJaJabgw86J1FwOv8qSU6ByyttmgW8sIv2bMZLZY4kAN1Hqm6ZPbzw0nxNoj1T9wRwt
         PcFjw9Tq5K3fhwe7ob9WmYJDDah5aItdMe95UtFIzEFV92tjblafUwiThd4l8eGhzOUq
         kEGQ==
X-Gm-Message-State: AOAM531u8kcdskFp13OQhQZy25y3tyRGoinF7Vm+aGi4FxiVV3ts2ojb
        eZMXxOaOd19NTb22sgEoU6JvQ97os91Q0PxpBkkAXA==
X-Google-Smtp-Source: ABdhPJyh/8Od7/mjuecpRfPBkc+3tMrs5hRTRH6UC/99lw4+qFip0WaLTFVugV8Iu9KOyTA0arufWFYpU/EBAW7ZarI=
X-Received: by 2002:a17:90a:2a4a:: with SMTP id d10mr449054pjg.32.1590616079419;
 Wed, 27 May 2020 14:47:59 -0700 (PDT)
MIME-Version: 1.0
References: <20200526173117.155339-1-ndesaulniers@google.com>
 <2f58c2a4-0f37-d507-7767-00161c6b5d98@arm.com> <CAKwvOd=Oy_OfRbL6-q-3CAHxWBNBKE+HkfNfgCiP726u+4dU1Q@mail.gmail.com>
 <34f261f7-c4b5-a628-9a4c-eb97b75fba52@arm.com> <CAKwvOdn1W4C5HRJEch5PS-Atcmysh0UD+VZX_wi8tviGwhmM7Q@mail.gmail.com>
 <CAKwvOd=Zxm9TDPNd4Qvn6Ru==FLasiP1xWXMM7ji08VWRjBu2g@mail.gmail.com>
In-Reply-To: <CAKwvOd=Zxm9TDPNd4Qvn6Ru==FLasiP1xWXMM7ji08VWRjBu2g@mail.gmail.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Wed, 27 May 2020 14:47:46 -0700
Message-ID: <CAKwvOdkM=zEpYXKf1A2vDeV8ys9+TRg7X_Cgb-yV7YhOAkXy3Q@mail.gmail.com>
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
        Kristof Beyls <Kristof.Beyls@arm.com>, victor.campos@arm.com,
        david.spickett@linaro.org, Arnd Bergmann <arnd@arndb.de>,
        Peter Smith <Peter.Smith@arm.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 27, 2020 at 1:31 PM Nick Desaulniers
<ndesaulniers@google.com> wrote:
>
> On Wed, May 27, 2020 at 1:14 PM Nick Desaulniers
> <ndesaulniers@google.com> wrote:
> >
> > On Wed, May 27, 2020 at 12:28 PM Robin Murphy <robin.murphy@arm.com> wrote:
> > >
> > > On 2020-05-27 18:55, Nick Desaulniers wrote:
> > > > On Wed, May 27, 2020 at 6:45 AM Robin Murphy <robin.murphy@arm.com> wrote:
> > > >>
> > > >> On 2020-05-26 18:31, Nick Desaulniers wrote:
> > > >>> Custom toolchains that modify the default target to -mthumb cannot
> > > >>> compile the arm64 compat vdso32, as
> > > >>> arch/arm64/include/asm/vdso/compat_gettimeofday.h
> > > >>> contains assembly that's invalid in -mthumb.  Force the use of -marm,
> > > >>> always.
> > > >>
> > > >> FWIW, this seems suspicious - the only assembly instructions I see there
> > > >> are SWI(SVC), MRRC, and a MOV, all of which exist in Thumb for the
> > > >> -march=armv7a baseline that we set.
> > > >>
> > > >> On a hunch, I've just bodged "VDSO_CFLAGS += -mthumb" into my tree and
> > > >> built a Thumb VDSO quite happily with Ubuntu 19.04's
> > > >> gcc-arm-linux-gnueabihf. What was the actual failure you saw?
> > > >
> > > >  From the link in the commit message: `write to reserved register 'R7'`
> > > > https://godbolt.org/z/zwr7iZ
> > > > IIUC r7 is reserved for the frame pointer in THUMB?
> > >
> > > It can be, if you choose to build with frame pointers and the common
> > > frame pointer ABI for Thumb code that uses r7. However it can also be
> > > for other things like the syscall number in the Arm syscall ABI too.
> >
> > Ah, right, with -fomit-frame-pointer, this error also goes away.  Not
> > sure if we prefer either:
> > - build the compat vdso as -marm always or
> > - disable frame pointers for the vdso (does this have unwinding implications?)
> > - other?
> >
> > > I
> > > take it Clang has decided that writing syscall wrappers with minimal
> > > inline asm is not a thing people deserve to do without arbitrary other
> > > restrictions?
> >
> > Was the intent not obvious? We would have gotten away with it, too, if
> > wasn't for you meddling kids and your stupid dog! /s
> > https://www.youtube.com/watch?v=hXUqwuzcGeU
> > Anyways, this seems to explain more the intentions:
> > https://reviews.llvm.org/D76848#1945810
> > + Victor, Kristof (ARM)
>
> And maybe some other useful data points regarding warning on use of r7
> and frame pointers.
> https://github.com/ClangBuiltLinux/linux/issues/701#issuecomment-591325758
> https://bugs.llvm.org/show_bug.cgi?id=45826
> https://gcc.gnu.org/bugzilla/show_bug.cgi?id=94986
>
> + Peter (ARM)
> + David, Arnd (Linaro)

Also, when I looked into this briefly, I didn't happen to see anything
in AAPCS that mentions r7 is used as the frame pointer for THUMB.
Does AAPCS not cover THUMB?  It also states the TPCS is obsolete.
https://developer.arm.com/docs/ihi0042/latest
https://static.docs.arm.com/ihi0042/i/aapcs32.pdf

-- 
Thanks,
~Nick Desaulniers
