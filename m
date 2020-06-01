Return-Path: <SRS0=8+oI=7O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F8C7C433DF
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jun 2020 14:28:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6A9262068D
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jun 2020 14:28:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="NxOgmo5l"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727815AbgFAO2Y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Jun 2020 10:28:24 -0400
Received: from mailout1.w1.samsung.com ([210.118.77.11]:55359 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727000AbgFAO2O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Jun 2020 10:28:14 -0400
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20200601142812euoutp0118ff54af71a1e510b2fb793ce693be81~UccypCv_R1115911159euoutp01I
        for <linux-kernel@vger.kernel.org>; Mon,  1 Jun 2020 14:28:12 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20200601142812euoutp0118ff54af71a1e510b2fb793ce693be81~UccypCv_R1115911159euoutp01I
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1591021692;
        bh=W1N0pk+zwBpYOwOEoTj035sNHYsI+JRLIt8m73+L2QA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=NxOgmo5l6KH+BlcTdKT9jtRcRDzyoS+l8jVjqZX+44PUCVV0lmGBCWZKG7SiFtUsA
         s6pFG2SNRQXK6idAXQtZHL6Z6h4qFfvXu0g3Y1v8sfPVVmooCE2LWt+IF/Q4LWnJ8I
         AUbhL4eoC5OisqIL59kUYCte+H4qCNMtcs7z5PR4=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20200601142811eucas1p2cfb8d4a2932683df1904664cb20905bd~UccyVyu-51927019270eucas1p2h;
        Mon,  1 Jun 2020 14:28:11 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges3new.samsung.com (EUCPMTA) with SMTP id 6F.6D.60698.B7015DE5; Mon,  1
        Jun 2020 15:28:11 +0100 (BST)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20200601142811eucas1p1604c8e6ca06c09f1ec821ea5e1918c53~UccyCywhV2463924639eucas1p1s;
        Mon,  1 Jun 2020 14:28:11 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20200601142811eusmtrp124c99c66d75d0868cf5e64e0be948c7b~UccyB7wtx3017330173eusmtrp1k;
        Mon,  1 Jun 2020 14:28:11 +0000 (GMT)
X-AuditID: cbfec7f5-a29ff7000001ed1a-e3-5ed5107b84ac
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id 53.FB.07950.B7015DE5; Mon,  1
        Jun 2020 15:28:11 +0100 (BST)
Received: from localhost (unknown [106.120.51.46]) by eusmtip1.samsung.com
        (KnoxPortal) with ESMTPA id
        20200601142811eusmtip150f76db6f64f8a7d964f5310398f8b42~Uccx3HTOv1539715397eusmtip1n;
        Mon,  1 Jun 2020 14:28:11 +0000 (GMT)
From:   =?UTF-8?q?=C5=81ukasz=20Stelmach?= <l.stelmach@samsung.com>
To:     Russell King <linux@armlinux.org.uk>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Enrico Weigelt <info@metux.net>,
        Kees Cook <keescook@chromium.org>,
        Ingo Molnar <mingo@kernel.org>,
        Ben Dooks <ben-linux@fluff.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     AKASHI Takahiro <takahiro.akashi@linaro.org>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        =?UTF-8?q?=C5=81ukasz=20Stelmach?= <l.stelmach@samsung.com>
Subject: [PATCH 5/5] arm: kexec_file: load zImage or uImage, initrd and dtb
Date:   Mon,  1 Jun 2020 16:27:54 +0200
Message-Id: <20200601142754.26139-6-l.stelmach@samsung.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200601142754.26139-1-l.stelmach@samsung.com>
MIME-Version: 1.0
Organization: Samsung R&D Institute Poland
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA02Sa0hTYRjHe89tR2t2nIZPFoZDSYW0WNkBpbQLnArKL32JspYdTNwsdrKy
        m1rmvfKCadsgSa1ly3TqKrOUlZotl2KZ0dVUSlEJS7p5ye0o+e3/PM/v//zfB14al30gPemY
        uCO8Jk6pklPOhLn594sVJ5lXkSuNTQq2qugOyeZVNGLsm+QHGPs8S82+sRgQa+rtItnOOj3F
        WgoeIvb2k/cStudTN8nemnyG2G85Uxg73vCbYKtNBXiYC9fZ1YFzuqQOgpso/4pzxaZ4zlSe
        QXHvuuopbsRmk3DVpYlczrdhirtYU4647yaviPm7nEMP8KqYo7wmaN0+54NZNy/ih39q0fGR
        yRNJqPFUJnKigVkN5wwPsUzkTMsYAwJr0+WZ4geCTlvtTPEdweOhfGrWYrzSTomDGwgm+nMl
        YvEFwdvP9zE7RTHhcKnsKWkfuDNjGNQVpDksOPMSQU+D2UG5Mdsgo6TCsZdgfEGbm0/atZQJ
        gfuPinExbxmk3bjrYJyYUGi0jmIi4wqtV/oIu17IBIDx7GuHxqf5c7U63B4GTC4NhtQpUly0
        Ccx3R2e0Gwy21EhEvRSs+dnTZnpaJ0J+XrDozUZg1v8iRCYE3tn+UHYGZ/zhTl2Q2A6Hs5lt
        pGh1ge5hV/EJLpBnLsTFthTSU2Ui7QMVl+pnFnrChUEDykFy7ZxjtHMO0P7PKkZ4OfLg4wV1
        NC8o4vhjgYJSLcTHRQdGHVKb0PSvs062jN1Dj8b3WxBDI/kCaeXHl5EyUnlUSFBbENC43F26
        oc0aKZMeUCac4DWH9mriVbxgQUtoQu4hVVwb2CNjopVH+FieP8xrZqcY7eSZhAqM+8eMPr69
        QSkSzWL58/WVNesGyOWvhyXeZSu39PvsvBnr/+dxFKCi5qKeDjSxcZcq9sfe0+1eRKXOP0oR
        vKbQ+9bfeX7VDQoDNhR+veq2rr8wL4xepNs+WfKlr9Rd2F2yo7UtfHO6d4rfmeSWhOuJWyPa
        h9YWnz+lr9YHPbnqKyeEg8pVAbhGUP4DHJ8LRXEDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrDIsWRmVeSWpSXmKPExsVy+t/xu7rVAlfjDKbclbXYOGM9q8WkdQeY
        LG427mayONOda3Hz0ApGi02Pr7FaXN41h83i0NS9jBZrj9xlt3j44Aarxep/pxgtPkz4z2Tx
        Z/9PFovNm6YyO/B5XL52kdljdsNFFo+/q14weyzYVOqxaVUnm8eda3vYPN6dO8fusXlJvceE
        D2/ZPPq2rGL0+LxJLoA7Ss+mKL+0JFUhI7+4xFYp2tDCSM/Q0kLPyMRSz9DYPNbKyFRJ384m
        JTUnsyy1SN8uQS+je2Ufc8H3WYwV7/5VNTAeqOli5OSQEDCRWDPzAhuILSSwlFFiyhLrLkYO
        oLiUxMq56RAlwhJ/rnVBlTxllLi0wR7EZhNwlOhfeoK1i5GLQ0TgL5PEwVmn2UAcZoFrjBIb
        J5xkBqkSFvCW6Fy8DqybRUBVYtbEyawgNq+AtcTOfQuYITbIS7Qv3w5WwylgI3Hg9CcmiG3W
        Eu+ndTNB1AtKnJz5hAXkOGYBdYn184RAwvwCWhJrmq6zgNjMQGOat85mnsAoNAtJxyyEjllI
        qhYwMq9iFEktLc5Nzy020itOzC0uzUvXS87P3cQIjOltx35u2cHY9S74EKMAB6MSD++G+1fi
        hFgTy4orcw8xSnAwK4nwOp09HSfEm5JYWZValB9fVJqTWnyI0RTozYnMUqLJ+cB0k1cSb2hq
        aG5haWhubG5sZqEkztshcDBGSCA9sSQ1OzW1ILUIpo+Jg1OqgbGMZ/qyvdceq/oUP7I5wnDk
        dGvoOd3gOV5WdkGhz5QsDp/6ZPevyXtbun522ked9ytebE6bZP1Z+E9L9Qv3wtXrfR6afVas
        ELz24Viv5I93G+a1TeHk3KIhn5ZTn23mY8+90kov4piP6eIsxp6Pb1nVltQ9dMtw091zcafa
        mX8e1YerOS28LymxFGckGmoxFxUnAgDYjMeB/wIAAA==
X-CMS-MailID: 20200601142811eucas1p1604c8e6ca06c09f1ec821ea5e1918c53
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20200601142811eucas1p1604c8e6ca06c09f1ec821ea5e1918c53
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20200601142811eucas1p1604c8e6ca06c09f1ec821ea5e1918c53
References: <20200601142754.26139-1-l.stelmach@samsung.com>
        <CGME20200601142811eucas1p1604c8e6ca06c09f1ec821ea5e1918c53@eucas1p1.samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is kexec_file_load implementation for ARM. It loads zImage and
initrd from file descripters and resuses DTB.

Most code is derived from arm64 kexec_file_load implementation
and from kexec-tools.

Cc: AKASHI Takahiro <takahiro.akashi@linaro.org>
Signed-off-by: Łukasz Stelmach <l.stelmach@samsung.com>
---
 arch/arm/Kconfig                     |  15 ++
 arch/arm/include/asm/image.h         |  26 ++++
 arch/arm/include/asm/kexec.h         |  14 ++
 arch/arm/kernel/Makefile             |   5 +-
 arch/arm/kernel/kexec_uimage.c       |  80 ++++++++++
 arch/arm/kernel/kexec_zimage.c       | 199 +++++++++++++++++++++++++
 arch/arm/kernel/machine_kexec.c      |  11 +-
 arch/arm/kernel/machine_kexec_file.c | 209 +++++++++++++++++++++++++++
 8 files changed, 554 insertions(+), 5 deletions(-)
 create mode 100644 arch/arm/kernel/kexec_uimage.c
 create mode 100644 arch/arm/kernel/kexec_zimage.c
 create mode 100644 arch/arm/kernel/machine_kexec_file.c

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index c77c93c485a0..6adb849cb304 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -1917,6 +1917,21 @@ config KEXEC
 	  is properly shutdown, so do not be surprised if this code does not
 	  initially work for you.
 
+config KEXEC_FILE
+	bool "Kexec file based system call (EXPERIMENTAL)"
+	depends on (!SMP || PM_SLEEP_SMP)
+	depends on USE_OF
+	select KEXEC_CORE
+	select CRC32
+	help
+	  This is new version of kexec system call. This system call is
+	  file based and takes file descriptors as system call argument
+	  for kernel and initramfs as opposed to list of segments as
+	  accepted by previous system call.
+
+	  The kernel to be loaded MUST support Flattened Device Tree
+	  (selected with CONFIG_USE_OF).
+
 config ATAGS_PROC
 	bool "Export atags in procfs"
 	depends on ATAGS && KEXEC
diff --git a/arch/arm/include/asm/image.h b/arch/arm/include/asm/image.h
index 624438740f23..95f23837b04f 100644
--- a/arch/arm/include/asm/image.h
+++ b/arch/arm/include/asm/image.h
@@ -8,8 +8,13 @@
 			 (((x) >>  8) & 0x0000ff00) |  \
 			 (((x) <<  8) & 0x00ff0000) |  \
 			 (((x) << 24) & 0xff000000))
