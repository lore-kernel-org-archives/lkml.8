Return-Path: <SRS0=QAx1=7P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.4 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3BA2C433DF
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jun 2020 12:20:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BBE162053B
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jun 2020 12:20:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728091AbgFBMUT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Jun 2020 08:20:19 -0400
Received: from mail-il1-f197.google.com ([209.85.166.197]:49105 "EHLO
        mail-il1-f197.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726648AbgFBMUR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Jun 2020 08:20:17 -0400
Received: by mail-il1-f197.google.com with SMTP id o4so4659753ilc.15
        for <linux-kernel@vger.kernel.org>; Tue, 02 Jun 2020 05:20:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=ZnzEZCHryLV8mcyggZorI2Pw7WyGvNuTkNQjiVsjQoU=;
        b=FdsBl84Qyw/W5ukEniHIurNnQaMm5825kUpKX8i4glOz0W9xehWfP9IUl6I9uR/meK
         Low7MW1RO4BHhTPTuds3YEgf+ewb30V2yDQa3tEFpGmU658nRCTBNCTPnZWCL3tpnSTF
         R5gWtUM8yoCwSmfRlF8+FmI+pCt0rHSk1BjQcK/R+8oirgRqoNz7nwBSzQV2xepq5QUU
         +2YlxBGYPaDewbODxZQRFuYSIk1khf6J5bKgOtZFBesjBji/VpnuP3Vj+fqCQJVSA/OD
         zpq1XQYVfXTQ4ww/+MrOO8u1839RxOFfD04hPxFas+JPU9QyK+e2S6TsqbDBj9TPhgsM
         nISQ==
X-Gm-Message-State: AOAM531RgMpH+Ow3Y0/SA1D7+w22Qvf/APGASCyI4fv83urqtS2jXpA+
        voxKvJ46IjwivBoYnZ7B/geUzGN2MrABPD3kHuHyLZ1Gm260
X-Google-Smtp-Source: ABdhPJz+A2UnGb/ByrAkBHUCSaa4hXkbpXZ72LvNlqDKR2a7Ml/YCuiqW9L4PbgcAXUjGaLM/aHRLNoVRDY5jDuWBJ8+1pTQy3Yt
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1286:: with SMTP id y6mr3284521ilq.0.1591100416502;
 Tue, 02 Jun 2020 05:20:16 -0700 (PDT)
Date:   Tue, 02 Jun 2020 05:20:16 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000020b15e05a718ef22@google.com>
Subject: linux-next test error: BUG: using smp_processor_id() in preemptible
 [ADDR] code: kworker/u4:LINE/6740
From:   syzbot <syzbot+8ea916061cc749544c8f@syzkaller.appspotmail.com>
To:     adilger.kernel@dilger.ca, linux-ext4@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-next@vger.kernel.org,
        sfr@canb.auug.org.au, syzkaller-bugs@googlegroups.com,
        tytso@mit.edu
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following crash on:

HEAD commit:    0e21d462 Add linux-next specific files for 20200602
git tree:       linux-next
console output: https://syzkaller.appspot.com/x/log.txt?x=13f3dcca100000
kernel config:  https://syzkaller.appspot.com/x/.config?x=ecc1aef35f550ee3
dashboard link: https://syzkaller.appspot.com/bug?extid=8ea916061cc749544c8f
compiler:       gcc (GCC) 9.0.0 20181231 (experimental)

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+8ea916061cc749544c8f@syzkaller.appspotmail.com

BUG: using smp_processor_id() in preemptible [00000000] code: kworker/u4:6/6740
caller is ext4_mb_new_blocks+0xa4d/0x3b70 fs/ext4/mballoc.c:4711
CPU: 1 PID: 6740 Comm: kworker/u4:6 Not tainted 5.7.0-next-20200602-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
Workqueue: writeback wb_workfn (flush-8:0)
Call Trace:
 __dump_stack lib/dump_stack.c:77 [inline]
 dump_stack+0x18f/0x20d lib/dump_stack.c:118
 check_preemption_disabled+0x20d/0x220 lib/smp_processor_id.c:48
 ext4_mb_new_blocks+0xa4d/0x3b70 fs/ext4/mballoc.c:4711
 ext4_ext_map_blocks+0x201b/0x33e0 fs/ext4/extents.c:4244
 ext4_map_blocks+0x4cb/0x1640 fs/ext4/inode.c:626
 mpage_map_one_extent fs/ext4/inode.c:2377 [inline]
 mpage_map_and_submit_extent fs/ext4/inode.c:2430 [inline]
 ext4_writepages+0x1ab5/0x3400 fs/ext4/inode.c:2782
 do_writepages+0xfa/0x2a0 mm/page-writeback.c:2338
 __writeback_single_inode+0x12a/0x13d0 fs/fs-writeback.c:1453
 writeback_sb_inodes+0x515/0xdc0 fs/fs-writeback.c:1717
 __writeback_inodes_wb+0xc3/0x250 fs/fs-writeback.c:1786
 wb_writeback+0x8db/0xd50 fs/fs-writeback.c:1895
 wb_check_old_data_flush fs/fs-writeback.c:1997 [inline]
 wb_do_writeback fs/fs-writeback.c:2050 [inline]
 wb_workfn+0xab3/0x1090 fs/fs-writeback.c:2079
 process_one_work+0x965/0x1690 kernel/workqueue.c:2269
 worker_thread+0x96/0xe10 kernel/workqueue.c:2415
 kthread+0x3b5/0x4a0 kernel/kthread.c:291
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:293


---
This bug is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this bug report. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
