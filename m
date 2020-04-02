Return-Path: <SRS0=iZC5=5S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6AE28C43331
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Apr 2020 14:50:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3D9F5206F5
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Apr 2020 14:50:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="arhfmja5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388748AbgDBOus (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Apr 2020 10:50:48 -0400
Received: from mail-lj1-f177.google.com ([209.85.208.177]:43459 "EHLO
        mail-lj1-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729549AbgDBOus (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Apr 2020 10:50:48 -0400
Received: by mail-lj1-f177.google.com with SMTP id g27so3489097ljn.10
        for <linux-kernel@vger.kernel.org>; Thu, 02 Apr 2020 07:50:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=0qdeGekIQvzSZQ/bchGHqOPc0D8b8p/R5z9ULmhHISQ=;
        b=arhfmja5XpBIHDuFu7oNorGl4wxrU0DpZmvk3vHpL0QOXMDs1U44LN6ygn3MBJ/eR3
         3wLXRbPkBU+NCWdir2hE0fYj+xCGAf31wkRp7hNMxDnwTg3711UfFAbMQIBv8rl0gnzS
         6zF+2Rbql09DPKB+8obYRkfmSPme12s2Kds2gbdUQxcs6t0y0mRwoEjxEm0rTT/uX5kR
         NNRtmJkZuVEVGSLeq191W5Hbi2hNkc/+mLCYkevKLXtKekdZt6pKC3QFksb7rD6s4dE6
         v2wHRLKK3slv+B7Va2Jr0nwgP5poY2NSI6ZEJmImTZ9gAcKu3XNK9O+8dChhnTt63LcN
         UFxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=0qdeGekIQvzSZQ/bchGHqOPc0D8b8p/R5z9ULmhHISQ=;
        b=JIqZczd9fI0xA3ach3APJtTu9nAuLBM1/tuXdgqCRAUMwDE4TADuLiix1pa86Aa7nc
         MiquM1fEyz/3Ug5U+FSIzcwenccI+gYxXI+2c9UypVZWReTMdU1dmPKCv0RtkRkV1HSp
         6QzccqFcocPEPpwaHFI+C02L6INfXw87qVETxzicsN3bFGQJGeXdT69znP+gu63UdBQM
         e2Mt9xSxPtVzAm5lUVd71XY4quKX/jnaCNSXtd0n7sdl2jHiM3b/60w7njUCUmvUCvL4
         SOtFprnoAm161ZjezvLOHZLgPM97aOI4hNJrtp/ediMCveuncNhYuoI2Wss4q2ZHcJOA
         Ikiw==
X-Gm-Message-State: AGi0PuaXmjGiMFHGYmjLtjfnKakNXQeYddFXKBDHkwcqLotqEe5yfzGi
        qBY50Tck2HoPbcol+hkcVFMjBc1OCL6QlQClZVUYZw==
X-Google-Smtp-Source: APiQypK+T2KMF7eZlc/bzKtEy+1N95v/ZTucX9SRvM+kNdBq97blBB+uE/UoYTni754wd6YAZlQUSWnSxRjy3C1jCUk=
X-Received: by 2002:a2e:5048:: with SMTP id v8mr2060638ljd.99.1585839045709;
 Thu, 02 Apr 2020 07:50:45 -0700 (PDT)
MIME-Version: 1.0
References: <CAG48ez2Sx4ELkM94aD_h_J7K7KBOeuGmvZLKRkg3n_f2WoZ_cg@mail.gmail.com>
 <4c5fe55d-9db9-2f61-59b2-1fb2e1b45ed0@amd.com> <CAG48ez1nHt2BRApHPp2S6rd4kr3P2kFsgHvStUsW7rqHSJprgg@mail.gmail.com>
 <87k12yns9z.fsf@nanos.tec.linutronix.de>
In-Reply-To: <87k12yns9z.fsf@nanos.tec.linutronix.de>
From:   Jann Horn <jannh@google.com>
Date:   Thu, 2 Apr 2020 16:50:19 +0200
Message-ID: <CAG48ez1esuROQU1J1L4Zrt91vRX4GYwzrfAs+K5mr-_TLq3saQ@mail.gmail.com>
Subject: Re: AMD DC graphics display code enables -mhard-float, -msse, -msse2
 without any visible FPU state protection
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
        Harry Wentland <harry.wentland@amd.com>,
        Leo Li <sunpeng.li@amd.com>, amd-gfx@lists.freedesktop.org,
        Alex Deucher <alexander.deucher@amd.com>,
        "David (ChunMing) Zhou" <David1.Zhou@amd.com>,
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

On Thu, Apr 2, 2020 at 11:36 AM Thomas Gleixner <tglx@linutronix.de> wrote:
> Jann Horn <jannh@google.com> writes:
> > On Thu, Apr 2, 2020 at 9:34 AM Christian K=C3=B6nig <christian.koenig@a=
md.com> wrote:
> >> Am 02.04.20 um 04:34 schrieb Jann Horn:
> >> > [x86 folks in CC so that they can chime in on the precise rules for
> >> > this stuff]
>
> They are pretty simple.
>
> Any code using FPU needs to be completely isolated from regular code
> either by using inline asm or by moving it to a different compilation
> unit. The invocations need fpu_begin/end() of course.
[...]
> We really need objtool support to validate that.
>
> Peter, now that we know how to do it (noinstr, clac/stac) we can emit
> annotations (see patch below) and validate that any FPU instruction is
> inside a safe region. Hmm?

One annoying aspect is that for the "move it to a different
compilation unit" method, objtool needs to know at compile time
(before linking) which functions are in FPU-enabled object files,
right? So we'd need to have some sort of function annotation that gets
plumbed from the function declaration in a header file through the
compiler into the ELF file, and then let objtool verify that calls to
FPU-enabled methods occur only when the FPU is available? (Ideally
something that covers indirect calls... but this would probably get
really complicated unless we can get the compiler to include that
annotation in its type checking.)
