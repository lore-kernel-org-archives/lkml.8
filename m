Return-Path: <SRS0=9JlO=3L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC136C33CAF
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jan 2020 16:28:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B9A7F2467C
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jan 2020 16:28:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728827AbgAVQ2W (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Jan 2020 11:28:22 -0500
Received: from mga04.intel.com ([192.55.52.120]:35968 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725802AbgAVQ2S (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jan 2020 11:28:18 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga104.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 22 Jan 2020 08:28:18 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,350,1574150400"; 
   d="scan'208";a="229400196"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga006.jf.intel.com with ESMTP; 22 Jan 2020 08:28:15 -0800
Received: by black.fi.intel.com (Postfix, from userid 1001)
        id 4CAEA29B; Wed, 22 Jan 2020 18:28:14 +0200 (EET)
From:   Mika Westerberg <mika.westerberg@linux.intel.com>
To:     Andy Shevchenko <andy@infradead.org>,
        Darren Hart <dvhart@infradead.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H . Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 02/10] platform/x86: intel_scu_ipc: Add constants for register offsets
Date:   Wed, 22 Jan 2020 19:28:05 +0300
Message-Id: <20200122162813.26070-3-mika.westerberg@linux.intel.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200122162813.26070-1-mika.westerberg@linux.intel.com>
References: <20200122162813.26070-1-mika.westerberg@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This makes the code more readable. These are taken from intel_pmc_ipc.c
which implements the same thing.

Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/platform/x86/intel_scu_ipc.c | 20 +++++++++++---------
 1 file changed, 11 insertions(+), 9 deletions(-)

diff --git a/drivers/platform/x86/intel_scu_ipc.c b/drivers/platform/x86/intel_scu_ipc.c
index e330ec73c465..a9b6decbb367 100644
--- a/drivers/platform/x86/intel_scu_ipc.c
+++ b/drivers/platform/x86/intel_scu_ipc.c
@@ -97,12 +97,14 @@ static struct intel_scu_ipc_dev  ipcdev; /* Only one for now */
 
 #define IPC_STATUS		0x04
 #define IPC_STATUS_IRQ		BIT(2)
+#define IPC_STATUS_ERR		BIT(1)
+#define IPC_STATUS_BUSY		BIT(0)
 
 /*
- * IPC Read Buffer (Read Only):
- * 16 byte buffer for receiving data from SCU, if IPC command
- * processing results in response data
+ * IPC Write/Read Buffers:
+ * 16 byte buffer for sending and receiving data to and from SCU.
  */
+#define IPC_WRITE_BUFFER	0x80
 #define IPC_READ_BUFFER		0x90
 
 #define IPC_I2C_CNTRL_ADDR	0
@@ -131,7 +133,7 @@ static inline void ipc_command(struct intel_scu_ipc_dev *scu, u32 cmd)
  */
 static inline void ipc_data_writel(struct intel_scu_ipc_dev *scu, u32 data, u32 offset)
 {
-	writel(data, scu->ipc_base + 0x80 + offset);
+	writel(data, scu->ipc_base + IPC_WRITE_BUFFER + offset);
 }
 
 /*
@@ -143,7 +145,7 @@ static inline void ipc_data_writel(struct intel_scu_ipc_dev *scu, u32 data, u32
  */
 static inline u8 ipc_read_status(struct intel_scu_ipc_dev *scu)
 {
-	return __raw_readl(scu->ipc_base + 0x04);
+	return __raw_readl(scu->ipc_base + IPC_STATUS);
 }
 
 /* Read ipc byte data */
@@ -165,17 +167,17 @@ static inline int busy_loop(struct intel_scu_ipc_dev *scu)
 	u32 loop_count = 100000;
 
 	/* break if scu doesn't reset busy bit after huge retry */
-	while ((status & BIT(0)) && --loop_count) {
+	while ((status & IPC_STATUS_BUSY) && --loop_count) {
 		udelay(1); /* scu processing time is in few u secods */
 		status = ipc_read_status(scu);
 	}
 
-	if (status & BIT(0)) {
+	if (status & IPC_STATUS_BUSY) {
 		dev_err(scu->dev, "IPC timed out");
 		return -ETIMEDOUT;
 	}
 
-	if (status & BIT(1))
+	if (status & IPC_STATUS_ERR)
 		return -EIO;
 
 	return 0;
@@ -192,7 +194,7 @@ static inline int ipc_wait_for_interrupt(struct intel_scu_ipc_dev *scu)
 	}
 
 	status = ipc_read_status(scu);
-	if (status & BIT(1))
+	if (status & IPC_STATUS_ERR)
 		return -EIO;
 
 	return 0;
-- 
2.24.1