+#define UIMAGE_MAGIC(x) (x)
 #else
 #define ZIMAGE_MAGIC(x) (x)
+#define UIMAGE_MAGIC(x) ((((x) >> 24) & 0x000000ff) | \
+			 (((x) >>  8) & 0x0000ff00) |  \
+			 (((x) <<  8) & 0x00ff0000) |  \
+			 (((x) << 24) & 0xff000000))
 #endif
 
 #define ARM_ZIMAGE_MAGIC1 ZIMAGE_MAGIC(0x016f2818)
@@ -17,6 +22,12 @@
 #define ARM_ZIMAGE_MAGIC3 ZIMAGE_MAGIC(0x5a534c4b)
 #define ARM_ZIMAGE_MAGIC4 ZIMAGE_MAGIC(0x5a534344)
 
+#define ARM_UIMAGE_MAGIC UIMAGE_MAGIC(0x27051956)
+#define ARM_UIMAGE_NAME_LEN		32
+#define ARM_UIMAGE_TYPE_KERNEL		2
+#define ARM_UIMAGE_TYPE_KERNEL_NOLOAD	14
+#define ARM_UIMAGE_ARCH_ARM		2
+
 #ifndef __ASSEMBLY__
 
 #include <linux/types.h>
@@ -33,6 +44,21 @@ struct arm_zimage_header {
 	__le32 extension_tag_offset;
 };
 
