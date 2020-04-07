Return-Path: <SRS0=z/zp=5X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 410CCC2BA80
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Apr 2020 13:53:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 105F12074F
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Apr 2020 13:53:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=juliacomputing-com.20150623.gappssmtp.com header.i=@juliacomputing-com.20150623.gappssmtp.com header.b="W5Mi8FhH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728957AbgDGNxV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Apr 2020 09:53:21 -0400
Received: from mail-io1-f65.google.com ([209.85.166.65]:45334 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728555AbgDGNxV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Apr 2020 09:53:21 -0400
Received: by mail-io1-f65.google.com with SMTP id i19so1402181ioh.12
        for <linux-kernel@vger.kernel.org>; Tue, 07 Apr 2020 06:53:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=juliacomputing-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=/tIS1nHkWLKceDKscialOKEJnhPfi2Afg0e9e9048cU=;
        b=W5Mi8FhHbDCFUgXZ6Z6WR/9xJUqZ9FPprIvt6ODMSY5V17Px+rYJ33yZ0gVgGbvlc6
         eFkaKkl1PSk4XWjUuxtRIQHEqy0unoYpLxRPYCz5RvdZ0WmDWbQJ//eA6vIvL+vwSUrs
         DNUJYDVGoIy2+SWvEoWLs9X6GXoP6aVUFLSwNUkWv2AZWobz1hk2dG6wnIyLu/LcY/NE
         RdgdoZ2hgiyfq9DwjbK0IGsLtdL7yC0J8YElW/9D+fOocy/m1mFdc1v5OF6BD2Yn2gDz
         oosFdWnXTgS2sney0D/7LMVhKk2JCDC9tc/c1lXBame6AfPt5b58vq0dX11l/FV7pCbU
         8N2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/tIS1nHkWLKceDKscialOKEJnhPfi2Afg0e9e9048cU=;
        b=id50ioHYkw3IQ4brAT0Hafx1D/0+q1jA8+LIt3WhXStlVU5dpNnvKQvAZDx+Ng0vU2
         +Xg6sY1fvCJEW5YD94vD88DC5v4zKtWWVJOIOnrz9mTYqi5M23zokZ24WnmlILZkLEPN
         G8l0UX+5R+OrHPEb1909sTWlEz7UAbyRRSUsuCQjlBxPW/27y/ZlLuBFtdwp+KzM9sp0
         1y5xflz7EFTUeg0QiEpvPN15l6NVRT2xFVz8xDipizWGkwRp9EqUZAk10nCjtXQFFiX4
         lzspJ5dYf6Ta9Ctp2v+ciKPb2W75vg0USjy0P/PSZD2LHNAdjYDh2KWcx7rU2BqYSxXJ
         IlcA==
X-Gm-Message-State: AGi0PuaSishpXwxu+B9pySww5hnr76d2WBXv+iBkhJuhrJbDx0hMHDj8
        YpNciIcqACcchw/gKa+lJPH9xqnfWarTpsnuQ/Mapw==
X-Google-Smtp-Source: APiQypIFeftaPaG0e8PVkF1/4uZiOdSZeIrZbhO4hk9CyEY9H79J9+Xj038Sgp0OA2dSMNtTvn7YY8g3jMnuMvqHhyc=
X-Received: by 2002:a02:3506:: with SMTP id k6mr2126090jaa.104.1586267599579;
 Tue, 07 Apr 2020 06:53:19 -0700 (PDT)
MIME-Version: 1.0
References: <20200407011259.GA72735@juliacomputing.com> <2A931F48-D28F-46F3-827F-FF7F4D5D3E66@amacapital.net>
 <CABV8kRyi-5wyiCV3HsPfFx6x1_icV72BSy+5eK8UC3UCexTSCA@mail.gmail.com>
 <CAP045AohDoxZ+tvm+hBWWXgXz6N-z0+UWj--_o1AiVRubWYm6A@mail.gmail.com> <20200407123348.GV20730@hirez.programming.kicks-ass.net>
In-Reply-To: <20200407123348.GV20730@hirez.programming.kicks-ass.net>
From:   Keno Fischer <keno@juliacomputing.com>
Date:   Tue, 7 Apr 2020 09:52:42 -0400
Message-ID: <CABV8kRx=7fFvHqQ9AX-1P9EBhXg5sH4xjoPKz6qkiQK4tHFUbA@mail.gmail.com>
Subject: Re: [RFC PATCH v2] x86/arch_prctl: Add ARCH_SET_XCR0 to set XCR0 per-thread
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Kyle Huey <me@kylehuey.com>, Andy Lutomirski <luto@amacapital.net>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Andi Kleen <andi@firstfloor.org>,
        Kyle Huey <khuey@kylehuey.com>,
        "Robert O'Callahan" <robert@ocallahan.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> > It's mentioned elsewhere, but I want to emphasize that the return
> > value of xgetbv is the big one because the dynamic linker uses this.
> > rr trace portability is essentially limited to machines with identical
> > xcr0 values because of it.
>
> I'm thinking just exposing that value is doable in a much less
> objectionable fashion, no?

Hi Peter,

I'm not sure I understand what you're asking,
but let me attempt to provide an answer anyway.
If I'm off the mark in what you would like to know,
please let me know and I'll try my best to get back
to you.

rr's operating principle relies upon every instruction
having deterministic and reproducible behavior,
every time they're executed and across machines.
That means literally bitwise identical updates to the
x86 register state. Most instructions do that given
identical register state - of course some don't by
design like rdtsc. Those instructions get trapped
and emulated (we're very lucky that doing so is
possible for all such instructions of practical
interest on Intel hardware). xcr0 puts us in a bit of
a bind here, because it modifies the user-visble
behavior of instructions (in the three ways I mentioned).
The xgetbv behavior is indeed the most problematic.
If there was a way to selectively trap
xgetbv/xsave/xrestor and emulate it, that would likely
prove sufficient (even just xgetbv may be sufficient,
but I'd have to do further work to validate that).
However, I don't think it's possible to trap these
instructions without also disabling the corresponding
xstate components, which we do not want, since
those instructions do actually need to get executed.

Thanks,
Keno
