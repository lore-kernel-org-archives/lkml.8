Return-Path: <SRS0=lrRa=AG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A934C433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jun 2020 21:10:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 62F862076E
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jun 2020 21:10:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=eclypsium.com header.i=@eclypsium.com header.b="g5Ewj3R9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391161AbgFYVKt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Jun 2020 17:10:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390087AbgFYVKs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Jun 2020 17:10:48 -0400
Received: from mail-qt1-x843.google.com (mail-qt1-x843.google.com [IPv6:2607:f8b0:4864:20::843])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2898DC08C5C1
        for <linux-kernel@vger.kernel.org>; Thu, 25 Jun 2020 14:10:48 -0700 (PDT)
Received: by mail-qt1-x843.google.com with SMTP id h23so5923380qtr.0
        for <linux-kernel@vger.kernel.org>; Thu, 25 Jun 2020 14:10:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=eclypsium.com; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=VbXE/FaMmPmDozkAg+4S/7yXY7IPumD6Vq1PucBnSA4=;
        b=g5Ewj3R9NkBN5OVoX0/8slJxcrMocHxFentbCVMbK34PG54IRa3UNHIl9ww5o+7d0Z
         CF5gyCzHpoeZe8FIoPPo/mxzmv/thFY1pKxZY6r1Z4nFxHVVG+9e0OJYV4Ve3JFw1/Xc
         PDIs50MErjdFHlbidMXbiBp5/D26xeLArvVf9JI29M0NPPorvwOE+G80aed5GJQd+y5r
         mDC9CjFzGwyhnZB5cWSvtrHUD5gLO15ca3O5UvX4Af3neBDLvh00x33UBKUHU4puc4ju
         dMnlrMqpOx0+YeV1pG4YQfeMLZEn5WZqdTMvWiNRM2YM1LQgOxSts6x08pqtfOGMbkpS
         oOnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=VbXE/FaMmPmDozkAg+4S/7yXY7IPumD6Vq1PucBnSA4=;
        b=MHKgskl+Y/GiHqrpXExl8TP4sh4mv0XlcL7tM66FDecchW2BwafdKWFguenGWa8xQs
         5CwmPBBFqYppiP1wQ8fuVUhkhJLNAPXDzlQZCp/k/hHcUdDif2VOzXSB4E9W1L6uVIpV
         +W1NStEkWVkWVCGMKBPXEkqe/9qAwMYKrLJqXHF3EI0cqb/wuSqgpQR98wg4mkL1E9BF
         lUqK8wrp+sFiH++o4vKuTTSGyuw8z7hmPWPiX3oG3rl+aQPs9ZNgHK0VZKDX2uCQP5FY
         jrqZgqkOD5IgmrdSlHGIBF4PJl9wjKythJFgu3L/3oVTNIZ/xoiBNo5BxBx4mRFxx37U
         /vig==
X-Gm-Message-State: AOAM531hcSiov31tXFPlt9RRsxA/4KaXhblh+sEaD7V2RiB9UMxoHGZl
        62ziD37mqUXvhrNuY7y28atIaA==
X-Google-Smtp-Source: ABdhPJwShWyPDBD+G7KPxWctBVJEOkjij+A1SiXNz1U8/tNTuhbiiTjXbb507aVfez0GsoqBczlaqA==
X-Received: by 2002:ac8:260b:: with SMTP id u11mr34561907qtu.380.1593119447157;
        Thu, 25 Jun 2020 14:10:47 -0700 (PDT)
Received: from localhost ([190.190.138.51])
        by smtp.gmail.com with ESMTPSA id u20sm6531246qtj.39.2020.06.25.14.10.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 25 Jun 2020 14:10:46 -0700 (PDT)
From:   Daniel Gutson <daniel.gutson@eclypsium.com>
To:     "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Daniel Gutson <daniel.gutson@eclypsium.com>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     "David S. Miller" <davem@davemloft.net>,
        Rob Herring <robh@kernel.org>, Tony Luck <tony.luck@intel.com>,
        Rahul Tanwar <rahul.tanwar@linux.intel.com>,
        Xiaoyao Li <xiaoyao.li@intel.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] Ability to read the MKTME status from userspace (patch v2)
Date:   Thu, 25 Jun 2020 18:10:29 -0300
Message-Id: <20200625211029.34733-1-daniel.gutson@eclypsium.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The intent of this patch is to provide visibility of the
MKTME status to userspace. This is an important factor for
firmware security related applilcations.

Changes since v1:
* Documentation/ABI/stable/securityfs-mktme-status (new file)
* include/uapi/misc/mktme_status.h (new file)
* Fixed MAINTAINER title.
* cpu.h: added values to the enumerands
* Renamed the function from get_mktme_status to mktme_get_status
* Improved Kconfig help
* Removed unnecessary license-related lines since there is a SPDX line
* Moved pr_fmt macro before the includes
* Turned global variables (mktme_dir, mktme_file) as static
* Removed BUFFER_SIZE macro
* No longer returning -1 for error, but using the previously error.
* No more pr_info for the normal behavior.
* Renamed this from a kernel driver to a kernel module.

