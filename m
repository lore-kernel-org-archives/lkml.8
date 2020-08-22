Return-Path: <SRS0=ximN=CA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69889C433E1
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Aug 2020 03:03:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4213420720
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Aug 2020 03:03:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kylehuey.com header.i=@kylehuey.com header.b="VKB+t35U"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726839AbgHVDDd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Aug 2020 23:03:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726387AbgHVDDa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Aug 2020 23:03:30 -0400
Received: from mail-ed1-x541.google.com (mail-ed1-x541.google.com [IPv6:2a00:1450:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52A88C061573
        for <linux-kernel@vger.kernel.org>; Fri, 21 Aug 2020 20:03:29 -0700 (PDT)
Received: by mail-ed1-x541.google.com with SMTP id bs17so3206928edb.1
        for <linux-kernel@vger.kernel.org>; Fri, 21 Aug 2020 20:03:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kylehuey.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=0RW8fmxrc/Tuk54ldRQbS//KunL/5Kwenn69hnksJ9o=;
        b=VKB+t35UvT7NJfgovMpHu4a0D0ezU7EolNcMzfHUYvht8IPJa70MXR7BQ+a+aNrarq
         o7ZS/gwlVHMkyQbEKxLu4bw0xejiJbIMYyFfVGsvnZ4tKEOAwvQrQN0Xg0TRctriHIAO
         XCWLeqnBd7ENRqDKwy1Z9qvsoZSa8fzqgnkO5QThaYKl7xqqCr+h0jzVpKFpwu/heCDd
         Caa3v32319FhmjdB3hiSuRfYKUJkzxORgi6mZmzJd+zqzuTnooZeONLUOhhR6Eyw0zsv
         HfSAS+AuSI39Nh24hKJ8zi6RVFDonfSLez/H+1ADMfRuqjvCImQW95PeOQDIDEyeogQm
         YyKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=0RW8fmxrc/Tuk54ldRQbS//KunL/5Kwenn69hnksJ9o=;
        b=XhiTSH/8xk+T2RVMdL3D44wvVLESgEmU+XKCPF5dVPPMVzo7mLPl6JysHOgd5wt6zG
         bXMhmh2xZnwhSakAcFsBZxOlUY7BebaamygdXXCAYe/ZNaK+6xBZlJkKHs8oY5wJNccc
         haCXcVoTC4q8ZzMzs7um10iMuJfNfRiSsZeRUSTYbP2bjN2YOVR9Pg4nXcNTvwE4ZnIw
         Usy2A4WzK1JlIGSnvtrzVv48WolNXo3+l9GLYRyk9WxS2okshNr3sJsZT3jRQGRMHvWr
         gQ22W/uc1fSPjs5I+uZjtbKF40PqpYyx4dQWyPj9v8B2lnDY+Fn5EDXcGeXvMpcqv/e1
         GGKg==
X-Gm-Message-State: AOAM533g4Kvdv1qz7VPojW3Z5gCPO78aOa9pU/q8xSQJYBGQ8aPsL656
        POXL2Y/UfWgzUYz/BdMivrN+iF1gCkgpGQP47GpeHw==
X-Google-Smtp-Source: ABdhPJwDsrbZWUV78Yms3gkSAj0WKh9pyOAOlnRsQYbRPvBlIk6t8bsvBmL9rtzTVmfT8qSZQV6Uiys/RXD/rQrh21w=
X-Received: by 2002:a05:6402:13c4:: with SMTP id a4mr5777622edx.108.1598065407767;
 Fri, 21 Aug 2020 20:03:27 -0700 (PDT)
MIME-Version: 1.0
References: <CAP045AqiT75B9o5OV+SJT8uTzo7A55Y1BxjNcaSuxtm5EoAxaQ@mail.gmail.com>
 <139EF22C-FA09-42B8-BC31-E858CE5970B1@amacapital.net>
In-Reply-To: <139EF22C-FA09-42B8-BC31-E858CE5970B1@amacapital.net>
From:   Kyle Huey <me@kylehuey.com>
Date:   Fri, 21 Aug 2020 20:03:16 -0700
Message-ID: <CAP045AqZjh0T-FrrcfTHcpda51OxTg-Ks3iRGhZa==6bn20SFQ@mail.gmail.com>
Subject: Re: [REGRESSION] x86/cpu fsgsbase breaks TLS in 32 bit rr tracees on
 a 64 bit system
To:     Andy Lutomirski <luto@amacapital.net>
Cc:     "Bae, Chang Seok" <chang.seok.bae@intel.com>,
        "Robert O'Callahan" <rocallahan@gmail.com>,
        Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>,
        "H . Peter Anvin" <hpa@zytor.com>, Andi Kleen <ak@linux.intel.com>,
        "Shankar, Ravi V" <ravi.v.shankar@intel.com>,
        LKML <linux-kernel@vger.kernel.org>,
        "Hansen, Dave" <dave.hansen@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 21, 2020 at 7:53 PM Andy Lutomirski <luto@amacapital.net> wrote=
:
>
>
>
> > On Aug 21, 2020, at 2:33 PM, Kyle Huey <me@kylehuey.com> wrote:
> >
> > =EF=BB=BFOn Fri, Aug 21, 2020 at 1:08 PM Bae, Chang Seok
> > <chang.seok.bae@intel.com> wrote:
> >>
> >>
> >>>> On Aug 20, 2020, at 21:41, Kyle Huey <me@kylehuey.com> wrote:
> >>>
> >>> On the x86-64 5.9-rc1 TLS is completely broken in 32 bit tracees when
> >>> running under rr[0]. Booting the kernel with `nofsgsbase` fixes it an=
d
> >>> I bisected to https://git.kernel.org/pub/scm/linux/kernel/git/torvald=
s/linux.git/commit/?h=3Dv5.8&id=3D673903495c85137791d5820d690229efe09c8f7b.
> >>>
> >>> STR:
> >>> 1. Build rr from source by
> >>> a. git clone https://github.com/mozilla/rr
> >>> b. mkdir rr/obj
> >>> c. cd rr/obj
> >>> d. cmake ..
> >>> e. make -j16
> >>> 2. Run the simple 32 bit tracee outside of rr with `./bin/simple_32`.
> >>> It should print a message and exit cleanly.
> >>> 3. Run it under rr with `./bin/rr ./bin/simple_32`.
> >>>
> >>> It should behave the same way, but with fsgsbase enabled it will
> >>> segfault. The `simple_32` binary is a simple "hello world" type
> >>> program but it does link to pthreads, so pre-main code attempts to
> >>> access TLS variables.
> >>>
> >>> The interplay between 32 bit and 64 bit TLS is dark magic to me
> >>> unfortunately so this is all the useful information I have.
> >>
> >> As I run it and collect the ptrace logs, it starts to set FSBASE with
> >> some numbers, e.g. 140632147826496, and then later attempts to set GS
> >> with 99 through putreg(), not putreg32().
> >>
> >> With FSGSBASE, the FS/GS base is decoupled from the selector. Andy
> >> made putreg32() to retain the old behavior, fetching FS/GS base
> >> according to the index, but the putreg() does not do. So, rr probably
> >> relies on the old behavior as observed to setting the GS index only.
> >> But it was previously considered to be okay with this comment [1]:
> >>
> >>   "Our modifications to fs/gs/fs_base/gs_base are always either a)
> >>    setting values that the kernel set during recording to make them
> >>    happen during replay or b) emulating PTRACE_SET_REGS that a tracee
> >>    ptracer tried to set on another tracee. Either way I think the
> >>    effects are going to be the same as what would happen if the
> >>    program were run without rr."
> >>
> >> It is not straightforward to go into the rr internal to me. Robert,
> >> any thought?
> >
> > Hmm. When we are running a 32 bit tracee in a 64 bit build of rr we
> > internally convert between the 32 bit and 64 bit user_regs_structs[0]
> > at the ptrace boundary. This does not preserve the fs/gsbase (because
> > there is no fs/gsbase in the 32 bit user_regs_struct, of course).
> >
> > 40c45904f818c1f6555294ca27afc5fda4f09e68 added magic for a 32 bit
> > tracer tracing a 32 bit tracee on a 64 bit kernel, but it looks like a
> > 64 bit tracer tracing a 32 bit tracee on a 64 bit kernel *is* now
> > expected to preserve the fs/gsbase values (or die, in our case).
> >
> > Is that correct?
>
> I was certainly not expecting rr to do this, and I thought I had asked in=
 advance.  What exact ptrace() calls are you doing here?  Is this POKEUSER =
or something else?  Breaking rr is at least impolite, and I=E2=80=99d like =
to fix this.

I believe we are PTRACE_GETREGSing and later PTRACE_SETREGSing, but
doing the latter with garbage for fs/gs_base for a 32 bit tracee. That
didn't used to matter (because those values were completely ignored
for a 32 bit tracee) but now it does.

There's a good case that that's our fault and I'm happy to spend my
"don't break userspace" points somewhere else ;)

- Kyle
