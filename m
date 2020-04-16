Return-Path: <SRS0=1dCa=6A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7F98C2BB85
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Apr 2020 08:17:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 828D7206F9
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Apr 2020 08:17:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2440395AbgDPIRW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Apr 2020 04:17:22 -0400
Received: from mga06.intel.com ([134.134.136.31]:51571 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2441222AbgDPIQp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Apr 2020 04:16:45 -0400
IronPort-SDR: SVxvA6raBaMENI93eFJ5cSq0Ye3gfRXMW6VYSURVgcmb2WQ9koffM35TMnncZVrP/faQr6UuMc
 sYC98Jt59vZQ==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Apr 2020 01:15:58 -0700
IronPort-SDR: MM7tNGcTSEU5oTbrc2mPIme1TT8WxTHmkYbmbrYb/DfF4wn+0Sk6xnlVPpbhrzuEGw5x7LQLRy
 INcXzOrjgRjg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,390,1580803200"; 
   d="scan'208";a="454241075"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga005.fm.intel.com with ESMTP; 16 Apr 2020 01:15:54 -0700
Received: by black.fi.intel.com (Postfix, from userid 1001)
        id 42968638; Thu, 16 Apr 2020 11:15:53 +0300 (EEST)
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
Subject: [PATCH v9 04/20] platform/x86: intel_scu_ipc: Introduce new SCU IPC API
Date:   Thu, 16 Apr 2020 11:15:36 +0300
Message-Id: <20200416081552.68083-5-mika.westerberg@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200416081552.68083-1-mika.westerberg@linux.intel.com>
References: <20200416081552.68083-1-mika.westerberg@linux.intel.com>
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
instance can be retrieved by calling new function intel_scu_ipc_dev_get()
that take care of pinning the providing module in place as long as
intel_scu_ipc_dev_put() is not called.

The old API is updated to call the new API and is is left there in the
legacy API header to support the existing users that cannot be converted
easily.

Subsequent patches will convert most of the users over to the new API.

Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 arch/x86/include/asm/intel_scu_ipc.h        |  38 +++-
 arch/x86/include/asm/intel_scu_ipc_legacy.h |  45 +++-
 drivers/platform/x86/intel_scu_ipc.c        | 230 +++++++++++++++-----
 3 files changed, 252 insertions(+), 61 deletions(-)

diff --git a/arch/x86/include/asm/intel_scu_ipc.h b/arch/x86/include/asm/intel_scu_ipc.h
index 2d0e485842fd..d5f6ae514172 100644
--- a/arch/x86/include/asm/intel_scu_ipc.h
+++ b/arch/x86/include/asm/intel_scu_ipc.h
@@ -18,8 +18,42 @@ struct intel_scu_ipc_data {
 };
 
 struct intel_scu_ipc_dev *
-intel_scu_ipc_register(struct device *parent,
-		       const struct intel_scu_ipc_data *scu_data);
+__intel_scu_ipc_register(struct device *parent,
+			 const struct intel_scu_ipc_data *scu_data,
+			 struct module *owner);
+
+#define intel_scu_ipc_register(parent, scu_data)  \
+	__intel_scu_ipc_register(parent, scu_data, THIS_MODULE)
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
+{
+	return intel_scu_ipc_dev_command_with_size(scu, cmd, sub, in, inlen,
+						   inlen, out, outlen);
+}
 
 #include <asm/intel_scu_ipc_legacy.h>
 
diff --git a/arch/x86/include/asm/intel_scu_ipc_legacy.h b/arch/x86/include/asm/intel_scu_ipc_legacy.h
index d3a02bc07edd..4cf13fecb673 100644
--- a/arch/x86/include/asm/intel_scu_ipc_legacy.h
+++ b/arch/x86/include/asm/intel_scu_ipc_legacy.h
@@ -19,25 +19,54 @@
 #define IPC_CMD_VRTC_SETTIME      1	/* Set time */
 #define IPC_CMD_VRTC_SETALARM     2	/* Set alarm */
 
+/* Don't call these in new code - they will be removed eventually */
+
 /* Read single register */
-int intel_scu_ipc_ioread8(u16 addr, u8 *data);
+static inline int intel_scu_ipc_ioread8(u16 addr, u8 *data)
+{
+	return intel_scu_ipc_dev_ioread8(NULL, addr, data);
+}
 
 /* Read a vector */
-int intel_scu_ipc_readv(u16 *addr, u8 *data, int len);
+static inline int intel_scu_ipc_readv(u16 *addr, u8 *data, int len)
+{
+	return intel_scu_ipc_dev_readv(NULL, addr, data, len);
+}
 
 /* Write single register */
-int intel_scu_ipc_iowrite8(u16 addr, u8 data);
+static inline int intel_scu_ipc_iowrite8(u16 addr, u8 data)
+{
+	return intel_scu_ipc_dev_iowrite8(NULL, addr, data);
+}
 
 /* Write a vector */
-int intel_scu_ipc_writev(u16 *addr, u8 *data, int len);
+static inline int intel_scu_ipc_writev(u16 *addr, u8 *data, int len)
+{
+	return intel_scu_ipc_dev_writev(NULL, addr, data, len);
+}
 
 /* Update single register based on the mask */
-int intel_scu_ipc_update_register(u16 addr, u8 data, u8 mask);
+static inline int intel_scu_ipc_update_register(u16 addr, u8 data, u8 mask)
+{
+	return intel_scu_ipc_dev_update(NULL, addr, data, mask);
+}
 
 /* Issue commands to the SCU with or without data */
-int intel_scu_ipc_simple_command(int cmd, int sub);
-int intel_scu_ipc_command(int cmd, int sub, u32 *in, int inlen,
-			  u32 *out, int outlen);
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
 
 extern struct blocking_notifier_head intel_scu_notifier;
 
diff --git a/drivers/platform/x86/intel_scu_ipc.c b/drivers/platform/x86/intel_scu_ipc.c
index e8ea250aeda3..608034ea7af5 100644
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
@@ -84,6 +85,102 @@ static struct class intel_scu_ipc_class = {
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
+	struct intel_scu_ipc_devres *dr = res;
+	struct intel_scu_ipc_dev *scu = dr->scu;
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
+	struct intel_scu_ipc_devres *dr;
+	struct intel_scu_ipc_dev *scu;
+
+	dr = devres_alloc(devm_intel_scu_ipc_dev_release, sizeof(*dr), GFP_KERNEL);
+	if (!dr)
+		return NULL;
+
+	scu = intel_scu_ipc_dev_get();
+	if (!scu) {
+		devres_free(dr);
+		return NULL;
+	}
+
+	dr->scu = scu;
+	devres_add(dev, dr);
+
+	return scu;
+}
+EXPORT_SYMBOL_GPL(devm_intel_scu_ipc_dev_get);
+
 /*
  * Send ipc command
  * Command Register (Write Only):
@@ -171,9 +268,9 @@ static int intel_scu_ipc_check_status(struct intel_scu_ipc_dev *scu)
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
@@ -183,11 +280,12 @@ static int pwr_reg_rdwr(u16 *addr, u8 *data, u32 count, u32 op, u32 id)
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
@@ -223,7 +321,8 @@ static int pwr_reg_rdwr(u16 *addr, u8 *data, u32 count, u32 op, u32 id)
 }
 
 /**
- * intel_scu_ipc_ioread8		-	read a word via the SCU
+ * intel_scu_ipc_dev_ioread8() - Read a byte via the SCU
+ * @scu: Optional SCU IPC instance
  * @addr: Register on SCU
  * @data: Return pointer for read byte
  *
@@ -232,14 +331,15 @@ static int pwr_reg_rdwr(u16 *addr, u8 *data, u32 count, u32 op, u32 id)
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
@@ -248,14 +348,15 @@ EXPORT_SYMBOL(intel_scu_ipc_ioread8);
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
@@ -267,14 +368,16 @@ EXPORT_SYMBOL(intel_scu_ipc_iowrite8);
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
@@ -286,16 +389,18 @@ EXPORT_SYMBOL(intel_scu_ipc_readv);
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
@@ -306,15 +411,17 @@ EXPORT_SYMBOL(intel_scu_ipc_writev);
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
@@ -325,14 +432,16 @@ EXPORT_SYMBOL(intel_scu_ipc_update_register);
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
@@ -345,44 +454,59 @@ int intel_scu_ipc_simple_command(int cmd, int sub)
 		dev_err(&scu->dev, "IPC command %#x failed with %d\n", cmdval, err);
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
 
 	if (!err) {
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
@@ -390,7 +514,7 @@ int intel_scu_ipc_command(int cmd, int sub, u32 *in, int inlen,
 		dev_err(&scu->dev, "IPC command %#x failed with %d\n", cmdval, err);
 	return err;
 }
-EXPORT_SYMBOL(intel_scu_ipc_command);
+EXPORT_SYMBOL(intel_scu_ipc_dev_command_with_size);
 
 /*
  * Interrupt handler gets called when ioc bit of IPC_COMMAND_REG set to 1
@@ -423,17 +547,20 @@ static void intel_scu_ipc_release(struct device *dev)
 }
 
 /**
- * intel_scu_ipc_register() - Register SCU IPC device
+ * __intel_scu_ipc_register() - Register SCU IPC device
  * @parent: Parent device
  * @scu_data: Data used to configure SCU IPC
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
-		       const struct intel_scu_ipc_data *scu_data)
+__intel_scu_ipc_register(struct device *parent,
+			 const struct intel_scu_ipc_data *scu_data,
+			 struct module *owner)
 {
 	int err;
 	struct intel_scu_ipc_dev *scu;
@@ -452,6 +579,7 @@ intel_scu_ipc_register(struct device *parent,
 		goto err_unlock;
 	}
 
+	scu->owner = owner;
 	scu->dev.parent = parent;
 	scu->dev.class = &intel_scu_ipc_class;
 	scu->dev.release = intel_scu_ipc_release;
@@ -507,7 +635,7 @@ intel_scu_ipc_register(struct device *parent,
 
 	return ERR_PTR(err);
 }
-EXPORT_SYMBOL_GPL(intel_scu_ipc_register);
+EXPORT_SYMBOL_GPL(__intel_scu_ipc_register);
 
 static int __init intel_scu_ipc_init(void)
 {
-- 
2.25.1

