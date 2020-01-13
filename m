Return-Path: <SRS0=WByN=3C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76ED3C33CA9
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jan 2020 15:13:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3B9B3214AF
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jan 2020 15:13:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1578928411;
	bh=1YQCX+jOa8VAMJX4j5CHQ1SQoddkYZWvGoaR2TYlBYU=;
	h=From:To:Cc:Subject:In-Reply-To:Date:List-ID:From;
	b=bam+iCh5qGP/vM7maaCpmgR3pFYrQJjqO3411V4XuVZquq83GeC0SZV96qf2Wdj75
	 SzQ54ODjfa55AIx0JSFd96Vvpxc2Y3ylmF/9/v/AqZ83ioQKfun44Ie6b4pYgCZmJm
	 CjeLh1G7WnhNFqLkWajBpok2aismsbPROCzRWGAM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729180AbgAMPNa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Jan 2020 10:13:30 -0500
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:35890 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729152AbgAMPN2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jan 2020 10:13:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=ITN2vt8XAi3o9UOjbymfr98Ys08P5EeJ9lhxyFe5Ij0=; b=xpsPGaf6XKXy
        XqhbPs/VhVdm1190PMDBuqkHtRDuU6kHmxZKzr/fq28PTdkkTlHl/wRMpvSv0fBF4KpdFMju8cj0z
        8XuwDuRbKjynye1lqPOx2oICEh5f6ZIfhe2YwKt0447UB70dge/aV0XiS+sc0xh6dmYDQ8a4KFX1P
        LVGVc=;
Received: from fw-tnat-cam7.arm.com ([217.140.106.55] helo=fitzroy.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <broonie@sirena.org.uk>)
        id 1ir1P8-0003NY-TC; Mon, 13 Jan 2020 15:13:22 +0000
Received: by fitzroy.sirena.org.uk (Postfix, from userid 1000)
        id 98CBCD01965; Mon, 13 Jan 2020 15:13:22 +0000 (GMT)
From:   Mark Brown <broonie@kernel.org>
To:     Axel Lin <axel.lin@ingics.com>
Cc:     Icenowy Zheng <icenowy@aosc.io>,
        Liam Girdwood <lgirdwood@gmail.com>,
        linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Support Opensource <support.opensource@diasemi.com>
