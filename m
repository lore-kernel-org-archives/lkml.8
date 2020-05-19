Return-Path: <SRS0=IaiW=7B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA354C433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 19 May 2020 03:31:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 952472075F
	for <linux-kernel@archiver.kernel.org>; Tue, 19 May 2020 03:31:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728237AbgESDbV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 May 2020 23:31:21 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:4859 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726302AbgESDbV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 May 2020 23:31:21 -0400
Received: from DGGEMS403-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id CA27B95C87A6593A342B;
        Tue, 19 May 2020 11:31:19 +0800 (CST)
Received: from use12-sp2.huawei.com (10.67.189.174) by
 DGGEMS403-HUB.china.huawei.com (10.3.19.203) with Microsoft SMTP Server id
 14.3.487.0; Tue, 19 May 2020 11:31:13 +0800
From:   Xiaoming Ni <nixiaoming@huawei.com>
To:     <mcgrof@kernel.org>, <keescook@chromium.org>, <yzaikin@google.com>,
        <adobriyan@gmail.com>, <mingo@kernel.org>, <nixiaoming@huawei.com>,
        <gpiccoli@canonical.com>, <rdna@fb.com>, <patrick.bellasi@arm.com>,
        <sfr@canb.auug.org.au>, <akpm@linux-foundation.org>,
        <mhocko@suse.com>, <penguin-kernel@i-love.sakura.ne.jp>,
        <vbabka@suse.cz>, <tglx@linutronix.de>, <peterz@infradead.org>,
        <Jisheng.Zhang@synaptics.com>, <khlebnikov@yandex-team.ru>,
        <bigeasy@linutronix.de>, <pmladek@suse.com>,
        <linux-kernel@vger.kernel.org>, <linux-fsdevel@vger.kernel.org>
CC:     <wangle6@huawei.com>, <alex.huangjianhui@huawei.com>
Subject: [PATCH v4 1/4] sysctl: Add register_sysctl_init() interface
Date:   Tue, 19 May 2020 11:31:08 +0800
Message-ID: <1589859071-25898-2-git-send-email-nixiaoming@huawei.com>
X-Mailer: git-send-email 1.8.5.6
In-Reply-To: <1589859071-25898-1-git-send-email-nixiaoming@huawei.com>
References: <1589859071-25898-1-git-send-email-nixiaoming@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.189.174]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In order to eliminate the duplicate code for registering the sysctl
interface during the initialization of each feature, add the
register_sysctl_init() interface

Signed-off-by: Xiaoming Ni <nixiaoming@huawei.com>
Reviewed-by: Kees Cook <keescook@chromium.org>
---
 include/linux/sysctl.h |  2 ++
 kernel/sysctl.c        | 19 +++++++++++++++++++
 2 files changed, 21 insertions(+)

diff --git a/include/linux/sysctl.h b/include/linux/sysctl.h
index 50bb7f3..857ba93 100644
--- a/include/linux/sysctl.h
+++ b/include/linux/sysctl.h
@@ -197,6 +197,8 @@ struct ctl_table_header *register_sysctl_paths(const struct ctl_path *path,
 void unregister_sysctl_table(struct ctl_table_header * table);
 
 extern int sysctl_init(void);
+extern void register_sysctl_init(const char *path, struct ctl_table *table,
+				 const char *table_name);
 void do_sysctl_args(void);
 
 extern int pwrsw_enabled;
diff --git a/kernel/sysctl.c b/kernel/sysctl.c
index cc1fcba..8afd713 100644
--- a/kernel/sysctl.c
+++ b/kernel/sysctl.c
@@ -3358,6 +3358,25 @@ int __init sysctl_init(void)
 	kmemleak_not_leak(hdr);
 	return 0;
 }
+
+/*
+ * The sysctl interface is used to modify the interface value,
+ * but the feature interface has default values. Even if register_sysctl fails,
+ * the feature body function can also run. At the same time, malloc small
+ * fragment of memory during the system initialization phase, almost does
+ * not fail. Therefore, the function return is designed as void
+ */
+void __init register_sysctl_init(const char *path, struct ctl_table *table,
+				 const char *table_name)
+{
+	struct ctl_table_header *hdr = register_sysctl(path, table);
+
+	if (unlikely(!hdr)) {
+		pr_err("failed when register_sysctl %s to %s\n", table_name, path);
+		return;
+	}
+	kmemleak_not_leak(hdr);
+}
 #endif /* CONFIG_SYSCTL */
 /*
  * No sense putting this after each symbol definition, twice,
-- 
1.8.5.6

