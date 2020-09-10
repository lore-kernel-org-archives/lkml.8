Return-Path: <SRS0=87nF=CT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66A21C433E2
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Sep 2020 08:23:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 043AC20732
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Sep 2020 08:23:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="CqsqG6+T"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729663AbgIJIXh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Sep 2020 04:23:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730104AbgIJINa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Sep 2020 04:13:30 -0400
Received: from mail-pg1-x544.google.com (mail-pg1-x544.google.com [IPv6:2607:f8b0:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A5D9C06179F
        for <linux-kernel@vger.kernel.org>; Thu, 10 Sep 2020 01:13:11 -0700 (PDT)
Received: by mail-pg1-x544.google.com with SMTP id m5so3822462pgj.9
        for <linux-kernel@vger.kernel.org>; Thu, 10 Sep 2020 01:13:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=XD87hlyZVgwsG9aiGYxOXLH+wE/VbkXceAnGyvTwMM0=;
        b=CqsqG6+T7IgsVP5ubJKbHGm+4PJjhcwpssveu+V5BCbvkB6qAGOKE6E2/+PYWdSxPZ
         arNmGkveV76zLOBSTI3q2K8iy2/MgTioQUcrYBYJTHL1d5o372WjDO4JyKEUK8HgRwU6
         jKcdBfkG4yp1RNaI5vPoBOF2yRr8VbnGCCB69Xp5LijJsLXQdYLBGWQj22llGD5txabI
         elynV9uCTZSIFVkA+PeZvOyhzfs2yn7qZMYxqOqYQXUGGNEWw0B1uer1626HxnsQqFHl
         3ElLuWNFpMXUpe7BUngTW6rciyf9uFEDn/AKhooFPm1X4kyn5oUAO+cXheIjnzVj4Uem
         jWBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=XD87hlyZVgwsG9aiGYxOXLH+wE/VbkXceAnGyvTwMM0=;
        b=LBrwO/BDrBD3S8NGP1vv1VxXZxIJquzb6h8fD1HY7ONN8hwHdX7XhCO0dDhxDV2iY4
         N7UpYZC+cpgm614yhunBUCXoOnkA6zu/mQicI0FXQ6UtUTASwTred2qkrXK32cGPXOz7
         pB3uEnArknP54RmwMne/X6YDmiovuYvGa8B2R7u9uIwtHr/8XrKIFQGTTLxKk9ADZ4T8
         h4934X4f4Q6e1+EPGhoKK64n6o59UQmFGWXl1CvBRAZq+PMCZ7SLLdb6aDikJLXvYuhm
         FHYwRBPy8R4Dgmn3vrr1KoHAGo/Eau1MhQ3o88fmi9VdiupF8Fx88KgFFIt89ZD3PGI6
         2nKg==
X-Gm-Message-State: AOAM530JV73qVoVtoYH+FnaxPVihd9bFJP77xSw27UIzH0RmvozzfD2M
        vbPuqTahq9L2iVp+p+wuTz1idw==
X-Google-Smtp-Source: ABdhPJx5XVABbyX9e2sxmvLaYxRNA1ZOzgYW0UO4o86mfVa2kZMyiSQqgXC7/Rx9xnUcNvObBvkEew==
X-Received: by 2002:a62:38ce:: with SMTP id f197mr4201218pfa.145.1599725591105;
        Thu, 10 Sep 2020 01:13:11 -0700 (PDT)
Received: from hsinchu02.internal.sifive.com (114-34-229-221.HINET-IP.hinet.net. [114.34.229.221])
        by smtp.gmail.com with ESMTPSA id e1sm2196056pfl.162.2020.09.10.01.13.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Sep 2020 01:13:08 -0700 (PDT)
From:   Greentime Hu <greentime.hu@sifive.com>
To:     greentime.hu@sifive.com, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org, aou@eecs.berkeley.edu,
        palmer@dabbelt.com, paul.walmsley@sifive.com
Cc:     Han-Kuan Chen <hankuan.chen@sifive.com>
Subject: [RFC PATCH v7 16/21] riscv: Add vector extension XOR implementation
Date:   Thu, 10 Sep 2020 16:12:11 +0800
Message-Id: <48fa9c9a6f13d00c67042657326d56a46ec0197f.1599719352.git.greentime.hu@sifive.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <cover.1599719352.git.greentime.hu@sifive.com>
References: <cover.1599719352.git.greentime.hu@sifive.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds support for vector optimized XOR it is tested in spike and
qemu.

Logs in spike:
[    0.008365] xor: measuring software checksum speed
[    0.048885]    8regs     :  1719.000 MB/sec
[    0.089080]    32regs    :  1717.000 MB/sec
[    0.129275]    rvv       :  7043.000 MB/sec
[    0.129525] xor: using function: rvv (7043.000 MB/sec)

Logs in qemu:
[    0.098943] xor: measuring software checksum speed
[    0.139391]    8regs     :  2911.000 MB/sec
[    0.181079]    32regs    :  2813.000 MB/sec
[    0.224260]    rvv       :    45.000 MB/sec
[    0.225586] xor: using function: 8regs (2911.000 MB/sec)

Signed-off-by: Han-Kuan Chen <hankuan.chen@sifive.com>
Signed-off-by: Greentime Hu <greentime.hu@sifive.com>
---
 arch/riscv/include/asm/xor.h | 74 ++++++++++++++++++++++++++++++++
 arch/riscv/lib/Makefile      |  1 +
 arch/riscv/lib/xor.S         | 81 ++++++++++++++++++++++++++++++++++++
 3 files changed, 156 insertions(+)
 create mode 100644 arch/riscv/include/asm/xor.h
 create mode 100644 arch/riscv/lib/xor.S

diff --git a/arch/riscv/include/asm/xor.h b/arch/riscv/include/asm/xor.h
new file mode 100644
index 000000000000..60ee0224913d
--- /dev/null
+++ b/arch/riscv/include/asm/xor.h
@@ -0,0 +1,74 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+/*
+ * Copyright (C) 2020 SiFive
+ */
+
+#include <linux/hardirq.h>
+#include <asm-generic/xor.h>
+#ifdef CONFIG_VECTOR
+#include <asm/vector.h>
+
+extern void xor_regs_2_(unsigned long bytes, unsigned long *p1,
+			unsigned long *p2);
+extern void xor_regs_3_(unsigned long bytes, unsigned long *p1,
+			unsigned long *p2, unsigned long *p3);
+extern void xor_regs_4_(unsigned long bytes, unsigned long *p1,
+			unsigned long *p2, unsigned long *p3,
+			unsigned long *p4);
+extern void xor_regs_5_(unsigned long bytes, unsigned long *p1,
+			unsigned long *p2, unsigned long *p3, unsigned long *p4,
+			unsigned long *p5);
+
+static void xor_rvv_2(unsigned long bytes, unsigned long *p1, unsigned long *p2)
+{
+	kernel_rvv_begin();
+	xor_regs_2_(bytes, p1, p2);
+	kernel_rvv_end();
+}
+
+static void
+xor_rvv_3(unsigned long bytes, unsigned long *p1, unsigned long *p2,
+	  unsigned long *p3)
+{
+	kernel_rvv_begin();
+	xor_regs_3_(bytes, p1, p2, p3);
+	kernel_rvv_end();
+}
+
+static void
+xor_rvv_4(unsigned long bytes, unsigned long *p1, unsigned long *p2,
+	  unsigned long *p3, unsigned long *p4)
+{
+	kernel_rvv_begin();
+	xor_regs_4_(bytes, p1, p2, p3, p4);
+	kernel_rvv_end();
+}
+
+static void
+xor_rvv_5(unsigned long bytes, unsigned long *p1, unsigned long *p2,
+	  unsigned long *p3, unsigned long *p4, unsigned long *p5)
+{
+	kernel_rvv_begin();
+	xor_regs_5_(bytes, p1, p2, p3, p4, p5);
+	kernel_rvv_end();
+}
+
+static struct xor_block_template xor_block_rvv = {
+	.name = "rvv",
+	.do_2 = xor_rvv_2,
+	.do_3 = xor_rvv_3,
+	.do_4 = xor_rvv_4,
+	.do_5 = xor_rvv_5
+};
+
+extern bool has_vector;
+#undef XOR_TRY_TEMPLATES
+#define XOR_TRY_TEMPLATES           \
+	do {        \
+		xor_speed(&xor_block_8regs);    \
+		xor_speed(&xor_block_32regs);    \
+		if (has_vector) { \
+			xor_speed(&xor_block_rvv);\
+		} \
+	} while (0)
+#endif
diff --git a/arch/riscv/lib/Makefile b/arch/riscv/lib/Makefile
index 0d0db80800c4..cedf8d573dc3 100644
--- a/arch/riscv/lib/Makefile
+++ b/arch/riscv/lib/Makefile
@@ -4,3 +4,4 @@ lib-y			+= memcpy.o
 lib-y			+= memset.o
 lib-y			+= uaccess.o
 lib-$(CONFIG_64BIT)	+= tishift.o
+lib-$(CONFIG_VECTOR)	+= xor.o
diff --git a/arch/riscv/lib/xor.S b/arch/riscv/lib/xor.S
new file mode 100644
index 000000000000..de2e234c39ed
--- /dev/null
+++ b/arch/riscv/lib/xor.S
@@ -0,0 +1,81 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+/*
+ * Copyright (C) 2020 SiFive
+ */
+#include <linux/linkage.h>
+#include <asm-generic/export.h>
+#include <asm/asm.h>
+
+ENTRY(xor_regs_2_)
+	vsetvli a3, a0, e8, m8
+	vle8.v v0, (a1)
+	vle8.v v8, (a2)
+	sub a0, a0, a3
+	vxor.vv v16, v0, v8
+	add a2, a2, a3
+	vse8.v v16, (a1)
+	add a1, a1, a3
+	bnez a0, xor_regs_2_
+	ret
+END(xor_regs_2_)
+EXPORT_SYMBOL(xor_regs_2_)
+
+ENTRY(xor_regs_3_)
+	vsetvli a4, a0, e8, m8
+	vle8.v v0, (a1)
+	vle8.v v8, (a2)
+	sub a0, a0, a4
+	vxor.vv v0, v0, v8
+	vle8.v v16, (a3)
+	add a2, a2, a4
+	vxor.vv v16, v0, v16
+	add a3, a3, a4
+	vse8.v v16, (a1)
+	add a1, a1, a4
+	bnez a0, xor_regs_3_
+	ret
+END(xor_regs_3_)
+EXPORT_SYMBOL(xor_regs_3_)
+
+ENTRY(xor_regs_4_)
+	vsetvli a5, a0, e8, m8
+	vle8.v v0, (a1)
+	vle8.v v8, (a2)
+	sub a0, a0, a5
+	vxor.vv v0, v0, v8
+	vle8.v v16, (a3)
+	add a2, a2, a5
+	vxor.vv v0, v0, v16
+	vle8.v v24, (a4)
+	add a3, a3, a5
+	vxor.vv v16, v0, v24
+	add a4, a4, a5
+	vse8.v v16, (a1)
+	add a1, a1, a5
+	bnez a0, xor_regs_4_
+	ret
+END(xor_regs_4_)
+EXPORT_SYMBOL(xor_regs_4_)
+
+ENTRY(xor_regs_5_)
+	vsetvli a6, a0, e8, m8
+	vle8.v v0, (a1)
+	vle8.v v8, (a2)
+	sub a0, a0, a6
+	vxor.vv v0, v0, v8
+	vle8.v v16, (a3)
+	add a2, a2, a6
+	vxor.vv v0, v0, v16
+	vle8.v v24, (a4)
+	add a3, a3, a6
+	vxor.vv v0, v0, v24
+	vle8.v v8, (a5)
+	add a4, a4, a6
+	vxor.vv v16, v0, v8
+	add a5, a5, a6
+	vse8.v v16, (a1)
+	add a1, a1, a6
+	bnez a0, xor_regs_5_
+	ret
+END(xor_regs_5_)
+EXPORT_SYMBOL(xor_regs_5_)
-- 
2.28.0

