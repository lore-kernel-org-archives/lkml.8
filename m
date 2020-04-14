Return-Path: <SRS0=4xmc=56=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09903C38A29
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Apr 2020 23:20:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D835D20784
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Apr 2020 23:20:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1586906454;
	bh=ZOpLQhnRd08sOnvMFaa91+VED600Lo361J+I/x4HT/U=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=Y5FTda3ISJfLCdl5LZ9tW1rrZmd2et0HXpKLir+TMAzzKQojpOG7JGwhJ/wRm5tnH
	 W3t3Srp+IcjPTlaZEALp9HklHetLy+Y3Fh+AHEprjYF5Scv8S6NsPZky/Wjo8AcJys
	 GXKl5dBB7USVHBjdAyxrMQnu0rTOJA7pypKLOgc0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392108AbgDNXUt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Apr 2020 19:20:49 -0400
Received: from mail.kernel.org ([198.145.29.99]:58458 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731159AbgDNXU1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Apr 2020 19:20:27 -0400
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3EC142084D
        for <linux-kernel@vger.kernel.org>; Tue, 14 Apr 2020 23:20:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1586906427;
        bh=ZOpLQhnRd08sOnvMFaa91+VED600Lo361J+I/x4HT/U=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=GLsNtWv62Q2xFLHzli9xxQrcjowu/vSVQ47ptlXB7uRq2TkuSj8zc+g3vDTitOlCr
         Rl1DcfgjJN7XfdwTiXf+v9/l+HiBK62qm0MrTquyEuoTahuaEE2QjflboRa6E2ypb4
         WfJJnA6yBzhCuMOcyop8FjQoAtNKwqL16/YNGxc4=
Received: by mail-wr1-f53.google.com with SMTP id u13so16136047wrp.3
        for <linux-kernel@vger.kernel.org>; Tue, 14 Apr 2020 16:20:27 -0700 (PDT)
X-Gm-Message-State: AGi0PuaiWzunaK7muriCAFyHPqWT0eIjYGC4/ZL8f/vLpQGj3+XZKdr/
        L6rqKxXgRX0k/UeK06noMvlvafCZG9g6BHpCtLbQaw==
X-Google-Smtp-Source: APiQypIqH10bim2r4lvd1sxTZHDU3AEdyqSct6JzQQXaspuA276JVwhLKjqUPouRRDYyyo5BMdWnC4IWbiZNOQeCsFY=
X-Received: by 2002:adf:bc05:: with SMTP id s5mr25696906wrg.70.1586906425665;
 Tue, 14 Apr 2020 16:20:25 -0700 (PDT)
MIME-Version: 1.0
References: <a5b07aa9-96ea-a9b5-13db-e5dcbd7760e6@intel.com>
 <BEA3CCB8-5127-4E6A-9696-E293C00BFA82@amacapital.net> <CABV8kRxqcCmPKtX3DDOf+47Re1hO1gMeUPhCd6HtDP0-SpcSBw@mail.gmail.com>
In-Reply-To: <CABV8kRxqcCmPKtX3DDOf+47Re1hO1gMeUPhCd6HtDP0-SpcSBw@mail.gmail.com>
From:   Andy Lutomirski <luto@kernel.org>
Date:   Tue, 14 Apr 2020 16:20:14 -0700
X-Gmail-Original-Message-ID: <CALCETrVmsWZ+w6C4RV50DWoL0Qaiy+S6BtXr=QKQEg3MYgAc6w@mail.gmail.com>
Message-ID: <CALCETrVmsWZ+w6C4RV50DWoL0Qaiy+S6BtXr=QKQEg3MYgAc6w@mail.gmail.com>
Subject: Re: [RFC PATCH v2] x86/arch_prctl: Add ARCH_SET_XCR0 to set XCR0 per-thread
To:     Keno Fischer <keno@juliacomputing.com>
Cc:     Dave Hansen <dave.hansen@intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
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

On Tue, Apr 7, 2020 at 11:30 AM Keno Fischer <keno@juliacomputing.com> wrot=
e:
>
> > TSX!
>
> Yes, it's problematic, but luckily turns out to
> be ok in practice if masked off in cpuid.
>
> > I think rr should give the raw KVM API at least a try.  It should be po=
ssible to fire up a vCPU in CPL3 in the correct state.  No guest kernel req=
uired.  I don=E2=80=99t know if there will be issues with the perf API, tho=
ugh.
>
> Yes, I've looked into it, but stopped short of doing a
> complete implementation. Using KVM to solve it
> for replay would probably be feasible with a moderate
> amount of engineering work, since rr does very few
> syscalls during replay. I'm a bit afraid of the
> performance implications, but I don't have numbers on this.
>
> Record and diversions are a lot harder though, because
> in this mode the tracee is a live process and able to do
> syscalls (and needs to receive signals and all that good
> stuff associated with being a real process). For diversions,
> performance isn't super important, so we could probably
> emulate this, but for record, performance is quite critical.
> I assume it would be possible to add a feature to KVM
> where it forwards syscalls made in guest CPL3 to the real
> kernel without round-trip through userspace, but I'm just
> seeing myself back here asking
> for a weird KVM feature that nobody but me wants ;)
> (well almost nobody, as I mentioned, there's an
> academic project that tried this with a custom kernel
> plugin - http://dune.scs.stanford.edu/).
>
> Admittedly, the use case for this feature during record is
> less pressing, since in our (operational) case
> the replay machines tend to be much newer than
> the record machines, but I wouldn't be surprised if I got
> bit by this as soon as the next user xstate component gets
> added and users start sending me those kinds of traces,
> even if we mask off the feature in CPUID (which rr already
> supports for record for similar reasons).

I'm imagining that rr would do record the usual way with normal XCR0
(why would you want to record with an unusual XCR0?) and replay would
use KVM.  I'm not sure about diversions.  This way KVM wouldn't need
to deal with syscalls.

Would this work?
