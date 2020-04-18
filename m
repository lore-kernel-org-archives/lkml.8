Return-Path: <SRS0=3CHW=6C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D62FC3815B
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Apr 2020 01:57:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5AC78221EA
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Apr 2020 01:57:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LJHx5Rqs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725939AbgDRBxq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Apr 2020 21:53:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725535AbgDRBxp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Apr 2020 21:53:45 -0400
Received: from mail-pl1-x644.google.com (mail-pl1-x644.google.com [IPv6:2607:f8b0:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2921CC061A0C
        for <linux-kernel@vger.kernel.org>; Fri, 17 Apr 2020 18:53:44 -0700 (PDT)
Received: by mail-pl1-x644.google.com with SMTP id v2so1622024plp.9
        for <linux-kernel@vger.kernel.org>; Fri, 17 Apr 2020 18:53:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=A9fgktb4vawbiefZhLEsxPgcZT5WQtSwsxwDz942ap4=;
        b=LJHx5Rqsfiz/dPYJ4Y0FCxgLNzMYEI3d1YLZs3k9tKMtqukM42mXir4uT9fUKZmax/
         1RqdpkP/TF4mrepto+xDelipkSzV8LzG/cckN/EkwLYdHDHxlDXh+0efZenGYUBxoBIM
         1suwRa/ljULzb3MZICmPWLb4+PcVjynNAh5PeYD6Z53drjjD0i6Vg7/Y0Hr08JnX0RkD
         C93GyL4ii8w/mj3XS9cPlUlr3rzce4yC881EFIKCGwbF40coK/buZWL6RAmQtNOyu/Ym
         JGJvCN3omc14sPVbDcKcqtJ7uKkSELoO5iMxWO+mQf14G2D/jDxuS8WBBUdQ7GlqQmuH
         sdKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=A9fgktb4vawbiefZhLEsxPgcZT5WQtSwsxwDz942ap4=;
        b=fZT5bXTeTU3PlMC6+mXbO2Koqq8sJS0I5HxXbMI5pvC5oBDBdzQz0uO+229ECxjlmT
         7iaYiD+83EDx+9MTGfoDFBjPUcxpJfnTKBbJojcacXwqrr0VGBsp8mg7GhSesavMNNtC
         d2uSmqJHyTyg+nOff+t6tsQsSWd1z1KRIfLI5C52/Y3T8/RX3ifopwdEq7Fbjbbqj+KD
         f8cIwotAxgpcYRNkw2mgZ4i1UBSVByHYvPNrT8xpFdcPgqtvF5PZosoVtvj+kLPNw8KM
         inaab/zknHNn91uW2gUQgqi9NQvDU4a9+Ejwrg7oYvIIQINBdOEEe+AeR7pDy6bAblPI
         6/IQ==
X-Gm-Message-State: AGi0PuYFD8J51XkFkI15eyg2TYWZjcaCzEk/cxUkoWnZOdGSNL/uYYHt
        6uTycA9bbhdyOgzXT6KVBAY=
X-Google-Smtp-Source: APiQypKZZ8C04PV2P0Iw3R7pz9vka5Qz/7oTbWn8T8QEEH7UNHfo2g9r/83Z3t2RzFXmn6tB6vSwSA==
X-Received: by 2002:a17:90a:dd45:: with SMTP id u5mr7475081pjv.19.1587174823649;
        Fri, 17 Apr 2020 18:53:43 -0700 (PDT)
Received: from localhost.localdomain ([45.135.186.72])
        by smtp.gmail.com with ESMTPSA id a22sm15539470pfg.169.2020.04.17.18.53.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Apr 2020 18:53:42 -0700 (PDT)
From:   Baolin Wang <baolin.wang7@gmail.com>
To:     lee.jones@linaro.org, arnd@arndb.de
Cc:     broonie@kernel.org, baolin.wang7@gmail.com, orsonzhai@gmail.com,
        zhang.lyra@gmail.com, linux-kernel@vger.kernel.org
Subject: [PATCH v2] mfd: syscon: Add Spreadtrum physical regmap bus support
Date:   Sat, 18 Apr 2020 09:53:11 +0800
Message-Id: <328db39335b515b190b518445a777ee97751d393.1587173992.git.baolin.wang7@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some platforms such as Spreadtrum platform, define a special method to
update bits of the registers instead of read-modify-write, which means
we should use a physical regmap bus to define the reg_update_bits()
operation instead of the MMIO regmap bus. Thus we can register a new
physical regmap bus into syscon core to support this.

Signed-off-by: Baolin Wang <baolin.wang7@gmail.com>
---
Changes from v1:
 - Add WARN_ONCE() for seting bits and clearing bits at the same time.
 - Remove the Spreadtrum SoC syscon driver, instead moving the regmap_bus
 instance into syscon.c driver.

Changes from RFC v2:
 - Drop regmap change, which was applied by Mark.
 - Add more information about how to use set/clear.
 - Add checking to ensure the platform is compatible with
 using a new physical regmap bus.

Changes from RFC v1:
 - Add new helper to registers a physical regmap bus instead of
 using the MMIO bus.
---
 drivers/mfd/syscon.c | 81 ++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 79 insertions(+), 2 deletions(-)

diff --git a/drivers/mfd/syscon.c b/drivers/mfd/syscon.c
index 3a97816d0cba..f85420d14ce3 100644
--- a/drivers/mfd/syscon.c
+++ b/drivers/mfd/syscon.c
@@ -40,6 +40,70 @@ static const struct regmap_config syscon_regmap_config = {
 	.reg_stride = 4,
 };
 
+#if IS_ENABLED(CONFIG_ARCH_SPRD)
+#define SPRD_REG_SET_OFFSET	0x1000
+#define SPRD_REG_CLR_OFFSET	0x2000
+
+/*
+ * The Spreadtrum platform defines a special set/clear method to update
+ * registers' bits, which means it can write values to the register's SET
+ * address (offset is 0x1000) to set bits, and write values to the register's
+ * CLEAR address (offset is 0x2000) to clear bits.
+ *
+ * This set/clear method can help to remove the race of accessing the global
+ * registers between the multiple subsystems instead of using hardware
+ * spinlocks.
+ *
+ * Note: there is a potential risk when users want to set and clear bits
+ * at the same time, since the set/clear method will always do bits setting
+ * before bits clearing, which may cause some unexpected results if the
+ * operation sequence is strict. Thus we recommend that do not set and
+ * clear bits at the same time if you are not sure about the results.
+ */
+static int sprd_syscon_update_bits(void *context, unsigned int reg,
+				   unsigned int mask, unsigned int val)
+{
+	void __iomem *base = context;
+	unsigned int set, clr;
+
+	set = val & mask;
+	clr = ~set & mask;
+
+	if (set)
+		writel(set, base + reg + SPRD_REG_SET_OFFSET);
+
+	if (clr)
+		writel(clr, base + reg + SPRD_REG_CLR_OFFSET);
+
+	WARN_ONCE(set && clr, "%s: non-atomic update", __func__);
+	return 0;
+}
+
+static int sprd_syscon_read(void *context, unsigned int reg, unsigned int *val)
+{
+	void __iomem *base = context;
+
+	*val = readl(base + reg);
+	return 0;
+}
+
+static int sprd_syscon_write(void *context, unsigned int reg, unsigned int val)
+{
+	void __iomem *base = context;
+
+	writel(val, base + reg);
+	return 0;
+}
+
+static struct regmap_bus sprd_syscon_regmap_bus = {
+	.fast_io = true,
+	.reg_write = sprd_syscon_write,
+	.reg_read = sprd_syscon_read,
+	.reg_update_bits = sprd_syscon_update_bits,
+	.val_format_endian_default = REGMAP_ENDIAN_LITTLE,
+};
+#endif
+
 static struct syscon *of_syscon_register(struct device_node *np, bool check_clk)
 {
 	struct clk *clk;
@@ -50,6 +114,7 @@ static struct syscon *of_syscon_register(struct device_node *np, bool check_clk)
 	int ret;
 	struct regmap_config syscon_config = syscon_regmap_config;
 	struct resource res;
+	bool use_phy_regmap_bus = false;
 
 	syscon = kzalloc(sizeof(*syscon), GFP_KERNEL);
 	if (!syscon)
@@ -106,14 +171,26 @@ static struct syscon *of_syscon_register(struct device_node *np, bool check_clk)
 	syscon_config.val_bits = reg_io_width * 8;
 	syscon_config.max_register = resource_size(&res) - reg_io_width;
 
-	regmap = regmap_init_mmio(NULL, base, &syscon_config);
+	 /*
+	  * The Spreadtrum syscon need register a real physical regmap bus
+	  * with new atomic bits updating operation instead of using
+	  * read-modify-write.
+	  */
+	if (IS_ENABLED(CONFIG_ARCH_SPRD) &&
+	    of_device_is_compatible(np, "sprd,atomic-syscon")) {
+		use_phy_regmap_bus = true;
+		regmap = regmap_init(NULL, &sprd_syscon_regmap_bus, base,
+				     &syscon_config);
+	} else {
+		regmap = regmap_init_mmio(NULL, base, &syscon_config);
+	}
 	if (IS_ERR(regmap)) {
 		pr_err("regmap init failed\n");
 		ret = PTR_ERR(regmap);
 		goto err_regmap;
 	}
 
-	if (check_clk) {
+	if (!use_phy_regmap_bus && check_clk) {
 		clk = of_clk_get(np, 0);
 		if (IS_ERR(clk)) {
 			ret = PTR_ERR(clk);
-- 
2.17.1

