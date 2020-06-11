Return-Path: <SRS0=NqQd=7Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 191ADC433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Jun 2020 23:34:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E66852078C
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Jun 2020 23:34:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726380AbgFKXeP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Jun 2020 19:34:15 -0400
Received: from mail-io1-f72.google.com ([209.85.166.72]:40594 "EHLO
        mail-io1-f72.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726294AbgFKXeN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Jun 2020 19:34:13 -0400
Received: by mail-io1-f72.google.com with SMTP id h65so4873250ioa.7
        for <linux-kernel@vger.kernel.org>; Thu, 11 Jun 2020 16:34:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=mf7ecZDnG5EwhGuhp6dMUSWS+/1lZQb0HVhn3jGu8DU=;
        b=toMvnkNU6wHctLXsbqZGfqfNOI7Hpg53TZoEHxEcr0DwxojYtV+Mf+DbDvdmUHGsXv
         oAJefNEvjhESwQkoEp4V/7aly96BzsjRC83MtW2ORe0P88t61Sl2hfbWa5lteH6HoGb2
         mMKe9iTNqLSyF5v+QriHlWK8xIngxwAfU8RSzvR+l96EHVvBhpvDSj1xxxKvWkuDGan7
         AZZPRKPZhCnpwDzMXnHSeB3GBIOW/OIhUNmxvw3zgOPuiAwblufkaMaM5WkwFzz3HGIR
         A89LuBkMW/GNf+akcUCmDIWPwdq7Vk7MKaUImJESKRjgCAdluafa0TS3GDXCp3AGZXoB
         826g==
X-Gm-Message-State: AOAM530gB0DZPrYYqHjPJwgHAfvqhPf/0DUXL7Z5/FgmoI+Y01L4Q1vk
        41iNHSrnJWTwRD0J+ZFS8i5/H51ErpnqbRLBx6zWIsVj5u9C
X-Google-Smtp-Source: ABdhPJxEff4JjwuKFQ5B1ZilXiWMWhcCYLbkzq/jFPOpJRuKSxsM4E9WUNhbe7FP9rd2Cm2cE48r3M758G085AErgw4Zo5KczAjH
MIME-Version: 1.0
X-Received: by 2002:a05:6602:2e87:: with SMTP id m7mr10999855iow.203.1591918452656;
 Thu, 11 Jun 2020 16:34:12 -0700 (PDT)
Date:   Thu, 11 Jun 2020 16:34:12 -0700
In-Reply-To: <000000000000204d2105995c23eb@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000e1ccfd05a7d765e7@google.com>
Subject: Re: KASAN: vmalloc-out-of-bounds Write in sys_imageblit
From:   syzbot <syzbot+26dc38a00dc05118a4e6@syzkaller.appspotmail.com>
To:     b.zolnierkie@samsung.com, dri-devel@lists.freedesktop.org,
        linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

syzbot has found a reproducer for the following crash on:

HEAD commit:    435faf5c Merge tag 'riscv-for-linus-5.8-mw0' of git://git...
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=1519d83e100000
kernel config:  https://syzkaller.appspot.com/x/.config?x=3dbb617b9c2a5bdf
dashboard link: https://syzkaller.appspot.com/bug?extid=26dc38a00dc05118a4e6
compiler:       gcc (GCC) 9.0.0 20181231 (experimental)
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=17fbd189100000

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+26dc38a00dc05118a4e6@syzkaller.appspotmail.com

==================================================================
BUG: KASAN: vmalloc-out-of-bounds in fast_imageblit drivers/video/fbdev/core/sysimgblt.c:229 [inline]
BUG: KASAN: vmalloc-out-of-bounds in sys_imageblit+0x1181/0x1240 drivers/video/fbdev/core/sysimgblt.c:275
Write of size 4 at addr ffffc90009c1b040 by task syz-executor.0/9196

CPU: 2 PID: 9196 Comm: syz-executor.0 Not tainted 5.7.0-syzkaller #0
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS rel-1.12.0-59-gc9ba5276e321-prebuilt.qemu.org 04/01/2014
Call Trace:
 __dump_stack lib/dump_stack.c:77 [inline]
 dump_stack+0x188/0x20d lib/dump_stack.c:118
 print_address_description.constprop.0.cold+0x5/0x413 mm/kasan/report.c:383
 __kasan_report mm/kasan/report.c:513 [inline]
 kasan_report.cold+0x1f/0x37 mm/kasan/report.c:530
 fast_imageblit drivers/video/fbdev/core/sysimgblt.c:229 [inline]
 sys_imageblit+0x1181/0x1240 drivers/video/fbdev/core/sysimgblt.c:275
 drm_fb_helper_sys_imageblit+0x1c/0x180 drivers/gpu/drm/drm_fb_helper.c:747
 bit_putcs_unaligned drivers/video/fbdev/core/bitblit.c:139 [inline]
 bit_putcs+0x8d0/0xd60 drivers/video/fbdev/core/bitblit.c:188
 fbcon_putcs+0x345/0x3f0 drivers/video/fbdev/core/fbcon.c:1362
 do_update_region+0x398/0x630 drivers/tty/vt/vt.c:683
 invert_screen+0x2a7/0x600 drivers/tty/vt/vt.c:800
 highlight drivers/tty/vt/selection.c:57 [inline]
 clear_selection drivers/tty/vt/selection.c:84 [inline]
 clear_selection+0x55/0x70 drivers/tty/vt/selection.c:80
 vc_do_resize+0xff3/0x1370 drivers/tty/vt/vt.c:1230
 fbcon_do_set_font+0x4a0/0x950 drivers/video/fbdev/core/fbcon.c:2608
 fbcon_set_font+0x732/0x870 drivers/video/fbdev/core/fbcon.c:2705
 con_font_set drivers/tty/vt/vt.c:4571 [inline]
 con_font_op+0xd65/0x1160 drivers/tty/vt/vt.c:4636
 vt_ioctl+0x1740/0x2640 drivers/tty/vt/vt_ioctl.c:980
 tty_ioctl+0xedc/0x1440 drivers/tty/tty_io.c:2656
 vfs_ioctl fs/ioctl.c:47 [inline]
 ksys_ioctl+0x11a/0x180 fs/ioctl.c:771
 __do_sys_ioctl fs/ioctl.c:780 [inline]
 __se_sys_ioctl fs/ioctl.c:778 [inline]
 __x64_sys_ioctl+0x6f/0xb0 fs/ioctl.c:778
 do_syscall_64+0xf6/0x7d0 arch/x86/entry/common.c:295
 entry_SYSCALL_64_after_hwframe+0x49/0xb3
RIP: 0033:0x45c879
Code: 1d b2 fb ff c3 66 2e 0f 1f 84 00 00 00 00 00 66 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 0f 83 eb b1 fb ff c3 66 2e 0f 1f 84 00 00 00 00
RSP: 002b:00007fb46427fc78 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
RAX: ffffffffffffffda RBX: 000000000074bf00 RCX: 000000000045c879
RDX: 0000000020000080 RSI: 0000000000004b72 RDI: 0000000000000003
RBP: 00000000006fae40 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 00007fb4642806d4
R13: 000000000000037a R14: 00000000006ecfc0 R15: 00000000004ace26


Memory state around the buggy address:
 ffffc90009c1af00: f9 f9 f9 f9 f9 f9 f9 f9 f9 f9 f9 f9 f9 f9 f9 f9
 ffffc90009c1af80: f9 f9 f9 f9 f9 f9 f9 f9 f9 f9 f9 f9 f9 f9 f9 f9
>ffffc90009c1b000: f9 f9 f9 f9 f9 f9 f9 f9 f9 f9 f9 f9 f9 f9 f9 f9
                                           ^
 ffffc90009c1b080: f9 f9 f9 f9 f9 f9 f9 f9 f9 f9 f9 f9 f9 f9 f9 f9
 ffffc90009c1b100: f9 f9 f9 f9 f9 f9 f9 f9 f9 f9 f9 f9 f9 f9 f9 f9
==================================================================

