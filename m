Return-Path: <SRS0=z1XV=3D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91041C33C9E
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jan 2020 17:09:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6723A2465A
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jan 2020 17:09:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728757AbgANRJU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Jan 2020 12:09:20 -0500
Received: from mga12.intel.com ([192.55.52.136]:1169 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726053AbgANRJU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jan 2020 12:09:20 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga106.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 14 Jan 2020 09:09:19 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,433,1574150400"; 
   d="scan'208";a="305207400"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga001.jf.intel.com with ESMTP; 14 Jan 2020 09:09:18 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 720B71AD; Tue, 14 Jan 2020 19:09:17 +0200 (EET)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>, linux-kernel@vger.kernel.org
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v1] tty: baudrate: Synchronise baud_table[] and baud_bits[]
Date:   Tue, 14 Jan 2020 19:09:17 +0200
Message-Id: <20200114170917.36947-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.24.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Synchronize baud rate tables for better readability.
No functional change intended.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/tty/tty_baudrate.c | 24 +++++++++---------------
 1 file changed, 9 insertions(+), 15 deletions(-)

diff --git a/drivers/tty/tty_baudrate.c b/drivers/tty/tty_baudrate.c
index f438eaa68246..eb6b07f079c8 100644
--- a/drivers/tty/tty_baudrate.c
+++ b/drivers/tty/tty_baudrate.c
@@ -17,8 +17,8 @@
  * include/asm/termbits.h file.
  */
 static const speed_t baud_table[] = {
-	0, 50, 75, 110, 134, 150, 200, 300, 600, 1200, 1800, 2400, 4800,
-	9600, 19200, 38400, 57600, 115200, 230400, 460800,
+	0, 50, 75, 110, 134, 150, 200, 300, 600, 1200, 1800, 2400,
+	4800, 9600, 19200, 38400, 57600, 115200, 230400, 460800,
 #ifdef __sparc__
 	76800, 153600, 307200, 614400, 921600
 #else
@@ -27,22 +27,16 @@ static const speed_t baud_table[] = {
 #endif
 };
 
-#ifndef __sparc__
 static const tcflag_t baud_bits[] = {
-	B0, B50, B75, B110, B134, B150, B200, B300, B600,
-	B1200, B1800, B2400, B4800, B9600, B19200, B38400,
-	B57600, B115200, B230400, B460800, B500000, B576000,
-	B921600, B1000000, B1152000, B1500000, B2000000, B2500000,
-	B3000000, B3500000, B4000000
-};
+	B0, B50, B75, B110, B134, B150, B200, B300, B600, B1200, B1800, B2400,
+	B4800, B9600, B19200, B38400, B57600, B115200, B230400, B460800,
+#ifdef __sparc__
+	B76800, B153600, B307200, B614400, B921600
 #else
-static const tcflag_t baud_bits[] = {
-	B0, B50, B75, B110, B134, B150, B200, B300, B600,
-	B1200, B1800, B2400, B4800, B9600, B19200, B38400,
-	B57600, B115200, B230400, B460800, B76800, B153600,
-	B307200, B614400, B921600
-};
+	B500000, B576000, B921600, B1000000, B1152000, B1500000, B2000000,
+	B2500000, B3000000, B3500000, B4000000
 #endif
+};
 
 static int n_baud_table = ARRAY_SIZE(baud_table);
 
-- 
2.24.1