Subject: Applied "regulator: Convert i2c drivers to use .probe_new" to the regulator tree
In-Reply-To: <20200109155808.22003-1-axel.lin@ingics.com>
Message-Id: <applied-20200109155808.22003-1-axel.lin@ingics.com>
X-Patchwork-Hint: ignore
Date:   Mon, 13 Jan 2020 15:13:22 +0000 (GMT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   regulator: Convert i2c drivers to use .probe_new

has been applied to the regulator tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git for-5.6

All being well this means that it will be integrated into the linux-next
tree (usually sometime in the next 24 hours) and sent to Linus during
the next merge window (or sooner if it is a bug fix), however if
problems are discovered then the patch may be dropped or reverted.  

You may get further e-mails resulting from automated or manual testing
and review of the tree, please engage with people reporting problems and
send followup patches addressing any issues that are reported if needed.

If any updates are required or you are submitting further changes they
should be sent as incremental updates against current git, existing
patches will not be replaced.

Please add any relevant lists and maintainers to the CCs when replying
to this mail.

Thanks,
Mark

From 77e29598ca3fc20314f1acec35ada9706b3ea16b Mon Sep 17 00:00:00 2001
From: Axel Lin <axel.lin@ingics.com>
Date: Thu, 9 Jan 2020 23:58:08 +0800
Subject: [PATCH] regulator: Convert i2c drivers to use .probe_new

Use the new .probe_new for i2c drivers.
These drivers do not use const struct i2c_device_id * argument, so convert
them to utilise the simplified i2c driver registration.

Signed-off-by: Axel Lin <axel.lin@ingics.com>
Link: https://lore.kernel.org/r/20200109155808.22003-1-axel.lin@ingics.com
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/regulator/da9210-regulator.c   | 5 ++---
 drivers/regulator/da9211-regulator.c   | 5 ++---
 drivers/regulator/isl9305.c            | 5 ++---
 drivers/regulator/lp3971.c             | 5 ++---
 drivers/regulator/ltc3676.c            | 5 ++---
 drivers/regulator/mt6311-regulator.c   | 5 ++---
 drivers/regulator/pv88060-regulator.c  | 5 ++---
 drivers/regulator/pv88090-regulator.c  | 5 ++---
 drivers/regulator/slg51000-regulator.c | 5 ++---
 drivers/regulator/sy8106a-regulator.c  | 5 ++---
 drivers/regulator/sy8824x.c            | 5 ++---
 drivers/regulator/tps65132-regulator.c | 5 ++---
 12 files changed, 24 insertions(+), 36 deletions(-)

diff --git a/drivers/regulator/da9210-regulator.c b/drivers/regulator/da9210-regulator.c
index f9448ed50e05..0cdeb6186529 100644
--- a/drivers/regulator/da9210-regulator.c
+++ b/drivers/regulator/da9210-regulator.c
@@ -131,8 +131,7 @@ static const struct of_device_id da9210_dt_ids[] = {
 };
 MODULE_DEVICE_TABLE(of, da9210_dt_ids);
 
-static int da9210_i2c_probe(struct i2c_client *i2c,
-			    const struct i2c_device_id *id)
+static int da9210_i2c_probe(struct i2c_client *i2c)
 {
 	struct da9210 *chip;
 	struct device *dev = &i2c->dev;
@@ -228,7 +227,7 @@ static struct i2c_driver da9210_regulator_driver = {
 		.name = "da9210",
 		.of_match_table = of_match_ptr(da9210_dt_ids),
 	},
-	.probe = da9210_i2c_probe,
+	.probe_new = da9210_i2c_probe,
 	.id_table = da9210_i2c_id,
 };
 
diff --git a/drivers/regulator/da9211-regulator.c b/drivers/regulator/da9211-regulator.c
index 523dc1b95826..2ea4362ffa5c 100644
--- a/drivers/regulator/da9211-regulator.c
+++ b/drivers/regulator/da9211-regulator.c
@@ -416,8 +416,7 @@ static int da9211_regulator_init(struct da9211 *chip)
 /*
  * I2C driver interface functions
  */
-static int da9211_i2c_probe(struct i2c_client *i2c,
-		const struct i2c_device_id *id)
+static int da9211_i2c_probe(struct i2c_client *i2c)
 {
 	struct da9211 *chip;
 	int error, ret;
@@ -526,7 +525,7 @@ static struct i2c_driver da9211_regulator_driver = {
 		.name = "da9211",
 		.of_match_table = of_match_ptr(da9211_dt_ids),
 	},
-	.probe = da9211_i2c_probe,
+	.probe_new = da9211_i2c_probe,
 	.id_table = da9211_i2c_id,
 };
 
diff --git a/drivers/regulator/isl9305.c b/drivers/regulator/isl9305.c
index 978f5e903cae..cfb765986d0d 100644
--- a/drivers/regulator/isl9305.c
+++ b/drivers/regulator/isl9305.c
@@ -137,8 +137,7 @@ static const struct regmap_config isl9305_regmap = {
 	.cache_type = REGCACHE_RBTREE,
 };
 
-static int isl9305_i2c_probe(struct i2c_client *i2c,
-			     const struct i2c_device_id *id)
+static int isl9305_i2c_probe(struct i2c_client *i2c)
 {
 	struct regulator_config config = { };
 	struct isl9305_pdata *pdata = i2c->dev.platform_data;
@@ -198,7 +197,7 @@ static struct i2c_driver isl9305_regulator_driver = {
 		.name = "isl9305",
 		.of_match_table	= of_match_ptr(isl9305_dt_ids),
 	},
-	.probe = isl9305_i2c_probe,
+	.probe_new = isl9305_i2c_probe,
 	.id_table = isl9305_i2c_id,
 };
 
diff --git a/drivers/regulator/lp3971.c b/drivers/regulator/lp3971.c
index bc96e65ef7c0..8be252f81b09 100644
--- a/drivers/regulator/lp3971.c
+++ b/drivers/regulator/lp3971.c
@@ -400,8 +400,7 @@ static int setup_regulators(struct lp3971 *lp3971,
 	return 0;
 }
 
-static int lp3971_i2c_probe(struct i2c_client *i2c,
-			    const struct i2c_device_id *id)
+static int lp3971_i2c_probe(struct i2c_client *i2c)
 {
 	struct lp3971 *lp3971;
 	struct lp3971_platform_data *pdata = dev_get_platdata(&i2c->dev);
@@ -449,7 +448,7 @@ static struct i2c_driver lp3971_i2c_driver = {
 	.driver = {
 		.name = "LP3971",
 	},
-	.probe    = lp3971_i2c_probe,
+	.probe_new = lp3971_i2c_probe,
 	.id_table = lp3971_i2c_id,
 };
 
diff --git a/drivers/regulator/ltc3676.c b/drivers/regulator/ltc3676.c
index d934540eb8c4..e12e52c69e52 100644
--- a/drivers/regulator/ltc3676.c
+++ b/drivers/regulator/ltc3676.c
@@ -301,8 +301,7 @@ static irqreturn_t ltc3676_isr(int irq, void *dev_id)
 	return IRQ_HANDLED;
 }
 
-static int ltc3676_regulator_probe(struct i2c_client *client,
-				    const struct i2c_device_id *id)
+static int ltc3676_regulator_probe(struct i2c_client *client)
 {
 	struct device *dev = &client->dev;
 	struct regulator_init_data *init_data = dev_get_platdata(dev);
@@ -380,7 +379,7 @@ static struct i2c_driver ltc3676_driver = {
 		.name = DRIVER_NAME,
 		.of_match_table = of_match_ptr(ltc3676_of_match),
 	},
-	.probe = ltc3676_regulator_probe,
+	.probe_new = ltc3676_regulator_probe,
 	.id_table = ltc3676_i2c_id,
 };
 module_i2c_driver(ltc3676_driver);
diff --git a/drivers/regulator/mt6311-regulator.c b/drivers/regulator/mt6311-regulator.c
index af95449d3590..69e6af3cd505 100644
--- a/drivers/regulator/mt6311-regulator.c
+++ b/drivers/regulator/mt6311-regulator.c
@@ -85,8 +85,7 @@ static const struct regulator_desc mt6311_regulators[] = {
 /*
  * I2C driver interface functions
  */
-static int mt6311_i2c_probe(struct i2c_client *i2c,
-		const struct i2c_device_id *id)
+static int mt6311_i2c_probe(struct i2c_client *i2c)
 {
 	struct regulator_config config = { };
 	struct regulator_dev *rdev;
@@ -154,7 +153,7 @@ static struct i2c_driver mt6311_regulator_driver = {
 		.name = "mt6311",
 		.of_match_table = of_match_ptr(mt6311_dt_ids),
 	},
-	.probe = mt6311_i2c_probe,
+	.probe_new = mt6311_i2c_probe,
 	.id_table = mt6311_i2c_id,
 };
 
diff --git a/drivers/regulator/pv88060-regulator.c b/drivers/regulator/pv88060-regulator.c
index 3d3415839ba2..787ced918372 100644
--- a/drivers/regulator/pv88060-regulator.c
+++ b/drivers/regulator/pv88060-regulator.c
@@ -279,8 +279,7 @@ static irqreturn_t pv88060_irq_handler(int irq, void *data)
 /*
  * I2C driver interface functions
  */
-static int pv88060_i2c_probe(struct i2c_client *i2c,
-		const struct i2c_device_id *id)
+static int pv88060_i2c_probe(struct i2c_client *i2c)
 {
 	struct regulator_init_data *init_data = dev_get_platdata(&i2c->dev);
 	struct pv88060 *chip;
@@ -385,7 +384,7 @@ static struct i2c_driver pv88060_regulator_driver = {
 		.name = "pv88060",
 		.of_match_table = of_match_ptr(pv88060_dt_ids),
 	},
-	.probe = pv88060_i2c_probe,
+	.probe_new = pv88060_i2c_probe,
 	.id_table = pv88060_i2c_id,
 };
 
diff --git a/drivers/regulator/pv88090-regulator.c b/drivers/regulator/pv88090-regulator.c
index b1d0d97ae935..784729ec2182 100644
--- a/drivers/regulator/pv88090-regulator.c
+++ b/drivers/regulator/pv88090-regulator.c
@@ -272,8 +272,7 @@ static irqreturn_t pv88090_irq_handler(int irq, void *data)
 /*
  * I2C driver interface functions
  */
-static int pv88090_i2c_probe(struct i2c_client *i2c,
-		const struct i2c_device_id *id)
+static int pv88090_i2c_probe(struct i2c_client *i2c)
 {
 	struct regulator_init_data *init_data = dev_get_platdata(&i2c->dev);
 	struct pv88090 *chip;
@@ -406,7 +405,7 @@ static struct i2c_driver pv88090_regulator_driver = {
 		.name = "pv88090",
 		.of_match_table = of_match_ptr(pv88090_dt_ids),
 	},
-	.probe = pv88090_i2c_probe,
+	.probe_new = pv88090_i2c_probe,
 	.id_table = pv88090_i2c_id,
 };
 
diff --git a/drivers/regulator/slg51000-regulator.c b/drivers/regulator/slg51000-regulator.c
index bf1a3508ebc4..44e4cecbf6de 100644
--- a/drivers/regulator/slg51000-regulator.c
+++ b/drivers/regulator/slg51000-regulator.c
@@ -439,8 +439,7 @@ static void slg51000_clear_fault_log(struct slg51000 *chip)
 		dev_dbg(chip->dev, "Fault log: FLT_POR\n");
 }
 
-static int slg51000_i2c_probe(struct i2c_client *client,
-			      const struct i2c_device_id *id)
+static int slg51000_i2c_probe(struct i2c_client *client)
 {
 	struct device *dev = &client->dev;
 	struct slg51000 *chip;
@@ -509,7 +508,7 @@ static struct i2c_driver slg51000_regulator_driver = {
 	.driver = {
 		.name = "slg51000-regulator",
 	},
-	.probe = slg51000_i2c_probe,
+	.probe_new = slg51000_i2c_probe,
 	.id_table = slg51000_i2c_id,
 };
 
diff --git a/drivers/regulator/sy8106a-regulator.c b/drivers/regulator/sy8106a-regulator.c
index 42e03b2c10a0..2222e739e62b 100644
--- a/drivers/regulator/sy8106a-regulator.c
+++ b/drivers/regulator/sy8106a-regulator.c
@@ -61,8 +61,7 @@ static const struct regulator_desc sy8106a_reg = {
 /*
  * I2C driver interface functions
  */
-static int sy8106a_i2c_probe(struct i2c_client *i2c,
-			    const struct i2c_device_id *id)
+static int sy8106a_i2c_probe(struct i2c_client *i2c)
 {
 	struct device *dev = &i2c->dev;
 	struct regulator_dev *rdev;
@@ -141,7 +140,7 @@ static struct i2c_driver sy8106a_regulator_driver = {
 		.name = "sy8106a",
 		.of_match_table	= of_match_ptr(sy8106a_i2c_of_match),
 	},
-	.probe = sy8106a_i2c_probe,
+	.probe_new = sy8106a_i2c_probe,
 	.id_table = sy8106a_i2c_id,
 };
 
diff --git a/drivers/regulator/sy8824x.c b/drivers/regulator/sy8824x.c
index 92adb4f3ee19..62d243f3b904 100644
--- a/drivers/regulator/sy8824x.c
+++ b/drivers/regulator/sy8824x.c
@@ -112,8 +112,7 @@ static const struct regmap_config sy8824_regmap_config = {
 	.val_bits = 8,
 };
 
-static int sy8824_i2c_probe(struct i2c_client *client,
-			    const struct i2c_device_id *id)
+static int sy8824_i2c_probe(struct i2c_client *client)
 {
 	struct device *dev = &client->dev;
 	struct device_node *np = dev->of_node;
@@ -222,7 +221,7 @@ static struct i2c_driver sy8824_regulator_driver = {
 		.name = "sy8824-regulator",
 		.of_match_table = of_match_ptr(sy8824_dt_ids),
 	},
-	.probe = sy8824_i2c_probe,
+	.probe_new = sy8824_i2c_probe,
 	.id_table = sy8824_id,
 };
 module_i2c_driver(sy8824_regulator_driver);
diff --git a/drivers/regulator/tps65132-regulator.c b/drivers/regulator/tps65132-regulator.c
index 7b0e38f8d627..0edc83089ba2 100644
--- a/drivers/regulator/tps65132-regulator.c
+++ b/drivers/regulator/tps65132-regulator.c
@@ -220,8 +220,7 @@ static const struct regmap_config tps65132_regmap_config = {
 	.wr_table	= &tps65132_no_reg_table,
 };
 
-static int tps65132_probe(struct i2c_client *client,
-			  const struct i2c_device_id *client_id)
+static int tps65132_probe(struct i2c_client *client)
 {
 	struct device *dev = &client->dev;
 	struct tps65132_regulator *tps;
@@ -272,7 +271,7 @@ static struct i2c_driver tps65132_i2c_driver = {
 	.driver = {
 		.name = "tps65132",
 	},
-	.probe = tps65132_probe,
+	.probe_new = tps65132_probe,
 	.id_table = tps65132_id,
 };
 
-- 
2.20.1

