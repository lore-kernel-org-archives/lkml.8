Return-Path: <SRS0=9JlO=3L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DAC96C2D0DB
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jan 2020 16:28:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 96CD824686
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jan 2020 16:28:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728139AbgAVQ2U (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Jan 2020 11:28:20 -0500
Received: from mga09.intel.com ([134.134.136.24]:58620 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725827AbgAVQ2S (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jan 2020 11:28:18 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga102.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 22 Jan 2020 08:28:17 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,350,1574150400"; 
   d="scan'208";a="215956678"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga007.jf.intel.com with ESMTP; 22 Jan 2020 08:28:15 -0800
Received: by black.fi.intel.com (Postfix, from userid 1001)
        id 615C42CB; Wed, 22 Jan 2020 18:28:14 +0200 (EET)
From:   Mika Westerberg <mika.westerberg@linux.intel.com>
To:     Andy Shevchenko <andy@infradead.org>,
        Darren Hart <dvhart@infradead.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H . Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 04/10] platform/x86: intel_scu_ipc: Drop intel_scu_ipc_i2c_cntrl()
Date:   Wed, 22 Jan 2020 19:28:07 +0300
Message-Id: <20200122162813.26070-5-mika.westerberg@linux.intel.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200122162813.26070-1-mika.westerberg@linux.intel.com>
References: <20200122162813.26070-1-mika.westerberg@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There are no existing users for this functionality so drop it from the
driver completely. This also means we don't need to keep the struct
intel_scu_ipc_pdata_t around anymore so remove that as well.

Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 arch/x86/include/asm/intel_scu_ipc.h |  3 -
 drivers/platform/x86/intel_scu_ipc.c | 90 +---------------------------
 2 files changed, 3 insertions(+), 90 deletions(-)

diff --git a/arch/x86/include/asm/intel_scu_ipc.h b/arch/x86/include/asm/intel_scu_ipc.h
index 4a8c6e817398..d7bbebf4b729 100644
--- a/arch/x86/include/asm/intel_scu_ipc.h
+++ b/arch/x86/include/asm/intel_scu_ipc.h
@@ -53,9 +53,6 @@ int intel_scu_ipc_command(int cmd, int sub, u32 *in, int inlen,
 int intel_scu_ipc_raw_command(int cmd, int sub, u8 *in, int inlen,
 			      u32 *out, int outlen, u32 dptr, u32 sptr);
 
-/* I2C control api */
-int intel_scu_ipc_i2c_cntrl(u32 addr, u32 *data);
-
 /* Update FW version */
 int intel_scu_ipc_fw_update(u8 *buffer, u32 length);
 
diff --git a/drivers/platform/x86/intel_scu_ipc.c b/drivers/platform/x86/intel_scu_ipc.c
index 3cf8954a9f3e..fa87bf91e5e4 100644
--- a/drivers/platform/x86/intel_scu_ipc.c
+++ b/drivers/platform/x86/intel_scu_ipc.c
@@ -58,31 +58,9 @@
 #define IPC_RWBUF_SIZE    20		/* IPC Read buffer Size */
 #define IPC_IOC	          0x100		/* IPC command register IOC bit */
 
-#define PCI_DEVICE_ID_PENWELL		0x080e
-#define PCI_DEVICE_ID_CLOVERVIEW	0x08ea
-#define PCI_DEVICE_ID_TANGIER		0x11a0
-
-/* intel scu ipc driver data */
-struct intel_scu_ipc_pdata_t {
-	u32 i2c_base;
-	u32 i2c_len;
-};
-
-/* Penwell and Cloverview */
-static const struct intel_scu_ipc_pdata_t intel_scu_ipc_penwell_pdata = {
-	.i2c_base = 0xff12b000,
-	.i2c_len = 0x10,
-};
-
-static const struct intel_scu_ipc_pdata_t intel_scu_ipc_tangier_pdata = {
-	.i2c_base  = 0xff00d000,
-	.i2c_len = 0x10,
-};
-
 struct intel_scu_ipc_dev {
 	struct device *dev;
 	void __iomem *ipc_base;
-	void __iomem *i2c_base;
 	struct completion cmd_complete;
 	u8 irq_mode;
 };
@@ -101,9 +79,6 @@ static struct intel_scu_ipc_dev  ipcdev; /* Only one for now */
 #define IPC_WRITE_BUFFER	0x80
 #define IPC_READ_BUFFER		0x90
 
-#define IPC_I2C_CNTRL_ADDR	0
-#define I2C_DATA_ADDR		0x04
-
 static DEFINE_MUTEX(ipclock); /* lock used to prevent multiple call to SCU */
 
 /*
@@ -544,54 +519,6 @@ int intel_scu_ipc_raw_command(int cmd, int sub, u8 *in, int inlen,
 }
 EXPORT_SYMBOL_GPL(intel_scu_ipc_raw_command);
 
-/* I2C commands */
-#define IPC_I2C_WRITE 1 /* I2C Write command */
-#define IPC_I2C_READ  2 /* I2C Read command */
-
-/**
- *	intel_scu_ipc_i2c_cntrl		-	I2C read/write operations
- *	@addr: I2C address + command bits
- *	@data: data to read/write
- *
- *	Perform an an I2C read/write operation via the SCU. All locking is
- *	handled for the caller. This function may sleep.
- *
- *	Returns an error code or 0 on success.
- *
- *	This has to be in the IPC driver for the locking.
- */
-int intel_scu_ipc_i2c_cntrl(u32 addr, u32 *data)
-{
-	struct intel_scu_ipc_dev *scu = &ipcdev;
-	u32 cmd = 0;
-
-	mutex_lock(&ipclock);
-	if (scu->dev == NULL) {
-		mutex_unlock(&ipclock);
-		return -ENODEV;
-	}
-	cmd = (addr >> 24) & 0xFF;
-	if (cmd == IPC_I2C_READ) {
-		writel(addr, scu->i2c_base + IPC_I2C_CNTRL_ADDR);
-		/* Write not getting updated without delay */
-		usleep_range(1000, 2000);
-		*data = readl(scu->i2c_base + I2C_DATA_ADDR);
-	} else if (cmd == IPC_I2C_WRITE) {
-		writel(*data, scu->i2c_base + I2C_DATA_ADDR);
-		usleep_range(1000, 2000);
-		writel(addr, scu->i2c_base + IPC_I2C_CNTRL_ADDR);
-	} else {
-		dev_err(scu->dev,
-			"intel_scu_ipc: I2C INVALID_CMD = 0x%x\n", cmd);
-
-		mutex_unlock(&ipclock);
-		return -EIO;
-	}
-	mutex_unlock(&ipclock);
-	return 0;
-}
-EXPORT_SYMBOL(intel_scu_ipc_i2c_cntrl);
-
 /*
  * Interrupt handler gets called when ioc bit of IPC_COMMAND_REG set to 1
  * When ioc bit is set to 1, caller api must wait for interrupt handler called
@@ -622,15 +549,10 @@ static int ipc_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 {
 	int err;
 	struct intel_scu_ipc_dev *scu = &ipcdev;
-	struct intel_scu_ipc_pdata_t *pdata;
 
 	if (scu->dev)		/* We support only one SCU */
 		return -EBUSY;
 
-	pdata = (struct intel_scu_ipc_pdata_t *)id->driver_data;
-	if (!pdata)
-		return -ENODEV;
-
 	err = pcim_enable_device(pdev);
 	if (err)
 		return err;
@@ -643,10 +565,6 @@ static int ipc_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 
 	scu->ipc_base = pcim_iomap_table(pdev)[0];
 
-	scu->i2c_base = ioremap_nocache(pdata->i2c_base, pdata->i2c_len);
-	if (!scu->i2c_base)
-		return -ENOMEM;
-
 	err = devm_request_irq(&pdev->dev, pdev->irq, ioc, 0, "intel_scu_ipc",
 			       scu);
 	if (err)
@@ -661,12 +579,10 @@ static int ipc_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 	return 0;
 }
 
-#define SCU_DEVICE(id, pdata)	{PCI_VDEVICE(INTEL, id), (kernel_ulong_t)&pdata}
-
 static const struct pci_device_id pci_ids[] = {
-	SCU_DEVICE(PCI_DEVICE_ID_PENWELL,	intel_scu_ipc_penwell_pdata),
-	SCU_DEVICE(PCI_DEVICE_ID_CLOVERVIEW,	intel_scu_ipc_penwell_pdata),
-	SCU_DEVICE(PCI_DEVICE_ID_TANGIER,	intel_scu_ipc_tangier_pdata),
+	{ PCI_VDEVICE(INTEL, 0x080e) },
+	{ PCI_VDEVICE(INTEL, 0x08ea) },
+	{ PCI_VDEVICE(INTEL, 0x11a0) },
 	{}
 };
 
-- 
2.24.1

