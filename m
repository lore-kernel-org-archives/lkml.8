Return-Path: <SRS0=PxPh=37=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6DED7C3B186
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Feb 2020 13:26:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 32FDD20675
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Feb 2020 13:26:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729121AbgBKN0K (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Feb 2020 08:26:10 -0500
Received: from mga12.intel.com ([192.55.52.136]:3588 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728826AbgBKN0J (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Feb 2020 08:26:09 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga106.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 11 Feb 2020 05:26:08 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,428,1574150400"; 
   d="scan'208";a="431957077"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga005.fm.intel.com with ESMTP; 11 Feb 2020 05:26:04 -0800
Received: by black.fi.intel.com (Postfix, from userid 1001)
        id F287128E; Tue, 11 Feb 2020 15:26:03 +0200 (EET)
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
Subject: [PATCH v5 03/18] platform/x86: intel_scu_ipc: Introduce new SCU IPC API
Date:   Tue, 11 Feb 2020 16:25:48 +0300
Message-Id: <20200211132603.73509-4-mika.westerberg@linux.intel.com>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200211132603.73509-1-mika.westerberg@linux.intel.com>
References: <20200211132603.73509-1-mika.westerberg@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The current SCU IPC API has been operating on a single instance and
there has been no way to pin the providing module in place when the SCU
IPC is in use.

This implements a new API that takes the SCU IPC instance as first
parameter (NULL means the single instance is being used). The SCU IPC
instance can be retrieved by calling new function
intel_scu_ipc_dev_get() that take care of pinning the providing module
in place as long as intel_scu_ipc_dev_put() is not called.

The old API and constants that are still being used are left there to
support existing users that cannot be converted easily but they are put
to a separate header that is subject to be removed eventually.
Subsequent patches will convert most of the users over to the new API.

Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 arch/x86/include/asm/intel_scu_ipc.h        |  90 +++-----
 arch/x86/include/asm/intel_scu_ipc_legacy.h |  84 +++++++
 drivers/platform/x86/intel_scu_ipc.c        | 231 +++++++++++++++-----
 3 files changed, 299 insertions(+), 106 deletions(-)
 create mode 100644 arch/x86/include/asm/intel_scu_ipc_legacy.h

diff --git a/arch/x86/include/asm/intel_scu_ipc.h b/arch/x86/include/asm/intel_scu_ipc.h
index 78f939782a67..27041fe999e9 100644
--- a/arch/x86/include/asm/intel_scu_ipc.h
+++ b/arch/x86/include/asm/intel_scu_ipc.h
@@ -3,22 +3,6 @@
 #define  _ASM_X86_INTEL_SCU_IPC_H_
 
 #include <linux/ioport.h>
-#include <linux/notifier.h>
-
-#define IPCMSG_INDIRECT_READ	0x02
-#define IPCMSG_INDIRECT_WRITE	0x05
-
-#define IPCMSG_COLD_OFF		0x80	/* Only for Tangier */
-
-#define IPCMSG_WARM_RESET	0xF0
-#define IPCMSG_COLD_RESET	0xF1
-#define IPCMSG_SOFT_RESET	0xF2
-#define IPCMSG_COLD_BOOT	0xF3
-
-#define IPCMSG_VRTC		0xFA	 /* Set vRTC device */
-	/* Command id associated with message IPCMSG_VRTC */
-	#define IPC_CMD_VRTC_SETTIME      1 /* Set time */
-	#define IPC_CMD_VRTC_SETALARM     2 /* Set alarm */
 
 struct device;
 struct intel_scu_ipc_dev;
@@ -34,47 +18,43 @@ struct intel_scu_ipc_pdata {
 };
 
 struct intel_scu_ipc_dev *
-intel_scu_ipc_register(struct device *parent,
-		       const struct intel_scu_ipc_pdata *pdata);
-
-/* Read single register */
-int intel_scu_ipc_ioread8(u16 addr, u8 *data);
-
-/* Read a vector */
-int intel_scu_ipc_readv(u16 *addr, u8 *data, int len);
-
-/* Write single register */
-int intel_scu_ipc_iowrite8(u16 addr, u8 data);
-
-/* Write a vector */
-int intel_scu_ipc_writev(u16 *addr, u8 *data, int len);
-
-/* Update single register based on the mask */
-int intel_scu_ipc_update_register(u16 addr, u8 data, u8 mask);
-
-/* Issue commands to the SCU with or without data */
-int intel_scu_ipc_simple_command(int cmd, int sub);
-int intel_scu_ipc_command(int cmd, int sub, u32 *in, int inlen,
-			  u32 *out, int outlen);
-
-extern struct blocking_notifier_head intel_scu_notifier;
-
-static inline void intel_scu_notifier_add(struct notifier_block *nb)
-{
-	blocking_notifier_chain_register(&intel_scu_notifier, nb);
-}
-
-static inline void intel_scu_notifier_remove(struct notifier_block *nb)
-{
-	blocking_notifier_chain_unregister(&intel_scu_notifier, nb);
-}
-
-static inline int intel_scu_notifier_post(unsigned long v, void *p)
+__intel_scu_ipc_register(struct device *parent,
+			 const struct intel_scu_ipc_pdata *pdata,
+			 struct module *owner);
+
+#define intel_scu_ipc_register(parent, pdata)  \
+	__intel_scu_ipc_register(parent, pdata, THIS_MODULE)
+
+struct intel_scu_ipc_dev *intel_scu_ipc_dev_get(void);
+void intel_scu_ipc_dev_put(struct intel_scu_ipc_dev *scu);
+struct intel_scu_ipc_dev *devm_intel_scu_ipc_dev_get(struct device *dev);
+
+int intel_scu_ipc_dev_ioread8(struct intel_scu_ipc_dev *scu, u16 addr,
+			      u8 *data);
+int intel_scu_ipc_dev_iowrite8(struct intel_scu_ipc_dev *scu, u16 addr,
+			       u8 data);
+int intel_scu_ipc_dev_readv(struct intel_scu_ipc_dev *scu, u16 *addr,
+			    u8 *data, size_t len);
+int intel_scu_ipc_dev_writev(struct intel_scu_ipc_dev *scu, u16 *addr,
+			     u8 *data, size_t len);
+
+int intel_scu_ipc_dev_update(struct intel_scu_ipc_dev *scu, u16 addr,
+			     u8 data, u8 mask);
+
+int intel_scu_ipc_dev_simple_command(struct intel_scu_ipc_dev *scu, int cmd,
+				     int sub);
+int intel_scu_ipc_dev_command_with_size(struct intel_scu_ipc_dev *scu, int cmd,
+					int sub, const void *in, size_t inlen,
+					size_t size, void *out, size_t outlen);
+
+static inline int intel_scu_ipc_dev_command(struct intel_scu_ipc_dev *scu, int cmd,
+					    int sub, const void *in, size_t inlen,
+					    void *out, size_t outlen)
 {
-	return blocking_notifier_call_chain(&intel_scu_notifier, v, p);
+	return intel_scu_ipc_dev_command_with_size(scu, cmd, sub, in, inlen,
+						   inlen, out, outlen);
 }
 
-#define		SCU_AVAILABLE		1
-#define		SCU_DOWN		2
+#include <asm/intel_scu_ipc_legacy.h>
 
 #endif
diff --git a/arch/x86/include/asm/intel_scu_ipc_legacy.h b/arch/x86/include/asm/intel_scu_ipc_legacy.h
new file mode 100644
index 000000000000..b6694f7d84af
--- /dev/null
+++ b/arch/x86/include/asm/intel_scu_ipc_legacy.h
@@ -0,0 +1,84 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef _ASM_X86_INTEL_SCU_IPC_LEGACY_H_
+#define _ASM_X86_INTEL_SCU_IPC_LEGACY_H_
+
+#define IPCMSG_COLD_OFF		0x80	/* Only for Tangier */
+#define IPCMSG_COLD_RESET	0xF1
+
+#define IPCMSG_VRTC		0xFA	 /* Set vRTC device */
+/* Command id associated with message IPCMSG_VRTC */
+#define IPC_CMD_VRTC_SETTIME	1 /* Set time */
+#define IPC_CMD_VRTC_SETALARM	2 /* Set alarm */
+
+#include <linux/notifier.h>
+
+/* Don't call these in new code - they will be removed eventually */
+
+/* Read single register */
+static inline int intel_scu_ipc_ioread8(u16 addr, u8 *data)
+{
+	return intel_scu_ipc_dev_ioread8(NULL, addr, data);
+}
+
+/* Read a vector */
+static inline int intel_scu_ipc_readv(u16 *addr, u8 *data, int len)
+{
+	return intel_scu_ipc_dev_readv(NULL, addr, data, len);
+}
+
+/* Write single register */
+static inline int intel_scu_ipc_iowrite8(u16 addr, u8 data)
+{
+	return intel_scu_ipc_dev_iowrite8(NULL, addr, data);
+}
+
+/* Write a vector */
+static inline int intel_scu_ipc_writev(u16 *addr, u8 *data, int len)
+{
+	return intel_scu_ipc_dev_writev(NULL, addr, data, len);
+}
+
+/* Update single register based on the mask */
+static inline int intel_scu_ipc_update_register(u16 addr, u8 data, u8 mask)
+{
+	return intel_scu_ipc_dev_update(NULL, addr, data, mask);
+}
+
+/* Issue commands to the SCU with or without data */
+static inline int intel_scu_ipc_simple_command(int cmd, int sub)
+{
+	return intel_scu_ipc_dev_simple_command(NULL, cmd, sub);
+}
+
+static inline int intel_scu_ipc_command(int cmd, int sub, u32 *in, int inlen,
+					u32 *out, int outlen)
+{
+	/* New API takes both inlen and outlen as bytes so convert here */
+	size_t inbytes = inlen * sizeof(u32);
+	size_t outbytes = outlen * sizeof(u32);
+
+	return intel_scu_ipc_dev_command_with_size(NULL, cmd, sub, in, inbytes,
+						   inlen, out, outbytes);
+}
+
+extern struct blocking_notifier_head intel_scu_notifier;
+
+static inline void intel_scu_notifier_add(struct notifier_block *nb)
+{
+	blocking_notifier_chain_register(&intel_scu_notifier, nb);
+}
+
+static inline void intel_scu_notifier_remove(struct notifier_block *nb)
+{
+	blocking_notifier_chain_unregister(&intel_scu_notifier, nb);
+}
+
+static inline int intel_scu_notifier_post(unsigned long v, void *p)
+{
+	return blocking_notifier_call_chain(&intel_scu_notifier, v, p);
+}
+
+#define		SCU_AVAILABLE		1
+#define		SCU_DOWN		2
+
+#endif
diff --git a/drivers/platform/x86/intel_scu_ipc.c b/drivers/platform/x86/intel_scu_ipc.c
index 1fc52b63d984..b9e77facf280 100644
--- a/drivers/platform/x86/intel_scu_ipc.c
+++ b/drivers/platform/x86/intel_scu_ipc.c
@@ -56,6 +56,7 @@
 struct intel_scu_ipc_dev {
 	struct device dev;
 	struct resource mem;
+	struct module *owner;
 	int irq;
 	void __iomem *ipc_base;
 	struct completion cmd_complete;
@@ -84,6 +85,103 @@ static struct class intel_scu_ipc_class = {
 	.owner = THIS_MODULE,
 };
 
+/**
+ * intel_scu_ipc_dev_get() - Get SCU IPC instance
+ *
+ * The recommended new API takes SCU IPC instance as parameter and this
+ * function can be called by driver to get the instance. This also makes
+ * sure the driver providing the IPC functionality cannot be unloaded
+ * while the caller has the instance.
+ *
+ * Call intel_scu_ipc_dev_put() to release the instance.
+ *
+ * Returns %NULL if SCU IPC is not currently available.
+ */
+struct intel_scu_ipc_dev *intel_scu_ipc_dev_get(void)
+{
+	struct intel_scu_ipc_dev *scu = NULL;
+
+	mutex_lock(&ipclock);
+	if (ipcdev) {
+		get_device(&ipcdev->dev);
+		/*
+		 * Prevent the IPC provider from being unloaded while it
+		 * is being used.
+		 */
+		if (!try_module_get(ipcdev->owner))
+			put_device(&ipcdev->dev);
+		else
+			scu = ipcdev;
+	}
+
+	mutex_unlock(&ipclock);
+	return scu;
+}
+EXPORT_SYMBOL_GPL(intel_scu_ipc_dev_get);
+
+/**
+ * intel_scu_ipc_dev_put() - Put SCU IPC instance
+ * @scu: SCU IPC instance
+ *
+ * This function releases the SCU IPC instance retrieved from
+ * intel_scu_ipc_dev_get() and allows the driver providing IPC to be
+ * unloaded.
+ */
+void intel_scu_ipc_dev_put(struct intel_scu_ipc_dev *scu)
+{
+	if (scu) {
+		module_put(scu->owner);
+		put_device(&scu->dev);
+	}
+}
+EXPORT_SYMBOL_GPL(intel_scu_ipc_dev_put);
+
+struct intel_scu_ipc_devres {
+	struct intel_scu_ipc_dev *scu;
+};
+
+static void devm_intel_scu_ipc_dev_release(struct device *dev, void *res)
+{
+	struct intel_scu_ipc_devres *devres = res;
+	struct intel_scu_ipc_dev *scu = devres->scu;
+
+	intel_scu_ipc_dev_put(scu);
+}
+
+/**
+ * devm_intel_scu_ipc_dev_get() - Allocate managed SCU IPC device
+ * @dev: Device requesting the SCU IPC device
+ *
+ * The recommended new API takes SCU IPC instance as parameter and this
+ * function can be called by driver to get the instance. This also makes
+ * sure the driver providing the IPC functionality cannot be unloaded
+ * while the caller has the instance.
+ *
+ * Returns %NULL if SCU IPC is not currently available.
+ */
+struct intel_scu_ipc_dev *devm_intel_scu_ipc_dev_get(struct device *dev)
+{
+	struct intel_scu_ipc_devres *devres;
+	struct intel_scu_ipc_dev *scu;
+
+	devres = devres_alloc(devm_intel_scu_ipc_dev_release, sizeof(*devres),
+			      GFP_KERNEL);
+	if (!devres)
+		return NULL;
+
+	scu = intel_scu_ipc_dev_get();
+	if (!scu) {
+		devres_free(devres);
+		return NULL;
+	}
+
+	devres->scu = scu;
+	devres_add(dev, devres);
+
+	return scu;
+}
+EXPORT_SYMBOL_GPL(devm_intel_scu_ipc_dev_get);
+
 /*
  * Send ipc command
  * Command Register (Write Only):
@@ -171,9 +269,9 @@ static int intel_scu_ipc_check_status(struct intel_scu_ipc_dev *scu)
 }
 
 /* Read/Write power control(PMIC in Langwell, MSIC in PenWell) registers */
-static int pwr_reg_rdwr(u16 *addr, u8 *data, u32 count, u32 op, u32 id)
+static int pwr_reg_rdwr(struct intel_scu_ipc_dev *scu, u16 *addr, u8 *data,
+			u32 count, u32 op, u32 id)
 {
-	struct intel_scu_ipc_dev *scu;
 	int nc;
 	u32 offset = 0;
 	int err;
@@ -183,11 +281,12 @@ static int pwr_reg_rdwr(u16 *addr, u8 *data, u32 count, u32 op, u32 id)
 	memset(cbuf, 0, sizeof(cbuf));
 
 	mutex_lock(&ipclock);
-	if (!ipcdev) {
+	if (!scu)
+		scu = ipcdev;
+	if (!scu) {
 		mutex_unlock(&ipclock);
 		return -ENODEV;
 	}
-	scu = ipcdev;
 
 	for (nc = 0; nc < count; nc++, offset += 2) {
 		cbuf[offset] = addr[nc];
@@ -223,7 +322,8 @@ static int pwr_reg_rdwr(u16 *addr, u8 *data, u32 count, u32 op, u32 id)
 }
 
 /**
- * intel_scu_ipc_ioread8		-	read a word via the SCU
+ * intel_scu_ipc_dev_ioread8() - Read a byte via the SCU
+ * @scu: Optional SCU IPC instance
  * @addr: Register on SCU
  * @data: Return pointer for read byte
  *
@@ -232,14 +332,15 @@ static int pwr_reg_rdwr(u16 *addr, u8 *data, u32 count, u32 op, u32 id)
  *
  * This function may sleep.
  */
-int intel_scu_ipc_ioread8(u16 addr, u8 *data)
+int intel_scu_ipc_dev_ioread8(struct intel_scu_ipc_dev *scu, u16 addr, u8 *data)
 {
-	return pwr_reg_rdwr(&addr, data, 1, IPCMSG_PCNTRL, IPC_CMD_PCNTRL_R);
+	return pwr_reg_rdwr(scu, &addr, data, 1, IPCMSG_PCNTRL, IPC_CMD_PCNTRL_R);
 }
-EXPORT_SYMBOL(intel_scu_ipc_ioread8);
+EXPORT_SYMBOL(intel_scu_ipc_dev_ioread8);
 
 /**
- * intel_scu_ipc_iowrite8		-	write a byte via the SCU
+ * intel_scu_ipc_dev_iowrite8() - Write a byte via the SCU
+ * @scu: Optional SCU IPC instance
  * @addr: Register on SCU
  * @data: Byte to write
  *
@@ -248,14 +349,15 @@ EXPORT_SYMBOL(intel_scu_ipc_ioread8);
  *
  * This function may sleep.
  */
-int intel_scu_ipc_iowrite8(u16 addr, u8 data)
+int intel_scu_ipc_dev_iowrite8(struct intel_scu_ipc_dev *scu, u16 addr, u8 data)
 {
-	return pwr_reg_rdwr(&addr, &data, 1, IPCMSG_PCNTRL, IPC_CMD_PCNTRL_W);
+	return pwr_reg_rdwr(scu, &addr, &data, 1, IPCMSG_PCNTRL, IPC_CMD_PCNTRL_W);
 }
-EXPORT_SYMBOL(intel_scu_ipc_iowrite8);
+EXPORT_SYMBOL(intel_scu_ipc_dev_iowrite8);
 
 /**
- * intel_scu_ipc_readvv		-	read a set of registers
+ * intel_scu_ipc_dev_readv() - Read a set of registers
+ * @scu: Optional SCU IPC instance
  * @addr: Register list
  * @data: Bytes to return
  * @len: Length of array
@@ -267,14 +369,16 @@ EXPORT_SYMBOL(intel_scu_ipc_iowrite8);
  *
  * This function may sleep.
  */
-int intel_scu_ipc_readv(u16 *addr, u8 *data, int len)
+int intel_scu_ipc_dev_readv(struct intel_scu_ipc_dev *scu, u16 *addr, u8 *data,
+			    size_t len)
 {
-	return pwr_reg_rdwr(addr, data, len, IPCMSG_PCNTRL, IPC_CMD_PCNTRL_R);
+	return pwr_reg_rdwr(scu, addr, data, len, IPCMSG_PCNTRL, IPC_CMD_PCNTRL_R);
 }
-EXPORT_SYMBOL(intel_scu_ipc_readv);
+EXPORT_SYMBOL(intel_scu_ipc_dev_readv);
 
 /**
- * intel_scu_ipc_writev		-	write a set of registers
+ * intel_scu_ipc_dev_writev() - Write a set of registers
+ * @scu: Optional SCU IPC instance
  * @addr: Register list
  * @data: Bytes to write
  * @len: Length of array
@@ -286,16 +390,18 @@ EXPORT_SYMBOL(intel_scu_ipc_readv);
  *
  * This function may sleep.
  */
-int intel_scu_ipc_writev(u16 *addr, u8 *data, int len)
+int intel_scu_ipc_dev_writev(struct intel_scu_ipc_dev *scu, u16 *addr, u8 *data,
+			     size_t len)
 {
-	return pwr_reg_rdwr(addr, data, len, IPCMSG_PCNTRL, IPC_CMD_PCNTRL_W);
+	return pwr_reg_rdwr(scu, addr, data, len, IPCMSG_PCNTRL, IPC_CMD_PCNTRL_W);
 }
-EXPORT_SYMBOL(intel_scu_ipc_writev);
+EXPORT_SYMBOL(intel_scu_ipc_dev_writev);
 
 /**
- * intel_scu_ipc_update_register	-	r/m/w a register
+ * intel_scu_ipc_dev_update() - Update a register
+ * @scu: Optional SCU IPC instance
  * @addr: Register address
- * @bits: Bits to update
+ * @data: Bits to update
  * @mask: Mask of bits to update
  *
  * Read-modify-write power control unit register. The first data argument
@@ -306,15 +412,17 @@ EXPORT_SYMBOL(intel_scu_ipc_writev);
  * This function may sleep. Locking between SCU accesses is handled
  * for the caller.
  */
-int intel_scu_ipc_update_register(u16 addr, u8 bits, u8 mask)
+int intel_scu_ipc_dev_update(struct intel_scu_ipc_dev *scu, u16 addr, u8 data,
+			     u8 mask)
 {
-	u8 data[2] = { bits, mask };
-	return pwr_reg_rdwr(&addr, data, 1, IPCMSG_PCNTRL, IPC_CMD_PCNTRL_M);
+	u8 tmp[2] = { data, mask };
+	return pwr_reg_rdwr(scu, &addr, tmp, 1, IPCMSG_PCNTRL, IPC_CMD_PCNTRL_M);
 }
-EXPORT_SYMBOL(intel_scu_ipc_update_register);
+EXPORT_SYMBOL(intel_scu_ipc_dev_update);
 
 /**
- * intel_scu_ipc_simple_command	-	send a simple command
+ * intel_scu_ipc_dev_simple_command() - Send a simple command
+ * @scu: Optional SCU IPC instance
  * @cmd: Command
  * @sub: Sub type
  *
@@ -325,14 +433,16 @@ EXPORT_SYMBOL(intel_scu_ipc_update_register);
  * This function may sleep. Locking for SCU accesses is handled for the
  * caller.
  */
-int intel_scu_ipc_simple_command(int cmd, int sub)
+int intel_scu_ipc_dev_simple_command(struct intel_scu_ipc_dev *scu, int cmd,
+				     int sub)
 {
-	struct intel_scu_ipc_dev *scu;
 	u32 cmdval;
 	int err;
 
 	mutex_lock(&ipclock);
-	if (!ipcdev) {
+	if (!scu)
+		scu = ipcdev;
+	if (!scu) {
 		mutex_unlock(&ipclock);
 		return -ENODEV;
 	}
@@ -346,52 +456,67 @@ int intel_scu_ipc_simple_command(int cmd, int sub)
 	mutex_unlock(&ipclock);
 	return err;
 }
-EXPORT_SYMBOL(intel_scu_ipc_simple_command);
+EXPORT_SYMBOL(intel_scu_ipc_dev_simple_command);
 
 /**
- * intel_scu_ipc_command	-	command with data
+ * intel_scu_ipc_command_with_size() - Command with data
+ * @scu: Optional SCU IPC instance
  * @cmd: Command
  * @sub: Sub type
  * @in: Input data
- * @inlen: Input length in dwords
+ * @inlen: Input length in bytes
+ * @size: Input size written to the IPC command register in whatever
+ *	  units (dword, byte) the particular firmware requires. Normally
+ *	  should be the same as @inlen.
  * @out: Output data
- * @outlen: Output length in dwords
+ * @outlen: Output length in bytes
  *
  * Issue a command to the SCU which involves data transfers. Do the
  * data copies under the lock but leave it for the caller to interpret.
  */
-int intel_scu_ipc_command(int cmd, int sub, u32 *in, int inlen,
-			  u32 *out, int outlen)
+int intel_scu_ipc_dev_command_with_size(struct intel_scu_ipc_dev *scu, int cmd,
+					int sub, const void *in, size_t inlen,
+					size_t size, void *out, size_t outlen)
 {
-	struct intel_scu_ipc_dev *scu;
-	u32 cmdval;
+	size_t outbuflen = DIV_ROUND_UP(outlen, sizeof(u32));
+	size_t inbuflen = DIV_ROUND_UP(inlen, sizeof(u32));
+	u32 cmdval, inbuf[4] = {};
 	int i, err;
 
+	if (inbuflen > 4 || outbuflen > 4)
+		return -EINVAL;
+
 	mutex_lock(&ipclock);
-	if (!ipcdev) {
+	if (!scu)
+		scu = ipcdev;
+	if (!scu) {
 		mutex_unlock(&ipclock);
 		return -ENODEV;
 	}
-	scu = ipcdev;
 
-	for (i = 0; i < inlen; i++)
-		ipc_data_writel(scu, *in++, 4 * i);
+	memcpy(inbuf, in, inlen);
+	for (i = 0; i < inbuflen; i++)
+		ipc_data_writel(scu, inbuf[i], 4 * i);
 
-	cmdval = (inlen << 16) | (sub << 12) | cmd;
+	cmdval = (size << 16) | (sub << 12) | cmd;
 	ipc_command(scu, cmdval);
 	err = intel_scu_ipc_check_status(scu);
 	if (err) {
 		dev_err(&scu->dev, "IPC command %#x failed with %d\n", cmdval,
 			err);
 	} else {
-		for (i = 0; i < outlen; i++)
-			*out++ = ipc_data_readl(scu, 4 * i);
+		u32 outbuf[4] = {};
+
+		for (i = 0; i < outbuflen; i++)
+			outbuf[i] = ipc_data_readl(scu, 4 * i);
+
+		memcpy(out, outbuf, outlen);
 	}
 
 	mutex_unlock(&ipclock);
 	return err;
 }
-EXPORT_SYMBOL(intel_scu_ipc_command);
+EXPORT_SYMBOL(intel_scu_ipc_dev_command_with_size);
 
 /*
  * Interrupt handler gets called when ioc bit of IPC_COMMAND_REG set to 1
@@ -424,17 +549,20 @@ static void intel_scu_ipc_release(struct device *dev)
 }
 
 /**
- * intel_scu_ipc_register() - Register SCU IPC device
+ * __intel_scu_ipc_register() - Register SCU IPC device
  * @parent: Parent device
  * @pdata: Platform specific data for SCU IPC
+ * @owner: Module registering the SCU IPC device
  *
  * Call this function to register SCU IPC mechanism under @parent.
  * Returns pointer to the new SCU IPC device or ERR_PTR() in case of
- * failure.
+ * failure. The caller may use the returned instance if it needs to do
+ * SCU IPC calls itself.
  */
 struct intel_scu_ipc_dev *
-intel_scu_ipc_register(struct device *parent,
-		       const struct intel_scu_ipc_pdata *pdata)
+__intel_scu_ipc_register(struct device *parent,
+			 const struct intel_scu_ipc_pdata *pdata,
+			 struct module *owner)
 {
 	int err;
 	struct intel_scu_ipc_dev *scu;
@@ -453,6 +581,7 @@ intel_scu_ipc_register(struct device *parent,
 		goto err_unlock;
 	}
 
+	scu->owner = owner;
 	scu->dev.parent = parent;
 	scu->dev.class = &intel_scu_ipc_class;
 	scu->dev.release = intel_scu_ipc_release;
@@ -508,7 +637,7 @@ intel_scu_ipc_register(struct device *parent,
 
 	return ERR_PTR(err);
 }
-EXPORT_SYMBOL_GPL(intel_scu_ipc_register);
+EXPORT_SYMBOL_GPL(__intel_scu_ipc_register);
 
 static int __init intel_scu_ipc_init(void)
 {
-- 
2.25.0

