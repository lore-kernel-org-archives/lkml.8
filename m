Return-Path: <SRS0=8+oI=7O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4EA4C433E1
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jun 2020 14:28:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AC9E92068D
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jun 2020 14:28:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="IHzDkama"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727795AbgFAO2U (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Jun 2020 10:28:20 -0400
Received: from mailout1.w1.samsung.com ([210.118.77.11]:55330 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726113AbgFAO2N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Jun 2020 10:28:13 -0400
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20200601142811euoutp0175398c2b9e8e1a2f251c7f70d05ec878~UccxxMWIp0888208882euoutp01S
        for <linux-kernel@vger.kernel.org>; Mon,  1 Jun 2020 14:28:11 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20200601142811euoutp0175398c2b9e8e1a2f251c7f70d05ec878~UccxxMWIp0888208882euoutp01S
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1591021691;
        bh=Qz6U1Wo5NiI9a+hsP0kvKTekCHlCwheEB+SMihQuSRY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=IHzDkama6HDzRYDvYnFe7jW7aHTsZ41zrK2JUmgP0jPY9ER2dbBbGmm0xrpx3dvRZ
         iTLGrLrzHeEAogbalCoZvpEK1Z1YT+TOljz5MtJb5U6uH7pb66GiDcgq+U7eX+v9ou
         sln6vRo9+glRM5yDbc75sK7Yei2XtL/LImRFm54o=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20200601142810eucas1p222984f1c15f427a5327b43bc2ef363c0~UccxaOV1B2609926099eucas1p2P;
        Mon,  1 Jun 2020 14:28:10 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges3new.samsung.com (EUCPMTA) with SMTP id 3E.6D.60698.A7015DE5; Mon,  1
        Jun 2020 15:28:10 +0100 (BST)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20200601142810eucas1p23056f7997a880ff7d676c64703f87115~UccxH0XE83062630626eucas1p2G;
        Mon,  1 Jun 2020 14:28:10 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20200601142810eusmtrp2a83a46639842bb833882f4c67dbd6ff9~UccxHKKwk1485714857eusmtrp2K;
        Mon,  1 Jun 2020 14:28:10 +0000 (GMT)
X-AuditID: cbfec7f5-a0fff7000001ed1a-e0-5ed5107a3af5
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id 45.52.08375.A7015DE5; Mon,  1
        Jun 2020 15:28:10 +0100 (BST)
Received: from localhost (unknown [106.120.51.46]) by eusmtip2.samsung.com
        (KnoxPortal) with ESMTPA id
        20200601142810eusmtip2567a0195d07aa80b2647c6d26b54bace~Uccw8Hs4M2413124131eusmtip2R;
        Mon,  1 Jun 2020 14:28:10 +0000 (GMT)
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
Subject: [PATCH 2/5] arm: add image header definitions
Date:   Mon,  1 Jun 2020 16:27:51 +0200
Message-Id: <20200601142754.26139-3-l.stelmach@samsung.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200601142754.26139-1-l.stelmach@samsung.com>
MIME-Version: 1.0
Organization: Samsung R&D Institute Poland
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA02SeUgUYRjG+WZmZ8ettXGNetMOWpJIzQNLBhRR6Y+BEiSIIEibcjzKVdtJ
        O4i0wiMrNUWqtcOiaFmvdjVL047Fo9Q2RPOI1rIsS/LII1zTLXdHyf+e5/1+z3vAR+GKPokL
        FZdwjFcncPFKUkZUN1lMW0/R7yJ8vt/xZvTXKiRMfvkLjOk9+xRj2i6qmF6jFjGGL10SpqP2
        BskYC+sRU9ZgljL9n3okTIm1BTFjeX8xZva5hWAqDYV4sCPb0dWOs0Vp7QQ7p/uOs8WGZNag
        u0CyH7rqSHbEZJKylfdS2byxYZLNqdIhdsKwPnzZPllgFB8fl8KrvYMOyGLT8/vJJLPricz3
        pVgaaliVjRwooLeBtaMEz0YySkFrEbRZtBLRTCJoftuOiWYCwei4nlyM3LJ2L1APEDyemZGK
        ZhDBwNxHZKNIOgRy77+yUyvpKQxqCzNJm8HpTgT9z6sxG+VM+8PL6QbCpgnaDbS/MqQ2LacD
        oLOwGxPnbYDMB4/tsx3oQHjROo6JjBO8vj5gz66g3aH0XLdd4/P8+UdF9pOAvkLBH/NPidho
        B5QVTeGidoah5iqpqNfC35rb802peZ0KBfn+YvYSguob04TIBMAH0wxpY3B6C1TUeovlEKia
        K1iIOkLPsJO4giPkV1/FxbIcsjIUIr0JynPrFhq6wOUhLcpDSs2SYzRLDtD8n1WMcB1azScL
        qhhe8Evgj3sJnEpITojxOpSoMqD5X9dqbZ56gp7NHjQimkLK5fKHHzsjFBIuRTipMiKgcOVK
        eeib1giFPIo7eYpXJ0aqk+N5wYhcKUK5Wu5398d+BR3DHeOP8HwSr158xSgHlzTkER5UPqnf
        2Ha0sT7181f3ykijn/NNXVafnjeFacy7x5WWr/FY2J71+t0pNd8GLIHpO+s00XmhTZ5nErlI
        3xyjJtpj+o5PCNHvU/DZ+VPfXuvvyBa3XYFv9IfHRwdnb5LryoSSlrRNZt/j0Rv2e+YGK5v2
        hKzhNlsPbo8acZGdblQSQizn646rBe4f/Coc83EDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrHIsWRmVeSWpSXmKPExsVy+t/xe7pVAlfjDA69lbXYOGM9q8WkdQeY
        LG427mayONOda3Hz0ApGi02Pr7FaXN41h83i0NS9jBZrj9xlt3j44Aarxep/pxgtPkz4z2Tx
        Z/9PFovNm6YyO/B5XL52kdljdsNFFo+/q14weyzYVOqxaVUnm8eda3vYPN6dO8fusXlJvceE
        D2/ZPPq2rGL0+LxJLoA7Ss+mKL+0JFUhI7+4xFYp2tDCSM/Q0kLPyMRSz9DYPNbKyFRJ384m
        JTUnsyy1SN8uQS+jddJDtoK70hXtt9YwNTAeEeti5OSQEDCRmPfvOmsXIxeHkMBSRonOiweY
        uhg5gBJSEivnpkPUCEv8udbFBlHzlFHiyfleRpAEm4CjRP/SE2DNIgJ/mSQOzjoNVsUscI1R
        YuOEk8wgVcICZhIHfxxhAbFZBFQlVnxsYwexeQWsJa5Mvc4EsUJeon35djYQm1PARuLA6U9g
        cSGgmvfTupkg6gUlTs58wgJyHbOAusT6eUIgYX4BLYk1TdfBxjMDjWneOpt5AqPQLCQdsxA6
        ZiGpWsDIvIpRJLW0ODc9t9hQrzgxt7g0L10vOT93EyMwrrcd+7l5B+OljcGHGAU4GJV4eDfc
        vxInxJpYVlyZe4hRgoNZSYTX6ezpOCHelMTKqtSi/Pii0pzU4kOMpkBvTmSWEk3OB6acvJJ4
        Q1NDcwtLQ3Njc2MzCyVx3g6BgzFCAumJJanZqakFqUUwfUwcnFINjNmft/xgM3plYHMzq99D
        X7gtMpHF8G3WRRGuF7HFSrMXmebO3e0qdS79/xkL12X8a64GS/7U0n9za68K26G1Sxeyczml
        zZVIz5TZ3mP0YM6ySR+uTZTT4DBe9iW/KqggQOLvrOB7uVPjornWReZ4xnxhWye/6Lf4Rs66
        9+dPrimyOHjQ5cPqRCWW4oxEQy3mouJEAGmHb9wBAwAA
X-CMS-MailID: 20200601142810eucas1p23056f7997a880ff7d676c64703f87115
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20200601142810eucas1p23056f7997a880ff7d676c64703f87115
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20200601142810eucas1p23056f7997a880ff7d676c64703f87115
References: <20200601142754.26139-1-l.stelmach@samsung.com>
        <CGME20200601142810eucas1p23056f7997a880ff7d676c64703f87115@eucas1p2.samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This structure will be used later by kexec_file loader.

Signed-off-by: Łukasz Stelmach <l.stelmach@samsung.com>
---
 arch/arm/boot/compressed/head.S        |  3 +-
 arch/arm/boot/compressed/vmlinux.lds.S | 13 ++-----
 arch/arm/include/asm/image.h           | 48 ++++++++++++++++++++++++++
 3 files changed, 53 insertions(+), 11 deletions(-)
 create mode 100644 arch/arm/include/asm/image.h

diff --git a/arch/arm/boot/compressed/head.S b/arch/arm/boot/compressed/head.S
index dcc1afa60fb9..97e4cfcfc197 100644
--- a/arch/arm/boot/compressed/head.S
+++ b/arch/arm/boot/compressed/head.S
@@ -7,6 +7,7 @@
  */
 #include <linux/linkage.h>
 #include <asm/assembler.h>
+#include <asm/image.h>
 #include <asm/v7m.h>
 
 #include "efi-header.S"
@@ -211,7 +212,7 @@ start:
 		.word	_magic_start	@ absolute load/run zImage address
 		.word	_magic_end	@ zImage end address
 		.word	0x04030201	@ endianness flag
-		.word	0x45454545	@ another magic number to indicate
+		.word	ARM_ZIMAGE_MAGIC2 @ another magic number to indicate
 		.word	_magic_table	@ additional data table
 
 		__EFI_HEADER
diff --git a/arch/arm/boot/compressed/vmlinux.lds.S b/arch/arm/boot/compressed/vmlinux.lds.S
index f82b5962d97e..308e9cd6a897 100644
--- a/arch/arm/boot/compressed/vmlinux.lds.S
+++ b/arch/arm/boot/compressed/vmlinux.lds.S
@@ -3,14 +3,7 @@
  *  Copyright (C) 2000 Russell King
  */
 
-#ifdef CONFIG_CPU_ENDIAN_BE8
-#define ZIMAGE_MAGIC(x) ( (((x) >> 24) & 0x000000ff) | \
-			  (((x) >>  8) & 0x0000ff00) | \
-			  (((x) <<  8) & 0x00ff0000) | \
-			  (((x) << 24) & 0xff000000) )
-#else
-#define ZIMAGE_MAGIC(x) (x)
-#endif
+#include <asm/image.h>
 
 OUTPUT_ARCH(arm)
 ENTRY(_start)
@@ -43,7 +36,7 @@ SECTIONS
   .table : ALIGN(4) {
     _table_start = .;
     LONG(ZIMAGE_MAGIC(4))
-    LONG(ZIMAGE_MAGIC(0x5a534c4b))
+    LONG(ARM_ZIMAGE_MAGIC3)
     LONG(ZIMAGE_MAGIC(__piggy_size_addr - _start))
     LONG(ZIMAGE_MAGIC(_kernel_bss_size))
     LONG(0)
@@ -107,7 +100,7 @@ SECTIONS
     _edata_real = .;
   }
 
-  _magic_sig = ZIMAGE_MAGIC(0x016f2818);
+  _magic_sig = ARM_ZIMAGE_MAGIC1;
   _magic_start = ZIMAGE_MAGIC(_start);
   _magic_end = ZIMAGE_MAGIC(_edata);
   _magic_table = ZIMAGE_MAGIC(_table_start - _start);
diff --git a/arch/arm/include/asm/image.h b/arch/arm/include/asm/image.h
new file mode 100644
index 000000000000..d5c18a0f6a34
--- /dev/null
+++ b/arch/arm/include/asm/image.h
@@ -0,0 +1,48 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+
+#ifndef __ASM_IMAGE_H
+#define __ASM_IMAGE_H
+
+#ifdef CONFIG_CPU_ENDIAN_BE8
+#define ZIMAGE_MAGIC(x) ((((x) >> 24) & 0x000000ff) | \
+			 (((x) >>  8) & 0x0000ff00) |  \
+			 (((x) <<  8) & 0x00ff0000) |  \
+			 (((x) << 24) & 0xff000000))
+#else
+#define ZIMAGE_MAGIC(x) (x)
+#endif
+
+#define ARM_ZIMAGE_MAGIC1 ZIMAGE_MAGIC(0x016f2818)
+#define ARM_ZIMAGE_MAGIC2 (0x45454545)
+#define ARM_ZIMAGE_MAGIC3 ZIMAGE_MAGIC(0x5a534c4b)
+
+#ifndef __ASSEMBLY__
+
+#include <linux/types.h>
+#include <asm/setup.h>
+
+/* ARM zImage header format */
+struct arm_zimage_header {
+	__le32 code[9];
+	__le32 magic;
+	__le32 start;
+	__le32 end;
+	__le32 endian;
+	__le32 magic2;
+	__le32 extension_tag_offset;
+};
+
+struct arm_zimage_tag {
+	struct tag_header hdr;
+	union {
+#define ZIMAGE_TAG_KRNL_SIZE ARM_ZIMAGE_MAGIC3
+		struct zimage_krnl_size {
+			__le32 size_ptr;
+			__le32 bss_size;
+		} krnl_size;
+	} u;
+};
+
+#endif /* __ASSEMBLY__ */
+
+#endif /* __ASM_IMAGE_H */
-- 
2.26.2

