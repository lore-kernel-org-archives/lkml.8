Return-Path: <SRS0=dgGg=75=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C4CBC433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jun 2020 16:31:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EC5A220882
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jun 2020 16:31:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730583AbgFPQbp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Jun 2020 12:31:45 -0400
Received: from mga17.intel.com ([192.55.52.151]:46101 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729167AbgFPQbp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Jun 2020 12:31:45 -0400
IronPort-SDR: 48O7QsjXl56BYrM3RJ8Krrj7ryY3zy5VC/XGOhxMpCHmAmVIMiV03hR9hORd1VuUhOKSfARE0A
 GVTfelL2IUeA==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jun 2020 09:31:45 -0700
IronPort-SDR: 719ePnbyZDjL5iP2Vd92+ADc2o9Uu/Gxwqp73SoLkL83IO4eSH5Sirq/2MQwqsfEhgA5O8fBk0
 WlzUlKA5KFDQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,518,1583222400"; 
   d="scan'208";a="263061031"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga008.fm.intel.com with ESMTP; 16 Jun 2020 09:31:41 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id C65EC217; Tue, 16 Jun 2020 19:31:39 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     linux-kernel@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Stefan Wahren <wahrenst@gmx.net>,
        Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        Petr Mladek <pmladek@suse.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
Subject: [PATCH v1] ARM: bcm2835: Fix integer overflow in rpi_firmware_print_firmware_revision()
Date:   Tue, 16 Jun 2020 19:31:39 +0300
Message-Id: <20200616163139.4229-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.27.0.rc2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

time64_t is 64-bit width type, we are not supposed to supply lesser ones
as in the case of rpi_firmware_print_firmware_revision() after the commit
4a60f58ee002 ("ARM: bcm2835: Switch to use %ptT"). Use temporary variable
of time64_t type to correctly handle lesser types.

Fixes: 4a60f58ee002 ("ARM: bcm2835: Switch to use %ptT")
Reported-by: Stefan Wahren <wahrenst@gmx.net>
Reported-by: Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Petr Mladek <pmladek@suse.com>
Cc: Steven Rostedt <rostedt@goodmis.org>
Cc: Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
---
 drivers/firmware/raspberrypi.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/firmware/raspberrypi.c b/drivers/firmware/raspberrypi.c
index ef8098856a47..625c8fdceabf 100644
--- a/drivers/firmware/raspberrypi.c
+++ b/drivers/firmware/raspberrypi.c
@@ -181,6 +181,7 @@ EXPORT_SYMBOL_GPL(rpi_firmware_property);
 static void
 rpi_firmware_print_firmware_revision(struct rpi_firmware *fw)
 {
+	time64_t date_and_time;
 	u32 packet;
 	int ret = rpi_firmware_property(fw,
 					RPI_FIRMWARE_GET_FIRMWARE_REVISION,
@@ -189,7 +190,9 @@ rpi_firmware_print_firmware_revision(struct rpi_firmware *fw)
 	if (ret)
 		return;
 
-	dev_info(fw->cl.dev, "Attached to firmware from %ptT\n", &packet);
+	/* This is not compatible with y2038 */
+	date_and_time = packet;
+	dev_info(fw->cl.dev, "Attached to firmware from %ptT\n", &date_and_time);
 }
 
 static void
-- 
2.27.0.rc2

