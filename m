Return-Path: <SRS0=9JlO=3L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76980C2D0DB
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jan 2020 16:28:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4FB6D24125
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jan 2020 16:28:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729151AbgAVQ2x (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Jan 2020 11:28:53 -0500
Received: from mga04.intel.com ([192.55.52.120]:35968 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726871AbgAVQ2T (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jan 2020 11:28:19 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga104.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 22 Jan 2020 08:28:18 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,350,1574150400"; 
   d="scan'208";a="229400195"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga006.jf.intel.com with ESMTP; 22 Jan 2020 08:28:15 -0800
Received: by black.fi.intel.com (Postfix, from userid 1001)
        id 3E50C5C; Wed, 22 Jan 2020 18:28:14 +0200 (EET)
From:   Mika Westerberg <mika.westerberg@linux.intel.com>
To:     Andy Shevchenko <andy@infradead.org>,
        Darren Hart <dvhart@infradead.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H . Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 01/10] platform/x86: intel_scu_ipc: Fix interrupt support
Date:   Wed, 22 Jan 2020 19:28:04 +0300
Message-Id: <20200122162813.26070-2-mika.westerberg@linux.intel.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200122162813.26070-1-mika.westerberg@linux.intel.com>
References: <20200122162813.26070-1-mika.westerberg@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently the driver has disabled interrupt support for Tangier but
actually interrupt works just fine if the command is not written twice
in a row. Also we need to ack the interrupt in the handler.

Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: stable@vger.kernel.org
---
 drivers/platform/x86/intel_scu_ipc.c | 21 ++++++++-------------
 1 file changed, 8 insertions(+), 13 deletions(-)

diff --git a/drivers/platform/x86/intel_scu_ipc.c b/drivers/platform/x86/intel_scu_ipc.c
index cdab916fbf92..e330ec73c465 100644
--- a/drivers/platform/x86/intel_scu_ipc.c
+++ b/drivers/platform/x86/intel_scu_ipc.c
@@ -67,26 +67,22 @@
 struct intel_scu_ipc_pdata_t {
 	u32 i2c_base;
 	u32 i2c_len;
-	u8 irq_mode;
 };
 
 static const struct intel_scu_ipc_pdata_t intel_scu_ipc_lincroft_pdata = {
 	.i2c_base = 0xff12b000,
 	.i2c_len = 0x10,
-	.irq_mode = 0,
 };
 
 /* Penwell and Cloverview */
 static const struct intel_scu_ipc_pdata_t intel_scu_ipc_penwell_pdata = {
 	.i2c_base = 0xff12b000,
 	.i2c_len = 0x10,
-	.irq_mode = 1,
 };
 
 static const struct intel_scu_ipc_pdata_t intel_scu_ipc_tangier_pdata = {
 	.i2c_base  = 0xff00d000,
 	.i2c_len = 0x10,
-	.irq_mode = 0,
 };
 
 struct intel_scu_ipc_dev {
@@ -99,6 +95,9 @@ struct intel_scu_ipc_dev {
 
 static struct intel_scu_ipc_dev  ipcdev; /* Only one for now */
 
+#define IPC_STATUS		0x04
+#define IPC_STATUS_IRQ		BIT(2)
+
 /*
  * IPC Read Buffer (Read Only):
  * 16 byte buffer for receiving data from SCU, if IPC command
@@ -120,11 +119,8 @@ static DEFINE_MUTEX(ipclock); /* lock used to prevent multiple call to SCU */
  */
 static inline void ipc_command(struct intel_scu_ipc_dev *scu, u32 cmd)
 {
-	if (scu->irq_mode) {
-		reinit_completion(&scu->cmd_complete);
-		writel(cmd | IPC_IOC, scu->ipc_base);
-	}
-	writel(cmd, scu->ipc_base);
+	reinit_completion(&scu->cmd_complete);
+	writel(cmd | IPC_IOC, scu->ipc_base);
 }
 
 /*
@@ -610,9 +606,10 @@ EXPORT_SYMBOL(intel_scu_ipc_i2c_cntrl);
 static irqreturn_t ioc(int irq, void *dev_id)
 {
 	struct intel_scu_ipc_dev *scu = dev_id;
+	int status = ipc_read_status(scu);
 
-	if (scu->irq_mode)
-		complete(&scu->cmd_complete);
+	writel(status | IPC_STATUS_IRQ, scu->ipc_base + IPC_STATUS);
+	complete(&scu->cmd_complete);
 
 	return IRQ_HANDLED;
 }
@@ -638,8 +635,6 @@ static int ipc_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 	if (!pdata)
 		return -ENODEV;
 
-	scu->irq_mode = pdata->irq_mode;
-
 	err = pcim_enable_device(pdev);
 	if (err)
 		return err;
-- 
2.24.1

