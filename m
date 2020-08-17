Return-Path: <SRS0=ysYr=B3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D4B3C433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Aug 2020 12:26:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5E45F2075B
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Aug 2020 12:26:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728355AbgHQM0X (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Aug 2020 08:26:23 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:51676 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728255AbgHQM0R (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Aug 2020 08:26:17 -0400
Received: from DGGEMS408-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 011A9D86263573792732;
        Mon, 17 Aug 2020 20:26:16 +0800 (CST)
Received: from localhost.localdomain.localdomain (10.175.113.25) by
 DGGEMS408-HUB.china.huawei.com (10.3.19.208) with Microsoft SMTP Server id
 14.3.487.0; Mon, 17 Aug 2020 20:26:09 +0800
From:   Wei Yongjun <weiyongjun1@huawei.com>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Michael Ellerman <mpe@ellerman.id.au>,
        "David Rientjes" <rientjes@google.com>,
        Michel Lespinasse <walken@google.com>,
        "Daniel Axtens" <dja@axtens.net>,
        Thomas Gleixner <tglx@linutronix.de>,
        Akash Goel <akash.goel@intel.com>,
        Chris Wilson <chris@chris-wilson.co.uk>
CC:     Wei Yongjun <weiyongjun1@huawei.com>,
        <linux-kernel@vger.kernel.org>, "Hulk Robot" <hulkci@huawei.com>
Subject: [PATCH] kernel/relay.c: fix memleak on destroy relay channel
Date:   Mon, 17 Aug 2020 20:28:26 +0800
Message-ID: <20200817122826.48518-1-weiyongjun1@huawei.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.113.25]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

kmemleak report memory leak as follows:

unreferenced object 0x607ee4e5f948 (size 8):
comm "syz-executor.1", pid 2098, jiffies 4295031601 (age 288.468s)
hex dump (first 8 bytes):
00 00 00 00 00 00 00 00 ........
backtrace:
[<00000000ca1de2fa>] relay_open kernel/relay.c:583 [inline]
[<00000000ca1de2fa>] relay_open+0xb6/0x970 kernel/relay.c:563
[<0000000038ae5a4b>] do_blk_trace_setup+0x4a8/0xb20 kernel/trace/blktrace.c:557
[<00000000d5e778e9>] __blk_trace_setup+0xb6/0x150 kernel/trace/blktrace.c:597
[<0000000038fdf803>] blk_trace_ioctl+0x146/0x280 kernel/trace/blktrace.c:738
[<00000000ce25a0ca>] blkdev_ioctl+0xb2/0x6a0 block/ioctl.c:613
[<00000000579e47e0>] block_ioctl+0xe5/0x120 fs/block_dev.c:1871
[<00000000b1588c11>] vfs_ioctl fs/ioctl.c:48 [inline]
[<00000000b1588c11>] __do_sys_ioctl fs/ioctl.c:753 [inline]
[<00000000b1588c11>] __se_sys_ioctl fs/ioctl.c:739 [inline]
[<00000000b1588c11>] __x64_sys_ioctl+0x170/0x1ce fs/ioctl.c:739
[<0000000088fc9942>] do_syscall_64+0x33/0x40 arch/x86/entry/common.c:46
[<000000004f6dd57a>] entry_SYSCALL_64_after_hwframe+0x44/0xa9

'chan->buf' is malloced in relay_open() by alloc_percpu() but not free
while destroy the relay channel. Fix it by adding free_percpu() before
return from relay_destroy_channel().

Fixes: 017c59c042d0 ("relay: Use per CPU constructs for the relay channel buffer pointers")
Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: Wei Yongjun <weiyongjun1@huawei.com>
---
 kernel/relay.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/kernel/relay.c b/kernel/relay.c
index 72fe443ea78f..fb4e0c530c08 100644
--- a/kernel/relay.c
+++ b/kernel/relay.c
@@ -197,6 +197,7 @@ static struct rchan_buf *relay_create_buf(struct rchan *chan)
 static void relay_destroy_channel(struct kref *kref)
 {
 	struct rchan *chan = container_of(kref, struct rchan, kref);
+	free_percpu(chan->buf);
 	kfree(chan);
 }
 
-- 
2.25.1

