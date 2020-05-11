Return-Path: <SRS0=ABJN=6Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.4 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0C85C54E8D
	for <linux-kernel@archiver.kernel.org>; Mon, 11 May 2020 06:28:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B38BA20708
	for <linux-kernel@archiver.kernel.org>; Mon, 11 May 2020 06:28:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727913AbgEKG2O (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 May 2020 02:28:14 -0400
Received: from mail-il1-f199.google.com ([209.85.166.199]:51299 "EHLO
        mail-il1-f199.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725854AbgEKG2O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 May 2020 02:28:14 -0400
Received: by mail-il1-f199.google.com with SMTP id h19so5986710ilo.18
        for <linux-kernel@vger.kernel.org>; Sun, 10 May 2020 23:28:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=SdfFMw5QKTbp52YZLfDLUPr8EGNvzpaeFUzU/UMWBC0=;
        b=fOF1ouH9qrg4R9Ilx5N2DbuIpzJLz896WbI5JnFn4mZqO+vVhqOQOtRccAc2oSMdol
         VezO0JQlmdN9H2GpRMSc9ehX9hroMCaTjcvibneDvytvERo/ybiGohUUylUQ6Jl0Cce/
         2A+6Un2V6kxvf5/zqF8WHiVOXiEWxEwfxX/nCn6saBjnbpg1ggEevEi9J+Ulg/EWp21D
         /pFCP5yrBtHcghJ71xoI5a+hS5S+QjFMAZL1BFfukaJyfRpU0VSwIi5QVuzh/jp1FLCD
         aAhe+ubg9z/CvxlrS1yvWcytcLqNMFUzi/KLtSUFZQenzrT8exEn65XQ97XJsEOY3CBR
         mlOw==
X-Gm-Message-State: AGi0PuYOlpkFdoTSGPHqfIAZbYYdcYzRNDuhhNgCJJ1ki/9BoR0RH7fa
        Cydl7RyNqSdPD/KF9L1w+FNJWUheH554CF7IJLsR+eW3AraW
X-Google-Smtp-Source: APiQypLnnjc/3dhr0Q5a3fswFKEcUcTz5qP78a+YlI7XE6RnjODj+LmKxoJntZm/lCawPwk9fB9sIV9RcwKfW7XRKxPWXqr+1hce
MIME-Version: 1.0
X-Received: by 2002:a5d:91c6:: with SMTP id k6mr13800452ior.13.1589178493472;
 Sun, 10 May 2020 23:28:13 -0700 (PDT)
Date:   Sun, 10 May 2020 23:28:13 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000096951505a55973f9@google.com>
Subject: KASAN: vmalloc-out-of-bounds Write in drm_fb_helper_dirty_work (2)
From:   syzbot <syzbot+839b7dbe276bd3648b70@syzkaller.appspotmail.com>
To:     airlied@linux.ie, daniel@ffwll.ch, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, maarten.lankhorst@linux.intel.com,
        mripard@kernel.org, syzkaller-bugs@googlegroups.com,
        tzimmermann@suse.de
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following crash on:

HEAD commit:    e99332e7 gcc-10: mark more functions __init to avoid secti..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=13de23a2100000
kernel config:  https://syzkaller.appspot.com/x/.config?x=a45301b663dae85a
dashboard link: https://syzkaller.appspot.com/bug?extid=839b7dbe276bd3648b70
compiler:       gcc (GCC) 9.0.0 20181231 (experimental)

Unfortunately, I don't have any reproducer for this crash yet.

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+839b7dbe276bd3648b70@syzkaller.appspotmail.com

==================================================================
BUG: KASAN: vmalloc-out-of-bounds in memcpy include/linux/string.h:381 [inline]
BUG: KASAN: vmalloc-out-of-bounds in drm_fb_helper_dirty_blit_real drivers/gpu/drm/drm_fb_helper.c:386 [inline]
BUG: KASAN: vmalloc-out-of-bounds in drm_fb_helper_dirty_work+0x3f5/0x6b0 drivers/gpu/drm/drm_fb_helper.c:415
Write of size 32 at addr ffffc900290e5fe0 by task kworker/3:3/10902

CPU: 3 PID: 10902 Comm: kworker/3:3 Not tainted 5.7.0-rc4-syzkaller #0
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS rel-1.12.0-59-gc9ba5276e321-prebuilt.qemu.org 04/01/2014
Workqueue: events drm_fb_helper_dirty_work
Call Trace:
 __dump_stack lib/dump_stack.c:77 [inline]
 dump_stack+0x188/0x20d lib/dump_stack.c:118
 print_address_description.constprop.0.cold+0x5/0x315 mm/kasan/report.c:382
 __kasan_report.cold+0x35/0x4d mm/kasan/report.c:511
 kasan_report+0x33/0x50 mm/kasan/common.c:625
 check_memory_region_inline mm/kasan/generic.c:187 [inline]
 check_memory_region+0x141/0x190 mm/kasan/generic.c:193
 memcpy+0x39/0x60 mm/kasan/common.c:107
 memcpy include/linux/string.h:381 [inline]
 drm_fb_helper_dirty_blit_real drivers/gpu/drm/drm_fb_helper.c:386 [inline]
 drm_fb_helper_dirty_work+0x3f5/0x6b0 drivers/gpu/drm/drm_fb_helper.c:415
 process_one_work+0x965/0x16a0 kernel/workqueue.c:2268
 worker_thread+0x96/0xe20 kernel/workqueue.c:2414
 kthread+0x388/0x470 kernel/kthread.c:268
 ret_from_fork+0x24/0x30 arch/x86/entry/entry_64.S:352


Memory state around the buggy address:
 ffffc900290e5e80: f9 f9 f9 f9 f9 f9 f9 f9 f9 f9 f9 f9 f9 f9 f9 f9
 ffffc900290e5f00: f9 f9 f9 f9 f9 f9 f9 f9 f9 f9 f9 f9 f9 f9 f9 f9
>ffffc900290e5f80: f9 f9 f9 f9 f9 f9 f9 f9 f9 f9 f9 f9 f9 f9 f9 f9
                                                       ^
 ffffc900290e6000: f9 f9 f9 f9 f9 f9 f9 f9 f9 f9 f9 f9 f9 f9 f9 f9
 ffffc900290e6080: f9 f9 f9 f9 f9 f9 f9 f9 f9 f9 f9 f9 f9 f9 f9 f9
==================================================================


---
This bug is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this bug report. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
