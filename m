Return-Path: <SRS0=7RkH=3E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B954EC33CB2
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jan 2020 22:41:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 937C02081E
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jan 2020 22:41:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730763AbgAOWl3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Jan 2020 17:41:29 -0500
Received: from mga11.intel.com ([192.55.52.93]:38389 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729449AbgAOWl2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jan 2020 17:41:28 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 15 Jan 2020 14:41:28 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,323,1574150400"; 
   d="scan'208";a="243060977"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga002.jf.intel.com with ESMTP; 15 Jan 2020 14:41:26 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id ED9B1BD; Thu, 16 Jan 2020 00:41:25 +0200 (EET)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>, linux-kernel@vger.kernel.org
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v2 2/2] tty: baudrate: SPARC supports few more baud rates
Date:   Thu, 16 Jan 2020 00:41:24 +0200
Message-Id: <20200115224124.74684-2-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200115224124.74684-1-andriy.shevchenko@linux.intel.com>
References: <20200115224124.74684-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

According to termbits.h SPARC supports few more baud rates
than currently defined in tty_baudrate.c.

Append supported ones to baud_table[] and baud_bits[].

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/tty/tty_baudrate.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/tty/tty_baudrate.c b/drivers/tty/tty_baudrate.c
index eb6b07f079c8..40207cab3b2a 100644
--- a/drivers/tty/tty_baudrate.c
+++ b/drivers/tty/tty_baudrate.c
@@ -20,7 +20,8 @@ static const speed_t baud_table[] = {
 	0, 50, 75, 110, 134, 150, 200, 300, 600, 1200, 1800, 2400,
 	4800, 9600, 19200, 38400, 57600, 115200, 230400, 460800,
 #ifdef __sparc__
-	76800, 153600, 307200, 614400, 921600
+	76800, 153600, 307200, 614400, 921600, 500000, 576000,
+	1000000, 1152000, 1500000, 2000000
 #else
 	500000, 576000, 921600, 1000000, 1152000, 1500000, 2000000,
 	2500000, 3000000, 3500000, 4000000
@@ -31,7 +32,8 @@ static const tcflag_t baud_bits[] = {
 	B0, B50, B75, B110, B134, B150, B200, B300, B600, B1200, B1800, B2400,
 	B4800, B9600, B19200, B38400, B57600, B115200, B230400, B460800,
 #ifdef __sparc__
-	B76800, B153600, B307200, B614400, B921600
+	B76800, B153600, B307200, B614400, B921600, B500000, B576000,
+	B1000000, B1152000, B1500000, B2000000
 #else
 	B500000, B576000, B921600, B1000000, B1152000, B1500000, B2000000,
 	B2500000, B3000000, B3500000, B4000000
-- 
2.24.1

