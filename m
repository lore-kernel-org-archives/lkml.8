Return-Path: <SRS0=F/Af=7W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8FC2EC433E0
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jun 2020 23:55:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 64A50206F7
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jun 2020 23:55:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="q66wWDpX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726021AbgFIXza (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Jun 2020 19:55:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725932AbgFIXz1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Jun 2020 19:55:27 -0400
Received: from mail-pl1-x644.google.com (mail-pl1-x644.google.com [IPv6:2607:f8b0:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4BB85C05BD1E
        for <linux-kernel@vger.kernel.org>; Tue,  9 Jun 2020 16:55:26 -0700 (PDT)
Received: by mail-pl1-x644.google.com with SMTP id t7so228805plr.0
        for <linux-kernel@vger.kernel.org>; Tue, 09 Jun 2020 16:55:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=DXx+4AN08cMWPSOuEs/2ai9rnq4nQ97k7cBaiF4BCfg=;
        b=q66wWDpXk0iJUR8I2l43jCIuJGlrauLKZMeHmBNa57NglWax7PcrYE1fThpKNf4lL9
         dJwVP8bzub3cQpq4+HtD1aiG0DfT0jWaV5zXSQ4gRFA8vSb+hD8g0079rVCkXE/4H3Cr
         01GeTEYPH17Uf2NjOHzR31pkyFG512jFzIK40TvMzB4nKG7Khz317FPml5U9iXEo7xbB
         /ZA4zVz3lHNK8+v3f84B3h0mVBefldFokJ1umPG0FP1IM7b+nBGszfW8o6EO3KAh+WCM
         o0EZXMNB9ssTfGCirm0e3hODwLCIdGaOydlrYGet3V9u335J4/l49P0fVyzDG70NgZnz
         hM7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=DXx+4AN08cMWPSOuEs/2ai9rnq4nQ97k7cBaiF4BCfg=;
        b=as10q/X6RbjCmCcdRkhBPdDuYjbp/cHl2hcGr3FMqVAxPRM3rtHlf1lq62H5dVGkWz
         EWvB+R6Vr5FQUdFp8PDjqEv7iUenqhO/eVtQYwqcLTRASyKccT1HiGcKXwGtJXxKrs/H
         bdtCCzvpXG70OL9RRyhLmgyi7AQ6yosnzsJ2MWl3/oxyWqBDnTlyJVSMd3njOs8tnAky
         Mx03C1d5tVuVpJG+nOdYrEBHHCRmlsIRd8EU8+nf7JVt4/OPrnwbMnohyLk2SZ3YGRFX
         WnIdG6tEryrIxktteVQDeavLilqIoov05RzHrLWXLgmDKHiYLHnhTN6zG+/MnvmjUY1m
         Kxrg==
X-Gm-Message-State: AOAM531z+wJeaHXRzAZMY/TRX8sbTXPpDIiO8TRbOJP24enw2148sKe6
        z+BcOr/T/locStk6SElcuxdz7xEAOXx/PFrq1fb/mw==
X-Google-Smtp-Source: ABdhPJx8vOo+ybAa4WU/mOk+7qaJQ43m6g1xN3IH64PNoMik3Hg47aoib1u6tVw0WL48Kk7Xg4RcHe0bHBi8vupZLlY=
X-Received: by 2002:a17:902:fe8b:: with SMTP id x11mr686509plm.179.1591746925120;
 Tue, 09 Jun 2020 16:55:25 -0700 (PDT)
MIME-Version: 1.0
References: <20200528072031.GA22156@willie-the-truck> <20200608205711.109418-1-ndesaulniers@google.com>
 <20200609203502.GA21214@gaia>
In-Reply-To: <20200609203502.GA21214@gaia>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Tue, 9 Jun 2020 16:55:13 -0700
Message-ID: <CAKwvOdnDeYQ-tbyW8=tcKcbbFxtDzqk8dCUSzbBYP1amb9a2hg@mail.gmail.com>
Subject: Re: [PATCH v2] arm64: vdso32: add CONFIG_THUMB2_COMPAT_VDSO
To:     Catalin Marinas <catalin.marinas@arm.com>
Cc:     Will Deacon <will@kernel.org>, Stephen Boyd <swboyd@google.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Dave Martin <Dave.Martin@arm.com>,
        Luis Lozano <llozano@google.com>,
        Manoj Gupta <manojgupta@google.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Nathan Chancellor <natechancellor@gmail.com>,
        Naohiro Aota <naohiro.aota@wdc.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 9, 2020 at 1:35 PM Catalin Marinas <catalin.marinas@arm.com> wrote:
>
> On Mon, Jun 08, 2020 at 01:57:08PM -0700, Nick Desaulniers wrote:
> > diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
> > index 7f9d38444d6d..fe9e6b231cac 100644
> > --- a/arch/arm64/Kconfig
> > +++ b/arch/arm64/Kconfig
> > @@ -1299,6 +1299,14 @@ config COMPAT_VDSO
> >         You must have a 32-bit build of glibc 2.22 or later for programs
> >         to seamlessly take advantage of this.
> >
> > +config THUMB2_COMPAT_VDSO
> > +     bool "Compile the vDSO in THUMB2 mode"
> > +     depends on COMPAT_VDSO
> > +     default y
> > +     help
> > +       Compile the compat vDSO with -mthumb -fomit-frame-pointer if y, otherwise
> > +       as -marm.
>
> Now that we understood the issue (I think), do we actually need this
> choice? Why not going for -mthumb -fomit-frame-pointer always for the
> compat vdso?

"Why should the compat vdso be configurable?" is a fair question.  I
don't have an answer, but maybe some of the folks on thread do?

Our problem is more so "if the vdso is built as thumb, we need it also
explicitly built with -fomit-frame-pointer."  Whether it should be
built as thumb, arm, or configurable (and which default to pick in
that case) are still an open questions.  Will asked for it to be
configurable, so I sent a patch making it configurable.

I'm not sure what the tradeoffs would be for a A32 vs T32 compat vdso image.

Is it possible to have hardware that's A64+A32 but not T32, or A64+T32
but not A32? (I suspect not).

I'm not sure whether userspace cares about frame pointer based
unwinding through the vdso, but if it's built as THUMB, then that
likely doesn't work for binaries with A32/T32 interworking.  Whether
the functions in the vdso are faster when built as A32 or T32 I cannot
say.
-- 
Thanks,
~Nick Desaulniers
