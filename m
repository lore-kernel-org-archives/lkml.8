Return-Path: <SRS0=dnKw=BT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4EE61C433E0
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Aug 2020 22:15:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 21F5E206C3
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Aug 2020 22:15:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EkEegYiu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726448AbgHIWPC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 9 Aug 2020 18:15:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726323AbgHIWPC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Aug 2020 18:15:02 -0400
Received: from mail-io1-xd41.google.com (mail-io1-xd41.google.com [IPv6:2607:f8b0:4864:20::d41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14F01C061756
        for <linux-kernel@vger.kernel.org>; Sun,  9 Aug 2020 15:15:02 -0700 (PDT)
Received: by mail-io1-xd41.google.com with SMTP id s189so7083286iod.2
        for <linux-kernel@vger.kernel.org>; Sun, 09 Aug 2020 15:15:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=sQaF90PpIcuP+xs/1px5CITaSQ2qw7KzLG5oySQrZ38=;
        b=EkEegYiusOb5wI6CQxsIU+qTY1cIDF+iZq3K3WNDmV8FT3TONvjhZHaZMgxKVHvoNO
         Ro9VFZ+NMhYA+6l3XjqyXBf5bVBx5f71VgT7cM+jkPlBx/Jv2+BjwiG+sApvsBZKN76H
         ez6KFI8+LKh2cZuRgCxpZDYjt5JAV7xcQOidRrls0vSXYE4TF6Y6BPwDdZcSMMAEX4l2
         B+X5S9SSHr/HPudhrkB+ATPuXEG8JzLhmFFh4LCP/1jozWRWQSBcE3ueclClmAJ6ROAJ
         lD/5UfaGZCLVJTWRoqOQgxkmR5aiyeFJQWHZ/Ij7q2FINyZ9VEcvhPdt2CgYTwR0r3dN
         xPDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=sQaF90PpIcuP+xs/1px5CITaSQ2qw7KzLG5oySQrZ38=;
        b=VsY4Cwb/Pjps1naIySrcU1S4tW02sA/7K8BOm9Ml5ImxV5CssCGwDGC/Kacp6tya3a
         jrvsIhuW+7nYLV5tULY/eK5a+2rnxSsi+xuGPVfVQzjF/V9WMNyBjLbjZiy+qd9/+Jxk
         dAhT2hxTS2E2s7EnWgSh81yD8gV+KWZM7lUluPZpRKkEgPAhKCXd+vlecaaD+BA4J6ay
         DB8vqw8sp6+MbIlMLLxUq1K7uvvvYG/3iL8EyUuIYnnjuQFDxBMge+rhVbCOhfaQNLh1
         mR2rcT/AWzgpsG8yly2ID2sgLeTfdTouqdRM66PqJ4doWqsInSY7URez/UI4vmZ/c91O
         uSIQ==
X-Gm-Message-State: AOAM532UMjRC+s5SrtiQ7x8dpdEJ7nee82qh64JxSAMfcp+x0qX8Frms
        Mh9sa+zN/vt8pSQePY9lxq0=
X-Google-Smtp-Source: ABdhPJwbOlyHy0wSJGCn4IKp7kRY/+u4L0k6pHrwBcDzNftpzuGLdpJ25uCJUFu6HDuJ+s9DaU3CdA==
X-Received: by 2002:a02:9149:: with SMTP id b9mr16792126jag.50.1597011300459;
        Sun, 09 Aug 2020 15:15:00 -0700 (PDT)
Received: from localhost.localdomain (x-128-101-215-112.reshalls.umn.edu. [128.101.215.112])
        by smtp.gmail.com with ESMTPSA id c14sm10675549ild.41.2020.08.09.15.14.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 09 Aug 2020 15:14:59 -0700 (PDT)
From:   James Bond <jameslouisebond@gmail.com>
To:     jameslouisebond@gmail.com
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Kees Cook <keescook@chromium.org>,
        Michel Lespinasse <walken@google.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Denis Efremov <efremov@linux.com>, linux-kernel@vger.kernel.org
Subject: [PATCH] tty/vt: fix a memory leak in con_insert_unipair
Date:   Sun,  9 Aug 2020 17:14:52 -0500
Message-Id: <20200809221453.10235-1-jameslouisebond@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Syzkaller find a memory leak in con_insert_unipair:
    BUG: memory leak
    unreferenced object 0xffff88804893d100 (size 256):
    comm "syz-executor.3", pid 16154, jiffies 4295043307 (age 2392.340s)
    hex dump (first 32 bytes):
    80 af 88 4e 80 88 ff ff 00 a8 88 4e 80 88 ff ff  ...N.......N....
    80 ad 88 4e 80 88 ff ff 00 aa 88 4e 80 88 ff ff  ...N.......N....
    backtrace:
    [<00000000f76ff1de>] kmalloc include/linux/slab.h:555 [inline]
    [<00000000f76ff1de>] kmalloc_array include/linux/slab.h:596 [inline]
    [<00000000f76ff1de>] con_insert_unipair+0x9e/0x1a0 drivers/tty/vt/consolemap.c:482
    [<000000002f1ad7da>] con_set_unimap+0x244/0x2a0 drivers/tty/vt/consolemap.c:595
    [<0000000046ccb106>] do_unimap_ioctl drivers/tty/vt/vt_ioctl.c:297 [inline]
    [<0000000046ccb106>] vt_ioctl+0x863/0x12f0 drivers/tty/vt/vt_ioctl.c:1018
    [<00000000db1577ff>] tty_ioctl+0x4cd/0xa30 drivers/tty/tty_io.c:2656
    [<00000000e5cdf5ed>] vfs_ioctl fs/ioctl.c:48 [inline]
    [<00000000e5cdf5ed>] ksys_ioctl+0xa6/0xd0 fs/ioctl.c:753
    [<00000000fb4aa12c>] __do_sys_ioctl fs/ioctl.c:762 [inline]
    [<00000000fb4aa12c>] __se_sys_ioctl fs/ioctl.c:760 [inline]
    [<00000000fb4aa12c>] __x64_sys_ioctl+0x1a/0x20 fs/ioctl.c:760
    [<00000000f561f260>] do_syscall_64+0x4c/0xe0 arch/x86/entry/common.c:384
    [<0000000056206928>] entry_SYSCALL_64_after_hwframe+0x44/0xa9
    BUG: leak checking failed

To fix this issue, we need to release the pointer p1 when the call of
the function kmalloc_array fail.

Signed-off-by: James Bond <jameslouisebond@gmail.com>
---
 drivers/tty/vt/consolemap.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/tty/vt/consolemap.c b/drivers/tty/vt/consolemap.c
index 5947b54d92be..1e8d06c32ca1 100644
--- a/drivers/tty/vt/consolemap.c
+++ b/drivers/tty/vt/consolemap.c
@@ -489,7 +489,10 @@ con_insert_unipair(struct uni_pagedir *p, u_short unicode, u_short fontpos)
 	p2 = p1[n = (unicode >> 6) & 0x1f];
 	if (!p2) {
 		p2 = p1[n] = kmalloc_array(64, sizeof(u16), GFP_KERNEL);
-		if (!p2) return -ENOMEM;
+		if (!p2) {
+			kfree(p1);
+			return -ENOMEM;
+		}
 		memset(p2, 0xff, 64*sizeof(u16)); /* No glyphs for the characters (yet) */
 	}
 
-- 
2.17.1

