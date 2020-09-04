Return-Path: <SRS0=2gBQ=CN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A30F9C433E2
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Sep 2020 20:51:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6702C20E65
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Sep 2020 20:51:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SU5eMYwa"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728428AbgIDUvS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 4 Sep 2020 16:51:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728222AbgIDUvG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Sep 2020 16:51:06 -0400
Received: from mail-pg1-x543.google.com (mail-pg1-x543.google.com [IPv6:2607:f8b0:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15D98C061246
        for <linux-kernel@vger.kernel.org>; Fri,  4 Sep 2020 13:51:06 -0700 (PDT)
Received: by mail-pg1-x543.google.com with SMTP id 67so4901493pgd.12
        for <linux-kernel@vger.kernel.org>; Fri, 04 Sep 2020 13:51:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=RxCWHdbfreHXoqDA6qXQiYenauJy3LyU70nLka4sUEA=;
        b=SU5eMYwa7Kg6BYssTOlCn2aHAxL96gMimltZE8qY6MMcY7Oc8eFoD94XcEcUKZumHd
         7+FuKDrc1UfEzMQlARzncCI3xV+bgI1lLi+q7nf/vOc5Ck+FhlPh6B+4t/R+rimeTr6R
         ghjwqP5InNlJDiPix+LACO7CtQqPHvQJisCUJCAG/3EVdvgJC5bd8BO6leVlHcaME04o
         TR7F/gYg43XFoUaxEN5reIN7xd06gcByFDo8T1T1FWPPZBnp8akAOU4/3UNKIYcXdmAY
         G5H36of8B6J1KuZtMS3dB0+SQw9Hqdu/DEPm1qJwjc4n+YVJ1Jqk844SBEjXcdPKBIal
         nk4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=RxCWHdbfreHXoqDA6qXQiYenauJy3LyU70nLka4sUEA=;
        b=tnPl5k5S1cWS/0WTab9u9nYgddw8xRAeABdLK3MPnMUOCumRETz67UL/Sxd6gTUKKu
         fLlpSY5MCgJM2KNAvvuBtdSjmxBJVXPmPBeBTLtlzl/iDbydSqwhHJHJwPTXEK9oKyZ5
         9eSl2tdZHYISR793G9P0GZk94bWkYI20vqVOE8mh39b5RUxJflcvU9HTREh/n0wkuda2
         T4gg6nOu8qOIxSIEFd27iuoSXfx+vDi+pof9wvU+31P7u169xHGePSBuFuVVzcLSlKAM
         EcxN46wSH+D4ou5K8X7bZfPeSUVo+fQhVyn3tjq6nWlPLDHgCxDQBYRrY4wPbV+ruwiQ
         pZ2g==
X-Gm-Message-State: AOAM531Sgt3UH0fx+R4rQAAfey9AETRS7Y5vltGKIae2U514eAXSmas7
        1j+xf71AA1xvNTsgFbSDU4M=
X-Google-Smtp-Source: ABdhPJyaf3izTc2RkFlgrS8LPEQEVC+nZaLiXulPOucvyrGxCwKz1NdnmpoJCskXWsLjCw72qrrbyg==
X-Received: by 2002:a62:5fc4:: with SMTP id t187mr10210651pfb.34.1599252665577;
        Fri, 04 Sep 2020 13:51:05 -0700 (PDT)
Received: from fainelli-desktop.igp.broadcom.net ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id gb17sm6193305pjb.15.2020.09.04.13.51.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Sep 2020 13:51:04 -0700 (PDT)
From:   Florian Fainelli <f.fainelli@gmail.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     Florian Fainelli <f.fainelli@gmail.com>,
        bcm-kernel-feedback-list@broadcom.com (maintainer:BROADCOM BCM7XXX ARM
        ARCHITECTURE), linux-kernel@vger.kernel.org (open list)
Subject: [PATCH 3/4] soc: bcm: brcmstb: biuctrl: Change RAC prefetch distance from +/-1 to +/- 2
Date:   Fri,  4 Sep 2020 13:50:54 -0700
Message-Id: <20200904205055.3309379-5-f.fainelli@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200904205055.3309379-1-f.fainelli@gmail.com>
References: <20200904205055.3309379-1-f.fainelli@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Change the RAC prefetch distance from +/- 1 to +/- 2 for Cortex-A72 CPUs
since this provides an average of a 3.8% performance increase for
synthetic memcpy benchmarks.

Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
---
 drivers/soc/bcm/brcmstb/biuctrl.c | 20 ++++++++++++++++----
 1 file changed, 16 insertions(+), 4 deletions(-)

diff --git a/drivers/soc/bcm/brcmstb/biuctrl.c b/drivers/soc/bcm/brcmstb/biuctrl.c
index d448a89ceb27..28f69cc0df51 100644
--- a/drivers/soc/bcm/brcmstb/biuctrl.c
+++ b/drivers/soc/bcm/brcmstb/biuctrl.c
@@ -20,6 +20,8 @@
 #define RACENDATA_SHIFT			6
 #define RAC_CPU_SHIFT			8
 #define RACCFG_MASK			0xff
+#define DPREF_LINE_2_SHIFT		24
+#define DPREF_LINE_2_MASK		0xff
 
 /* Bitmask to enable instruction and data prefetching with a 256-bytes stride */
 #define RAC_DATA_INST_EN_MASK		(1 << RACPREFINST_SHIFT | \
@@ -50,6 +52,7 @@ enum cpubiuctrl_regs {
 	CPU_MCP_FLOW_REG,
 	CPU_WRITEBACK_CTRL_REG,
 	RAC_CONFIG0_REG,
+	RAC_CONFIG1_REG,
 	NUM_CPU_BIUCTRL_REGS,
 };
 
@@ -58,7 +61,7 @@ static inline u32 cbc_readl(int reg)
 	int offset = cpubiuctrl_regs[reg];
 
 	if (offset == -1 ||
-	    (IS_ENABLED(CONFIG_CACHE_B15_RAC) && reg == RAC_CONFIG0_REG))
+	    (IS_ENABLED(CONFIG_CACHE_B15_RAC) && reg >= RAC_CONFIG0_REG))
 		return (u32)-1;
 
 	return readl_relaxed(cpubiuctrl_base + offset);
@@ -69,7 +72,7 @@ static inline void cbc_writel(u32 val, int reg)
 	int offset = cpubiuctrl_regs[reg];
 
 	if (offset == -1 ||
-	    (IS_ENABLED(CONFIG_CACHE_B15_RAC) && reg == RAC_CONFIG0_REG))
+	    (IS_ENABLED(CONFIG_CACHE_B15_RAC) && reg >= RAC_CONFIG0_REG))
 		return;
 
 	writel(val, cpubiuctrl_base + offset);
