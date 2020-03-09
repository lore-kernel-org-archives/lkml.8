Return-Path: <SRS0=fsZL=42=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22421C18E5A
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Mar 2020 15:19:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E719320578
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Mar 2020 15:19:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="GY7opBl7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727174AbgCIPTw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Mar 2020 11:19:52 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:36703 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726958AbgCIPTv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Mar 2020 11:19:51 -0400
Received: by mail-pl1-f193.google.com with SMTP id g12so4102941plo.3
        for <linux-kernel@vger.kernel.org>; Mon, 09 Mar 2020 08:19:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Yf1WGNQKdnRTZYwPvg0rA3HnZDuK1fcilTtmCuMketA=;
        b=GY7opBl7ePbTVvgJfuJPrfsd7FCf3C/mdyonAq9ETHocMFWmWPTiEVQ6c68qYUGoCk
         MSVQT5KO9dvwlAxSB7ARyS9u2drJABMEHXUDVmqHN9ot50shp/fgwsUcXdwvJ6AFx1bH
         kZuwizdhakLp8bz/TMcPBeoNKj8o/OF6T0qJQ6XRIvySWVZTD+Zck4VHOoC0INvV4N2M
         BoPUsokO1YqZe7KR/Y+CoNR0uQSjXTy05RHaHSCR8qcbeR3Pt8Ie672pLQeIJuoZh4/Y
         PPU7u5ngn0EypyRV/Cl89EdE5gl3ENnSYuP1MqgOo1XzwKYRfCgta+y1pgBvTzDX6r3H
         axIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Yf1WGNQKdnRTZYwPvg0rA3HnZDuK1fcilTtmCuMketA=;
        b=bGDthR6goEeO6wotdLh00AjqhtJUf0gG6pwfww7OOAnTTPDOB0wu9NAnHXp5FFo5hU
         pyLLjAFgwUN0NQN2aZJydXHt8Sqw/8aczGP/RjJjIVuHaaNtLjAL3ggdtzO2baganCeB
         2msKngStVHqzKPf+heAs4V5oZM5lp8ZsoYu43E7UsIJaPZt0uNY47TyrlRFkcOz5jWEw
         /MmiTLJMSop7IZkhHGPCkdwb8i8VvZP0B7344pEdgVXTBj3KjRUGN92uKcW7gVsAnzkB
         cnHFdVJnMsKE1V5bpXPXyI//6qQEJRJV9YYLaA4RDabMuz0Tv8+FLMUh2JZScslaDL/n
         nwAA==
X-Gm-Message-State: ANhLgQ2OEmjgo8VlLk8U8KrLXLklzteiUSm8TGVJkE4D7GAzJqwisukk
        9uXP+1yewq7RCTzM/G631HT87UnSYEZ2ePmIKoWmNMDq4hw=
X-Google-Smtp-Source: ADFU+vtSZUdRh/Jr7H1YNyPpZcU23c20tbkfQtAqjKTaM4SU418MtRQmiQuOlFJko9yOD//ktSpgNnwj2uU0i0ROMCE=
X-Received: by 2002:a17:90a:5218:: with SMTP id v24mr18709379pjh.90.1583767189741;
 Mon, 09 Mar 2020 08:19:49 -0700 (PDT)
MIME-Version: 1.0
References: <000000000000d8e41d0590a01fc7@google.com>
In-Reply-To: <000000000000d8e41d0590a01fc7@google.com>
From:   Andrey Konovalov <andreyknvl@google.com>
Date:   Mon, 9 Mar 2020 16:19:38 +0100
Message-ID: <CAAeHK+xEZo8WrdeOGcs8rJNUEE4tEGnT2S_-to=Zytg-7qNBSw@mail.gmail.com>
Subject: Re: WARNING in flexcop_usb_probe/usb_submit_urb
To:     syzbot <syzbot+26a8e8c838ca7937dc9e@syzkaller.appspotmail.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        LKML <linux-kernel@vger.kernel.org>,
        USB list <linux-usb@vger.kernel.org>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 21, 2019 at 2:58 PM syzbot
