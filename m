Return-Path: <SRS0=xbEg=53=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34097C2BBC7
	for <linux-kernel@archiver.kernel.org>; Sat, 11 Apr 2020 13:06:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 16C3320753
	for <linux-kernel@archiver.kernel.org>; Sat, 11 Apr 2020 13:06:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726182AbgDKNGt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 11 Apr 2020 09:06:49 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:13153 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726037AbgDKNGt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Apr 2020 09:06:49 -0400
Received: from DGGEMS409-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id B30933196E5B490457B4;
        Sat, 11 Apr 2020 21:06:41 +0800 (CST)
Received: from use12-sp2.huawei.com (10.67.189.174) by
 DGGEMS409-HUB.china.huawei.com (10.3.19.209) with Microsoft SMTP Server id
 14.3.487.0; Sat, 11 Apr 2020 21:06:22 +0800
From:   Xiaoming Ni <nixiaoming@huawei.com>
To:     <mcgrof@kernel.org>, <keescook@chromium.org>, <yzaikin@google.com>,
        <James.Bottomley@HansenPartnership.com>, <deller@gmx.de>
CC:     <nixiaoming@huawei.com>, <linux-kernel@vger.kernel.org>,
        <linux-fsdevel@vger.kernel.org>, <linux-parisc@vger.kernel.org>,
        <wangle6@huawei.com>, <victor.lisheng@huawei.com>
Subject: [PATCH] parisc: add sysctl file interface panic_on_stackoverflow
Date:   Sat, 11 Apr 2020 21:06:19 +0800
Message-ID: <1586610379-51745-1-git-send-email-nixiaoming@huawei.com>
X-Mailer: git-send-email 1.8.5.6
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.189.174]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The variable sysctl_panic_on_stackoverflow is used in
arch/parisc/kernel/irq.c and arch/x86/kernel/irq_32.c, but the sysctl file
interface panic_on_stackoverflow only exists on x86.

Add sysctl file interface panic_on_stackoverflow for parisc

Signed-off-by: Xiaoming Ni <nixiaoming@huawei.com>
---
 kernel/sysctl.c | 20 +++++++++++---------
 1 file changed, 11 insertions(+), 9 deletions(-)

diff --git a/kernel/sysctl.c b/kernel/sysctl.c
index 8a176d8..b9ff323 100644
--- a/kernel/sysctl.c
+++ b/kernel/sysctl.c
@@ -994,30 +994,32 @@ static int sysrq_sysctl_handler(struct ctl_table *table, int write,
 		.proc_handler   = proc_dointvec,
 	},
 #endif
-#if defined(CONFIG_X86)
+
+#if (defined(CONFIG_X86_32) || defined(CONFIG_PARISC)) && \
+	defined(CONFIG_DEBUG_STACKOVERFLOW)
 	{
-		.procname	= "panic_on_unrecovered_nmi",
-		.data		= &panic_on_unrecovered_nmi,
+		.procname	= "panic_on_stackoverflow",
+		.data		= &sysctl_panic_on_stackoverflow,
 		.maxlen		= sizeof(int),
 		.mode		= 0644,
 		.proc_handler	= proc_dointvec,
 	},
+#endif
+#if defined(CONFIG_X86)
 	{
-		.procname	= "panic_on_io_nmi",
-		.data		= &panic_on_io_nmi,
+		.procname	= "panic_on_unrecovered_nmi",
+		.data		= &panic_on_unrecovered_nmi,
 		.maxlen		= sizeof(int),
 		.mode		= 0644,
 		.proc_handler	= proc_dointvec,
 	},
-#ifdef CONFIG_DEBUG_STACKOVERFLOW
 	{
-		.procname	= "panic_on_stackoverflow",
-		.data		= &sysctl_panic_on_stackoverflow,
+		.procname	= "panic_on_io_nmi",
+		.data		= &panic_on_io_nmi,
 		.maxlen		= sizeof(int),
 		.mode		= 0644,
 		.proc_handler	= proc_dointvec,
 	},
-#endif
 	{
 		.procname	= "bootloader_type",
 		.data		= &bootloader_type,
-- 
1.8.5.6

