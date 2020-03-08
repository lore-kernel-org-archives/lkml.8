Return-Path: <SRS0=tZRF=4Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 518E5C10F27
	for <linux-kernel@archiver.kernel.org>; Sun,  8 Mar 2020 16:14:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 29E7120866
	for <linux-kernel@archiver.kernel.org>; Sun,  8 Mar 2020 16:14:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1583684041;
	bh=mRQksgvrFhuFw52BkRZIUfsXfl+zLZU76dhB5kz1oiI=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=r9IjDxy4LA0cmvmHh8Gfkb6LG7YfiuT55PLaJt0dKGZbqhPybRNxNe+wn4GMuedjd
	 5EnZbaE7IfumT7s+JpZNtuGMKZX3p7gTRCN5khroNFRkjfybzxJ4XMbs3/N0KpxZ/B
	 TlrtArbkv50d9w8DE48OO3PLqAudqR0kWylxJzRA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726385AbgCHQN7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 8 Mar 2020 12:13:59 -0400
Received: from mail.kernel.org ([198.145.29.99]:50090 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726279AbgCHQN7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Mar 2020 12:13:59 -0400
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8D4F3208C3
        for <linux-kernel@vger.kernel.org>; Sun,  8 Mar 2020 16:13:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1583684038;
        bh=mRQksgvrFhuFw52BkRZIUfsXfl+zLZU76dhB5kz1oiI=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=Q7DPeXrzITreUMoH9NB4FJLPdra2cQuf9v+XNO2bJvxHvfky42oHj/JiChwks2Pcf
         I3vienDNQh+NkjfdEFJWsUyeMpWYpvyurXWgr5sHcrHU6pU3I2eSETBkSaXuHcLOBn
         ToI644F68dq5epf7nQ2UupA6lQHEpFL10CYEt90s=
Received: by mail-wm1-f53.google.com with SMTP id n8so3388603wmc.4
        for <linux-kernel@vger.kernel.org>; Sun, 08 Mar 2020 09:13:58 -0700 (PDT)
X-Gm-Message-State: ANhLgQ0C8wRKRm8JZ4HUAGJyBIqd4/Jvu5Ao6KhwNPTX0QscBiiwzwxz
        Vyi7wZEFzzmdJxP2K4xMutd7gor5/GcMxd+gzcPHIg==
X-Google-Smtp-Source: ADFU+vv+C4oNuEe96ou1GcyDnB9JRJD0U3PndiDgxeDaG+Cyze/oTiExMZOjsZDkKujWE/RSETi9fVqOLQt/IIjpy30=
X-Received: by 2002:a7b:ce09:: with SMTP id m9mr16355373wmc.49.1583684036959;
 Sun, 08 Mar 2020 09:13:56 -0700 (PDT)
MIME-Version: 1.0
References: <000000000000ff323f05a053100c@google.com>
In-Reply-To: <000000000000ff323f05a053100c@google.com>
From:   Andy Lutomirski <luto@kernel.org>
Date:   Sun, 8 Mar 2020 09:13:45 -0700
X-Gmail-Original-Message-ID: <CALCETrV7JcVt3ejMbHxTs4-CFmKjcmSbW2eMmmMZUM7dg2mBuA@mail.gmail.com>
Message-ID: <CALCETrV7JcVt3ejMbHxTs4-CFmKjcmSbW2eMmmMZUM7dg2mBuA@mail.gmail.com>
Subject: Re: general protection fault in syscall_return_slowpath
To:     Dmitry Vyukov <dvyukov@google.com>
Cc:     Borislav Petkov <bp@alien8.de>, "H. Peter Anvin" <hpa@zytor.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Andrew Lutomirski <luto@kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>, X86 ML <x86@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Mar 7, 2020 at 11:45 PM syzbot
<syzbot+cd66e43794b178bb5cd6@syzkaller.appspotmail.com> wrote:
>
> Hello,
>
> syzbot found the following crash on:
>
> HEAD commit:    63623fd4 Merge tag 'for-linus' of git://git.kernel.org/pub..
> git tree:       upstream
> console output: https://syzkaller.appspot.com/x/log.txt?x=16cfeac3e00000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=5d2e033af114153f
> dashboard link: https://syzkaller.appspot.com/bug?extid=cd66e43794b178bb5cd6
> compiler:       clang version 10.0.0 (https://github.com/llvm/llvm-project/ c2443155a0fb245c8f17f2c1c72b6ea391e86e81)
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=12a42329e00000

I tried to reproduce this and got:

$ make -j4
tools/syz-env/env.go:14:2: cannot find package
"github.com/google/syzkaller/pkg/osutil" in any of:

I'm sure that if I actually understood Go's delightful packaging
system, I could reverse engineer your build system and figure out how
to make it work.  But perhaps you could document the build process?
Or maybe make 'make' just work?

For kicks, I tried this:

$ mkdir -p src/github.com/google
$ ln -sr . src/github.com/google/syzkaller
$ GOPATH=`/bin/pwd` make
GOOS=linux GOARCH=amd64 go install ./syz-manager
go install: no install location for directory
/home/luto/apps/syzkaller/syz-manager outside GOPATH

Are there instructions for just building syzkaller?  I don't want to
install it, I don't want to fuzz my kernel -- I just want to run your
reproducer.

--Andy
