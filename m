Return-Path: <SRS0=ltrd=5B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.4 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C4D9C18E5B
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Mar 2020 23:47:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3DFB120663
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Mar 2020 23:47:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732971AbgCPXrU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Mar 2020 19:47:20 -0400
Received: from mail-il1-f199.google.com ([209.85.166.199]:45999 "EHLO
        mail-il1-f199.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732900AbgCPXrT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Mar 2020 19:47:19 -0400
Received: by mail-il1-f199.google.com with SMTP id h12so15341883ils.12
        for <linux-kernel@vger.kernel.org>; Mon, 16 Mar 2020 16:47:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=NlyCPiQeeXe46SWO6vOpnbLfRJ41bBQJbSHfng0kaHk=;
        b=oiRd9nd8F7+loa+mez/5jznuBzO4jLtRSzatzVS6Lc9/wYKuaiV3Tn2I2261tWDfPj
         buyARkRYMfrAP71cz8nY5TbDHKWU+aeSC1K9hH4LKOLT1UXooWgn1hgQhLO1cNWbW+Uu
         s2lqLahrdmgmwVg0VVWcTRG6HDO0ZwbCeJuxIuMWl/yfyTyN3olRlmnS2nbGOd98IT9I
         uXVunMLG/d9B/gYyL4/9OjfWTiASoil2/ouClt+vL0gr3KcmHvShiGPJbs2kq63yv+N+
         Yes4vd0PpBYT9Qc7xuItmTrWTb7KkG04GoPi1G3NRYBtnerBN+zOgpOo6t0xhwUtn6Mw
         0xGA==
X-Gm-Message-State: ANhLgQ1erggx1PyJAmIiGHY8q6VPOHzj+TIUtNt1cij3ZVhtk5VoACTF
        fsUa68Pcx3Jx+E67FaWBUTTrkpejevUKPoWMfXgc9+BM+/nQ
X-Google-Smtp-Source: ADFU+vsryNBcEg/zB8G6qOT+eYg/7l8gp78N4VCAXM42eZb7GFS9/j+AUdUkUK+g4/94bj3W1buRUJ4+QlmxMTwAn6TFwRWpsCA0
MIME-Version: 1.0
X-Received: by 2002:a92:6a10:: with SMTP id f16mr2392363ilc.113.1584402437253;
 Mon, 16 Mar 2020 16:47:17 -0700 (PDT)
Date:   Mon, 16 Mar 2020 16:47:17 -0700
In-Reply-To: <000000000000b380de059f5ff6aa@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000742e9e05a10170bc@google.com>
Subject: Re: WARNING: ODEBUG bug in tcindex_destroy_work (3)
From:   syzbot <syzbot+46f513c3033d592409d2@syzkaller.appspotmail.com>
To:     davem@davemloft.net, jhs@mojatatu.com, jiri@resnulli.us,
        kuba@kernel.org, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org, syzkaller-bugs@googlegroups.com,
        xiyou.wangcong@gmail.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

syzbot has found a reproducer for the following crash on:

HEAD commit:    74522e7b net: sched: set the hw_stats_type in pedit loop
git tree:       net-next
console output: https://syzkaller.appspot.com/x/log.txt?x=14c85173e00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=b5acf5ac38a50651
dashboard link: https://syzkaller.appspot.com/bug?extid=46f513c3033d592409d2
compiler:       gcc (GCC) 9.0.0 20181231 (experimental)
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=17bfff65e00000

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+46f513c3033d592409d2@syzkaller.appspotmail.com

------------[ cut here ]------------
ODEBUG: free active (active state 0) object type: work_struct hint: tcindex_destroy_rexts_work+0x0/0x20 net/sched/cls_tcindex.c:143
WARNING: CPU: 1 PID: 7 at lib/debugobjects.c:485 debug_print_object+0x160/0x250 lib/debugobjects.c:485
Kernel panic - not syncing: panic_on_warn set ...
CPU: 1 PID: 7 Comm: kworker/u4:0 Not tainted 5.6.0-rc5-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
Workqueue: tc_filter_workqueue tcindex_destroy_work
Call Trace:
 __dump_stack lib/dump_stack.c:77 [inline]
 dump_stack+0x188/0x20d lib/dump_stack.c:118
 panic+0x2e3/0x75c kernel/panic.c:221
 __warn.cold+0x2f/0x35 kernel/panic.c:582
 report_bug+0x27b/0x2f0 lib/bug.c:195
 fixup_bug arch/x86/kernel/traps.c:174 [inline]
 fixup_bug arch/x86/kernel/traps.c:169 [inline]
 do_error_trap+0x12b/0x220 arch/x86/kernel/traps.c:267
 do_invalid_op+0x32/0x40 arch/x86/kernel/traps.c:286
 invalid_op+0x23/0x30 arch/x86/entry/entry_64.S:1027
RIP: 0010:debug_print_object+0x160/0x250 lib/debugobjects.c:485
Code: dd c0 fa 51 88 48 89 fa 48 c1 ea 03 80 3c 02 00 0f 85 bf 00 00 00 48 8b 14 dd c0 fa 51 88 48 c7 c7 20 f0 51 88 e8 a8 bd b1 fd <0f> 0b 83 05 8b cf d3 06 01 48 83 c4 20 5b 5d 41 5c 41 5d c3 48 89
RSP: 0018:ffffc90000cdfc40 EFLAGS: 00010082
RAX: 0000000000000000 RBX: 0000000000000003 RCX: 0000000000000000
RDX: 0000000000000000 RSI: ffffffff815bfe61 RDI: fffff5200019bf7a
RBP: 0000000000000001 R08: ffff8880a95de1c0 R09: ffffed1015ce45c9
R10: ffffed1015ce45c8 R11: ffff8880ae722e43 R12: ffffffff8977aba0
R13: ffffffff814a9360 R14: ffff88807e278f98 R15: ffff88809835c6c8
 __debug_check_no_obj_freed lib/debugobjects.c:967 [inline]
 debug_check_no_obj_freed+0x2e1/0x445 lib/debugobjects.c:998
 kfree+0xf6/0x2b0 mm/slab.c:3756
 tcindex_destroy_work+0x2e/0x70 net/sched/cls_tcindex.c:231
 process_one_work+0x94b/0x1690 kernel/workqueue.c:2266
 worker_thread+0x96/0xe20 kernel/workqueue.c:2412
 kthread+0x357/0x430 kernel/kthread.c:255
 ret_from_fork+0x24/0x30 arch/x86/entry/entry_64.S:352
Kernel Offset: disabled
Rebooting in 86400 seconds..

