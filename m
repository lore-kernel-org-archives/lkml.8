Return-Path: <SRS0=3e5Q=77=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E83BFC433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jun 2020 21:02:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BA18D208C7
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jun 2020 21:02:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=eclypsium.com header.i=@eclypsium.com header.b="IlQd8cDQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729469AbgFRVC2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Jun 2020 17:02:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728718AbgFRVC0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Jun 2020 17:02:26 -0400
Received: from mail-qt1-x842.google.com (mail-qt1-x842.google.com [IPv6:2607:f8b0:4864:20::842])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F092FC06174E
        for <linux-kernel@vger.kernel.org>; Thu, 18 Jun 2020 14:02:25 -0700 (PDT)
Received: by mail-qt1-x842.google.com with SMTP id u17so5665437qtq.1
        for <linux-kernel@vger.kernel.org>; Thu, 18 Jun 2020 14:02:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=eclypsium.com; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=jy7GMX1sYqM9QFe7w1sS182kLNcGYmdLGpaHYaHvzsY=;
        b=IlQd8cDQEH5M1UTLX5G3dtqBhO6o6fg2aWBp5+x8JEmc99q+KM40Tu3N8e6E/3fyEF
         29uOP1abhmqu7QT0qwlE7aZ9HocWj2JoWJOaTWV+UpOMRQoS3KCKEk+DSAR8XZR04ZT/
         CdvHvgSiIvYVpmFzLlkjDUj4kJLU02eG6bWrs3hrO9nwZi6qXbLzvRysJdcAdCUFTpYE
         3rgbb4DibfSlFB3bCuIiHCQGihqlYxu08SiL2TMreWj5v7ujBq0QiC75dlYJRE74v6BH
         llakZcSh5HNXawk9UBgD22gHMH4kOuevrSg5qG8uAc8rqObOpfn+5m3ZqlzfWqgCiER/
         jj6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=jy7GMX1sYqM9QFe7w1sS182kLNcGYmdLGpaHYaHvzsY=;
        b=lzU2KmhfUIAxWd/xdDuH8umN+Q6lDJ+Dll5wRpp/eSr7mcG0cjyQNuvWKJwBrhvWf1
         IG25NxW25cg5W9ioZPF1JZh9erymKG8tNmfshvKEWe+c4EfMB3mDVnLfMnGf/fjPwiRt
         O2SG+XkR7pzVnQjvlUEIkO6ZPvqh66eo0f7U5hKlI3xKbwsPZ+td6IPQ9rKZSlrNw9tj
         FY0DbqORFiReS6NDD10gn2tOJint0/dYPJq19zulZzTHoDQ2F9TdX27QxxPq2OYxIlPe
         N+bJKGvJ2jvsjbsK7n+6QBSHjv8sHn11E0HheZU5DLqzJZPF4Lt2dAXsl5rFgSeQDUcB
         pvAg==
X-Gm-Message-State: AOAM532+ynJKo18HfmHEJwSJFFb2xtvXcTzxkhH1ulBGejF7jKH13lak
        Vd7ZN9elCI0fUBRSUNN9PedLnQ==
X-Google-Smtp-Source: ABdhPJytt0ZbHgNan+grDVAJJ1ow+/3P3VvbXLKUZA5OeYrM6fdWzLuphGldqwgJ/HIyOe21FOyhog==
X-Received: by 2002:aed:29c3:: with SMTP id o61mr127355qtd.15.1592514144002;
        Thu, 18 Jun 2020 14:02:24 -0700 (PDT)
Received: from localhost ([190.190.138.51])
        by smtp.gmail.com with ESMTPSA id o6sm4183499qtd.59.2020.06.18.14.02.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 18 Jun 2020 14:02:23 -0700 (PDT)
From:   Daniel Gutson <daniel.gutson@eclypsium.com>
To:     Thomas Gleixner <tglx@linutronix.de>,
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
        linux-kernel@vger.kernel.org, Daniel Gutson <daniel@eclypsium.com>
Subject: [PATCH] Ability to read the MKTME status from userspace
Date:   Thu, 18 Jun 2020 18:02:15 -0300
Message-Id: <20200618210215.23602-1-daniel.gutson@eclypsium.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Daniel Gutson <daniel@eclypsium.com>

The intent of this patch is to provide visibility of the
MKTME status to userspace. This is an important factor for
firmware security related applilcations.

Signed-off-by: Daniel Gutson <daniel@eclypsium.com>
---
 MAINTAINERS                 |  5 +++
 arch/x86/include/asm/cpu.h  |  8 ++++
 arch/x86/kernel/cpu/intel.c | 12 +++---
 drivers/misc/Kconfig        | 11 +++++
 drivers/misc/Makefile       |  1 +
 drivers/misc/mktme_status.c | 81 +++++++++++++++++++++++++++++++++++++
 6 files changed, 113 insertions(+), 5 deletions(-)
 create mode 100644 drivers/misc/mktme_status.c

diff --git a/MAINTAINERS b/MAINTAINERS
index 50659d76976b..dc3b3c0e4701 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -11335,6 +11335,11 @@ W:	https://linuxtv.org
 T:	git git://linuxtv.org/media_tree.git
 F:	drivers/media/radio/radio-miropcm20*
 
+MKTME_STATUS MKTME STATUS READING SUPPORT
+M:	Daniel Gutson <daniel.gutson@eclypsium.com>
+S:	Supported
+F:	drivers/misc/mktme_status.c
+
 MMP SUPPORT
 R:	Lubomir Rintel <lkundrak@v3.sk>
 L:	linux-arm-kernel@lists.infradead.org (moderated for non-subscribers)
