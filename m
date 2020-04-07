Return-Path: <SRS0=z/zp=5X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F9F6C2BA16
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Apr 2020 04:53:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 67A0A2064A
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Apr 2020 04:53:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kylehuey.com header.i=@kylehuey.com header.b="dvpRymoA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726704AbgDGExy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Apr 2020 00:53:54 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:36497 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725802AbgDGExy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Apr 2020 00:53:54 -0400
Received: by mail-lj1-f193.google.com with SMTP id b1so2191013ljp.3
        for <linux-kernel@vger.kernel.org>; Mon, 06 Apr 2020 21:53:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kylehuey.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=pm+tm2kIJY/IAP4sRjoyMLEHImGewUatZD3P6wd75sU=;
        b=dvpRymoA7Lat0DwGWj9BVhdjwHDo3iim6OxTvzJav8Y5gSVLJHmHjMLoJGSfDQajlJ
         4PTNbB+4zfYb/lXyOwo4Bh4JP6wnLgpVDQrPQY+0vAimzLj1BjgKaQ+2atw1DtJMT1bU
         dXf3kBNFyBDL3Ttzdf3qieI3xH603soAZpUsAKuBKDvUwN+4VIC4D01rX0TDg6ItPmsX
         QfpvbiASWkrgK9XxaPYye8mUQp4Yn4nGjonJxScFoyri8YYr5X7We2qQAcSlX++t1qBG
         kP9UbkMOjpd8yLfnlnmqAujXQ7Z/yRjvbWE5h2I2JDB6zF+7zYLoupmAetqlEbcrbXii
         nHRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=pm+tm2kIJY/IAP4sRjoyMLEHImGewUatZD3P6wd75sU=;
        b=AtEuJTJb0fNQPw7uxVjBZMopoFsmuwd9nmPJNX3u2yDBA3GrvFMeRV9lieqg3JkVdV
         TOu34wkxPKq+/klsLasuZUYjyLkkT1Tqpoa4ynEI/b6qC/MuQxIAHrxcbPI58J3B1X2w
         /kfY0+kzPUjatYowLJv9YZq/CL16pzD/OsjwtcK4RIXwgSxgIbtOgBW4sRsYQ+ikGyEH
         dwq6khPfIIt0vS88OMs8B/mTVU394YFpPFYii46N8hRH7CFR95+3vY/+gl9jx8jNjehf
         Dt8/dnUaW0czGN7+CGrncyDDsaxSTy+X6b/xv0oF05R0D+ipQgLk53vECI5ptMhoXg1w
         Ettw==
X-Gm-Message-State: AGi0PubbRH74UHAZvPmUuR77AB4oyzh69Vga4ZBVZb+ZUc8z82d6vQi0
        LEqmhrG4d6GXg4Ybq2SVOWtYln9vgWiqpsf+gq+b+w==
X-Google-Smtp-Source: APiQypISpY9TYKAO5YPA1gLRMdLSl+avCBHbi65+fxDPiqYWxgXcwk879vyOc/8Yyn6CH5prXqIJJHVgzaOmBC0TeNI=
X-Received: by 2002:a2e:8850:: with SMTP id z16mr432193ljj.284.1586235231489;
 Mon, 06 Apr 2020 21:53:51 -0700 (PDT)
MIME-Version: 1.0
References: <20200407011259.GA72735@juliacomputing.com> <2A931F48-D28F-46F3-827F-FF7F4D5D3E66@amacapital.net>
 <CABV8kRyi-5wyiCV3HsPfFx6x1_icV72BSy+5eK8UC3UCexTSCA@mail.gmail.com>
