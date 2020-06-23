Return-Path: <SRS0=AM+j=AE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=FROM_LOCAL_DIGITS,
	FROM_LOCAL_HEX,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 980B3C433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 19:47:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 795CF207E8
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 19:47:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387493AbgFWTrP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Jun 2020 15:47:15 -0400
Received: from mail-il1-f197.google.com ([209.85.166.197]:42187 "EHLO
        mail-il1-f197.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733302AbgFWTrO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Jun 2020 15:47:14 -0400
Received: by mail-il1-f197.google.com with SMTP id d3so8581856ilq.9
        for <linux-kernel@vger.kernel.org>; Tue, 23 Jun 2020 12:47:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=KCtwlgZ+RKZk2rijKadVPUxLfAiSocZDUn+/oj8K6OM=;
        b=s9mDx1qFX/C6Mm402LL5Z6iH0A+OhIXTC382TBmGwOTLk7XDAslnpydIQvBEDadXYF
         EzUjTVM+vSP7mBnWl63EGTdIfdwXwBJkk/MwetxMVf4r86i869h8pu3KAo2e8AQhbnOW
         AFviL4daTei8CY9+munVG7i8OBmBWXlUURZfHCGQJpgLfEXrceMBOM8H5d3iDNK1mojS
         ZiAh7/Pbj8qwbF3vCd6wz8En72pry4qoZf7W/Z182zexoMKz0ZAz7rBvYReh0zx8dny4
         9vxdkE1KbdiGv1/wqUUChtcMRG7mRRDSEFCQ3cbg2qBxUGIt667iKZpbO+RtKTRMY9qn
         JC7g==
X-Gm-Message-State: AOAM530bZuXtNLGLihuCwZSvk3l3WHCqkUE35B1A9C7BJiRUNHl4MYmG
        ngsKUZtpLx1hPfPgJO6MhQlwrmh+bfLpeHPcbmNgnTSOEv2o
X-Google-Smtp-Source: ABdhPJxWbF/JdduAtICGRLIrD7B2M74O58yKMzgV1pFof1zqa1ZQrLCp5Xyp58BB+mzyuCSmcZA4j3aEPLRx4Sl8c5fDsij5hO4W
MIME-Version: 1.0
X-Received: by 2002:a92:c643:: with SMTP id 3mr25846387ill.229.1592941634164;
 Tue, 23 Jun 2020 12:47:14 -0700 (PDT)
Date:   Tue, 23 Jun 2020 12:47:14 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000040aa7e05a8c5a02c@google.com>
Subject: KASAN: slab-out-of-bounds Write in snd_usb_mixer_notify_id
From:   syzbot <syzbot+fb14314433463ad51625@syzkaller.appspotmail.com>
To:     alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        perex@perex.cz, syzkaller-bugs@googlegroups.com, tiwai@suse.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following crash on:

HEAD commit:    7ae77150 Merge tag 'powerpc-5.8-1' of git://git.kernel.org..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=14a0b46e100000
kernel config:  https://syzkaller.appspot.com/x/.config?x=d195fe572fb15312
dashboard link: https://syzkaller.appspot.com/bug?extid=fb14314433463ad51625
compiler:       gcc (GCC) 9.0.0 20181231 (experimental)
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=11bb9d35100000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1309c569100000

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+fb14314433463ad51625@syzkaller.appspotmail.com

==================================================================
BUG: KASAN: slab-out-of-bounds in snd_usb_mixer_notify_id+0x219/0x2a0 sound/usb/mixer.c:3240
Write of size 4 at addr ffff888095d78ce0 by task swapper/1/0

CPU: 1 PID: 0 Comm: swapper/1 Not tainted 5.7.0-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
Call Trace:
 <IRQ>
 __dump_stack lib/dump_stack.c:77 [inline]
 dump_stack+0x188/0x20d lib/dump_stack.c:118
 print_address_description.constprop.0.cold+0xd3/0x413 mm/kasan/report.c:383
 __kasan_report mm/kasan/report.c:513 [inline]
 kasan_report.cold+0x1f/0x37 mm/kasan/report.c:530
 snd_usb_mixer_notify_id+0x219/0x2a0 sound/usb/mixer.c:3240
 snd_usb_mixer_interrupt+0x416/0x980 sound/usb/mixer.c:3379
 __usb_hcd_giveback_urb+0x2af/0x4b0 drivers/usb/core/hcd.c:1650
 usb_hcd_giveback_urb+0x368/0x420 drivers/usb/core/hcd.c:1716
 __skb_queue_head_init include/linux/skbuff.h:1854 [inline]
 skbpoolfree drivers/block/aoe/aoedev.c:435 [inline]
 freedev drivers/block/aoe/aoedev.c:290 [inline]
 dummy_timer+0x1243/0x2fe1 drivers/block/aoe/aoedev.c:366
 call_timer_fn+0x1ac/0x780 kernel/time/timer.c:1404
 expire_timers kernel/time/timer.c:1449 [inline]
 __run_timers kernel/time/timer.c:1773 [inline]
 __run_timers kernel/time/timer.c:1740 [inline]
 run_timer_softirq+0x623/0x1600 kernel/time/timer.c:1786


---
This bug is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this bug report. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
syzbot can test patches for this bug, for details see:
https://goo.gl/tpsmEJ#testing-patches
