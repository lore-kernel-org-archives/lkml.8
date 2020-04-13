Return-Path: <SRS0=sVLE=55=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5883C2BA19
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Apr 2020 06:13:53 +0000 (UTC)
Received: from vger.kernel.org (unknown [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 72CE220731
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Apr 2020 06:13:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GfNvBiCU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 72CE220731
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727041AbgDMGNw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Apr 2020 02:13:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.18]:48228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726138AbgDMGNv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Apr 2020 02:13:51 -0400
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com [IPv6:2607:f8b0:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08AE8C0A3BE0
        for <linux-kernel@vger.kernel.org>; Sun, 12 Apr 2020 23:13:51 -0700 (PDT)
Received: by mail-pf1-x441.google.com with SMTP id r20so2425396pfh.9
        for <linux-kernel@vger.kernel.org>; Sun, 12 Apr 2020 23:13:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=auYmqYDM1/7u1gkIGGIbmBahIPEKepRX3a1enGdJRB0=;
        b=GfNvBiCU+sLaDhQj5vqhY89ljMY161UZKuRt9Re6Y/GBvo2JDLMrrhESAhxdjjO9TU
         lIsFEmwW0ePezpzqA0OnE5XBEUfvoIr6xmDAkL5oaeRnbtjTWUXQY56b44y31pPp2eJQ
         tK5W7hcfkMqaRiEUXNgEMDYMBZDG6LLvjF7WYCVXNqR3eM2GkRE8nklbSuHoakYUQp9F
         SGJrLquh6/AE5XEGd+RSKBAamMNqA0ufyN3kXuP+zjbOYzcHJ14zEHpeJKCXVv6KBBie
         O8/ScfjK+QjC03jFFrBKGBpf2Dll0wjy4J/7JzMrLDdVzxiZg5E/47KVqH5UojsHkVb9
         39Ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=auYmqYDM1/7u1gkIGGIbmBahIPEKepRX3a1enGdJRB0=;
        b=Rge83GOpzmsh52v4j9hgqGXI66g+lkxzqD68v1e3aU7YZX36L99reiVl1/A6ZknTVS
         mFpKbukEOpf/YeKeRI4xhgww3kRGuAqhU9v4twjgExJYByiCkKv2JWErBQ7JI2wjk3/O
         4NAQbotspTIFScwzjgTyQSmFu+Uu7jv02i0CQdXMQwDFqvkpo41LETxZyS0HU1zbeh68
         z+iilty8H3xL2b0C/RaWUuFLLbK8Dh8mt9hnNQzQhxUF/E5RxiEhzVJoBWypQfhOBdSo
         Lzf122I5LlNlTEDmUK5mdRcX7RyTJ+Jy0/fAaYyZ8e/I9Dk1iLGnjddIC9cHuj39pByi
         z0fg==
X-Gm-Message-State: AGi0PuaHpj28OZejGJnpYo5FGb6azujHNJD2oar02vMMOUWmB0ToAkQF
        ObdttGlybdlODqqvoO6gGP4=
X-Google-Smtp-Source: APiQypINZLNzv946Hr9wE7c05M2XXhdaivVmrXhiDb4R421ZtJN1W0rXxCq/iNf7IrAXfgcvku8Y6A==
X-Received: by 2002:aa7:9f4a:: with SMTP id h10mr16559837pfr.234.1586758430610;
        Sun, 12 Apr 2020 23:13:50 -0700 (PDT)
Received: from localhost.localdomain ([45.135.186.19])
        by smtp.gmail.com with ESMTPSA id w5sm7712645pfw.154.2020.04.12.23.13.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 Apr 2020 23:13:50 -0700 (PDT)
From:   Baolin Wang <baolin.wang7@gmail.com>
To:     lee.jones@linaro.org, arnd@arndb.de, broonie@kernel.org
Cc:     baolin.wang7@gmail.com, orsonzhai@gmail.com, zhang.lyra@gmail.com,
        linux-kernel@vger.kernel.org
Subject: [RFC PATCH v2 1/3] mfd: syscon: Support physical regmap bus
Date:   Mon, 13 Apr 2020 14:13:19 +0800
Message-Id: <a3187ff166bf4434362b92d91149a8e445c4ed0c.1586757922.git.baolin.wang7@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <cover.1586757922.git.baolin.wang7@gmail.com>
References: <cover.1586757922.git.baolin.wang7@gmail.com>
In-Reply-To: <cover.1586757922.git.baolin.wang7@gmail.com>
References: <cover.1586757922.git.baolin.wang7@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some platforms such as Spreadtrum platform, define a special method to
update bits of the registers instead of reading and writing, which means
we should use a physical regmap bus to define the reg_update_bits()
operation instead of the MMIO regmap bus.

Thus add a new helper for the syscon driver to allow to register a physical
regmap bus to support this new requirement.

Signed-off-by: Baolin Wang <baolin.wang7@gmail.com>
---
 drivers/mfd/syscon.c       | 16 ++++++++++++++--
 include/linux/mfd/syscon.h |  7 +++++++
 2 files changed, 21 insertions(+), 2 deletions(-)

diff --git a/drivers/mfd/syscon.c b/drivers/mfd/syscon.c
index 3a97816d0cba..5de74e1b6634 100644
--- a/drivers/mfd/syscon.c
+++ b/drivers/mfd/syscon.c
@@ -24,6 +24,7 @@
 #include <linux/slab.h>
 
 static struct platform_driver syscon_driver;
+static struct regmap_bus *syscon_phy_regmap_bus;
 
 static DEFINE_SPINLOCK(syscon_list_slock);
 static LIST_HEAD(syscon_list);
@@ -106,14 +107,18 @@ static struct syscon *of_syscon_register(struct device_node *np, bool check_clk)
 	syscon_config.val_bits = reg_io_width * 8;
 	syscon_config.max_register = resource_size(&res) - reg_io_width;
 
-	regmap = regmap_init_mmio(NULL, base, &syscon_config);
+	if (syscon_phy_regmap_bus)
+		regmap = regmap_init(NULL, syscon_phy_regmap_bus, base,
+				     &syscon_config);
+	else
+		regmap = regmap_init_mmio(NULL, base, &syscon_config);
 	if (IS_ERR(regmap)) {
 		pr_err("regmap init failed\n");
 		ret = PTR_ERR(regmap);
 		goto err_regmap;
 	}
 
-	if (check_clk) {
+	if (check_clk && !syscon_phy_regmap_bus) {
 		clk = of_clk_get(np, 0);
 		if (IS_ERR(clk)) {
 			ret = PTR_ERR(clk);
@@ -172,6 +177,13 @@ static struct regmap *device_node_get_regmap(struct device_node *np,
 	return syscon->regmap;
 }
 
+void syscon_register_phys_regmap_bus(struct regmap_bus *phy_regmap_bus)
+{
+	if (phy_regmap_bus)
+		syscon_phy_regmap_bus = phy_regmap_bus;
+}
+EXPORT_SYMBOL_GPL(syscon_register_phys_regmap_bus);
+
 struct regmap *device_node_to_regmap(struct device_node *np)
 {
 	return device_node_get_regmap(np, false);
diff --git a/include/linux/mfd/syscon.h b/include/linux/mfd/syscon.h
index 7f20e9b502a5..fbc2a2f0f414 100644
--- a/include/linux/mfd/syscon.h
+++ b/include/linux/mfd/syscon.h
@@ -13,6 +13,7 @@
 
 #include <linux/err.h>
 #include <linux/errno.h>
+#include <linux/regmap.h>
 
 struct device_node;
 
@@ -28,6 +29,7 @@ extern struct regmap *syscon_regmap_lookup_by_phandle_args(
 					const char *property,
 					int arg_count,
 					unsigned int *out_args);
+extern void syscon_register_phys_regmap_bus(struct regmap_bus *phy_regmap_bus);
 #else
 static inline struct regmap *device_node_to_regmap(struct device_node *np)
 {
@@ -59,6 +61,11 @@ static inline struct regmap *syscon_regmap_lookup_by_phandle_args(
 {
 	return ERR_PTR(-ENOTSUPP);
 }
+
+static inline void
+syscon_register_phys_regmap_bus(struct regmap_bus *phy_regmap_bus)
+{
+}
 #endif
 
 #endif /* __LINUX_MFD_SYSCON_H__ */
-- 
2.17.1

