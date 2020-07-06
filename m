Return-Path: <SRS0=eGSO=AR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A4FBC433DF
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jul 2020 09:02:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E11F62075B
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jul 2020 09:02:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="uMWdedn6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728616AbgGFJC5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Jul 2020 05:02:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728135AbgGFJC5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jul 2020 05:02:57 -0400
Received: from mail-io1-xd41.google.com (mail-io1-xd41.google.com [IPv6:2607:f8b0:4864:20::d41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 483CAC061794
        for <linux-kernel@vger.kernel.org>; Mon,  6 Jul 2020 02:02:57 -0700 (PDT)
Received: by mail-io1-xd41.google.com with SMTP id q8so38528472iow.7
        for <linux-kernel@vger.kernel.org>; Mon, 06 Jul 2020 02:02:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:reply-to:from:date:message-id
         :subject:to:cc:content-transfer-encoding;
        bh=IHHyz8cHUenzzXke/VXQ1OE9u5CEFd7aV6cOLeDVyg4=;
        b=uMWdedn6LbHVrDrw+cGTc6+UU/AKuWQ65hI9Vac3Lw8r5V1KKFX4inQJ8KNED0ZwAF
         ZzBNSMs2voGG8KUTpE2eqZBGcIW5/9ilRgFjUWYV7HIETVVgt5FbCI4UvdSbGJimMtyC
         /bMA4tG+C19aeaLh3S5B8n7PJs5Xl6Xj4C0OZVXfPIxOk6VOjK9FbjjC+RQjPAgRS+Zq
         j0umtX2qLwLoX9iShLT9dsTUpwCHNbCjMypu7OnmrOTgSgbR04+s7pi2fS9XHdCw2mJb
         mU5EFrH7vxSWUaGOVA/B2VsV6a1Tc6vPupywVv7yi8PKWRyee2Ku532xuBnBqEP9Bqi/
         UxTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc:content-transfer-encoding;
        bh=IHHyz8cHUenzzXke/VXQ1OE9u5CEFd7aV6cOLeDVyg4=;
        b=fTaMG4YtFWUHzfMIQj9uWFV/ERdn6xEfjgHg36pZMPiUONbQkoJ8RoKgG+hRwjqxrF
         fbOYyHV4LxIzRjk8bY2dSYJGAe/IVWLhP4ErEe7MpYdve60M/2pUOylLS/sFjnuoIpLK
         H2Q4dmkQ1V3CkjmdtHabWtRlgKMs2T9wPCNVlMI2+cwLNeKQBImkG/aJF1p1MsWlN92O
         qW3A+tAHi9amNqEDjHMrAkgLpKvQ9sP3AIJA9RF75Xb1PVrLFviOzeMPqb3gK6E2Efda
         0CoIa+K1G4dLFPw56arlDlBpGzXoVLns8cuB2LKOMA3orepCY42K/fsRWSKE/+VaJUKH
         btLQ==
X-Gm-Message-State: AOAM533HuNXrMQ9nkpSojk911ViZ6dbtlsGtX2FNdcxaQQPXVklJskBT
        OKocCaUFgTzXf1e+QQjP0m40qe2xgpdPVAU3kyo=
X-Google-Smtp-Source: ABdhPJwP9W9ZEIvuDHGeF2HlBtyKsmXf7PtKP+n356DusKYA0gPQv9UHUH3qX2iBlcKCGc0Tly8cRLFs8mW/h12VHM8=
X-Received: by 2002:a05:6602:2c45:: with SMTP id x5mr23860006iov.80.1594026176616;
 Mon, 06 Jul 2020 02:02:56 -0700 (PDT)
MIME-Version: 1.0
References: <CA+icZUVgJFXJ3C_iYK8HrsuhAy3R9U1RDB6mPkOS52JcnU4mDQ@mail.gmail.com>
 <20200706083900.GC4800@hirez.programming.kicks-ass.net> <CA+icZUV=VVpy=R5_bq0N4TvPg+SfzyCXuWW9-QCnKk8-WnZLLg@mail.gmail.com>
In-Reply-To: <CA+icZUV=VVpy=R5_bq0N4TvPg+SfzyCXuWW9-QCnKk8-WnZLLg@mail.gmail.com>
Reply-To: sedat.dilek@gmail.com
From:   Sedat Dilek <sedat.dilek@gmail.com>
Date:   Mon, 6 Jul 2020 11:02:45 +0200
Message-ID: <CA+icZUWevq9qidK8K1v0GV-FOyyhn2hp4DTrsUSz-oeXCNp+1A@mail.gmail.com>
Subject: Re: [Linux v5.8-rc4] objtool warnings with gcc-10
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Josh Poimboeuf <jpoimboe@redhat.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org, mbenes@suse.cz
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 6, 2020 at 10:43 AM Sedat Dilek <sedat.dilek@gmail.com> wrote:
>
> On Mon, Jul 6, 2020 at 10:39 AM Peter Zijlstra <peterz@infradead.org> wro=
te:
> >
> > On Mon, Jul 06, 2020 at 09:09:55AM +0200, Sedat Dilek wrote:
> > > [ Please CC me I am not subscribed to this mailing-list ]
> > >
> > > Hi Josh and Peter,
> > >
> > > today I switched over from Linux v5.7.y to Linux v5.8-rc4 and built
> > > the first time with GCC version 10 on Debian/testing AMD64.
> > >
> > > $ cat /proc/version
> > > Linux version 5.8.0-rc4-1-amd64-gcc10 (sedat.dilek@gmail.com@iniza)
> > > (gcc-10 (Debian 10.1.0-4) 10.1.0, GNU ld (GNU Binutils for Debian)
> > > 2.34) #1~bullseye+dileks1 SMP 2020-07-06
> > >
> > > I see these objtool warnings (which are new to me):
> > >
> > > $ grep warning: build-log_5.8.0-rc4-1-amd64-gcc10.txt | sort
> > > arch/x86/kernel/cpu/mce/core.o: warning: objtool: mce_panic()+0x118: =
unreachable instruction
> > > drivers/atm/horizon.o: warning: objtool: interrupt_handler()+0x19f: u=
nreachable instruction
> > > drivers/message/fusion/mptbase.o: warning: objtool: mpt_Soft_Hard_Res=
etHandler()+0x33a: unreachable instruction
> > > drivers/scsi/aic7xxx/aic79xx_core.o: warning: objtool: ahd_intr.part.=
0()+0x10f: unreachable instruction
> > > drivers/scsi/pcmcia/aha152x_core.o: warning: objtool: run()+0x4c0: un=
reachable instruction
> > > fs/btrfs/backref.o: warning: objtool: btrfs_backref_finish_upper_link=
s()+0x309: unreachable instruction
> > > fs/btrfs/extent_io.o: warning: objtool: __set_extent_bit.cold()+0xc: =
unreachable instruction
> > > fs/btrfs/relocation.o: warning: objtool: update_backref_cache.part.0(=
)+0x1de: unreachable instruction
> > > kernel/exit.o: warning: objtool: __x64_sys_exit_group()+0x14: unreach=
able instruction
> > > net/core/skbuff.o: warning: objtool: skb_push.cold()+0x15: unreachabl=
e instruction
> >
> > That's more CONFIG_LIVEPATCH=3Dy wreckage I expect. The problem is that
> > GCC -flive-patching=3D thing wreck the propagation of the noreturn.
> >
> > This really is a compiler issue and we've not managed a sensible
> > work-around in objtool.
>
> Thanks for the quick response.
>
> I have...
>
> CONFIG_LIVEPATCH=3Dy
>
> ...and see in my build-log:
>
> -flive-patching=3Dinline-clone
>
> - Sedat -

OK, I found some discussions in "Re: linux-next: Tree for May 21
(objtool warnings)" [1].

GCC docs say [2]:
- BOQ (Begin Of Quote) -
[ -flive-patching=3Dlevel ]

The level argument should be one of the following:

[ =E2=80=98inline-clone=E2=80=99 ]

Only enable inlining and cloning optimizations, which includes
inlining, cloning, interprocedural scalar replacement of aggregates
and partial inlining. As a result, when patching a function, all its
callers and its clones=E2=80=99 callers are impacted, therefore need to be
patched as well.

-flive-patching=3Dinline-clone disables the following optimization flags:

-fwhole-program  -fipa-pta  -fipa-reference  -fipa-ra
-fipa-icf  -fipa-icf-functions  -fipa-icf-variables
-fipa-bit-cp  -fipa-vrp  -fipa-pure-const  -fipa-reference-addressable
-fipa-stack-alignment

[ =E2=80=98inline-only-static=E2=80=99 ]

Only enable inlining of static functions. As a result, when patching a
static function, all its callers are impacted and so need to be
patched as well.

In addition to all the flags that -flive-patching=3Dinline-clone
disables, -flive-patching=3Dinline-only-static disables the following
additional optimization flags:

-fipa-cp-clone  -fipa-sra  -fpartial-inlining  -fipa-cp

When -flive-patching is specified without any value, the default value
is inline-clone.

This flag is disabled by default.

Note that -flive-patching is not supported with link-time optimization (-fl=
to).
 - EOQ (End of Quote) -

Josh says in [3]:

> The issue here is that with -fno-ipa-pure-const, GCC no longer
> automatically detects that the static inline function is noreturn, so it
> emits unreachable instructions after a call to it.

- Sedat -

[1] https://marc.info/?t=3D159011496400002&r=3D1&w=3D2
[2] https://gcc.gnu.org/onlinedocs/gcc/Optimize-Options.html
[3] https://marc.info/?l=3Dlinux-next&m=3D159059217601108&w=3D2
