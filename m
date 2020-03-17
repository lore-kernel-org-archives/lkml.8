Return-Path: <SRS0=kRID=5C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42C9FC10F29
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Mar 2020 09:01:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0EE7620663
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Mar 2020 09:01:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725995AbgCQJBO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Mar 2020 05:01:14 -0400
Received: from smtpbgsg2.qq.com ([54.254.200.128]:43560 "EHLO smtpbgsg2.qq.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725536AbgCQJBO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Mar 2020 05:01:14 -0400
X-QQ-mid: bizesmtp4t1584435664toays8ce8
Received: from localhost.localdomain (unknown [111.28.186.3])
        by esmtp6.qq.com (ESMTP) with 
        id ; Tue, 17 Mar 2020 17:00:59 +0800 (CST)
X-QQ-SSF: 01400000002000I0QxF0B00A0000000
X-QQ-FEAT: 1USUZei7XzYFyXuV+Y3zh+RUWCUt8+ThVu5z7R5jI9TJvtwHJzKtPfBsHAgxy
        mHUJI3EzqcvKCtazjqjkmNYw85Sb3VTbpQDG+pAoC306wHjMchpEA/zcnIjDR3HeRwbfV26
        l6bw/BcKr0yOErfFvoRhxVWB+ot+bnnzglXnoIaOCvECPPj3fxyVPt9Urrv6yabv9ezVeu6
        jAAwXJjbm7xES4hizmayeaacrk8ULPvpMugs4Ne3maBIFQJMK7Lm0mGw+Ke/LWQ6wr+PhRe
        kg426gMGXv6bnzC3JBT1jeCSg+hmV3A0GNxISiV41SQrzsyOWL25LdJCQ/n7PYj7Ge63L0o
        Rt+iphzadoqdVCuT+M=
X-QQ-GoodBg: 2
From:   Gao Long <gaolong@tj.kylinos.cn>
To:     ralf@linux-mips.org, paul.burton@mips.com, jhogan@kernel.org
Cc:     linux-mips@linux-mips.org, linux-kernel@vger.kernel.org,
        Gao Long <gaolong@tj.kylinos.cn>
Subject: [PATCH] mips tool: Find correct start address for vmlinux
Date:   Tue, 17 Mar 2020 17:00:38 +0800
Message-Id: <1584435638-14003-1-git-send-email-gaolong@tj.kylinos.cn>
X-Mailer: git-send-email 2.7.4
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:tj.kylinos.cn:qybgforeign:qybgforeign7
X-QQ-Bgrelay: 1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When shell variable $LANG is set to anything like zh_CN.UTF-8,
there will be an error in mips kernel compiling, complaining about
unknown "invalid operands `dli $26'". It is because of retreiving
a bad "start address" from vmlinux, by using objdump -f vmlinux.
New tool has been added to linux kernel 5.4, named elf-entry,
to get correct "start address", regardless of the $LANG shell variable.
I back-ported the elf-entry tool and relevant Makefiles to 4.19.

Signed-off-by: Gao Long <gaolong@tj.kylinos.cn>
---
 arch/mips/Makefile          |  8 +---
 arch/mips/tools/Makefile    |  5 +++
 arch/mips/tools/elf-entry.c | 96 +++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 103 insertions(+), 6 deletions(-)
 create mode 100644 arch/mips/tools/Makefile
 create mode 100644 arch/mips/tools/elf-entry.c

diff --git a/arch/mips/Makefile b/arch/mips/Makefile
index ad0a92f..448397e 100644
--- a/arch/mips/Makefile
+++ b/arch/mips/Makefile
@@ -13,6 +13,7 @@
 #
 
 archscripts: scripts_basic
+	$(Q)$(MAKE) $(build)=arch/mips/tools elf-entry
 	$(Q)$(MAKE) $(build)=arch/mips/boot/tools relocs
 
 KBUILD_DEFCONFIG := 32r2el_defconfig
@@ -259,12 +260,7 @@ load-y					= $(CONFIG_PHYSICAL_START)
 endif
 
 # Sign-extend the entry point to 64 bits if retrieved as a 32-bit number.
-entry-y		= $(shell $(OBJDUMP) -f vmlinux 2>/dev/null \
-			| sed -n '/^start address / { \
-				s/^.* //; \
-				s/0x\([0-7].......\)$$/0x00000000\1/; \
-				s/0x\(........\)$$/0xffffffff\1/; p }')
-
+entry-y                         = $(shell $(objtree)/arch/mips/tools/elf-entry vmlinux)
 cflags-y			+= -I$(srctree)/arch/mips/include/asm/mach-generic
 drivers-$(CONFIG_PCI)		+= arch/mips/pci/
 
diff --git a/arch/mips/tools/Makefile b/arch/mips/tools/Makefile
new file mode 100644
index 0000000..3baee4b
--- /dev/null
+++ b/arch/mips/tools/Makefile
@@ -0,0 +1,5 @@
+# SPDX-License-Identifier: GPL-2.0
+hostprogs-y := elf-entry
+PHONY += elf-entry
+elf-entry: $(obj)/elf-entry
+	@:
diff --git a/arch/mips/tools/elf-entry.c b/arch/mips/tools/elf-entry.c
new file mode 100644
index 0000000..adde79c
--- /dev/null
+++ b/arch/mips/tools/elf-entry.c
@@ -0,0 +1,96 @@
+// SPDX-License-Identifier: GPL-2.0
+#include <byteswap.h>
+#include <elf.h>
+#include <endian.h>
+#include <inttypes.h>
+#include <stdint.h>
+#include <stdio.h>
+#include <stdlib.h>
+#include <string.h>
+
+#ifdef be32toh
+/* If libc provides [bl]e{32,64}toh() then we'll use them */
+#elif BYTE_ORDER == LITTLE_ENDIAN
+# define be32toh(x)	bswap_32(x)
+# define le32toh(x)	(x)
+# define be64toh(x)	bswap_64(x)
+# define le64toh(x)	(x)
+#elif BYTE_ORDER == BIG_ENDIAN
+# define be32toh(x)	(x)
+# define le32toh(x)	bswap_32(x)
+# define be64toh(x)	(x)
+# define le64toh(x)	bswap_64(x)
+#endif
+
+__attribute__((noreturn))
+static void die(const char *msg)
+{
+	fputs(msg, stderr);
+	exit(EXIT_FAILURE);
+}
+
+int main(int argc, const char *argv[])
+{
+	uint64_t entry;
+	size_t nread;
+	FILE *file;
+	union {
+		Elf32_Ehdr ehdr32;
+		Elf64_Ehdr ehdr64;
+	} hdr;
+
+	if (argc != 2)
+		die("Usage: elf-entry <elf-file>\n");
+
+	file = fopen(argv[1], "r");
+	if (!file) {
+		perror("Unable to open input file");
+		return EXIT_FAILURE;
+	}
+
+	nread = fread(&hdr, 1, sizeof(hdr), file);
+	if (nread != sizeof(hdr)) {
+		perror("Unable to read input file");
+		return EXIT_FAILURE;
+	}
+
+	if (memcmp(hdr.ehdr32.e_ident, ELFMAG, SELFMAG))
+		die("Input is not an ELF\n");
+
+	switch (hdr.ehdr32.e_ident[EI_CLASS]) {
+	case ELFCLASS32:
+		switch (hdr.ehdr32.e_ident[EI_DATA]) {
+		case ELFDATA2LSB:
+			entry = le32toh(hdr.ehdr32.e_entry);
+			break;
+		case ELFDATA2MSB:
+			entry = be32toh(hdr.ehdr32.e_entry);
+			break;
+		default:
+			die("Invalid ELF encoding\n");
+		}
+
+		/* Sign extend to form a canonical address */
+		entry = (int64_t)(int32_t)entry;
+		break;
+
+	case ELFCLASS64:
+		switch (hdr.ehdr32.e_ident[EI_DATA]) {
+		case ELFDATA2LSB:
+			entry = le64toh(hdr.ehdr64.e_entry);
+			break;
+		case ELFDATA2MSB:
+			entry = be64toh(hdr.ehdr64.e_entry);
+			break;
+		default:
+			die("Invalid ELF encoding\n");
+		}
+		break;
+
+	default:
+		die("Invalid ELF class\n");
+	}
+
+	printf("0x%016" PRIx64 "\n", entry);
+	return EXIT_SUCCESS;
+}
-- 
2.7.4



