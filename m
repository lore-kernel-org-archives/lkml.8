Return-Path: <SRS0=4zup=3T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6E07C35240
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Jan 2020 12:43:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 98AE3214D8
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Jan 2020 12:43:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="GxjEgzKJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727276AbgA3MnS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Jan 2020 07:43:18 -0500
Received: from mailout2.w1.samsung.com ([210.118.77.12]:56412 "EHLO
        mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727201AbgA3MnS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Jan 2020 07:43:18 -0500
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20200130124316euoutp02f653f2ba71e77090085950b61f475388~uqrDrUQdD0709507095euoutp02j
        for <linux-kernel@vger.kernel.org>; Thu, 30 Jan 2020 12:43:16 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20200130124316euoutp02f653f2ba71e77090085950b61f475388~uqrDrUQdD0709507095euoutp02j
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1580388196;
        bh=lT1I19NYIZKRT4a1vnKJnFS8PvPg81U0RYirnuIE4as=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=GxjEgzKJINoygEsVV6sN0v/n9E/krYy9QvIo0DqaZiS30WfdjX2NxFcpva+7r3bH9
         WlOexxyGAlk9cVfO4g/MS0dUXNftPiQtnJfWtUnzrIJXWExgqBhFtTr8xLgpaRv/HA
         ERQs3Cr+0tYTE6GcsCpkhOcmgdSDHE72pYraK68w=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20200130124315eucas1p195c03b5901c94e88a3a5ebb207e6a12c~uqrDfR3sX1976019760eucas1p1C;
        Thu, 30 Jan 2020 12:43:15 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges3new.samsung.com (EUCPMTA) with SMTP id 27.BA.60698.36FC23E5; Thu, 30
        Jan 2020 12:43:15 +0000 (GMT)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20200130124315eucas1p12d5380c44b68d08ae96849056303e175~uqrDPNpNZ0696206962eucas1p1m;
        Thu, 30 Jan 2020 12:43:15 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20200130124315eusmtrp1b7fee25bcd3170c976aa8c63f9fa3529~uqrDOnwd22256122561eusmtrp1E;
        Thu, 30 Jan 2020 12:43:15 +0000 (GMT)
X-AuditID: cbfec7f5-a29ff7000001ed1a-76-5e32cf638755
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id 54.6D.07950.36FC23E5; Thu, 30
        Jan 2020 12:43:15 +0000 (GMT)
Received: from localhost (unknown [106.120.51.46]) by eusmtip2.samsung.com
        (KnoxPortal) with ESMTPA id
        20200130124315eusmtip2bad2ce430c110ffce79aaf6e8db206ad~uqrDBgM2d1616616166eusmtip2L;
        Thu, 30 Jan 2020 12:43:15 +0000 (GMT)
From:   =?UTF-8?q?=C5=81ukasz=20Stelmach?= <l.stelmach@samsung.com>
To:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org
Cc:     =?UTF-8?q?=C5=81ukasz=20Stelmach?= <l.stelmach@samsung.com>
Subject: [RFC PATCH 4/4] boot/loader: Enable building bootloader replacement
 for Odroid XU4
Date:   Thu, 30 Jan 2020 13:42:33 +0100
Message-Id: <20200130124233.4006-4-l.stelmach@samsung.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200130124233.4006-1-l.stelmach@samsung.com>
MIME-Version: 1.0
Organization: Samsung R&D Institute Poland
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFmphleLIzCtJLcpLzFFi42LZduzned3k80ZxBq8eGlvcPLSC0WLT42us
        Fpd3zWGzmHF+H5MDi8fmJfUefVtWMXp83iQXwBzFZZOSmpNZllqkb5fAlbHt6lr2gk8TGSse
        N79kbmBcU9nFyMkhIWAiseX0JJYuRi4OIYEVjBKndr1khnC+MEpcb1zOCOF8ZpQ4OnMBUIYD
        rGXyKx+I+HJGiTNzZ0J1PGeU6D7xnQ1kLpuAo0T/0hOsILaIQLbE5I9fmEBsZgF7iYmz/oPV
        CAvESnw+uAqshkVAVeLyqlYWEJtXwEpiwb7ZTBD3yUuc713HDmJzClhLfFz9mxWiRlDi5Mwn
        YPX8AloSa5qus0DMl5do3job7CAJgW52iTMXjrNBDHKRuHf6DDOELSzx6vgWdghbRuL05B4W
        iM/qJSZPMoPo7WGU2DbnBwtEjbXEnXO/2EBqmAU0Jdbv0ocIO0pMPzePHaKVT+LGW0GIE/gk
        Jm2bDg0rXomONiGIahWJdf17oAZKSfS+WsE4gVFpFpJnZiF5YBbCrgWMzKsYxVNLi3PTU4uN
        81LL9YoTc4tL89L1kvNzNzEC08bpf8e/7mDc9yfpEKMAB6MSD++Cc0ZxQqyJZcWVuYcYJTiY
        lUR4RV0N44R4UxIrq1KL8uOLSnNSiw8xSnOwKInzGi96GSskkJ5YkpqdmlqQWgSTZeLglGpg
        lNXzWuFZURfPtVP0Lk+BxdfjHYwmAh1Mb6KXf/c8pqgt+KPENPSLQqNY23n+M41KBouO8/x5
        6Ssm3vImzUHmaiPnnN7DnQ3uJvvdrU/8uGBWyFF180982a4lJrnHxPNnpiesuzLxpVbL+ae5
        X9fZOvnFzHI8fzmK22xTc9iOKWUFs+smGh5QYinOSDTUYi4qTgQA8oUO6hcDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprCIsWRmVeSWpSXmKPExsVy+t/xe7rJ543iDN6vlre4eWgFo8Wmx9dY
        LS7vmsNmMeP8PiYHFo/NS+o9+rasYvT4vEkugDlKz6Yov7QkVSEjv7jEVina0MJIz9DSQs/I
        xFLP0Ng81srIVEnfziYlNSezLLVI3y5BL2Pb1bXsBZ8mMlY8bn7J3MC4prKLkYNDQsBEYvIr
        ny5GLg4hgaWMEo//PmSBiEtJrJyb3sXICWQKS/y51sUGUfOUUaJhz0I2kASbgKNE/9ITrCC2
        iECuxLVDR9lBbGYBe4mJs/6D1QgLREvcudYLFmcRUJW4vKqVBcTmFbCSWLBvNhPEAnmJ873r
        wGo4BawlPq7+DTZTSCBbomvPK0aIekGJkzOfgN3GLKAusX6eEEiYX0BLYk3TdRaItfISzVtn
        M09gFJqFpGMWQscsJFULGJlXMYqklhbnpucWG+kVJ+YWl+al6yXn525iBMbItmM/t+xg7HoX
        fIhRgINRiYfX44xRnBBrYllxZe4hRgkOZiURXlFXwzgh3pTEyqrUovz4otKc1OJDjKZAb05k
        lhJNzgfGb15JvKGpobmFpaG5sbmxmYWSOG+HwMEYIYH0xJLU7NTUgtQimD4mDk6pBsaTkh/S
        kmoiPjyzeavk5x39/Okk9/2/q1yvKhy/uv7YUzbnk9UF2WvUZZpUF+4VUTp+NZDD/2Ja/OIZ
        lhNuMPYoB97cavRibe6dpY55yU3Vl2+IV0d8uqviZHd4bY9222Yv3tiJp9omNnEqvG2KVDPZ
        /HPa4n7h99oH79TqlmhfT2VhTOMJ5VBiKc5INNRiLipOBAAsOc8cpwIAAA==
X-CMS-MailID: 20200130124315eucas1p12d5380c44b68d08ae96849056303e175
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20200130124315eucas1p12d5380c44b68d08ae96849056303e175
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20200130124315eucas1p12d5380c44b68d08ae96849056303e175
References: <20200130123934.3900-1-l.stelmach@samsung.com>
        <20200130124233.4006-1-l.stelmach@samsung.com>
        <CGME20200130124315eucas1p12d5380c44b68d08ae96849056303e175@eucas1p1.samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This code enables booting of Linux kernel on Odroid XU4 without u-boot

Signed-off-by: Łukasz Stelmach <l.stelmach@samsung.com>
---
 arch/arm/Kconfig                              |   8 ++
 arch/arm/Makefile                             |   8 +-
 arch/arm/boot/Makefile                        |  17 +++
 arch/arm/boot/loader/Kconfig                  |  23 +++
 arch/arm/boot/loader/Makefile                 |  42 ++++++
 arch/arm/boot/loader/odroid-console.c         | 136 ++++++++++++++++++
 arch/arm/boot/loader/odroid-crt0.S            |  40 ++++++
 arch/arm/boot/loader/piggy.S                  |  14 ++
 arch/arm/boot/loader/vectors.S                | 112 +++++++++++++++
 arch/arm/boot/loader/vmlinux.lds              |  17 +++
 .../configs/odroidxu4_bootloader_defconfig    | 127 ++++++++++++++++
 11 files changed, 543 insertions(+), 1 deletion(-)
 create mode 100644 arch/arm/boot/loader/Kconfig
 create mode 100644 arch/arm/boot/loader/Makefile
 create mode 100644 arch/arm/boot/loader/odroid-console.c
 create mode 100644 arch/arm/boot/loader/odroid-crt0.S
 create mode 100644 arch/arm/boot/loader/piggy.S
 create mode 100644 arch/arm/boot/loader/vectors.S
 create mode 100644 arch/arm/boot/loader/vmlinux.lds
 create mode 100644 arch/arm/configs/odroidxu4_bootloader_defconfig

diff --git arch/arm/Kconfig arch/arm/Kconfig
index 96dab76da3b3..576d90071ba5 100644
--- arch/arm/Kconfig
+++ arch/arm/Kconfig
@@ -1715,6 +1715,13 @@ endmenu
 
 menu "Boot options"
 
+menu "Bootloader"
+	depends on BLK_DEV_INITRD
+
+source "arch/arm/boot/loader/Kconfig"
+
+endmenu
+
 config USE_OF
 	bool "Flattened Device Tree support"
 	select IRQ_DOMAIN
@@ -1982,6 +1989,7 @@ config DMI
 	  firmware need to be enabled. This would require the DMI subsystem
 	  to be enabled much earlier than we do on ARM, which is non-trivial.
 
+
 endmenu
 
 menu "CPU Power Management"
diff --git arch/arm/Makefile arch/arm/Makefile
index db857d07114f..0c2c3d0039ec 100644
--- arch/arm/Makefile
+++ arch/arm/Makefile
@@ -328,11 +328,17 @@ archprepare:
 # Convert bzImage to zImage
 bzImage: zImage
 
-BOOT_TARGETS	= zImage Image xipImage bootpImage uImage
+BOOT_TARGETS	= zImage Image xipImage bootImage bootpImage uImage
 INSTALL_TARGETS	= zinstall uinstall install
 
 PHONY += bzImage $(BOOT_TARGETS) $(INSTALL_TARGETS)
 
+ifeq ($(compress-y),)
+bootImage: Image
+else
+bootImage: zImage
+endif
+
 bootpImage uImage: zImage
 zImage: Image
 
diff --git arch/arm/boot/Makefile arch/arm/boot/Makefile
index 0b3cd7a33a26..20fc5cccaa1e 100644
--- arch/arm/boot/Makefile
+++ arch/arm/boot/Makefile
@@ -66,8 +66,25 @@ $(obj)/compressed/vmlinux: $(obj)/Image FORCE
 $(obj)/zImage:	$(obj)/compressed/vmlinux FORCE
 	$(call if_changed,objcopy)
 
+compress-$(CONFIG_KERNEL_GZIP) = gzip
+compress-$(CONFIG_KERNEL_LZO)  = lzo
+compress-$(CONFIG_KERNEL_LZMA) = lzma
+compress-$(CONFIG_KERNEL_XZ)   = xzkern
+compress-$(CONFIG_KERNEL_LZ4)  = lz4
+
+ifeq ($(compress-y),)
+$(obj)/loader/vmlinux: $(obj)/Image dtbs FORCE
+	$(Q)$(MAKE) $(build)=$(obj)/loader $@
+else
+$(obj)/loader/vmlinux: $(obj)/zImage FORCE
+	$(Q)$(MAKE) $(build)=$(obj)/loader $@
+endif
+
 endif
 
+$(obj)/bootImage: $(obj)/loader/vmlinux FORCE
+	$(call if_changed,objcopy)
+
 ifneq ($(LOADADDR),)
   UIMAGE_LOADADDR=$(LOADADDR)
 else
diff --git arch/arm/boot/loader/Kconfig arch/arm/boot/loader/Kconfig
new file mode 100644
index 000000000000..bc69bf59241a
--- /dev/null
+++ arch/arm/boot/loader/Kconfig
@@ -0,0 +1,23 @@
+choice
+  prompt "Select platform to boot"
+
+  config BOOT_LOADER_XU4
+    bool "Odroid XU4"
+    depends on ARCH_EXYNOS5
+    help
+      Build a kernel loadable by XU4 firmware
+
+  config BOOT_LOADER_XU3
+    bool "Odroid XU3"
+    depends on ARCH_EXYNOS5
+    help
+      Build a kernel loadable by XU3 firmware
+endchoice
+
+config BOOT_LOADER_PLATFORM
+  string
+  default exynos5422-odroidxu4 if BOOT_LOADER_XU4
+  default exynos5422-odroidxu3 if BOOT_LOADER_XU3
+  default ""
+
+
diff --git arch/arm/boot/loader/Makefile arch/arm/boot/loader/Makefile
new file mode 100644
index 000000000000..014ccbf6885a
--- /dev/null
+++ arch/arm/boot/loader/Makefile
@@ -0,0 +1,42 @@
+# SPDX-License-Identifier: GPL-2.0
+#
+# linux/arch/arm/boot/loader/Makefile
+#
+# create a bootable image for selected platform
+#
+
+
+DTB  := $(subst $(quote),,$(obj)/../dts/$(CONFIG_BOOT_LOADER_PLATFORM).dtb)
+OBJS =
+
+loader-$(CONFIG_BOOT_LOADER_XU3) = odroid-console.o odroid-crt0.o
+loader-$(CONFIG_BOOT_LOADER_XU4) = odroid-console.o odroid-crt0.o
+
+compress-$(CONFIG_KERNEL_GZIP) = gzip
+compress-$(CONFIG_KERNEL_LZO)  = lzo
+compress-$(CONFIG_KERNEL_LZMA) = lzma
+compress-$(CONFIG_KERNEL_XZ)   = xzkern
+compress-$(CONFIG_KERNEL_LZ4)  = lz4
+
+ifeq ($(compress-y),)
+IMAGE = $(obj)/../Image
+else
+IMAGE = $(obj)/../zImage
+endif
+AFLAGS_piggy.o	= -DIMAGE=\"$(IMAGE)\" -DFDT=\"$(DTB)\"
+
+$(obj)/piggy.o: $(IMAGE) $(DTB)
+
+CFLAGS_odroid-console.o = -D__UART_BASE=$(shell $(srctree)/scripts/get_console_base.pl $(obj)/../dts/$(CONFIG_BOOT_LOADER_PLATFORM).dtb)
+
+targets		:= vmlinux
+
+LDFLAGS_vmlinux =
+# Next argument is a linker script
+LDFLAGS_vmlinux += -Ttext 0x43E00000 -T
+
+targets		:= vmlinux vectors.o piggy.o $(loader-y)
+
+$(obj)/vmlinux: $(obj)/vmlinux.lds $(obj)/vectors.o $(addprefix $(obj)/, $(loader-y)) \
+		$(obj)/piggy.o FORCE
+	$(call if_changed,ld)
diff --git arch/arm/boot/loader/odroid-console.c arch/arm/boot/loader/odroid-console.c
new file mode 100644
index 000000000000..40dec77fd0ed
--- /dev/null
+++ arch/arm/boot/loader/odroid-console.c
@@ -0,0 +1,136 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/* Copyright (c) 2020 Samsung Electronics, Co. Ltd. */
+
+#include <asm/io.h>
+
+/* Dummy functions to avoid linker complaints */
+void __aeabi_unwind_cpp_pr0(void)
+{
+};
+#define arm_heavy_mb()
+
+#define GPIO_BASE	((void*)0x14010000)
+#define GPA1CON	(GPIO_BASE + 0x20)
+#define GPA1DAT	(GPIO_BASE + 0x24)
+#define GPA1PUD	(GPIO_BASE + 0x28)
+#define GPA1DRV_SR	(GPIO_BASE + 0x2c)
+#define GPA1CONPDN	(GPIO_BASE + 0x20)
+#define GPA1PUDPDN	(GPIO_BASE + 0x24)
+
+#define GPA1CON0_UART2RX	(0x2 << 0)
+#define GPA1CON1_UART2TX	(0x2 << 4)
+#define GPA1CON2_UART2CTS	(0x2 << 8)
+#define GPA1CON3_UART2RTS	(0x2 << 12)
+
+#define GPA1_UART2MASK		(0xffff)
+#define GPA1PUD_UART2MASK	(0xff)
+
+#ifndef __UART_BASE
+#error __UART_BASE not defined
+#else
+#define UART_BASE ((void*)__UART_BASE)
+#endif
+
+#define S3C2410_ULCON		(0x00)
+#define S3C2410_UCON		(0x04)
+#define S3C2410_UFCON		(0x08)
+#define S3C2410_UMCON		(0x0C)
+#define S3C2410_UBRDIV		(0x28)
+#define S3C2410_FRACVAL	(0x2C)
+
+#define UART_ULCON	(UART_BASE + S3C2410_ULCON)
+#define UART_UCON	(UART_BASE + S3C2410_UCON)
+#define UART_UFCON	(UART_BASE + S3C2410_UFCON)
+#define UART_UMCON	(UART_BASE + S3C2410_UMCON)
+#define UART_UBRDIV	(UART_BASE + S3C2410_UBRDIV)
+#define UART_UFRACVAL	(UART_BASE + S3C2410_FRACVAL)
+
+#define S5PV210_ULCON_CS5	(0)
+#define S5PV210_ULCON_CS6	(1)
+#define S5PV210_ULCON_CS7	(2)
+#define S5PV210_ULCON_CS8	(3)
+#define S5PV210_ULCON_CSTOPB	(1 << 2) /* two stop bits */
+#define S5PV210_ULCON_PARODD	(4 << 3) /* parity check: odd */
+#define S5PV210_ULCON_PAREVN	(5 << 3) /* parity check: even */
+#define S5PV210_ULCON_IRDA	(1 << 6) /* Infrared Mode */
+#define S5PV210_ULCON_DEFAULT	(S5PV210_ULCON_CS8) /* 8N1 */
+
+#define S3C2410_UCON_RXIRQMODE		(1<<0)
+#define S3C2410_UCON_TXIRQMODE		(1<<2)
+#define S3C2410_UCON_SBREAK		(1<<4)
+#define S3C2443_UCON_LOOPBACK		(1<<5)
+#define S3C2443_UCON_RXERR_IRQEN	(1<<6)
+#define S3C2410_UCON_RXFIFO_TOI	(1<<7)
+#define S3C2410_UCON_RXILEVEL		(1<<8)
+#define S3C2410_UCON_TXILEVEL		(1<<9)
+#define S5PV210_UCON_DEFAULT		( \
+					 S3C2410_UCON_RXIRQMODE |	\
+					 S3C2410_UCON_TXIRQMODE |   \
+					 S3C2443_UCON_RXERR_IRQEN | 0)
+
+#define S3C2410_UFCON_FIFOMODE		(1<<0)
+#define S3C2410_UFCON_RESETRX		(1<<1)
+#define S3C2410_UFCON_RESETTX		(1<<2)
+#define S3C2410_UFCON_RESETBOTH	(3<<1)
+
+#define S5PV210_UFCON_DEFAULT	(S3C2410_UFCON_FIFOMODE |	\
+				 S3C2410_UFCON_RESETBOTH)
+
+
+/* CLK_SRC_PERIC0 */
+#define PWM_SEL	6
+#define UART3_SEL	6
+#define UART2_SEL	6
+#define UART1_SEL	6
+#define UART0_SEL	6
+/* SRC_CLOCK = SCLK_MPLL */
+#define CLK_SRC_PERIC0_VAL	((PWM_SEL << 24)	\
+				| (UART3_SEL << 12)	\
+				| (UART2_SEL << 8)	 \
+				| (UART1_SEL << 4)	\
+				| (UART0_SEL))
+
+
+#define UART5_RATIO	7
+#define UART4_RATIO	7
+#define UART3_RATIO	7
+#define UART2_RATIO	7
+#define UART1_RATIO	7
+#define UART0_RATIO	7
+
+#define CLK_DIV_PERIC0_VAL	((UART3_RATIO << 12)	\
+				| (UART2_RATIO << 8)	\
+				| (UART1_RATIO << 4)	\
+				| (UART0_RATIO))
+
+
+#define CLK_SRC_PERIC0 (0x10020250)
+#define CLK_DIV_PERIC0 (0x10020558)
+
+void console_on(void) {
+	int a;
+	a = readl(GPA1CON);
+	a = (a & ~GPA1_UART2MASK) |
+		GPA1CON0_UART2RX |
+		GPA1CON1_UART2TX |
+		GPA1CON2_UART2CTS |
+		GPA1CON3_UART2RTS;
+	writel(a, GPA1CON);
+
+	a = readl(GPA1PUD) & ~GPA1PUD_UART2MASK;
+	writel(a, GPA1PUD);
+
+	/* UART2_SEL: SCLK_MPLL (3)*/
+	/* MPLL_M: 266 */
+	/* MPLL_P: 3 */
+	/* MPLL_S: 2 */
+	/* UART2_RATIO: 9 */
+
+	writel(S5PV210_UFCON_DEFAULT, UART_UFCON);
+	writel(0, UART_UMCON);
+	writel(S5PV210_ULCON_DEFAULT, UART_ULCON);
+	writel(S5PV210_UCON_DEFAULT, UART_UCON);
+
+	writel(0x1b, UART_UBRDIV);
+	writel(0x0d, UART_UFRACVAL);
+}
diff --git arch/arm/boot/loader/odroid-crt0.S arch/arm/boot/loader/odroid-crt0.S
new file mode 100644
index 000000000000..586bb8e18d78
--- /dev/null
+++ arch/arm/boot/loader/odroid-crt0.S
@@ -0,0 +1,40 @@
+/*
+ *  crt0 - C-runtime startup Code for ARM
+ *
+ *  Copyright (c) 2012  Albert ARIBAUD <albert.u.boot@aribaud.net>
+ *  Copyright (c) 2020  Samsung Electronics, Co. Ltd.
+ *
+ * SPDX-License-Identifier:	GPL-2.0
+ */
+
+#include <linux/linkage.h>
+
+splash:	.asciz "boot/loader\r\n\7"
+/*
+ * entry point of crt0 sequence
+ */
+	.arm
+ENTRY(_main)
+	ldr	sp, =user_stack_end
+	bl	console_on
+	mov	r0,  #0x12C00000
+	add	r0, r0, #0x20000
+	adr	r2, splash
+_putc:	ldrb	r1, [r2]
+	teq	r1, #0
+	beq	_done
+	strb	r1, [r0, #0x20] /* UTXH */
+	add	r2, r2, #1
+	b	_putc
+_done:
+	mov	r0, #0
+	mov     r1, #~0
+	ldr	r2, =dt_blob_start
+ 	b	zImage
+ENDPROC(_main)
+
+
+	.align 2
+	.section ".stack", "aw", %nobits
+user_stack:	.space  64
+user_stack_end:
diff --git arch/arm/boot/loader/piggy.S arch/arm/boot/loader/piggy.S
new file mode 100644
index 000000000000..ae0c9f770741
--- /dev/null
+++ arch/arm/boot/loader/piggy.S
@@ -0,0 +1,14 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+	.section .piggydata,#alloc
+	.align  12
+	.globl  dt_blob_start
+dt_blob_start:
+	.incbin FDT
+	.globl dt_blob_end
+dt_blob_end:
+	.align 12
+	.globl	zImage
+zImage:
+        .incbin IMAGE
+	.globl	zImage_end
+zImage_end:
diff --git arch/arm/boot/loader/vectors.S arch/arm/boot/loader/vectors.S
new file mode 100644
index 000000000000..744ee4625b6e
--- /dev/null
+++ arch/arm/boot/loader/vectors.S
@@ -0,0 +1,112 @@
+/*
+ *  vectors - Generic ARM exception table code
+ *
+ *  Copyright (c) 1998	Dan Malek <dmalek@jlc.net>
+ *  Copyright (c) 1999	Magnus Damm <kieraypc01.p.y.kie.era.ericsson.se>
+ *  Copyright (c) 2000	Wolfgang Denk <wd@denx.de>
+ *  Copyright (c) 2001	Alex Züpke <azu@sysgo.de>
+ *  Copyright (c) 2001	Marius Gröger <mag@sysgo.de>
+ *  Copyright (c) 2002	Alex Züpke <azu@sysgo.de>
+ *  Copyright (c) 2002	Gary Jennejohn <garyj@denx.de>
+ *  Copyright (c) 2002	Kyle Harris <kharris@nexus-tech.net>
+ *  Copyright (c) 2020  Samsung Electronics, Co. Ltd.
+ *
+ * SPDX-License-Identifier:	GPL-2.0
+ */
+
+/* From head.S */
+ AR_CLASS(      .arch   armv7-a )
+ M_CLASS(       .arch   armv7-m )
+
+/*
+ *************************************************************************
+ *
+ * Symbol _start is referenced elsewhere, so make it global
+ *
+ *************************************************************************
+ */
+
+.globl _start
+
+/*
+ *************************************************************************
+ *
+ * Vectors have their own section so linker script can map them easily
+ *
+ *************************************************************************
+ */
+
+	.section ".vectors", "ax"
+	.arm
+
+/*
+ *************************************************************************
+ *
+ * Exception vectors as described in ARM reference manuals
+ *
+ * Uses indirect branch to allow reaching handlers anywhere in memory.
+ *
+ *************************************************************************
+ */
+
+_start:
+	b	_main
+	ldr	pc, _undefined_instruction
+	ldr	pc, _software_interrupt
+	ldr	pc, _prefetch_abort
+	ldr	pc, _data_abort
+	ldr	pc, _not_used
+	ldr	pc, _irq
+	ldr	pc, _fiq
+
+/*
+ *************************************************************************
+ *
+ * Indirect vectors table
+ *
+ * Symbols referenced here must be defined somewhere else
+ *
+ *************************************************************************
+ */
+
+	.globl	_undefined_instruction
+	.globl	_software_interrupt
+	.globl	_prefetch_abort
+	.globl	_data_abort
+	.globl	_not_used
+	.globl	_irq
+	.globl	_fiq
+
+_undefined_instruction:	.word undefined_instruction
+_software_interrupt:	.word software_interrupt
+_prefetch_abort:	.word prefetch_abort
+_data_abort:		.word data_abort
+_not_used:		.word not_used
+_irq:			.word irq
+_fiq:			.word fiq
+
+	.balignl 16,0xdeadbeef
+
+/*
+ *************************************************************************
+ *
+ * Interrupt handling
+ *
+ *************************************************************************
+ */
+
+/* SPL interrupt handling: just hang */
+
+	.align	5
+undefined_instruction:
+software_interrupt:
+prefetch_abort:
+data_abort:
+not_used:
+irq:
+fiq:
+
+1:
+	bl	1b			/* hang and never return */
+
+
diff --git arch/arm/boot/loader/vmlinux.lds arch/arm/boot/loader/vmlinux.lds
new file mode 100644
index 000000000000..bbd45def56a2
--- /dev/null
+++ arch/arm/boot/loader/vmlinux.lds
@@ -0,0 +1,17 @@
+OUTPUT_FORMAT("elf32-littlearm", "elf32-littlearm", "elf32-littlearm")
+OUTPUT_ARCH(arm)
+ENTRY(_start)
+SECTIONS
+{
+ . = 0x00000000;
+ . = ALIGN(4);
+ .text :
+ {
+  *(.vectors)
+  *(.text*)
+ }
+ . = ALIGN(4096);
+ .piggydata : { *(.piggydata) }
+ . = ALIGN(8);
+ .stack : { *(.stack) }
+}
diff --git arch/arm/configs/odroidxu4_bootloader_defconfig arch/arm/configs/odroidxu4_bootloader_defconfig
new file mode 100644
index 000000000000..88961d952613
--- /dev/null
+++ arch/arm/configs/odroidxu4_bootloader_defconfig
@@ -0,0 +1,127 @@
+CONFIG_BOOT_LOADER_XU4=y
+CONFIG_LOCALVERSION="-boot-loader"
+CONFIG_KERNEL_XZ=y
+CONFIG_DEFAULT_HOSTNAME="boot-loader"
+# CONFIG_SWAP is not set
+# CONFIG_CROSS_MEMORY_ATTACH is not set
+CONFIG_NO_HZ=y
+CONFIG_HIGH_RES_TIMERS=y
+CONFIG_BLK_DEV_INITRD=y
+CONFIG_INITRAMFS_SOURCE="tools/hsinit/initramfs.cpio"
+# CONFIG_RD_GZIP is not set
+# CONFIG_RD_BZIP2 is not set
+# CONFIG_RD_LZMA is not set
+# CONFIG_RD_LZO is not set
+# CONFIG_RD_LZ4 is not set
+CONFIG_CC_OPTIMIZE_FOR_SIZE=y
+# CONFIG_MULTIUSER is not set
+# CONFIG_SYSFS_SYSCALL is not set
+# CONFIG_FHANDLE is not set
+# CONFIG_BUG is not set
+# CONFIG_BASE_FULL is not set
+# CONFIG_SHMEM is not set
+# CONFIG_AIO is not set
+# CONFIG_IO_URING is not set
+# CONFIG_ADVISE_SYSCALLS is not set
+# CONFIG_MEMBARRIER is not set
+# CONFIG_KALLSYMS is not set
+# CONFIG_RSEQ is not set
+CONFIG_EMBEDDED=y
+# CONFIG_VM_EVENT_COUNTERS is not set
+CONFIG_SLOB=y
+CONFIG_ARCH_EXYNOS=y
+# CONFIG_ARCH_EXYNOS3 is not set
+# CONFIG_ARCH_EXYNOS4 is not set
+# CONFIG_SOC_EXYNOS5250 is not set
+# CONFIG_SOC_EXYNOS5260 is not set
+# CONFIG_SOC_EXYNOS5410 is not set
+# CONFIG_SOC_EXYNOS5800 is not set
+CONFIG_HAVE_ARM_ARCH_TIMER=y
+CONFIG_THUMB2_KERNEL=y
+CONFIG_HIGHMEM=y
+CONFIG_SECCOMP=y
+# CONFIG_ATAGS is not set
+CONFIG_ZBOOT_ROM_TEXT=0x0
+CONFIG_ZBOOT_ROM_BSS=0x0
+CONFIG_ARM_APPENDED_DTB=y
+CONFIG_CMDLINE="earlycon debug console=ttySAC2,115200n8 clk_ignore_unused hs=/dev/mmcblk1p6:uroot.cpio.gz"
+CONFIG_KEXEC=y
+CONFIG_VFP=y
+# CONFIG_SUSPEND is not set
+CONFIG_PM=y
+# CONFIG_BLK_DEV_BSG is not set
+CONFIG_PARTITION_ADVANCED=y
+# CONFIG_MQ_IOSCHED_DEADLINE is not set
+# CONFIG_MQ_IOSCHED_KYBER is not set
+# CONFIG_COREDUMP is not set
+# CONFIG_COMPACTION is not set
+CONFIG_DEVTMPFS=y
+CONFIG_DEVTMPFS_MOUNT=y
+CONFIG_SCSI=y
+CONFIG_BLK_DEV_SD=y
+CONFIG_CHR_DEV_SG=y
+# CONFIG_INPUT is not set
+# CONFIG_SERIO is not set
+# CONFIG_VT is not set
+# CONFIG_LEGACY_PTYS is not set
+# CONFIG_DEVMEM is not set
+CONFIG_SERIAL_SAMSUNG=y
+CONFIG_SERIAL_SAMSUNG_CONSOLE=y
+# CONFIG_HW_RANDOM is not set
+CONFIG_I2C=y
+CONFIG_I2C_CHARDEV=y
+CONFIG_I2C_MUX=y
+CONFIG_I2C_ARB_GPIO_CHALLENGE=y
+CONFIG_I2C_GPIO=y
+CONFIG_I2C_S3C2410=y
+CONFIG_SENSORS_PWM_FAN=y
+CONFIG_THERMAL_EMULATION=y
+CONFIG_MFD_SEC_CORE=y
+CONFIG_REGULATOR=y
+CONFIG_REGULATOR_FIXED_VOLTAGE=y
+CONFIG_REGULATOR_GPIO=y
+CONFIG_REGULATOR_S2MPS11=y
+# CONFIG_USB_SUPPORT is not set
+CONFIG_MMC=y
+# CONFIG_PWRSEQ_SIMPLE is not set
+CONFIG_MMC_BLOCK_MINORS=16
+CONFIG_MMC_SDHCI=y
+CONFIG_MMC_SDHCI_S3C=y
+CONFIG_MMC_SDHCI_S3C_DMA=y
+CONFIG_MMC_DW=y
+CONFIG_MMC_DW_EXYNOS=y
+CONFIG_NEW_LEDS=y
+CONFIG_LEDS_CLASS=y
+CONFIG_LEDS_CLASS_FLASH=y
+CONFIG_LEDS_GPIO=y
+CONFIG_LEDS_PWM=y
+CONFIG_LEDS_TRIGGERS=y
+CONFIG_LEDS_TRIGGER_HEARTBEAT=y
+# CONFIG_VIRTIO_MENU is not set
+CONFIG_COMMON_CLK_S2MPS11=y
+# CONFIG_EXYNOS_AUDSS_CLK_CON is not set
+# CONFIG_IOMMU_SUPPORT is not set
+CONFIG_PWM=y
+CONFIG_PWM_SAMSUNG=y
+# CONFIG_PHY_EXYNOS_DP_VIDEO is not set
+# CONFIG_PHY_EXYNOS_MIPI_VIDEO is not set
+CONFIG_NVMEM=y
+# CONFIG_FILE_LOCKING is not set
+# CONFIG_DNOTIFY is not set
+# CONFIG_INOTIFY_USER is not set
+CONFIG_VFAT_FS=y
+# CONFIG_PROC_SYSCTL is not set
+# CONFIG_PROC_PAGE_MONITOR is not set
+# CONFIG_MISC_FILESYSTEMS is not set
+CONFIG_NLS_CODEPAGE_437=y
+CONFIG_NLS_ISO8859_1=y
+CONFIG_PRINTK_TIME=y
+# CONFIG_SECTION_MISMATCH_WARN_ONLY is not set
+CONFIG_MAGIC_SYSRQ=y
+# CONFIG_DEBUG_MISC is not set
+# CONFIG_SCHED_DEBUG is not set
+# CONFIG_FTRACE is not set
+CONFIG_DEBUG_LL=y
+CONFIG_DEBUG_S3C_UART2=y
+CONFIG_DEBUG_UNCOMPRESS=y
+# CONFIG_RUNTIME_TESTING_MENU is not set
-- 
2.20.1

