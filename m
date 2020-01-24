Return-Path: <SRS0=1j9/=3N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E34DC2D0DB
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jan 2020 15:57:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 290CD2071E
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jan 2020 15:57:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730707AbgAXP5q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Jan 2020 10:57:46 -0500
Received: from mga17.intel.com ([192.55.52.151]:53173 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729225AbgAXP5h (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jan 2020 10:57:37 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga107.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 24 Jan 2020 07:57:37 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,358,1574150400"; 
   d="scan'208";a="375542487"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga004.jf.intel.com with ESMTP; 24 Jan 2020 07:57:34 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 8A7CC115; Fri, 24 Jan 2020 17:57:33 +0200 (EET)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        linux-kernel@vger.kernel.org
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v2 1/5] console: Don't perform test for CON_BRL flag twice
Date:   Fri, 24 Jan 2020 17:57:28 +0200
Message-Id: <20200124155733.54799-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.24.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The braille_unregister_console() already tests for console to have
CON_BRL flag. No need to repeat this in _braille_unregister_console().

However, we need to check for that flag at the beginning of the function
to avoid any regressions in the callers.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
v2: new patch
 drivers/accessibility/braille/braille_console.c | 4 ++--
 kernel/printk/braille.c                         | 5 +----
 2 files changed, 3 insertions(+), 6 deletions(-)

diff --git a/drivers/accessibility/braille/braille_console.c b/drivers/accessibility/braille/braille_console.c
index 1339c586bf64..f0ffccfb6bb7 100644
--- a/drivers/accessibility/braille/braille_console.c
+++ b/drivers/accessibility/braille/braille_console.c
@@ -369,10 +369,10 @@ int braille_register_console(struct console *console, int index,
 
 int braille_unregister_console(struct console *console)
 {
-	if (braille_co != console)
-		return -EINVAL;
 	if (!(console->flags & CON_BRL))
 		return 0;
+	if (braille_co != console)
+		return -EINVAL;
 	unregister_keyboard_notifier(&keyboard_notifier_block);
 	unregister_vt_notifier(&vt_notifier_block);
 	braille_co = NULL;
diff --git a/kernel/printk/braille.c b/kernel/printk/braille.c
index 17a9591e54ff..2ec42173890f 100644
--- a/kernel/printk/braille.c
+++ b/kernel/printk/braille.c
@@ -51,8 +51,5 @@ _braille_register_console(struct console *console, struct console_cmdline *c)
 int
 _braille_unregister_console(struct console *console)
 {
-	if (console->flags & CON_BRL)
-		return braille_unregister_console(console);
-
-	return 0;
+	return braille_unregister_console(console);
 }
-- 
2.24.1

