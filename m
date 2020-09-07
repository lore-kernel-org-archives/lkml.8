Return-Path: <SRS0=/EmK=CQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=BAYES_00,FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56546C43461
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Sep 2020 21:19:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2C566217A0
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Sep 2020 21:19:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728104AbgIGVTa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Sep 2020 17:19:30 -0400
Received: from mail-io1-f78.google.com ([209.85.166.78]:44608 "EHLO
        mail-io1-f78.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727869AbgIGVTR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Sep 2020 17:19:17 -0400
Received: by mail-io1-f78.google.com with SMTP id l8so8535971ioa.11
        for <linux-kernel@vger.kernel.org>; Mon, 07 Sep 2020 14:19:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=KDsIY9T/YTTlKMwesQyoJ6ofuhbIdzhOayQF73PmSbw=;
        b=KoPmQcRyJ8cJoKqv+i6nZNCAB6namXGNb2hJJDMS1eKkoDX+XcQgPUgWzbA37lCnlO
         1wDPFIm6GQo6yq+sDVbfIkffNjfEOnmkyXAwNKuljZl6zmdN6br3Ttq9N1H+UUU2h4Nm
         NA8jOhEN+oHcfQ8ANSF3O+2wa83Ah0CIVByz4Iz6RXozdRcxEMIO5pdLJfHxV3T+yauj
         LEzWirP0md+b80r1ukujlZX4lyq/eN1AcmA4eIvYQ2AqChGd/HHNAv/QeIqa9Esb1u61
         9AsQIqsoZTniTUrtCmOcP/yreBibjevPH/3PvnTmEOl7XxMTyta6iHOTaYyvhG4SInOi
         sUAQ==
X-Gm-Message-State: AOAM532dqFY0WlPWPG8dZxZqrQnkYeAu9hPk0MkIC3WPiRSPIUu1yltF
        5kDXoOeZOY8bLedq8tV6pJqKgUXcmECdkAuPpDkGTTln7LWg
X-Google-Smtp-Source: ABdhPJw22dwmVAPZ9SruiFpMv44NnluSWWCi0x/WHYJ6GOkdMfP+JrrrAJQjP7aqkLwToAMWPQMWs9Sz4aA+PKlNIPULyb1thvlz
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:60c:: with SMTP id t12mr2508124ils.200.1599513556041;
 Mon, 07 Sep 2020 14:19:16 -0700 (PDT)
Date:   Mon, 07 Sep 2020 14:19:16 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000005244f405aebfc5ba@google.com>
Subject: INFO: trying to register non-static key in update_defense_level
From:   syzbot <syzbot+80eac45c3b92882289f6@syzkaller.appspotmail.com>
To:     coreteam@netfilter.org, davem@davemloft.net, fw@strlen.de,
        horms@verge.net.au, ja@ssi.bg, kadlec@netfilter.org,
        kuba@kernel.org, linux-kernel@vger.kernel.org,
        lvs-devel@vger.kernel.org, netdev@vger.kernel.org,
        netfilter-devel@vger.kernel.org, pablo@netfilter.org,
        syzkaller-bugs@googlegroups.com, wensong@linux-vs.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    9322c47b Merge tag 'xfs-5.9-fixes-2' of git://git.kernel.o..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=1670fe59900000
kernel config:  https://syzkaller.appspot.com/x/.config?x=bd46548257448703
dashboard link: https://syzkaller.appspot.com/bug?extid=80eac45c3b92882289f6
compiler:       gcc (GCC) 10.1.0-syz 20200507

Unfortunately, I don't have any reproducer for this issue yet.

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+80eac45c3b92882289f6@syzkaller.appspotmail.com

INFO: trying to register non-static key.
the code is fine but needs lockdep annotation.
turning off the locking correctness validator.
CPU: 0 PID: 607 Comm: kworker/0:12 Not tainted 5.9.0-rc3-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
Workqueue: events_long defense_work_handler
Call Trace:
 __dump_stack lib/dump_stack.c:77 [inline]
 dump_stack+0x198/0x1fd lib/dump_stack.c:118
 assign_lock_key kernel/locking/lockdep.c:894 [inline]
 register_lock_class+0x157d/0x1630 kernel/locking/lockdep.c:1206
 __lock_acquire+0xf9/0x5570 kernel/locking/lockdep.c:4305
 lock_acquire+0x1f3/0xae0 kernel/locking/lockdep.c:5006
 __raw_spin_lock include/linux/spinlock_api_smp.h:142 [inline]
 _raw_spin_lock+0x2a/0x40 kernel/locking/spinlock.c:151
 spin_lock include/linux/spinlock.h:354 [inline]
 update_defense_level+0xdc/0x10f0 net/netfilter/ipvs/ip_vs_ctl.c:113
 defense_work_handler+0x25/0xe0 net/netfilter/ipvs/ip_vs_ctl.c:235
 process_one_work+0x94c/0x1670 kernel/workqueue.c:2269
 worker_thread+0x64c/0x1120 kernel/workqueue.c:2415
 kthread+0x3b5/0x4a0 kernel/kthread.c:292
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:294


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
