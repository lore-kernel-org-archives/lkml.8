Return-Path: <SRS0=ro3C=3X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76665C33CAC
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Feb 2020 13:15:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4DB7520658
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Feb 2020 13:15:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728198AbgBCNPc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Feb 2020 08:15:32 -0500
Received: from mga07.intel.com ([134.134.136.100]:15733 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727899AbgBCNPc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Feb 2020 08:15:32 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga105.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 03 Feb 2020 05:15:31 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,397,1574150400"; 
   d="scan'208";a="337145773"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga001.fm.intel.com with ESMTP; 03 Feb 2020 05:15:30 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 22E1514E; Mon,  3 Feb 2020 15:15:28 +0200 (EET)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        linux-kernel@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v1] printk: Declare log_wait as external variable
Date:   Mon,  3 Feb 2020 15:15:28 +0200
Message-Id: <20200203131528.52825-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.24.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Static analyzer is not happy:

kernel/printk/printk.c:421:1: warning: symbol 'log_wait' was not declared. Should it be static?

This is due to usage of log_wait in the other module without announcing
its declaration to the world. I wasn't able to dug into deep history of
reasons why it is so, and thus decide to make less invasive change, i.e.
declaring log_wait as external variable to make static analyzer happy.

Note the above is done if and only if the CONFIG_PROC_FS is enabled,
otherwise we fallback to static variable.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 kernel/printk/printk.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
index 633f41a11d75..43b5cb88c607 100644
--- a/kernel/printk/printk.c
+++ b/kernel/printk/printk.c
@@ -418,7 +418,14 @@ DEFINE_RAW_SPINLOCK(logbuf_lock);
 	} while (0)
 
 #ifdef CONFIG_PRINTK
+
+#ifdef CONFIG_PROC_FS
+extern wait_queue_head_t log_wait;	/* Used in fs/proc/kmsg.c */
 DECLARE_WAIT_QUEUE_HEAD(log_wait);
+#else
+static DECLARE_WAIT_QUEUE_HEAD(log_wait);
+#endif /* CONFIG_PROC_FS */
+
 /* the next printk record to read by syslog(READ) or /proc/kmsg */
 static u64 syslog_seq;
 static u32 syslog_idx;
-- 
2.24.1

