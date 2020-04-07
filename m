Return-Path: <SRS0=z/zp=5X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55C2DC2BA16
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Apr 2020 04:45:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 26DAC2074F
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Apr 2020 04:45:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=juliacomputing-com.20150623.gappssmtp.com header.i=@juliacomputing-com.20150623.gappssmtp.com header.b="wgGjWELF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726635AbgDGEpS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Apr 2020 00:45:18 -0400
Received: from mail-io1-f68.google.com ([209.85.166.68]:35712 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725883AbgDGEpR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Apr 2020 00:45:17 -0400
Received: by mail-io1-f68.google.com with SMTP id o3so2059347ioh.2
        for <linux-kernel@vger.kernel.org>; Mon, 06 Apr 2020 21:45:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=juliacomputing-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=iNp6RaOoSag897phKncSfnpKVnk/3sl4pKb9T9TZ+v8=;
        b=wgGjWELFp5mt7wwRU6iZuwdA7s1AIXK3Rm/k6xQkTBH3BsPA3H7WlI354Ys53TPAZt
         U7KwBk4YnU64izCvh+/RpilM7NWWIXpw/1yJGt7Qo6yYB9uw/QKH06B9phBFz4yt7Yz8
         PoA/KeIcc1H3DG7DeV6qS8GggPjlTAOolrbNaAM2WIDl141KZednMIPnOqOSigcZ/Ldk
         AzQcgR7nGnnWpV5VtZ8zNWbt+18odS1Dt+CACKEeQjVKkQtEZqj9uC7qQgzClcjeSOan
         eaL5L3cdH8dR+J6siZkXPmmzbOjnbjuPPeyE7/yvewKlSdvdTXknQD8zgOxEo4e4RlHD
         0A6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=iNp6RaOoSag897phKncSfnpKVnk/3sl4pKb9T9TZ+v8=;
        b=ib9CUe2hkNSmbO3aLIcRpjH0+5dDahByn7ujP9QVwLGUR0n0CenvYG/VOxx0jyIbx/
         chioEFKjwF5LsvQxtwn+78HhbpUDixFyuRJsGorWc/ZeI+eKgH+JmHYs7wN+OvhUfNx4
         UEv5ovc/elTDNxXNC2cCZD5/TAlMKePnbSQdN3b0NlR2AjAqhdHS+Xqg2E105ZxFxoYq
         Dtw1Y436wKlIzQyArBhb6Bf8OEndrah+iqb0Nu2V6gskJNkImbpvBGNFYJqN2Fy/5qWC
         wztwQ1N29CHPA2YQDZ3A+PwLvoS5eJdulgH28T2H1iRnFRI2u/SEq4TVXDMeK98bIMLS
         vPQA==
X-Gm-Message-State: AGi0PubHLGXCvl7F7e+K0AVM+JXt7T+dWHCXABtgPQ2lRspc1NqIjcDY
        HEjr7dS8QH7e+DO64O26gm4i/6gp7VC6Po20Ysp+WA==
X-Google-Smtp-Source: APiQypKOVt8F0s8Idc0YvrUn95Qz/4O8iaknwDtJpRa4y0ibcDfeHj7guyJuwyxzTlfCeq0jl1i+nfaEIkIbYkhQ6tU=
X-Received: by 2002:a5d:8a10:: with SMTP id w16mr410156iod.153.1586234716142;
 Mon, 06 Apr 2020 21:45:16 -0700 (PDT)
MIME-Version: 1.0
References: <20200407011259.GA72735@juliacomputing.com> <2A931F48-D28F-46F3-827F-FF7F4D5D3E66@amacapital.net>
In-Reply-To: <2A931F48-D28F-46F3-827F-FF7F4D5D3E66@amacapital.net>
From:   Keno Fischer <keno@juliacomputing.com>
Date:   Tue, 7 Apr 2020 00:44:39 -0400
Message-ID: <CABV8kRyi-5wyiCV3HsPfFx6x1_icV72BSy+5eK8UC3UCexTSCA@mail.gmail.com>
Subject: Re: [RFC PATCH v2] x86/arch_prctl: Add ARCH_SET_XCR0 to set XCR0 per-thread
To:     Andy Lutomirski <luto@amacapital.net>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, x86@kernel.org,
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

On Mon, Apr 6, 2020 at 11:58 PM Andy Lutomirski <luto@amacapital.net> wrote=
:
>
>
> > On Apr 6, 2020, at 6:13 PM, Keno Fischer <keno@juliacomputing.com> wrot=
e:
> >
> > =EF=BB=BFThis is a follow-up to my from two-years ago [1].
>
> Your changelog is missing an explanation of why this is useful.  Why woul=
d a user program want to change XCR0?

Ah, sorry - I wasn't sure what the convention was around repeating the
applicable parts from the v1 changelog in this email.
Here's the description from the v1 patch:

> The rr (http://rr-project.org/) debugger provides user space
> record-and-replay functionality by carefully controlling the process
> environment in order to ensure completely deterministic execution
> of recorded traces. The recently added ARCH_SET_CPUID arch_prctl
> allows rr to move traces across (Intel) machines, by allowing cpuid
> invocations to be reliably recorded and replayed. This works very
> well, with one catch: It is currently not possible to replay a
> recording from a machine supporting a smaller set of XCR0 state
> components on one supporting a larger set. This is because the
> value of XCR0 is observable in userspace (either by explicit
> xgetbv or by looking at the result of xsave) and since glibc
> does observe this value, replay divergence is almost immediate.
> I also suspect that people interested in process (or container)
> live-migration may eventually care about this if a migration happens
> in between a userspace xsave and a corresponding xrstor.
>
> We encounter this problem quite frequently since most of our users
> are using pre-Skylake systems (and thus don't support the AVX512
> state components), while we recently upgraded our main development
> machines to Skylake.

Basically, for rr to work, we need to tightly control any user-visible
CPU behavior,
either by putting in the CPU in the right state or by trapping and emulatin=
g
(as we do for rdtsc, cpuid, etc). XCR0 controls a bunch of
user-visible CPU behavior,
namely:
1) The size of the xsave region if xsave is passed an all-ones mask
(which is fairly common)
2) The return value of xgetbv
3) Whether instructions making use of the relevant xstate component traps

