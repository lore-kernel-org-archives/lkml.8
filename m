Return-Path: <SRS0=ro3C=3X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93678C33CAC
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Feb 2020 13:31:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6732C2086A
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Feb 2020 13:31:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728153AbgBCNbe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Feb 2020 08:31:34 -0500
Received: from mga07.intel.com ([134.134.136.100]:16678 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727823AbgBCNbe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Feb 2020 08:31:34 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga105.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 03 Feb 2020 05:31:33 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,398,1574150400"; 
   d="scan'208";a="248825888"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga002.jf.intel.com with ESMTP; 03 Feb 2020 05:31:32 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 4943517C; Mon,  3 Feb 2020 15:31:31 +0200 (EET)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        linux-kernel@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v5 3/7] console: Use for_each_console() helper in unregister_console()
Date:   Mon,  3 Feb 2020 15:31:26 +0200
Message-Id: <20200203133130.11591-3-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200203133130.11591-1-andriy.shevchenko@linux.intel.com>
References: <20200203133130.11591-1-andriy.shevchenko@linux.intel.com>
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
Reviewed-by: Petr Mladek <pmladek@suse.com>
---
v5: no change

 kernel/printk/printk.c | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
index 21b1a5d5e5b0..c63338df76cf 100644
--- a/kernel/printk/printk.c
+++ b/kernel/printk/printk.c
@@ -2816,7 +2816,7 @@ EXPORT_SYMBOL(register_console);
 
 int unregister_console(struct console *console)
 {
-        struct console *a, *b;
+	struct console *con;
 	int res;
 
 	pr_info("%sconsole [%s%d] disabled\n",
@@ -2832,11 +2832,10 @@ int unregister_console(struct console *console)
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