In-Reply-To: <CABV8kRyi-5wyiCV3HsPfFx6x1_icV72BSy+5eK8UC3UCexTSCA@mail.gmail.com>
From:   Kyle Huey <me@kylehuey.com>
Date:   Mon, 6 Apr 2020 21:53:40 -0700
Message-ID: <CAP045AohDoxZ+tvm+hBWWXgXz6N-z0+UWj--_o1AiVRubWYm6A@mail.gmail.com>
Subject: Re: [RFC PATCH v2] x86/arch_prctl: Add ARCH_SET_XCR0 to set XCR0 per-thread
To:     Keno Fischer <keno@juliacomputing.com>
Cc:     Andy Lutomirski <luto@amacapital.net>,
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
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 6, 2020 at 9:45 PM Keno Fischer <keno@juliacomputing.com> wrote=
:
>
> On Mon, Apr 6, 2020 at 11:58 PM Andy Lutomirski <luto@amacapital.net> wro=
te:
> >
> >
> > > On Apr 6, 2020, at 6:13 PM, Keno Fischer <keno@juliacomputing.com> wr=
ote:
> > >
> > > =EF=BB=BFThis is a follow-up to my from two-years ago [1].
> >
> > Your changelog is missing an explanation of why this is useful.  Why wo=
uld a user program want to change XCR0?
>
> Ah, sorry - I wasn't sure what the convention was around repeating the
> applicable parts from the v1 changelog in this email.
> Here's the description from the v1 patch:
>
> > The rr (http://rr-project.org/) debugger provides user space
> > record-and-replay functionality by carefully controlling the process
> > environment in order to ensure completely deterministic execution
> > of recorded traces. The recently added ARCH_SET_CPUID arch_prctl
> > allows rr to move traces across (Intel) machines, by allowing cpuid
> > invocations to be reliably recorded and replayed. This works very
> > well, with one catch: It is currently not possible to replay a
> > recording from a machine supporting a smaller set of XCR0 state
> > components on one supporting a larger set. This is because the
> > value of XCR0 is observable in userspace (either by explicit
> > xgetbv or by looking at the result of xsave) and since glibc
> > does observe this value, replay divergence is almost immediate.
> > I also suspect that people interested in process (or container)
> > live-migration may eventually care about this if a migration happens
> > in between a userspace xsave and a corresponding xrstor.
> >
> > We encounter this problem quite frequently since most of our users
> > are using pre-Skylake systems (and thus don't support the AVX512
> > state components), while we recently upgraded our main development
> > machines to Skylake.
>
> Basically, for rr to work, we need to tightly control any user-visible
> CPU behavior,
> either by putting in the CPU in the right state or by trapping and emulat=
ing
> (as we do for rdtsc, cpuid, etc). XCR0 controls a bunch of
> user-visible CPU behavior,
> namely:
> 1) The size of the xsave region if xsave is passed an all-ones mask
> (which is fairly common)
> 2) The return value of xgetbv

It's mentioned elsewhere, but I want to emphasize that the return
value of xgetbv is the big one because the dynamic linker uses this.
rr trace portability is essentially limited to machines with identical
xcr0 values because of it.

- Kyle

> 3) Whether instructions making use of the relevant xstate component traps
>
> In the v1 review, it was raised that user space could be adjusted to
> deal with these
> issues by always checking support in cpuid first (which is already emulat=
able).
> Unfortunately, we don't control the environment on the record side (rr su=
pports
> record on any Intel from the past decade - with the exception of a few th=
at have
> microarchitecture bugs causing problems; and kernel versions back to 3.11=
), so
> trying to patch user space is unfortunately a no-go for us (as well as of=
 course
> being a debugging tool, so we want to be able to help users debug if they=
 get
> uses of these instructions wrong).
>
> Another suggestion in the v1 review was to use a VM instead with an appro=
priate
> XCR0 value. That does mostly work, but has some problems:
> 1) The performance is quite a bit worse (particularly if we're already
> replaying in a virtualized environment)
> 2) We may want to simultaneously replay tasks with different XCR0
> values. This comes
> into play e.g. when recording a distributed system where different
> nodes in the system
> are on hosts with different hardware configurations (the reason you
> want to replay them
> jointly rather than node-by-node is that this way you can avoid
> recording any intra-node
> communication, since you can just recompute it from the trace).
>
> As a result, doing this will fully-featured VMs isn't an attractive
> proposition. I had looked into
> doing something more light-weight using the raw KVM API or something
> analogous to what project dune did (http://dune.scs.stanford.edu/ -
> basically implementing
> linux user space, but where the threads run in guest CPL0 rather than
> host CPL3).
> My conclusion was that this approach too would require significant
> kernel modification to
> work well (as well as having the noted performance problems in
> virtualized environments).
>
> Sorry if this is too much of an info dump, but I hope this gives some col=
or.
>
> Keno
