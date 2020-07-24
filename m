Return-Path: <SRS0=4orP=BD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12CE2C433E1
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jul 2020 21:03:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D65C7206EB
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jul 2020 21:03:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aEx9uIl7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726731AbgGXVDy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Jul 2020 17:03:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726591AbgGXVDy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jul 2020 17:03:54 -0400
Received: from mail-pj1-x1042.google.com (mail-pj1-x1042.google.com [IPv6:2607:f8b0:4864:20::1042])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 436D8C0619D3
        for <linux-kernel@vger.kernel.org>; Fri, 24 Jul 2020 14:03:54 -0700 (PDT)
Received: by mail-pj1-x1042.google.com with SMTP id a9so6060518pjd.3
        for <linux-kernel@vger.kernel.org>; Fri, 24 Jul 2020 14:03:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=Y8tsa7SxG+dumOjm5p1Tyg2KlYffPKi8RbMVcAZeul8=;
        b=aEx9uIl7yqn6s1YHRISzAd5Jvg13iL0U/nBHZP86n0Uw2eXu6AamP9VvlDCb1XeQ8G
         Bl1EOiKW8mhtg1Ycb5I4IcH8lItRP1qYpoYNO9nYYmEsyfMib4jmiz5fV8Xx/E8q3F9p
         q8f3Noa+pJ79dhl7dfUmHerGWMbnlAu06eWx/xRoFDuhYySE5Bn4SMbXoMkaO4bjys7L
         p14ChAlLAjpjcKm9aywCMFpZdjG7PeI8WxMvDe0qjI8U6Tr04XnyAx9VgPoxB+S1Tlx7
         fuS3Y9rNWRbd819xpIp/JGZDEvO4VicsXGGq0BxsxYFmGuW9ZfNzZmw9hfYTuMwxt1f6
         97CA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=Y8tsa7SxG+dumOjm5p1Tyg2KlYffPKi8RbMVcAZeul8=;
        b=tyA5sX1ZiKe2zT2UDz+ZQEyYO90EB1SRmcK15Hv++IEXz216gDezkwODSIR+kaQU0w
         YbU0r9QRBKqrOPi1sSaC88/qisH0j5Uo1hx0IDHDE5kZzR+VN/6ZgyynPyCg2uic9ebl
         bRkeEfWPXOoVP0+Q/fb8BOwug4AEN+f2lYunhpgSrIOcY2XrtmfLTtxZjfhtMrstu03V
         UVmF1rRRwvGKN2V7yGpFExSz76N8lW+fm9ojcoOKDHDwkbp9q+jvwOcXxCH4qHJ3zPJs
         vsRrCYwk1ty0wkYJ+2CRQdusz3lsHGgdac5FxOoRLEnlP8p78/ysL0+gL0jomzqeMI7y
         zDBQ==
X-Gm-Message-State: AOAM531ocm+tBKmaik9ahat963waom+ukB4pdIMMNBN/TeEztBJXs0gH
        VPl2TlEzkKZZfzRUgh2n8go4HwKE
X-Google-Smtp-Source: ABdhPJwsqk7uqma31vYdv+Oup1pY+aNkR/adzoIgaTuO1TFFh2pa6xDd69Udjq/CeAclYjmTIdJqYA==
X-Received: by 2002:a17:90a:f014:: with SMTP id bt20mr7285519pjb.135.1595624633683;
        Fri, 24 Jul 2020 14:03:53 -0700 (PDT)
Received: from fainelli-desktop.igp.broadcom.net ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id 66sm7481558pfg.63.2020.07.24.14.03.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Jul 2020 14:03:52 -0700 (PDT)
From:   Florian Fainelli <f.fainelli@gmail.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org,
        Florian Fainelli <f.fainelli@gmail.com>,
        bcm-kernel-feedback-list@broadcom.com (maintainer:BROADCOM BCM7XXX ARM
        ARCHITECTURE)
Subject: [PATCH] soc: bcm: brcmstb: biuctrl: Enable Read-ahead cache
Date:   Fri, 24 Jul 2020 14:03:25 -0700
Message-Id: <20200724210328.24812-1-f.fainelli@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Brahma-B53 and Cortex-A72 CPUs integrated on Broadcom STB SoCs feature a
read-ahead cache that performs cache line size adaptation between the
bus interface unit and the memory controller.

