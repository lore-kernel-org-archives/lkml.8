Return-Path: <SRS0=wIUh=66=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE274C433DF
	for <linux-kernel@archiver.kernel.org>; Sat, 16 May 2020 08:55:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A04172065C
	for <linux-kernel@archiver.kernel.org>; Sat, 16 May 2020 08:55:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726999AbgEPIzg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 16 May 2020 04:55:36 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:50420 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726899AbgEPIze (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 May 2020 04:55:34 -0400
Received: from DGGEMS404-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 702BF66F73B25B48AE89;
        Sat, 16 May 2020 16:55:25 +0800 (CST)
Received: from use12-sp2.huawei.com (10.67.189.174) by
 DGGEMS404-HUB.china.huawei.com (10.3.19.204) with Microsoft SMTP Server id
 14.3.487.0; Sat, 16 May 2020 16:55:18 +0800
From:   Xiaoming Ni <nixiaoming@huawei.com>
To:     <mcgrof@kernel.org>, <keescook@chromium.org>, <yzaikin@google.com>,
        <adobriyan@gmail.com>, <peterz@infradead.org>, <mingo@kernel.org>,
        <patrick.bellasi@arm.com>, <gregkh@linuxfoundation.org>,
        <tglx@linutronix.de>, <Jisheng.Zhang@synaptics.com>,
        <bigeasy@linutronix.de>, <pmladek@suse.com>,
        <ebiederm@xmission.com>
CC:     <linux-kernel@vger.kernel.org>, <linux-fsdevel@vger.kernel.org>,
        <nixiaoming@huawei.com>, <wangle6@huawei.com>
Subject: [PATCH v2 1/4] sysctl: Add register_sysctl_init() interface
Date:   Sat, 16 May 2020 16:55:12 +0800
Message-ID: <1589619315-65827-2-git-send-email-nixiaoming@huawei.com>
X-Mailer: git-send-email 1.8.5.6
In-Reply-To: <1589619315-65827-1-git-send-email-nixiaoming@huawei.com>
References: <1589619315-65827-1-git-send-email-nixiaoming@huawei.com>
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
---
 include/linux/sysctl.h |  2 ++
 kernel/sysctl.c        | 19 +++++++++++++++++++
 2 files changed, 21 insertions(+)

diff --git a/include/linux/sysctl.h b/include/linux/sysctl.h
index 02fa844..43f8ef9 100644
--- a/include/linux/sysctl.h
+++ b/include/linux/sysctl.h
@@ -206,6 +206,8 @@ struct ctl_table_header *register_sysctl_paths(const struct ctl_path *path,
 void unregister_sysctl_table(struct ctl_table_header * table);
 
 extern int sysctl_init(void);
+extern void register_sysctl_init(const char *path, struct ctl_table *table,
+				 const char *table_name);
 
 extern struct ctl_table sysctl_mount_point[];
 
diff --git a/kernel/sysctl.c b/kernel/sysctl.c
index b9ff323..20c31f5 100644
--- a/kernel/sysctl.c
+++ b/kernel/sysctl.c
@@ -1970,6 +1970,25 @@ int __init sysctl_init(void)
 	return 0;
 }
 
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
+
 #endif /* CONFIG_SYSCTL */
 
 /*
-- 
1.8.5.6

