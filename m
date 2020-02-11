Return-Path: <SRS0=PxPh=37=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67E66C352A3
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Feb 2020 13:26:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1E4E5206DB
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Feb 2020 13:26:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729208AbgBKN0U (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Feb 2020 08:26:20 -0500
Received: from mga17.intel.com ([192.55.52.151]:9007 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729140AbgBKN0P (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Feb 2020 08:26:15 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga107.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 11 Feb 2020 05:26:13 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,428,1574150400"; 
   d="scan'208";a="226502778"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga007.fm.intel.com with ESMTP; 11 Feb 2020 05:26:09 -0800
Received: by black.fi.intel.com (Postfix, from userid 1001)
        id 3B2514DC; Tue, 11 Feb 2020 15:26:04 +0200 (EET)
From:   Mika Westerberg <mika.westerberg@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Darren Hart <dvhart@infradead.org>,
        Lee Jones <lee.jones@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H . Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        Zha Qipeng <qipeng.zha@intel.com>,
        "David E . Box" <david.e.box@linux.intel.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v5 08/18] platform/x86: intel_pmc_ipc: Start using SCU IPC
Date:   Tue, 11 Feb 2020 16:25:53 +0300
Message-Id: <20200211132603.73509-9-mika.westerberg@linux.intel.com>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200211132603.73509-1-mika.westerberg@linux.intel.com>
References: <20200211132603.73509-1-mika.westerberg@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SCU IPC is pretty much the same IPC implemented in the intel_pmc_ipc
driver so drop the duplicate implementation and call directly the SCU
IPC.

Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/platform/x86/Kconfig         |   1 +
 drivers/platform/x86/intel_pmc_ipc.c | 303 ++++-----------------------
 2 files changed, 40 insertions(+), 264 deletions(-)

diff --git a/drivers/platform/x86/Kconfig b/drivers/platform/x86/Kconfig
index d2835400082b..6e99bd8fd806 100644
--- a/drivers/platform/x86/Kconfig
+++ b/drivers/platform/x86/Kconfig
@@ -1322,6 +1322,7 @@ config INTEL_PMC_CORE
 config INTEL_PMC_IPC
 	tristate "Intel PMC IPC Driver"
 	depends on ACPI && PCI
+	select INTEL_SCU_IPC
 	---help---
 	This driver provides support for PMC control on some Intel platforms.
 	The PMC is an ARC processor which defines IPC commands for communication
diff --git a/drivers/platform/x86/intel_pmc_ipc.c b/drivers/platform/x86/intel_pmc_ipc.c
index 2433bf73f1ed..ea85b854c4c6 100644
--- a/drivers/platform/x86/intel_pmc_ipc.c
+++ b/drivers/platform/x86/intel_pmc_ipc.c
@@ -21,28 +21,10 @@
 #include <linux/platform_device.h>
 
 #include <asm/intel_pmc_ipc.h>
+#include <asm/intel_scu_ipc.h>
 
 #include <linux/platform_data/itco_wdt.h>
 
-/*
- * IPC registers
- * The IA write to IPC_CMD command register triggers an interrupt to the ARC,
- * The ARC handles the interrupt and services it, writing optional data to
- * the IPC1 registers, updates the IPC_STS response register with the status.
- */
-#define IPC_CMD			0x00
-#define		IPC_CMD_MSI		BIT(8)
-#define		IPC_CMD_SIZE		16
-#define		IPC_CMD_SUBCMD		12
-#define IPC_STATUS		0x04
-#define		IPC_STATUS_IRQ		BIT(2)
-#define		IPC_STATUS_ERR		BIT(1)
-#define		IPC_STATUS_BUSY		BIT(0)
-#define IPC_SPTR		0x08
-#define IPC_DPTR		0x0C
-#define IPC_WRITE_BUFFER	0x80
-#define IPC_READ_BUFFER		0x90
-
 /* Residency with clock rate at 19.2MHz to usecs */
 #define S0IX_RESIDENCY_IN_USECS(d, s)		\
 ({						\
@@ -51,16 +33,6 @@
 	result;					\
 })
 
-/*
- * 16-byte buffer for sending data associated with IPC command.
- */
-#define IPC_DATA_BUFFER_SIZE	16
-
-#define IPC_LOOP_CNT		3000000
-#define IPC_MAX_SEC		3
-
-#define IPC_TRIGGER_MODE_IRQ		true
-
 /* exported resources from IFWI */
 #define PLAT_RESOURCE_IPC_INDEX		0
 #define PLAT_RESOURCE_IPC_SIZE		0x1000
@@ -103,11 +75,6 @@
 
 static struct intel_pmc_ipc_dev {
 	struct device *dev;
-	void __iomem *ipc_base;
-	bool irq_mode;
-	int irq;
-	int cmd;
-	struct completion cmd_complete;
 
 	/* The following PMC BARs share the same ACPI device with the IPC */
 	resource_size_t acpi_io_base;
@@ -132,53 +99,6 @@ static struct intel_pmc_ipc_dev {
 	struct platform_device *telemetry_dev;
 } ipcdev;
 
-static char *ipc_err_sources[] = {
-	[IPC_ERR_NONE] =
-		"no error",
-	[IPC_ERR_CMD_NOT_SUPPORTED] =
-		"command not supported",
-	[IPC_ERR_CMD_NOT_SERVICED] =
-		"command not serviced",
-	[IPC_ERR_UNABLE_TO_SERVICE] =
-		"unable to service",
-	[IPC_ERR_CMD_INVALID] =
-		"command invalid",
-	[IPC_ERR_CMD_FAILED] =
-		"command failed",
-	[IPC_ERR_EMSECURITY] =
-		"Invalid Battery",
-	[IPC_ERR_UNSIGNEDKERNEL] =
-		"Unsigned kernel",
-};
-
-/* Prevent concurrent calls to the PMC */
-static DEFINE_MUTEX(ipclock);
-
-static inline void ipc_send_command(u32 cmd)
-{
-	ipcdev.cmd = cmd;
-	if (ipcdev.irq_mode) {
-		reinit_completion(&ipcdev.cmd_complete);
-		cmd |= IPC_CMD_MSI;
-	}
-	writel(cmd, ipcdev.ipc_base + IPC_CMD);
-}
-
-static inline u32 ipc_read_status(void)
-{
-	return readl(ipcdev.ipc_base + IPC_STATUS);
-}
-
-static inline void ipc_data_writel(u32 data, u32 offset)
-{
-	writel(data, ipcdev.ipc_base + IPC_WRITE_BUFFER + offset);
-}
-
-static inline u32 ipc_data_readl(u32 offset)
-{
-	return readl(ipcdev.ipc_base + IPC_READ_BUFFER + offset);
-}
-
 static inline u64 gcr_data_readq(u32 offset)
 {
 	return readq(ipcdev.gcr_mem_base + offset);
@@ -274,127 +194,6 @@ static int update_no_reboot_bit(void *priv, bool set)
 				    PMC_CFG_NO_REBOOT_MASK, value);
 }
 
-static int intel_pmc_ipc_check_status(void)
-{
-	int status;
-	int ret = 0;
-
-	if (ipcdev.irq_mode) {
-		if (0 == wait_for_completion_timeout(
-				&ipcdev.cmd_complete, IPC_MAX_SEC * HZ))
-			ret = -ETIMEDOUT;
-	} else {
-		int loop_count = IPC_LOOP_CNT;
-
-		while ((ipc_read_status() & IPC_STATUS_BUSY) && --loop_count)
-			udelay(1);
-		if (loop_count == 0)
-			ret = -ETIMEDOUT;
-	}
-
-	status = ipc_read_status();
-	if (ret == -ETIMEDOUT) {
-		dev_err(ipcdev.dev,
-			"IPC timed out, TS=0x%x, CMD=0x%x\n",
-			status, ipcdev.cmd);
-		return ret;
-	}
-
-	if (status & IPC_STATUS_ERR) {
-		int i;
-
-		ret = -EIO;
-		i = (status >> IPC_CMD_SIZE) & 0xFF;
-		if (i < ARRAY_SIZE(ipc_err_sources))
-			dev_err(ipcdev.dev,
-				"IPC failed: %s, STS=0x%x, CMD=0x%x\n",
-				ipc_err_sources[i], status, ipcdev.cmd);
-		else
-			dev_err(ipcdev.dev,
-				"IPC failed: unknown, STS=0x%x, CMD=0x%x\n",
-				status, ipcdev.cmd);
-		if ((i == IPC_ERR_UNSIGNEDKERNEL) || (i == IPC_ERR_EMSECURITY))
-			ret = -EACCES;
-	}
-
-	return ret;
-}
-
-/**
- * intel_pmc_ipc_simple_command() - Simple IPC command
- * @cmd:	IPC command code.
- * @sub:	IPC command sub type.
- *
- * Send a simple IPC command to PMC when don't need to specify
- * input/output data and source/dest pointers.
- *
- * Return:	an IPC error code or 0 on success.
- */
-static int intel_pmc_ipc_simple_command(int cmd, int sub)
-{
-	int ret;
-
-	mutex_lock(&ipclock);
-	if (ipcdev.dev == NULL) {
-		mutex_unlock(&ipclock);
-		return -ENODEV;
-	}
-	ipc_send_command(sub << IPC_CMD_SUBCMD | cmd);
-	ret = intel_pmc_ipc_check_status();
-	mutex_unlock(&ipclock);
-
-	return ret;
-}
-
-/**
- * intel_pmc_ipc_raw_cmd() - IPC command with data and pointers
- * @cmd:	IPC command code.
- * @sub:	IPC command sub type.
- * @in:		input data of this IPC command.
- * @inlen:	input data length in bytes.
- * @out:	output data of this IPC command.
- * @outlen:	output data length in dwords.
- * @sptr:	data writing to SPTR register.
- * @dptr:	data writing to DPTR register.
- *
- * Send an IPC command to PMC with input/output data and source/dest pointers.
- *
- * Return:	an IPC error code or 0 on success.
- */
-static int intel_pmc_ipc_raw_cmd(u32 cmd, u32 sub, u8 *in, u32 inlen, u32 *out,
-				 u32 outlen, u32 dptr, u32 sptr)
-{
-	u32 wbuf[4] = { 0 };
-	int ret;
-	int i;
-
-	if (inlen > IPC_DATA_BUFFER_SIZE || outlen > IPC_DATA_BUFFER_SIZE / 4)
-		return -EINVAL;
-
-	mutex_lock(&ipclock);
-	if (ipcdev.dev == NULL) {
-		mutex_unlock(&ipclock);
-		return -ENODEV;
-	}
-	memcpy(wbuf, in, inlen);
-	writel(dptr, ipcdev.ipc_base + IPC_DPTR);
-	writel(sptr, ipcdev.ipc_base + IPC_SPTR);
-	/* The input data register is 32bit register and inlen is in Byte */
-	for (i = 0; i < ((inlen + 3) / 4); i++)
-		ipc_data_writel(wbuf[i], 4 * i);
-	ipc_send_command((inlen << IPC_CMD_SIZE) |
-			(sub << IPC_CMD_SUBCMD) | cmd);
-	ret = intel_pmc_ipc_check_status();
-	if (!ret) {
-		/* out is read from 32bit register and outlen is in 32bit */
-		for (i = 0; i < outlen; i++)
-			*out++ = ipc_data_readl(4 * i);
-	}
-	mutex_unlock(&ipclock);
-
-	return ret;
-}
-
 /**
  * intel_pmc_ipc_command() -  IPC command with input/output data
  * @cmd:	IPC command code.
@@ -411,54 +210,32 @@ static int intel_pmc_ipc_raw_cmd(u32 cmd, u32 sub, u8 *in, u32 inlen, u32 *out,
 int intel_pmc_ipc_command(u32 cmd, u32 sub, u8 *in, u32 inlen,
 			  u32 *out, u32 outlen)
 {
-	return intel_pmc_ipc_raw_cmd(cmd, sub, in, inlen, out, outlen, 0, 0);
+	return intel_scu_ipc_dev_command(NULL, cmd, sub, in, inlen, out, outlen);
 }
 EXPORT_SYMBOL_GPL(intel_pmc_ipc_command);
 
-static irqreturn_t ioc(int irq, void *dev_id)
-{
-	int status;
-
-	if (ipcdev.irq_mode) {
-		status = ipc_read_status();
-		writel(status | IPC_STATUS_IRQ, ipcdev.ipc_base + IPC_STATUS);
-	}
-	complete(&ipcdev.cmd_complete);
-
-	return IRQ_HANDLED;
-}
-
 static int ipc_pci_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 {
 	struct intel_pmc_ipc_dev *pmc = &ipcdev;
+	struct intel_scu_ipc_pdata pdata = {};
+	struct intel_scu_ipc_dev *scu;
 	int ret;
 
 	/* Only one PMC is supported */
 	if (pmc->dev)
 		return -EBUSY;
 
-	pmc->irq_mode = IPC_TRIGGER_MODE_IRQ;
-
 	spin_lock_init(&ipcdev.gcr_lock);
 
 	ret = pcim_enable_device(pdev);
 	if (ret)
 		return ret;
 
-	ret = pcim_iomap_regions(pdev, 1 << 0, pci_name(pdev));
-	if (ret)
-		return ret;
-
-	init_completion(&pmc->cmd_complete);
-
-	pmc->ipc_base = pcim_iomap_table(pdev)[0];
+	pdata.mem = pdev->resource[0];
 
-	ret = devm_request_irq(&pdev->dev, pdev->irq, ioc, 0, "intel_pmc_ipc",
-				pmc);
-	if (ret) {
-		dev_err(&pdev->dev, "Failed to request irq\n");
-		return ret;
-	}
+	scu = devm_intel_scu_ipc_register(&pdev->dev, &pdata);
+	if (IS_ERR(scu))
+		return PTR_ERR(scu);
 
 	pmc->dev = &pdev->dev;
 
@@ -485,6 +262,7 @@ static ssize_t intel_pmc_ipc_simple_cmd_store(struct device *dev,
 					      struct device_attribute *attr,
 					      const char *buf, size_t count)
 {
+	struct intel_scu_ipc_dev *scu = dev_get_drvdata(dev);
 	int subcmd;
 	int cmd;
 	int ret;
@@ -495,7 +273,7 @@ static ssize_t intel_pmc_ipc_simple_cmd_store(struct device *dev,
 		return -EINVAL;
 	}
 
-	ret = intel_pmc_ipc_simple_command(cmd, subcmd);
+	ret = intel_scu_ipc_dev_simple_command(scu, cmd, subcmd);
 	if (ret) {
 		dev_err(dev, "command %d error with %d\n", cmd, ret);
 		return ret;
@@ -508,6 +286,7 @@ static ssize_t intel_pmc_ipc_northpeak_store(struct device *dev,
 					     struct device_attribute *attr,
 					     const char *buf, size_t count)
 {
+	struct intel_scu_ipc_dev *scu = dev_get_drvdata(dev);
 	unsigned long val;
 	int subcmd;
 	int ret;
@@ -520,7 +299,7 @@ static ssize_t intel_pmc_ipc_northpeak_store(struct device *dev,
 		subcmd = 1;
 	else
 		subcmd = 0;
-	ret = intel_pmc_ipc_simple_command(PMC_IPC_NORTHPEAK_CTRL, subcmd);
+	ret = intel_scu_ipc_dev_simple_command(scu, PMC_IPC_NORTHPEAK_CTRL, subcmd);
 	if (ret) {
 		dev_err(dev, "command north %d error with %d\n", subcmd, ret);
 		return ret;
@@ -714,9 +493,11 @@ static int ipc_create_pmc_devices(void)
 	return ret;
 }
 
-static int ipc_plat_get_res(struct platform_device *pdev)
+static int ipc_plat_get_res(struct platform_device *pdev,
+			    struct intel_scu_ipc_pdata *pdata)
 {
 	struct resource *res, *punit_res = punit_res_array;
+	resource_size_t start;
 	void __iomem *addr;
 	int size;
 
@@ -785,23 +566,30 @@ static int ipc_plat_get_res(struct platform_device *pdev)
 		dev_info(&pdev->dev, "punit GTD interface res: %pR\n", res);
 	}
 
+	pdata->irq = platform_get_irq(pdev, 0);
+
 	res = platform_get_resource(pdev, IORESOURCE_MEM,
 				    PLAT_RESOURCE_IPC_INDEX);
 	if (!res) {
 		dev_err(&pdev->dev, "Failed to get ipc resource\n");
 		return -ENXIO;
 	}
-	size = PLAT_RESOURCE_IPC_SIZE + PLAT_RESOURCE_GCR_SIZE;
-	res->end = res->start + size - 1;
+	dev_info(&pdev->dev, "ipc res: %pR\n", res);
 
-	addr = devm_ioremap_resource(&pdev->dev, res);
-	if (IS_ERR(addr))
-		return PTR_ERR(addr);
+	pdata->mem.flags = res->flags;
+	pdata->mem.start = res->start;
+	pdata->mem.end = res->start + PLAT_RESOURCE_IPC_SIZE - 1;
 
-	ipcdev.ipc_base = addr;
+	start = res->start + PLAT_RESOURCE_GCR_OFFSET;
+	if (!devm_request_mem_region(&pdev->dev, start, PLAT_RESOURCE_GCR_SIZE,
+				     "pmc_ipc_plat"))
+		return -EBUSY;
 
-	ipcdev.gcr_mem_base = addr + PLAT_RESOURCE_GCR_OFFSET;
-	dev_info(&pdev->dev, "ipc res: %pR\n", res);
+	addr = devm_ioremap(&pdev->dev, start, PLAT_RESOURCE_GCR_SIZE);
+	if (!addr)
+		return -ENOMEM;
+
+	ipcdev.gcr_mem_base = addr;
 
 	ipcdev.telem_res_inval = 0;
 	res = platform_get_resource(pdev, IORESOURCE_MEM,
@@ -854,51 +642,38 @@ MODULE_DEVICE_TABLE(acpi, ipc_acpi_ids);
 
 static int ipc_plat_probe(struct platform_device *pdev)
 {
+	struct intel_scu_ipc_pdata pdata = {};
+	struct intel_scu_ipc_dev *scu;
 	int ret;
 
 	ipcdev.dev = &pdev->dev;
-	ipcdev.irq_mode = IPC_TRIGGER_MODE_IRQ;
-	init_completion(&ipcdev.cmd_complete);
 	spin_lock_init(&ipcdev.gcr_lock);
 
-	ipcdev.irq = platform_get_irq(pdev, 0);
-	if (ipcdev.irq < 0)
-		return -EINVAL;
-
-	ret = ipc_plat_get_res(pdev);
+	ret = ipc_plat_get_res(pdev, &pdata);
 	if (ret) {
 		dev_err(&pdev->dev, "Failed to request resource\n");
 		return ret;
 	}
 
+	scu = devm_intel_scu_ipc_register(&pdev->dev, &pdata);
+	if (IS_ERR(scu))
+		return PTR_ERR(scu);
+
+	platform_set_drvdata(pdev, scu);
+
 	ret = ipc_create_pmc_devices();
 	if (ret) {
 		dev_err(&pdev->dev, "Failed to create pmc devices\n");
 		return ret;
 	}
 
-	if (devm_request_irq(&pdev->dev, ipcdev.irq, ioc, IRQF_NO_SUSPEND,
-			     "intel_pmc_ipc", &ipcdev)) {
-		dev_err(&pdev->dev, "Failed to request irq\n");
-		ret = -EBUSY;
-		goto err_irq;
-	}
-
 	ipcdev.has_gcr_regs = true;
 
 	return 0;
-
-err_irq:
-	platform_device_unregister(ipcdev.tco_dev);
-	platform_device_unregister(ipcdev.punit_dev);
-	platform_device_unregister(ipcdev.telemetry_dev);
-
-	return ret;
 }
 
 static int ipc_plat_remove(struct platform_device *pdev)
 {
-	devm_free_irq(&pdev->dev, ipcdev.irq, &ipcdev);
 	platform_device_unregister(ipcdev.tco_dev);
 	platform_device_unregister(ipcdev.punit_dev);
 	platform_device_unregister(ipcdev.telemetry_dev);
-- 
2.25.0

