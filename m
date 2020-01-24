Return-Path: <SRS0=1j9/=3N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C62FC2D0DB
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jan 2020 15:57:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EDA0C2071E
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jan 2020 15:57:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729924AbgAXP5h (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Jan 2020 10:57:37 -0500
Received: from mga14.intel.com ([192.55.52.115]:10966 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727285AbgAXP5h (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jan 2020 10:57:37 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 24 Jan 2020 07:57:36 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,358,1574150400"; 
   d="scan'208";a="245740888"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga002.jf.intel.com with ESMTP; 24 Jan 2020 07:57:34 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 9362E107; Fri, 24 Jan 2020 17:57:33 +0200 (EET)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        linux-kernel@vger.kernel.org
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v2 2/5] console: Drop double check for console_drivers being non-NULL
Date:   Fri, 24 Jan 2020 17:57:29 +0200
Message-Id: <20200124155733.54799-2-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200124155733.54799-1-andriy.shevchenko@linux.intel.com>
References: <20200124155733.54799-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is no need to explicitly check for console_drivers to be non-NULL
since for_each_console() does this.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
v2: mark it as a console patch in the Subject line
 kernel/printk/printk.c | 16 ++++++----------
 1 file changed, 6 insertions(+), 10 deletions(-)

diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
index fada22dc4ab6..51337ed426e0 100644
--- a/kernel/printk/printk.c
+++ b/kernel/printk/printk.c
@@ -1772,9 +1772,6 @@ static void call_console_drivers(const char *ext_text, size_t ext_len,
 
 	trace_console_rcuidle(text, len);
 
-	if (!console_drivers)
-		return;
-
 	for_each_console(con) {
 		if (exclusive_console && con != exclusive_console)
 			continue;
@@ -2653,18 +2650,17 @@ void register_console(struct console *newcon)
 	struct console_cmdline *c;
 	static bool has_preferred;
 
-	if (console_drivers)
-		for_each_console(bcon)
-			if (WARN(bcon == newcon,
-					"console '%s%d' already registered\n",
-					bcon->name, bcon->index))
-				return;
+	for_each_console(bcon) {
+		if (WARN(bcon == newcon, "console '%s%d' already registered\n",
+					 bcon->name, bcon->index))
+			return;
+	}
 
 	/*
 	 * before we register a new CON_BOOT console, make sure we don't
 	 * already have a valid console
 	 */
-	if (console_drivers && newcon->flags & CON_BOOT) {
+	if (newcon->flags & CON_BOOT) {
 		/* find the last or real console */
 		for_each_console(bcon) {
 			if (!(bcon->flags & CON_BOOT)) {
-- 
2.24.1

