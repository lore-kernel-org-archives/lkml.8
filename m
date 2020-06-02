Return-Path: <SRS0=QAx1=7P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51227C433DF
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jun 2020 16:17:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2070620757
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jun 2020 16:17:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="WwGJABCV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728190AbgFBQR6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Jun 2020 12:17:58 -0400
Received: from mailout1.w1.samsung.com ([210.118.77.11]:39375 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727113AbgFBQRk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Jun 2020 12:17:40 -0400
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20200602161738euoutp0155e4907effa3170b5eedce043800f837~UxloZVORZ2974529745euoutp01E
        for <linux-kernel@vger.kernel.org>; Tue,  2 Jun 2020 16:17:38 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20200602161738euoutp0155e4907effa3170b5eedce043800f837~UxloZVORZ2974529745euoutp01E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1591114658;
        bh=6fQXZmSTsOXD9PCsKsQlhyyv57eMpT0Awzxum+3ePUA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=WwGJABCV3T5YO2T+ZVMu0rRDD0bc/H7+1y7Te8I7hyhDH7Ckemw64+oyYedWSe5rQ
         kzBZeB1lm/22jPX/tV64F5ncDXn3+Y6YskBjWip6CPJPbrJ9iXZ+/lfDLZZhOPivjr
         5N/PoWSgLFc5fNe5PG/N3sg2JRAYA/nJIyDmJ2FY=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20200602161738eucas1p2f68006fddfbaf01f75f6b20de9c15cbc~UxloGtt9a1812318123eucas1p25;
        Tue,  2 Jun 2020 16:17:38 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges3new.samsung.com (EUCPMTA) with SMTP id FC.23.60698.2AB76DE5; Tue,  2
        Jun 2020 17:17:38 +0100 (BST)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20200602161738eucas1p27dfbe386bd76555598d5574faf4fdad3~Uxln1dQ011811918119eucas1p25;
        Tue,  2 Jun 2020 16:17:38 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20200602161737eusmtrp1f8d7b2dfe4b25ce023e560009a294e0a~UxlnvCMqX2876728767eusmtrp1P;
        Tue,  2 Jun 2020 16:17:37 +0000 (GMT)
X-AuditID: cbfec7f5-a0fff7000001ed1a-18-5ed67ba2c0f1
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id E0.DE.08375.1AB76DE5; Tue,  2
        Jun 2020 17:17:37 +0100 (BST)
Received: from localhost (unknown [106.120.51.46]) by eusmtip2.samsung.com
        (KnoxPortal) with ESMTPA id
        20200602161737eusmtip2ae861338ba4a9a14a2c82f662c12b774~UxlnjrcYK0295502955eusmtip2k;
        Tue,  2 Jun 2020 16:17:37 +0000 (GMT)
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
Subject: [PATCH v2 2/5] arm: add image header definitions
Date:   Tue,  2 Jun 2020 18:17:28 +0200
Message-Id: <20200602161731.23033-3-l.stelmach@samsung.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200602161731.23033-1-l.stelmach@samsung.com>
MIME-Version: 1.0
Organization: Samsung R&D Institute Poland
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA01Sa0hTcRTnv3t3dzVn/80eJ42iUR+SfGXFTaMyom5PLIpAaLX0YtE2Y2tW
        BqVLfGU5jWE5P9gyGuaD5lzlI3NGVtZCrKWUtejhAypDR1k2c7tKffud83ucc+DQhLRPGEof
        UR/nNGqFUkYFkvaHY84I82mXPNr5VcLculwnZEpq7wuY3qwmAfP0vIrpdVgQY/3gEjLdjeUU
        4zC2IKbmQZ+Iee/uETI3vU8QM2yYEDDjrWMkU281EuuD2W5XF8GaMrtI9k/VAMFWWHWstSqf
        Yt+4min2q9MpYusrz7KG4S8Ue9FWhdgR64LEGUmBa1I45ZF0ThO19mDg4VJ3ruhYX9jJrvwB
        lIkezClAATTgFZD9xy4qQIG0FFsQGOxuii9GEXQU100xIwiGLa9F05aakisCnriBwF14daro
        R/C2zSb0qSicAEXXHwl9xCzsEUCjMdcfTOAXCN632gU+VQheDXWlXuTDJF4CxXq9vy/G8fCu
        rQXx8xZC7o3bk2aaDsBrwDSq5CUSeHzlI+nDM3E4VOtf+TExKT/XYCJ8swAbaaj3TOdshPL2
        QYLHITDUYZu6Zz50XiokffmAz8KlklW8txCBvfwnyWvi4Y3zl38HAi+FusYovp0AnrEJircG
        Q88XCb9CMJTYSwm+LYa8HCmvXgy1Rc1TgaFwYciCDEhW9t8xZf8dUPZvVgUiqtBcTqdVpXLa
        WDV3IlKrUGl16tTI5DSVFU0+Xae3w3MH3Rs/5ECYRrIgcXSMSy4VKtK1p1QOBDQhmyXe8KxT
        LhWnKE5lcJq0AxqdktM6UBhNyuaKY82D+6U4VXGcO8pxxzjNNCugA0Izkdmmouqbs1XpWwz7
        YvaYT37qjtgV/YG6ZkmSNGz+ptZj0bZ1RU3VZ570pW/P+Y4r+18uokzLRPqi/DxxVuzo7KB5
        t01H92ZszcpOSVra0JpYoEys3Lm7oGN7YmazPI0OyRn4EZcRt/K5bot3fCj3brj5c/tv4vJE
        wKbl66t3dCb/lpHaw4qYcEKjVfwFqt11vHADAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrLIsWRmVeSWpSXmKPExsVy+t/xe7oLq6/FGRycamqxccZ6VotJ6w4w
        Wdxs3M1kcaY71+LmoRWMFpseX2O1uLxrDpvFoal7GS3WHrnLbvHwwQ1Wi9X/TjFafJjwn8ni
        z/6fLBabN01lduDzuHztIrPH7IaLLB5/V71g9liwqdRj06pONo871/awebw7d47dY/OSeo8J
        H96yefRtWcXo8XmTXAB3lJ5NUX5pSapCRn5xia1StKGFkZ6hpYWekYmlnqGxeayVkamSvp1N
        SmpOZllqkb5dgl7G9Aft7AV3pSsudr5gbGA8ItbFyMkhIWAisXbSTKYuRi4OIYGljBLP3qxi
        7GLkAEpISaycmw5RIyzx51oXG0TNU0aJ0+f3MIMk2AQcJfqXnmAFSYgI/GWSODjrNFgVs8A1
        RomNE06CVQkLWEqsn/6PEcRmEVCVmNjUxARi8wpYS9w/uJcRYoW8RPvy7WwgmzkFbCRmf8kB
        CQsJ5Eo8XP6KHaJcUOLkzCcsICXMAuoS6+cJgYT5BbQk1jRdZwGxmYGmNG+dzTyBUWgWko5Z
        CB2zkFQtYGRexSiSWlqcm55bbKhXnJhbXJqXrpecn7uJERjV24793LyD8dLG4EOMAhyMSjy8
        BobX4oRYE8uKK3MPMUpwMCuJ8DqdPR0nxJuSWFmVWpQfX1Sak1p8iNEU6MuJzFKiyfnAhJNX
        Em9oamhuYWlobmxubGahJM7bIXAwRkggPbEkNTs1tSC1CKaPiYNTqoFR2//k8dAlpzK4v3RU
        Vwf33U95f7j40LGyXOZleg3sbI1fHdcJPSyW5kkR6J99cMnsO+43a3hy/d7qezye8WZq2aq/
        j9tfXHPk1dxjxPg651QBl6rvzTcFrK/ULT8mqe5a+H3xvfbba7RYymI3cfxl+7Fnfr1ey3sH
        CaNPeWYd17i+9sbEf4hSYinOSDTUYi4qTgQACKAKBwADAAA=
X-CMS-MailID: 20200602161738eucas1p27dfbe386bd76555598d5574faf4fdad3
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20200602161738eucas1p27dfbe386bd76555598d5574faf4fdad3
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20200602161738eucas1p27dfbe386bd76555598d5574faf4fdad3
References: <20200601142754.26139-1-l.stelmach@samsung.com>
        <20200602161731.23033-1-l.stelmach@samsung.com>
        <CGME20200602161738eucas1p27dfbe386bd76555598d5574faf4fdad3@eucas1p2.samsung.com>
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
index 55758264e776..005b172d504f 100644
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

