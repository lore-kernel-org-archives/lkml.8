Return-Path: <SRS0=2JZx=64=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6EADBC433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 14 May 2020 20:18:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 434FF2065F
	for <linux-kernel@archiver.kernel.org>; Thu, 14 May 2020 20:18:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727838AbgENUSM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 May 2020 16:18:12 -0400
Received: from mail-il1-f197.google.com ([209.85.166.197]:33331 "EHLO
        mail-il1-f197.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725975AbgENUSL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 May 2020 16:18:11 -0400
Received: by mail-il1-f197.google.com with SMTP id b29so4376974ilb.0
        for <linux-kernel@vger.kernel.org>; Thu, 14 May 2020 13:18:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=IPg2EsJITZG2pHDONJjjBuxNwGIW/PzUBwTlpT6HwaI=;
        b=kt7fmXUnHbc24athZKnXz7B9MoSBA5EfqsY44OWFC6nXJ8BSLSyDNMgbiGYTBJzNr9
         R14bXiRnkZC7OcdpKoBIZ1ZiEAHuHUFwWfVdIKYMASjfqAsRaK2/BXhgwaz57ebEfVBH
         oEZFrddbyK9ds5YCGQu8yuwwy6g/ynWCyoMUXylV6UT7lk8v2lWrLZ+198LXMPq50Nl2
         yJCzEGbn7Jt+hU2+MolTTp4imEhkMeexkfYPQf16KXh/VX7YyKWe3PJ9JawW3mf4v0/U
         vonOJFxCSRTDjcMgB7Z35FBE1+AXVLs4rWJvSSdx9g58tptQ4pvuUTcmQaWHOxnedNVR
         ElqQ==
X-Gm-Message-State: AOAM531MZcosJc7z98PaOYV8PFcU8CbQEPHZQRrVzf4IJ2KZ+tSDznQq
        uwNbT55wEh3A2/1C5GpX3e+2MOOTuyoYGkp5cwJs15IDkCkV
X-Google-Smtp-Source: ABdhPJxGuvQnbzRJzfnK1FrWkVtW7RepuEfB4roh2OBItqjGz5Gf9NiC+nAr4jfLh94bvRFGGTUGVduyzpa5zafKq1Fxl8+THd+a
MIME-Version: 1.0
X-Received: by 2002:a5d:8b8e:: with SMTP id p14mr5755453iol.110.1589487491247;
 Thu, 14 May 2020 13:18:11 -0700 (PDT)
Date:   Thu, 14 May 2020 13:18:11 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000004a72f505a5a16525@google.com>
Subject: WARNING in media_create_pad_link
From:   syzbot <syzbot+dd320d114deb3f5bb79b@syzkaller.appspotmail.com>
To:     andreyknvl@google.com, laurent.pinchart@ideasonboard.com,
        linux-kernel@vger.kernel.org, linux-media@vger.kernel.org,
        linux-usb@vger.kernel.org, mchehab@kernel.org,
        sakari.ailus@linux.intel.com, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following crash on:

HEAD commit:    059e7e0f usb: raw-gadget: fix typo in uapi headers
git tree:       https://github.com/google/kasan.git usb-fuzzer
console output: https://syzkaller.appspot.com/x/log.txt?x=10e77dfa100000
kernel config:  https://syzkaller.appspot.com/x/.config?x=b484a6e53b2b06ad
dashboard link: https://syzkaller.appspot.com/bug?extid=dd320d114deb3f5bb79b
compiler:       gcc (GCC) 9.0.0 20181231 (experimental)
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=16cd44ac100000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=17b12b92100000

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+dd320d114deb3f5bb79b@syzkaller.appspotmail.com

uvcvideo 1-1:0.0: Entity type for entity Processing 1 was not initialized!
uvcvideo 1-1:0.0: Entity type for entity Input 255 was not initialized!
------------[ cut here ]------------
WARNING: CPU: 0 PID: 163 at drivers/media/mc/mc-entity.c:669 media_create_pad_link+0x500/0x650 drivers/media/mc/mc-entity.c:669
Kernel panic - not syncing: panic_on_warn set ...
CPU: 0 PID: 163 Comm: kworker/0:3 Not tainted 5.7.0-rc1-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
Workqueue: usb_hub_wq hub_event
Call Trace:
 __dump_stack lib/dump_stack.c:77 [inline]
 dump_stack+0xef/0x16e lib/dump_stack.c:118
 panic+0x2aa/0x6e1 kernel/panic.c:221
 __warn.cold+0x2f/0x30 kernel/panic.c:582
 report_bug+0x27b/0x2f0 lib/bug.c:195
 fixup_bug arch/x86/kernel/traps.c:175 [inline]
 fixup_bug arch/x86/kernel/traps.c:170 [inline]
 do_error_trap+0x12b/0x1e0 arch/x86/kernel/traps.c:267
 do_invalid_op+0x32/0x40 arch/x86/kernel/traps.c:286
 invalid_op+0x23/0x30 arch/x86/entry/entry_64.S:1027
RIP: 0010:media_create_pad_link+0x500/0x650 drivers/media/mc/mc-entity.c:669
Code: bc ea ff ff ff eb da e8 ee e0 37 fd 0f 0b 41 bc ea ff ff ff eb cb e8 df e0 37 fd 0f 0b 41 bc ea ff ff ff eb bc e8 d0 e0 37 fd <0f> 0b 41 bc ea ff ff ff eb ad e8 c1 e0 37 fd 0f 0b 41 bc ea ff ff
RSP: 0018:ffff8881ce48ef70 EFLAGS: 00010293
RAX: ff


---
This bug is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this bug report. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
syzbot can test patches for this bug, for details see:
https://goo.gl/tpsmEJ#testing-patches
