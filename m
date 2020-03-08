Return-Path: <SRS0=tZRF=4Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3BB5CC10DCE
	for <linux-kernel@archiver.kernel.org>; Sun,  8 Mar 2020 18:26:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 16181206D5
	for <linux-kernel@archiver.kernel.org>; Sun,  8 Mar 2020 18:26:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726397AbgCHS0a (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 8 Mar 2020 14:26:30 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:56909 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726279AbgCHS03 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Mar 2020 14:26:29 -0400
Received: from p5de0bf0b.dip0.t-ipconnect.de ([93.224.191.11] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1jB0d5-0008Ac-93; Sun, 08 Mar 2020 19:26:23 +0100
Received: by nanos.tec.linutronix.de (Postfix, from userid 1000)
        id B41E21040A5; Sun,  8 Mar 2020 19:26:22 +0100 (CET)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Andy Lutomirski <luto@kernel.org>,
        Dmitry Vyukov <dvyukov@google.com>
Cc:     Borislav Petkov <bp@alien8.de>, "H. Peter Anvin" <hpa@zytor.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Andrew Lutomirski <luto@kernel.org>,
        Ingo Molnar <mingo@redhat.com>, X86 ML <x86@kernel.org>
Subject: Re: general protection fault in syscall_return_slowpath
In-Reply-To: <CALCETrV7JcVt3ejMbHxTs4-CFmKjcmSbW2eMmmMZUM7dg2mBuA@mail.gmail.com>
References: <000000000000ff323f05a053100c@google.com> <CALCETrV7JcVt3ejMbHxTs4-CFmKjcmSbW2eMmmMZUM7dg2mBuA@mail.gmail.com>
Date:   Sun, 08 Mar 2020 19:26:22 +0100
Message-ID: <87eeu28zzl.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Andy Lutomirski <luto@kernel.org> writes:
> On Sat, Mar 7, 2020 at 11:45 PM syzbot
> <syzbot+cd66e43794b178bb5cd6@syzkaller.appspotmail.com> wrote:
> $ make -j4
> tools/syz-env/env.go:14:2: cannot find package
> "github.com/google/syzkaller/pkg/osutil" in any of:
>
> I'm sure that if I actually understood Go's delightful packaging
> system, I could reverse engineer your build system and figure out how
> to make it work.  But perhaps you could document the build process?
> Or maybe make 'make' just work?
>
> For kicks, I tried this:
>
> $ mkdir -p src/github.com/google
> $ ln -sr . src/github.com/google/syzkaller
> $ GOPATH=`/bin/pwd` make
> GOOS=linux GOARCH=amd64 go install ./syz-manager
> go install: no install location for directory
> /home/luto/apps/syzkaller/syz-manager outside GOPATH
>
> Are there instructions for just building syzkaller?  I don't want to
> install it, I don't want to fuzz my kernel -- I just want to run your
> reproducer.

https://github.com/google/syzkaller/blob/master/docs/executing_syzkaller_programs.md

That's how I build the binaries:

  mkdir foo
  export GOPATH=$HOME/foo

  cd foo
  go get -u -d github.com/google/syzkaller/...
  cd src/github.com/google/syzkaller
  make
  cp bin/linux_amd64/syz-execprog bin/linux_amd64/syz-executor $GOPATH

Of course you can build it somewhere and scp the executables to a test box.

And then to run it

  cd $GOPATH
  wget -O repro.syz https://syzkaller.appspot.com/x/repro.syz?x=12a42329e00000
  ./syz-execprog -procs 6 -repeat 0 -collide -disable none repro.syz

The command line options are a bit tedious as you have to look them up
in the comment in repro.syz.

A scripts which converts that comment into command line options or
syz-execprog simply taking it from repro.syz would indeed be handy.

A kernel with the config provided in the report and running that
reproducer is still not reproducing with a runtime of 8hrs+ :(

Thanks,

        tglx
