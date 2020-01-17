Return-Path: <SRS0=N8G3=3G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0C8BC33CB1
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jan 2020 08:24:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8FD9B20728
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jan 2020 08:24:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YPB5am7u"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729636AbgAQIY1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Jan 2020 03:24:27 -0500
Received: from mail-pg1-f193.google.com ([209.85.215.193]:36728 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729317AbgAQIY1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jan 2020 03:24:27 -0500
Received: by mail-pg1-f193.google.com with SMTP id k3so11308540pgc.3
        for <linux-kernel@vger.kernel.org>; Fri, 17 Jan 2020 00:24:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=c3CLbGH3yNmegqMMrTOsWM1VXAtdVUHSPp5sdhxItpE=;
        b=YPB5am7urRYdi3ZEg/wc/wYUlIoNarzwCR501g4ss4efAaGox/Tf/xNZL1/PFI9BLD
         tA/yPz7irn4d1SqeNQSJRfhDI7HNRpnralnmvN/mPSoFwj24VPVQ23oXgQ92iJlozJxm
         998lr08BWiEO849l6fn03UuXyfCf0dkH+eNjlYh+zKJbx2kCk3GDcgjXgwlPLylFWl5Y
         B+a7zYi4ZouoNeo0nLtLTJ35dCfWMjaAI9myoD0YHmp1ZILfBz3hFeX+xIPdpaPcUNGC
         i2Gmpjy02T22QRYOWO4LduTo0HZDqAOx5lV1DWgdA2hY05Kh7I0SEjrz1zO/pJKtzD1J
         2Rtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=c3CLbGH3yNmegqMMrTOsWM1VXAtdVUHSPp5sdhxItpE=;
        b=Dj7amEyLvpxZ3l47HA5LnFQSkqHGpfbaIXW1/3epe1XV/jshxC+H2MoOjHM1VyrMgm
         NQm8vlfZP4G84eYuQOq7aH+OF4V11FbaLbRkAFnYuJiY3qJmDedTWQmycKDa4TybgRLY
         PvNVEshF4vpBSWuBZ2lVkIQbOtxQPHHmVmm79xi2BCu80VeQUIPn8gp4hL4rpQLpK6s0
         xOSyyDW1ZUedYccJzeodVF/E0XG+XBQipWT5K9Hn5Ex55wBVDUK1EFu+mVz851Gv3WLA
         OyI3xEyI0NRUO2xAJI/JRSMFESn+vjGjy52E4SDUfvMEOatlRz/8eMQ7dIPXq4hAVGcg
         nzGw==
X-Gm-Message-State: APjAAAUmaWcQ8GYF5tWkYM+4iLuuOenmjMS8gVeMgDpwauiJXbRmwqVL
        LkxA6duYks8iHlDxl30fpws=
X-Google-Smtp-Source: APXvYqzYGKHy+cjwfqHiazgyLGUHkNRWvGtu8myj7Q3ns2krT7/XXq6cncKglnA05RG2OBg+a5QPMw==
X-Received: by 2002:aa7:9edd:: with SMTP id r29mr1807945pfq.14.1579249466692;
        Fri, 17 Jan 2020 00:24:26 -0800 (PST)
Received: from bj08259pcu1.spreadtrum.com ([117.18.48.82])
        by smtp.gmail.com with ESMTPSA id d1sm6158471pjx.6.2020.01.17.00.24.23
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 17 Jan 2020 00:24:26 -0800 (PST)
From:   Jing Xia <jing.xia.mail@gmail.com>
To:     akpm@linux-foundation.org
Cc:     npiggin@gmail.com, rppt@linux.ibm.com, allison@lohutok.net,
        tglx@linutronix.de, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, yuming.han@unisoc.com,
        chunyang.zhang@unisoc.com, Jing Xia <jing.xia@unisoc.com>
Subject: [RFC] lib/show_mem.c: extend show_mem() to support showing drivers' memory consumption
Date:   Fri, 17 Jan 2020 16:24:05 +0800
Message-Id: <1579249445-27429-1-git-send-email-jing.xia.mail@gmail.com>
X-Mailer: git-send-email 1.9.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jing Xia <jing.xia@unisoc.com>

In low memory situations, sometimes we need to check how much memory
a driver using.This patch add a notifer chain to show_mem.So a driver
can show their memory usage when show_mem_extend() is called.

Co-developed-by: Yuming Han <yuming.han@unisoc.com>
Signed-off-by: Yuming Han <yuming.han@unisoc.com>
Signed-off-by: Jing Xia <jing.xia@unisoc.com>
---
 include/linux/mm.h |  9 +++++++++
 lib/show_mem.c     | 36 ++++++++++++++++++++++++++++++++++++
 2 files changed, 45 insertions(+)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index cfaa8fe..a37274a 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -2201,6 +2201,15 @@ extern void memmap_init_zone(unsigned long, int, unsigned long, unsigned long,
 #ifdef __HAVE_ARCH_RESERVED_KERNEL_PAGES
 extern unsigned long arch_reserved_kernel_pages(void);
 #endif
+enum show_mem_extend_type {
+	SHOW_MEM_EXTEND_BASIC,
+	SHOW_MEM_EXTEND_CLASSIC,
+	SHOW_MEM_EXTEND_ALL
+};
+extern int register_show_mem_notifier(struct notifier_block *nb);
+extern int unregister_show_mem_notifier(struct notifier_block *nb);
+extern void show_mem_extend(unsigned int flags, nodemask_t *nodemask,
+			    enum show_mem_extend_type type);
 
 extern __printf(3, 4)
 void warn_alloc(gfp_t gfp_mask, nodemask_t *nodemask, const char *fmt, ...);
diff --git a/lib/show_mem.c b/lib/show_mem.c
index 1c26c14..6b013cb 100644
--- a/lib/show_mem.c
+++ b/lib/show_mem.c
@@ -7,6 +7,8 @@
 
 #include <linux/mm.h>
 #include <linux/cma.h>
+#include <linux/notifier.h>
+#include <linux/swap.h>
 
 void show_mem(unsigned int filter, nodemask_t *nodemask)
 {
@@ -42,3 +44,37 @@ void show_mem(unsigned int filter, nodemask_t *nodemask)
 	printk("%lu pages hwpoisoned\n", atomic_long_read(&num_poisoned_pages));
 #endif
 }
+
+static BLOCKING_NOTIFIER_HEAD(show_mem_notify_list);
+
+int register_show_mem_notifier(struct notifier_block *nb)
+{
+	return blocking_notifier_chain_register(&show_mem_notify_list, nb);
+}
+EXPORT_SYMBOL_GPL(register_show_mem_notifier);
+
+int unregister_show_mem_notifier(struct notifier_block *nb)
+{
+	return blocking_notifier_chain_unregister(&show_mem_notify_list, nb);
+}
+EXPORT_SYMBOL_GPL(unregister_show_mem_notifier);
+
+void show_mem_extend(unsigned int filter, nodemask_t *nodemask,
+		     enum show_mem_extend_type type)
+{
+	unsigned long used = 0;
+	struct sysinfo si;
+
+	pr_info("Mem-Info-Extend:\n");
+	show_mem(filter, NULL);
+	si_meminfo(&si);
+	pr_info("MemTotal:	%8lu KB\n"
+		"Buffers:	%8lu KB\n"
+		"SwapCached:	%8lu KB\n",
+		(si.totalram) << (PAGE_SHIFT - 10),
+		(si.bufferram) << (PAGE_SHIFT - 10),
+		total_swapcache_pages() << (PAGE_SHIFT - 10));
+
+	blocking_notifier_call_chain(&show_mem_notify_list,
+				     (unsigned long)type, &used);
+}
-- 
1.9.1

