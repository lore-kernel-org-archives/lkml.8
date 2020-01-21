Return-Path: <SRS0=3tRb=3K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 533CAC2D0CE
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jan 2020 16:02:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3064A24654
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jan 2020 16:02:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729907AbgAUQCq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Jan 2020 11:02:46 -0500
Received: from mga17.intel.com ([192.55.52.151]:15612 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729402AbgAUQB3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jan 2020 11:01:29 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga107.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 21 Jan 2020 08:01:29 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,346,1574150400"; 
   d="scan'208";a="250299116"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga004.fm.intel.com with ESMTP; 21 Jan 2020 08:01:25 -0800
Received: by black.fi.intel.com (Postfix, from userid 1001)
        id C3CECCE9; Tue, 21 Jan 2020 18:01:15 +0200 (EET)
From:   Mika Westerberg <mika.westerberg@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Darren Hart <dvhart@infradead.org>,
        Lee Jones <lee.jones@linaro.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H . Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        Zha Qipeng <qipeng.zha@intel.com>,
        "David E . Box" <david.e.box@linux.intel.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Mark Brown <broonie@kernel.org>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v4 24/38] platform/x86: intel_scu_ipc: Add managed function to register SCU IPC
Date:   Tue, 21 Jan 2020 19:01:00 +0300
Message-Id: <20200121160114.60007-25-mika.westerberg@linux.intel.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200121160114.60007-1-mika.westerberg@linux.intel.com>
References: <20200121160114.60007-1-mika.westerberg@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Drivers such as intel_pmc_ipc.c can be unloaded as well so in order to
support those in this driver add a new function that can be called to
unregister the SCU IPC when it is not needed anymore.

We also add a managed version of the intel_scu_ipc_register() that takes
care of calling intel_scu_ipc_unregister() automatically when the driver
is unbound.

Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 arch/x86/include/asm/intel_scu_ipc.h |  3 ++
 drivers/platform/x86/intel_scu_ipc.c | 63 ++++++++++++++++++++++++++++
 2 files changed, 66 insertions(+)

diff --git a/arch/x86/include/asm/intel_scu_ipc.h b/arch/x86/include/asm/intel_scu_ipc.h
index ce2ad516f0f9..23990b08c913 100644
--- a/arch/x86/include/asm/intel_scu_ipc.h
+++ b/arch/x86/include/asm/intel_scu_ipc.h
@@ -34,6 +34,9 @@ struct intel_scu_ipc_pdata {
 
 struct intel_scu_ipc_dev *
 intel_scu_ipc_register(struct device *dev, const struct intel_scu_ipc_pdata *pdata);
+void intel_scu_ipc_unregister(struct intel_scu_ipc_dev *scu);
+struct intel_scu_ipc_dev *
+devm_intel_scu_ipc_register(struct device *dev, const struct intel_scu_ipc_pdata *pdata);
 
 struct intel_scu_ipc_dev *intel_scu_ipc_dev_get(void);
 void intel_scu_ipc_dev_put(struct intel_scu_ipc_dev *scu);
diff --git a/drivers/platform/x86/intel_scu_ipc.c b/drivers/platform/x86/intel_scu_ipc.c
index 391b65a4789e..3df2efa19d77 100644
--- a/drivers/platform/x86/intel_scu_ipc.c
+++ b/drivers/platform/x86/intel_scu_ipc.c
@@ -584,3 +584,66 @@ intel_scu_ipc_register(struct device *dev, const struct intel_scu_ipc_pdata *pda
 	return ERR_PTR(err);
 }
 EXPORT_SYMBOL_GPL(intel_scu_ipc_register);
+
+/**
+ * intel_scu_ipc_unregister() - Unregister SCU IPC
+ * @scu: SCU IPC handle
+ *
+ * This unregisters the SCU IPC device and releases the acquired
+ * resources.
+ */
+void intel_scu_ipc_unregister(struct intel_scu_ipc_dev *scu)
+{
+	mutex_lock(&ipclock);
+	if (!WARN_ON(!scu->dev)) {
+		if (scu->irq > 0)
+			free_irq(scu->irq, scu);
+		iounmap(scu->ipc_base);
+		release_mem_region(scu->mem.start, resource_size(&scu->mem));
+		scu->dev = NULL;
+	}
+	mutex_unlock(&ipclock);
+}
+EXPORT_SYMBOL_GPL(intel_scu_ipc_unregister);
+
+static void devm_intel_scu_ipc_unregister(struct device *dev, void *res)
+{
+	struct intel_scu_ipc_devres *devres = res;
+	struct intel_scu_ipc_dev *scu = devres->scu;
+
+	intel_scu_ipc_unregister(scu);
+}
+
+/**
+ * devm_intel_scu_ipc_register() - Register managed SCU IPC device
+ * @dev: SCU device
+ * @pdata: Platform specific data
+ *
+ * Call this function to initialize managed SCU IPC mechanism for @dev.
+ * Returns SCU IPC instance or ERR_PTR() if there was an error. The caller
+ * may use the returned instance if it needs to do SCU IPC calls itself.
+ */
+struct intel_scu_ipc_dev *
+devm_intel_scu_ipc_register(struct device *dev,
+			    const struct intel_scu_ipc_pdata *pdata)
+{
+	struct intel_scu_ipc_devres *devres;
+	struct intel_scu_ipc_dev *scu;
+
+	devres = devres_alloc(devm_intel_scu_ipc_unregister, sizeof(*devres),
+			      GFP_KERNEL);
+	if (!devres)
+		return NULL;
+
+	scu = intel_scu_ipc_register(dev, pdata);
+	if (IS_ERR(scu)) {
+		devres_free(devres);
+		return scu;
+	}
+
+	devres->scu = scu;
+	devres_add(dev, devres);
+
+	return scu;
+}
+EXPORT_SYMBOL_GPL(devm_intel_scu_ipc_register);
-- 
2.24.1

