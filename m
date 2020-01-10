Return-Path: <SRS0=n6RB=27=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B458EC33CA2
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jan 2020 08:25:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 92C752072E
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jan 2020 08:25:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726927AbgAJIZW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Jan 2020 03:25:22 -0500
Received: from out30-45.freemail.mail.aliyun.com ([115.124.30.45]:46664 "EHLO
        out30-45.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726583AbgAJIZW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jan 2020 03:25:22 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R811e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e07417;MF=shile.zhang@linux.alibaba.com;NM=1;PH=DS;RN=5;SR=0;TI=SMTPD_---0TnJTHE8_1578644713;
Received: from e18g09479.et15sqa.tbsite.net(mailfrom:shile.zhang@linux.alibaba.com fp:SMTPD_---0TnJTHE8_1578644713)
          by smtp.aliyun-inc.com(127.0.0.1);
          Fri, 10 Jan 2020 16:25:20 +0800
From:   Shile Zhang <shile.zhang@linux.alibaba.com>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Pavel Tatashin <pasha.tatashin@oracle.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Shile Zhang <shile.zhang@linux.alibaba.com>
Subject: [PATCH 0/1] try to fix tick_sched timer stuck issue
Date:   Fri, 10 Jan 2020 16:25:09 +0800
Message-Id: <20200110082510.172517-1-shile.zhang@linux.alibaba.com>
X-Mailer: git-send-email 2.24.0.rc2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andrew and Pavel,

I found the 'tick_sched timer stuck' issue when enabled deferred pages
initialize feature on my 2c320g VM.
The dmesg log shown that deferred 81,699,533 pages (about 310GB) only
with 1ms!

    [    0.340130] node 0 initialised, 81699533 pages in 1ms

Obviously that is wrong time, and the timestamp in dmesg log. I checked
the sysytemd-analyze, also is wrong time:

    Startup finished in 837ms (kernel) + 1.026s (initrd) + 1.542s (userspace) = 3.407s

In fact, to initialize 320GB memory needs about 2+s on my VM.

I guess it possible caused by the timer is blocked during memory
initialising, so I added debug log based on my roughly anaylsis,
inside 'pgdat_resize_{lock,unlock}', as following:
---8<---
diff --git a/include/linux/memory_hotplug.h b/include/linux/memory_hotplug.h
index 92b1047..7c00c56 100644
--- a/include/linux/memory_hotplug.h
+++ b/include/linux/memory_hotplug.h
@@ -285,13 +285,13 @@ static inline bool movable_node_is_enabled(void)
 void pgdat_resize_lock(struct pglist_data *pgdat, unsigned long *flags)
 {
        spin_lock_irqsave(&pgdat->node_size_lock, *flags);
-       trace_printk("DBG: pgdat_resize_lock: jiffies=%lu\n", jiffies);
+       trace_printk("  DBG: jiffies=%lu after pgdat_resize_lock\n", jiffies);
 }
 static inline
 void pgdat_resize_unlock(struct pglist_data *pgdat, unsigned long *flags)
 {
        mdelay(100);
-       trace_printk("DBG: pgdat_resize_unlock: jiffies=%lu\n", jiffies);
+       trace_printk("DBG: jiffies=%lu before pgdat_resize_unlock\n", jiffies);
        spin_unlock_irqrestore(&pgdat->node_size_lock, *flags);
 }
 static inline
--->8---

Note, I add 'mdelay(100)' to check if the jiffies is stuck to update.
The trace shown that the jiffies was stuck inside pgdat_resize_{lock,unlock}:

    pgdatinit0-19    [000] d...     0.339850: pgdat_resize_lock:   DBG: jiffies=4294667301 after pgdat_resize_lock
    pgdatinit0-19    [000] d...     2.929611: pgdat_resize_unlock: DBG: jiffies=4294667301 before pgdat_resize_unlock

I think the root cause is clear now.

I'm not clear about the original 'window issue' mentioned by Pavel,
in commit:
https://lore.kernel.org/patchwork/patch/933504/

I just try to fix this timer issue, please help to review if it is OK to
fix it, or give some advise to fix this issue gracefully, thanks!

One more question is, I found there also other spin_lock_irqsave be used in
the kernel boot path on boot CPU, but I cannot search any issue reported
about if interrupts can be disabled on boot CPU on boot path. How we ensure
the tick_sched timer be fired in time? :r the accuracy of system wall clock?

Thanks!

Shile Zhang (1):
  mm: fix tick_sched timer blocked by pgdat_resize_lock

 include/linux/memory_hotplug.h | 14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

-- 
2.24.0.rc2

