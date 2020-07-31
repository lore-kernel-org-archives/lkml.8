Return-Path: <SRS0=S/iQ=BK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0C2EC433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Jul 2020 18:08:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7E4932177B
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Jul 2020 18:08:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387709AbgGaSI3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 Jul 2020 14:08:29 -0400
Received: from mga14.intel.com ([192.55.52.115]:31216 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730040AbgGaSI3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Jul 2020 14:08:29 -0400
IronPort-SDR: CzKf95QFQG2oRDkWEDrkJJXjNA2UMnWkvo8Dvq17WpF61nlXb96qP6ydj3xWYOqvDTeJ+BAhan
 O8VD+M+9sWDw==
X-IronPort-AV: E=McAfee;i="6000,8403,9698"; a="151048004"
X-IronPort-AV: E=Sophos;i="5.75,419,1589266800"; 
   d="scan'208";a="151048004"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Jul 2020 11:08:28 -0700
IronPort-SDR: Xla5EuKiNSVBnpCZQHOOD9RCXdefukV/S5ThOsac7bpxVOQ6YN+u8xN4ehBlKkv6/s2Yjjj2pE
 9whxFIdVpcdA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,419,1589266800"; 
   d="scan'208";a="491079847"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga006.fm.intel.com with ESMTP; 31 Jul 2020 11:08:26 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 142F6119; Fri, 31 Jul 2020 21:08:25 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        linux-kernel@vger.kernel.org,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Steven Rostedt <rostedt@goodmis.org>
Subject: [PATCH v2 1/3] lib/vsprintf: Replace hidden BUILD_BUG_ON() with static_assert()
Date:   Fri, 31 Jul 2020 21:08:22 +0300
Message-Id: <20200731180825.30575-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

First of all, there is no compile time check for the SMALL
to be ' ' (0x20, i.e. space). Second, for ZEROPAD the check
is hidden in the code.

For better maintenance replace BUILD_BUG_ON() with static_assert()
for ZEROPAD and move it closer to the definition. While at it,
introduce check for SMALL.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Reviewed-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
---
v2: replaced to have plain defined constant on left side, added tag (Steven)
 lib/vsprintf.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/lib/vsprintf.c b/lib/vsprintf.c
index 31a674dd2674..f90f09682977 100644
--- a/lib/vsprintf.c
+++ b/lib/vsprintf.c
@@ -381,6 +381,9 @@ int num_to_str(char *buf, int size, unsigned long long num, unsigned int width)
 #define SMALL	32		/* use lowercase in hex (must be 32 == 0x20) */
 #define SPECIAL	64		/* prefix hex with "0x", octal with "0" */
 
+static_assert(ZEROPAD == ('0' - ' '));
+static_assert(SMALL == ' ');
+
 enum format_type {
 	FORMAT_TYPE_NONE, /* Just a string part */
 	FORMAT_TYPE_WIDTH,
@@ -507,7 +510,7 @@ char *number(char *buf, char *end, unsigned long long num,
 	/* zero or space padding */
 	if (!(spec.flags & LEFT)) {
 		char c = ' ' + (spec.flags & ZEROPAD);
-		BUILD_BUG_ON(' ' + ZEROPAD != '0');
+
 		while (--field_width >= 0) {
 			if (buf < end)
 				*buf = c;
-- 
2.27.0