On 32-bit ARM kernels we have to resort to a full featured read-ahead
cache driver under arch/arm/mm/cache-b15-rac.c (CONFIG_CACHE_B15_RAC)
because there are still cache maintenance operations by set/ways/index
that cannot be transparently handled by the ARM Coherency Extension that
the read-ahead cache interfaces to.

The 64-bit ARM kernel however has long deprecated all of those, so this
is simply a one time configuration.

Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
---
 drivers/soc/bcm/brcmstb/biuctrl.c | 87 +++++++++++++++++++++++++++----
 1 file changed, 77 insertions(+), 10 deletions(-)

diff --git a/drivers/soc/bcm/brcmstb/biuctrl.c b/drivers/soc/bcm/brcmstb/biuctrl.c
index 61731e01f94b..95602ece51d4 100644
--- a/drivers/soc/bcm/brcmstb/biuctrl.c
+++ b/drivers/soc/bcm/brcmstb/biuctrl.c
@@ -13,6 +13,20 @@
 #include <linux/syscore_ops.h>
 #include <linux/soc/brcmstb/brcmstb.h>
 
+#define RACENPREF_MASK			0x3
+#define RACPREFINST_SHIFT		0
+#define RACENINST_SHIFT			2
+#define RACPREFDATA_SHIFT		4
+#define RACENDATA_SHIFT			6
+#define RAC_CPU_SHIFT			8
+#define RACCFG_MASK			0xff
+
+/* Bitmask to enable instruction and data prefetching with a 256-bytes stride */
+#define RAC_DATA_INST_EN_MASK		(1 << RACPREFINST_SHIFT | \
+					 RACENPREF_MASK << RACENINST_SHIFT | \
+					 1 << RACPREFDATA_SHIFT | \
+					 RACENPREF_MASK << RACENDATA_SHIFT)
+
 #define  CPU_CREDIT_REG_MCPx_WR_PAIRING_EN_MASK	0x70000000
 #define CPU_CREDIT_REG_MCPx_READ_CRED_MASK	0xf
 #define CPU_CREDIT_REG_MCPx_WRITE_CRED_MASK	0xf
@@ -31,11 +45,20 @@ static void __iomem *cpubiuctrl_base;
 static bool mcp_wr_pairing_en;
 static const int *cpubiuctrl_regs;
 
