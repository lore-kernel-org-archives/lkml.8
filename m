Return-Path: <SRS0=52rg=4G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F016BC34022
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Feb 2020 02:42:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C6AD1215A4
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Feb 2020 02:42:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1581993734;
	bh=ZISZO3v3AhBff22PqMDVPy3sI56gdxu348tYny317jk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=O4jD8fozg/unv9LU1MSXRi4hD3esvEpHN71JoZV+Wl5qaWjPUH1kTx76CGoWefPsc
	 ZJ3X5NtpRnVYuG+sKT4F4FMoHapAfnjl+OrLuXP3kEzUT4h1WkwqU5JZAHT6gaU4Lq
	 zeJD2DHmMFx4cQ4/8NK7KA1z9mbdfxaK8y7OHaIU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726681AbgBRCmN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Feb 2020 21:42:13 -0500
Received: from mail.kernel.org ([198.145.29.99]:54262 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726477AbgBRClt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Feb 2020 21:41:49 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 72E8724649;
        Tue, 18 Feb 2020 02:41:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1581993709;
        bh=ZISZO3v3AhBff22PqMDVPy3sI56gdxu348tYny317jk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=wLOu/lunTyTIVPA1PudwJyI4qV2Uh3/dGfChbFpddmixSlmR++kQICW21WZDTpr+5
         ZlrGvCHYaQkQjBx4HohI8YJ1M4NtCw8q0zd5hP45jk8JO46ZIds+PTSZA1oNBjMCmZ
         Rl/xDtsThQKh7pt/QyZMqC0lqf9ACzM2qemf89b0=
From:   Sasha Levin <sashal@kernel.org>
To:     mingo@kernel.org, peterz@infradead.org
Cc:     linux-kernel@vger.kernel.org, tglx@linutronix.de, jolsa@redhat.com,
        alexey.budankov@linux.intel.com, songliubraving@fb.com,
        acme@redhat.com, allison@lohutok.net,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 05/11] tools/lib/lockdep: add definition required for IRQ flag tracing
Date:   Mon, 17 Feb 2020 21:41:27 -0500
Message-Id: <20200218024133.5059-6-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200218024133.5059-1-sashal@kernel.org>
References: <20200218024133.5059-1-sashal@kernel.org>
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
2.20.1

