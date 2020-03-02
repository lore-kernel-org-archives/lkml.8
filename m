Return-Path: <SRS0=29cB=4T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BCD93C3F2D4
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Mar 2020 08:43:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 99B9C246B6
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Mar 2020 08:43:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727490AbgCBInn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Mar 2020 03:43:43 -0500
Received: from mga14.intel.com ([192.55.52.115]:45723 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727159AbgCBInn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Mar 2020 03:43:43 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 02 Mar 2020 00:43:42 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,506,1574150400"; 
   d="scan'208";a="243133911"
Received: from sgsxdev004.isng.intel.com (HELO localhost) ([10.226.88.13])
  by orsmga006.jf.intel.com with ESMTP; 02 Mar 2020 00:43:38 -0800
From:   Dilip Kota <eswara.kota@linux.intel.com>
To:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Cc:     kishon@ti.com, robh@kernel.org, andriy.shevchenko@intel.com,
        cheol.yong.kim@intel.com, chuanhua.lei@linux.intel.com,
        qi-ming.wu@intel.com, yixin.zhu@intel.com,
        Dilip Kota <eswara.kota@linux.intel.com>
Subject: [PATCH v4 1/3] mfd: syscon: Add fwnode_to_regmap
Date:   Mon,  2 Mar 2020 16:43:23 +0800
Message-Id: <9953bb25281397553cb87b09d641c968d8432dd9.1583127977.git.eswara.kota@linux.intel.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <cover.1583127977.git.eswara.kota@linux.intel.com>
References: <cover.1583127977.git.eswara.kota@linux.intel.com>
In-Reply-To: <cover.1583127977.git.eswara.kota@linux.intel.com>
References: <cover.1583127977.git.eswara.kota@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Traverse regmap handle entry from firmware node handle.

Signed-off-by: Dilip Kota <eswara.kota@linux.intel.com>
---
Changes on v4:
  No changes

 drivers/mfd/syscon.c       | 8 ++++++++
 include/linux/mfd/syscon.h | 6 ++++++
 2 files changed, 14 insertions(+)

diff --git a/drivers/mfd/syscon.c b/drivers/mfd/syscon.c
index e22197c832e8..08064ffc5394 100644
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
index 112dc66262cc..a024dd88bdd4 100644
--- a/include/linux/mfd/syscon.h
+++ b/include/linux/mfd/syscon.h
@@ -18,6 +18,7 @@ struct device_node;
 
 #ifdef CONFIG_MFD_SYSCON
 extern struct regmap *device_node_to_regmap(struct device_node *np);
+extern struct regmap *fwnode_to_regmap(struct fwnode_handle *fwnode);
 extern struct regmap *syscon_node_to_regmap(struct device_node *np);
 extern struct regmap *syscon_regmap_lookup_by_compatible(const char *s);
 extern struct regmap *syscon_regmap_lookup_by_phandle(
@@ -29,6 +30,11 @@ static inline struct regmap *device_node_to_regmap(struct device_node *np)
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

