Return-Path: <SRS0=eifh=6G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 613E1C55189
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Apr 2020 12:52:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4ABD320857
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Apr 2020 12:52:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726906AbgDVMwI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Apr 2020 08:52:08 -0400
Received: from mga12.intel.com ([192.55.52.136]:14544 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726412AbgDVMwG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Apr 2020 08:52:06 -0400
IronPort-SDR: 9YlBCYxkpF9ftwY8IHmcv1EDHL8aH5BQphmZTAQ+e33PeCtbXp+0WAkYR1OJseVb3k81n2CGFY
 j1Qx2MNJAf5w==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Apr 2020 05:52:06 -0700
IronPort-SDR: Uz68v+E4aoAJ2wMqjQEJVpfs3IdxKjfSHUogmmO9U1/DfebSQ90Vdv9Y2wh1f3dLMRbcTd4Uca
 Inbv5I/Iptkw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,414,1580803200"; 
   d="scan'208";a="245966335"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga007.fm.intel.com with ESMTP; 22 Apr 2020 05:52:04 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 8DA3A6D8; Wed, 22 Apr 2020 15:52:03 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Joe Perches <joe@perches.com>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v4 3/7] kernel.h: Move oops_in_progress to printk.h
Date:   Wed, 22 Apr 2020 15:51:57 +0300
Message-Id: <20200422125201.37618-3-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.26.1
In-Reply-To: <20200422125201.37618-1-andriy.shevchenko@linux.intel.com>
References: <20200422125201.37618-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The oops_in_progress is defined in printk.c, so it's logical
to move oops_in_progress to printk.h.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
v4: new patch
 include/linux/debug_locks.h | 2 +-
 include/linux/kernel.h      | 1 -
 include/linux/printk.h      | 2 ++
 3 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/include/linux/debug_locks.h b/include/linux/debug_locks.h
index 257ab3c92cb8a..e5ffbc25475a0 100644
--- a/include/linux/debug_locks.h
+++ b/include/linux/debug_locks.h
@@ -2,9 +2,9 @@
 #ifndef __LINUX_DEBUG_LOCKING_H
 #define __LINUX_DEBUG_LOCKING_H
 
-#include <linux/kernel.h>
 #include <linux/atomic.h>
 #include <linux/bug.h>
+#include <linux/printk.h>
 
 struct task_struct;
 
diff --git a/include/linux/kernel.h b/include/linux/kernel.h
index 04a5885cec1b4..899302e2b7554 100644
--- a/include/linux/kernel.h
+++ b/include/linux/kernel.h
@@ -527,7 +527,6 @@ extern unsigned int sysctl_oops_all_cpu_backtrace;
 #endif /* CONFIG_SMP */
 
 extern void bust_spinlocks(int yes);
-extern int oops_in_progress;		/* If set, an oops, panic(), BUG() or die() is in progress */
 extern int panic_timeout;
 extern unsigned long panic_print;
 extern int panic_on_oops;
diff --git a/include/linux/printk.h b/include/linux/printk.h
index 768ac6bc637df..c59fdf688d36c 100644
--- a/include/linux/printk.h
+++ b/include/linux/printk.h
@@ -11,6 +11,8 @@
 extern const char linux_banner[];
 extern const char linux_proc_banner[];
 
+extern int oops_in_progress;	/* If set, an oops, panic(), BUG() or die() is in progress */
+
 #define PRINTK_MAX_SINGLE_HEADER_LEN 2
 
 static inline int printk_get_level(const char *buffer)
-- 
2.26.1

