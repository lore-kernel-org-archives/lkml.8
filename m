Return-Path: <SRS0=ro3C=3X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36E52C35247
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Feb 2020 13:31:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 11EB622527
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Feb 2020 13:31:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728167AbgBCNbf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Feb 2020 08:31:35 -0500
Received: from mga09.intel.com ([134.134.136.24]:48918 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728119AbgBCNbe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Feb 2020 08:31:34 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga102.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 03 Feb 2020 05:31:34 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,398,1574150400"; 
   d="scan'208";a="234658483"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga006.jf.intel.com with ESMTP; 03 Feb 2020 05:31:32 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 669CB2AF; Mon,  3 Feb 2020 15:31:31 +0200 (EET)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        linux-kernel@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v5 5/7] console: Avoid positive return code from unregister_console()
Date:   Mon,  3 Feb 2020 15:31:28 +0200
Message-Id: <20200203133130.11591-5-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200203133130.11591-1-andriy.shevchenko@linux.intel.com>
References: <20200203133130.11591-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There are only two callers that use the returned code from
unregister_console():

  - unregister_early_console() in arch/m68k/kernel/early_printk.c
  - kgdb_unregister_nmi_console() in drivers/tty/serial/kgdb_nmi.c

They both expect to get "0" on success and a non-zero value on error.
But the current behavior is confusing and buggy:

  - _braille_unregister_console() returns "1" on success
  - unregister_console() returns "1" on error

Fix and clean up the behavior:

  - Return success when _braille_unregister_console() succeeded
  - Return a meaningful error code when the console was not registered before

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
v5: no change

 kernel/printk/printk.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
index 463ed5c5474e..5fdae891a4cd 100644
--- a/kernel/printk/printk.c
+++ b/kernel/printk/printk.c
@@ -2823,10 +2823,12 @@ int unregister_console(struct console *console)
 		console->name, console->index);
 
 	res = _braille_unregister_console(console);
-	if (res)
+	if (res < 0)
 		return res;
+	if (res > 0)
+		return 0;
 
-	res = 1;
+	res = -ENODEV;
 	console_lock();
 	if (console_drivers == console) {
 		console_drivers=console->next;
-- 
2.24.1

