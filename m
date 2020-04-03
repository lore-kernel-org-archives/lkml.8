Return-Path: <SRS0=4r1w=5T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D8D9C2BA16
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Apr 2020 04:42:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 652C2206F8
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Apr 2020 04:42:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1585888938;
	bh=IlSSFdTCbto5kyJBE4f6YruWvRB+ADD1o1vAqS/skW8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=YGbK0n617gVtTz2R+vh5Lgs6SjKjmRj4weVpmRZSSww9d3e38NW14pzZqNuatTOzq
	 UdWetLkJ6S+NqcDEphkqN/1nJMRTL48UCVmPQleklL96AO+RPVmwDD9AyNYkDFIThG
	 7SRA+/8CSinA9ndqkJ9nhSxDzFdN1CpeNwmqZuQI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732798AbgDCEmR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Apr 2020 00:42:17 -0400
Received: from mail.kernel.org ([198.145.29.99]:42622 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732383AbgDCEmP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Apr 2020 00:42:15 -0400
Received: from localhost.localdomain (unknown [223.93.147.148])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D9390206F8;
        Fri,  3 Apr 2020 04:42:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1585888934;
        bh=IlSSFdTCbto5kyJBE4f6YruWvRB+ADD1o1vAqS/skW8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=AxNKZafgB8GL4cScVWcXQFNuL4Qp8JWlU6UeoHUznZk623LNb1tX3QmqlhXYk3w18
         xcD5zQStgqNJ25Xd0xTyW0ujNeq/ShE0p56c2ywRX5bzZ+eRMJyqbwBU0Pa2nzXqRA
         ETlSOUAKo8tJd5AvIPgPe6jekQysRya5Fy1XylGY=
From:   guoren@kernel.org
To:     arnd@arndb.de
Cc:     linux-kernel@vger.kernel.org, linux-csky@vger.kernel.org,
        Guo Ren <guoren@linux.alibaba.com>
Subject: [PATCH 05/11] csky/ftrace: Fixup ftrace_modify_code deadlock without CPU_HAS_ICACHE_INS
Date:   Fri,  3 Apr 2020 12:41:44 +0800
Message-Id: <20200403044150.20562-5-guoren@kernel.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20200403044150.20562-1-guoren@kernel.org>
References: <20200403044150.20562-1-guoren@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Guo Ren <guoren@linux.alibaba.com>

If ICACHE_INS is not supported, we use IPI to sync icache on each
core. But ftrace_modify_code is called from stop_machine from default
implementation of arch_ftrace_update_code and stop_machine callback
is irq_disabled. When you call ipi with irq_disabled, a deadlock will
happen.

We couldn't use icache_flush with irq_disabled, but startup make_nop
is specific case and it needn't ipi other cores.

Signed-off-by: Guo Ren <guoren@linux.alibaba.com>
---
 arch/csky/kernel/ftrace.c | 31 +++++++++++++++++++++++++++
 arch/csky/mm/cachev2.c    | 45 +++++++++++++++++++++++++++++++++------
 2 files changed, 70 insertions(+), 6 deletions(-)

diff --git a/arch/csky/kernel/ftrace.c b/arch/csky/kernel/ftrace.c
index b4502cd2eabe..44628e3f7fa6 100644
--- a/arch/csky/kernel/ftrace.c
+++ b/arch/csky/kernel/ftrace.c
@@ -3,6 +3,7 @@
 
 #include <linux/ftrace.h>
 #include <linux/uaccess.h>
+#include <linux/stop_machine.h>
 #include <asm/cacheflush.h>
 
 #ifdef CONFIG_DYNAMIC_FTRACE
@@ -201,5 +202,35 @@ int ftrace_disable_ftrace_graph_caller(void)
 #endif /* CONFIG_DYNAMIC_FTRACE */
 #endif /* CONFIG_FUNCTION_GRAPH_TRACER */
 
+#ifndef CONFIG_CPU_HAS_ICACHE_INS
+struct ftrace_modify_param {
+	int command;
+	atomic_t cpu_count;
+};
+
+static int __ftrace_modify_code(void *data)
+{
+	struct ftrace_modify_param *param = data;
+
+	if (atomic_inc_return(&param->cpu_count) == 1) {
+		ftrace_modify_all_code(param->command);
+		atomic_inc(&param->cpu_count);
+	} else {
+		while (atomic_read(&param->cpu_count) <= num_online_cpus())
+			cpu_relax();
+		local_icache_inv_all(NULL);
+	}
+
+	return 0;
+}
+
+void arch_ftrace_update_code(int command)
+{
+	struct ftrace_modify_param param = { command, ATOMIC_INIT(0) };
+
+	stop_machine(__ftrace_modify_code, &param, cpu_online_mask);
+}
+#endif
+
 /* _mcount is defined in abi's mcount.S */
 EXPORT_SYMBOL(_mcount);
diff --git a/arch/csky/mm/cachev2.c b/arch/csky/mm/cachev2.c
index bc419f8039d3..7a9664adce43 100644
--- a/arch/csky/mm/cachev2.c
+++ b/arch/csky/mm/cachev2.c
@@ -7,8 +7,12 @@
 #include <asm/cache.h>
 #include <asm/barrier.h>
 
+/* for L1-cache */
 #define INS_CACHE		(1 << 0)
+#define DATA_CACHE		(1 << 1)
 #define CACHE_INV		(1 << 4)
+#define CACHE_CLR		(1 << 5)
+#define CACHE_OMS		(1 << 6)
 
 void local_icache_inv_all(void *priv)
 {
@@ -16,11 +20,6 @@ void local_icache_inv_all(void *priv)
 	sync_is();
 }
 
-void icache_inv_all(void)
-{
-	on_each_cpu(local_icache_inv_all, NULL, 1);
-}
-
 #ifdef CONFIG_CPU_HAS_ICACHE_INS
 void icache_inv_range(unsigned long start, unsigned long end)
 {
@@ -31,9 +30,43 @@ void icache_inv_range(unsigned long start, unsigned long end)
 	sync_is();
 }
 #else
+struct cache_range {
+	unsigned long start;
+	unsigned long end;
+};
+
+static DEFINE_SPINLOCK(cache_lock);
+
+static inline void cache_op_line(unsigned long i, unsigned int val)
+{
+	mtcr("cr22", i);
+	mtcr("cr17", val);
+}
+
+void local_icache_inv_range(void *priv)
+{
+	struct cache_range *param = priv;
+	unsigned long i = param->start & ~(L1_CACHE_BYTES - 1);
+	unsigned long flags;
+
+	spin_lock_irqsave(&cache_lock, flags);
+
+	for (; i < param->end; i += L1_CACHE_BYTES)
+		cache_op_line(i, INS_CACHE | CACHE_INV | CACHE_OMS);
+
+	spin_unlock_irqrestore(&cache_lock, flags);
+
+	sync_is();
+}
+
 void icache_inv_range(unsigned long start, unsigned long end)
 {
-	icache_inv_all();
+	struct cache_range param = { start, end };
+
+	if (irqs_disabled())
+		local_icache_inv_range(&param);
+	else
+		on_each_cpu(local_icache_inv_range, &param, 1);
 }
 #endif
 
-- 
2.17.0

