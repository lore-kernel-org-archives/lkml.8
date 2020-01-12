Return-Path: <SRS0=/A4t=3B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1108C33CA7
	for <linux-kernel@archiver.kernel.org>; Sun, 12 Jan 2020 01:55:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9D3B12084D
	for <linux-kernel@archiver.kernel.org>; Sun, 12 Jan 2020 01:55:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731930AbgALBzT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 11 Jan 2020 20:55:19 -0500
Received: from foss.arm.com ([217.140.110.172]:57774 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731897AbgALBzT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Jan 2020 20:55:19 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 98235328;
        Sat, 11 Jan 2020 17:55:18 -0800 (PST)
Received: from DESKTOP-VLO843J.lan (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id B605A3F6C4;
        Sat, 11 Jan 2020 17:55:17 -0800 (PST)
From:   Robin Murphy <robin.murphy@arm.com>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org, heiko@sntech.de,
        linux-rockchip@lists.infradead.org, smoch@web.de
Subject: [PATCH v2 1/5] mfd: rk808: Always use poweroff when requested
Date:   Sun, 12 Jan 2020 01:55:00 +0000
Message-Id: <233bf172a5310658d703b11be6e637d6c4d46338.1578789410.git.robin.murphy@arm.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <cover.1578789410.git.robin.murphy@arm.com>
References: <cover.1578789410.git.robin.murphy@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Soeren Moch <smoch@web.de>

With the device tree property "rockchip,system-power-controller" we
explicitly request to use this PMIC to power off the system. So always
register our poweroff function, even if some other handler (probably
PSCI poweroff) was registered before.

This does tend to reveal a warning on shutdown due to the Rockchip I2C
driver not implementing an atomic transfer method, however since the
write to DEV_OFF takes effect immediately the I2C completion interrupt
is moot anyway, and as the very last thing written to the console it is
only visible to users going out of their way to capture serial output.

Signed-off-by: Soeren Moch <smoch@web.de>
Reviewed-by: Heiko Stuebner <heiko@sntech.de>
[ rm: note potential warning in commit message ]
Signed-off-by: Robin Murphy <robin.murphy@arm.com>
---
 drivers/mfd/rk808.c | 11 ++---------
 1 file changed, 2 insertions(+), 9 deletions(-)

diff --git a/drivers/mfd/rk808.c b/drivers/mfd/rk808.c
index a69a6742ecdc..616e44e7ef98 100644
--- a/drivers/mfd/rk808.c
+++ b/drivers/mfd/rk808.c
@@ -550,7 +550,7 @@ static int rk808_probe(struct i2c_client *client,
 	const struct mfd_cell *cells;
 	int nr_pre_init_regs;
 	int nr_cells;
-	int pm_off = 0, msb, lsb;
+	int msb, lsb;
 	unsigned char pmic_id_msb, pmic_id_lsb;
 	int ret;
 	int i;
@@ -674,16 +674,9 @@ static int rk808_probe(struct i2c_client *client,
 		goto err_irq;
 	}
 
-	pm_off = of_property_read_bool(np,
-				"rockchip,system-power-controller");
-	if (pm_off && !pm_power_off) {
+	if (of_property_read_bool(np, "rockchip,system-power-controller")) {
 		rk808_i2c_client = client;
 		pm_power_off = rk808->pm_pwroff_fn;
-	}
-
-	if (pm_off && !pm_power_off_prepare) {
-		if (!rk808_i2c_client)
-			rk808_i2c_client = client;
 		pm_power_off_prepare = rk808->pm_pwroff_prep_fn;
 	}
 
-- 
2.17.1