<syzbot+26a8e8c838ca7937dc9e@syzkaller.appspotmail.com> wrote:
>
> Hello,
>
> syzbot found the following crash on:
>
> HEAD commit:    eea39f24 usb-fuzzer: main usb gadget fuzzer driver
> git tree:       https://github.com/google/kasan.git usb-fuzzer
> console output: https://syzkaller.appspot.com/x/log.txt?x=151c664c600000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=d0c62209eedfd54e
> dashboard link: https://syzkaller.appspot.com/bug?extid=26a8e8c838ca7937dc9e
> compiler:       gcc (GCC) 9.0.0 20181231 (experimental)
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=16c6042e600000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=14d8d64c600000
>
> IMPORTANT: if you fix the bug, please add the following tag to the commit:
> Reported-by: syzbot+26a8e8c838ca7937dc9e@syzkaller.appspotmail.com
>
> lgdt330x 0-0059: Demod loaded for LGDT3303 chip
> tuner-simple 0-0061: creating new instance
> tuner-simple 0-0061: type set to 64 (LG TDVS-H06xF)
> b2c2-flexcop: found 'LG Electronics LGDT3303 VSB/QAM Frontend' .
> usb 1-1: DVB: registering adapter 0 frontend 0 (LG Electronics LGDT3303
> VSB/QAM Frontend)...
> b2c2-flexcop: initialization of 'Air2PC/AirStar 2 ATSC 3rd generation
> (HD5000)' at the 'USB' bus controlled by a 'FlexCopIII' complete
> ------------[ cut here ]------------
> usb 1-1: BOGUS urb xfer, pipe 0 != type 1
> WARNING: CPU: 0 PID: 12 at drivers/usb/core/urb.c:477
> usb_submit_urb+0x1188/0x13b0 drivers/usb/core/urb.c:477
> Kernel panic - not syncing: panic_on_warn set ...
> CPU: 0 PID: 12 Comm: kworker/0:1 Not tainted 5.3.0-rc5+ #28
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS
> Google 01/01/2011
> Workqueue: usb_hub_wq hub_event
> Call Trace:
>   __dump_stack lib/dump_stack.c:77 [inline]
>   dump_stack+0xca/0x13e lib/dump_stack.c:113
>   panic+0x2a3/0x6da kernel/panic.c:219
>   __warn.cold+0x20/0x4a kernel/panic.c:576
>   report_bug+0x262/0x2a0 lib/bug.c:186
>   fixup_bug arch/x86/kernel/traps.c:179 [inline]
>   fixup_bug arch/x86/kernel/traps.c:174 [inline]
>   do_error_trap+0x12b/0x1e0 arch/x86/kernel/traps.c:272
>   do_invalid_op+0x32/0x40 arch/x86/kernel/traps.c:291
>   invalid_op+0x23/0x30 arch/x86/entry/entry_64.S:1028
> RIP: 0010:usb_submit_urb+0x1188/0x13b0 drivers/usb/core/urb.c:477
> Code: 4d 85 ed 74 2c e8 88 ba ef fd 4c 89 f7 e8 70 bf 1c ff 41 89 d8 44 89
> e1 4c 89 ea 48 89 c6 48 c7 c7 00 69 18 86 e8 6d a0 c5 fd <0f> 0b e9 20 f4
> ff ff e8 5c ba ef fd 4c 89 f2 48 b8 00 00 00 00 00
> RSP: 0018:ffff8881da20f278 EFLAGS: 00010282
> RAX: 0000000000000000 RBX: 0000000000000001 RCX: 0000000000000000
> RDX: 0000000000000000 RSI: ffffffff81288cfd RDI: ffffed103b441e41
> RBP: ffff8881d530c300 R08: ffff8881da1f9800 R09: ffffed103b645d58
> R10: ffffed103b645d57 R11: ffff8881db22eabf R12: 0000000000000000
> R13: ffff8881cf2f0930 R14: ffff8881d69791a0 R15: ffff8881d5f5f780
>   flexcop_usb_transfer_init drivers/media/usb/b2c2/flexcop-usb.c:484 [inline]
>   flexcop_usb_probe.cold+0x5c0/0x7bd drivers/media/usb/b2c2/flexcop-usb.c:575
>   usb_probe_interface+0x305/0x7a0 drivers/usb/core/driver.c:361
>   really_probe+0x281/0x6d0 drivers/base/dd.c:548
>   driver_probe_device+0x101/0x1b0 drivers/base/dd.c:721
>   __device_attach_driver+0x1c2/0x220 drivers/base/dd.c:828
>   bus_for_each_drv+0x162/0x1e0 drivers/base/bus.c:454
>   __device_attach+0x217/0x360 drivers/base/dd.c:894
>   bus_probe_device+0x1e4/0x290 drivers/base/bus.c:514
>   device_add+0xae6/0x16f0 drivers/base/core.c:2165
>   usb_set_configuration+0xdf6/0x1670 drivers/usb/core/message.c:2023
>   generic_probe+0x9d/0xd5 drivers/usb/core/generic.c:210
>   usb_probe_device+0x99/0x100 drivers/usb/core/driver.c:266
>   really_probe+0x281/0x6d0 drivers/base/dd.c:548
>   driver_probe_device+0x101/0x1b0 drivers/base/dd.c:721
>   __device_attach_driver+0x1c2/0x220 drivers/base/dd.c:828
>   bus_for_each_drv+0x162/0x1e0 drivers/base/bus.c:454
>   __device_attach+0x217/0x360 drivers/base/dd.c:894
>   bus_probe_device+0x1e4/0x290 drivers/base/bus.c:514
>   device_add+0xae6/0x16f0 drivers/base/core.c:2165
>   usb_new_device.cold+0x6a4/0xe79 drivers/usb/core/hub.c:2536
>   hub_port_connect drivers/usb/core/hub.c:5098 [inline]
>   hub_port_connect_change drivers/usb/core/hub.c:5213 [inline]
>   port_event drivers/usb/core/hub.c:5359 [inline]
>   hub_event+0x1b5c/0x3640 drivers/usb/core/hub.c:5441
>   process_one_work+0x92b/0x1530 kernel/workqueue.c:2269
>   worker_thread+0x96/0xe20 kernel/workqueue.c:2415
>   kthread+0x318/0x420 kernel/kthread.c:255
>   ret_from_fork+0x24/0x30 arch/x86/entry/entry_64.S:352
> Kernel Offset: disabled
> Rebooting in 86400 seconds..
>
>
> ---
> This bug is generated by a bot. It may contain errors.
> See https://goo.gl/tpsmEJ for more information about syzbot.
> syzbot engineers can be reached at syzkaller@googlegroups.com.
>
> syzbot will keep track of this bug report. See:
> https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
> syzbot can test patches for this bug, for details see:
> https://goo.gl/tpsmEJ#testing-patches

#syz fix: media: b2c2-flexcop-usb: add sanity checking
