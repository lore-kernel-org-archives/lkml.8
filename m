Return-Path: <SRS0=g10L=63=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6CD6C433E1
	for <linux-kernel@archiver.kernel.org>; Wed, 13 May 2020 23:08:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BFC312065C
	for <linux-kernel@archiver.kernel.org>; Wed, 13 May 2020 23:08:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Qh7lvFu7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732434AbgEMXId (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 May 2020 19:08:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1732392AbgEMXIa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 May 2020 19:08:30 -0400
Received: from mail-pl1-x643.google.com (mail-pl1-x643.google.com [IPv6:2607:f8b0:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E7A2C061A0E
        for <linux-kernel@vger.kernel.org>; Wed, 13 May 2020 16:08:29 -0700 (PDT)
Received: by mail-pl1-x643.google.com with SMTP id t7so427278plr.0
        for <linux-kernel@vger.kernel.org>; Wed, 13 May 2020 16:08:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=qrc+zALKhm7UR0okg2VxygijLhPHdyDYt6UnXc1+qEk=;
        b=Qh7lvFu7Q7FSluMhlA+8KOS62pXg1rxQC1Ogk+ACNtMIaCyE9ShN6VB9f9gGDvteW4
         gypT5Ev3vDl69jha5hOD76TZn8yRrjhUMxAWk1zqNUDl4SXtliMPJmL50nvFC0c/bC3V
         lRIsq85AmTyx2GxwUTqokmeiKV/xXeYZWSBXw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=qrc+zALKhm7UR0okg2VxygijLhPHdyDYt6UnXc1+qEk=;
        b=UFQqW5EaG4YW3Iman+edOJsbRC6CYooj4LZfIEe+1W9IASjkBtbqF8yc8zpbZ17uDp
         J1vPZLHQFnq07yi1H4yh2xC9+vyRQVZW2P9+fv9PVvgmwPakZ7mYh3Ck7bUxoQGQyMzx
         HAzEZa1k1mnTPEdlsfH6uMj5mvzT3JSJ3CGjlAVDj+aUVKe6K5I2JVr3UnvAC3FF6pHc
         tFzZiP8BbwVw94Nsjz2rySoQMUabwsS7maSgUYNTHA4h9hTMNBw6/kIoLgQE3/BO9iln
         h4/nvdRilozYgtmSNshADBrmFvsKgR26cxnMzvQAzSGGqX8z2U6e+iU/0VCesxOwBaYz
         VxTQ==
X-Gm-Message-State: AGi0PuZuc/KWhL1lFOrw5sPVtxvaX2Tl6WhI2DkpaZH9sfAEWeOXbR3F
        99xwIGypwdWe0fEb3w1Gkqqw6mktlY0=
X-Google-Smtp-Source: APiQypIC95WO6zapnYJu+clR5WAb4BkJ+bKNL8ecWaB8HKs1F+M+TwF+Wpg9tsvdBFehI4qaz05YSQ==
X-Received: by 2002:a17:90a:ba18:: with SMTP id s24mr39292689pjr.192.1589411308676;
        Wed, 13 May 2020 16:08:28 -0700 (PDT)
Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com. [209.85.216.43])
        by smtp.gmail.com with ESMTPSA id q62sm17136421pjh.57.2020.05.13.16.08.27
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 13 May 2020 16:08:28 -0700 (PDT)
Received: by mail-pj1-f43.google.com with SMTP id a5so11731147pjh.2
        for <linux-kernel@vger.kernel.org>; Wed, 13 May 2020 16:08:27 -0700 (PDT)
X-Received: by 2002:a1f:9605:: with SMTP id y5mr1422470vkd.75.1589411305040;
 Wed, 13 May 2020 16:08:25 -0700 (PDT)
MIME-Version: 1.0
References: <20200428211351.85055-1-dianders@chromium.org> <20200428141218.v3.5.I22067ad43e77ddfd4b64c2d49030628480f9e8d9@changeid>
 <20200511145908.GA22040@willie-the-truck> <CAD=FV=W1F-B7SUwxebhhH2HS+fN4sYv4RHvvKud5a+00J0T=SA@mail.gmail.com>
 <20200512073552.GA1538@willie-the-truck> <CAD=FV=WuKS7c4WNiLKm+bjRF8Rd7wM1y7THWzJhVhUyExNiiVg@mail.gmail.com>
 <20200513061745.GB17433@willie-the-truck>
In-Reply-To: <20200513061745.GB17433@willie-the-truck>
From:   Doug Anderson <dianders@chromium.org>
Date:   Wed, 13 May 2020 16:08:13 -0700
X-Gmail-Original-Message-ID: <CAD=FV=U+JiK1_Lka1PB9DWTsKOowhL+Q+i1yK7=T-4E+zue36g@mail.gmail.com>
Message-ID: <CAD=FV=U+JiK1_Lka1PB9DWTsKOowhL+Q+i1yK7=T-4E+zue36g@mail.gmail.com>
Subject: Re: [PATCH v3 05/11] arm64: Add call_break_hook() to early_brk64()
 for early kgdb
To:     Will Deacon <will@kernel.org>
Cc:     Jason Wessel <jason.wessel@windriver.com>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andy Gross <agross@kernel.org>,
        kgdb-bugreport@lists.sourceforge.net,
        Catalin Marinas <catalin.marinas@arm.com>,
        linux-serial@vger.kernel.org, Sumit Garg <sumit.garg@linaro.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Frank Rowand <frowand.list@gmail.com>, bp@alien8.de,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Jiri Slaby <jslaby@suse.com>,
        Alexios Zavras <alexios.zavras@intel.com>,
        Allison Randal <allison@lohutok.net>,
        Dave Martin <Dave.Martin@arm.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        James Morse <james.morse@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        jinho lim <jordan.lim@samsung.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Tue, May 12, 2020 at 11:17 PM Will Deacon <will@kernel.org> wrote:
>
> Hey Doug,
>
> On Tue, May 12, 2020 at 08:27:50AM -0700, Doug Anderson wrote:
> > On Tue, May 12, 2020 at 12:36 AM Will Deacon <will@kernel.org> wrote:
> > > On Mon, May 11, 2020 at 03:45:02PM -0700, Doug Anderson wrote:
> > > > On Mon, May 11, 2020 at 7:59 AM Will Deacon <will@kernel.org> wrote:
> > > > > On Tue, Apr 28, 2020 at 02:13:45PM -0700, Douglas Anderson wrote:
> > > > > > diff --git a/arch/arm64/kernel/traps.c b/arch/arm64/kernel/traps.c
> > > > > > index cf402be5c573..a8173f0c1774 100644
> > > > > > --- a/arch/arm64/kernel/traps.c
> > > > > > +++ b/arch/arm64/kernel/traps.c
> > > > > > @@ -1044,6 +1044,9 @@ int __init early_brk64(unsigned long addr, unsigned int esr,
> > > > > >       if ((comment & ~KASAN_BRK_MASK) == KASAN_BRK_IMM)
> > > > > >               return kasan_handler(regs, esr) != DBG_HOOK_HANDLED;
> > > > > >  #endif
> > > > > > +     if (call_break_hook(regs, esr) == DBG_HOOK_HANDLED)
> > > > > > +             return 0;
> > > > >
> > > > > I think this just means we're not running debug_traps_init() early enough,
> > > > > and actually the KASAN early handler is unnecessary too.
> > > > >
> > > > > If we call debug_traps_init() directly from setup_arch() and drop the
> > > > > arch_initcall(), can we then drop early_brk64 entirely?
> > > >
> > > > It seems to work in my testing.  ...but the worry I have is the
> > > > comment right before trap_init().  It says:
> > > >
> > > > /* This registration must happen early, before debug_traps_init(). */
> > >
> > > I /think/ the reason for this is because debug_traps_init() replaces the
> > > BRK vector, so if that runs before the break hooks have been registered
> > > for e.g. BUG() then BUG() won't work during that window. Hmm, so dropping
> > > early_brk64 is problematic after all. Damn.
> > >
> > > Is trap_init() early enough for you? If so, we could call debug_traps_init()
> > > from traps_init() after registering the break hooks.
> >
> > "Early enough" is a subjective term, of course.  The earlier we can
> > init, the earlier we can drop into the debugger.  ...but, of course,
> > everyone thinks their feature is the most important and should be
> > first, so let's see...
> >
> > Certainly if we waited until trap_init() it wouldn't be early enough
> > to set "ARCH_HAS_EARLY_DEBUG".  Setting that means that debugging is
> > ready when early params are parsed and those happen at the start of
> > setup_arch().  The call to trap_init() happens a bit later.
> >
> > If we decide that we just don't care about getting
> > "ARCH_HAS_EARLY_DEBUG" to work then the earliest we'll be able to
> > break into the debugger (via kgdbwait) is dbg_late_init().  That
> > _does_ happen after trap_init() so your solution would work.
> >
> > As a person who spends most of his time in driver land, it wouldn't be
> > the end of the world to wait for dbg_late_init().  That's still much
> > earlier than most code I'd ever debug.  ...and, bonus points is that
> > if we hit a crash any time after earlyparams we _will_ still drop into
> > the debugger.  It's only breakpoints that won't be available until
> > dbg_late_init().
> >
> >
> > tl;dr:
> >
> > * If we care about "kgdbwait" and breakpoints working as early as
> > possible then we need my patch.
> >
> > * If we are OK w/ a slightly later "kgdbwait" then I think we can move
> > debug_traps_init() to trap_init() and get rid of the early version.
> >
> >
> > Please let me know which way you'd like to proceed.
>
> Let's go with the trap_init() approach for now, and we can revisit it later
> if somebody has a compelling reason to initialise things earlier. However,
> I don't think you can remove early_brk64(), as it's needed for BUG() to
> work correctly.

Posted at:

https://lore.kernel.org/r/20200513160501.1.I0b5edf030cc6ebef6ab4829f8867cdaea42485d8@changeid

I'll also reply to the v4 version of this patch to point at it.

-Doug
