Return-Path: <SRS0=4zup=3T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8ED8DC2D0DB
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Jan 2020 15:26:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 664AD20707
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Jan 2020 15:26:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727263AbgA3P0C (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Jan 2020 10:26:02 -0500
Received: from mga09.intel.com ([134.134.136.24]:4226 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727158AbgA3P0C (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Jan 2020 10:26:02 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga102.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 30 Jan 2020 07:26:01 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,382,1574150400"; 
   d="scan'208";a="247417855"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga002.jf.intel.com with ESMTP; 30 Jan 2020 07:26:00 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 6F7291EA; Thu, 30 Jan 2020 17:25:59 +0200 (EET)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        linux-kernel@vger.kernel.org
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v4 5/6] console: Introduce ->exit() callback
Date:   Thu, 30 Jan 2020 17:25:57 +0200
Message-Id: <20200130152558.51839-5-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200130152558.51839-1-andriy.shevchenko@linux.intel.com>
References: <20200130152558.51839-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some consoles might require special operations on unregistering.
For instance, serial console, when registered in the kernel,
keeps power on for entire time, until it gets unregistered.
Example of use:

	->setup(console):
		pm_runtime_get(...);

	->exit(console):
		pm_runtime_put(...);

For such cases to have a balance we would provide ->exit() callback.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
v4: Don't rely on CON_ENABLED at all (Sergey, Petr), update commit message (Petr)
 include/linux/console.h | 1 +
 kernel/printk/printk.c  | 4 ++++
 2 files changed, 5 insertions(+)

diff --git a/include/linux/console.h b/include/linux/console.h
index f33016b3a401..54759ad0c36b 100644
--- a/include/linux/console.h
+++ b/include/linux/console.h
@@ -148,6 +148,7 @@ struct console {
 	struct tty_driver *(*device)(struct console *, int *);
 	void	(*unblank)(void);
 	int	(*setup)(struct console *, char *);
+	void	(*exit)(struct console *);
 	int	(*match)(struct console *, char *name, int idx, char *options);
 	short	flags;
 	short	index;
diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
index 932345e6cd71..0117d4d92a8e 100644
--- a/kernel/printk/printk.c
+++ b/kernel/printk/printk.c
@@ -2850,6 +2850,10 @@ int unregister_console(struct console *console)
 	console->flags &= ~CON_ENABLED;
 	console_unlock();
 	console_sysfs_notify();
+
+	if (!res && console->exit)
+		console->exit(console);
+
 	return res;
 }
 EXPORT_SYMBOL(unregister_console);
-- 
2.24.1

