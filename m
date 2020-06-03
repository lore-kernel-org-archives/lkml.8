Return-Path: <SRS0=boYM=7Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2FBEC433E0
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jun 2020 03:41:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9BCE92072F
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jun 2020 03:41:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725950AbgFCDlZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Jun 2020 23:41:25 -0400
Received: from mail-il1-f199.google.com ([209.85.166.199]:43386 "EHLO
        mail-il1-f199.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725882AbgFCDlX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Jun 2020 23:41:23 -0400
Received: by mail-il1-f199.google.com with SMTP id e5so287286ill.10
        for <linux-kernel@vger.kernel.org>; Tue, 02 Jun 2020 20:41:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=gXY/ZYEP3SmrwbBJcl7C6Xw3GUvmdoWZklMcqyQfDr4=;
        b=N3PtzmbMuiq2gOfIoJNPH6hkh/eS9WA9barU3S2h4jwgNZOI3c565JY2rhf+GjJD1O
         jPeQEoSXw/pR4u66eCZ8bALIY3KxoS0hSj5xdF+/JlLIi/53HE047INwdXi8W5odjh1V
         /WeVvZd34dtPfgvkx4fEAdMyD2gpd3KD0FwNNlYm1dcERX9xvn22GJdyTAN/JQo+TEhR
         yUo39hcbU2Y+jvJB6ziVOVqm7br0x/MGMPlbtz3lfHFL/VCvy+2NeYlp0JcpVgE9Zgyy
         UACRAmrxbGxvxi5NtIq+HWZGk2ndCGsT4Z8r1a/EaOtvH6MJbYxkZwQT0CHjWpqgdaEN
         8q+A==
X-Gm-Message-State: AOAM531XWLyEWGG7vgnnAyI+fF5EKRdPnBUfcgDY26ea565dCA5cHydo
        GX/iEEMl4fB1YvwmR2IhYpEUz912s7DJoaIXv0D/B/UD1Lum
X-Google-Smtp-Source: ABdhPJxq0CtdjSAJeiL8/yVeyj9mc4ScvfYBmPSicxFf2BLe4pWWyJTMypz7bJatLdWpslCO4PVKgv07dKbKcCnMcQu200HJZv1f
MIME-Version: 1.0
X-Received: by 2002:a92:9603:: with SMTP id g3mr2273048ilh.204.1591155681272;
 Tue, 02 Jun 2020 20:41:21 -0700 (PDT)
Date:   Tue, 02 Jun 2020 20:41:21 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000002a280b05a725cd93@google.com>
Subject: memory leak in crypto_create_tfm
From:   syzbot <syzbot+2e635807decef724a1fa@syzkaller.appspotmail.com>
To:     davem@davemloft.net, herbert@gondor.apana.org.au,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following crash on:

HEAD commit:    19409891 Merge tag 'pnp-5.8-rc1' of git://git.kernel.org/p..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=13165aa6100000
kernel config:  https://syzkaller.appspot.com/x/.config?x=6d41e63a2c7e0715
dashboard link: https://syzkaller.appspot.com/bug?extid=2e635807decef724a1fa
compiler:       gcc (GCC) 9.0.0 20181231 (experimental)
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=17f00ef2100000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=170f2ef2100000

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+2e635807decef724a1fa@syzkaller.appspotmail.com

executing program
executing program
BUG: memory leak
unreferenced object 0xffff8881175bc480 (size 64):
  comm "syz-executor064", pid 6388, jiffies 4294941622 (age 13.280s)
  hex dump (first 32 bytes):
    00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
    e0 7e 56 84 ff ff ff ff 00 00 00 00 00 00 00 00  .~V.............
  backtrace:
    [<0000000029c7602f>] kmalloc include/linux/slab.h:560 [inline]
    [<0000000029c7602f>] kzalloc include/linux/slab.h:669 [inline]
    [<0000000029c7602f>] crypto_create_tfm+0x31/0x100 crypto/api.c:448
    [<00000000bec8cbdb>] crypto_alloc_tfm+0x79/0x1a0 crypto/api.c:527
    [<000000002f9791ba>] drbg_prepare_hrng crypto/drbg.c:1509 [inline]
    [<000000002f9791ba>] drbg_instantiate crypto/drbg.c:1587 [inline]
    [<000000002f9791ba>] drbg_kcapi_seed+0x432/0x6a9 crypto/drbg.c:1980
    [<0000000041302bb8>] crypto_rng_reset+0x35/0x1a0 crypto/rng.c:53
    [<000000004758c3c4>] alg_setkey crypto/af_alg.c:222 [inline]
    [<000000004758c3c4>] alg_setsockopt+0x149/0x190 crypto/af_alg.c:255
    [<000000008bc4b5cb>] __sys_setsockopt+0x112/0x230 net/socket.c:2132
    [<00000000cfbf30da>] __do_sys_setsockopt net/socket.c:2148 [inline]
    [<00000000cfbf30da>] __se_sys_setsockopt net/socket.c:2145 [inline]
    [<00000000cfbf30da>] __x64_sys_setsockopt+0x22/0x30 net/socket.c:2145
    [<00000000fc9c2183>] do_syscall_64+0x6e/0x220 arch/x86/entry/common.c:295
    [<0000000040e080a1>] entry_SYSCALL_64_after_hwframe+0x44/0xa9

BUG: memory leak
unreferenced object 0xffff8881175bc040 (size 64):
  comm "syz-executor064", pid 6389, jiffies 4294942172 (age 7.780s)
  hex dump (first 32 bytes):
    00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
    e0 7e 56 84 ff ff ff ff 00 00 00 00 00 00 00 00  .~V.............
  backtrace:
    [<0000000029c7602f>] kmalloc include/linux/slab.h:560 [inline]
    [<0000000029c7602f>] kzalloc include/linux/slab.h:669 [inline]
    [<0000000029c7602f>] crypto_create_tfm+0x31/0x100 crypto/api.c:448
    [<00000000bec8cbdb>] crypto_alloc_tfm+0x79/0x1a0 crypto/api.c:527
    [<000000002f9791ba>] drbg_prepare_hrng crypto/drbg.c:1509 [inline]
    [<000000002f9791ba>] drbg_instantiate crypto/drbg.c:1587 [inline]
    [<000000002f9791ba>] drbg_kcapi_seed+0x432/0x6a9 crypto/drbg.c:1980
    [<0000000041302bb8>] crypto_rng_reset+0x35/0x1a0 crypto/rng.c:53
    [<000000004758c3c4>] alg_setkey crypto/af_alg.c:222 [inline]
    [<000000004758c3c4>] alg_setsockopt+0x149/0x190 crypto/af_alg.c:255
    [<000000008bc4b5cb>] __sys_setsockopt+0x112/0x230 net/socket.c:2132
    [<00000000cfbf30da>] __do_sys_setsockopt net/socket.c:2148 [inline]
    [<00000000cfbf30da>] __se_sys_setsockopt net/socket.c:2145 [inline]
    [<00000000cfbf30da>] __x64_sys_setsockopt+0x22/0x30 net/socket.c:2145
    [<00000000fc9c2183>] do_syscall_64+0x6e/0x220 arch/x86/entry/common.c:295
    [<0000000040e080a1>] entry_SYSCALL_64_after_hwframe+0x44/0xa9

BUG: memory leak
unreferenced object 0xffff88811b3ca080 (size 96):
  comm "syz-executor064", pid 6389, jiffies 4294942172 (age 7.780s)
  hex dump (first 32 bytes):
    89 c7 08 cb 8a 12 10 6e 00 00 00 00 00 00 00 00  .......n........
    71 51 5a c2 1b 00 00 00 35 7d 00 00 00 00 00 00  qQZ.....5}......
  backtrace:
    [<000000008ec3eca0>] jent_entropy_collector_alloc+0x1b/0xf8 crypto/jitterentropy.c:662
    [<0000000026ed401a>] jent_kcapi_init+0x17/0x40 crypto/jitterentropy-kcapi.c:119
    [<00000000be7d6b06>] crypto_create_tfm+0x89/0x100 crypto/api.c:459
    [<00000000bec8cbdb>] crypto_alloc_tfm+0x79/0x1a0 crypto/api.c:527
    [<000000002f9791ba>] drbg_prepare_hrng crypto/drbg.c:1509 [inline]
    [<000000002f9791ba>] drbg_instantiate crypto/drbg.c:1587 [inline]
    [<000000002f9791ba>] drbg_kcapi_seed+0x432/0x6a9 crypto/drbg.c:1980
    [<0000000041302bb8>] crypto_rng_reset+0x35/0x1a0 crypto/rng.c:53
    [<000000004758c3c4>] alg_setkey crypto/af_alg.c:222 [inline]
    [<000000004758c3c4>] alg_setsockopt+0x149/0x190 crypto/af_alg.c:255
    [<000000008bc4b5cb>] __sys_setsockopt+0x112/0x230 net/socket.c:2132
    [<00000000cfbf30da>] __do_sys_setsockopt net/socket.c:2148 [inline]
    [<00000000cfbf30da>] __se_sys_setsockopt net/socket.c:2145 [inline]
    [<00000000cfbf30da>] __x64_sys_setsockopt+0x22/0x30 net/socket.c:2145
    [<00000000fc9c2183>] do_syscall_64+0x6e/0x220 arch/x86/entry/common.c:295
    [<0000000040e080a1>] entry_SYSCALL_64_after_hwframe+0x44/0xa9



---
This bug is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this bug report. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
syzbot can test patches for this bug, for details see:
https://goo.gl/tpsmEJ#testing-patches
