Return-Path: <SRS0=fsZL=42=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5889C10F27
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Mar 2020 08:42:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BB4A620828
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Mar 2020 08:42:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="hq2pJU9j"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726477AbgCIImv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Mar 2020 04:42:51 -0400
Received: from mail-qk1-f196.google.com ([209.85.222.196]:36563 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725962AbgCIImv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Mar 2020 04:42:51 -0400
Received: by mail-qk1-f196.google.com with SMTP id u25so8452456qkk.3
        for <linux-kernel@vger.kernel.org>; Mon, 09 Mar 2020 01:42:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=0k4lrhY4e7RSiq522A77l0K8bgsPNeuoe9M3zJhv4A4=;
        b=hq2pJU9j28V33ydnnn5PTbpTDJXWwPLDV1ZC5H8wmxQz7eE49Fl9iqNlUJN5ejo1mY
         VlMy6W3etXGABeW68vNYKgggciUta6uT2NtChCWhKs9Ur6e9ppnj3UA4fZpEADmySuvD
         ZqK/wb/hrRG/R0vVIvoccKYSwH73XzNxYyV9Vgw+Tq195Q266fIHt4lhEMGuskBfjSKw
         tiuKgMC4tM5VT395cB5o7W4tNuELzUk/e+nxn+yLIufPELhhd3in7Qzgq/lkQu69j/B5
         nsZ5+ozAbSJ8x64GfpA3qItC4meqJWfTtwIyBJpefYcQzBqsGnydMcB/8rmJCvOZoGDu
         8yUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=0k4lrhY4e7RSiq522A77l0K8bgsPNeuoe9M3zJhv4A4=;
        b=qZQd/NbHxK3NWCb6VXrJD0kdcLLFEJYYYqnQTTNzazB7G2k5Ct6bGS306RJvEQ3lIg
         jIAUMDJRHb28F1rCXwHEZYporMJMzJy6a9RV9XMOen1n73S2EqgJEONS5+H5TZer890l
         mdeSxBng+panY/1n0cKzBS4LOXAyIWyBSBjaAOp0dWMRnYLaATpH7DkKT5zY0/Nko/Ys
         /3O9KKo50BBuKI42l/X55IE6KoJQYgswvr/MgYT+uTmTfyQv7zfRHku2ECAAKXcdpRCv
         hLvOvHPJJhYvnvLQi+5jf8Xp3KHcZZ6VMlxV3YiW5qY0zGlpaYNxWS/AiHxxJ9QV0W8N
         DxIQ==
X-Gm-Message-State: ANhLgQ39fAWn0+OlX35Dqs34F2r3m6k5LIBRAXoED8CxLZ7ah3+ZbM6E
        qFVJG71MNe3YDGyaLWHfTI0pyAT3G/k9UtgmmS3kqg==
X-Google-Smtp-Source: ADFU+vvU40jfkoBfzXsp0g/d0cpQ6xiJ986DHJxok5GsZgoWt6Njbcs/WaEF/SLRshpoUtCu8LDUzoe5p2GEeZBPAh0=
X-Received: by 2002:a37:664d:: with SMTP id a74mr13595335qkc.256.1583743369546;
 Mon, 09 Mar 2020 01:42:49 -0700 (PDT)
MIME-Version: 1.0
References: <000000000000ff323f05a053100c@google.com> <CALCETrV7JcVt3ejMbHxTs4-CFmKjcmSbW2eMmmMZUM7dg2mBuA@mail.gmail.com>
 <87eeu28zzl.fsf@nanos.tec.linutronix.de>
In-Reply-To: <87eeu28zzl.fsf@nanos.tec.linutronix.de>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Mon, 9 Mar 2020 09:42:37 +0100
Message-ID: <CACT4Y+Z9U0aPrpP9quCOVUTCyVvggTuMb_F6NSgoTJvjyyO-YQ@mail.gmail.com>
Subject: Re: general protection fault in syscall_return_slowpath
To:     Thomas Gleixner <tglx@linutronix.de>,
        syzkaller <syzkaller@googlegroups.com>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>
Cc:     Borislav Petkov <bp@alien8.de>, "H. Peter Anvin" <hpa@zytor.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Andrew Lutomirski <luto@kernel.org>,
        Ingo Molnar <mingo@redhat.com>, X86 ML <x86@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Mar 8, 2020 at 7:26 PM Thomas Gleixner <tglx@linutronix.de> wrote:
>
> Andy Lutomirski <luto@kernel.org> writes:
> > On Sat, Mar 7, 2020 at 11:45 PM syzbot
> > <syzbot+cd66e43794b178bb5cd6@syzkaller.appspotmail.com> wrote:
> > $ make -j4
> > tools/syz-env/env.go:14:2: cannot find package
> > "github.com/google/syzkaller/pkg/osutil" in any of:
> >
> > I'm sure that if I actually understood Go's delightful packaging
> > system, I could reverse engineer your build system and figure out how
> > to make it work.  But perhaps you could document the build process?
> > Or maybe make 'make' just work?
> >
> > For kicks, I tried this:
> >
> > $ mkdir -p src/github.com/google
> > $ ln -sr . src/github.com/google/syzkaller
> > $ GOPATH=`/bin/pwd` make
> > GOOS=linux GOARCH=amd64 go install ./syz-manager
> > go install: no install location for directory
> > /home/luto/apps/syzkaller/syz-manager outside GOPATH
> >
> > Are there instructions for just building syzkaller?  I don't want to
> > install it, I don't want to fuzz my kernel -- I just want to run your
> > reproducer.
>
> https://github.com/google/syzkaller/blob/master/docs/executing_syzkaller_programs.md
>
> That's how I build the binaries:
>
>   mkdir foo
>   export GOPATH=$HOME/foo
>
>   cd foo
>   go get -u -d github.com/google/syzkaller/...
>   cd src/github.com/google/syzkaller
>   make
>   cp bin/linux_amd64/syz-execprog bin/linux_amd64/syz-executor $GOPATH
>
> Of course you can build it somewhere and scp the executables to a test box.
>
> And then to run it
>
>   cd $GOPATH
>   wget -O repro.syz https://syzkaller.appspot.com/x/repro.syz?x=12a42329e00000
>   ./syz-execprog -procs 6 -repeat 0 -collide -disable none repro.syz
>
> The command line options are a bit tedious as you have to look them up
> in the comment in repro.syz.
>
> A scripts which converts that comment into command line options or
> syz-execprog simply taking it from repro.syz would indeed be handy.
>
> A kernel with the config provided in the report and running that
> reproducer is still not reproducing with a runtime of 8hrs+ :(

There is https://github.com/google/syzkaller/issues/563 for a self
contained repro script.

But I am not sure how configurable it should be; how much should it
download; and if it should assume reproducing on host, or some other
remote machine/VM. Some users want only flags for syz-repro and have
the rest installed; some want the script to take care of Go toolchain
installation and/or syzkaller checkout; some also want
qemu/image/kernel/gcc. Some there is whole spectrum of what it can do
with lots of variations. If it does everything end-to-end downloading
tens of gigs and building own kernel, some users won't be happy. If we
add a gazillion of flags, one will need to be a certified expert in
configuring this script, which may be not simpler than doing all steps
manually, and obviously less transparent when it fails...