+enum cpubiuctrl_regs {
+	CPU_CREDIT_REG = 0,
+	CPU_MCP_FLOW_REG,
+	CPU_WRITEBACK_CTRL_REG,
+	RAC_CONFIG0_REG,
+	NUM_CPU_BIUCTRL_REGS,
+};
+
 static inline u32 cbc_readl(int reg)
 {
 	int offset = cpubiuctrl_regs[reg];
 
-	if (offset == -1)
+	if (offset == -1 ||
+	    (IS_ENABLED(CONFIG_CACHE_B15_RAC) && reg == RAC_CONFIG0_REG))
 		return (u32)-1;
 
 	return readl_relaxed(cpubiuctrl_base + offset);
@@ -45,22 +68,18 @@ static inline void cbc_writel(u32 val, int reg)
 {
 	int offset = cpubiuctrl_regs[reg];
 
-	if (offset == -1)
+	if (offset == -1 ||
+	    (IS_ENABLED(CONFIG_CACHE_B15_RAC) && reg == RAC_CONFIG0_REG))
 		return;
 
 	writel(val, cpubiuctrl_base + offset);
 }
 
-enum cpubiuctrl_regs {
-	CPU_CREDIT_REG = 0,
-	CPU_MCP_FLOW_REG,
-	CPU_WRITEBACK_CTRL_REG
-};
-
 static const int b15_cpubiuctrl_regs[] = {
 	[CPU_CREDIT_REG] = 0x184,
 	[CPU_MCP_FLOW_REG] = -1,
 	[CPU_WRITEBACK_CTRL_REG] = -1,
+	[RAC_CONFIG0_REG] = -1,
 };
 
 /* Odd cases, e.g: 7260A0 */
@@ -68,22 +87,23 @@ static const int b53_cpubiuctrl_no_wb_regs[] = {
 	[CPU_CREDIT_REG] = 0x0b0,
 	[CPU_MCP_FLOW_REG] = 0x0b4,
 	[CPU_WRITEBACK_CTRL_REG] = -1,
+	[RAC_CONFIG0_REG] = 0x78,
 };
 
 static const int b53_cpubiuctrl_regs[] = {
 	[CPU_CREDIT_REG] = 0x0b0,
 	[CPU_MCP_FLOW_REG] = 0x0b4,
 	[CPU_WRITEBACK_CTRL_REG] = 0x22c,
+	[RAC_CONFIG0_REG] = 0x78,
 };
 
 static const int a72_cpubiuctrl_regs[] = {
 	[CPU_CREDIT_REG] = 0x18,
 	[CPU_MCP_FLOW_REG] = 0x1c,
 	[CPU_WRITEBACK_CTRL_REG] = 0x20,
+	[RAC_CONFIG0_REG] = 0x08,
 };
 
-#define NUM_CPU_BIUCTRL_REGS	3
-
 static int __init mcp_write_pairing_set(void)
 {
 	u32 creds = 0;
@@ -117,6 +137,52 @@ static const u32 a72_b53_mach_compat[] = {
 	0x7278,
 };
 
+/* The read-ahead cache present in the Brahma-B53 CPU is a special piece of
+ * hardware after the integrated L2 cache of the B53 CPU complex whose purpose
+ * is to prefetch instruction and/or data with a line size of either 64 bytes
+ * or 256 bytes. The rationale is that the data-bus of the CPU interface is
+ * optimized for 256-byte transactions, and enabling the read-ahead cache
+ * provides a significant performance boost (typically twice the performance
+ * for a memcpy benchmark application).
+ *
+ * The read-ahead cache is transparent for Virtual Address cache maintenance
+ * operations: IC IVAU, DC IVAC, DC CVAC, DC CVAU and DC CIVAC.  So no special
+ * handling is needed for the DMA API above and beyond what is included in the
+ * arm64 implementation.
+ *
+ * In addition, since the Point of Unification is typically between L1 and L2
+ * for the Brahma-B53 processor no special read-ahead cache handling is needed
+ * for the IC IALLU and IC IALLUIS cache maintenance operations.
+ *
+ * However, it is not possible to specify the cache level (L3) for the cache
+ * maintenance instructions operating by set/way to operate on the read-ahead
+ * cache.  The read-ahead cache will maintain coherency when inner cache lines
+ * are cleaned by set/way, but if it is necessary to invalidate inner cache
+ * lines by set/way to maintain coherency with system masters operating on
+ * shared memory that does not have hardware support for coherency, then it
+ * will also be necessary to explicitly invalidate the read-ahead cache.
+ */
+static void __init a72_b53_rac_enable_all(struct device_node *np)
+{
+	unsigned int cpu;
+	u32 enable = 0;
+
+	if (IS_ENABLED(CONFIG_CACHE_B15_RAC))
+		return;
+
+	if (WARN(num_possible_cpus() > 4, "RAC only supports 4 CPUs\n"))
+		return;
+
+	for_each_possible_cpu(cpu)
+		enable |= RAC_DATA_INST_EN_MASK << (cpu * RAC_CPU_SHIFT);
+
+	cbc_writel(enable, RAC_CONFIG0_REG);
+
+	pr_info("%pOF: Broadcom %s read-ahead cache\n",
+		np, cpubiuctrl_regs == a72_cpubiuctrl_regs ?
+		"Cortex-A72" : "Brahma-B53");
+}
+
 static void __init mcp_a72_b53_set(void)
 {
 	unsigned int i;
@@ -262,6 +328,7 @@ static int __init brcmstb_biuctrl_init(void)
 		return ret;
 	}
 
+	a72_b53_rac_enable_all(np);
 	mcp_a72_b53_set();
 #ifdef CONFIG_PM_SLEEP
 	register_syscore_ops(&brcmstb_cpu_credit_syscore_ops);
-- 
2.17.1