@@ -80,6 +83,7 @@ static const int b15_cpubiuctrl_regs[] = {
 	[CPU_MCP_FLOW_REG] = -1,
 	[CPU_WRITEBACK_CTRL_REG] = -1,
 	[RAC_CONFIG0_REG] = -1,
+	[RAC_CONFIG1_REG] = -1,
 };
 
 /* Odd cases, e.g: 7260A0 */
@@ -88,6 +92,7 @@ static const int b53_cpubiuctrl_no_wb_regs[] = {
 	[CPU_MCP_FLOW_REG] = 0x0b4,
 	[CPU_WRITEBACK_CTRL_REG] = -1,
 	[RAC_CONFIG0_REG] = 0x78,
+	[RAC_CONFIG1_REG] = 0x7c,
 };
 
 static const int b53_cpubiuctrl_regs[] = {
@@ -95,6 +100,7 @@ static const int b53_cpubiuctrl_regs[] = {
 	[CPU_MCP_FLOW_REG] = 0x0b4,
 	[CPU_WRITEBACK_CTRL_REG] = 0x22c,
 	[RAC_CONFIG0_REG] = 0x78,
+	[RAC_CONFIG1_REG] = 0x7c,
 };
 
 static const int a72_cpubiuctrl_regs[] = {
@@ -102,6 +108,7 @@ static const int a72_cpubiuctrl_regs[] = {
 	[CPU_MCP_FLOW_REG] = 0x1c,
 	[CPU_WRITEBACK_CTRL_REG] = 0x20,
 	[RAC_CONFIG0_REG] = 0x08,
+	[RAC_CONFIG1_REG] = 0x0c,
 };
 
 static int __init mcp_write_pairing_set(void)
@@ -167,7 +174,7 @@ static const u32 a72_b53_mach_compat[] = {
 static void __init a72_b53_rac_enable_all(struct device_node *np)
 {
 	unsigned int cpu;
-	u32 enable = 0;
+	u32 enable = 0, pref_dist;
 
 	if (IS_ENABLED(CONFIG_CACHE_B15_RAC))
 		return;
@@ -175,10 +182,15 @@ static void __init a72_b53_rac_enable_all(struct device_node *np)
 	if (WARN(num_possible_cpus() > 4, "RAC only supports 4 CPUs\n"))
 		return;
 
-	for_each_possible_cpu(cpu)
+	pref_dist = cbc_readl(RAC_CONFIG1_REG);
+	for_each_possible_cpu(cpu) {
 		enable |= RAC_DATA_INST_EN_MASK << (cpu * RAC_CPU_SHIFT);
+		if (cpubiuctrl_regs == a72_cpubiuctrl_regs)
+			pref_dist |= 1 << (cpu + DPREF_LINE_2_SHIFT);
+	}
 
 	cbc_writel(enable, RAC_CONFIG0_REG);
+	cbc_writel(pref_dist, RAC_CONFIG1_REG);
 
 	pr_info("%pOF: Broadcom %s read-ahead cache\n",
 		np, cpubiuctrl_regs == a72_cpubiuctrl_regs ?
-- 
2.25.1

