Return-Path: <SRS0=3tRb=3K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06CDBC2D0CE
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jan 2020 23:30:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CEC6324125
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jan 2020 23:30:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="VezdEsW+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727022AbgAUXaW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Jan 2020 18:30:22 -0500
Received: from mail-ot1-f66.google.com ([209.85.210.66]:45431 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725933AbgAUXaV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jan 2020 18:30:21 -0500
Received: by mail-ot1-f66.google.com with SMTP id 59so4593753otp.12
        for <linux-kernel@vger.kernel.org>; Tue, 21 Jan 2020 15:30:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=LbcDS4EF+x2BxRF6rHqQUdAfV9I8sFLSrevUr/kKoHY=;
        b=VezdEsW+weQJiA5EQJtJ/SZWVJLa/h1gZXv8NILA9vvh4oIQus8WUfKfzbeUTCB/N0
         fACCS7IoMBZWx5tjLN5JkuJHuUMyhOn7NEhx7iAJVvXr1bu0WLXdlg3RGNiqDaIBrQ9w
         pDSUt0vkGOSZ7Jkg7E/ga2pGHVb+tcmnh5TVc50ikmr+dKIGcDZgsSq9BXRIIcXKyOoO
         iOyc1tzF7S9gRz8Klf8A8YWjb4pcyNvG/tfmXQtOQyhWpPXxm9q1XANiix5yc6wVJZ6S
         nXyKPykdcyniJliL5z4X4amkm6i82P9HoiR2krL4Lqzq6OOHVMGf3pvvC6zUA7DbgvXt
         JXtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=LbcDS4EF+x2BxRF6rHqQUdAfV9I8sFLSrevUr/kKoHY=;
        b=idg40J1ex/VYvBGuN8mE3mfHW+Y5DzsmptDVnmXz30FnNeg56svW3Vg70RHexLQC7u
         4VAMaSVfb87blFmrbtBugV9AmteUsCjLTDDCsEyr/ZXgMa1tAQIokBrIheFyYYGKdqxq
         frPw7089new/IvEh4DF8iJrSRYfo8s4NPHqL3edzpu5+xrirDLhRvhqkDVANDjrCCVsL
         absRu2avNgTiGNnoEGyjs/31H8+vM7sM3plk/eq1rs+BSqYTCkGF2PZUXn9TZqaXq8Zb
         HQjxNsTFrq86mPkNbYL3KOY6NexjFAuA42e2qH+C7l97NrhgDtTSPozShjX50o4k3XBs
         SIvA==
X-Gm-Message-State: APjAAAUL4yePBQkb+F2ksV/GNjjUKc68xJkwwSJqxA/sVpMR+1fWiMX3
        iG00x6SHIfLEo4eu91MdOkRYK61A8GcFLF00eRHAaw==
X-Google-Smtp-Source: APXvYqwWW++gz2gWD+RcdN0I4Y9DwL4+eB65gL5tWkorN0Jtx5VeUhQ6qSChBcxkhHV5avY8iY25hn9OOrSdADS49Kw=
X-Received: by 2002:a05:6830:1d6a:: with SMTP id l10mr5525708oti.233.1579649420757;
 Tue, 21 Jan 2020 15:30:20 -0800 (PST)
MIME-Version: 1.0
References: <20200121151503.2934-1-cai@lca.pw> <CANpmjNPR+mbadR0DDKGUhTkaXJi=vsHmhvq3+Rz0Hrx=E9V_Qg@mail.gmail.com>
 <20200121152853.GI7808@zn.tnic> <44A4276D-5530-4DAA-8FC7-753D03ADD2F3@lca.pw>
 <CANpmjNO7mTEMc6pvpVVXdu2r6cMg_N8QkRffEHHG-WNFXE4CjA@mail.gmail.com>
 <20200121154528.GK7808@zn.tnic> <E9162CDC-BBC5-4D69-87FB-C93AB8B3D581@lca.pw> <20200121221814.GQ7808@zn.tnic>
In-Reply-To: <20200121221814.GQ7808@zn.tnic>
From:   Marco Elver <elver@google.com>
Date:   Wed, 22 Jan 2020 00:30:09 +0100
Message-ID: <CANpmjNMCyWbbMX2kK8b+Uygg2v-yaQZky8r_X_ca6YCKCy8-dw@mail.gmail.com>
Subject: Re: [PATCH -next] x86/mm/pat: silence a data race in cpa_4k_install
To:     Borislav Petkov <bp@alien8.de>
Cc:     Qian Cai <cai@lca.pw>, Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 21 Jan 2020 at 23:18, Borislav Petkov <bp@alien8.de> wrote:
>
> On Tue, Jan 21, 2020 at 03:21:35PM -0500, Qian Cai wrote:
> > Actually "__no_kcsan" does not work because I have
>
> Why, because KCSAN conflicts with inlining? I'm looking at the comment
> over __no_kasan_or_inline.

Rather a bug in GCC. AFAIK it is GCC <9 ignoring
__attribute__((no_sanitize_*)) for functions that it decides to
inline. Somewhere GCC loses the attribute when inlined, resulting in
still emitting instrumentation calls. __no_kcsan_or_inline works
around it by making such functions noinline. GCC also emits an error
if you try to combine __always_inline and
__attribute__((no_sanitize_*)).

For these reasons we sadly need __no_kcsan_or_inline (similarly we
need __no_kasan_or_inline for KASAN for the same reasons). I hope this
will look a bit nicer once we move past GCC<9.

> > CONFIG_OPTIMIZE_INLINING=y (GCC 8.3.1) here, so it has to be,
> >
> > diff --git a/arch/x86/mm/pat/set_memory.c b/arch/x86/mm/pat/set_memory.c
> > index 20823392f4f2..fabbf8a33b7f 100644
> > --- a/arch/x86/mm/pat/set_memory.c
> > +++ b/arch/x86/mm/pat/set_memory.c
> > @@ -126,7 +126,7 @@ static inline void cpa_inc_2m_checked(void)
> >         cpa_2m_checked++;
> >  }
> >
> > -static inline void cpa_inc_4k_install(void)
> > +static inline void __no_kcsan_or_inline cpa_inc_4k_install(void)

It should be 'static __no_kcsan_or_inline void
cpa_inc_4k_install(void)', since __no_kcsan_or_inline provides
__always_inline on non-KCSAN builds.

Thanks,
-- Marco

> >  {
> >         cpa_4k_install++;
> >  }
> >
> > Are you fine with it or data_race() looks better?
>
> This one looks marginally better because the annotation is still outside
> of the function, so to speak.
>
> Btw, looking at the other "inc" CPA statistics functions there, does it
> mean that for KCSAN they all need to be annotated now too?
>
> --
> Regards/Gruss,
>     Boris.
>
> https://people.kernel.org/tglx/notes-about-netiquette
