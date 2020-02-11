Return-Path: <SRS0=PxPh=37=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87418C352A3
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Feb 2020 13:26:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6378620675
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Feb 2020 13:26:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728109AbgBKN0w (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Feb 2020 08:26:52 -0500
Received: from mga12.intel.com ([192.55.52.136]:3588 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729141AbgBKN0P (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Feb 2020 08:26:15 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga106.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 11 Feb 2020 05:26:13 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,428,1574150400"; 
   d="scan'208";a="380432980"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga004.jf.intel.com with ESMTP; 11 Feb 2020 05:26:09 -0800
Received: by black.fi.intel.com (Postfix, from userid 1001)
        id 2F8CF4AB; Tue, 11 Feb 2020 15:26:04 +0200 (EET)
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
Subject: [PATCH v5 07/18] platform/x86: intel_scu_ipc: Add managed function to register SCU IPC
Date:   Tue, 11 Feb 2020 16:25:52 +0300
Message-Id: <20200211132603.73509-8-mika.westerberg@linux.intel.com>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200211132603.73509-1-mika.westerberg@linux.intel.com>
References: <20200211132603.73509-1-mika.westerberg@linux.intel.com>
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
 drivers/platform/x86/intel_scu_ipc.c | 63 ++++++++++++++++++++++++++++
 2 files changed, 73 insertions(+)

diff --git a/arch/x86/include/asm/intel_scu_ipc.h b/arch/x86/include/asm/intel_scu_ipc.h
index 27041fe999e9..2463ff5cad5b 100644
--- a/arch/x86/include/asm/intel_scu_ipc.h
+++ b/arch/x86/include/asm/intel_scu_ipc.h
@@ -25,6 +25,16 @@ __intel_scu_ipc_register(struct device *parent,
 #define intel_scu_ipc_register(parent, pdata)  \
 	__intel_scu_ipc_register(parent, pdata, THIS_MODULE)
 
+void intel_scu_ipc_unregister(struct intel_scu_ipc_dev *scu);
+
+struct intel_scu_ipc_dev *
+__devm_intel_scu_ipc_register(struct device *parent,
+			      const struct intel_scu_ipc_pdata *pdata,
+			      struct module *owner);
+
+#define devm_intel_scu_ipc_register(parent, pdata)  \
+	__devm_intel_scu_ipc_register(parent, pdata, THIS_MODULE)
+
 struct intel_scu_ipc_dev *intel_scu_ipc_dev_get(void);
 void intel_scu_ipc_dev_put(struct intel_scu_ipc_dev *scu);
 struct intel_scu_ipc_dev *devm_intel_scu_ipc_dev_get(struct device *dev);
diff --git a/drivers/platform/x86/intel_scu_ipc.c b/drivers/platform/x86/intel_scu_ipc.c
index b9e77facf280..58b3d4a48ae2 100644
--- a/drivers/platform/x86/intel_scu_ipc.c
+++ b/drivers/platform/x86/intel_scu_ipc.c
@@ -639,6 +639,69 @@ __intel_scu_ipc_register(struct device *parent,
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
+	struct intel_scu_ipc_devres *devres = res;
+	struct intel_scu_ipc_dev *scu = devres->scu;
+
+	intel_scu_ipc_unregister(scu);
+}
+
+/**
+ * __devm_intel_scu_ipc_register() - Register managed SCU IPC device
+ * @parent: Parent device
+ * @pdata: Platform specific data
+ * @owner: Module registering the SCU IPC device
+ *
+ * Call this function to register managed SCU IPC mechanism under
+ * @parent. Returns pointer to the new SCU IPC device or ERR_PTR() in
+ * case of failure. The caller may use the returned instance if it needs
+ * to do SCU IPC calls itself.
+ */
+struct intel_scu_ipc_dev *
+__devm_intel_scu_ipc_register(struct device *parent,
+			      const struct intel_scu_ipc_pdata *pdata,
+			      struct module *owner)
+{
+	struct intel_scu_ipc_devres *devres;
+	struct intel_scu_ipc_dev *scu;
+
+	devres = devres_alloc(devm_intel_scu_ipc_unregister, sizeof(*devres),
+			      GFP_KERNEL);
+	if (!devres)
+		return NULL;
+
+	scu = __intel_scu_ipc_register(parent, pdata, owner);
+	if (IS_ERR(scu)) {
+		devres_free(devres);
+		return scu;
+	}
+
+	devres->scu = scu;
+	devres_add(parent, devres);
+
+	return scu;
+}
+EXPORT_SYMBOL_GPL(__devm_intel_scu_ipc_register);
+
 static int __init intel_scu_ipc_init(void)
 {
 	return class_register(&intel_scu_ipc_class);
-- 
2.25.0

