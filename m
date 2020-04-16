Return-Path: <SRS0=1dCa=6A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39245C2BB85
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Apr 2020 08:30:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B44AA20787
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Apr 2020 08:30:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2502200AbgDPIau (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Apr 2020 04:30:50 -0400
Received: from mga12.intel.com ([192.55.52.136]:39014 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2501905AbgDPIQi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Apr 2020 04:16:38 -0400
IronPort-SDR: 50DJ86U4MJ7Jkby1Lq0NZoFOIxuJQ0KSLNjEwAXOoHYuQlm79fWrUPMUvUrmUrrvHOMydpVxh/
 X6DSwaYfMoUQ==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Apr 2020 01:16:03 -0700
IronPort-SDR: J9MXT7awscDDBaJFE7XXJ+yPTGv8BozHrYnLEAXkbx5S3++YEn6jBznrYyyvKp6+u75o7+sOPg
 dXb47Y8JyftA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,390,1580803200"; 
   d="scan'208";a="288816856"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga002.fm.intel.com with ESMTP; 16 Apr 2020 01:15:58 -0700
Received: by black.fi.intel.com (Postfix, from userid 1001)
        id 69BFBCA1; Thu, 16 Apr 2020 11:15:53 +0300 (EEST)
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
Subject: [PATCH v9 08/20] platform/x86: intel_scu_ipc: Add managed function to register SCU IPC
Date:   Thu, 16 Apr 2020 11:15:40 +0300
Message-Id: <20200416081552.68083-9-mika.westerberg@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200416081552.68083-1-mika.westerberg@linux.intel.com>
References: <20200416081552.68083-1-mika.westerberg@linux.intel.com>
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
 arch/x86/include/asm/intel_scu_ipc.h | 10 +++++
 drivers/platform/x86/intel_scu_ipc.c | 62 ++++++++++++++++++++++++++++
 2 files changed, 72 insertions(+)

diff --git a/arch/x86/include/asm/intel_scu_ipc.h b/arch/x86/include/asm/intel_scu_ipc.h
index d5f6ae514172..11d457af68c5 100644
--- a/arch/x86/include/asm/intel_scu_ipc.h
+++ b/arch/x86/include/asm/intel_scu_ipc.h
@@ -25,6 +25,16 @@ __intel_scu_ipc_register(struct device *parent,
 #define intel_scu_ipc_register(parent, scu_data)  \
 	__intel_scu_ipc_register(parent, scu_data, THIS_MODULE)
 
+void intel_scu_ipc_unregister(struct intel_scu_ipc_dev *scu);
+
+struct intel_scu_ipc_dev *
+__devm_intel_scu_ipc_register(struct device *parent,
+			      const struct intel_scu_ipc_data *scu_data,
+			      struct module *owner);
+
+#define devm_intel_scu_ipc_register(parent, scu_data)  \
+	__devm_intel_scu_ipc_register(parent, scu_data, THIS_MODULE)
+
 struct intel_scu_ipc_dev *intel_scu_ipc_dev_get(void);
 void intel_scu_ipc_dev_put(struct intel_scu_ipc_dev *scu);
 struct intel_scu_ipc_dev *devm_intel_scu_ipc_dev_get(struct device *dev);
diff --git a/drivers/platform/x86/intel_scu_ipc.c b/drivers/platform/x86/intel_scu_ipc.c
index 608034ea7af5..d9cf7f7602b0 100644
--- a/drivers/platform/x86/intel_scu_ipc.c
+++ b/drivers/platform/x86/intel_scu_ipc.c
@@ -637,6 +637,68 @@ __intel_scu_ipc_register(struct device *parent,
 }
 EXPORT_SYMBOL_GPL(__intel_scu_ipc_register);
 
+/**
+ * intel_scu_ipc_unregister() - Unregister SCU IPC
+ * @scu: SCU IPC handle
+ *
+ * This unregisters the SCU IPC device and releases the acquired
+ * resources once the refcount goes to zero.
+ */
+void intel_scu_ipc_unregister(struct intel_scu_ipc_dev *scu)
+{
+	mutex_lock(&ipclock);
+	if (!WARN_ON(!ipcdev)) {
+		ipcdev = NULL;
+		device_unregister(&scu->dev);
+	}
+	mutex_unlock(&ipclock);
+}
+EXPORT_SYMBOL_GPL(intel_scu_ipc_unregister);
+
+static void devm_intel_scu_ipc_unregister(struct device *dev, void *res)
+{
+	struct intel_scu_ipc_devres *dr = res;
+	struct intel_scu_ipc_dev *scu = dr->scu;
+
+	intel_scu_ipc_unregister(scu);
+}
+
+/**
+ * __devm_intel_scu_ipc_register() - Register managed SCU IPC device
+ * @parent: Parent device
+ * @scu_data: Data used to configure SCU IPC
+ * @owner: Module registering the SCU IPC device
+ *
+ * Call this function to register managed SCU IPC mechanism under
+ * @parent. Returns pointer to the new SCU IPC device or ERR_PTR() in
+ * case of failure. The caller may use the returned instance if it needs
+ * to do SCU IPC calls itself.
+ */
+struct intel_scu_ipc_dev *
+__devm_intel_scu_ipc_register(struct device *parent,
+			      const struct intel_scu_ipc_data *scu_data,
+			      struct module *owner)
+{
+	struct intel_scu_ipc_devres *dr;
+	struct intel_scu_ipc_dev *scu;
+
+	dr = devres_alloc(devm_intel_scu_ipc_unregister, sizeof(*dr), GFP_KERNEL);
+	if (!dr)
+		return NULL;
+
+	scu = __intel_scu_ipc_register(parent, scu_data, owner);
+	if (IS_ERR(scu)) {
+		devres_free(dr);
+		return scu;
+	}
+
+	dr->scu = scu;
+	devres_add(parent, dr);
+
+	return scu;
+}
+EXPORT_SYMBOL_GPL(__devm_intel_scu_ipc_register);
+
 static int __init intel_scu_ipc_init(void)
 {
 	return class_register(&intel_scu_ipc_class);
-- 
2.25.1