In the v1 review, it was raised that user space could be adjusted to
deal with these
issues by always checking support in cpuid first (which is already emulatab=
le).
Unfortunately, we don't control the environment on the record side (rr supp=
orts
record on any Intel from the past decade - with the exception of a few that=
 have
microarchitecture bugs causing problems; and kernel versions back to 3.11),=
 so
trying to patch user space is unfortunately a no-go for us (as well as of c=
ourse
being a debugging tool, so we want to be able to help users debug if they g=
et
uses of these instructions wrong).

Another suggestion in the v1 review was to use a VM instead with an appropr=
iate
XCR0 value. That does mostly work, but has some problems:
1) The performance is quite a bit worse (particularly if we're already
replaying in a virtualized environment)
2) We may want to simultaneously replay tasks with different XCR0
values. This comes
into play e.g. when recording a distributed system where different
nodes in the system
are on hosts with different hardware configurations (the reason you
want to replay them
jointly rather than node-by-node is that this way you can avoid
recording any intra-node
communication, since you can just recompute it from the trace).

As a result, doing this will fully-featured VMs isn't an attractive
proposition. I had looked into
doing something more light-weight using the raw KVM API or something
analogous to what project dune did (http://dune.scs.stanford.edu/ -
basically implementing
linux user space, but where the threads run in guest CPL0 rather than
host CPL3).
My conclusion was that this approach too would require significant
kernel modification to
work well (as well as having the noted performance problems in
virtualized environments).

Sorry if this is too much of an info dump, but I hope this gives some color=
.

Keno
