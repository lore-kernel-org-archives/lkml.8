Return-Path: <SRS0=n6RB=27=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 560E3C33CA4
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jan 2020 08:25:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2C79A2072E
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jan 2020 08:25:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726962AbgAJIZZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Jan 2020 03:25:25 -0500
Received: from out30-44.freemail.mail.aliyun.com ([115.124.30.44]:47157 "EHLO
        out30-44.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726561AbgAJIZY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jan 2020 03:25:24 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R761e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01f04446;MF=shile.zhang@linux.alibaba.com;NM=1;PH=DS;RN=5;SR=0;TI=SMTPD_---0TnJTHE8_1578644713;
Received: from e18g09479.et15sqa.tbsite.net(mailfrom:shile.zhang@linux.alibaba.com fp:SMTPD_---0TnJTHE8_1578644713)
          by smtp.aliyun-inc.com(127.0.0.1);
          Fri, 10 Jan 2020 16:25:20 +0800
From:   Shile Zhang <shile.zhang@linux.alibaba.com>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Pavel Tatashin <pasha.tatashin@oracle.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Shile Zhang <shile.zhang@linux.alibaba.com>
Subject: [PATCH 1/1] mm: fix tick_sched timer blocked by pgdat_resize_lock
Date:   Fri, 10 Jan 2020 16:25:10 +0800
Message-Id: <20200110082510.172517-2-shile.zhang@linux.alibaba.com>
X-Mailer: git-send-email 2.24.0.rc2
In-Reply-To: <20200110082510.172517-1-shile.zhang@linux.alibaba.com>
References: <20200110082510.172517-1-shile.zhang@linux.alibaba.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When 'CONFIG_DEFERRED_STRUCT_PAGE_INIT' is set, 'pgdat_resize_lock'
will be called inside 'pgdatinit' kthread to initialise the deferred
pages with local interrupts disabled. Which is introduced by
commit 3a2d7fa8a3d5 ("mm: disable interrupts while initializing deferred
pages").

But 'pgdatinit' kthread is possible be pined on the boot CPU (CPU#0 by
default), especially in small system with NRCPUS <= 2. In this case, the
interrupts are disabled on boot CPU during memory initialising, which
caused the tick_sched timer be blocked, leading to wall clock stuck.

Fixes: commit 3a2d7fa8a3d5 ("mm: disable interrupts while initializing
deferred pages")

Signed-off-by: Shile Zhang <shile.zhang@linux.alibaba.com>
---
 include/linux/memory_hotplug.h | 14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

diff --git a/include/linux/memory_hotplug.h b/include/linux/memory_hotplug.h
index ba0dca6aac6e..6ffcb5b704bc 100644
--- a/include/linux/memory_hotplug.h
+++ b/include/linux/memory_hotplug.h
@@ -282,12 +282,22 @@ static inline bool movable_node_is_enabled(void)
 static inline
 void pgdat_resize_lock(struct pglist_data *pgdat, unsigned long *flags)
 {
-	spin_lock_irqsave(&pgdat->node_size_lock, *flags);
+	/*
+	 * Disable local interrupts on boot CPU will stop the tick_sched
+	 * timer, which will block jiffies(wall clock) update.
+	 */
+	if (current->cpu != get_boot_cpu_id())
+		spin_lock_irqsave(&pgdat->node_size_lock, *flags);
+	else
+		spin_lock(&pgdat->node_size_lock);
 }
 static inline
 void pgdat_resize_unlock(struct pglist_data *pgdat, unsigned long *flags)
 {
-	spin_unlock_irqrestore(&pgdat->node_size_lock, *flags);
+	if (current->cpu != get_boot_cpu_id())
+		spin_unlock_irqrestore(&pgdat->node_size_lock, *flags);
+	else
+		spin_unlock(&pgdat->node_size_lock);
 }
 static inline
 void pgdat_resize_init(struct pglist_data *pgdat)
-- 
2.24.0.rc2

