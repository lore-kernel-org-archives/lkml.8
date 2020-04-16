Return-Path: <SRS0=1dCa=6A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3AF9C2BB85
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Apr 2020 08:17:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 955B0206F9
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Apr 2020 08:17:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2440713AbgDPIRr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Apr 2020 04:17:47 -0400
Received: from mga06.intel.com ([134.134.136.31]:51574 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2441179AbgDPIRE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Apr 2020 04:17:04 -0400
IronPort-SDR: No3TLKHaUmbmwbmy+o1lEI7pY1NxweoDcmwXx3qjVZuW6De4/CJqfGBb3rockHnWJEfaLs18y+
 gPBDQeYCmHmw==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Apr 2020 01:16:06 -0700
IronPort-SDR: m/qVYwrBOyYQaeGsb49Y6XWSAZXFBbMIMq3REDpIL1pnNjL+PKHYfy/jWa8yB6SUqReRxsmOb0
 gSIH/IPXWnVg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,390,1580803200"; 
   d="scan'208";a="363914411"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga001.fm.intel.com with ESMTP; 16 Apr 2020 01:16:02 -0700
Received: by black.fi.intel.com (Postfix, from userid 1001)
        id D7BD8F6B; Thu, 16 Apr 2020 11:15:53 +0300 (EEST)
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
Subject: [PATCH v9 17/20] platform/x86: intel_pmc_ipc: Move PCI IDs to intel_scu_pcidrv.c
Date:   Thu, 16 Apr 2020 11:15:49 +0300
Message-Id: <20200416081552.68083-18-mika.westerberg@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200416081552.68083-1-mika.westerberg@linux.intel.com>
References: <20200416081552.68083-1-mika.westerberg@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The PCI probe driver in intel_pmc_ipc.c is a duplicate of what we
already have in intel_scu_pcidrv.c with the exception that the later also
creates SCU specific devices. Move the PCI IDs from the intel_pmc_ipc.c
to intel_scu.c and use driver_data to detect whether SCU devices need to
be created or not.

Also update Kconfig entry to mention all platforms supported by the
Intel SCU PCI driver and change dependency from X86_INTEL_MID to PCI
which is more generic.

Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/platform/x86/Kconfig            | 13 ++++--
 drivers/platform/x86/intel_pmc_ipc.c    | 61 +------------------------
 drivers/platform/x86/intel_scu_pcidrv.c | 21 +++++++--
 3 files changed, 27 insertions(+), 68 deletions(-)

diff --git a/drivers/platform/x86/Kconfig b/drivers/platform/x86/Kconfig
index cd0a6c125710..303514af2e0d 100644
--- a/drivers/platform/x86/Kconfig
+++ b/drivers/platform/x86/Kconfig
@@ -1329,7 +1329,7 @@ config INTEL_PMC_CORE
 
 config INTEL_PMC_IPC
 	tristate "Intel PMC IPC Driver"
-	depends on ACPI && PCI
+	depends on ACPI
 	select INTEL_SCU_IPC
 	---help---
 	This driver provides support for PMC control on some Intel platforms.
@@ -1351,13 +1351,18 @@ config INTEL_SCU
 
 config INTEL_SCU_PCI
 	bool "Intel SCU PCI driver"
-	depends on X86_INTEL_MID
+	depends on PCI
 	select INTEL_SCU
 	help
 	  This driver is used to bridge the communications between kernel
 	  and SCU on some embedded Intel x86 platforms. It also creates
-	  devices that are connected to the SoC through the SCU. This is
-	  not needed for PC-type machines.
+	  devices that are connected to the SoC through the SCU.
+	  Platforms supported:
+	    Medfield
+	    Clovertrail
+	    Merrifield
+	    Broxton
+	    Apollo Lake
 
 config INTEL_SCU_IPC_UTIL
 	tristate "Intel SCU IPC utility driver"
diff --git a/drivers/platform/x86/intel_pmc_ipc.c b/drivers/platform/x86/intel_pmc_ipc.c
index e4110df24490..16ca4ee9cdd5 100644
--- a/drivers/platform/x86/intel_pmc_ipc.c
+++ b/drivers/platform/x86/intel_pmc_ipc.c
@@ -17,7 +17,6 @@
 #include <linux/interrupt.h>
 #include <linux/io-64-nonatomic-lo-hi.h>
 #include <linux/module.h>
-#include <linux/pci.h>
 #include <linux/platform_device.h>
 
 #include <asm/intel_pmc_ipc.h>
@@ -194,50 +193,6 @@ static int update_no_reboot_bit(void *priv, bool set)
 				    PMC_CFG_NO_REBOOT_MASK, value);
 }
 
