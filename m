Return-Path: <SRS0=1cir=3Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60D7CC2D0DB
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jan 2020 11:47:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3B13A2087F
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jan 2020 11:47:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730389AbgA0Lr2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Jan 2020 06:47:28 -0500
Received: from mga05.intel.com ([192.55.52.43]:10062 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729951AbgA0LrX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jan 2020 06:47:23 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 27 Jan 2020 03:47:22 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,369,1574150400"; 
   d="scan'208";a="228936666"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga003.jf.intel.com with ESMTP; 27 Jan 2020 03:47:20 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id C2BE316D; Mon, 27 Jan 2020 13:47:19 +0200 (EET)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        linux-kernel@vger.kernel.org
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v3 1/5] console: Don't perform test for CON_BRL flag
Date:   Mon, 27 Jan 2020 13:47:15 +0200
Message-Id: <20200127114719.69114-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.24.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We don't call braille_register_console() without CON_BRL flag set.
And the _braille_unregister_console() already tests for console to have
CON_BRL flag. No need to repeat this in braille_unregister_console().

Drop the repetitive checks from Braille console driver.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
v3: drop checks in Braille console driver (Sergey)
 drivers/accessibility/braille/braille_console.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/drivers/accessibility/braille/braille_console.c b/drivers/accessibility/braille/braille_console.c
index 1339c586bf64..a8f7c278b691 100644
--- a/drivers/accessibility/braille/braille_console.c
+++ b/drivers/accessibility/braille/braille_console.c
@@ -347,8 +347,6 @@ int braille_register_console(struct console *console, int index,
 {
 	int ret;
 
-	if (!(console->flags & CON_BRL))
-		return 0;
 	if (!console_options)
 		/* Only support VisioBraille for now */
 		console_options = "57600o8";
@@ -371,8 +369,6 @@ int braille_unregister_console(struct console *console)
 {
 	if (braille_co != console)
 		return -EINVAL;
-	if (!(console->flags & CON_BRL))
-		return 0;
 	unregister_keyboard_notifier(&keyboard_notifier_block);
 	unregister_vt_notifier(&vt_notifier_block);
 	braille_co = NULL;
-- 
2.24.1