+struct arm_uimage_header {
+	__be32 magic;
+	__be32 hdr_crc;
+	__be32 time;
+	__be32 size;
+	__be32 load;
+	__be32 entry;
+	__be32 crc;
+	__u8   os;
+	__u8   arch;
+	__u8   type;
+	__u8   comp;
+	__u8   name[ARM_UIMAGE_NAME_LEN];
+};
+
 struct arm_zimage_tag {
 	struct tag_header hdr;
 	union {
diff --git a/arch/arm/include/asm/kexec.h b/arch/arm/include/asm/kexec.h
index 22751b5b5735..fda35afa7195 100644
--- a/arch/arm/include/asm/kexec.h
+++ b/arch/arm/include/asm/kexec.h
@@ -83,6 +83,20 @@ static inline struct page *boot_pfn_to_page(unsigned long boot_pfn)
 }
 #define boot_pfn_to_page boot_pfn_to_page
 
+#ifdef CONFIG_KEXEC_FILE
+
+extern const struct kexec_file_ops kexec_zimage_ops;
+extern const struct kexec_file_ops kexec_uimage_ops;
+
+struct kimage;
+
+extern int load_other_segments(struct kimage *image,
+		unsigned long kernel_load_addr, unsigned long kernel_size,
+		char *initrd, unsigned long initrd_len,
+		unsigned long initrd_offset, char *cmdline);
+
+#endif /* CONFIG_KEXEC_FILE */
+
 #endif /* __ASSEMBLY__ */
 
 #endif /* CONFIG_KEXEC */
diff --git a/arch/arm/kernel/Makefile b/arch/arm/kernel/Makefile
index 89e5d864e923..466c683bb551 100644
--- a/arch/arm/kernel/Makefile
+++ b/arch/arm/kernel/Makefile
@@ -3,6 +3,7 @@
 # Makefile for the linux kernel.
 #
 
+CFLAGS_kexec_zimage.o := -DTEXT_OFFSET=$(TEXT_OFFSET)
 CPPFLAGS_vmlinux.lds := -DTEXT_OFFSET=$(TEXT_OFFSET)
 AFLAGS_head.o        := -DTEXT_OFFSET=$(TEXT_OFFSET)
 
@@ -56,7 +57,9 @@ obj-$(CONFIG_FUNCTION_TRACER)	+= entry-ftrace.o
 obj-$(CONFIG_DYNAMIC_FTRACE)	+= ftrace.o insn.o patch.o
 obj-$(CONFIG_FUNCTION_GRAPH_TRACER)	+= ftrace.o insn.o patch.o
 obj-$(CONFIG_JUMP_LABEL)	+= jump_label.o insn.o patch.o
-obj-$(CONFIG_KEXEC)		+= machine_kexec.o relocate_kernel.o
+obj-$(CONFIG_KEXEC_CORE)	+= machine_kexec.o relocate_kernel.o
+obj-$(CONFIG_KEXEC_FILE)	+= machine_kexec_file.o kexec_zimage.o	\
+				   kexec_uimage.o
 # Main staffs in KPROBES are in arch/arm/probes/ .
 obj-$(CONFIG_KPROBES)		+= patch.o insn.o
 obj-$(CONFIG_OABI_COMPAT)	+= sys_oabi-compat.o
diff --git a/arch/arm/kernel/kexec_uimage.c b/arch/arm/kernel/kexec_uimage.c
new file mode 100644
index 000000000000..47033574e24e
--- /dev/null
+++ b/arch/arm/kernel/kexec_uimage.c
@@ -0,0 +1,80 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Kexec uImage loader
+ *
+ * Copyright (C) 2020 Samsung Electronics
+ * Author: Łukasz Stelmach <l.stelmach@samsung.com>
+ */
+
+#define pr_fmt(fmt)	"kexec_file(uImage): " fmt
+
+#include <asm/image.h>
+#include <linux/crc32.h>
+#include <linux/err.h>
+#include <linux/kexec.h>
+
+#define crc32_ones(crc, buf, len) \
+	(crc32(crc ^ 0xffffffff, buf, len) ^ 0xffffffff)
+
+static int uimage_probe(const char *uimage_buf, unsigned long uimage_len)
+{
+	const struct arm_uimage_header *h =
+		(struct arm_uimage_header *) uimage_buf;
+	struct arm_uimage_header uhdr;
+	unsigned long zoff = sizeof(struct arm_uimage_header);
+	uint32_t crc;
+
+	if (h->magic != ARM_UIMAGE_MAGIC)
+		return -EINVAL;
+
+	if (h->type != ARM_UIMAGE_TYPE_KERNEL &&
+	    h->type != ARM_UIMAGE_TYPE_KERNEL_NOLOAD){
+		pr_debug("Invalid image type: %d\n", h->type);
+		return -EINVAL;
+	}
+
+	if (h->arch != ARM_UIMAGE_ARCH_ARM) {
+		pr_debug("Invalidy image arch: %d\n", h->arch);
+		return -EINVAL;
+	}
+
+	memcpy((char *)&uhdr, h, sizeof(uhdr));
+	crc = be32_to_cpu(uhdr.hdr_crc);
+	uhdr.hdr_crc = 0;
+
+	if (crc32_ones(0, (char *)&uhdr, sizeof(uhdr)) != crc) {
+		pr_debug("Corrupt header, CRC do not match\n");
+		return -EINVAL;
+	}
+
+	crc = be32_to_cpu(uhdr.crc);
+	if (crc32_ones(0, uimage_buf + zoff, uimage_len - zoff) != crc) {
+		pr_debug("Corrupt zImage, CRC do not match\n");
+		return -EINVAL;
+	}
+
+	return kexec_zimage_ops.probe(uimage_buf + zoff,
+				      uimage_len - zoff);
+}
+
+static void *uimage_load(struct kimage *image,
+				char *uimage, unsigned long uimage_len,
+				char *initrd, unsigned long initrd_len,
+				char *cmdline, unsigned long cmdline_len)
+{
+	const struct arm_uimage_header *h =
+		(struct arm_uimage_header *) uimage;
+	unsigned long zimage_offset = sizeof(struct arm_uimage_header);
+
+	pr_debug("Loading uImage");
+	return kexec_zimage_ops.load(image,
+				     uimage + zimage_offset,
+				     uimage_len - zimage_offset,
+				     initrd, initrd_len,
+				     cmdline, cmdline_len);
+}
+
+const struct kexec_file_ops kexec_uimage_ops = {
+	.probe = uimage_probe,
+	.load = uimage_load,
+};
diff --git a/arch/arm/kernel/kexec_zimage.c b/arch/arm/kernel/kexec_zimage.c
new file mode 100644
index 000000000000..d09795fc9072
--- /dev/null
+++ b/arch/arm/kernel/kexec_zimage.c
@@ -0,0 +1,199 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Kexec zImage loader
+ *
+ * Copyright (C) 2020 Samsung Electronics
+ * Author: Łukasz Stelmach <l.stelmach@samsung.com>
+ */
+
+#define pr_fmt(fmt)	"kexec_file(zImage): " fmt
+
+#include <asm/image.h>
+#include <asm/unaligned.h>
+#include <linux/err.h>
+#include <linux/kexec.h>
+#include <linux/memblock.h>
+
+#define byte_size(t)    ((t)->hdr.size << 2)
+
+static const void *find_extension_tag(const char *buf,
+						       unsigned long len,
+						       uint32_t tag_id)
+{
+	const struct arm_zimage_header *h = (const struct arm_zimage_header *)buf;
+	const struct arm_zimage_tag *tag;
+	uint32_t offset, size;
+	uint32_t max = len - sizeof(struct tag_header);
+
+	if (len < sizeof(*h) ||
+	    h->magic != ARM_ZIMAGE_MAGIC1 ||
+	    h->magic2 != ARM_ZIMAGE_MAGIC2)
+		return NULL;
+
+	for (offset = h->extension_tag_offset;
+	     (tag = (void *)(buf + offset)) != NULL &&
+		     offset < max &&
+		     (size = le32_to_cpu(byte_size(tag))) != 0 &&
+		     offset + size < len;
+	     offset += size) {
+		pr_debug("  offset 0x%08x tag 0x%08x size %u\n",
+			  offset, le32_to_cpu(tag->hdr.tag), size);
+		if (tag->hdr.tag == tag_id)
+			return tag;
+	}
+
+	return NULL;
+}
+
+static int zimage_probe(const char *kernel_buf, unsigned long kernel_len)
+{
+	const struct arm_zimage_header *h =
+		(struct arm_zimage_header *)(kernel_buf);
+
+	if (!h || (kernel_len < sizeof(*h)))
+		return -EINVAL;
+
+	if ((h->magic != ARM_ZIMAGE_MAGIC1) ||
+	    (h->magic2 != ARM_ZIMAGE_MAGIC2))
+		return -EINVAL;
+
+	return 0;
+}
+
+
+#if defined(DEBUG)
+#define debug_offsets() ({			\
+	pr_debug("Image offsets:\n");		\
+	pr_debug("  kernel 0x%08lx 0x%08lx\n", kernel_offset, kernel_len); \
+	pr_debug("  zimage 0x%08lx 0x%08lx\n", zimage_offset, zimage_len); \
+	pr_debug("  initrd 0x%08lx 0x%08lx\n", initrd_offset, initrd_len); \
+})
+#else
+#define debug_offsets()
+#endif
+
+static void *zimage_load(struct kimage *image,
+				char *zimage, unsigned long zimage_len,
+				char *initrd, unsigned long initrd_len,
+				char *cmdline, unsigned long cmdline_len)
+{
+	struct arm_zimage_header *h;
+	struct kexec_buf kbuf;
+	struct kexec_segment *zimage_segment;
+	const struct arm_zimage_tag *klsz_tag;
+	const struct arm_zimage_tag_dc *dcsz_tag;
+	int ret = -EINVAL;
+
+	unsigned long zimage_mem = 0x20000; /* malloc 64kB + stack 4 kB + some bss */
+	unsigned long kernel_len = zimage_len * 4; /* 4:1 compression */
+	unsigned long kernel_offset = memblock_start_of_DRAM() +
+		ALIGN(TEXT_OFFSET, PAGE_SIZE);
+	unsigned long zimage_offset = kernel_offset +
+		ALIGN(kernel_len, PAGE_SIZE);
+	unsigned long initrd_offset = zimage_offset +
+		ALIGN(zimage_len + zimage_mem, PAGE_SIZE);
+
+	if (image->type == KEXEC_TYPE_CRASH) {
+		kernel_offset += crashk_res.start;
+		zimage_offset += crashk_res.start;
+		initrd_offset += crashk_res.start;
+	}
+	debug_offsets();
+
+	h = (struct arm_zimage_header *)zimage;
+
+	klsz_tag = find_extension_tag(zimage, zimage_len, ZIMAGE_TAG_KRNL_SIZE);
+	if (klsz_tag) {
+		uint32_t *p = (void *)zimage +
+			le32_to_cpu(klsz_tag->u.krnl_size.size_ptr);
+		uint32_t edata_size = le32_to_cpu(get_unaligned(p));
+		uint32_t bss_size = le32_to_cpu(klsz_tag->u.krnl_size.bss_size);
+
+		kernel_len = edata_size + bss_size;
+
+		pr_debug("Decompressed kernel sizes:\n");
+		pr_debug(" text+data 0x%08lx bss 0x%08lx total 0x%08lx\n",
+			 (unsigned long)edata_size,
+			 (unsigned long)bss_size,
+			 (unsigned long)kernel_len);
+
+		zimage_offset = kernel_offset + ALIGN(edata_size, PAGE_SIZE);
+		initrd_offset = zimage_offset +
+			max(ALIGN(zimage_len + 0x20000, PAGE_SIZE),
+			    ALIGN((unsigned long)bss_size, PAGE_SIZE));
+		debug_offsets();
+	}
+
+	dcsz_tag = find_extension_tag(zimage, zimage_len,
+				      ZIMAGE_TAG_DECOMP_SIZE);
+	if (dcsz_tag) {
+		uint32_t bss_size = le32_to_cpu(dcsz_tag->u.decomp_size.bss_size);
+		uint32_t stack_size = le32_to_cpu(dcsz_tag->u.decomp_size.stack_size);
+		uint32_t malloc_size = le32_to_cpu(dcsz_tag->u.decomp_size.malloc_size);
+
+		zimage_mem = bss_size + stack_size + malloc_size;
+
+		pr_debug("Decompressor memory requirements:\n");
+		pr_debug(" bss 0x%08lx stack 0x%08lx malloc 0x%08lx total 0x%08lx\n",
+			 (unsigned long)bss_size,
+			 (unsigned long)stack_size,
+			 (unsigned long)malloc_size,
+			 zimage_mem);
+
+		initrd_offset = max(ALIGN(zimage_offset + zimage_len +
+					  bss_size + stack_size +
+					  malloc_size, PAGE_SIZE),
+				    ALIGN(kernel_offset + kernel_len, PAGE_SIZE));
+		debug_offsets();
+	}
+
+	/*
+	 * zImage MUST be loaded into the first 128 MiB of physical
+	 * memory for proper memory detection. Should the uncompressed
+	 * kernel be larger than 128 MiB, zImage relocation becomes
+	 * unavoidable and it is best to rely on the relocation code.
+	 */
+	if (((zimage_offset - kernel_offset) + PAGE_SIZE + 0x8000) >= SZ_128M) {
+		pr_debug("The kernel is too big (%ld MiB) to avoid "
+			 "zImage relocation. Loading zimage at 0x%08lx\n",
+			 ((zimage_offset - kernel_offset) >> 20),
+			 kernel_offset);
+		zimage_offset = kernel_offset;
+	}
+
+	kbuf.image = image;
+	kbuf.top_down = false;
+
+	kbuf.buf_min = zimage_offset;
+	kbuf.buf_max = ULONG_MAX;
+	kbuf.buffer = zimage;
+	kbuf.bufsz = zimage_len;
+	kbuf.buf_align = PAGE_SIZE;
+
+	kbuf.mem = KEXEC_BUF_MEM_UNKNOWN;
+	kbuf.memsz = zimage_len;
+
+	ret = kexec_add_buffer(&kbuf);
+	if (ret)
+		return ERR_PTR(ret);
+
+	pr_debug("Loaded zImage at 0x%lx bufsz=0x%lx memsz=0x%lx\n",
+		 kbuf.mem, kbuf.bufsz, kbuf.memsz);
+
+	initrd_offset += kbuf.mem - zimage_offset;
+	debug_offsets();
+
+	zimage_segment = &image->segment[image->nr_segments - 1];
+	image->start = zimage_segment->mem;
+
+	ret = load_other_segments(image,
+				  zimage_segment->mem, zimage_segment->memsz,
+				  initrd, initrd_len, initrd_offset,
+				  cmdline);
+	return ERR_PTR(ret);
+}
+
+const struct kexec_file_ops kexec_zimage_ops = {
+	.probe = zimage_probe,
+	.load = zimage_load,
+};
diff --git a/arch/arm/kernel/machine_kexec.c b/arch/arm/kernel/machine_kexec.c
index c10a2dfd53d1..2e4780efabb4 100644
--- a/arch/arm/kernel/machine_kexec.c
+++ b/arch/arm/kernel/machine_kexec.c
@@ -93,10 +93,13 @@ int machine_kexec_prepare(struct kimage *image)
 					       current_segment->memsz))
 			return -EINVAL;
 
