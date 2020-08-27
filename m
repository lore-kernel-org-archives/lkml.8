Return-Path: <SRS0=OCv1=CF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.4 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7A64C433E1
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Aug 2020 13:40:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7C8D0207CD
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Aug 2020 13:40:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="VFTQz853"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728009AbgH0Nku (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Aug 2020 09:40:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726853AbgH0Ney (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Aug 2020 09:34:54 -0400
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com [IPv6:2607:f8b0:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70421C061264
        for <linux-kernel@vger.kernel.org>; Thu, 27 Aug 2020 06:34:54 -0700 (PDT)
Received: by mail-pf1-x441.google.com with SMTP id k18so3510682pfp.7
        for <linux-kernel@vger.kernel.org>; Thu, 27 Aug 2020 06:34:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=fOtOQwtAMnsiuZkel6P+QKLSzAWGFcwbvl4MhWbUo1c=;
        b=VFTQz853WO4K2b97Gw8Vq+2NCsRZgwv1PoyWPiyF79O4L1GRoHXehFI0hrHO5E+3L7
         nrLw54vjbmJAxJfu7iwZojsuLgK1EkXhuuF5hJg/zw7PF1ifJG/xBnl50S06cC19W/gq
         i8v8c7i9DpklX0WWeUhuKJ027ioHReA6qzTwjXZQmmsBYH86hl6lvvvHIdQI5xUCw35n
         djVrMOcEzNUHZDX9Q0JRJ+54DxyZ3qczuN01T1vEaxVf6TNlY1JzVpxVurEPofRICLTQ
         sehOfUQssBoXDLpPl5PGDtsh+7wUv7SMNBwZa5CtaOi0/dpNOGbR+wxV8VZ0akl3pAEH
         TFSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=fOtOQwtAMnsiuZkel6P+QKLSzAWGFcwbvl4MhWbUo1c=;
        b=TQABgIuVJKddzEwmFzPJ11lKKWQK88KwZQkU+l6WcLdT1Cug6IG5oelAB1PQDfddj2
         lAAF8/3qFYCMbZoIaKzBU0a/k3dwaDZ4l5tySjprX2sAPz/OzUiE/HS/6Mscxi1MI/BJ
         IXXJiIokLsriyYra2C90Fb/09RmhZfz/lH8UyxNbbo0bM6Q5gI4WGyZNITe1eJ+zmfI6
         F5rHOz0zCN3yWw4zmmiA4tSr+5RgoHbx6d/y4IQSGLg0/Ozq1dl4MEEjX3UOgull6qFS
         e4bWN8JrT3xb/TDAWbsGWIHLtFND5LR18ae3xlRVqYWksYCsHqWlQaerYxqQfV9nZdTv
         +ECw==
X-Gm-Message-State: AOAM531ocjTnqSuRVgxTB4+pA+4J6ZkFPA0FeriojUcX26uV4Gx95IA8
        oN8JhADommVb48Whp/GQBGRfOOVHAOeGGThAMSvZyQ==
X-Google-Smtp-Source: ABdhPJwZDZ1YWgPOElrp9s/sDw0FY/M9AwCUa4WE07eW6R7ae8uB2U5pgCBMXEphtljLWo5s8MA4P1VEg3eAT76xSLQ=
X-Received: by 2002:a17:902:b589:: with SMTP id a9mr15940749pls.98.1598535293587;
 Thu, 27 Aug 2020 06:34:53 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1597425745.git.andreyknvl@google.com> <f173aacd755e4644485c551198549ac52d1eb650.1597425745.git.andreyknvl@google.com>
 <20200827095429.GC29264@gaia> <CAAeHK+xHQDMsTehppknjNTEMFh18ufWB1XLUGdVFoc-QZ-mVrw@mail.gmail.com>
 <20200827131045.GM29264@gaia>
In-Reply-To: <20200827131045.GM29264@gaia>
From:   Andrey Konovalov <andreyknvl@google.com>
Date:   Thu, 27 Aug 2020 15:34:42 +0200
Message-ID: <CAAeHK+xraz7E41b4LW6VW9xOH51UoZ+odNEDrDGtaJ71n=bQ3A@mail.gmail.com>
Subject: Re: [PATCH 21/35] arm64: mte: Add in-kernel tag fault handler
To:     Catalin Marinas <catalin.marinas@arm.com>
Cc:     Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        kasan-dev <kasan-dev@googlegroups.com>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Alexander Potapenko <glider@google.com>,
        Marco Elver <elver@google.com>,
        Evgenii Stepanov <eugenis@google.com>,
        Elena Petrova <lenaptr@google.com>,
        Branislav Rankov <Branislav.Rankov@arm.com>,
        Kevin Brodsky <kevin.brodsky@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 27, 2020 at 3:10 PM Catalin Marinas <catalin.marinas@arm.com> wrote:
>
> On Thu, Aug 27, 2020 at 02:31:23PM +0200, Andrey Konovalov wrote:
> > On Thu, Aug 27, 2020 at 11:54 AM Catalin Marinas
> > <catalin.marinas@arm.com> wrote:
> > > On Fri, Aug 14, 2020 at 07:27:03PM +0200, Andrey Konovalov wrote:
> > > > +static int do_tag_recovery(unsigned long addr, unsigned int esr,
> > > > +                        struct pt_regs *regs)
> > > > +{
> > > > +     report_tag_fault(addr, esr, regs);
> > > > +
> > > > +     /* Skip over the faulting instruction and continue: */
> > > > +     arm64_skip_faulting_instruction(regs, AARCH64_INSN_SIZE);
> > >
> > > Ooooh, do we expect the kernel to still behave correctly after this? I
> > > thought the recovery means disabling tag checking altogether and
> > > restarting the instruction rather than skipping over it.
> >
> > The intention is to be able to catch multiple MTE faults without
> > panicking or disabling MTE when executing KASAN tests (those do
> > multiple bad accesses one after another).
>
> The problem is that for MTE synchronous tag check faults, the access has
> not happened, so you basically introduce memory corruption by skipping
> the access.

Yes, you're right.

> > We do arm64_skip_faulting_instruction() for software tag-based KASAN
> > too, it's not ideal, but works for testing purposes.
>
> IIUC, KASAN only skips over the brk instruction which doesn't have any
> other side-effects.

Oh, yes, indeed. For some reason I confused myself thinking that we
also skip the access for software KASAN.

> Has the actual memory access taken place when it
> hits the brk?

IIRC, no, but it will be executed right after we skip the brk.

> > Can we disable MTE, reexecute the instruction, and then reenable MTE,
> > or something like that?
>
> If you want to preserve the MTE enabled, you could single-step the
> instruction or execute it out of line, though it's a bit more convoluted
> (we have a similar mechanism for kprobes/uprobes).
>
> Another option would be to attempt to set the matching tag in memory,
> under the assumption that it is writable (if it's not, maybe it's fine
> to panic). Not sure how this interacts with the slub allocator since,
> presumably, the logical tag in the pointer is wrong rather than the
> allocation one.
>
> Yet another option would be to change the tag in the register and
> re-execute but this may confuse the compiler.

Which one of these would be simpler to implement?

Perhaps we could somehow only skip faulting instructions that happen
in the KASAN test module?.. Decoding stack trace would be an option,
but that's a bit weird.

Overall, this feature is not essential, but will make testing simpler.

> > When running in-kernel MTE in production, we'll either panic or
> > disable MTE after the first fault. This was controlled by the
> > panic_on_mte_fault option Vincenzo initially had.
>
> I prefer to disable MTE, print something and continue, but no panic.

OK, we can do this.

> > > We only skip if we emulated it.
> >
> > I'm not sure I understand this part, what do you mean by emulating?
>
> Executing it out of line or other form of instruction emulation (see
> arch/arm64/kernel/probes/simulate-insn.c) so that the access actually
> takes place. But you can single-step or experiment with some of the
> other tricks above.
>
> --
> Catalin
