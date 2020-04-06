Return-Path: <SRS0=Zj89=5W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A457C2BA2B
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Apr 2020 07:40:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5C38720780
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Apr 2020 07:40:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726702AbgDFHkj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Apr 2020 03:40:39 -0400
Received: from mga06.intel.com ([134.134.136.31]:31242 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726475AbgDFHkj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Apr 2020 03:40:39 -0400
IronPort-SDR: V8iocR8QX8+wK0xxJR1TkmQiGQvkcQzYuVn4OL/dkxGKsbI4HQmrTIPdA9V8HF2rE+cpUiSigT
 /XKn80TQ2fKg==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Apr 2020 00:40:38 -0700
IronPort-SDR: ZVTFNVLe5kvKMu9lsBrkcKmQzFG0AiAH9Wxg/pqTK0M2SUNvHC5bZuIHkuOv57YvCK5DG45n1T
 DuI8QDpawxvQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,350,1580803200"; 
   d="scan'208";a="451986108"
Received: from sgsxdev004.isng.intel.com (HELO localhost) ([10.226.88.13])
  by fmsmga006.fm.intel.com with ESMTP; 06 Apr 2020 00:40:35 -0700
From:   Dilip Kota <eswara.kota@linux.intel.com>
To:     linux-kernel@vger.kernel.org, kishon@ti.com,
        devicetree@vger.kernel.org, lee.jones@linaro.org, arnd@arndb.de
Cc:     robh@kernel.org, andriy.shevchenko@intel.com,
        cheol.yong.kim@intel.com, chuanhua.lei@linux.intel.com,
        qi-ming.wu@intel.com, yixin.zhu@intel.com,
        Dilip Kota <eswara.kota@linux.intel.com>
Subject: [RESEND PATCH v6 1/4] mfd: syscon: Add fwnode_to_regmap
Date:   Mon,  6 Apr 2020 15:39:53 +0800
Message-Id:
 <9c58aeb1561f28f302921d54aee75942545c4971.1585889042.git.eswara.kota@linux.intel.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <cover.1585889042.git.eswara.kota@linux.intel.com>
References: <cover.1585889042.git.eswara.kota@linux.intel.com>
In-Reply-To: <cover.1585889042.git.eswara.kota@linux.intel.com>
References: <cover.1585889042.git.eswara.kota@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Message-ID: <20200406073953.ZH2kaflD1e4JMxbGXCWBc0PCT2QahaAEBGfgYavI7QQ@z>

Traverse regmap handle entry from firmware node handle.

Signed-off-by: Dilip Kota <eswara.kota@linux.intel.com>
---
Changes on v5:
  No changes
  
Changes on v5:
  No changes

Changes on v4:
  No changes

 drivers/mfd/syscon.c       | 8 ++++++++
 include/linux/mfd/syscon.h | 6 ++++++
 2 files changed, 14 insertions(+)

diff --git a/drivers/mfd/syscon.c b/drivers/mfd/syscon.c
index 3a97816d0cba..e085c50816b9 100644
--- a/drivers/mfd/syscon.c
+++ b/drivers/mfd/syscon.c
@@ -178,6 +178,14 @@ struct regmap *device_node_to_regmap(struct device_node *np)
 }
 EXPORT_SYMBOL_GPL(device_node_to_regmap);
 
+struct regmap *fwnode_to_regmap(struct fwnode_handle *fwnode)
+{
+	struct device_node *np = to_of_node(fwnode);
+
+	return device_node_get_regmap(np, false);
+}
+EXPORT_SYMBOL_GPL(fwnode_to_regmap);
+
 struct regmap *syscon_node_to_regmap(struct device_node *np)
 {
 	if (!of_device_is_compatible(np, "syscon"))
diff --git a/include/linux/mfd/syscon.h b/include/linux/mfd/syscon.h
index 7f20e9b502a5..dacab0b4a091 100644
--- a/include/linux/mfd/syscon.h
+++ b/include/linux/mfd/syscon.h
@@ -18,6 +18,7 @@ struct device_node;
 
 #ifdef CONFIG_MFD_SYSCON
 extern struct regmap *device_node_to_regmap(struct device_node *np);
+extern struct regmap *fwnode_to_regmap(struct fwnode_handle *fwnode);
 extern struct regmap *syscon_node_to_regmap(struct device_node *np);
 extern struct regmap *syscon_regmap_lookup_by_compatible(const char *s);
 extern struct regmap *syscon_regmap_lookup_by_phandle(
@@ -34,6 +35,11 @@ static inline struct regmap *device_node_to_regmap(struct device_node *np)
 	return ERR_PTR(-ENOTSUPP);
 }
 
+static inline struct regmap *fwnode_to_regmap(struct fwnode_handle *fwnode)
+{
+	return ERR_PTR(-ENOTSUPP);
+}
+
 static inline struct regmap *syscon_node_to_regmap(struct device_node *np)
 {
 	return ERR_PTR(-ENOTSUPP);
-- 
2.11.0