-		err = get_user(header, (__be32*)current_segment->buf);
-		if (err)
-			return err;
-
+		if (image->file_mode) {
+			header = *(__be32 *)current_segment->buf;
+		} else {
+			err = get_user(header, (__be32 *)current_segment->buf);
+			if (err)
+				return err;
+		}
 		if (header == cpu_to_be32(OF_DT_HEADER))
 			image->arch.kernel_r2 = current_segment->mem;
 	}
diff --git a/arch/arm/kernel/machine_kexec_file.c b/arch/arm/kernel/machine_kexec_file.c
new file mode 100644
index 000000000000..ead680f1e795
--- /dev/null
+++ b/arch/arm/kernel/machine_kexec_file.c
@@ -0,0 +1,209 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * kexec_file for arm
+ *
+ * Copyright (C) 2018 Linaro Limited
+ * Copyright (C) 2020 Samsung Electronics
+ * Authors:
+ *     AKASHI Takahiro <takahiro.akashi@linaro.org>
+ *     Łukasz Stelmach <l.stelmach@samsung.com>
+ *
+ */
+
+#define pr_fmt(fmt) "kexec_file: " fmt
+
+#include <linux/kexec.h>
+#include <linux/libfdt.h>
+#include <linux/of_fdt.h>
+#include <linux/random.h>
+
+/* relevant device tree properties */
+#define FDT_PROP_INITRD_START	"linux,initrd-start"
+#define FDT_PROP_INITRD_END	"linux,initrd-end"
+#define FDT_PROP_BOOTARGS	"bootargs"
+#define FDT_PROP_RNG_SEED	"rng-seed"
+
+static int setup_dtb(struct kimage *image,
+		     unsigned long initrd_load_addr, unsigned long initrd_len,
+		     char *cmdline, void *dtb)
+{
+	int off, ret;
+
+	ret = fdt_path_offset(dtb, "/chosen");
+	if (ret < 0)
+		goto out;
+
+	off = ret;
+
+	/* add bootargs */
+	if (cmdline) {
+		ret = fdt_setprop_string(dtb, off, FDT_PROP_BOOTARGS, cmdline);
+		if (ret)
+			goto out;
+	} else {
+		ret = fdt_delprop(dtb, off, FDT_PROP_BOOTARGS);
+		if (ret && (ret != -FDT_ERR_NOTFOUND))
+			goto out;
+	}
+
+	/* add initrd-* */
+	if (initrd_load_addr) {
+		ret = fdt_setprop_u64(dtb, off, FDT_PROP_INITRD_START,
+				      initrd_load_addr);
+		if (ret)
+			goto out;
+
+		ret = fdt_setprop_u64(dtb, off, FDT_PROP_INITRD_END,
+				      initrd_load_addr + initrd_len);
+		if (ret)
+			goto out;
+	} else {
+		ret = fdt_delprop(dtb, off, FDT_PROP_INITRD_START);
+		if (ret && (ret != -FDT_ERR_NOTFOUND))
+			goto out;
+
+		ret = fdt_delprop(dtb, off, FDT_PROP_INITRD_END);
+		if (ret && (ret != -FDT_ERR_NOTFOUND))
+			goto out;
+	}
+
+	/* add rng-seed */
+	if (rng_is_initialized()) {
+		char seed[128];
+		get_random_bytes(seed, sizeof(seed));
+
+		ret = fdt_setprop(dtb, off, FDT_PROP_RNG_SEED,
+				  seed, sizeof(seed));
+		if (ret)
+			goto out;
+	} else {
+		pr_notice("RNG is not initialised: omitting \"%s\" property\n",
+				FDT_PROP_RNG_SEED);
+		ret = 0;
+	}
+
+out:
+	if (ret)
+		return (ret == -FDT_ERR_NOSPACE) ? -ENOMEM : -EINVAL;
+
+	return 0;
+}
+/*
+ * More space needed so that we can add initrd, bootargs and kaslr-seed.
+ */
+#define DTB_EXTRA_SPACE 0x1000
+
+static int create_dtb(struct kimage *image,
+		      unsigned long initrd_load_addr, unsigned long initrd_len,
+		      char *cmdline, void **dtb)
+{
+	void *buf;
+	size_t buf_size;
+	size_t cmdline_len;
+	int ret;
+
+	cmdline_len = cmdline ? strlen(cmdline) : 0;
+	buf_size = fdt_totalsize(initial_boot_params)
+			+ cmdline_len + DTB_EXTRA_SPACE;
+
+	for (;;) {
+		buf = vmalloc(buf_size);
+		if (!buf)
+			return -ENOMEM;
+
+		/* duplicate a device tree blob */
+		ret = fdt_open_into(initial_boot_params, buf, buf_size);
+		if (ret)
+			return -EINVAL;
+
+		ret = setup_dtb(image, initrd_load_addr, initrd_len,
+				cmdline, buf);
+		if (ret) {
+			vfree(buf);
+			if (ret == -ENOMEM) {
+				/* unlikely, but just in case */
+				buf_size += DTB_EXTRA_SPACE;
+				continue;
+			} else {
+				return ret;
+			}
+		}
+
+		/* trim it */
+		fdt_pack(buf);
+		*dtb = buf;
+
+		return 0;
+	}
+}
+
+int load_other_segments(struct kimage *image,
+			unsigned long zimage_load_addr,
+			unsigned long zimage_len,
+			char *initrd,
+			unsigned long initrd_len,
+			unsigned long initrd_offset,
+			char *cmdline)
+{
+	struct kexec_buf kbuf;
+	void *dtb = NULL;
+	unsigned long initrd_load_addr = 0;
+	unsigned long dtb_len;
+	int ret = 0;
+
+	kbuf.image = image;
+	/* not allocate anything below the kernel */
+	kbuf.buf_min = initrd_offset;
+	if (initrd) {
+		kbuf.buffer = initrd;
+		kbuf.bufsz = initrd_len;
+		kbuf.mem = KEXEC_BUF_MEM_UNKNOWN;
+		kbuf.memsz = initrd_len;
+		kbuf.buf_align = PAGE_SIZE;
+		kbuf.buf_max = ULONG_MAX;
+		kbuf.top_down = false;
+
+		ret = kexec_add_buffer(&kbuf);
+		if (ret)
+			goto out_err;
+
+		pr_debug("Loaded initrd at 0x%lx bufsz=0x%lx memsz=0x%lx\n",
+				kbuf.mem, kbuf.bufsz, kbuf.memsz);
+
+		initrd_load_addr = kbuf.mem;
+		kbuf.buf_min = initrd_load_addr + kbuf.memsz;
+	}
+
+	/* load dtb */
+	ret = create_dtb(image, initrd_load_addr, initrd_len, cmdline, &dtb);
+	if (ret) {
+		pr_err("Preparing for new dtb failed\n");
+		goto out_err;
+	}
+
+	dtb_len = fdt_totalsize(dtb);
+	kbuf.buffer = dtb;
+	kbuf.bufsz = dtb_len;
+	kbuf.mem = KEXEC_BUF_MEM_UNKNOWN;
+	kbuf.memsz = dtb_len;
+	kbuf.buf_align = PAGE_SIZE;
+	kbuf.buf_max = ULONG_MAX;
+	kbuf.top_down = false;
+
+	ret = kexec_add_buffer(&kbuf);
+	if (ret)
+		goto out_err;
+
+	pr_debug("Loaded dtb at 0x%lx bufsz=0x%lx memsz=0x%lx\n",
+		 kbuf.mem, kbuf.bufsz, kbuf.memsz);
+	return 0;
+out_err:
+	vfree(dtb);
+	return ret;
+}
+
+const struct kexec_file_ops * const kexec_file_loaders[] = {
+	&kexec_uimage_ops,
+	&kexec_zimage_ops,
+	NULL
+};
-- 
2.26.2

