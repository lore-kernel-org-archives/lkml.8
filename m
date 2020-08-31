Return-Path: <SRS0=8grS=CJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=BAYES_00,FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9EE5CC433E6
	for <linux-kernel@archiver.kernel.org>; Mon, 31 Aug 2020 11:48:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8773220866
	for <linux-kernel@archiver.kernel.org>; Mon, 31 Aug 2020 11:48:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726526AbgHaLsU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 31 Aug 2020 07:48:20 -0400
Received: from mail-il1-f200.google.com ([209.85.166.200]:56443 "EHLO
        mail-il1-f200.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726144AbgHaLsQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Aug 2020 07:48:16 -0400
Received: by mail-il1-f200.google.com with SMTP id w82so4780730ila.23
        for <linux-kernel@vger.kernel.org>; Mon, 31 Aug 2020 04:48:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=/iTRQyL/57CWo3c4FNSLWhOYt/YjpXSA+mhZxmmaW1c=;
        b=ms5ES1kOkHyAg+dl8Klpz4s1ycYYbnB/ErDLxJ4nosaPo553vyS3ODhnUXQGDNaDP6
         nJzZgmgXZpTGREEgcrz5pNexhicPaYR/StjLKrffmr82RyiWywVosGNrdDXavrbnluuK
         uNHGZtgn1bK3XvfPTY0n3/tdcWUMFY14XgJg8l3ENttJBFXo9ZAxrLSmqFwlFTfm1h+T
         rjFUit4tUxGgsjfhhkAIz6J4kBgrDQ4OfaUKBg+r8YZyBrKsoYruxsa5PNDKnO2lOKpp
         CJHXaHrNrIard9O/jVCOm3AlPUpFH+0IvXLJfrhDU5zAhw4IxJObUMUZLdC5j+BJW3x3
         Bdqw==
X-Gm-Message-State: AOAM53320MYo6S5nGD9ZHfMJ1zLYcQa6yKIVpbC8/CNlPhSSV5jNlpNz
        zZQi9fnjdMjFaNjsTFMBX9cEJH9H8VeXX9v92oeGUPiXj/sW
X-Google-Smtp-Source: ABdhPJyf0IWvn2xSDtVDcy9jX1mz8uFJZ2ZodF7CPXTs66vFHYZXXKd+eUzFUOOruTJFjocyhSNDf4WK9HL/mjX1bIBQdv5MigNK
MIME-Version: 1.0
X-Received: by 2002:a92:c9ca:: with SMTP id k10mr1023132ilq.81.1598874495578;
 Mon, 31 Aug 2020 04:48:15 -0700 (PDT)
Date:   Mon, 31 Aug 2020 04:48:15 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000059779405ae2afa90@google.com>
Subject: KASAN: use-after-free Write in rtl_fw_do_work
From:   syzbot <syzbot+dc3cab055dff074f2d7f@syzkaller.appspotmail.com>
To:     andreyknvl@google.com, davem@davemloft.net, kuba@kernel.org,
        kvalo@codeaurora.org, linux-kernel@vger.kernel.org,
        linux-usb@vger.kernel.org, linux-wireless@vger.kernel.org,
        netdev@vger.kernel.org, pkshih@realtek.com,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    3ed8e1c2 usb: typec: tcpm: Migrate workqueue to RT priorit..
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/usb.git usb-testing
console output: https://syzkaller.appspot.com/x/log.txt?x=111f9015900000
kernel config:  https://syzkaller.appspot.com/x/.config?x=ccafc70ac3d5f49c
dashboard link: https://syzkaller.appspot.com/bug?extid=dc3cab055dff074f2d7f
compiler:       gcc (GCC) 10.1.0-syz 20200507
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=148a00c9900000

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+dc3cab055dff074f2d7f@syzkaller.appspotmail.com

usb 1-1: Direct firmware load for rtlwifi/rtl8192cufw_TMSC.bin failed with error -2
usb 1-1: Direct firmware load for rtlwifi/rtl8192cufw.bin failed with error -2
rtlwifi: Loading alternative firmware rtlwifi/rtl8192cufw.bin
rtlwifi: Selected firmware is not available
==================================================================
BUG: KASAN: use-after-free in rtl_fw_do_work.cold+0x68/0x6a drivers/net/wireless/realtek/rtlwifi/core.c:93
Write of size 4 at addr ffff8881c9c2ff30 by task kworker/1:5/3063

CPU: 1 PID: 3063 Comm: kworker/1:5 Not tainted 5.9.0-rc1-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
Workqueue: events request_firmware_work_func
Call Trace:
 __dump_stack lib/dump_stack.c:77 [inline]
 dump_stack+0xf6/0x16e lib/dump_stack.c:118
 print_address_description.constprop.0+0x1c/0x210 mm/kasan/report.c:383
 __kasan_report mm/kasan/report.c:513 [inline]
 kasan_report.cold+0x37/0x7c mm/kasan/report.c:530
 rtl_fw_do_work.cold+0x68/0x6a drivers/net/wireless/realtek/rtlwifi/core.c:93
 request_firmware_work_func+0x126/0x250 drivers/base/firmware_loader/main.c:1001
 process_one_work+0x94c/0x15f0 kernel/workqueue.c:2269
 worker_thread+0x64c/0x1120 kernel/workqueue.c:2415
 kthread+0x392/0x470 kernel/kthread.c:292
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:294

The buggy address belongs to the page:
page:000000008323bb9d refcount:0 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x1c9c2f
flags: 0x200000000000000()
raw: 0200000000000000 0000000000000000 ffffea0007270bc8 0000000000000000
raw: 0000000000000000 0000000000000000 00000000ffffffff 0000000000000000
page dumped because: kasan: bad access detected

Memory state around the buggy address:
 ffff8881c9c2fe00: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
 ffff8881c9c2fe80: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
>ffff8881c9c2ff00: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
                                     ^
 ffff8881c9c2ff80: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
 ffff8881c9c30000: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
==================================================================


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
syzbot can test patches for this issue, for details see:
https://goo.gl/tpsmEJ#testing-patches
