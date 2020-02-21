Return-Path: <SRS0=1210=4J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63AE8C35640
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Feb 2020 08:57:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 42F7C2067D
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Feb 2020 08:57:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387777AbgBUI53 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Feb 2020 03:57:29 -0500
Received: from mga12.intel.com ([192.55.52.136]:24941 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728063AbgBUI52 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Feb 2020 03:57:28 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga106.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 21 Feb 2020 00:57:27 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,467,1574150400"; 
   d="scan'208";a="409077690"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga005.jf.intel.com with ESMTP; 21 Feb 2020 00:57:25 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 222F194; Fri, 21 Feb 2020 10:57:23 +0200 (EET)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Petr Mladek <pmladek@suse.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        linux-kernel@vger.kernel.org,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
Subject: [PATCH v1] lib/vsprintf: update comment about simple_strto<foo>() functions
Date:   Fri, 21 Feb 2020 10:57:23 +0200
Message-Id: <20200221085723.42469-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.25.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The commit 885e68e8b7b1 ("kernel.h: update comment about simple_strto<foo>()
functions") updated a comment regard to simple_strto<foo>() functions, but
missed similar change in the vsprintf.c module.

Update comments in vsprintf.c as well for simple_strto<foo>() functions.

Reported-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 lib/vsprintf.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/lib/vsprintf.c b/lib/vsprintf.c
index 7c488a1ce318..d5641a217685 100644
--- a/lib/vsprintf.c
+++ b/lib/vsprintf.c
@@ -58,7 +58,7 @@
  * @endp: A pointer to the end of the parsed string will be placed here
  * @base: The number base to use
  *
- * This function is obsolete. Please use kstrtoull instead.
+ * This function has caveats. Please use kstrtoull instead.
  */
 unsigned long long simple_strtoull(const char *cp, char **endp, unsigned int base)
 {
@@ -83,7 +83,7 @@ EXPORT_SYMBOL(simple_strtoull);
  * @endp: A pointer to the end of the parsed string will be placed here
  * @base: The number base to use
  *
- * This function is obsolete. Please use kstrtoul instead.
+ * This function has caveats. Please use kstrtoul instead.
  */
 unsigned long simple_strtoul(const char *cp, char **endp, unsigned int base)
 {
@@ -97,7 +97,7 @@ EXPORT_SYMBOL(simple_strtoul);
  * @endp: A pointer to the end of the parsed string will be placed here
  * @base: The number base to use
  *
- * This function is obsolete. Please use kstrtol instead.
+ * This function has caveats. Please use kstrtol instead.
  */
 long simple_strtol(const char *cp, char **endp, unsigned int base)
 {
@@ -114,7 +114,7 @@ EXPORT_SYMBOL(simple_strtol);
  * @endp: A pointer to the end of the parsed string will be placed here
  * @base: The number base to use
  *
- * This function is obsolete. Please use kstrtoll instead.
+ * This function has caveats. Please use kstrtoll instead.
  */
 long long simple_strtoll(const char *cp, char **endp, unsigned int base)
 {
-- 
2.25.0

