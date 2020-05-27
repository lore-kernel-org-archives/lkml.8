Return-Path: <SRS0=UR55=7J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.3 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC9CFC433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 27 May 2020 20:31:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C79CE204EF
	for <linux-kernel@archiver.kernel.org>; Wed, 27 May 2020 20:31:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="vray6QFi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728450AbgE0UbQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 May 2020 16:31:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726129AbgE0UbP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 May 2020 16:31:15 -0400
Received: from mail-pj1-x1043.google.com (mail-pj1-x1043.google.com [IPv6:2607:f8b0:4864:20::1043])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54E1FC05BD1E
        for <linux-kernel@vger.kernel.org>; Wed, 27 May 2020 13:31:15 -0700 (PDT)
Received: by mail-pj1-x1043.google.com with SMTP id q9so2070338pjm.2
        for <linux-kernel@vger.kernel.org>; Wed, 27 May 2020 13:31:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=gqTtOxf1VeVKv93J0vI4JCcXB031qmV7s7ROwagrA3E=;
        b=vray6QFipLSa6Zrr1DR1XbG3QjUIDz/wbMWL+WLYA1+neDtywxY3+/s5y+zWzdoB2f
         qcu8k4EXyQPVMggMeGyT/CQ9XK4CBK++Jq3i/kNJYoseBryOweQ4U/JWICMdXEIS/gY9
         PiJfNiDTLhYrsbc/SDK1sXcoIuPAOqUi1ek/KdDACdvra8MZ3+ynrN1HLtTQ0QxUK7zo
         i810G43EuzbbVtDQ7+T4jKwB+NVnKMs7X2zNXRtBM9vXj9JWHlZuNbQXz9MGXiJXlERu
         cUFKBjpcVg9ytJ8L2k8bxE9kDLheC45LReO6csE4GmcfiyocPw0ty4eFWVbamUXeN7Mm
         1siw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=gqTtOxf1VeVKv93J0vI4JCcXB031qmV7s7ROwagrA3E=;
        b=mxctYsRtA8tUEbAuR33d3o5s8fI6H6aMPQ1Amla5W6Wkh55moT1fTI1K0LqQaSYay3
         KZth2IDqlCHZHLSnM5f/eTZVO7F7AiXoz5ggftAKjioXt/p4j5FC8UqqBaXVNs56Vscj
         hS2vcz4Nw9gR5bDoaASr5qHTvG4Q/6HpIo1fr/Yjo5HJYGLz2BPGzd1FIPS+fOU9WVWZ
         suY57KeM5dcJNFkRFleQRoGI+lDaJWcpGKrf1uJMZF7MlSQnWXa3Zuz2mJ9Ntw8NfXhP
         /kfyETJJpbO64iWX15fiU8xmnSxynaSRXltNIp0XYYTeRlkmoX//S+QNZxsrIwZNQTmA
         oGNA==
X-Gm-Message-State: AOAM533IoAc9n/KRvNamxzFcqe8dyC56PwW7Ghz+n8n+6NXP+Bjy1Ro/
        rtj7CMLHI1CBcXiQgeIACElHWEurXGd5WVjSTbZHjg==
X-Google-Smtp-Source: ABdhPJygdUZklCY45cKMtHF7+W8TRx7Zi+nO1S9a/7BQuk6a5E/aPgvj4vI0zAAr+LRr8v57FOgpTLXG8R8KUxpiLHc=
X-Received: by 2002:a17:90a:2a4a:: with SMTP id d10mr180245pjg.32.1590611474425;
 Wed, 27 May 2020 13:31:14 -0700 (PDT)
MIME-Version: 1.0
References: <20200526173117.155339-1-ndesaulniers@google.com>
 <2f58c2a4-0f37-d507-7767-00161c6b5d98@arm.com> <CAKwvOd=Oy_OfRbL6-q-3CAHxWBNBKE+HkfNfgCiP726u+4dU1Q@mail.gmail.com>
 <34f261f7-c4b5-a628-9a4c-eb97b75fba52@arm.com> <CAKwvOdn1W4C5HRJEch5PS-Atcmysh0UD+VZX_wi8tviGwhmM7Q@mail.gmail.com>
In-Reply-To: <CAKwvOdn1W4C5HRJEch5PS-Atcmysh0UD+VZX_wi8tviGwhmM7Q@mail.gmail.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Wed, 27 May 2020 13:31:03 -0700
Message-ID: <CAKwvOd=Zxm9TDPNd4Qvn6Ru==FLasiP1xWXMM7ji08VWRjBu2g@mail.gmail.com>
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

On Wed, May 27, 2020 at 1:14 PM Nick Desaulniers
<ndesaulniers@google.com> wrote:
>
> On Wed, May 27, 2020 at 12:28 PM Robin Murphy <robin.murphy@arm.com> wrote:
> >
> > On 2020-05-27 18:55, Nick Desaulniers wrote:
> > > On Wed, May 27, 2020 at 6:45 AM Robin Murphy <robin.murphy@arm.com> wrote:
> > >>
> > >> On 2020-05-26 18:31, Nick Desaulniers wrote:
> > >>> Custom toolchains that modify the default target to -mthumb cannot
> > >>> compile the arm64 compat vdso32, as
> > >>> arch/arm64/include/asm/vdso/compat_gettimeofday.h
> > >>> contains assembly that's invalid in -mthumb.  Force the use of -marm,
> > >>> always.
> > >>
> > >> FWIW, this seems suspicious - the only assembly instructions I see there
> > >> are SWI(SVC), MRRC, and a MOV, all of which exist in Thumb for the
> > >> -march=armv7a baseline that we set.
> > >>
> > >> On a hunch, I've just bodged "VDSO_CFLAGS += -mthumb" into my tree and
> > >> built a Thumb VDSO quite happily with Ubuntu 19.04's
> > >> gcc-arm-linux-gnueabihf. What was the actual failure you saw?
> > >
> > >  From the link in the commit message: `write to reserved register 'R7'`
> > > https://godbolt.org/z/zwr7iZ
> > > IIUC r7 is reserved for the frame pointer in THUMB?
> >
> > It can be, if you choose to build with frame pointers and the common
> > frame pointer ABI for Thumb code that uses r7. However it can also be
> > for other things like the syscall number in the Arm syscall ABI too.
>
> Ah, right, with -fomit-frame-pointer, this error also goes away.  Not
> sure if we prefer either:
> - build the compat vdso as -marm always or
> - disable frame pointers for the vdso (does this have unwinding implications?)
> - other?
>
> > I
> > take it Clang has decided that writing syscall wrappers with minimal
> > inline asm is not a thing people deserve to do without arbitrary other
> > restrictions?
>
> Was the intent not obvious? We would have gotten away with it, too, if
> wasn't for you meddling kids and your stupid dog! /s
> https://www.youtube.com/watch?v=hXUqwuzcGeU
> Anyways, this seems to explain more the intentions:
> https://reviews.llvm.org/D76848#1945810
> + Victor, Kristof (ARM)

And maybe some other useful data points regarding warning on use of r7
and frame pointers.
https://github.com/ClangBuiltLinux/linux/issues/701#issuecomment-591325758
https://bugs.llvm.org/show_bug.cgi?id=45826
https://gcc.gnu.org/bugzilla/show_bug.cgi?id=94986

+ Peter (ARM)
+ David, Arnd (Linaro)
-- 
Thanks,
~Nick Desaulniers
