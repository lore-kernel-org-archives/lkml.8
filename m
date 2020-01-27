Return-Path: <SRS0=1cir=3Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80612C2D0DB
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jan 2020 11:47:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 52AEA206D3
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jan 2020 11:47:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730352AbgA0LrX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Jan 2020 06:47:23 -0500
Received: from mga12.intel.com ([192.55.52.136]:12783 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726210AbgA0LrX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jan 2020 06:47:23 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga106.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 27 Jan 2020 03:47:22 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,369,1574150400"; 
   d="scan'208";a="221709913"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga008.jf.intel.com with ESMTP; 27 Jan 2020 03:47:20 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id DF8B1286; Mon, 27 Jan 2020 13:47:19 +0200 (EET)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        linux-kernel@vger.kernel.org
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v3 3/5] console: Use for_each_console() helper in unregister_console()
Date:   Mon, 27 Jan 2020 13:47:17 +0200
Message-Id: <20200127114719.69114-3-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200127114719.69114-1-andriy.shevchenko@linux.intel.com>
References: <20200127114719.69114-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We have rather open coded single linked list manipulations where we may
simple use for_each_console() helper with properly set exit conditions.

Replace open coded single-linked list handling with for_each_console()
helper in use.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
v3: no changes
 kernel/printk/printk.c | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
index 51337ed426e0..d40a316908da 100644
--- a/kernel/printk/printk.c
+++ b/kernel/printk/printk.c
@@ -2809,7 +2809,7 @@ EXPORT_SYMBOL(register_console);
 
 int unregister_console(struct console *console)
 {
-        struct console *a, *b;
+	struct console *con;
 	int res;
 
 	pr_info("%sconsole [%s%d] disabled\n",
@@ -2825,11 +2825,10 @@ int unregister_console(struct console *console)
 	if (console_drivers == console) {
 		console_drivers=console->next;
 		res = 0;
-	} else if (console_drivers) {
-		for (a=console_drivers->next, b=console_drivers ;
-		     a; b=a, a=b->next) {
-			if (a == console) {
-				b->next = a->next;
+	} else {
+		for_each_console(con) {
+			if (con->next == console) {
+				con->next = console->next;
 				res = 0;
 				break;
 			}
-- 
2.24.1

