Return-Path: <SRS0=4r1w=5T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9120C43331
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Apr 2020 12:36:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 890212077D
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Apr 2020 12:36:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403980AbgDCMgQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Apr 2020 08:36:16 -0400
Received: from mail-io1-f70.google.com ([209.85.166.70]:52026 "EHLO
        mail-io1-f70.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2403861AbgDCMgQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Apr 2020 08:36:16 -0400
Received: by mail-io1-f70.google.com with SMTP id m3so5865543ioj.18
        for <linux-kernel@vger.kernel.org>; Fri, 03 Apr 2020 05:36:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=UvbA5A0WRpymYAsYKP+Bj3BYcaBTCY3Et4nTEY3sA68=;
        b=QcypZasu1usMrPSRMozgdYNp1cDnkWQvF5XzTZYKPptOuduCrtKpU++TsS7Kki+Ih4
         eaHd/avzH3H8G9IYPwop4k9EkoHJnXCNdlNRriIypS4KY9rKNMSrTvKybLx29VMmt6PH
         yXL5fu110d+GJ0t5bsVzm1pEYd4ydVRjjkLikcqCSsKitHLP14afNsMj6f4PVZTirRKi
         VaMf5Pc32SdZphfBwCIUUDSquTkYHM1bsjlS3Pjhis8eO0W98/j1tKMFE1AwczhEdvsD
         o56vY961zuDIjaotAzNGGUE3V/T6wyLWheZ+nz5g4LNDtFgboK67gwsVwFTzGZ3HtMiT
         7iRw==
X-Gm-Message-State: AGi0PuYyG+IlHnKL7Awaknv1Mg4yC81stMCvp5Olyb45+6+cwN+UJi+i
        h5uBYUWcmGCsrF68aqNeSzgXd1au5OJjQDQCI6ofK0FlMyWO
X-Google-Smtp-Source: APiQypKOeoi0/P/oER14D0BMRYIlvEPJDDZYRsE3CVFtPY/rAhRbh3XQ0qTPgH1RkKPtTOdK7QS/ERRL6nw/T4NRjAitrkvExrTK
MIME-Version: 1.0
X-Received: by 2002:a92:778e:: with SMTP id s136mr8654364ilc.256.1585917375308;
 Fri, 03 Apr 2020 05:36:15 -0700 (PDT)
Date:   Fri, 03 Apr 2020 05:36:15 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000cc687e05a26229d2@google.com>
Subject: KCSAN: data-race in fuse_lock_inode / process_init_reply
From:   syzbot <syzbot+e9c2dec6b40030f721c6@syzkaller.appspotmail.com>
To:     elver@google.com, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, miklos@szeredi.hu,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following crash on:

HEAD commit:    245a4300 Merge branch 'rcu/kcsan' into tip/locking/kcsan
git tree:       https://github.com/google/ktsan.git kcsan
console output: https://syzkaller.appspot.com/x/log.txt?x=12a7d9a5e00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=a4b9db179318d21f
dashboard link: https://syzkaller.appspot.com/bug?extid=e9c2dec6b40030f721c6
compiler:       gcc (GCC) 9.0.0 20181231 (experimental)

Unfortunately, I don't have any reproducer for this crash yet.

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+e9c2dec6b40030f721c6@syzkaller.appspotmail.com

==================================================================
BUG: KCSAN: data-race in fuse_lock_inode / process_init_reply

read to 0xffff888099cc4d2d of 1 bytes by task 14548 on cpu 1:
 fuse_lock_inode+0x4c/0x90 fs/fuse/inode.c:351
 fuse_lookup+0x3f/0x210 fs/fuse/dir.c:389
 __lookup_hash+0xcb/0x110 fs/namei.c:1544
 filename_create+0x102/0x2d0 fs/namei.c:3639
 user_path_create fs/namei.c:3696 [inline]
 do_linkat+0xff/0x640 fs/namei.c:4298
 __do_sys_link fs/namei.c:4342 [inline]
 __se_sys_link fs/namei.c:4340 [inline]
 __x64_sys_link+0x47/0x60 fs/namei.c:4340
 do_syscall_64+0xcc/0x3a0 arch/x86/entry/common.c:294
 entry_SYSCALL_64_after_hwframe+0x44/0xa9

write to 0xffff888099cc4d2d of 6 bytes by task 14532 on cpu 0:
 process_init_reply+0x7a/0xb90 fs/fuse/inode.c:891
 fuse_request_end+0x324/0x530 fs/fuse/dev.c:328
 end_requests+0x100/0x160 fs/fuse/dev.c:2056
 fuse_abort_conn+0x737/0x7d0 fs/fuse/dev.c:2151
 fuse_dev_release+0x26b/0x290 fs/fuse/dev.c:2186
 __fput+0x1e1/0x520 fs/file_table.c:280
 ____fput+0x1f/0x30 fs/file_table.c:313
 task_work_run+0xf6/0x130 kernel/task_work.c:113
 tracehook_notify_resume include/linux/tracehook.h:188 [inline]
 exit_to_usermode_loop+0x2b4/0x2c0 arch/x86/entry/common.c:164
 prepare_exit_to_usermode arch/x86/entry/common.c:195 [inline]
 syscall_return_slowpath arch/x86/entry/common.c:278 [inline]
 do_syscall_64+0x384/0x3a0 arch/x86/entry/common.c:304
 entry_SYSCALL_64_after_hwframe+0x44/0xa9

Reported by Kernel Concurrency Sanitizer on:
CPU: 0 PID: 14532 Comm: syz-executor.1 Not tainted 5.5.0-rc1-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
==================================================================


---
This bug is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this bug report. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
