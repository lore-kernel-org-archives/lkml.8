Return-Path: <SRS0=AM+j=AE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84B4AC433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 02:52:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6E901207BC
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 02:52:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732312AbgFWCwu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Jun 2020 22:52:50 -0400
Received: from mx2.suse.de ([195.135.220.15]:33226 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731974AbgFWCvn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Jun 2020 22:51:43 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id C812DB1A5;
        Tue, 23 Jun 2020 02:51:41 +0000 (UTC)
From:   =?UTF-8?q?Andreas=20F=C3=A4rber?= <afaerber@suse.de>
To:     linux-realtek-soc@lists.infradead.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        =?UTF-8?q?James=20Tai=20=5B=E6=88=B4=E5=BF=97=E5=B3=B0=5D?= 
        <james.tai@realtek.com>,
        =?UTF-8?q?Stanley=20Chang=20=5B=E6=98=8C=E8=82=B2=E5=BE=B7=5D?= 
        <stanley_chang@realtek.com>, Edgar Lee <cylee12@realtek.com>,
        =?UTF-8?q?Andreas=20F=C3=A4rber?= <afaerber@suse.de>
Subject: [PATCH v2 26/29] soc: realtek: chip: Detect RTD1294
Date:   Tue, 23 Jun 2020 04:51:03 +0200
Message-Id: <20200623025106.31273-27-afaerber@suse.de>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200623025106.31273-1-afaerber@suse.de>
References: <20200623025106.31273-1-afaerber@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Detection logic from downstream include/soc/realtek/rtd129x_cpu.h.

Signed-off-by: Andreas Färber <afaerber@suse.de>
---
 Note: We don't have any RTD1294 .dtsi/.dts yet.
 
 v1 -> v2:
 * Instead of direct eFuse register access use nvmem cell API
 * Warn on errors other than deferred probing
 
 drivers/soc/realtek/chip.c | 39 ++++++++++++++++++++++++++++++++++++++
 1 file changed, 39 insertions(+)

diff --git a/drivers/soc/realtek/chip.c b/drivers/soc/realtek/chip.c
index 9cee760bac35..bed028ce1b16 100644
--- a/drivers/soc/realtek/chip.c
+++ b/drivers/soc/realtek/chip.c
@@ -10,6 +10,7 @@
 #include <linux/io.h>
 #include <linux/mfd/syscon.h>
 #include <linux/module.h>
+#include <linux/nvmem-consumer.h>
 #include <linux/of.h>
 #include <linux/of_address.h>
 #include <linux/platform_device.h>
@@ -26,6 +27,8 @@
 
 #define REG_ISO_CHIP_INFO1	0x028
 
+#define REG_EFUSE_PACKAGE_ID	0x1d8
+
 struct dhc_soc_revision {
 	const char *name;
 	u16 chip_rev;
@@ -76,6 +79,33 @@ struct dhc_soc {
 	const char *codename;
 };
 
+static int dhc_efuse_read_u8(struct device *dev, const char *cell_id, u8 *val)
+{
+	struct nvmem_cell *cell;
+	void *buf;
+	size_t len;
+
+	cell = nvmem_cell_get(dev, cell_id);
+	if (IS_ERR(cell))
+		return PTR_ERR(cell);
+
+	buf = nvmem_cell_read(cell, &len);
+	if (IS_ERR(buf)) {
+		nvmem_cell_put(cell);
+		return PTR_ERR(buf);
+	}
+	if (len != sizeof(*val)) {
+		kfree(buf);
+		nvmem_cell_put(cell);
+		return -EINVAL;
+	}
+	memcpy(val, buf, 1);
+	kfree(buf);
+	nvmem_cell_put(cell);
+
+	return 0;
+}
+
 static const char *default_name(struct device *dev, const struct dhc_soc *s)
 {
 	return s->family;
@@ -86,6 +116,15 @@ static const char *rtd1295_name(struct device *dev, const struct dhc_soc *s)
 	struct regmap *regmap;
 	unsigned int val;
 	int ret;
+	u8 b;
+
+	ret = dhc_efuse_read_u8(dev, "efuse_package_id", &b);
+	if (ret == -EPROBE_DEFER)
+		return ERR_PTR(ret);
+	else if (ret)
+		dev_warn(dev, "Could not read efuse package_id (%d)\n", ret);
+	else if (b == 0x1)
+		return "RTD1294";
 
 	regmap = syscon_regmap_lookup_by_phandle(dev->of_node, "iso-syscon");
 	if (IS_ERR(regmap)) {
-- 
2.26.2