-static int ipc_pci_probe(struct pci_dev *pdev, const struct pci_device_id *id)
-{
-	struct intel_pmc_ipc_dev *pmc = &ipcdev;
-	struct intel_scu_ipc_data scu_data = {};
-	struct intel_scu_ipc_dev *scu;
-	int ret;
-
-	/* Only one PMC is supported */
-	if (pmc->dev)
-		return -EBUSY;
-
-	spin_lock_init(&ipcdev.gcr_lock);
-
-	ret = pcim_enable_device(pdev);
-	if (ret)
-		return ret;
-
-	scu_data.mem = pdev->resource[0];
-
-	scu = devm_intel_scu_ipc_register(&pdev->dev, &scu_data);
-	if (IS_ERR(scu))
-		return PTR_ERR(scu);
-
-	pmc->dev = &pdev->dev;
-
-	pci_set_drvdata(pdev, pmc);
-
-	return 0;
-}
-
-static const struct pci_device_id ipc_pci_ids[] = {
-	{PCI_VDEVICE(INTEL, 0x0a94), 0},
-	{PCI_VDEVICE(INTEL, 0x1a94), 0},
-	{PCI_VDEVICE(INTEL, 0x5a94), 0},
-	{ 0,}
-};
-MODULE_DEVICE_TABLE(pci, ipc_pci_ids);
-
-static struct pci_driver ipc_pci_driver = {
-	.name = "intel_pmc_ipc",
-	.id_table = ipc_pci_ids,
-	.probe = ipc_pci_probe,
-};
-
 static ssize_t intel_pmc_ipc_simple_cmd_store(struct device *dev,
 					      struct device_attribute *attr,
 					      const char *buf, size_t count)
@@ -673,25 +628,11 @@ static struct platform_driver ipc_plat_driver = {
 
 static int __init intel_pmc_ipc_init(void)
 {
-	int ret;
-
-	ret = platform_driver_register(&ipc_plat_driver);
-	if (ret) {
-		pr_err("Failed to register PMC ipc platform driver\n");
-		return ret;
-	}
-	ret = pci_register_driver(&ipc_pci_driver);
-	if (ret) {
-		pr_err("Failed to register PMC ipc pci driver\n");
-		platform_driver_unregister(&ipc_plat_driver);
-		return ret;
-	}
-	return ret;
+	return platform_driver_register(&ipc_plat_driver);
 }
 
 static void __exit intel_pmc_ipc_exit(void)
 {
-	pci_unregister_driver(&ipc_pci_driver);
 	platform_driver_unregister(&ipc_plat_driver);
 }
 
diff --git a/drivers/platform/x86/intel_scu_pcidrv.c b/drivers/platform/x86/intel_scu_pcidrv.c
index b869ec2eda0e..8c5fd8240da9 100644
--- a/drivers/platform/x86/intel_scu_pcidrv.c
+++ b/drivers/platform/x86/intel_scu_pcidrv.c
@@ -17,6 +17,7 @@
 static int intel_scu_pci_probe(struct pci_dev *pdev,
 			       const struct pci_device_id *id)
 {
+	void (*setup_fn)(void) = (void (*)(void))id->driver_data;
 	struct intel_scu_ipc_data scu_data = {};
 	struct intel_scu_ipc_dev *scu;
 	int ret;
@@ -32,14 +33,26 @@ static int intel_scu_pci_probe(struct pci_dev *pdev,
 	if (IS_ERR(scu))
 		return PTR_ERR(scu);
 
-	intel_scu_devices_create();
+	if (setup_fn)
+		setup_fn();
 	return 0;
 }
 
+static void intel_mid_scu_setup(void)
+{
+	intel_scu_devices_create();
+}
+
 static const struct pci_device_id pci_ids[] = {
-	{ PCI_VDEVICE(INTEL, 0x080e) },
-	{ PCI_VDEVICE(INTEL, 0x08ea) },
-	{ PCI_VDEVICE(INTEL, 0x11a0) },
+	{ PCI_VDEVICE(INTEL, 0x080e),
+	  .driver_data = (kernel_ulong_t)intel_mid_scu_setup },
+	{ PCI_VDEVICE(INTEL, 0x08ea),
+	  .driver_data = (kernel_ulong_t)intel_mid_scu_setup },
+	{ PCI_VDEVICE(INTEL, 0x0a94) },
+	{ PCI_VDEVICE(INTEL, 0x11a0),
+	  .driver_data = (kernel_ulong_t)intel_mid_scu_setup },
+	{ PCI_VDEVICE(INTEL, 0x1a94) },
+	{ PCI_VDEVICE(INTEL, 0x5a94) },
 	{}
 };
 
-- 
2.25.1

