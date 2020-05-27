Return-Path: <SRS0=UR55=7J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7884AC433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 27 May 2020 18:17:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5656C2084C
	for <linux-kernel@archiver.kernel.org>; Wed, 27 May 2020 18:17:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="jW9I6IcI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391810AbgE0SRq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 May 2020 14:17:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388827AbgE0SRp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 May 2020 14:17:45 -0400
Received: from mail-pj1-x1044.google.com (mail-pj1-x1044.google.com [IPv6:2607:f8b0:4864:20::1044])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81C97C08C5C1
        for <linux-kernel@vger.kernel.org>; Wed, 27 May 2020 11:17:45 -0700 (PDT)
Received: by mail-pj1-x1044.google.com with SMTP id cx22so1923172pjb.1
        for <linux-kernel@vger.kernel.org>; Wed, 27 May 2020 11:17:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=sfeuf1RcsifrB3Z4RHr75dVIcka7dq4SQp4hnMKidtE=;
        b=jW9I6IcISPBM5odZ0BBjMleOhp3HrTz9i9z9t14jKrriGmH38qc4vC4E7I7/9cJ2SM
         H/jUBbMYY0HmfRStYhkSugbSHV5HxjSC9y37pi78dxd6I23oImiF5in+948rZ+zBhizp
         7jKLslPhjxB4C/PiKSQKABEF9x5ifrbEBOfqbUumjhb2k6NLf7r9gsr86IG2lqWCSx5V
         wHRkvgfhXWOXK6u5JMHoQSRNkrOOb7UgEXE78GT9bQcYIX5tLLiAJqjfu90k5O6QjvO9
         /nPSE9QpMJG4R+YNscIU4e9LW+m9lTxcjktaQmrV9jJZPz/VJr0Nln2Fy9jnRIirunBr
         jBFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=sfeuf1RcsifrB3Z4RHr75dVIcka7dq4SQp4hnMKidtE=;
        b=HlLt6KYAWE20A7PtBnbgXf560Q999fEGctk2JpVcQyppE7j8s4gI5RI3F9Dqjm+OF+
         SZXpaHh/XgiM2mP3fsH+uRt89fct5OwKCRXE5eLr3JY95x8poCm3iq+OYTM4P0uV38uI
         SA82aLra0vXxifQCDuDgIXiOUb4EHYnSQZIpwA6cuDS8e1aLjiIMIg4zeOUU6v/dGZU/
         J1qXnlrNHYZbx4imtGEnCa/3jLlmrrd2hrFho/m5fyLG7dmJqgaWp1v9XRugxvD/zdD1
         HafKKfuY2SHOM8dyCdkU1e1BUvMkwJQfSaX6Aohw+uEq+jOULHGbTAN+UE3f6db2aITI
         C9UQ==
X-Gm-Message-State: AOAM532J6O4jvkCkP7M6fOG0jtBzmQCEsUdwFEFO9oavprn+7Js5sVPR
        m6Woa+MDs1OXTDPiDpANHdQcaSt9w9OPWCEUOfu4wA==
X-Google-Smtp-Source: ABdhPJyjh15doArAoxCqTXh0jXL58m+0M+ODK5t8I5EYjY3oEL4CWvhsrwLclt6q37m0hfEZn9W/NelVh8W+dscvGLM=
X-Received: by 2002:a17:90a:4e8c:: with SMTP id o12mr5942532pjh.25.1590603464524;
 Wed, 27 May 2020 11:17:44 -0700 (PDT)
MIME-Version: 1.0
References: <20200526173117.155339-1-ndesaulniers@google.com>
 <2f58c2a4-0f37-d507-7767-00161c6b5d98@arm.com> <CAKwvOd=Oy_OfRbL6-q-3CAHxWBNBKE+HkfNfgCiP726u+4dU1Q@mail.gmail.com>
 <20200527180839.GA16411@willie-the-truck>
In-Reply-To: <20200527180839.GA16411@willie-the-truck>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Wed, 27 May 2020 11:17:33 -0700
Message-ID: <CAKwvOdm5hGzJ0WY_GAywRZ1c8MkA=H7imY0rrVgB4MgtyJ+iRg@mail.gmail.com>
Subject: Re: [PATCH] arm64: vdso32: force vdso32 to be compiled as -marm
To:     Will Deacon <will@kernel.org>
Cc:     Robin Murphy <robin.murphy@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Naohiro Aota <naohiro.aota@wdc.com>,
        Stephen Boyd <swboyd@google.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Manoj Gupta <manojgupta@google.com>,
        Luis Lozano <llozano@google.com>,
        Nathan Chancellor <natechancellor@gmail.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 27, 2020 at 11:08 AM Will Deacon <will@kernel.org> wrote:
>
> On Wed, May 27, 2020 at 10:55:24AM -0700, Nick Desaulniers wrote:
> > On Wed, May 27, 2020 at 6:45 AM Robin Murphy <robin.murphy@arm.com> wrote:
> > >
> > > On 2020-05-26 18:31, Nick Desaulniers wrote:
> > > > Custom toolchains that modify the default target to -mthumb cannot
> > > > compile the arm64 compat vdso32, as
> > > > arch/arm64/include/asm/vdso/compat_gettimeofday.h
> > > > contains assembly that's invalid in -mthumb.  Force the use of -marm,
> > > > always.
> > >
> > > FWIW, this seems suspicious - the only assembly instructions I see there
> > > are SWI(SVC), MRRC, and a MOV, all of which exist in Thumb for the
> > > -march=armv7a baseline that we set.
> > >
> > > On a hunch, I've just bodged "VDSO_CFLAGS += -mthumb" into my tree and
> > > built a Thumb VDSO quite happily with Ubuntu 19.04's
> > > gcc-arm-linux-gnueabihf. What was the actual failure you saw?
> >
> > From the link in the commit message: `write to reserved register 'R7'`
> > https://godbolt.org/z/zwr7iZ
> > IIUC r7 is reserved for the frame pointer in THUMB?
> >
> > What is the implicit default of your gcc-arm-linux-gnueabihf at -O2?
> > -mthumb, or -marm?
>
> Hmm, but this *is* weird because if I build a 32-bit kernel then I get
> either an ARM or a Thumb-2 VDSO depending on CONFIG_THUMB2_KERNEL. I'm
> not sure if that's deliberate, but both build and appear to work.

That's because there's 3 VDSO's when it comes to ARM:
arm64's 64b vdso: arch/arm64/kernel/vdso
arm64's 32b vdso: arch/arm64/kernel/vdso32/
arm's 32b vdso: arch/arm/kernel/vdso.c

When you build a 32b kernel, you're only making use of the last of
those three; the arm64 vdso and vdso32 code is irrelevant.
This patch is specific to the second case, which is the 32b compat
vdso for a 64b kernel.

>
> I'll drop this patch for now, while we figure it out a bit more.
>
> Cheers,
>
> Will



-- 
Thanks,
~Nick Desaulniers
