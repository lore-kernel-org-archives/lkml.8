Return-Path: <SRS0=fsZL=42=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 743FBC10F27
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Mar 2020 08:34:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3DE9C2067C
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Mar 2020 08:34:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="vU4nbJah"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726451AbgCIIej (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Mar 2020 04:34:39 -0400
Received: from mail-qk1-f195.google.com ([209.85.222.195]:41243 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725796AbgCIIei (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Mar 2020 04:34:38 -0400
Received: by mail-qk1-f195.google.com with SMTP id b5so8404799qkh.8
        for <linux-kernel@vger.kernel.org>; Mon, 09 Mar 2020 01:34:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=9+6dD3kG6eokXhmm1OkCv7DvGFwNHGRFW09c2WNOzOc=;
        b=vU4nbJahGRiC9pKc3K/sl/p6UnaE01/8RtXt7+myKSYAGraV1KAEfpylhPMSfvPN8C
         4uh77hzcorCUuhUZ4tu2cNV+xSiyiHxEbufdVLw/ul1iUIoXkVUrpabdS6p8TBg/tXX6
         a9Z+2Nkz+lOZmQmKpXUno2mNVUi5CpVe1SSD/glpzq+6Ur9+oG7C7XEj6RD+2xhImrXJ
         BBrRoaQuxiVkPTyfnryU04URnfO37ajEnov7omzOzTSJipIMjDffRNOsjxjfRL9jyQJK
         weAvKHPnyz6jIVPmkJI5incvnLwEesoFe2CAQ9ekNalo62Q/WhH8vk26A/UgJSi3C7Aq
         pa9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=9+6dD3kG6eokXhmm1OkCv7DvGFwNHGRFW09c2WNOzOc=;
        b=HXaICVeTpdXwVIlaW1ibZjsdXsWM2EG2Z6VY8fmx6j+Dx9Sh4mGwYWbG/hkDGVF2w2
         imktOjeZk5JVF/n0FAyuzP1Pzpl6CGQkRev5dZO8zeRh05LsKkGPe2CFxFePaoalpIvT
         JQSZdy04f/w1c+Uf7JE+JDnRCjvJbcXAKCfJNIX1RZgM/T7rDK2MfMVU9CIj7t5OOv8T
         TpNG381sVLXe5s0howZDmYwX31K7bh9LRQEB+JZpasPsb0ke6SVQtWt4HpFzDyRntPX4
         MujxmLIGwTjB/3dVz3Ki4kvCNtgRfN+EUBkdSWvXNRmcCNd8E+Tvwx8BBA3jTiZuE9lX
         uSaQ==
X-Gm-Message-State: ANhLgQ3jWvOGI2l1G1BmxK4rgw7vQ0e6jilcZw5U3B0Tvh9mfAbNg+qY
        Gco4VqNavQAPpOzA/M+2z6FPT45HFuFIzS9q8TsGAw==
X-Google-Smtp-Source: ADFU+vugoA8q5STs8f3Zw+WvXUXkNzO+o7UcniTPzwXH0RVRgiQreHUUQA1tp9e1AvqWcG/rZi49aSkgCEHeKgsDdoU=
X-Received: by 2002:a37:ef14:: with SMTP id j20mr12489316qkk.43.1583742877219;
 Mon, 09 Mar 2020 01:34:37 -0700 (PDT)
MIME-Version: 1.0
References: <000000000000ff323f05a053100c@google.com> <CALCETrV7JcVt3ejMbHxTs4-CFmKjcmSbW2eMmmMZUM7dg2mBuA@mail.gmail.com>
 <87eeu28zzl.fsf@nanos.tec.linutronix.de>
In-Reply-To: <87eeu28zzl.fsf@nanos.tec.linutronix.de>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Mon, 9 Mar 2020 09:34:25 +0100
Message-ID: <CACT4Y+YX72sz2LsqQOTQ=TdDK_f7zURjA9j9VyYwj7GgLrajkQ@mail.gmail.com>
Subject: Re: general protection fault in syscall_return_slowpath
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Borislav Petkov <bp@alien8.de>, "H. Peter Anvin" <hpa@zytor.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Andrew Lutomirski <luto@kernel.org>,
        Ingo Molnar <mingo@redhat.com>, X86 ML <x86@kernel.org>,
        Jann Horn <jannh@google.com>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>
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
>
> Thanks,
>
>         tglx


I see the repro opens /dev/fb0, so this may be related to the exact
type of framebuffer on the machine. That's what Jann tried to figure
out.

There is a plenty of open bugs on dashboard related to fb/tty, just
doing a quick grep based on titles:

https://syzkaller.appspot.com/upstream
BUG: unable to handle kernel paging request in
drm_fb_helper_dirty_work 7 4d20h 90d
BUG: unable to handle kernel paging request in vga16fb_imageblit 1 74d 73d
divide error in fbcon_switch C cause 141 3d15h 96d
general protection fault in fbcon_cursor C cause 12 13h48m 87d
general protection fault in fbcon_fb_blanked 3 88d 90d
general protection fault in fbcon_invert_region 1 49d 48d
general protection fault in fbcon_modechanged 3 89d 90d
INFO: task hung in do_fb_ioctl 6 36d 57d
INFO: task hung in fb_compat_ioctl 1 87d 87d
INFO: task hung in fb_open C cause 171 1h06m 96d
INFO: task hung in fb_release C cause 23 2d12h 77d
INFO: task hung in release_tty 3 6d16h 62d
INFO: task hung in tty_ldisc_hangup C cause 15 17d 92d
INFO: trying to register non-static key in hci_uart_tty_receive (2) 1 103d 99d
KASAN: global-out-of-bounds Read in fbcon_get_font C cause 19 7d06h 90d
KASAN: global-out-of-bounds Read in fb_pad_aligned_buffer C cause 5 4d22h 92d
KASAN: global-out-of-bounds Read in vga16fb_imageblit C cause 225 1d11h 96d
KASAN: slab-out-of-bounds Read in fbcon_get_font C cause 42 5d04h 96d
KASAN: slab-out-of-bounds Read in fb_pad_aligned_buffer 4 9d00h 48d
KASAN: slab-out-of-bounds Write in fbcon_scroll 1 75d 73d
KASAN: use-after-free Read in fbcon_cursor syz cause 3 41d 84d
KASAN: use-after-free Read in fb_mode_is_equal syz cause 70 5h49m 92d
KASAN: use-after-free Read in tty_open C cause 7 42d 96d
KASAN: use-after-free Write in release_tty C cause 544 4h01m 96d
KASAN: vmalloc-out-of-bounds Read in drm_fb_helper_dirty_work 1 80d 80d
KASAN: vmalloc-out-of-bounds Write in drm_fb_helper_dirty_work 2 64d 76d
KCSAN: data-race in echo_char / n_tty_receive_buf_common 11 21d 125d
KMSAN: kernel-infoleak in tty_compat_ioctl C 81 2h17m 14d
memory leak in tty_init_dev C 3 121d 192d
possible deadlock in n_tty_receive_buf_common C cause 585 1h18m 23d
possible deadlock in tty_port_close_start C cause 4 9d18h 25d
WARNING in dlfb_submit_urb/usb_submit_urb C 190 8d23h 251d

So if you don't see something obvious here, it may be not worth
spending more time until these, more obvious ones are fixed. This may
be a previous silent memory corruption that wasn't caught by KASAN.
