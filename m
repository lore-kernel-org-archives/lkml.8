Return-Path: <SRS0=dFdc=BX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=BAYES_00,FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6AED8C433E3
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Aug 2020 04:12:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 53BBD2076C
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Aug 2020 04:12:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726042AbgHMEMR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Aug 2020 00:12:17 -0400
Received: from mail-il1-f197.google.com ([209.85.166.197]:46872 "EHLO
        mail-il1-f197.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725747AbgHMEMR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Aug 2020 00:12:17 -0400
Received: by mail-il1-f197.google.com with SMTP id q19so3457522ilt.13
        for <linux-kernel@vger.kernel.org>; Wed, 12 Aug 2020 21:12:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=fLaCGHGgT3wqRkpWLRL3dQ2c0G5xWbLrSnsnvPdBuKY=;
        b=joEneXhiwwWskBLYdgsrAP048WKo3xrGALUWRzu3+UU9DrM4QQk38oo+uJG2FDzmFy
         TW1nmpwcqtt2AmzRzmo5G+KKCt4X383Po4PhSWP36bvD9RE6OozA7bMBniuT24j4o0RG
         y+nfB+sgZvxca6qvK1jQb+36TsDV19wyI9hYLbU6CTXCS1Cdv8jS/NzsxtLX2PySiWTV
         gJxJJ4ft2fB5/Imr+L+2yeGphCfL3I2k+cDTCbg1a8FWrPj6mx6hjlhQk14aosjq4LN2
         nkmYUvfWJ7dCndmBwy8c/4vibV+ky1uSq/6SR35Bc80b96SBe1Fh12pKEKrF3gGLR5eu
         +yxQ==
X-Gm-Message-State: AOAM533NmJStAAmfO9slw86XjX6qWlv5DWeS9TTI0+X175sQ2EkmhDzb
        IzT/Xm1Ogs4n4UNwMM0hVhD9zMT4jru68kgTOLeN8jS7EgJj
X-Google-Smtp-Source: ABdhPJxrZ/akRosvNiyLsSh0xjc7hpy58bbdmFwt0MLxpTnT6JmfrK4nwTqpsl/wwi/bao4wDkugmY7vjJcoL/UofK6+g02jAtCe
MIME-Version: 1.0
X-Received: by 2002:a92:ba17:: with SMTP id o23mr2957896ili.198.1597291936463;
 Wed, 12 Aug 2020 21:12:16 -0700 (PDT)
Date:   Wed, 12 Aug 2020 21:12:16 -0700
In-Reply-To: <000000000000eb931405ac9d164f@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000079c37a05acba82d0@google.com>
Subject: Re: KMSAN: uninit-value in joydev_connect
From:   syzbot <syzbot+6a1bb5a33a0b128085bc@syzkaller.appspotmail.com>
To:     dmitry.torokhov@gmail.com, glider@google.com,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

syzbot has found a reproducer for the following issue on:

HEAD commit:    ce8056d1 wip: changed copy_from_user where instrumented
git tree:       https://github.com/google/kmsan.git master
console output: https://syzkaller.appspot.com/x/log.txt?x=127b9fba900000
kernel config:  https://syzkaller.appspot.com/x/.config?x=3afe005fb99591f
dashboard link: https://syzkaller.appspot.com/bug?extid=6a1bb5a33a0b128085bc
compiler:       clang version 10.0.0 (https://github.com/llvm/llvm-project/ c2443155a0fb245c8f17f2c1c72b6ea391e86e81)
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1472674e900000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=15a1339a900000

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+6a1bb5a33a0b128085bc@syzkaller.appspotmail.com

usb 1-1: config 0 interface 219 altsetting 0 endpoint 0xA has invalid wMaxPacketSize 0
usb 1-1: New USB device found, idVendor=078c, idProduct=1002, bcdDevice=e6.47
usb 1-1: New USB device strings: Mfr=0, Product=0, SerialNumber=0
usb 1-1: config 0 descriptor??
gtco 1-1:0.219: Collection level already at zero
input: GTCO_CalComp as /devices/platform/dummy_hcd.0/usb1/1-1/1-1:0.219/input/input5
=====================================================
BUG: KMSAN: uninit-value in joydev_connect+0x10c0/0x1920 drivers/input/joydev.c:958
CPU: 1 PID: 27 Comm: kworker/1:1 Not tainted 5.8.0-rc5-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
Workqueue: usb_hub_wq hub_event
Call Trace:
 __dump_stack lib/dump_stack.c:77 [inline]
 dump_stack+0x21c/0x280 lib/dump_stack.c:118
 kmsan_report+0xf7/0x1e0 mm/kmsan/kmsan_report.c:121
 __msan_warning+0x58/0xa0 mm/kmsan/kmsan_instr.c:215
 joydev_connect+0x10c0/0x1920 drivers/input/joydev.c:958
 input_attach_handler drivers/input/input.c:1031 [inline]
 input_register_device+0x1d7b/0x21c0 drivers/input/input.c:2229
 gtco_probe+0x32ce/0x39b0 drivers/input/tablet/gtco.c:990
 usb_probe_interface+0xece/0x1550 drivers/usb/core/driver.c:374
 really_probe+0xf20/0x20b0 drivers/base/dd.c:529
 driver_probe_device+0x293/0x390 drivers/base/dd.c:701
 __device_attach_driver+0x63f/0x830 drivers/base/dd.c:807
 bus_for_each_drv+0x2ca/0x3f0 drivers/base/bus.c:431
 __device_attach+0x4e2/0x7f0 drivers/base/dd.c:873
 devic

