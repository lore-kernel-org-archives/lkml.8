Return-Path: <SRS0=g5yc=BI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 184E9C433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Jul 2020 05:13:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E74072074B
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Jul 2020 05:13:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mail.ustc.edu.cn header.i=@mail.ustc.edu.cn header.b="ukkJp7kh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726925AbgG2FN5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Jul 2020 01:13:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726858AbgG2FNt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jul 2020 01:13:49 -0400
Received: from ustc.edu.cn (email6.ustc.edu.cn [IPv6:2001:da8:d800::8])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id ACBC9C061794;
        Tue, 28 Jul 2020 22:13:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mail.ustc.edu.cn; s=dkim; h=Received:Date:From:To:Cc:Subject:
        Message-ID:In-Reply-To:References:MIME-Version:Content-Type:
        Content-Transfer-Encoding; bh=jAv8lo/WfEsqTqAa0m0SsJRnXcZlvGrQwY
        GdjFjZMrc=; b=ukkJp7khjmVwSEmouMg3q195Uy2DFTY2cLSLjU1l6ZRnBz94Gb
        KDepwfDjHAM/Jr6cS9FDi1C2kLtl/+asxphy1o4TyPaLduwFe4jnCfJTJ/FP/gEd
        omfsQd+CnqFrVXrr1ncB8/BT0k8JVDPv4MZDyeMVbmMdvU+nlQfQWjtl4=
Received: from xhacker (unknown [101.86.17.135])
        by newmailweb.ustc.edu.cn (Coremail) with SMTP id LkAmygCXjUCFBSFfwOg9AA--.30602S5;
        Wed, 29 Jul 2020 13:13:47 +0800 (CST)
Date:   Wed, 29 Jul 2020 13:09:13 +0800
From:   Jisheng Zhang <jszhang3@mail.ustc.edu.cn>
To:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Saravanan Sekar <sravanhome@gmail.com>
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: [PATCH v2 1/4] regulator: mp886x: implement set_ramp_delay
Message-ID: <20200729130913.3ac38b32@xhacker>
In-Reply-To: <20200729130839.10a9bf88@xhacker>
References: <20200729130839.10a9bf88@xhacker>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-CM-TRANSID: LkAmygCXjUCFBSFfwOg9AA--.30602S5
X-Coremail-Antispam: 1UD129KBjvJXoWxCF4rJFWfWr4xJr45ZFykAFb_yoWrGr13pF
        15XFn8Jr40qF1xWF4FkF92k3W3Kr4xKwn7Ary7C3yakanxtFy3XF18XryayF1fJryrJF1j
        yayjkw4ku3WUXrJanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUU9jb7Iv0xC_tr1lb4IE77IF4wAFF20E14v26rWj6s0DM7CY07I2
        0VC2zVCF04k26cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28IrcIa0xkI8VA2jI
        8067AKxVWUWwA2048vs2IY020Ec7CjxVAFwI0_Gr0_Xr1l8cAvFVAK0II2c7xJM28CjxkF
        64kEwVA0rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVW8JVW5JwA2z4x0Y4vE2Ix0cI8IcV
        CY1x0267AKxVW8JVWxJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY
        1x0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4
        xG6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCa
        FVCjc4AY6r1j6r4UM4x0Y48IcVAKI48JMxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4
        AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE
        17CEb7AF67AKxVWUAVWUtwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMI
        IF0xvE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4l
        IxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvf
        C2KfnxnUUI43ZEXa7IU00385UUUUU==
X-CM-SenderInfo: xmv2xttqjtqzxdloh3xvwfhvlgxou0/
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jisheng Zhang <Jisheng.Zhang@synaptics.com>

Implement the .set_ramp_delay for MP8867 and MP8869. MP8867 and MP8869
could share the implementation, the only difference is the slew_rates
array.

Signed-off-by: Jisheng Zhang <Jisheng.Zhang@synaptics.com>
---
 drivers/regulator/mp886x.c | 67 ++++++++++++++++++++++++++++++++++++--
 1 file changed, 64 insertions(+), 3 deletions(-)

diff --git a/drivers/regulator/mp886x.c b/drivers/regulator/mp886x.c
index 1786f7162019..3c9a6605b115 100644
--- a/drivers/regulator/mp886x.c
+++ b/drivers/regulator/mp886x.c
@@ -18,18 +18,48 @@
 #define  MP886X_V_BOOT		(1 << 7)
 #define MP886X_SYSCNTLREG1	0x01
 #define  MP886X_MODE		(1 << 0)
