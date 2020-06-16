Return-Path: <SRS0=dgGg=75=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38F02C433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jun 2020 07:46:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 19F6C206F1
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jun 2020 07:46:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="VJHC11Uq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726384AbgFPHp6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Jun 2020 03:45:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726259AbgFPHp4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Jun 2020 03:45:56 -0400
Received: from mail-pl1-x643.google.com (mail-pl1-x643.google.com [IPv6:2607:f8b0:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C378FC03E96A
        for <linux-kernel@vger.kernel.org>; Tue, 16 Jun 2020 00:45:55 -0700 (PDT)
Received: by mail-pl1-x643.google.com with SMTP id k6so3058746pll.9
        for <linux-kernel@vger.kernel.org>; Tue, 16 Jun 2020 00:45:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=vV7PDthSiPR3LChm1dR2y1ass0+TcfMiVV19frp0t7U=;
        b=VJHC11UqQBI1FGJ+MeKOiWKzMZGBTEHwNKV3OXnRsqMaz6M/rTt7pvyn+uVO+MYabl
         iaSOBJwnznJ+7y6uHyDg4fqR8po25vKF0mvJjZDEgyajtVYm1mLTp4Vl8hwuRcNA3r1M
         SiolWjgx/7vQjDLvauayB86aTzSmQoPqZdAQCLjaM0Zplg64t7mLe0iDxiP9Un6Y1QIY
         vB2XGsQm/zuZPXi3yIGPUaPKviKVm0IBx/uEKmBbmcwwSxp7La/sKBU3bXoXIXLNIWIv
         jEnxWscZ62T1Ym1ZosQcPG6lVZcy/+sW611lSpjlRhFs19m0bxs/Yh+Iun86+OOP3p50
         iuGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=vV7PDthSiPR3LChm1dR2y1ass0+TcfMiVV19frp0t7U=;
        b=VdueKA8e06QuS9nCyxuPnT+AC9o/lYPlUlV7+k2xCgOAjYF8p9S7lHMYhiDI5zyC2b
         Z9jD2QthyM8+v8l4+tvwY5/kNkQUn+FRnKw50IJ7rjmJJXrEd+9h/PF9AVqK1fOQ3G/Q
         TNpUIHAy4sZHT9g4WashlG1Z/goR5Xjqvvgrde1q6hIcucVkEuj60WpODHiHlvt4H9Gu
         SmgxNtA10SRkVksW8XVK3zDt6XxW8fWNSgOj5i2C4CPcwv3DL4knWhTrZlFzkmd3TRRl
         oX7S28smLmeqHNp2G/lDsKihx5IBM9dSXiMvUQR8RndcxisHAIs3hjXAF5X7PzGqv/fz
         FFPg==
X-Gm-Message-State: AOAM530lOGaJFdJZ47NgNEZpSvl3FCNcmTYr8fFH1jZjwyb2GW++LBRE
        KAVoilxNQWe/SUkFVllEhHo+Xw==
X-Google-Smtp-Source: ABdhPJxOR/0ji5UrB9CnB39EGe+8bQm9woYF0QdIZpmAvJ+qYh4U0dcwFYR+oXEWTXHvrW/1WVVvGw==
X-Received: by 2002:a17:90a:9f81:: with SMTP id o1mr1578412pjp.139.1592293555400;
        Tue, 16 Jun 2020 00:45:55 -0700 (PDT)
Received: from hsinchu02.internal.sifive.com (114-34-229-221.HINET-IP.hinet.net. [114.34.229.221])
        by smtp.gmail.com with ESMTPSA id i22sm15948250pfo.92.2020.06.16.00.45.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Jun 2020 00:45:55 -0700 (PDT)
From:   Zong Li <zong.li@sifive.com>
To:     paul.walmsley@sifive.com, palmer@dabbelt.com,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Zong Li <zong.li@sifive.com>
Subject: [PATCH 2/2] riscv: Support CONFIG_STRICT_DEVMEM
Date:   Tue, 16 Jun 2020 15:45:47 +0800
Message-Id: <7faa60aa4a606b5c5c1ae374d82a7eee6c764b38.1592292685.git.zong.li@sifive.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <cover.1592292685.git.zong.li@sifive.com>
References: <cover.1592292685.git.zong.li@sifive.com>
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

Signed-off-by: Zong Li <zong.li@sifive.com>
---
 arch/riscv/Kconfig          |  1 +
 arch/riscv/include/asm/io.h |  2 ++
 arch/riscv/mm/init.c        | 19 +++++++++++++++++++
 3 files changed, 22 insertions(+)

diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
index 128192e14ff2..ffd7841ede4c 100644
--- a/arch/riscv/Kconfig
+++ b/arch/riscv/Kconfig
@@ -16,6 +16,7 @@ config RISCV
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
diff --git a/arch/riscv/mm/init.c b/arch/riscv/mm/init.c
index bbe816e03b2f..5e7e61519acc 100644
--- a/arch/riscv/mm/init.c
+++ b/arch/riscv/mm/init.c
@@ -517,6 +517,25 @@ void mark_rodata_ro(void)
 }
 #endif
 
+#ifdef CONFIG_STRICT_DEVMEM
+#include <linux/ioport.h>
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
+
 void __init resource_init(void)
 {
 	struct memblock_region *region;
-- 
2.27.0