Signed-off-by: Daniel Gutson <daniel.gutson@eclypsium.com>
---
 .../ABI/stable/securityfs-mktme-status        | 12 ++++
 MAINTAINERS                                   |  5 ++
 arch/x86/include/asm/cpu.h                    |  8 +++
 arch/x86/kernel/cpu/intel.c                   | 12 ++--
 drivers/misc/Kconfig                          | 15 +++++
 drivers/misc/Makefile                         |  1 +
 drivers/misc/mktme_status.c                   | 67 +++++++++++++++++++
 include/uapi/misc/mktme_status.h              | 12 ++++
 8 files changed, 127 insertions(+), 5 deletions(-)
 create mode 100644 Documentation/ABI/stable/securityfs-mktme-status
 create mode 100644 drivers/misc/mktme_status.c
 create mode 100644 include/uapi/misc/mktme_status.h

diff --git a/Documentation/ABI/stable/securityfs-mktme-status b/Documentation/ABI/stable/securityfs-mktme-status
new file mode 100644
index 000000000000..a791c6ef2c15
--- /dev/null
+++ b/Documentation/ABI/stable/securityfs-mktme-status
@@ -0,0 +1,12 @@
+What: 		/securityfs/mktme/status
+Date:		24-Jun-2020
+KernelVersion:	v5.7
+Contact:	daniel.gutson@eclypsium.com
+Description: 	The mktme securityfs interface exports the BIOS status
+		of the MKTME.
+Values:         For possible values see arch/x86/include/asm/cpu.h.
+
+		Currently these values are:
+		0 Enabled by BIOS
+		1 Disabled by BIOS
+		2 Uninitialized
diff --git a/MAINTAINERS b/MAINTAINERS
index 7b5ffd646c6b..e034e8ab6fe1 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -11477,6 +11477,11 @@ W:	https://linuxtv.org
 T:	git git://linuxtv.org/media_tree.git
 F:	drivers/media/radio/radio-miropcm20*
 
+MKTME STATUS READING SUPPORT
+M:	Daniel Gutson <daniel.gutson@eclypsium.com>
+S:	Supported
+F:	drivers/misc/mktme_status.c
+
 MMP SUPPORT
 R:	Lubomir Rintel <lkundrak@v3.sk>
 L:	linux-arm-kernel@lists.infradead.org (moderated for non-subscribers)
diff --git a/arch/x86/include/asm/cpu.h b/arch/x86/include/asm/cpu.h
index dd17c2da1af5..80d2896a3f43 100644
--- a/arch/x86/include/asm/cpu.h
+++ b/arch/x86/include/asm/cpu.h
@@ -26,6 +26,14 @@ struct x86_cpu {
 	struct cpu cpu;
 };
 
+enum mktme_status_type {
+	MKTME_ENABLED = 0,
+	MKTME_DISABLED = 1,
+	MKTME_UNINITIALIZED = 2
+};
+
+extern enum mktme_status_type mktme_get_status(void);
+
 #ifdef CONFIG_HOTPLUG_CPU
 extern int arch_register_cpu(int num);
 extern void arch_unregister_cpu(int);
diff --git a/arch/x86/kernel/cpu/intel.c b/arch/x86/kernel/cpu/intel.c
index c25a67a34bd3..134a88685bc3 100644
--- a/arch/x86/kernel/cpu/intel.c
+++ b/arch/x86/kernel/cpu/intel.c
@@ -495,11 +495,7 @@ static void srat_detect_node(struct cpuinfo_x86 *c)
 #define TME_ACTIVATE_CRYPTO_ALGS(x)	((x >> 48) & 0xffff)	/* Bits 63:48 */
 #define TME_ACTIVATE_CRYPTO_AES_XTS_128	1
 
-/* Values for mktme_status (SW only construct) */
-#define MKTME_ENABLED			0
-#define MKTME_DISABLED			1
-#define MKTME_UNINITIALIZED		2
-static int mktme_status = MKTME_UNINITIALIZED;
+static enum mktme_status_type mktme_status = MKTME_UNINITIALIZED;
 
 static void detect_tme(struct cpuinfo_x86 *c)
 {
@@ -1114,6 +1110,12 @@ bool handle_user_split_lock(struct pt_regs *regs, long error_code)
 	return true;
 }
 
