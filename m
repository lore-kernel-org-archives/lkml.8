Return-Path: <SRS0=Xj+s=AD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3E6BC433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jun 2020 06:34:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7E6902541B
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jun 2020 06:34:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="De6eVo+E"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731266AbgFVGd7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Jun 2020 02:33:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726686AbgFVGd4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Jun 2020 02:33:56 -0400
Received: from mail-pj1-x1044.google.com (mail-pj1-x1044.google.com [IPv6:2607:f8b0:4864:20::1044])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 631C6C061794
        for <linux-kernel@vger.kernel.org>; Sun, 21 Jun 2020 23:33:56 -0700 (PDT)
Received: by mail-pj1-x1044.google.com with SMTP id b7so6301136pju.0
        for <linux-kernel@vger.kernel.org>; Sun, 21 Jun 2020 23:33:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ezv4JnfVR6LWgBcc7PypHNj9Qesz1Vb4pgdtDvjBS6U=;
        b=De6eVo+EUy6FB1RenXpF+tB/HeWze+V+ZVIbaffFxDVW8f2PVwswMIQC2ZsQPNPBkn
         fmwOdBvg3XxjmYfOKrDO1e9Z2fjaorlzvuP9n4KWdmYTPxfAYGBIE/36wEW6MKNYMJzK
         6FPckM7xvYCVCBBrhKgNX/tu6ebOD1oAhXUCMWHteJKpDxUXMHn/zhgJhz4gP2rKqICw
         djiuC0vKWG5JeXeSrBIajmnE6b6iskFFEzi4s8LSVy7xtUXEmTpA0113rdjUZVV7kJMa
         88UemmoEAr3AaTekjmUk2I/dZsSWlR5D4B9k4X79uwE5zp2Dd090+uWNSqJe+BBB2FvO
         C0hA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ezv4JnfVR6LWgBcc7PypHNj9Qesz1Vb4pgdtDvjBS6U=;
        b=hOAzSTcYjMQ+vBQd5bvqBd9MQ/2x8llzFZamJIJSy6SNpeyQWFFENOM2s8rpKzb2Q4
         3YycBBzII7Ul6zvbBpRp4VrozYscQXJtoXN1pgelp20/ekb4b6mOqK/rh+iKfaO5gxSD
         /jzVHNl0sdHQcqwuF45MnCZEw4U9SmIsVe4ZZgpRuysDHq3IPuMcCXj0rLi3Z56G25gU
         eu/cEwIAdPhY/xAYSVxm98NpDp4t0/q/YLuLd+/q+2P/2jxNAqek2iEToQYyaFjlZHcd
         mdziY9IGMxusLr8eO8F8WNMnMeWTdrn14347Z5cbqgaebHrBdq8PC1tWndMQoW7wlTFo
         EKZQ==
X-Gm-Message-State: AOAM532Iz67tng3yQivfLGVobQeL9SI2pG2ofJQ2emocE2UhlEA1YgdQ
        LUp7zxecI6T1ApgBlxlBuOAf6w==
X-Google-Smtp-Source: ABdhPJymS1+lWUG1/NvEHh6oxkU/+2b3wwobJdkL6IsQbdSfWN3lKaKiw8+pSS/wWSoOgRCD0lv7gg==
X-Received: by 2002:a17:90b:796:: with SMTP id l22mr15316991pjz.45.1592807635928;
        Sun, 21 Jun 2020 23:33:55 -0700 (PDT)
Received: from hsinchu02.internal.sifive.com (114-34-229-221.HINET-IP.hinet.net. [114.34.229.221])
        by smtp.gmail.com with ESMTPSA id w11sm12530999pfi.93.2020.06.21.23.33.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 21 Jun 2020 23:33:55 -0700 (PDT)
From:   Zong Li <zong.li@sifive.com>
To:     paul.walmsley@sifive.com, palmer@dabbelt.com, mick@ics.forth.gr,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Zong Li <zong.li@sifive.com>
Subject: [PATCH v2 1/2] riscv: Support CONFIG_STRICT_DEVMEM
Date:   Mon, 22 Jun 2020 14:33:49 +0800
Message-Id: <07db05fd125ce591cc773d03d994184ddbc7dee2.1592807136.git.zong.li@sifive.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <cover.1592807136.git.zong.li@sifive.com>
References: <cover.1592807136.git.zong.li@sifive.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Implement the 'devmem_is_allowed()' interface for RISC-V, like some of
other architectures have done. It will be called from range_is_allowed()
when userpsace attempts to access /dev/mem.

