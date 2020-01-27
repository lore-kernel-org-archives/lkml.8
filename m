Return-Path: <SRS0=1cir=3Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87F53C2D0DB
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jan 2020 11:47:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 63D2C206D3
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jan 2020 11:47:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730421AbgA0Lrd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Jan 2020 06:47:33 -0500
Received: from mga05.intel.com ([192.55.52.43]:10062 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726210AbgA0LrY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jan 2020 06:47:24 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 27 Jan 2020 03:47:22 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,369,1574150400"; 
   d="scan'208";a="228936667"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga003.jf.intel.com with ESMTP; 27 Jan 2020 03:47:20 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id E7526446; Mon, 27 Jan 2020 13:47:19 +0200 (EET)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        linux-kernel@vger.kernel.org
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v3 4/5] console: Avoid positive return code from unregister_console()
Date:   Mon, 27 Jan 2020 13:47:18 +0200
Message-Id: <20200127114719.69114-4-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200127114719.69114-1-andriy.shevchenko@linux.intel.com>
References: <20200127114719.69114-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There are two callers which use the returned code from unregister_console().
In some cases, i.e. successfully unregistered Braille console or when console
has not been enabled the return code is 1. This code is ambiguous and also
prevents callers to distinguish successful operation.

Replace this logic to return only negative error codes or 0 when console,
either enabled, disabled or Braille has been successfully unregistered.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
v3: no changes
 kernel/printk/printk.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
index d40a316908da..da6a9bdf76b6 100644
--- a/kernel/printk/printk.c
+++ b/kernel/printk/printk.c
@@ -2817,10 +2817,12 @@ int unregister_console(struct console *console)
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
@@ -2838,6 +2840,9 @@ int unregister_console(struct console *console)
 	if (!res && (console->flags & CON_EXTENDED))
 		nr_ext_console_drivers--;
 
+	if (res && !(console->flags & CON_ENABLED))
+		res = 0;
+
 	/*
 	 * If this isn't the last console and it has CON_CONSDEV set, we
 	 * need to set it on the next preferred console.
-- 
2.24.1