diff --git a/arch/x86/include/asm/cpu.h b/arch/x86/include/asm/cpu.h
index dd17c2da1af5..8929c1240135 100644
--- a/arch/x86/include/asm/cpu.h
+++ b/arch/x86/include/asm/cpu.h
@@ -26,6 +26,14 @@ struct x86_cpu {
 	struct cpu cpu;
 };
 
+enum mktme_status_type {
+	MKTME_ENABLED,
+	MKTME_DISABLED,
+	MKTME_UNINITIALIZED
+};
+
+extern enum mktme_status_type get_mktme_status(void);
+
 #ifdef CONFIG_HOTPLUG_CPU
 extern int arch_register_cpu(int num);
 extern void arch_unregister_cpu(int);
diff --git a/arch/x86/kernel/cpu/intel.c b/arch/x86/kernel/cpu/intel.c
index a19a680542ce..1f6054523226 100644
--- a/arch/x86/kernel/cpu/intel.c
+++ b/arch/x86/kernel/cpu/intel.c
@@ -489,11 +489,7 @@ static void srat_detect_node(struct cpuinfo_x86 *c)
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
@@ -1107,6 +1103,12 @@ bool handle_user_split_lock(struct pt_regs *regs, long error_code)
 	return true;
 }
 
+enum mktme_status_type get_mktme_status(void)
+{
+	return mktme_status;
+}
+EXPORT_SYMBOL_GPL(get_mktme_status);
+
 /*
  * This function is called only when switching between tasks with
  * different split-lock detection modes. It sets the MSR for the
diff --git a/drivers/misc/Kconfig b/drivers/misc/Kconfig
index 99e151475d8f..0dc978efbbd5 100644
--- a/drivers/misc/Kconfig
+++ b/drivers/misc/Kconfig
@@ -465,6 +465,17 @@ config PVPANIC
 	  a paravirtualized device provided by QEMU; it lets a virtual machine
 	  (guest) communicate panic events to the host.
 
+config MKTME_STATUS
+	tristate "MKTME status reading support"
+	depends on X86_64 && SECURITYFS
+	help
+	  This driver provides support for reading the MKTME status. The status
+	  can be read from the mktme virtual file in the securityfs filesystem,
+	  under the mktme directory.
+
+	  The MKTME (Multi-Key Total Memory Encryption) status can be
+	  0 (enabled), 1 (disabled), or 3 (uninitialized).
+
 source "drivers/misc/c2port/Kconfig"
 source "drivers/misc/eeprom/Kconfig"
 source "drivers/misc/cb710/Kconfig"
diff --git a/drivers/misc/Makefile b/drivers/misc/Makefile
index 9abf2923d831..f2f02efe34fd 100644
--- a/drivers/misc/Makefile
+++ b/drivers/misc/Makefile
@@ -58,3 +58,4 @@ obj-$(CONFIG_PVPANIC)   	+= pvpanic.o
 obj-$(CONFIG_HABANA_AI)		+= habanalabs/
 obj-$(CONFIG_UACCE)		+= uacce/
 obj-$(CONFIG_XILINX_SDFEC)	+= xilinx_sdfec.o
+obj-$(CONFIG_MKTME_STATUS)	+= mktme_status.o
diff --git a/drivers/misc/mktme_status.c b/drivers/misc/mktme_status.c
new file mode 100644
index 000000000000..795993181e77
--- /dev/null
+++ b/drivers/misc/mktme_status.c
@@ -0,0 +1,81 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * MKTME Status driver
+ *
+ * Copyright 2020 (c) Daniel Gutson (daniel.gutson@eclypsium.com)
+ *
+ * This file is licensed under  the terms of the GNU General Public
+ * License version 2. This program is licensed "as is" without any
+ * warranty of any kind, whether express or implied.
+ */
+
+#include <linux/module.h>
+#include <linux/security.h>
+#include <asm/cpu.h>
+
+#ifdef pr_fmt
+#undef pr_fmt
+#endif
+#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
+
+struct dentry *mktme_dir;
+struct dentry *mktme_file;
+
+/* Buffer to return: always 3 because of the following chars:
+ *     value \n \0
+ */
+#define BUFFER_SIZE 3
+
+static ssize_t mktme_status_read(struct file *filp, char __user *buf,
+				 size_t count, loff_t *ppos)
+{
+	char tmp[BUFFER_SIZE];
+
+	if (*ppos == BUFFER_SIZE)
+		return 0; // nothing else to read
+
+	sprintf(tmp, "%d\n", (int)get_mktme_status() & 1);
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
+		return -1;
+	}
+
+	pr_info("mktme securityfs dir creation successful\n");
+
+	mktme_file = securityfs_create_file("status", 0600, mktme_dir, NULL,
+					    &mktme_status_ops);
+	if (IS_ERR(mktme_file)) {
+		pr_err("Error creating sysfs file bioswe\n");
+		goto out_file;
+	}
+
+	return 0;
+
+out_file:
+	securityfs_remove(mktme_file);
+	securityfs_remove(mktme_dir);
+	return -1;
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
+MODULE_DESCRIPTION("MKTME Status driver");
+MODULE_AUTHOR("Daniel Gutson <daniel.gutson@eclypsium.com>");
+MODULE_LICENSE("GPL");
-- 
2.25.1

