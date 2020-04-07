Return-Path: <SRS0=z/zp=5X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52134C2D0EC
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Apr 2020 22:16:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DF53220730
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Apr 2020 22:16:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=juliacomputing-com.20150623.gappssmtp.com header.i=@juliacomputing-com.20150623.gappssmtp.com header.b="NFmoJFD9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726481AbgDGWQc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Apr 2020 18:16:32 -0400
Received: from mail-io1-f68.google.com ([209.85.166.68]:37627 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726380AbgDGWQc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Apr 2020 18:16:32 -0400
Received: by mail-io1-f68.google.com with SMTP id n20so5111938ioa.4
        for <linux-kernel@vger.kernel.org>; Tue, 07 Apr 2020 15:16:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=juliacomputing-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=+YHrzs2XPGAqjRasG+YxC96yDyxPmKpa+mwePIDhyYI=;
        b=NFmoJFD9/fSsMOlsdKH/bQgFHeTGKGos97k1EE064Kd7wUj5Ml/IWBtOjYaxNwQ3BX
         /9tk64StRSEsVWiROBTzm9M2UoGw7kW/1IiEOmGwEJxxJlzx0WMhj7I2cZ6lE9dNeq8R
         Dc65W2NMvYcMeWUVsw+gdm0FFaxE1ROWtypxnlMUCY5Uo9oBJXn3a8JpZfGDG8mWZuI2
         WkEQKy2/uMkC5QJ8HWhv/gV+R/vGj7HMN3cCqqA53pDpWyET7sKyi8npopt2UyBgRGzA
         mEIq6t3HxdYQp0RqX/l5UCRSSl/xSwRGfp+/cKAPARkvzADRJgNVduZHIUKoxNHZkS6F
         XB9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+YHrzs2XPGAqjRasG+YxC96yDyxPmKpa+mwePIDhyYI=;
        b=h7gdSiWefkyT403hKLwQb4aaowpLv4edY9Pt7ZL139n7kmiQ7AxocjSUY/4PrYwgAO
         OENS1rIVLLyC9tgBbUwh/+jx5yamTuf9WFBhJiHhfpUfa1wVKrPRIvAyc+Z2hnO+/3PS
         R7BYJfUYTsgSNecuv5kbm+xZgwZcbvrkiwq/6LyW5jrcOsrOPt8wujLKJmxighhPbwUV
         A1+XPMqPra+xx0UQx3+7TpIp94k7Ectls9cl4a0saHFc+Sg1RrZwRXh5XQoZyrjVoTJd
         gLLBFfGEWJbTg3mKV2PIwejkSOpaBoaaASX2IJG5dv+r3w4fb/+fMAKkGr1whrHNKSPw
         N5cw==
X-Gm-Message-State: AGi0PuZGRitjzPP9yRAgOEhzx0t5J5WMs24Rzpc3ffupP8vuRovQjwby
        seJoW0OKWzoZQhi82iA2M9NJaSr/EH0yEgtl0dXq3A==
X-Google-Smtp-Source: APiQypIwEA3RSbllQhtbkGB6f/PER8aQGoRVQymPwJiAq7ezLIRoJezpBLGk4jXxyv7DTPEQO2AhuV9PchQdz+RN8DM=
X-Received: by 2002:a02:cd2d:: with SMTP id h13mr4047248jaq.46.1586297791226;
 Tue, 07 Apr 2020 15:16:31 -0700 (PDT)
MIME-Version: 1.0
References: <20200407011259.GA72735@juliacomputing.com> <8f95e8b4-415f-1652-bb02-0a7c631c72ac@intel.com>
 <CABV8kRw1TQsqs+z43bSfZ5isctuFGMB4g_ztDYihiiXHcy4nVA@mail.gmail.com>
 <5208ad1e-cd9b-d57e-15b0-0ca935fccacd@intel.com> <CABV8kRzfR32+MpAvTAPHCN902WtHSxySujcO2yAB3OT0caVDJg@mail.gmail.com>
 <9921cb2e-a7cb-c1d0-b120-c08f06be7c7f@intel.com>
In-Reply-To: <9921cb2e-a7cb-c1d0-b120-c08f06be7c7f@intel.com>
From:   Keno Fischer <keno@juliacomputing.com>
Date:   Tue, 7 Apr 2020 18:15:54 -0400
Message-ID: <CABV8kRxDkE1dQh0c2FkFpkUruiR0aD-hXbgd5-jcoCDiwYHs1A@mail.gmail.com>
Subject: Re: [RFC PATCH v2] x86/arch_prctl: Add ARCH_SET_XCR0 to set XCR0 per-thread
To:     Dave Hansen <dave.hansen@intel.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
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

> The userspace buffer is... a userspace buffer.  It is not and should not
> be tied to the format of the kernel buffer.

I don't think I disagree with you. However, I should point out that in
the kernel currently, the layout of this user space buffer changes depending
on the setting of the kernel XCR0 (Is this a good idea? Probably not -
certainly all the users I've looked at get this wrong and assume the
layout is fixed just variably sized, but that is how the kernel currently
works, so we're probably stuck with it)

> > Are you referring to a ptracer which runs with a modified XCR0, and
> > assumes that the value it gets back from ptrace will have an
> > XSTATE_BV equal to its own observed XCR0 and thus get confused about
> > the layout of the buffer (or potentially have not copied all of the
> > relevant xstate because it calculated a wrong buffer size)?
>
> I don't think it's insane for a process to assume that it can XRSTOR a
> buffer that it gets back from ptrace.  That seems like something that
> could clearly be an ABI that apps depend on.

Yes, that's fair, but I'm less worried about the case where
the ptracer itself is running with a modified XCR0,
because something had to explicitly opt that
process into that behavior. That piece can verify
that the application works fine, or alternatively fix
the system calls to emulate whatever behavior
that user application wants to build from this primitive.
I also believe that the issue I mentioned above,
where the ptrace xstate buffer is compacted will
cause it to fail to XRSTOR properly depending
on what the kernel XCR0 value is, and it won't XRSTORC
either, because we don't write the XCOMP_BV.

> Also, let's look at the comment about where XCR0 shows up in the ABI
> (arch/x86/include/asm/user.h):
>
> >  * For now, only the first 8 bytes of the software usable bytes[464..471] will
> >  * be used and will be set to OS enabled xstate mask (which is same as the
> >  * 64bit mask returned by the xgetbv's xCR0).
>
> That also makes it sound like we expect there to be a *SINGLE* value
> across the entire system.  It also makes me wonder *which* xgetbv is
> expected to match USER_XSTATE_XCR0_WORD.  It can't be the ptracee since
> we expect them to change XCR0.  It can't be the ptracer because they can
> use this new prctl too.  So does it refer to the kernel?  Or, should the
> new prctl() *disable* future ptrace()s?

It can't be the ptracee's XCR0, because that would be
breaking to the ptracers, which haven't opted into any
XCR0 modification. I don't think it should be the ptracer's
XCR0, because that would make the ptracer with the
modified XCR0 unable to trace a tracee with the full XCR0,
which, while potentially an acceptable trade-off, seems unnecessary.

> > If so, I think that's just a buggy ptracer. The kernel's xfeature
> > mask is available via ptrace and a well-behaved ptracer should use
> > that (e.g. gdb does, though it looks like it then also assumes that
> > the xstate has no holes, so it potentially gets the layout wrong
> > anyway).
>
> I'm trying to figure out what the semantics are of this whole thing.  It
> can't be "don't let userspace observe the real XCR0" because ptrace
> exposes that.  Is it, "make memory images portable, unless it's a memory
> image from ptrace"?

The semantics I want are "make userspace instructions behave
in the way that they would if XCR0 was this value". I'm open to
additionally extending this to sigframes, because I can't think of
a situation in which writing all those extra zeros would be useful,
but I'm also ok with the argument that it shouldn't affect any kernel
behavior whatsoever as Andy was suggesting earlier in the thread.

You can build something with more complete semantics on top of it,
as rr would, to more fully emulate the environment. You're probably
gonna be needing to trap CPUID anyway to mask off the relevant
features. I would prefer if the kernel didn't make assumptions here,
and just gave me the minimal primitive to build on top of.

> > In general, I don't really want the modified XCR0 to affect
> > anything other than the particular instructions that depend
> > on it and maybe the signal frame (though as I said before,
> > I'm open to either here).
>
> Just remember that, in the end, we don't get to say what a good ptracer
> or bad ptracer is.  If they're expecting semantics that we've kept
> constant for 10 years, we change the semantics, and the app breaks, the
> kernel is in the wrong.

Every ptracer is a bad ptracer - using this API "correctly" is essentially
impossible ;). I certainly agree that we can't change the behavior for
ptracers that haven't opted into XCR0 modification, but I don't think
that imposes any restriction on what a ptracer with modified XCR0
does (well, there's three possible options, and two reasonable ones,
so it should be one of those)

> I also don't feel like I have a good handle on what ptracers *do* with
> their XSAVE buffers that they get/set.  How many apps in a distro do
> something with this interface?

Well, anything that's a debugger would: gdb, lldb, rr.
CRIU's compel tool does too.
However, most ptracers probably don't touch the fpu state.
strace doesn't, proot doesn't.
I did some grepping around and the only other ptracer
I could find that was using this interface is
... linux (in um mode).

As a quick survey, gdb reads the kernel
XCR0 from the xstate and uses that to compute
the size of the xsave area (which I think is most correct).
lldb and rr use cpuid, which should be a
fine upper bound (overallocating is fine for ptrace)
assuming nobody is messing with cpuid *cough*,
though of course what just happens here is that they
just won't see the extra state. criu always uses 4096 bytes.
linux um requests the maximum it knows about.
None (including linux-um, oops) of them are aware
that the layout of the ptrace buffer is compressed if
XCR0 has holes in it (I'll leave it up to you to decide
whether that means we should fix it while hardware
with holes in its XCR0 is still rare - though you can
get into this situation with cmdline flags). All those
applications will have incorrect behavior if the kernel
XCR0 has a whole in it (they don't care about the
user XCR0 though, so that's somewhat unrelated
to this PR).

I don't see any compelling reason to hide additional
xstate from a ptracer with modified xcr0 if it asks for it.
