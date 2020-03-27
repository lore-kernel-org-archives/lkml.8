Return-Path: <SRS0=s8dx=5M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58F7CC43331
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Mar 2020 13:30:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 39EE1206F2
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Mar 2020 13:30:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727729AbgC0Na0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Mar 2020 09:30:26 -0400
Received: from mail-io1-f71.google.com ([209.85.166.71]:40465 "EHLO
        mail-io1-f71.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726540AbgC0NaP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Mar 2020 09:30:15 -0400
Received: by mail-io1-f71.google.com with SMTP id z207so8593399iof.7
        for <linux-kernel@vger.kernel.org>; Fri, 27 Mar 2020 06:30:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=n4vumiXWDS40eA/9ntKo+unPEO96iPs77sUIyblD6q8=;
        b=jkLP7P95bIR6dpVkK6ly1zpN0DB9BvNXIrm/DYLqGmvpxfKA+hKQ8yhwo69E0rtNNu
         YlAYKgxZOrM3eDtNybA0KCkavOxz17jtPS4/GTEqaxvhhjGK5JG30D36JaZ1rwvNCgM9
         ASiI6RFh3sK+lwkwtXGErVe1uGMDZ9a0BpKcrNFoiDHVkFElZ1kTpuZBS7YSiVpEF74Y
         pWD2OSmh4DXrK7nxZJc792Cm/SzBuxMYG6TtHuS+UZc9f9iOn697JUaomhq0/RsWGMgF
         Y/hNT1VG5QDLTDsBFY/f2QayH9kS9+Nw2O4jUvjUERwQpX4+/LY/2uTG2UPtRs7GKTOv
         v6OQ==
X-Gm-Message-State: ANhLgQ2McpNTBXrxcgeZEGK769sStcVgH10izP6Vchp3Q2dSvzIh9dkb
        pXBd9qZDiv6DsOO8Dp3cQDLG9wXsUkdw44IoM7izJIm1X1H4
X-Google-Smtp-Source: ADFU+vtsdGZ0mIf4+EJpDoxAfc6IIb4PwKVbgR0RItf2HFkpqESytj6kyz/idIh55iyZQCV/qn/E4spNJ75LiVetgXCIpzopEKJx
MIME-Version: 1.0
X-Received: by 2002:a05:6638:253:: with SMTP id w19mr12803116jaq.137.1585315814604;
 Fri, 27 Mar 2020 06:30:14 -0700 (PDT)
Date:   Fri, 27 Mar 2020 06:30:14 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000fc837f05a1d619d5@google.com>
Subject: INFO: trying to register non-static key in ath9k_htc_rx_msg
From:   syzbot <syzbot+835e7082fea90ddd153f@syzkaller.appspotmail.com>
To:     andreyknvl@google.com, ath9k-devel@qca.qualcomm.com,
        davem@davemloft.net, kvalo@codeaurora.org,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
        linux-wireless@vger.kernel.org, netdev@vger.kernel.org,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following crash on:

HEAD commit:    e17994d1 usb: core: kcov: collect coverage from usb comple..
git tree:       https://github.com/google/kasan.git usb-fuzzer
console output: https://syzkaller.appspot.com/x/log.txt?x=1274cdc5e00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=5d64370c438bc60
dashboard link: https://syzkaller.appspot.com/bug?extid=835e7082fea90ddd153f
compiler:       gcc (GCC) 9.0.0 20181231 (experimental)
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1415bba7e00000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=12c3316be00000

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+835e7082fea90ddd153f@syzkaller.appspotmail.com

INFO: trying to register non-static key.
the code is fine but needs lockdep annotation.
turning off the locking correctness validator.
CPU: 0 PID: 0 Comm: swapper/0 Not tainted 5.6.0-rc5-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
Call Trace:
 <IRQ>
 __dump_stack lib/dump_stack.c:77 [inline]
 dump_stack+0xef/0x16e lib/dump_stack.c:118
 assign_lock_key kernel/locking/lockdep.c:880 [inline]
 register_lock_class+0x1022/0x11d0 kernel/locking/lockdep.c:1189
 __lock_acquire+0xfc/0x3b60 kernel/locking/lockdep.c:3836
 lock_acquire+0x130/0x340 kernel/locking/lockdep.c:4484
 __raw_spin_lock_irqsave include/linux/spinlock_api_smp.h:110 [inline]
 _raw_spin_lock_irqsave+0x32/0x50 kernel/locking/spinlock.c:159
 complete+0x13/0x70 kernel/sched/completion.c:32
 htc_process_conn_rsp drivers/net/wireless/ath/ath9k/htc_hst.c:138 [inline]
 ath9k_htc_rx_msg+0x7c2/0xaf0 drivers/net/wireless/ath/ath9k/htc_hst.c:443
 ath9k_hif_usb_reg_in_cb+0x1ba/0x630 drivers/net/wireless/ath/ath9k/hif_usb.c:718
 __usb_hcd_giveback_urb+0x29a/0x550 drivers/usb/core/hcd.c:1650
 usb_hcd_giveback_urb+0x368/0x420 drivers/usb/core/hcd.c:1716


---
This bug is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this bug report. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
syzbot can test patches for this bug, for details see:
https://goo.gl/tpsmEJ#testing-patches