Access to exclusive IOMEM and kernel RAM is denied unless
CONFIG_STRICT_DEVMEM is set to 'n'.

Test it by devmem, the result as follows:

 - CONFIG_STRICT_DEVMEM=y
        $ devmem 0x10010000
        0x00000000
        $ devmem 0x80200000
        0x0000106F

 - CONFIG_STRICT_DEVMEM is not set
        $ devmem 0x10010000
        devmem: mmap: Operation not permitted
        $ devmem 0x80200000
        devmem: mmap: Operation not permitted

Changes in v2:
 - Move implementations out from mm/init.c. Suggested by Nick Kossifidis.

Signed-off-by: Zong Li <zong.li@sifive.com>
---
 arch/riscv/Kconfig          |  1 +
 arch/riscv/include/asm/io.h |  2 ++
 arch/riscv/mm/Makefile      |  1 +
 arch/riscv/mm/mmap.c        | 24 ++++++++++++++++++++++++
 4 files changed, 28 insertions(+)
 create mode 100644 arch/riscv/mm/mmap.c

diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
index 089293e4ad46..c6569939f7ba 100644
--- a/arch/riscv/Kconfig
+++ b/arch/riscv/Kconfig
@@ -17,6 +17,7 @@ config RISCV
 	select ARCH_HAS_BINFMT_FLAT
 	select ARCH_HAS_DEBUG_VIRTUAL if MMU
 	select ARCH_HAS_DEBUG_WX
+	select ARCH_HAS_DEVMEM_IS_ALLOWED
 	select ARCH_HAS_GCOV_PROFILE_ALL
 	select ARCH_HAS_GIGANTIC_PAGE
 	select ARCH_HAS_MMIOWB
diff --git a/arch/riscv/include/asm/io.h b/arch/riscv/include/asm/io.h
index 3835c3295dc5..04ac65ab93ce 100644
--- a/arch/riscv/include/asm/io.h
+++ b/arch/riscv/include/asm/io.h
@@ -147,4 +147,6 @@ __io_writes_outs(outs, u64, q, __io_pbr(), __io_paw())
 
 #include <asm-generic/io.h>
 
+extern int devmem_is_allowed(unsigned long pfn);
+
 #endif /* _ASM_RISCV_IO_H */
diff --git a/arch/riscv/mm/Makefile b/arch/riscv/mm/Makefile
index 363ef01c30b1..4530ad52f1d6 100644
--- a/arch/riscv/mm/Makefile
+++ b/arch/riscv/mm/Makefile
@@ -10,6 +10,7 @@ obj-y += extable.o
 obj-$(CONFIG_MMU) += fault.o pageattr.o
 obj-y += cacheflush.o
 obj-y += context.o
+obj-y += mmap.o
 
 ifeq ($(CONFIG_MMU),y)
 obj-$(CONFIG_SMP) += tlbflush.o
diff --git a/arch/riscv/mm/mmap.c b/arch/riscv/mm/mmap.c
new file mode 100644
index 000000000000..095fc82897b1
--- /dev/null
+++ b/arch/riscv/mm/mmap.c
@@ -0,0 +1,24 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (C) 2020 SiFive
+ */
+
+#ifdef CONFIG_STRICT_DEVMEM
+#include <linux/ioport.h>
+
+/*
+ * devmem_is_allowed() checks to see if /dev/mem access to a certain address
+ * is valid. The argument is a physical page number.
+ *
+ * Disallow access to system RAM as well as device-exclusive MMIO regions.
+ * This effectively disable read()/write() on /dev/mem.
+ */
+int devmem_is_allowed(unsigned long pfn)
+{
+	if (iomem_is_exclusive(pfn << PAGE_SHIFT))
+		return 0;
+	if (!page_is_ram(pfn))
+		return 1;
+	return 0;
+}
+#endif
-- 
2.27.0