+#define  MP886X_SLEW_SHIFT	3
+#define  MP886X_SLEW_MASK	(0x7 << MP886X_SLEW_SHIFT)
 #define  MP886X_GO		(1 << 6)
 #define  MP886X_EN		(1 << 7)
 
+struct mp886x_cfg_info {
+	const struct regulator_ops *rops;
+	const int slew_rates[8];
+};
+
 struct mp886x_device_info {
 	struct device *dev;
 	struct regulator_desc desc;
 	struct regulator_init_data *regulator;
 	struct gpio_desc *en_gpio;
+	const struct mp886x_cfg_info *ci;
 	u32 r[2];
 	unsigned int sel;
 };
 
+static int mp886x_set_ramp(struct regulator_dev *rdev, int ramp)
+{
+	struct mp886x_device_info *di = rdev_get_drvdata(rdev);
+	const struct mp886x_cfg_info *ci = di->ci;
+	int reg = -1, i;
+
+	for (i = 0; i < ARRAY_SIZE(ci->slew_rates); i++) {
+		if (ramp <= ci->slew_rates[i])
+			reg = i;
+		else
+			break;
+	}
+
+	if (reg < 0) {
+		dev_err(di->dev, "unsupported ramp value %d\n", ramp);
+		return -EINVAL;
+	}
+
+	return regmap_update_bits(rdev->regmap, MP886X_SYSCNTLREG1,
+				  MP886X_SLEW_MASK, reg << MP886X_SLEW_SHIFT);
+}
+
 static int mp886x_set_mode(struct regulator_dev *rdev, unsigned int mode)
 {
 	switch (mode) {
@@ -117,6 +147,21 @@ static const struct regulator_ops mp8869_regulator_ops = {
 	.is_enabled = regulator_is_enabled_regmap,
 	.set_mode = mp886x_set_mode,
 	.get_mode = mp886x_get_mode,
+	.set_ramp_delay = mp886x_set_ramp,
+};
+
+static const struct mp886x_cfg_info mp8869_ci = {
+	.rops = &mp8869_regulator_ops,
+	.slew_rates = {
+		40000,
+		30000,
+		20000,
+		10000,
+		5000,
+		2500,
+		1250,
+		625,
+	},
 };
 
 static int mp8867_set_voltage_sel(struct regulator_dev *rdev, unsigned int sel)
@@ -173,6 +218,21 @@ static const struct regulator_ops mp8867_regulator_ops = {
 	.is_enabled = regulator_is_enabled_regmap,
 	.set_mode = mp886x_set_mode,
 	.get_mode = mp886x_get_mode,
+	.set_ramp_delay = mp886x_set_ramp,
+};
+
+static const struct mp886x_cfg_info mp8867_ci = {
+	.rops = &mp8867_regulator_ops,
+	.slew_rates = {
+		64000,
+		32000,
+		16000,
+		8000,
+		4000,
+		2000,
+		1000,
+		500,
+	},
 };
 
 static int mp886x_regulator_register(struct mp886x_device_info *di,
@@ -183,7 +243,7 @@ static int mp886x_regulator_register(struct mp886x_device_info *di,
 
 	rdesc->name = "mp886x-reg";
 	rdesc->supply_name = "vin";
-	rdesc->ops = of_device_get_match_data(di->dev);
+	rdesc->ops = di->ci->rops;
 	rdesc->type = REGULATOR_VOLTAGE;
 	rdesc->n_voltages = 128;
 	rdesc->enable_reg = MP886X_SYSCNTLREG1;
@@ -235,6 +295,7 @@ static int mp886x_i2c_probe(struct i2c_client *client,
 	if (IS_ERR(di->en_gpio))
 		return PTR_ERR(di->en_gpio);
 
+	di->ci = of_device_get_match_data(dev);
 	di->dev = dev;
 
 	regmap = devm_regmap_init_i2c(client, &mp886x_regmap_config);
@@ -259,11 +320,11 @@ static int mp886x_i2c_probe(struct i2c_client *client,
 static const struct of_device_id mp886x_dt_ids[] = {
 	{
 		.compatible = "mps,mp8867",
-		.data = &mp8867_regulator_ops
+		.data = &mp8867_ci
 	},
 	{
 		.compatible = "mps,mp8869",
-		.data = &mp8869_regulator_ops
+		.data = &mp8869_ci
 	},
 	{ }
 };
-- 
2.28.0.rc1


