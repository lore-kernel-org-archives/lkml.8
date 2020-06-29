Return-Path: <SRS0=6VGy=AK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97DD3C433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jun 2020 22:59:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4906D206C3
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jun 2020 22:59:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=eclypsium.com header.i=@eclypsium.com header.b="bV7lWMX0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728664AbgF2W7x (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Jun 2020 18:59:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728027AbgF2W7w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jun 2020 18:59:52 -0400
Received: from mail-qv1-xf41.google.com (mail-qv1-xf41.google.com [IPv6:2607:f8b0:4864:20::f41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1E4FC061755
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jun 2020 15:59:51 -0700 (PDT)
Received: by mail-qv1-xf41.google.com with SMTP id h18so8462062qvl.3
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jun 2020 15:59:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=eclypsium.com; s=google;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ry9ScHjhU4Jq+35qnnWyl5PSpYhDV4+s4CT50TdWiiM=;
        b=bV7lWMX0vtP0jASnsBtwX2qtKRxJsbgoJFRNQBn4d6iIdJvFJjTHjOX8aJhgdD8bBl
         NUdaRH+id+uLk7mrwTccIP7N82eJTZGDg6zvXrSLOpkYSVwbiALYdPzG5bjPZf6vCtd3
         tigE9BbEli357xkUHMIJUXbgPe5Vx6pSPKlj1RNb4oGiCpyi+OwP+BxDSqaTKG7xvBXx
         P6Govaqpj24tBMCuMojQf/zIc41GZve+XtvIDS0mZXKh+oWS+GcYI6XSpV/bQm6SLAcU
         j3yINm0ksoN1dnPZ1teC1Xj1f9P2qeqqRSZVU7iTtFspAl+vfTV5jXMIGKvRjrLtJw2q
         /s7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ry9ScHjhU4Jq+35qnnWyl5PSpYhDV4+s4CT50TdWiiM=;
        b=ReKHRsAEdlnW+0WADtJZpNIaCl1ShDyY1YGEvq6U1hkfShoTJyaXSqP7hEJ8U8vHyT
         oJgwVDDyS9WKdrWxLgMGdPHeMnGmWYPrcqmKRkKTZrHa40OY165IW6R//X7OvQvRI//G
         jy46GmVwMfyLRDqt+oueIeMkKInYHO1GvwXCiHvneF1rdpPydhl7FhnubE4z7JEN9yTn
         E82hY04lje1wBcHBWn51zMqASLQA1Q7g+Spx3/inpozFwKC38tQPsl5oag2bjgKeWHul
         6BMRJ3wD/4si+Ef4xRWzw85Q/HdAIXW/DJsMHb6wFUGLuklIsdBQfR5AFU8Pp76Bnq83
         Yb0g==
X-Gm-Message-State: AOAM533+R6WQ79rA1ceP/FTzCFMRalV2Bejd/NaifdZdxVzPe/7F2a4K
        d/gtXcSi1finRKSSENAOoIlqYw==
X-Google-Smtp-Source: ABdhPJz1b76jpY1jJouphyOQVImii3zlgoeXfuC4c0ID8PkKIidbr58OAqOkOhOaCoOqzsooGcGtfQ==
X-Received: by 2002:a0c:8b4a:: with SMTP id d10mr17324570qvc.31.1593471589846;
        Mon, 29 Jun 2020 15:59:49 -0700 (PDT)
Received: from localhost ([190.190.138.51])
        by smtp.gmail.com with ESMTPSA id i10sm1936350qkn.126.2020.06.29.15.59.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 29 Jun 2020 15:59:49 -0700 (PDT)
From:   Daniel Gutson <daniel.gutson@eclypsium.com>
To:     Daniel Gutson <daniel.gutson@eclypsium.com>,
        Derek Kiernan <derek.kiernan@xilinx.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        linux-kernel@vger.kernel.org, Richard Hughes <hughsient@gmail.com>,
        Alex Bazhaniuk <alex@eclypsium.com>
Subject: [PATCH] SPI LPC information kernel module
Date:   Mon, 29 Jun 2020 19:59:32 -0300
Message-Id: <20200629225932.5036-1-daniel.gutson@eclypsium.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This kernel module exports configuration attributes for the
system SPI chip.
This initial version exports the BIOS Write Enable (bioswe),
BIOS Lock Enable (ble), and the SMM Bios Write Protect (SMM_BWP)
fields of the Bios Control register. The idea is to keep adding more
flags, not only from the BC but also from other registers in following
versions.

The goal is that the attributes are avilable to fwupd when SecureBoot
is turned on.

A technical note: I check if *ppos == BUFFER_SIZE in the reading function
to exit early and avoid an extra access to the HW, for example when using
the 'cat' command, which causes two read operations.

Signed-off-by: Daniel Gutson <daniel.gutson@eclypsium.com>
---
 Documentation/ABI/stable/securityfs-spi-lpc |  23 +
 MAINTAINERS                                 |   6 +
 drivers/misc/Kconfig                        |   1 +
 drivers/misc/Makefile                       |   1 +
 drivers/misc/spi_lpc/Kconfig                |  20 +
 drivers/misc/spi_lpc/Makefile               |   8 +
 drivers/misc/spi_lpc/bios_data_access.c     | 559 +++++++++++++++++++
 drivers/misc/spi_lpc/bios_data_access.h     | 181 +++++++
 drivers/misc/spi_lpc/low_level_access.c     |  59 ++
 drivers/misc/spi_lpc/low_level_access.h     |  21 +
 drivers/misc/spi_lpc/spi_lpc_main.c         | 176 ++++++
 drivers/misc/spi_lpc/viddid_arch_map.c      | 566 ++++++++++++++++++++
 drivers/misc/spi_lpc/viddid_arch_map.h      |  17 +
 13 files changed, 1638 insertions(+)
 create mode 100644 Documentation/ABI/stable/securityfs-spi-lpc
 create mode 100644 drivers/misc/spi_lpc/Kconfig
 create mode 100644 drivers/misc/spi_lpc/Makefile
 create mode 100644 drivers/misc/spi_lpc/bios_data_access.c
 create mode 100644 drivers/misc/spi_lpc/bios_data_access.h
 create mode 100644 drivers/misc/spi_lpc/low_level_access.c
 create mode 100644 drivers/misc/spi_lpc/low_level_access.h
 create mode 100644 drivers/misc/spi_lpc/spi_lpc_main.c
 create mode 100644 drivers/misc/spi_lpc/viddid_arch_map.c
 create mode 100644 drivers/misc/spi_lpc/viddid_arch_map.h

diff --git a/Documentation/ABI/stable/securityfs-spi-lpc b/Documentation/ABI/stable/securityfs-spi-lpc
new file mode 100644
index 000000000000..22660a7fd914
--- /dev/null
+++ b/Documentation/ABI/stable/securityfs-spi-lpc
@@ -0,0 +1,23 @@
+What:		/sys/kernel/security/firmware/bioswe
+Date:		June 2020
+KernelVersion:	5.8.0
+Contact:	daniel.gutson@eclypsium.com
+Description:	If the system firmware set BIOS Write Enable.
+		0: writes disabled, 1: writes enabled.
+Users:		https://github.com/fwupd/fwupd
+
+What:		/sys/kernel/security/firmware/ble
+Date:		June 2020
+KernelVersion:	5.8.0
+Contact:	daniel.gutson@eclypsium.com
+Description:	If the system firmware set Bios Lock Enable.
+		0: SMM lock disabled, 1: SMM lock enabled.
+Users:		https://github.com/fwupd/fwupd
+
+What:		/sys/kernel/security/firmware/smm_bwp
+Date:		June 2020
+KernelVersion:	5.8.0
+Contact:	daniel.gutson@eclypsium.com
+Description:	If the system firmware set SMM Bios Write Protect.
+		0: writes disabled unless in SMM, 1: writes enabled.
+Users:		https://github.com/fwupd/fwupd
diff --git a/MAINTAINERS b/MAINTAINERS
index 7b5ffd646c6b..d7b7f943cb75 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -16078,6 +16078,12 @@ W:	http://www.st.com/spear
 F:	arch/arm/boot/dts/spear*
 F:	arch/arm/mach-spear/
 
+SPI LPC information kernel MODULE
+M:	Daniel Gutson <daniel.gutson@eclypsium.com>
+S:	Supported
+F:	Documentation/ABI/stable/securityfs-spi-lpc
+F:	drivers/misc/spi_lpc/*
+
 SPI NOR SUBSYSTEM
 M:	Tudor Ambarus <tudor.ambarus@microchip.com>
 L:	linux-mtd@lists.infradead.org
diff --git a/drivers/misc/Kconfig b/drivers/misc/Kconfig
index e1b1ba5e2b92..228ceeb3d389 100644
--- a/drivers/misc/Kconfig
+++ b/drivers/misc/Kconfig
@@ -472,4 +472,5 @@ source "drivers/misc/ocxl/Kconfig"
 source "drivers/misc/cardreader/Kconfig"
 source "drivers/misc/habanalabs/Kconfig"
 source "drivers/misc/uacce/Kconfig"
+source "drivers/misc/spi_lpc/Kconfig"
 endmenu
diff --git a/drivers/misc/Makefile b/drivers/misc/Makefile
index c7bd01ac6291..280365e7e53c 100644
--- a/drivers/misc/Makefile
+++ b/drivers/misc/Makefile
@@ -57,3 +57,4 @@ obj-$(CONFIG_PVPANIC)   	+= pvpanic.o
 obj-$(CONFIG_HABANA_AI)		+= habanalabs/
 obj-$(CONFIG_UACCE)		+= uacce/
 obj-$(CONFIG_XILINX_SDFEC)	+= xilinx_sdfec.o
+obj-$(CONFIG_SPI_LPC)		+= spi_lpc/
diff --git a/drivers/misc/spi_lpc/Kconfig b/drivers/misc/spi_lpc/Kconfig
new file mode 100644
index 000000000000..08d74746578d
--- /dev/null
+++ b/drivers/misc/spi_lpc/Kconfig
@@ -0,0 +1,20 @@
+# SPDX-License-Identifier: GPL-2.0-only
+#
+# SPI LPC information kernel module
+#
+
+config SPI_LPC
+	tristate "SPI LPC information"
+	depends on SECURITYFS && CPU_SUP_INTEL
+	help
+	  This kernel modules exports the configuration attributes for the
+	  system SPI chip.
+	  Enable this kernel module to read the BIOSWE, BLE, and SMM_BWP fields
+	  of the Bios Control register, by reading these three files:
+
+    	      /sys/kernel/security/firmware/bioswe
+    	      /sys/kernel/security/firmware/ble
+    	      /sys/kernel/security/firmware/smm_bwp
+
+	  To compile this driver as a module, choose M here: the
+	  module will be called spi_lpc.
diff --git a/drivers/misc/spi_lpc/Makefile b/drivers/misc/spi_lpc/Makefile
new file mode 100644
index 000000000000..65f314d37164
--- /dev/null
+++ b/drivers/misc/spi_lpc/Makefile
@@ -0,0 +1,8 @@
+# SPDX-License-Identifier: GPL-2.0-only
+#
+# Makefile for the SPI LPC kernel module
+#
+
+obj-m	:= spi_lpc.o
+
+spi_lpc-y := spi_lpc_main.o bios_data_access.o low_level_access.o viddid_arch_map.o
diff --git a/drivers/misc/spi_lpc/bios_data_access.c b/drivers/misc/spi_lpc/bios_data_access.c
new file mode 100644
index 000000000000..9c5932ad6d61
--- /dev/null
+++ b/drivers/misc/spi_lpc/bios_data_access.c
@@ -0,0 +1,559 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * SPI LPC flash platform security driver
+ *
+ * Copyright 2020 (c) Daniel Gutson (daniel.gutson@eclypsium.com)
+ *
+ */
+#include <linux/module.h>
+#include "low_level_access.h"
+#include "bios_data_access.h"
+
+#define get_mask_from_bit_size(type, size)                                     \
+	(((type) ~((type)0)) >> (sizeof(type) * 8 - size))
+
+#define get_mask_from_bit_size_with_offset(type, size, offset)                 \
+	(get_mask_from_bit_size(type, size) << (offset))
+
+#define extract_bits(type, value, start, size)                                 \
+	((value)&get_mask_from_bit_size_with_offset(type, size, start))
+
+#define extract_bits_shifted(type, value, start, size)                         \
+	(extract_bits(type, value, start, size) >> (start))
+
+static int read_spibar(enum PCH_Arch pch_arch, enum CPU_Arch cpu_arch,
+		       u64 *offset);
+
+static int read_sbase_atom_avn_byt(struct sbase_atom_avn_byt *reg)
+{
+	u32 value;
+	const int ret = pci_read_dword(&value, 0x0, 0x1f, 0x0, 0x54);
+
+	if (ret != 0)
+		return ret;
+
+	reg->memi = extract_bits_shifted(u32, value, 0, 1);
+	reg->enable = extract_bits_shifted(u32, value, 1, 1);
+	reg->addrng = extract_bits_shifted(u32, value, 2, 1);
+	reg->pref = extract_bits_shifted(u32, value, 3, 1);
+	reg->base = extract_bits(u32, value, 9, 23);
+
+	return 0;
+}
+
+int spi_read_sbase(enum PCH_Arch pch_arch __maybe_unused,
+		   enum CPU_Arch cpu_arch, struct spi_sbase *reg)
+{
+	int ret = 0;
+
+	reg->register_arch.source = RegSource_CPU;
+	reg->register_arch.cpu_arch = cpu_arch;
+
+	switch (cpu_arch) {
+	case cpu_avn:
+	case cpu_byt:
+		ret = read_sbase_atom_avn_byt(&reg->cpu_byt);
+		break;
+	default:
+		ret = -EIO;
+	}
+	return ret;
+}
+EXPORT_SYMBOL_GPL(spi_read_sbase);
+
+static int read_bc_pch_3xx_4xx_5xx(struct bc_pch_3xx_4xx_5xx *reg)
+{
+	u32 value;
+	const int ret = pci_read_dword(&value, 0x0, 0x1f, 0x5, 0xdc);
+
+	if (ret != 0)
+		return ret;
+
+	reg->bioswe = extract_bits_shifted(u32, value, 0, 1);
+	reg->ble = extract_bits_shifted(u32, value, 1, 1);
+	reg->src = extract_bits_shifted(u32, value, 2, 2);
+	reg->tss = extract_bits_shifted(u32, value, 4, 1);
+	reg->smm_bwp = extract_bits_shifted(u32, value, 5, 1);
+	reg->bbs = extract_bits_shifted(u32, value, 6, 1);
+	reg->bild = extract_bits_shifted(u32, value, 7, 1);
+	reg->spi_sync_ss = extract_bits_shifted(u32, value, 8, 1);
+	reg->spi_async_ss = extract_bits_shifted(u32, value, 10, 1);
+	reg->ase_bwp = extract_bits_shifted(u32, value, 11, 1);
+
+	return 0;
+}
+
+static int
+read_bc_cpu_snb_jkt_ivb_ivt_bdx_hsx(struct bc_cpu_snb_jkt_ivb_ivt_bdx_hsx *reg)
+{
+	u32 value;
+	const int ret = pci_read_dword(&value, 0x0, 0x1f, 0x5, 0xdc);
+
+	if (ret != 0)
+		return ret;
+
+	reg->bioswe = extract_bits_shifted(u32, value, 0, 1);
+	reg->ble = extract_bits_shifted(u32, value, 1, 1);
+	reg->src = extract_bits_shifted(u32, value, 2, 2);
+	reg->tss = extract_bits_shifted(u32, value, 4, 1);
+	reg->smm_bwp = extract_bits_shifted(u32, value, 5, 1);
+
+	return 0;
+}
+
+static int read_bc_cpu_skl_kbl_cfl(struct bc_cpu_skl_kbl_cfl *reg)
+{
+	u32 value;
+	const int ret = pci_read_dword(&value, 0x0, 0x1f, 0x5, 0xdc);
+
+	if (ret != 0)
+		return ret;
+
+	reg->bioswe = extract_bits_shifted(u32, value, 0, 1);
+	reg->ble = extract_bits_shifted(u32, value, 1, 1);
+	reg->src = extract_bits_shifted(u32, value, 2, 2);
+	reg->tss = extract_bits_shifted(u32, value, 4, 1);
+	reg->smm_bwp = extract_bits_shifted(u32, value, 5, 1);
+	reg->bbs = extract_bits_shifted(u32, value, 6, 1);
+	reg->bild = extract_bits_shifted(u32, value, 7, 1);
+
+	return 0;
+}
+
+static int read_bc_cpu_apl_glk(struct bc_cpu_apl_glk *reg)
+{
+	u32 value;
+	const int ret = pci_read_dword(&value, 0x0, 0xd, 0x2, 0xdc);
+
+	if (ret != 0)
+		return ret;
+
+	reg->bioswe = extract_bits_shifted(u32, value, 0, 1);
+	reg->ble = extract_bits_shifted(u32, value, 1, 1);
+	reg->src = extract_bits_shifted(u32, value, 2, 2);
+	reg->tss = extract_bits_shifted(u32, value, 4, 1);
+	reg->smm_bwp = extract_bits_shifted(u32, value, 5, 1);
+	reg->bbs = extract_bits_shifted(u32, value, 6, 1);
+	reg->bild = extract_bits_shifted(u32, value, 7, 1);
+	reg->spi_sync_ss = extract_bits_shifted(u32, value, 8, 1);
+	reg->osfh = extract_bits_shifted(u32, value, 9, 1);
+	reg->spi_async_ss = extract_bits_shifted(u32, value, 10, 1);
+	reg->ase_bwp = extract_bits_shifted(u32, value, 11, 1);
+
+	return 0;
+}
+
+static int read_bc_cpu_atom_avn(struct bc_cpu_atom_avn *reg,
+				enum PCH_Arch pch_arch, enum CPU_Arch cpu_arch)
+{
+	u8 value;
+	int ret;
+	u64 barOffset;
+
+	ret = read_spibar(pch_arch, cpu_arch, &barOffset);
+	if (ret != 0)
+		return ret;
+
+	ret = mmio_read_byte(barOffset + 0xfc, &value);
+	if (ret != 0)
+		return ret;
+
+	reg->bioswe = extract_bits_shifted(u8, value, 0, 1);
+	reg->ble = extract_bits_shifted(u8, value, 1, 1);
+	reg->src = extract_bits_shifted(u8, value, 2, 2);
+	reg->tss = extract_bits_shifted(u8, value, 4, 1);
+	reg->smm_bwp = extract_bits_shifted(u8, value, 5, 1);
+
+	return 0;
+}
+
+static int read_bc_cpu_atom_byt(struct bc_cpu_atom_byt *reg,
+				enum PCH_Arch pch_arch, enum CPU_Arch cpu_arch)
+{
+	u32 value;
+	int ret;
+	u64 barOffset;
+
+	ret = read_spibar(pch_arch, cpu_arch, &barOffset);
+	if (ret != 0)
+		return ret;
+
+	ret = mmio_read_dword(barOffset + 0xfc, &value);
+	if (ret != 0)
+		return ret;
+
+	reg->bioswe = extract_bits_shifted(u32, value, 0, 1);
+	reg->ble = extract_bits_shifted(u32, value, 1, 1);
+	reg->src = extract_bits_shifted(u32, value, 2, 2);
+	reg->smm_bwp = extract_bits_shifted(u32, value, 5, 1);
+
+	return 0;
+}
+
+int spi_read_bc(enum PCH_Arch pch_arch, enum CPU_Arch cpu_arch,
+		struct spi_bc *reg)
+{
+	int ret = 0;
+
+	reg->register_arch.source = RegSource_PCH;
+	reg->register_arch.pch_arch = pch_arch;
+
+	switch (pch_arch) {
+	case pch_3xx:
+	case pch_4xx:
+	case pch_495:
+	case pch_5xx:
+		ret = read_bc_pch_3xx_4xx_5xx(&reg->pch_5xx);
+		break;
+	default:
+		reg->register_arch.source = RegSource_CPU;
+		reg->register_arch.cpu_arch = cpu_arch;
+
+		switch (cpu_arch) {
+		case cpu_snb:
+		case cpu_jkt:
+		case cpu_ivb:
+		case cpu_ivt:
+		case cpu_bdw:
+		case cpu_bdx:
+		case cpu_hsx:
+		case cpu_hsw:
+			ret = read_bc_cpu_snb_jkt_ivb_ivt_bdx_hsx(
+				&reg->cpu_hsw);
+			break;
+		case cpu_skl:
+		case cpu_kbl:
+		case cpu_cfl:
+			ret = read_bc_cpu_skl_kbl_cfl(&reg->cpu_cfl);
+			break;
+		case cpu_apl:
+		case cpu_glk:
+			ret = read_bc_cpu_apl_glk(&reg->cpu_glk);
+			break;
+		case cpu_avn:
+			ret = read_bc_cpu_atom_avn(&reg->cpu_avn, pch_arch,
+						   cpu_arch);
+			break;
+		case cpu_byt:
+			ret = read_bc_cpu_atom_byt(&reg->cpu_byt, pch_arch,
+						   cpu_arch);
+			break;
+		default:
+			ret = -EIO;
+		}
+	}
+	return ret;
+}
+EXPORT_SYMBOL_GPL(spi_read_bc);
+
+int read_spibar(enum PCH_Arch pch_arch, enum CPU_Arch cpu_arch, u64 *offset)
+{
+	int ret = 0;
+	u64 field_offset;
+
+	switch (cpu_arch) {
+	case cpu_avn:
+	case cpu_byt: {
+		struct spi_sbase reg;
+
+		ret = spi_read_sbase(pch_arch, cpu_arch, &reg);
+		if (ret == 0) {
+			ret = spi_read_sbase_base(&reg, &field_offset);
+			*offset = field_offset + 0;
+		}
+	} break;
+	default:
+		ret = -EIO;
+	}
+
+	return ret;
+}
+
+int spi_read_bc_bioswe(const struct spi_bc *reg, u64 *value)
+{
+	int ret = 0;
+
+	switch (reg->register_arch.source) {
+	case RegSource_PCH:
+		switch (reg->register_arch.pch_arch) {
+		case pch_3xx:
+			*value = reg->pch_3xx.bioswe;
+			break;
+		case pch_4xx:
+			*value = reg->pch_4xx.bioswe;
+			break;
+		case pch_495:
+			*value = reg->pch_495.bioswe;
+			break;
+		case pch_5xx:
+			*value = reg->pch_5xx.bioswe;
+			break;
+		default:
+			/* requested PCH arch hasn't field bioswe */
+			ret = -EIO;
+			*value = 0;
+		}
+		break;
+	case RegSource_CPU:
+		switch (reg->register_arch.cpu_arch) {
+		case cpu_snb:
+			*value = reg->cpu_snb.bioswe;
+			break;
+		case cpu_jkt:
+			*value = reg->cpu_jkt.bioswe;
+			break;
+		case cpu_ivb:
+			*value = reg->cpu_ivb.bioswe;
+			break;
+		case cpu_ivt:
+			*value = reg->cpu_ivt.bioswe;
+			break;
+		case cpu_bdw:
+			*value = reg->cpu_bdw.bioswe;
+			break;
+		case cpu_bdx:
+			*value = reg->cpu_bdx.bioswe;
+			break;
+		case cpu_hsx:
+			*value = reg->cpu_hsx.bioswe;
+			break;
+		case cpu_hsw:
+			*value = reg->cpu_hsw.bioswe;
+			break;
+		case cpu_skl:
+			*value = reg->cpu_skl.bioswe;
+			break;
+		case cpu_kbl:
+			*value = reg->cpu_kbl.bioswe;
+			break;
+		case cpu_cfl:
+			*value = reg->cpu_cfl.bioswe;
+			break;
+		case cpu_apl:
+			*value = reg->cpu_apl.bioswe;
+			break;
+		case cpu_glk:
+			*value = reg->cpu_glk.bioswe;
+			break;
+		case cpu_avn:
+			*value = reg->cpu_avn.bioswe;
+			break;
+		case cpu_byt:
+			*value = reg->cpu_byt.bioswe;
+			break;
+		default:
+			/* requested CPU arch hasn't field bioswe */
+			ret = -EIO;
+			*value = 0;
+		}
+		break;
+	default:
+		ret = -EIO; /* should not reach here, it's a bug */
+		*value = 0;
+	}
+	return ret;
+}
+EXPORT_SYMBOL_GPL(spi_read_bc_bioswe);
+
+int spi_read_bc_ble(const struct spi_bc *reg, u64 *value)
+{
+	int ret = 0;
+
+	switch (reg->register_arch.source) {
+	case RegSource_PCH:
+		switch (reg->register_arch.pch_arch) {
+		case pch_3xx:
+			*value = reg->pch_3xx.ble;
+			break;
+		case pch_4xx:
+			*value = reg->pch_4xx.ble;
+			break;
+		case pch_495:
+			*value = reg->pch_495.ble;
+			break;
+		case pch_5xx:
+			*value = reg->pch_5xx.ble;
+			break;
+		default:
+			/* requested PCH arch hasn't field ble */
+			ret = -EIO;
+			*value = 0;
+		}
+		break;
+	case RegSource_CPU:
+		switch (reg->register_arch.cpu_arch) {
+		case cpu_snb:
+			*value = reg->cpu_snb.ble;
+			break;
+		case cpu_jkt:
+			*value = reg->cpu_jkt.ble;
+			break;
+		case cpu_ivb:
+			*value = reg->cpu_ivb.ble;
+			break;
+		case cpu_ivt:
+			*value = reg->cpu_ivt.ble;
+			break;
+		case cpu_bdw:
+			*value = reg->cpu_bdw.ble;
+			break;
+		case cpu_bdx:
+			*value = reg->cpu_bdx.ble;
+			break;
+		case cpu_hsx:
+			*value = reg->cpu_hsx.ble;
+			break;
+		case cpu_hsw:
+			*value = reg->cpu_hsw.ble;
+			break;
+		case cpu_skl:
+			*value = reg->cpu_skl.ble;
+			break;
+		case cpu_kbl:
+			*value = reg->cpu_kbl.ble;
+			break;
+		case cpu_cfl:
+			*value = reg->cpu_cfl.ble;
+			break;
+		case cpu_apl:
+			*value = reg->cpu_apl.ble;
+			break;
+		case cpu_glk:
+			*value = reg->cpu_glk.ble;
+			break;
+		case cpu_avn:
+			*value = reg->cpu_avn.ble;
+			break;
+		case cpu_byt:
+			*value = reg->cpu_byt.ble;
+			break;
+		default:
+			/* requested CPU arch hasn't field ble */
+			ret = -EIO;
+			*value = 0;
+		}
+		break;
+	default:
+		ret = -EIO; /* should not reach here, it's a bug */
+		*value = 0;
+	}
+	return ret;
+}
+EXPORT_SYMBOL_GPL(spi_read_bc_ble);
+
+int spi_read_bc_smm_bwp(const struct spi_bc *reg, u64 *value)
+{
+	int ret = 0;
+
+	switch (reg->register_arch.source) {
+	case RegSource_PCH:
+		switch (reg->register_arch.pch_arch) {
+		case pch_3xx:
+			*value = reg->pch_3xx.smm_bwp;
+			break;
+		case pch_4xx:
+			*value = reg->pch_4xx.smm_bwp;
+			break;
+		case pch_495:
+			*value = reg->pch_495.smm_bwp;
+			break;
+		case pch_5xx:
+			*value = reg->pch_5xx.smm_bwp;
+			break;
+		default:
+			/* requested PCH arch hasn't field smm_bwp */
+			ret = -EIO;
+			*value = 0;
+		}
+		break;
+	case RegSource_CPU:
+		switch (reg->register_arch.cpu_arch) {
+		case cpu_snb:
+			*value = reg->cpu_snb.smm_bwp;
+			break;
+		case cpu_jkt:
+			*value = reg->cpu_jkt.smm_bwp;
+			break;
+		case cpu_ivb:
+			*value = reg->cpu_ivb.smm_bwp;
+			break;
+		case cpu_ivt:
+			*value = reg->cpu_ivt.smm_bwp;
+			break;
+		case cpu_bdw:
+			*value = reg->cpu_bdw.smm_bwp;
+			break;
+		case cpu_bdx:
+			*value = reg->cpu_bdx.smm_bwp;
+			break;
+		case cpu_hsx:
+			*value = reg->cpu_hsx.smm_bwp;
+			break;
+		case cpu_hsw:
+			*value = reg->cpu_hsw.smm_bwp;
+			break;
+		case cpu_skl:
+			*value = reg->cpu_skl.smm_bwp;
+			break;
+		case cpu_kbl:
+			*value = reg->cpu_kbl.smm_bwp;
+			break;
+		case cpu_cfl:
+			*value = reg->cpu_cfl.smm_bwp;
+			break;
+		case cpu_apl:
+			*value = reg->cpu_apl.smm_bwp;
+			break;
+		case cpu_glk:
+			*value = reg->cpu_glk.smm_bwp;
+			break;
+		case cpu_avn:
+			*value = reg->cpu_avn.smm_bwp;
+			break;
+		case cpu_byt:
+			*value = reg->cpu_byt.smm_bwp;
+			break;
+		default:
+			/* requested CPU arch hasn't field smm_bwp */
+			ret = -EIO;
+			*value = 0;
+		}
+		break;
+	default:
+		ret = -EIO; /* should not reach here, it's a bug */
+		*value = 0;
+	}
+	return ret;
+}
+EXPORT_SYMBOL_GPL(spi_read_bc_smm_bwp);
+
+int spi_read_sbase_base(const struct spi_sbase *reg, u64 *value)
+{
+	int ret = 0;
+
+	switch (reg->register_arch.source) {
+	case RegSource_PCH:
+		ret = -EIO; /* no PCH archs have this field */
+		*value = 0;
+		break;
+	case RegSource_CPU:
+		switch (reg->register_arch.cpu_arch) {
+		case cpu_avn:
+			*value = reg->cpu_avn.base;
+			break;
+		case cpu_byt:
+			*value = reg->cpu_byt.base;
+			break;
+		default:
+			/* requested CPU arch hasn't field base */
+			ret = -EIO;
+			*value = 0;
+		}
+		break;
+	default:
+		ret = -EIO; /* should not reach here, it's a bug */
+		*value = 0;
+	}
+	return ret;
+}
+EXPORT_SYMBOL_GPL(spi_read_sbase_base);
diff --git a/drivers/misc/spi_lpc/bios_data_access.h b/drivers/misc/spi_lpc/bios_data_access.h
new file mode 100644
index 000000000000..a97da7d9f6be
--- /dev/null
+++ b/drivers/misc/spi_lpc/bios_data_access.h
@@ -0,0 +1,181 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * SPI LPC flash platform security driver
+ *
+ * Copyright 2020 (c) Daniel Gutson (daniel.gutson@eclypsium.com)
+ *
+ */
+#ifndef BIOS_DATA_ACCESS_H
+#define BIOS_DATA_ACCESS_H
+
+#include <linux/types.h>
+
+enum PCH_Arch {
+	pch_none,
+	pch_6_c200,
+	pch_7_c210,
+	pch_c60x_x79,
+	pch_communications_89xx,
+	pch_8_c220,
+	pch_c61x_x99,
+	pch_5_mobile,
+	pch_6_mobile,
+	pch_7_8_mobile,
+	pch_1xx,
+	pch_c620,
+	pch_2xx,
+	pch_3xx,
+	pch_4xx,
+	pch_495,
+	pch_5xx,
+	PCH_Archs_count
+};
+
+enum CPU_Arch {
+	cpu_none,
+	cpu_bdw,
+	cpu_bdx,
+	cpu_hsw,
+	cpu_hsx,
+	cpu_ivt,
+	cpu_jkt,
+	cpu_kbl,
+	cpu_skl,
+	cpu_ivb,
+	cpu_snb,
+	cpu_avn,
+	cpu_cfl,
+	cpu_byt,
+	cpu_whl,
+	cpu_cml,
+	cpu_icl,
+	cpu_apl,
+	cpu_glk,
+	cpu_tgl,
+	cpu_amd,
+	CPU_Archs_count
+};
+
+enum RegisterSource { RegSource_PCH, RegSource_CPU };
+
+struct RegisterArch {
+	enum RegisterSource source;
+
+	union {
+		enum PCH_Arch pch_arch;
+		enum CPU_Arch cpu_arch;
+	};
+};
+
+struct sbase_atom_avn_byt {
+	u64 memi;
+	u64 enable;
+	u64 addrng;
+	u64 pref;
+	u64 base;
+};
+
+struct spi_sbase {
+	struct RegisterArch register_arch;
+
+	union {
+		struct sbase_atom_avn_byt cpu_avn;
+		struct sbase_atom_avn_byt cpu_byt;
+	};
+};
+
+struct bc_pch_3xx_4xx_5xx {
+	u64 bioswe;
+	u64 ble;
+	u64 src;
+	u64 tss;
+	u64 smm_bwp;
+	u64 bbs;
+	u64 bild;
+	u64 spi_sync_ss;
+	u64 spi_async_ss;
+	u64 ase_bwp;
+};
+
+struct bc_cpu_snb_jkt_ivb_ivt_bdx_hsx {
+	u64 bioswe;
+	u64 ble;
+	u64 src;
+	u64 tss;
+	u64 smm_bwp;
+};
+
+struct bc_cpu_skl_kbl_cfl {
+	u64 bioswe;
+	u64 ble;
+	u64 src;
+	u64 tss;
+	u64 smm_bwp;
+	u64 bbs;
+	u64 bild;
+};
+
+struct bc_cpu_apl_glk {
+	u64 bioswe;
+	u64 ble;
+	u64 src;
+	u64 tss;
+	u64 smm_bwp;
+	u64 bbs;
+	u64 bild;
+	u64 spi_sync_ss;
+	u64 osfh;
+	u64 spi_async_ss;
+	u64 ase_bwp;
+};
+
+struct bc_cpu_atom_avn {
+	u64 bioswe;
+	u64 ble;
+	u64 src;
+	u64 tss;
+	u64 smm_bwp;
+};
+
+struct bc_cpu_atom_byt {
+	u64 bioswe;
+	u64 ble;
+	u64 src;
+	u64 smm_bwp;
+};
+
+struct spi_bc {
+	struct RegisterArch register_arch;
+
+	union {
+		struct bc_pch_3xx_4xx_5xx pch_3xx;
+		struct bc_pch_3xx_4xx_5xx pch_4xx;
+		struct bc_pch_3xx_4xx_5xx pch_495;
+		struct bc_pch_3xx_4xx_5xx pch_5xx;
+		struct bc_cpu_snb_jkt_ivb_ivt_bdx_hsx cpu_snb;
+		struct bc_cpu_snb_jkt_ivb_ivt_bdx_hsx cpu_jkt;
+		struct bc_cpu_snb_jkt_ivb_ivt_bdx_hsx cpu_ivb;
+		struct bc_cpu_snb_jkt_ivb_ivt_bdx_hsx cpu_ivt;
+		struct bc_cpu_snb_jkt_ivb_ivt_bdx_hsx cpu_bdw;
+		struct bc_cpu_snb_jkt_ivb_ivt_bdx_hsx cpu_bdx;
+		struct bc_cpu_snb_jkt_ivb_ivt_bdx_hsx cpu_hsx;
+		struct bc_cpu_snb_jkt_ivb_ivt_bdx_hsx cpu_hsw;
+		struct bc_cpu_skl_kbl_cfl cpu_skl;
+		struct bc_cpu_skl_kbl_cfl cpu_kbl;
+		struct bc_cpu_skl_kbl_cfl cpu_cfl;
+		struct bc_cpu_apl_glk cpu_apl;
+		struct bc_cpu_apl_glk cpu_glk;
+		struct bc_cpu_atom_avn cpu_avn;
+		struct bc_cpu_atom_byt cpu_byt;
+	};
+};
+
+extern int spi_read_sbase(enum PCH_Arch pch_arch, enum CPU_Arch cpu_arch,
+			  struct spi_sbase *reg);
+extern int spi_read_bc(enum PCH_Arch pch_arch, enum CPU_Arch cpu_arch,
+		       struct spi_bc *reg);
+extern int spi_read_bc_bioswe(const struct spi_bc *reg, u64 *value);
+extern int spi_read_bc_ble(const struct spi_bc *reg, u64 *value);
+extern int spi_read_bc_smm_bwp(const struct spi_bc *reg, u64 *value);
+extern int spi_read_sbase_base(const struct spi_sbase *reg, u64 *value);
+#endif /* BIOS_DATA_ACCESS_H */
diff --git a/drivers/misc/spi_lpc/low_level_access.c b/drivers/misc/spi_lpc/low_level_access.c
new file mode 100644
index 000000000000..9d3ce9e69b8c
--- /dev/null
+++ b/drivers/misc/spi_lpc/low_level_access.c
@@ -0,0 +1,59 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * SPI LPC flash platform security driver
+ *
+ * Copyright 2020 (c) Daniel Gutson (daniel.gutson@eclypsium.com)
+ */
+
+#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
+
+#include <linux/version.h>
+#include <linux/pci.h>
+#include "low_level_access.h"
+
+#define GENERIC_MMIO_READ(Type, Suffix, function)                              \
+	int mmio_read_##Suffix(u64 phys_address, Type *value)                  \
+	{                                                                      \
+		int ret = 0;                                                   \
+		void __iomem *mapped_address =                                 \
+			ioremap(phys_address, sizeof(Type));                   \
+		pr_debug("Reading MMIO 0x%llx 0x%lx\n", phys_address,          \
+			 sizeof(Type));                                        \
+		if (mapped_address != NULL) {                                  \
+			*value = function(mapped_address);                     \
+			iounmap(mapped_address);                               \
+		} else {                                                       \
+			pr_err("Failed to MAP IO memory: 0x%llx\n",            \
+			       phys_address);                                  \
+			ret = -EIO;                                            \
+		}                                                              \
+		return ret;                                                    \
+	}
+GENERIC_MMIO_READ(u8, byte, readb)
+GENERIC_MMIO_READ(u16, word, readw)
+GENERIC_MMIO_READ(u32, dword, readl)
+#undef GENERIC_MMIO_READ
+
+#define GENERIC_PCI_READ(Suffix, Type)                                         \
+	int pci_read_##Suffix(Type *value, u64 bus, u64 device, u64 function,  \
+			      u64 offset)                                      \
+	{                                                                      \
+		int ret;                                                       \
+		struct pci_bus *found_bus = pci_find_bus(0, bus);              \
+		pr_debug("Reading PCI 0x%llx 0x%llx 0x%llx 0x%llx\n", bus,     \
+			 device, function, offset);                            \
+		if (found_bus != NULL) {                                       \
+			ret = pci_bus_read_config_##Suffix(                    \
+				found_bus, PCI_DEVFN(device, function),        \
+				offset, value);                                \
+		} else {                                                       \
+			pr_err("Couldn't find Bus 0x%llx\n", bus);             \
+			ret = -EIO;                                            \
+		}                                                              \
+		return ret;                                                    \
+	}
+
+GENERIC_PCI_READ(byte, u8)
+GENERIC_PCI_READ(word, u16)
+GENERIC_PCI_READ(dword, u32)
+#undef GENERIC_PCI_READ
diff --git a/drivers/misc/spi_lpc/low_level_access.h b/drivers/misc/spi_lpc/low_level_access.h
new file mode 100644
index 000000000000..499ca1d84678
--- /dev/null
+++ b/drivers/misc/spi_lpc/low_level_access.h
@@ -0,0 +1,21 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * SPI LPC flash platform security driver
+ *
+ * Copyright 2020 (c) Daniel Gutson (daniel.gutson@eclypsium.com)
+ */
+
+#ifndef LOW_LEVEL_H
+#define LOW_LEVEL_H
+
+#include <linux/types.h>
+
+int pci_read_byte(u8 *value, u64 bus, u64 device, u64 function, u64 offset);
+int pci_read_word(u16 *value, u64 bus, u64 device, u64 function, u64 offset);
+int pci_read_dword(u32 *value, u64 bus, u64 device, u64 function, u64 offset);
+
+int mmio_read_byte(u64 phys_address, u8 *value);
+int mmio_read_word(u64 phys_address, u16 *value);
+int mmio_read_dword(u64 phys_address, u32 *value);
+
+#endif /* LOW_LEVEL_H */
diff --git a/drivers/misc/spi_lpc/spi_lpc_main.c b/drivers/misc/spi_lpc/spi_lpc_main.c
new file mode 100644
index 000000000000..d83ee1eb9768
--- /dev/null
+++ b/drivers/misc/spi_lpc/spi_lpc_main.c
@@ -0,0 +1,176 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * SPI LPC flash platform security driver
+ *
+ * Copyright 2020 (c) Richard Hughes (richard@hughsie.com)
+ *                    Daniel Gutson (daniel.gutson@eclypsium.com)
+ */
+
+#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
+
+#include <linux/module.h>
+#include <linux/security.h>
+#include "bios_data_access.h"
+#include "low_level_access.h"
+#include "viddid_arch_map.h"
+
+#define SIZE_WORD sizeof(u16)
+#define WORD_MASK 0xFFFFu
+#define LOW_WORD(x) ((x) & WORD_MASK)
+#define HIGH_WORD(x) ((x) >> ((SIZE_WORD * 8)) & WORD_MASK)
+
+static enum PCH_Arch pch_arch;
+static enum CPU_Arch cpu_arch;
+
+static struct dentry *spi_dir;
+static struct dentry *spi_bioswe;
+static struct dentry *spi_ble;
+static struct dentry *spi_smm_bwp;
+
+typedef int Read_BC_Flag_Fn(struct spi_bc *bc, u64 *value);
+
+static int get_pci_vid_did(u8 bus, u8 dev, u8 fun, u16 *vid, u16 *did)
+{
+	u32 vid_did;
+	int ret = pci_read_dword(&vid_did, bus, dev, fun, 0);
+
+	if (ret == 0) {
+		*vid = LOW_WORD(vid_did);
+		*did = HIGH_WORD(vid_did);
+	}
+	return ret;
+}
+
+static int get_pch_arch(enum PCH_Arch *pch_arch)
+{
+	u16 pch_vid;
+	u16 pch_did;
+	int ret = get_pci_vid_did(0, 0x1f, 0, &pch_vid, &pch_did);
+
+	if (ret != 0)
+		return ret;
+
+	pr_debug("PCH VID: %x - DID: %x\n", pch_vid, pch_did);
+	ret = viddid2pch_arch(pch_vid, pch_did, pch_arch);
+
+	return ret;
+}
+
+static int get_cpu_arch(enum CPU_Arch *cpu_arch)
+{
+	u16 cpu_vid;
+	u16 cpu_did;
+	int ret = get_pci_vid_did(0, 0, 0, &cpu_vid, &cpu_did);
+
+	if (ret != 0)
+		return ret;
+
+	pr_debug("CPU VID: %x - DID: %x\n", cpu_vid, cpu_did);
+	ret = viddid2cpu_arch(cpu_vid, cpu_did, cpu_arch);
+
+	return ret;
+}
+
+static int get_pch_cpu(enum PCH_Arch *pch_arch, enum CPU_Arch *cpu_arch)
+{
+	const int cpu_res = get_cpu_arch(cpu_arch);
+	const int pch_res = get_pch_arch(pch_arch);
+
+	return cpu_res != 0 && pch_res != 0 ? -EIO : 0;
+}
+
+/* Buffer to return: always 3 because of the following chars:
+ *     value \n \0
+ */
+#define BUFFER_SIZE 3
+
+static ssize_t bc_flag_read(struct file *filp, char __user *buf, size_t count,
+			    loff_t *ppos)
+{
+	char tmp[BUFFER_SIZE];
+	ssize_t ret;
+	u64 value = 0;
+	struct spi_bc bc;
+
+	if (*ppos == BUFFER_SIZE)
+		return 0; /* nothing else to read */
+
+	if (file_inode(filp)->i_private == NULL)
+		return -EIO;
+
+	ret = spi_read_bc(pch_arch, cpu_arch, &bc);
+
+	if (ret == 0)
+		ret = ((Read_BC_Flag_Fn *)file_inode(filp)->i_private)(&bc,
+								       &value);
+
+	if (ret != 0)
+		return ret;
+
+	sprintf(tmp, "%d\n", (int)value & 1);
+	ret = simple_read_from_buffer(buf, count, ppos, tmp, sizeof(tmp));
+
+	return ret;
+}
+
+static const struct file_operations bc_flags_ops = {
+	.read = bc_flag_read,
+};
+
+static int __init mod_init(void)
+{
+	int ret = 0;
+
+	if (get_pch_cpu(&pch_arch, &cpu_arch) != 0) {
+		pr_err("Couldn't detect PCH or CPU\n");
+		return -EIO;
+	}
+
+	spi_dir = securityfs_create_dir("firmware", NULL);
+	if (IS_ERR(spi_dir)) {
+		pr_err("Couldn't create firmware securityfs dir\n");
+		return PTR_ERR(spi_dir);
+	}
+
+#define create_file(name, function)                                            \
+	do {                                                                   \
+		spi_##name = securityfs_create_file(#name, 0600, spi_dir,      \
+						    &function, &bc_flags_ops); \
+		if (IS_ERR(spi_##name)) {                                      \
+			pr_err("Error creating securityfs file " #name "\n");  \
+			ret = PTR_ERR(spi_##name);                             \
+			goto out_##name;                                       \
+		}                                                              \
+	} while (0)
+
+	create_file(bioswe, spi_read_bc_bioswe);
+	create_file(ble, spi_read_bc_ble);
+	create_file(smm_bwp, spi_read_bc_smm_bwp);
+
+	return 0;
+
+out_smm_bwp:
+	securityfs_remove(spi_smm_bwp);
+out_ble:
+	securityfs_remove(spi_ble);
+out_bioswe:
+	securityfs_remove(spi_bioswe);
+	securityfs_remove(spi_dir);
+	return ret;
+}
+
+static void __exit mod_exit(void)
+{
+	securityfs_remove(spi_smm_bwp);
+	securityfs_remove(spi_ble);
+	securityfs_remove(spi_bioswe);
+	securityfs_remove(spi_dir);
+}
+
+module_init(mod_init);
+module_exit(mod_exit);
+
+MODULE_DESCRIPTION("SPI LPC flash platform security driver");
+MODULE_AUTHOR("Richard Hughes <richard@hughsie.com>");
+MODULE_AUTHOR("Daniel Gutson <daniel.gutson@eclypsium.com>");
+MODULE_LICENSE("GPL");
diff --git a/drivers/misc/spi_lpc/viddid_arch_map.c b/drivers/misc/spi_lpc/viddid_arch_map.c
new file mode 100644
index 000000000000..f7955ef70e2b
--- /dev/null
+++ b/drivers/misc/spi_lpc/viddid_arch_map.c
@@ -0,0 +1,566 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * SPI LPC flash platform security driver
+ *
+ * Copyright 2020 (c) Daniel Gutson (daniel.gutson@eclypsium.com)
+ *
+ */
+
+#include <linux/module.h>
+
+#include "viddid_arch_map.h"
+
+int viddid2pch_arch(u64 vid, u64 did, enum PCH_Arch *arch)
+{
+	switch (vid) {
+	case 0x8086: /* INTEL */
+		switch (did) {
+		case 0x1c44:
+		case 0x1c46:
+		case 0x1c47:
+		case 0x1c49:
+		case 0x1c4a:
+		case 0x1c4b:
+		case 0x1c4c:
+		case 0x1c4d:
+		case 0x1c4e:
+		case 0x1c4f:
+		case 0x1c50:
+		case 0x1c52:
+		case 0x1c54:
+		case 0x1c56:
+		case 0x1c5c:
+			*arch = pch_6_c200;
+			return 0;
+		case 0x1e47:
+		case 0x1e48:
+		case 0x1e49:
+		case 0x1e44:
+		case 0x1e46:
+		case 0x1e4a:
+		case 0x1e53:
+		case 0x1e55:
+		case 0x1e58:
+		case 0x1e57:
+		case 0x1e59:
+		case 0x1e5d:
+		case 0x1e5e:
+		case 0x1e56:
+			*arch = pch_7_c210;
+			return 0;
+		case 0x1d41:
+			*arch = pch_c60x_x79;
+			return 0;
+		case 0x2390:
+		case 0x2310:
+			*arch = pch_communications_89xx;
+			return 0;
+		case 0x8c41:
+		case 0x8c42:
+		case 0x8c44:
+		case 0x8c46:
+		case 0x8c49:
+		case 0x8c4a:
+		case 0x8c4b:
+		case 0x8c4c:
+		case 0x8c4e:
+		case 0x8c4f:
+		case 0x8c50:
+		case 0x8c52:
+		case 0x8c54:
+		case 0x8c56:
+		case 0x8c5c:
+		case 0x8cc1:
+		case 0x8cc2:
+		case 0x8cc3:
+		case 0x8cc4:
+		case 0x8cc6:
+			*arch = pch_8_c220;
+			return 0;
+		case 0x8d40:
+		case 0x8d44:
+		case 0x8d47:
+			*arch = pch_c61x_x99;
+			return 0;
+		case 0x9cc3:
+		case 0x9cc5:
+		case 0x9cc7:
+		case 0x9cc9:
+		case 0x9cc1:
+		case 0x9cc2:
+		case 0x9cc6:
+			*arch = pch_5_mobile;
+			return 0;
+		case 0x9d41:
+		case 0x9d43:
+		case 0x9d46:
+		case 0x9d48:
+			*arch = pch_6_mobile;
+			return 0;
+		case 0x9d4b:
+		case 0x9d4e:
+		case 0x9d50:
+		case 0x9d53:
+		case 0x9d56:
+		case 0x9d58:
+			*arch = pch_7_8_mobile;
+			return 0;
+		case 0xa141:
+		case 0xa142:
+		case 0xa143:
+		case 0xa144:
+		case 0xa145:
+		case 0xa146:
+		case 0xa147:
+		case 0xa148:
+		case 0xa149:
+		case 0xa14a:
+		case 0xa14b:
+		case 0xa14c:
+		case 0xa14d:
+		case 0xa14e:
+		case 0xa14f:
+		case 0xa150:
+		case 0xa151:
+		case 0xa152:
+		case 0xa153:
+		case 0xa154:
+		case 0xa155:
+		case 0xa156:
+		case 0xa157:
+		case 0xa158:
+		case 0xa159:
+		case 0xa15a:
+		case 0xa15b:
+		case 0xa15c:
+		case 0xa15d:
+		case 0xa15e:
+		case 0xa15f:
+			*arch = pch_1xx;
+			return 0;
+		case 0xa1c1:
+		case 0xa1c2:
+		case 0xa1c3:
+		case 0xa1c4:
+		case 0xa1c5:
+		case 0xa1c6:
+		case 0xa1c7:
+		case 0xa242:
+		case 0xa243:
+		case 0xa244:
+		case 0xa245:
+		case 0xa246:
+			*arch = pch_c620;
+			return 0;
+		case 0xa2c0:
+		case 0xa2c1:
+		case 0xa2c2:
+		case 0xa2c3:
+		case 0xa2c4:
+		case 0xa2c5:
+		case 0xa2c6:
+		case 0xa2c7:
+		case 0xa2c8:
+		case 0xa2c9:
+		case 0xa2ca:
+		case 0xa2cb:
+		case 0xa2cc:
+		case 0xa2cd:
+		case 0xa2ce:
+		case 0xa2cf:
+		case 0xa2d2:
+		case 0xa2d3:
+			*arch = pch_2xx;
+			return 0;
+		case 0xa300:
+		case 0xa301:
+		case 0xa302:
+		case 0xa303:
+		case 0xa304:
+		case 0xa305:
+		case 0xa306:
+		case 0xa307:
+		case 0xa308:
+		case 0xa309:
+		case 0xa30a:
+		case 0xa30b:
+		case 0xa30c:
+		case 0xa30d:
+		case 0xa30e:
+		case 0xa30f:
+		case 0xa310:
+		case 0xa311:
+		case 0xa312:
+		case 0xa313:
+		case 0xa314:
+		case 0xa315:
+		case 0xa316:
+		case 0xa317:
+		case 0xa318:
+		case 0xa319:
+		case 0xa31a:
+		case 0xa31b:
+		case 0xa31c:
+		case 0xa31d:
+		case 0xa31e:
+		case 0xa31f:
+		case 0x9d81:
+		case 0x9d83:
+		case 0x9d84:
+		case 0x9d85:
+		case 0x9d86:
+			*arch = pch_3xx;
+			return 0;
+		case 0x280:
+		case 0x281:
+		case 0x282:
+		case 0x283:
+		case 0x284:
+		case 0x285:
+		case 0x286:
+		case 0x287:
+		case 0x288:
+		case 0x289:
+		case 0x28a:
+		case 0x28b:
+		case 0x28c:
+		case 0x28d:
+		case 0x28e:
+		case 0x28f:
+		case 0x290:
+		case 0x291:
+		case 0x292:
+		case 0x293:
+		case 0x294:
+		case 0x295:
+		case 0x296:
+		case 0x297:
+		case 0x298:
+		case 0x299:
+		case 0x29a:
+		case 0x29b:
+		case 0x29c:
+		case 0x29d:
+		case 0x29e:
+		case 0x29f:
+		case 0x680:
+		case 0x681:
+		case 0x682:
+		case 0x683:
+		case 0x684:
+		case 0x685:
+		case 0x686:
+		case 0x687:
+		case 0x688:
+		case 0x689:
+		case 0x68a:
+		case 0x68b:
+		case 0x68c:
+		case 0x68d:
+		case 0x68e:
+		case 0x68f:
+		case 0x690:
+		case 0x691:
+		case 0x692:
+		case 0x693:
+		case 0x694:
+		case 0x695:
+		case 0x696:
+		case 0x697:
+		case 0x698:
+		case 0x699:
+		case 0x69a:
+		case 0x69b:
+		case 0x69c:
+		case 0x69d:
+		case 0x69e:
+		case 0x69f:
+		case 0xa3c1:
+		case 0xa3c8:
+		case 0xa3da:
+			*arch = pch_4xx;
+			return 0;
+		case 0x3480:
+		case 0x3481:
+		case 0x3482:
+		case 0x3483:
+		case 0x3484:
+		case 0x3485:
+		case 0x3486:
+		case 0x3487:
+		case 0x3488:
+		case 0x3489:
+		case 0x348a:
+		case 0x348b:
+		case 0x348c:
+		case 0x348d:
+		case 0x348e:
+		case 0x348f:
+		case 0x3490:
+		case 0x3491:
+		case 0x3492:
+		case 0x3493:
+		case 0x3494:
+		case 0x3495:
+		case 0x3496:
+		case 0x3497:
+		case 0x3498:
+		case 0x3499:
+		case 0x349a:
+		case 0x349b:
+		case 0x349c:
+		case 0x349d:
+		case 0x349e:
+		case 0x349f:
+		case 0x3887:
+			*arch = pch_495;
+			return 0;
+		case 0x4380:
+		case 0x4381:
+		case 0x4382:
+		case 0x4383:
+		case 0x4384:
+		case 0x4385:
+		case 0x4386:
+		case 0x4387:
+		case 0x4388:
+		case 0x4389:
+		case 0x438a:
+		case 0x438b:
+		case 0x438c:
+		case 0x438d:
+		case 0x438e:
+		case 0x438f:
+		case 0x4390:
+		case 0x4391:
+		case 0x4392:
+		case 0x4393:
+		case 0x4394:
+		case 0x4395:
+		case 0x4396:
+		case 0x4397:
+		case 0x4398:
+		case 0x4399:
+		case 0x439a:
+		case 0x439b:
+		case 0x439c:
+		case 0x439d:
+		case 0x439e:
+		case 0x439f:
+		case 0xa080:
+		case 0xa081:
+		case 0xa082:
+		case 0xa083:
+		case 0xa084:
+		case 0xa085:
+		case 0xa086:
+		case 0xa087:
+		case 0xa088:
+		case 0xa089:
+		case 0xa08a:
+		case 0xa08b:
+		case 0xa08c:
+		case 0xa08d:
+		case 0xa08e:
+		case 0xa08f:
+		case 0xa090:
+		case 0xa091:
+		case 0xa092:
+		case 0xa093:
+		case 0xa094:
+		case 0xa095:
+		case 0xa096:
+		case 0xa097:
+		case 0xa098:
+		case 0xa099:
+		case 0xa09a:
+		case 0xa09b:
+		case 0xa09c:
+		case 0xa09d:
+		case 0xa09e:
+		case 0xa09f:
+			*arch = pch_5xx;
+			return 0;
+		default:
+			*arch = pch_none;
+			return -EIO; /* DID not found */
+		}
+	case 0x1022: /* AMD */
+		switch (did) {
+		default:
+			*arch = pch_none;
+			return -EIO; /* DID not found */
+		}
+	default:
+		return -EIO; /* VID not supported */
+	}
+}
+
+int viddid2cpu_arch(u64 vid, u64 did, enum CPU_Arch *arch)
+{
+	switch (vid) {
+	case 0x8086: /* INTEL */
+		switch (did) {
+		case 0x1600:
+		case 0x1604:
+		case 0x1610:
+		case 0x1614:
+		case 0x1618:
+			*arch = cpu_bdw;
+			return 0;
+		case 0x6f00:
+			*arch = cpu_bdx;
+			return 0;
+		case 0xa00:
+		case 0xa04:
+		case 0xa08:
+		case 0xc00:
+		case 0xc04:
+		case 0xc08:
+		case 0xd00:
+		case 0xd04:
+		case 0xd08:
+			*arch = cpu_hsw;
+			return 0;
+		case 0x2f00:
+			*arch = cpu_hsx;
+			return 0;
+		case 0xe00:
+			*arch = cpu_ivt;
+			return 0;
+		case 0x3c00:
+			*arch = cpu_jkt;
+			return 0;
+		case 0x5900:
+		case 0x5904:
+		case 0x590c:
+		case 0x590f:
+		case 0x5910:
+		case 0x5914:
+		case 0x5918:
+		case 0x591f:
+			*arch = cpu_kbl;
+			return 0;
+		case 0x1900:
+		case 0x1904:
+		case 0x190c:
+		case 0x190f:
+		case 0x1910:
+		case 0x191f:
+		case 0x1918:
+		case 0x2020:
+			*arch = cpu_skl;
+			return 0;
+		case 0x150:
+		case 0x154:
+		case 0x158:
+			*arch = cpu_ivb;
+			return 0;
+		case 0x100:
+		case 0x104:
+		case 0x108:
+			*arch = cpu_snb;
+			return 0;
+		case 0x1f00:
+		case 0x1f01:
+		case 0x1f02:
+		case 0x1f03:
+		case 0x1f04:
+		case 0x1f05:
+		case 0x1f06:
+		case 0x1f07:
+		case 0x1f08:
+		case 0x1f09:
+		case 0x1f0a:
+		case 0x1f0b:
+		case 0x1f0c:
+		case 0x1f0d:
+		case 0x1f0e:
+		case 0x1f0f:
+			*arch = cpu_avn;
+			return 0;
+		case 0x3e0f:
+		case 0x3e10:
+		case 0x3e18:
+		case 0x3e1f:
+		case 0x3e30:
+		case 0x3e31:
+		case 0x3e32:
+		case 0x3e33:
+		case 0x3ec2:
+		case 0x3ec4:
+		case 0x3ec6:
+		case 0x3eca:
+		case 0x3ecc:
+		case 0x3ed0:
+			*arch = cpu_cfl;
+			return 0;
+		case 0xf00:
+			*arch = cpu_byt;
+			return 0;
+		case 0x3e34:
+		case 0x3e35:
+			*arch = cpu_whl;
+			return 0;
+		case 0x3e20:
+		case 0x9b33:
+		case 0x9b43:
+		case 0x9b44:
+		case 0x9b51:
+		case 0x9b53:
+		case 0x9b54:
+		case 0x9b61:
+		case 0x9b63:
+		case 0x9b64:
+		case 0x9b71:
+		case 0x9b73:
+			*arch = cpu_cml;
+			return 0;
+		case 0x8a00:
+		case 0x8a02:
+		case 0x8a10:
+		case 0x8a12:
+		case 0x8a16:
+			*arch = cpu_icl;
+			return 0;
+		case 0x5af0:
+			*arch = cpu_apl;
+			return 0;
+		case 0x3180:
+		case 0x31f0:
+			*arch = cpu_glk;
+			return 0;
+		case 0x9a02:
+		case 0x9a04:
+		case 0x9a12:
+		case 0x9a14:
+		case 0x9a26:
+		case 0x9a36:
+			*arch = cpu_tgl;
+			return 0;
+		default:
+			*arch = cpu_none;
+			return -EIO; /* DID not found */
+		}
+	case 0x1022: /* AMD */
+		switch (did) {
+		case 0x1410:
+		case 0x1422:
+		case 0x1576:
+		case 0x1510:
+		case 0x1514:
+		case 0x1536:
+		case 0x1566:
+		case 0x1450:
+		case 0x1480:
+		case 0x15d0:
+			*arch = cpu_amd;
+			return 0;
+		default:
+			*arch = cpu_none;
+			return -EIO; /* DID not found */
+		}
+	default:
+		return -EIO; /* VID not supported */
+	}
+}
diff --git a/drivers/misc/spi_lpc/viddid_arch_map.h b/drivers/misc/spi_lpc/viddid_arch_map.h
new file mode 100644
index 000000000000..910f5372462d
--- /dev/null
+++ b/drivers/misc/spi_lpc/viddid_arch_map.h
@@ -0,0 +1,17 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * SPI LPC flash platform security driver
+ *
+ * Copyright 2020 (c) Daniel Gutson (daniel.gutson@eclypsium.com)
+ *
+ */
+
+#ifndef VIDDID_ARCH_MAP_H
+#define VIDDID_ARCH_MAP_H
+
+#include "bios_data_access.h"
+
+int viddid2pch_arch(u64 vid, u64 did, enum PCH_Arch *arch);
+int viddid2cpu_arch(u64 vid, u64 did, enum CPU_Arch *arch);
+
+#endif /* VIDDID_ARCH_MAP_H */
-- 
2.25.1

