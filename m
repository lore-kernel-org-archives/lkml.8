Return-Path: <SRS0=iZC5=5S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB232C43331
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Apr 2020 07:56:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BB8B7206F6
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Apr 2020 07:56:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="RmbAMcl8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387620AbgDBH4t (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Apr 2020 03:56:49 -0400
Received: from mail-lf1-f67.google.com ([209.85.167.67]:40054 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725965AbgDBH4t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Apr 2020 03:56:49 -0400
Received: by mail-lf1-f67.google.com with SMTP id j17so1901317lfe.7
        for <linux-kernel@vger.kernel.org>; Thu, 02 Apr 2020 00:56:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=NLxAfO/+CXjGBU0lneDYEfTm3/RVeCex0QsJS4HUhZc=;
        b=RmbAMcl888PHsTzOLIAl3LFnAF/LaClsZoOPozQJSeYjsZqb0oxpAyEx6/MxUb3vFY
         Q2kOTxQb/Gp67rDIH00o5g7ZBUV1U1VoYnaTHxaeGVwNWK6fkxOQODwh+Z2bnvv5ymsJ
         sijSpJjrPsy8TmsG2arBREV/jexcBBiKN+uhkIlwRKTF08AOQJKOujRbDytrEkKempwC
         hmbnjA5WnLz0YNt8y32d+aeA89hLAOiBH1eWsnssiGJIqFn8K+dZST9PfqBKJWg1FXy8
         DnviHEtx46AAaVg5SurPy8EP3SIZDbX1Ukd8lM/iwKozhzQUzTok7u1zT18BzBpufgPQ
         LHNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=NLxAfO/+CXjGBU0lneDYEfTm3/RVeCex0QsJS4HUhZc=;
        b=nK6Tn8Iy4368Fgaq/K7yNtylJoG3RpW95uYQMfDdzzF7znCQD6Um8Nbf0WHj2FKuy1
         Z0QDBZ4Y/CHi/kqz//ak2CICCjcXRK7QjP6hpDo0aKgP3cknirWQBRbUGdScAEydB/PD
         k4uBse6CZP9Tq52nzqHSGes1q+WK2lcdKdv062mMvQMjEsqgvuC2X7i4smx4NOuFTfT7
         uEpbd1Rwyz6RwKVcejYGGuqGylWKy0QTA+gDepw4t4w0auJ25oT4WuXIR/tQuFhUtee7
         geUXSTgJWT+U6+bm5JGPiw+KdeGG3iEMg8lXfAJW7OZrLWwbkcDvHScFpz54ZinZFYYo
         fzjA==
X-Gm-Message-State: AGi0Pua5zL2D0NcoQFHzEV8HYR0gvOtynbzHRTbMIyl1wnMVOV158BTf
        MRS3yUa4j5Cz5ERLhMhpxax92zO+sLudJOYI/a6mvg==
X-Google-Smtp-Source: APiQypJ4cqTyHEJt4zQugpcoHs1N3egWTunLDxTUril9LnntFZT1U1twMztpRgVqvm7g5n1lG3YDWUTVbxU80Ip3k7A=
X-Received: by 2002:a19:6e47:: with SMTP id q7mr1311472lfk.164.1585814204978;
 Thu, 02 Apr 2020 00:56:44 -0700 (PDT)
MIME-Version: 1.0
References: <CAG48ez2Sx4ELkM94aD_h_J7K7KBOeuGmvZLKRkg3n_f2WoZ_cg@mail.gmail.com>
 <4c5fe55d-9db9-2f61-59b2-1fb2e1b45ed0@amd.com>
In-Reply-To: <4c5fe55d-9db9-2f61-59b2-1fb2e1b45ed0@amd.com>
From:   Jann Horn <jannh@google.com>
Date:   Thu, 2 Apr 2020 09:56:18 +0200
Message-ID: <CAG48ez1nHt2BRApHPp2S6rd4kr3P2kFsgHvStUsW7rqHSJprgg@mail.gmail.com>
Subject: Re: AMD DC graphics display code enables -mhard-float, -msse, -msse2
 without any visible FPU state protection
To:     =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
Cc:     Harry Wentland <harry.wentland@amd.com>,
        Leo Li <sunpeng.li@amd.com>, amd-gfx@lists.freedesktop.org,
        Alex Deucher <alexander.deucher@amd.com>,
        "David (ChunMing) Zhou" <David1.Zhou@amd.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        kernel list <linux-kernel@vger.kernel.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Andy Lutomirski <luto@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 2, 2020 at 9:34 AM Christian K=C3=B6nig <christian.koenig@amd.c=
om> wrote:
> Am 02.04.20 um 04:34 schrieb Jann Horn:
> > [x86 folks in CC so that they can chime in on the precise rules for thi=
s stuff]
> > I noticed that several makefiles under drivers/gpu/drm/amd/display/dc/
> > turn on floating-point instructions in the compiler flags
> > (-mhard-float, -msse and -msse2) in order to make the "float" and
> > "double" types usable from C code without requiring helper functions.
> >
> > However, as far as I know, code running in normal kernel context isn't
> > allowed to use floating-point registers without special protection
> > using helpers like kernel_fpu_begin() and kernel_fpu_end() (which also
> > require that the protected code never blocks). If you violate that
> > rule, that can lead to various issues - among other things, I think
> > the kernel will clobber userspace FPU register state, and I think the
> > kernel code can blow up if a context switch happens at the wrong time,
> > since in-kernel task switches don't preserve FPU state.
> >
> > Is there some hidden trick I'm missing that makes it okay to use FPU
> > registers here?
> >
> > I would try testing this, but unfortunately none of the AMD devices I
> > have here have the appropriate graphics hardware...
>
> yes, using the floating point calculations in the display code has been
> a source of numerous problems and confusion in the past.
>
> The calls to kernel_fpu_begin() and kernel_fpu_end() are hidden behind
> the DC_FP_START() and DC_FP_END() macros which are supposed to hide the
> architecture depend handling for x86 and PPC64.

Hmm... but as far as I can tell, you're using those macros from inside
functions that are already compiled with the FPU on:

 - drivers/gpu/drm/amd/display/dc/calcs/dcn_calcs.c uses the macros,
but is already compiled with calcs_ccflags
 - drivers/gpu/drm/amd/display/dc/dcn20/dcn20_resource.c uses the
macros, but is already compiled with "-mhard-float -msse -msse2"
 - drivers/gpu/drm/amd/display/dc/dcn21/dcn21_resource.c uses the
macros, but is already compiled with "-mhard-float -msse -msse2"

AFAIK as soon as you enter any function in any file compiled with FPU
instructions, you may encounter SSE instructions, e.g. via things like
compiler-generated memory-zeroing code - not just when you're actually
using doubles or floats.
