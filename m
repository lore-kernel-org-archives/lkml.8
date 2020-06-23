Return-Path: <SRS0=AM+j=AE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55367C433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 02:52:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3255D2076A
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 02:52:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732110AbgFWCwA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Jun 2020 22:52:00 -0400
Received: from mx2.suse.de ([195.135.220.15]:33028 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731913AbgFWCvi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Jun 2020 22:51:38 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 99FBDB198;
        Tue, 23 Jun 2020 02:51:36 +0000 (UTC)
From:   =?UTF-8?q?Andreas=20F=C3=A4rber?= <afaerber@suse.de>
To:     linux-realtek-soc@lists.infradead.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        =?UTF-8?q?James=20Tai=20=5B=E6=88=B4=E5=BF=97=E5=B3=B0=5D?= 
        <james.tai@realtek.com>,
        =?UTF-8?q?Stanley=20Chang=20=5B=E6=98=8C=E8=82=B2=E5=BE=B7=5D?= 
        <stanley_chang@realtek.com>, Edgar Lee <cylee12@realtek.com>,
        =?UTF-8?q?Andreas=20F=C3=A4rber?= <afaerber@suse.de>
Subject: [PATCH v2 16/29] soc: realtek: chip: Detect RTD1392
Date:   Tue, 23 Jun 2020 04:50:53 +0200
Message-Id: <20200623025106.31273-17-afaerber@suse.de>
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

From: Stanley Chang <stanley_chang@realtek.com>

Distinguish RTD1392 from RTD1395 via ISO_CHIP_INFO1 register.

Signed-off-by: Stanley Chang <stanley_chang@realtek.com>
Signed-off-by: Andreas Färber <afaerber@suse.de>
---
 TODO: Name the bit in ISO_CHIP_INFO1:bound_opts.
 
 Note: We don't have any RTD1392 .dtsi/.dts yet.
 
 v2: New
 * Split out from Stanley's v1
 
 drivers/soc/realtek/chip.c | 25 ++++++++++++++++++++++++-
 1 file changed, 24 insertions(+), 1 deletion(-)

diff --git a/drivers/soc/realtek/chip.c b/drivers/soc/realtek/chip.c
index 6b3d1f3d3816..9cee760bac35 100644
--- a/drivers/soc/realtek/chip.c
+++ b/drivers/soc/realtek/chip.c
@@ -107,10 +107,33 @@ static const char *rtd1295_name(struct device *dev, const struct dhc_soc *s)
 	return "RTD1295";
 }
 
+static const char *rtd1395_name(struct device *dev, const struct dhc_soc *s)
+{
+	struct regmap *regmap;
+	unsigned int val;
+	int ret;
+
+	regmap = syscon_regmap_lookup_by_phandle(dev->of_node, "iso-syscon");
+	if (IS_ERR(regmap)) {
+		ret = PTR_ERR(regmap);
+		if (ret == -EPROBE_DEFER)
+			return ERR_PTR(ret);
+		dev_warn(dev, "Could not check iso (%d)\n", ret);
+	} else {
+		ret = regmap_read(regmap, REG_ISO_CHIP_INFO1, &val);
+		if (ret)
+			dev_warn(dev, "Could not read chip_info1 (%d)\n", ret);
+		else if (val & BIT(12))
+			return "RTD1392";
+	}
+
+	return "RTD1395";
+}
+
 static const struct dhc_soc dhc_soc_families[] = {
 	{ 0x6329, "RTD1195", default_name, rtd1195_revisions, "Phoenix" },
 	{ 0x6421, "RTD1295", rtd1295_name, rtd1295_revisions, "Kylin" },
-	{ 0x6481, "RTD1395", default_name, rtd1395_revisions, "Hercules" },
+	{ 0x6481, "RTD1395", rtd1395_name, rtd1395_revisions, "Hercules" },
 	{ 0x6525, "RTD1619", default_name, rtd1619_revisions, "Thor" },
 	{ 0x6570, "RTD1319", default_name, rtd1319_revisions, "Hank" },
 };
-- 
2.26.2

