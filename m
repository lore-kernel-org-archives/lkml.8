Return-Path: <SRS0=n+Ub=5Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1D69C2D0EA
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Apr 2020 08:58:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6F5AD20757
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Apr 2020 08:58:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KUnpqvor"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726681AbgDII6R (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Apr 2020 04:58:17 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:38782 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725972AbgDII6R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Apr 2020 04:58:17 -0400
Received: by mail-pf1-f194.google.com with SMTP id c21so3831389pfo.5
        for <linux-kernel@vger.kernel.org>; Thu, 09 Apr 2020 01:58:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=nr51atrKn1Az/ez7AUO/WBs2C0nP6WcScW/49wxP3BQ=;
        b=KUnpqvorJVsFGhFoJRciP3xfW2yY5ecOmnEWt7K46Z5EFnG8aks7cEUBqK1LQdkYBq
         P0xSVksaYYwapnPQg3TfYZ/+eTMMSuRDhbp1yeCYTs4dILJB+kKyZdYJ1YNmfmseEKNr
         Tp9qQs41wU+07mp2/bCUa2Apmwps7ASDfHc+sFuRKm0W+sDVdT5bR/xkQVUYF/iS5aip
         YEZmm6DUWMXiALgjVqBLxdFUnRLkwSdqLLml7bizikae49QHQJb62J0JPzq2LXpD6n7f
         QZXIQ2FDsqiNgCj9xAS5PEvohU5XnG3cKPRM9yUzkJgiKSxyxJ60aD2qHGb0RL/jLCGY
         J/yQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=nr51atrKn1Az/ez7AUO/WBs2C0nP6WcScW/49wxP3BQ=;
        b=ChSmtZFhbCwmG4Qwx/Z52DGe4Xa/m0cbUzhuKCxGvhRtdPzDkBw6XumlZB9bQmBX0K
         FqIRBwMwq31JoI4rPfmqcioUrgoeqbp+wectcBUyGuRwXPloKnocvDU4W326Yur9catc
         WNr43Ufw5+vwbFPcjAhzkhO9J+5tC600USqG2/2o5touxKYin42wcDGIsLUM6H01uzA1
         kia6fng284Mh0U0IzjqtRWC5+1c0qq8/7ZJ5z7tUKKc/TnR6nnA/iOHM8GMFLUrf5eE0
         Yw3XvHrgECefm4hU8f59HhbvPQD1i8gtnFd8VmVeJT5eKljNpmvX7/bwF59ceYmxfQJq
         tTRQ==
X-Gm-Message-State: AGi0PuYMsTm0qJML6h+LAYG2BfQRMuYCjl3489rxS3SCXQk12jd1Q8/J
        HWV8v/HwZ9uKyT5pTsxZsfE=
X-Google-Smtp-Source: APiQypKosFsA2VBNm7ieaOiBe5tl/O4B5VBtwuyBJSg3/LR/CqWg2U8asT28lp/iLKM9COBqswAsKg==
X-Received: by 2002:a63:e56:: with SMTP id 22mr11000344pgo.173.1586422697267;
        Thu, 09 Apr 2020 01:58:17 -0700 (PDT)
Received: from sh03840pcu.spreadtrum.com ([117.18.48.82])
        by smtp.gmail.com with ESMTPSA id s9sm1561712pjr.5.2020.04.09.01.58.13
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 09 Apr 2020 01:58:16 -0700 (PDT)
From:   Baolin Wang <baolin.wang7@gmail.com>
To:     lee.jones@linaro.org, arnd@arndb.de, broonie@kernel.org
Cc:     orsonzhai@gmail.com, zhang.lyra@gmail.com, baolin.wang7@gmail.com,
        linux-kernel@vger.kernel.org
Subject: [RFC PATCH 1/3] mfd: syscon: Add reg_update_bits() callback support
Date:   Thu,  9 Apr 2020 16:57:57 +0800
Message-Id: <759f7471d03946ae273a06f7bcca8a54528ec08c.1586422035.git.baolin.wang7@gmail.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <cover.1586422035.git.baolin.wang7@gmail.com>
References: <cover.1586422035.git.baolin.wang7@gmail.com>
In-Reply-To: <cover.1586422035.git.baolin.wang7@gmail.com>
References: <cover.1586422035.git.baolin.wang7@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some platforms such as Spreadtrum platform, define a special method to
update bits of the registers instead of reading and writing, thus add
a new reg_update_bits() callback for struct regmap_config and a helper
for syscon driver to support this new feature.

