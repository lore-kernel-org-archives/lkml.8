Return-Path: <SRS0=wIUh=66=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 627EFC433E0
	for <linux-kernel@archiver.kernel.org>; Sat, 16 May 2020 10:13:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3DF902074D
	for <linux-kernel@archiver.kernel.org>; Sat, 16 May 2020 10:13:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FEwq0wzh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726409AbgEPKNJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 16 May 2020 06:13:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725853AbgEPKNI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 May 2020 06:13:08 -0400
Received: from mail-pl1-x643.google.com (mail-pl1-x643.google.com [IPv6:2607:f8b0:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 556B3C061A0C
        for <linux-kernel@vger.kernel.org>; Sat, 16 May 2020 03:13:08 -0700 (PDT)
Received: by mail-pl1-x643.google.com with SMTP id f15so1988544plr.3
        for <linux-kernel@vger.kernel.org>; Sat, 16 May 2020 03:13:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=Pwph17mYjXF4W7X4OOaH7O6D4wWrQlD3/6R/CLTs2MU=;
        b=FEwq0wzhk004cUb5Kn1Uw/oN4qdmFYBotOM9Ve0jJ3e2E9GJ2R0tqaaIFV2xWltjW/
         Y1EBCHkX0sjnpZHheR1Pb89LokE4oJ5qldBo5qX6Y5EU0wH6LAi3boBIMBWI1hBPK3W/
         Bu7gHOSJoYqmzSoOwRa+OsC16F6LACp5f0iFeB7qdRpf0+vUNcLPtvey6T1W2ytpPE12
         doNRArcxjKp1rcxSUUgAaHwsq7tCtGAoZd7TDb6Kac4PiM/iqp53t274WEA4LtGHHEG+
         3NuDE3g6oRi9pjPya5v3VMlC06BugU2VGXnPh1quGs6GqfMJhuYjErxLYqKahXWtEj38
         Txzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=Pwph17mYjXF4W7X4OOaH7O6D4wWrQlD3/6R/CLTs2MU=;
        b=ITeKeTkDa/AVNlE6Wz5hUXGiPQaSfWYdTAJfV8Z+2RLJ8mSVC91yZO5MXopbPM4RZi
         o2Li5dhYlplaCVknaPw8aDGmFewhyMOV/ee7zRCTgrdadzlm31JFIaP5YZPjFY5jdJuN
         m20jyw0i3LZntB2oy5eiytyOu9qUcvtBV1O1g9OU6NQpYJCL9My7m3SaO/G1FHPVwlOX
         ClMnT1A4kan6ItLUHbJwag0d0wf7yGy9Tc9hJ1pGelrGqySfsVe1wMyt3f90xitwSBVz
         pO1y2cKpDlJpuoCbGy3VF4uFtDHfWgl34UMaFVGb7+WqVnkphN1NKgOzksPlnsOz6n+J
         8Q2Q==
X-Gm-Message-State: AOAM533LvSSeNQ6b0hNiV2UbcQLtatR8KWYZvTqf4GyJvKZNEBDjxBmh
        DVlm19QCEVxRpVzQhK10lT0=
X-Google-Smtp-Source: ABdhPJx9Ug2bqGbT+A81p+K6lAXWVAx17hHCp8MpzGi9VJZO4UMe3eDuSkJPikv0NFBEILxX2Qvgmg==
X-Received: by 2002:a17:90a:fd8c:: with SMTP id cx12mr4489871pjb.211.1589623987977;
        Sat, 16 May 2020 03:13:07 -0700 (PDT)
Received: from localhost.localdomain ([45.135.186.16])
        by smtp.gmail.com with ESMTPSA id x10sm3554542pgr.65.2020.05.16.03.13.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 16 May 2020 03:13:07 -0700 (PDT)
From:   Baolin Wang <baolin.wang7@gmail.com>
To:     lee.jones@linaro.org, arnd@arndb.de
Cc:     broonie@kernel.org, baolin.wang7@gmail.com, orsonzhai@gmail.com,
        zhang.lyra@gmail.com, linux-kernel@vger.kernel.org
Subject: [PATCH v4 1/2] mfd: syscon: Support physical regmap bus
Date:   Sat, 16 May 2020 18:12:28 +0800
Message-Id: <db5adf754300bdc89d561ea3fb23afc4b6a3ee87.1589623456.git.baolin.wang7@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <cover.1589623456.git.baolin.wang7@gmail.com>
References: <cover.1589623456.git.baolin.wang7@gmail.com>
In-Reply-To: <cover.1589623456.git.baolin.wang7@gmail.com>
References: <cover.1589623456.git.baolin.wang7@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some platforms such as Spreadtrum platform, define a special method to
update bits of the registers instead of reading and writing, which means
we should use a physical regmap bus to define the reg_update_bits()
operation instead of the MMIO regmap bus.

Thus add a a __weak function  for the syscon driver to allow to register
a physical regmap bus to support this new requirement.

Signed-off-by: Baolin Wang <baolin.wang7@gmail.com>
---
 drivers/mfd/syscon.c       |  9 ++++++++-
 include/linux/mfd/syscon.h | 11 +++++++++++
 2 files changed, 19 insertions(+), 1 deletion(-)

diff --git a/drivers/mfd/syscon.c b/drivers/mfd/syscon.c
index 3a97816d0cba..dc92f3177ceb 100644
--- a/drivers/mfd/syscon.c
+++ b/drivers/mfd/syscon.c
@@ -40,6 +40,13 @@ static const struct regmap_config syscon_regmap_config = {
 	.reg_stride = 4,
 };
 
+struct regmap * __weak syscon_regmap_init(struct device_node *np,
+					  void __iomem *base,
+					  struct regmap_config *syscon_config)
+{
+	return regmap_init_mmio(NULL, base, syscon_config);
+}
+
 static struct syscon *of_syscon_register(struct device_node *np, bool check_clk)
 {
 	struct clk *clk;
@@ -106,7 +113,7 @@ static struct syscon *of_syscon_register(struct device_node *np, bool check_clk)
 	syscon_config.val_bits = reg_io_width * 8;
 	syscon_config.max_register = resource_size(&res) - reg_io_width;
 
-	regmap = regmap_init_mmio(NULL, base, &syscon_config);
+	regmap = syscon_regmap_init(np, base, &syscon_config);
 	if (IS_ERR(regmap)) {
 		pr_err("regmap init failed\n");
 		ret = PTR_ERR(regmap);
diff --git a/include/linux/mfd/syscon.h b/include/linux/mfd/syscon.h
index 7f20e9b502a5..85088e44fe7c 100644
--- a/include/linux/mfd/syscon.h
+++ b/include/linux/mfd/syscon.h
@@ -13,6 +13,7 @@
 
 #include <linux/err.h>
 #include <linux/errno.h>
+#include <linux/regmap.h>
 
 struct device_node;
 
@@ -28,6 +29,9 @@ extern struct regmap *syscon_regmap_lookup_by_phandle_args(
 					const char *property,
 					int arg_count,
 					unsigned int *out_args);
+extern struct regmap *syscon_regmap_init(struct device_node *np,
+					 void __iomem *base,
+					 struct regmap_config *syscon_config);
 #else
 static inline struct regmap *device_node_to_regmap(struct device_node *np)
 {
@@ -59,6 +63,13 @@ static inline struct regmap *syscon_regmap_lookup_by_phandle_args(
 {
 	return ERR_PTR(-ENOTSUPP);
 }
+
+static inline struct regmap *syscon_regmap_init(struct device_node *np,
+						void __iomem *base,
+						struct regmap_config *syscon_config)
+{
+	return ERR_PTR(-ENOTSUPP);
+}
 #endif
 
 #endif /* __LINUX_MFD_SYSCON_H__ */
-- 
2.17.1

