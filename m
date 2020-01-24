Return-Path: <SRS0=1j9/=3N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32D06C2D0DB
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jan 2020 15:57:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0F7492071E
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jan 2020 15:57:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730103AbgAXP5i (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Jan 2020 10:57:38 -0500
Received: from mga17.intel.com ([192.55.52.151]:53173 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729045AbgAXP5h (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jan 2020 10:57:37 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga107.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 24 Jan 2020 07:57:36 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,358,1574150400"; 
   d="scan'208";a="375542485"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga004.jf.intel.com with ESMTP; 24 Jan 2020 07:57:34 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id A2335357; Fri, 24 Jan 2020 17:57:33 +0200 (EET)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        linux-kernel@vger.kernel.org
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v2 3/5] console: Use for_each_console() helper in unregister_console()
Date:   Fri, 24 Jan 2020 17:57:30 +0200
Message-Id: <20200124155733.54799-3-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200124155733.54799-1-andriy.shevchenko@linux.intel.com>
References: <20200124155733.54799-1-andriy.shevchenko@linux.intel.com>
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
v2: new patch
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

