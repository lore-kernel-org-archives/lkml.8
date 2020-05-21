Return-Path: <SRS0=7UTg=7D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74A02C433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 21 May 2020 16:27:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3C8A420759
	for <linux-kernel@archiver.kernel.org>; Thu, 21 May 2020 16:27:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="K0o/kvZd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729825AbgEUQ1o (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 May 2020 12:27:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728456AbgEUQ1o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 May 2020 12:27:44 -0400
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com [IPv6:2607:f8b0:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00188C061A0E
        for <linux-kernel@vger.kernel.org>; Thu, 21 May 2020 09:27:43 -0700 (PDT)
Received: by mail-pf1-x441.google.com with SMTP id v63so3547703pfb.10
        for <linux-kernel@vger.kernel.org>; Thu, 21 May 2020 09:27:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=XPwZ+enoWr5eA6loAPCV/3vkjRfgUo7mHTVFxuPxPJA=;
        b=K0o/kvZd1FrauoOoPLW79wpOUfthDpAtsz4c6wZg78XJGe/LVr9n6l0l4+3kGHKKvt
         bz0dAkAkWKheWE+2A4xBK9KiowmXAICD0XVom1/cceOVp701ktoEiUm3pvDMHPdP0F64
         U8xDrI46PxNQOHAHgvtymtMiC269LwH/2d6Yi0AG+g+fjeqr6iVC2fUCYPLdVdIPGBGe
         e43QjPKt5EXcE3nZ09hLE3wVKOpsYNv73Qj3kYZEfpBE0oqJ8XcftNHlmmb38msOVOpj
         AlgPb0yHf7fBA1+Gr6gkbSNU5g/bcJCaZ+nEG779S/TogJefDSPp7orTajn4GEXHjusd
         3MFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=XPwZ+enoWr5eA6loAPCV/3vkjRfgUo7mHTVFxuPxPJA=;
        b=mAhdpkjlAfh1SeaAbJ8Ly0CeECxAQX+OF0YUu/D8D2TOQtTLwFLmWgbSLMWNkorPuZ
         SjreQ3tJ603Tdg9tcSUBKIw8QQbw/EoPDYH6wrgb5F/frdDMBwCXW61hoveehIxtU3Ng
         SO2YgmfBx11HT8yNPowjnjCzNHv/x9iQBN+wXCwQto+CindZfJN1TkJGkUI8hdE0XuvP
         xfHGee28c38uZaa/ZErS46uRdvyj6uILTmRPGLzLGK8I3q6xCJaAlqv7qjbDwxo6d+bJ
         n26YljKSVl8CgDFsb5gGJY8qNOYACLNxp+aNLwW74Zm7WV9LBSFGDx+YL2qGt9hcRItd
         SVYw==
X-Gm-Message-State: AOAM5324u5EAdi6c6xiWtj+vngtj8HnBArPfHGtEquOK0oQBL1AGIvX1
        zJT4NUI+l05YIE/wjELD9j1cWc4E7GDDKooZRrjPDg==
X-Google-Smtp-Source: ABdhPJyhrDZVw0Nbp8P1qW7tdXCZlOqTFixwpervkVjXRYTXOhPi4XGyUBCTzZZ5nBM7CYT19usk2wiZJTKdNjs5FFE=
X-Received: by 2002:a62:8647:: with SMTP id x68mr10127197pfd.178.1590078463184;
 Thu, 21 May 2020 09:27:43 -0700 (PDT)
MIME-Version: 1.0
References: <000000000000c866c705a61a95d4@google.com> <9a337dfa-175f-e13b-1977-0f63d589f37c@I-love.SAKURA.ne.jp>
 <0bc8334572c0716e8dcad2ec3b623f20cefdfde3.camel@kernel.org>
In-Reply-To: <0bc8334572c0716e8dcad2ec3b623f20cefdfde3.camel@kernel.org>
From:   Andrey Konovalov <andreyknvl@google.com>
Date:   Thu, 21 May 2020 18:27:32 +0200
Message-ID: <CAAeHK+xKzgNiE_rwyYOqxoUjOdu9Kcv_5G1O7Few2xrHgv1osA@mail.gmail.com>
Subject: Re: INFO: task hung in locks_remove_posix
To:     Jeff Layton <jlayton@kernel.org>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Cc:     syzbot <syzbot+f5bc30abd8916982419c@syzkaller.appspotmail.com>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 21, 2020 at 4:48 PM Jeff Layton <jlayton@kernel.org> wrote:
>
> On Thu, 2020-05-21 at 23:09 +0900, Tetsuo Handa wrote:
> > On 2020/05/21 5:53, syzbot wrote:
> > > Hello,
> > >
> > > syzbot found the following crash on:
> > >
> > > HEAD commit:    806d8acc USB: dummy-hcd: use configurable endpoint naming ..
> > > git tree:       https://github.com/google/kasan.git usb-fuzzer
> > > console output: https://syzkaller.appspot.com/x/log.txt?x=16c9ece2100000
> > > kernel config:  https://syzkaller.appspot.com/x/.config?x=d800e9bad158025f
> > > dashboard link: https://syzkaller.appspot.com/bug?extid=f5bc30abd8916982419c
> > > compiler:       gcc (GCC) 9.0.0 20181231 (experimental)
> > >
> > > Unfortunately, I don't have any reproducer for this crash yet.
> >
> > This seems to be a mislabeling due to '?' in all lines in a trace.
> >
> > #syz dup: INFO: task hung in wdm_flush
>
>
> I'm not sure I trust those stack traces. The console output shows '?'
> characters in front of every frame. Doesn't that mean that that address
> it found on the stack is unreliable?
>
> In principle, unless you're overriding the filp->lock operation (and the
> wdm fs doesn't do that, afaict), locks_remove_posix should not block.
> I'll also note that there is some of this in the logs before the hung
> task warnings:
>
> [  182.020388][   T12] usb 5-1: too many endpoints for config 0 interface 107 altsetting 116: 116, using maximum allowed: 30
> [  182.031661][   T12] usb 5-1: config 0 interface 107 altsetting 116 has 0 endpoint descriptors, different from the interface descriptor's value: 116
> [  182.045145][   T12] usb 5-1: config 0 interface 107 has no altsetting 0
> [  182.052028][   T12] usb 5-1: New USB device found, idVendor=0926, idProduct=3333, bcdDevice= 0.40
> [  182.060120][ T3525] usb 6-1: USB disconnect, device number 20
> [  182.061148][    C0] xpad 6-1:0.65: xpad_irq_out - usb_submit_urb failed with result -19
> [  182.075465][ T3525] xpad 6-1:0.65: xpad_try_sending_next_out_packet - usb_submit_urb failed with result -19
> [  182.075565][   T12] usb 5-1: New USB device strings: Mfr=0, Product=0, SerialNumber=0
> [  182.109020][   T12] usb 5-1: config 0 descriptor??
> [  182.136857][  T163] usb usb2-port1: attempt power cycle
> [  182.410396][ T4447] udc-core: couldn't find an available UDC or it's busy
> [  182.417562][ T4447] misc raw-gadget: fail, usb_gadget_probe_driver returned -16
> [  182.856513][  T163] usb 2-1: new high-speed USB device number 18 using dummy_hcd
> [  183.026601][  T163] usb 2-1: device descriptor read/8, error -61
> [  183.236577][  T163] usb 2-1: device descriptor read/8, error -71
> [  184.068991][ T3525] usb 5-1: USB disconnect, device number 21
> [  206.185571][   T23] INFO: task syz-executor.2:3145 blocked for more than 143 seconds.
> [  206.193630][   T23]       Not tainted 5.7.0-rc5-syzkaller #0
> [  206.199512][   T23] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
> [  206.208242][   T23] syz-executor.2  D28552  3145    370 0x80004006
>
> ...which leads me to believe that this might have more to do with the
> USB subsystem than anything in the posix locking code.
>
> In any case, I doubt there's much we can do here without a more reliable
> stack trace to work from. That call stack doesn't seem to make much
> sense.

Most likely this is a duplicate of:

https://syzkaller.appspot.com/bug?id=e7b761593b23eb50855b9ea31e3be5472b711186

(with more than 30000 crashes now :)

#syz dup: INFO: task hung in wdm_flush
