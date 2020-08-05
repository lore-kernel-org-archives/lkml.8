Return-Path: <SRS0=MXgo=BP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2170C433DF
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Aug 2020 00:10:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9B6F322CB3
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Aug 2020 00:10:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1596586255;
	bh=tRYFaJHLbrWHuzhI/M9Ok8ONo7BPRx1puliRQGyQrBY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=l79x8qtJFKAVlyAmOj4X02cxF8KzySTxWQjNhb2dsJS6dtvBx9n12rctyJNPKcbgn
	 e5UlS7DD+ntTrTMFn96JgaTA3Hw04L4u2NCCmj6NFJGyL7L0GD/ltQPgK8ZWkEic4U
	 68KAc7WsGxDAEkioZC/zZj198L1dONu8ylqos2Q0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728049AbgHEAKy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Aug 2020 20:10:54 -0400
Received: from mail.kernel.org ([198.145.29.99]:46932 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727979AbgHEAKv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Aug 2020 20:10:51 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E2CE322CBB;
        Wed,  5 Aug 2020 00:10:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1596586250;
        bh=tRYFaJHLbrWHuzhI/M9Ok8ONo7BPRx1puliRQGyQrBY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=MkBE5Y4TpZgkrDDGRR2Gs3YFMVv9QVzeps1rhhHW5X8CuAfgF/tX9FqzshQv+RQ2H
         LhAf3iubsZFQynWEMaoCINRifwJDYCoEHSxXkfdssJzldwb69P/+sswms+t0eLZ6T2
         trhDFKBV4fQRUogFXHYY9IGhx7OeVTdEkjB6AYNc=
From:   Sasha Levin <sashal@kernel.org>
To:     torvalds@linux-foundation.org
Cc:     mingo@kernel.org, peterz@infradead.org,
        linux-kernel@vger.kernel.org, Sasha Levin <sashal@kernel.org>
Subject: [PATCH v4 05/14] tools/lib/lockdep: add definition required for IRQ flag tracing
Date:   Tue,  4 Aug 2020 20:10:34 -0400
Message-Id: <20200805001043.3331907-6-sashal@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200805001043.3331907-1-sashal@kernel.org>
References: <20200805001043.3331907-1-sashal@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We are going to start building with CONFIG_TRACE_IRQFLAGS defined, so
let's wire up a few dummy variables in our task_struct.

This isn't needed in userspace, but due to some refactoring in
kernel-side lockdep it's easier to just wire it up and enable
CONFIG_TRACE_IRQFLAGS.

Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 tools/include/linux/lockdep.h | 8 ++++++++
 tools/lib/lockdep/lockdep.c   | 4 ++--
 2 files changed, 10 insertions(+), 2 deletions(-)

diff --git a/tools/include/linux/lockdep.h b/tools/include/linux/lockdep.h
index e56997288f2b0..3a9924d6d3ae8 100644
--- a/tools/include/linux/lockdep.h
+++ b/tools/include/linux/lockdep.h
@@ -23,6 +23,8 @@
 
 #include "../../../include/linux/lockdep.h"
 
+static bool early_boot_irqs_disabled;
+
 struct task_struct {
 	u64 curr_chain_key;
 	int lockdep_depth;
@@ -31,6 +33,12 @@ struct task_struct {
 	gfp_t lockdep_reclaim_gfp;
 	int pid;
 	int state;
+	int softirqs_enabled, hardirqs_enabled, softirqs_disabled, hardirqs_disabled, irq_events;
+	unsigned long softirq_disable_ip, softirq_enable_ip;
+	unsigned int softirq_disable_event, softirq_enable_event;
+	unsigned long hardirq_disable_ip, hardirq_enable_ip;
+	unsigned int hardirq_disable_event, hardirq_enable_event;
+	int softirq_context, hardirq_context;
 	char comm[17];
 };
 
diff --git a/tools/lib/lockdep/lockdep.c b/tools/lib/lockdep/lockdep.c
index 348a9d0fb766a..9be12d233477a 100644
--- a/tools/lib/lockdep/lockdep.c
+++ b/tools/lib/lockdep/lockdep.c
@@ -15,10 +15,10 @@ u32 prandom_u32(void)
 	abort();
 }
 
-void print_irqtrace_events(struct task_struct *curr)
+/*void print_irqtrace_events(struct task_struct *curr)
 {
 	abort();
-}
+}*/
 
 static struct new_utsname *init_utsname(void)
 {
-- 
2.25.1

