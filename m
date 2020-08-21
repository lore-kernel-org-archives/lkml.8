Return-Path: <SRS0=Oudi=B7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=BAYES_00,FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E860C433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Aug 2020 17:03:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1D30920702
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Aug 2020 17:03:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728662AbgHURDg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Aug 2020 13:03:36 -0400
Received: from mail-io1-f70.google.com ([209.85.166.70]:48379 "EHLO
        mail-io1-f70.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728404AbgHUQ6V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Aug 2020 12:58:21 -0400
Received: by mail-io1-f70.google.com with SMTP id k10so1581473iow.15
        for <linux-kernel@vger.kernel.org>; Fri, 21 Aug 2020 09:58:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=hG/nq+uFUOyOWSUsfQoPd7kqlRu0su+Bl0f81PDzkPE=;
        b=dRWt5Rs6OPygK5Fnvz0f3Ks89K8Rnw1kd3JpoU/ACVyVsUpiI2XVi+ythoC1/b61tu
         ESL34112LCPYhqc2kjEWUvl4+KLlSmeFPYSuVm2OOrLrvee5QSH//6fo2wAZ+fnP6hGD
         Zgr5ffsnxaWzPCl8HrjN9sOQz+afEzrCQ682oanB4MbBxjXA6FOgNkuzXwrKCjQCPPyx
         uRDeqbK+zIXrV2GQ4Cq2ZlsDjHFBFmbbG58g+aq+4hH0LkjRjZVVnWSWlL/WSrImwRPU
         02hjWfOhevLngjWXAx69eN87ATun2k19ier0NzA0hYIHWvqPrZpHiyPO7F4J+dczGPq2
         nRaw==
X-Gm-Message-State: AOAM533MQV0OlvOc6i5XjSQkQ30aXrImSn725p/aqzRDQlbrRWYdwUuz
        0WmNYGvuZbR0IN6ylrIsFZsXpWvO2wCI5xdx4mAuexojVii4
X-Google-Smtp-Source: ABdhPJyspOeR+rdEbQqOM2h9ujCTKUfuJ9GR//ug0GwCGDoFQ3/5ZqSXHgPbM662iCvmlRsBQsd2eWhW3hvrlrk8WSBzyPOkFqoV
MIME-Version: 1.0
X-Received: by 2002:a6b:7a41:: with SMTP id k1mr2909959iop.92.1598029100580;
 Fri, 21 Aug 2020 09:58:20 -0700 (PDT)
Date:   Fri, 21 Aug 2020 09:58:20 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000e1877405ad662415@google.com>
Subject: memory leak in rw_copy_check_uvector
From:   syzbot <syzbot+6e14de8b553308b5507c@syzkaller.appspotmail.com>
To:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com, viro@zeniv.linux.org.uk
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    da2968ff Merge tag 'pci-v5.9-fixes-1' of git://git.kernel...
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=124577f9900000
kernel config:  https://syzkaller.appspot.com/x/.config?x=948134d9ff96e950
dashboard link: https://syzkaller.appspot.com/bug?extid=6e14de8b553308b5507c
compiler:       gcc (GCC) 10.1.0-syz 20200507
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=12a9ab36900000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=17049fa1900000

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+6e14de8b553308b5507c@syzkaller.appspotmail.com

BUG: memory leak
unreferenced object 0xffff88811c405400 (size 1024):
  comm "syz-executor386", pid 6503, jiffies 4294942347 (age 13.130s)
  hex dump (first 32 bytes):
    00 01 00 20 00 00 00 00 14 00 00 00 00 00 00 00  ... ............
    00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
  backtrace:
    [<000000001a62dd57>] kmalloc_array include/linux/slab.h:594 [inline]
    [<000000001a62dd57>] rw_copy_check_uvector+0x171/0x1a0 fs/read_write.c:812
    [<0000000016ad020b>] import_iovec+0x4a/0x140 lib/iov_iter.c:1681
    [<00000000fb58399a>] io_import_iovec+0x271/0x640 fs/io_uring.c:2879
    [<0000000002d03b50>] io_rw_prep_async fs/io_uring.c:3006 [inline]
    [<0000000002d03b50>] io_read_prep+0x94/0xf0 fs/io_uring.c:3031
    [<000000008ab01d5d>] io_req_defer_prep fs/io_uring.c:5462 [inline]
    [<000000008ab01d5d>] io_req_defer_prep+0x1c6/0x720 fs/io_uring.c:5442
    [<0000000075ed8a70>] io_submit_sqe fs/io_uring.c:6262 [inline]
    [<0000000075ed8a70>] io_submit_sqes+0x306/0xc00 fs/io_uring.c:6488
    [<00000000d1d617da>] __do_sys_io_uring_enter+0x582/0x830 fs/io_uring.c:8265
    [<00000000334cee0e>] do_syscall_64+0x2d/0x70 arch/x86/entry/common.c:46
    [<0000000053cdb89f>] entry_SYSCALL_64_after_hwframe+0x44/0xa9



---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
syzbot can test patches for this issue, for details see:
https://goo.gl/tpsmEJ#testing-patches