+enum mktme_status_type mktme_get_status(void)
+{
+	return mktme_status;
+}
+EXPORT_SYMBOL_GPL(mktme_get_status);
+
 /*
  * This function is called only when switching between tasks with
  * different split-lock detection modes. It sets the MSR for the
diff --git a/drivers/misc/Kconfig b/drivers/misc/Kconfig
index e1b1ba5e2b92..c9715bbdd8e5 100644
--- a/drivers/misc/Kconfig
+++ b/drivers/misc/Kconfig
@@ -456,6 +456,21 @@ config PVPANIC
 	  a paravirtualized device provided by QEMU; it lets a virtual machine
 	  (guest) communicate panic events to the host.
 
+config MKTME_STATUS
+	tristate "MKTME status reading support"
+	depends on X86_64 && SECURITYFS
+	help
+	  This module provides support for reading the MKTME status.
+	  Enable this configuration option to enable reading the MKTME status
+	  from the mktme virtual file in the securityfs filesystem,
+	  under the mktme directory.
+
+	  The MKTME (Multi-Key Total Memory Encryption) status can be
+	  0 (enabled), 1 (disabled), or 3 (uninitialized).
+
+	  To compile this driver as a module, choose M here: the module will
+	  be called mktme_status.
+
 source "drivers/misc/c2port/Kconfig"
 source "drivers/misc/eeprom/Kconfig"
 source "drivers/misc/cb710/Kconfig"
diff --git a/drivers/misc/Makefile b/drivers/misc/Makefile
index c7bd01ac6291..98c971c096a6 100644
--- a/drivers/misc/Makefile
+++ b/drivers/misc/Makefile
@@ -57,3 +57,4 @@ obj-$(CONFIG_PVPANIC)   	+= pvpanic.o
 obj-$(CONFIG_HABANA_AI)		+= habanalabs/
 obj-$(CONFIG_UACCE)		+= uacce/
 obj-$(CONFIG_XILINX_SDFEC)	+= xilinx_sdfec.o
+obj-$(CONFIG_MKTME_STATUS)	+= mktme_status.o
diff --git a/drivers/misc/mktme_status.c b/drivers/misc/mktme_status.c
new file mode 100644
index 000000000000..22c14966b4e9
--- /dev/null
+++ b/drivers/misc/mktme_status.c
@@ -0,0 +1,67 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * MKTME Status driver
+ *
+ * Copyright 2020 (c) Daniel Gutson (daniel.gutson@eclypsium.com)
+ *
+ */
+
+#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
+
+#include <linux/module.h>
+#include <linux/security.h>
+#include <asm/cpu.h>
+
+static struct dentry *mktme_dir;
+static struct dentry *mktme_file;
+
+static ssize_t mktme_status_read(struct file *filp, char __user *buf,
+				 size_t count, loff_t *ppos)
+{
+	/* Buffer size 3 because of the following chars:
+	 *     value \n \0
+	 */
+	char tmp[3];
+
+	sprintf(tmp, "%d\n", (int)mktme_get_status() & 1);
+	return simple_read_from_buffer(buf, count, ppos, tmp, sizeof(tmp));
+}
+
+static const struct file_operations mktme_status_ops = {
+	.read = mktme_status_read,
+};
+
+static int __init mod_init(void)
+{
+	mktme_dir = securityfs_create_dir("mktme", NULL);
+	if (IS_ERR(mktme_dir)) {
+		pr_err("Couldn't create mktme sysfs dir\n");
+		return PTR_ERR(mktme_dir);
+	}
+
+	mktme_file = securityfs_create_file("status", 0600, mktme_dir, NULL,
+					    &mktme_status_ops);
+	if (IS_ERR(mktme_file)) {
+		pr_err("Error creating securityfs file 'status'\n");
+		goto out_file;
+	}
+
+	return 0;
+
+out_file:
+	securityfs_remove(mktme_dir);
+	return PTR_ERR(mktme_file);
+}
+
+static void __exit mod_exit(void)
+{
+	securityfs_remove(mktme_file);
+	securityfs_remove(mktme_dir);
+}
+
+module_init(mod_init);
+module_exit(mod_exit);
+
+MODULE_DESCRIPTION("MKTME Status kernel module");
+MODULE_AUTHOR("Daniel Gutson <daniel.gutson@eclypsium.com>");
+MODULE_LICENSE("GPL");
diff --git a/include/uapi/misc/mktme_status.h b/include/uapi/misc/mktme_status.h
new file mode 100644
index 000000000000..04b992d2757f
--- /dev/null
+++ b/include/uapi/misc/mktme_status.h
@@ -0,0 +1,12 @@
+/* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */
+
+#ifndef __MKTME_STATUS_H__
+#define __MKTME_STATUS_H__
+
+enum mktme_status_type {
+	MKTME_ENABLED = 0,
+	MKTME_DISABLED = 1,
+	MKTME_UNINITIALIZED = 2
+};
+
+#endif /* __MKTME_STATUS_H__ */
-- 
2.25.1