Signed-off-by: Baolin Wang <baolin.wang7@gmail.com>
---
 drivers/mfd/syscon.c       | 10 ++++++++++
 include/linux/mfd/syscon.h |  8 ++++++++
 include/linux/regmap.h     |  4 ++++
 3 files changed, 22 insertions(+)

diff --git a/drivers/mfd/syscon.c b/drivers/mfd/syscon.c
index 3a97816..cf6efe2 100644
--- a/drivers/mfd/syscon.c
+++ b/drivers/mfd/syscon.c
@@ -34,6 +34,8 @@ struct syscon {
 	struct list_head list;
 };
 
+static regmap_hw_reg_update_bits reg_update_bits;
+
 static const struct regmap_config syscon_regmap_config = {
 	.reg_bits = 32,
 	.val_bits = 32,
@@ -105,6 +107,7 @@ static struct syscon *of_syscon_register(struct device_node *np, bool check_clk)
 	syscon_config.reg_stride = reg_io_width;
 	syscon_config.val_bits = reg_io_width * 8;
 	syscon_config.max_register = resource_size(&res) - reg_io_width;
+	syscon_config.reg_update_bits = reg_update_bits;
 
 	regmap = regmap_init_mmio(NULL, base, &syscon_config);
 	if (IS_ERR(regmap)) {
@@ -172,6 +175,13 @@ static struct regmap *device_node_get_regmap(struct device_node *np,
 	return syscon->regmap;
 }
 
+void syscon_register_reg_update_bits(regmap_hw_reg_update_bits hw_reg_update_bits)
+{
+	if (hw_reg_update_bits)
+		reg_update_bits = hw_reg_update_bits;
+}
+EXPORT_SYMBOL_GPL(syscon_register_reg_update_bits);
+
 struct regmap *device_node_to_regmap(struct device_node *np)
 {
 	return device_node_get_regmap(np, false);
diff --git a/include/linux/mfd/syscon.h b/include/linux/mfd/syscon.h
index 7f20e9b..b64ef84 100644
--- a/include/linux/mfd/syscon.h
+++ b/include/linux/mfd/syscon.h
@@ -13,6 +13,7 @@
 
 #include <linux/err.h>
 #include <linux/errno.h>
+#include <linux/regmap.h>
 
 struct device_node;
 
@@ -28,6 +29,8 @@ extern struct regmap *syscon_regmap_lookup_by_phandle_args(
 					const char *property,
 					int arg_count,
 					unsigned int *out_args);
+extern void
+syscon_register_reg_update_bits(regmap_hw_reg_update_bits hw_reg_update_bits);
 #else
 static inline struct regmap *device_node_to_regmap(struct device_node *np)
 {
@@ -59,6 +62,11 @@ static inline struct regmap *syscon_regmap_lookup_by_phandle_args(
 {
 	return ERR_PTR(-ENOTSUPP);
 }
+
+static inline void
+syscon_register_reg_update_bits(regmap_hw_reg_update_bits hw_reg_update_bits)
+{
+}
 #endif
 
 #endif /* __LINUX_MFD_SYSCON_H__ */
diff --git a/include/linux/regmap.h b/include/linux/regmap.h
index 40b0716..78c1036 100644
--- a/include/linux/regmap.h
+++ b/include/linux/regmap.h
@@ -340,6 +340,8 @@ struct regmap_access_table {
  *		  read operation on a bus such as SPI, I2C, etc. Most of the
  *		  devices do not need this.
  * @reg_write:	  Same as above for writing.
+ * @reg_update_bits: Optional, should only be provided for devices whose update
+ *		     operation cannot be represented as read and write.
  * @fast_io:	  Register IO is fast. Use a spinlock instead of a mutex
  *	     	  to perform locking. This field is ignored if custom lock/unlock
  *	     	  functions are used (see fields lock/unlock of struct regmap_config).
@@ -416,6 +418,8 @@ struct regmap_config {
 
 	int (*reg_read)(void *context, unsigned int reg, unsigned int *val);
 	int (*reg_write)(void *context, unsigned int reg, unsigned int val);
+	int (*reg_update_bits)(void *context, unsigned int reg,
+			       unsigned int mask, unsigned int val);
 
 	bool fast_io;
 
-- 
1.9.1

