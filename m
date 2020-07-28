Return-Path: <SRS0=jZ1s=BH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 124B9C43445
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jul 2020 15:37:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E0AED2074F
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jul 2020 15:37:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mail.ustc.edu.cn header.i=@mail.ustc.edu.cn header.b="C5d3mtrX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731017AbgG1Phk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Jul 2020 11:37:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730979AbgG1Ph1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jul 2020 11:37:27 -0400
Received: from ustc.edu.cn (email6.ustc.edu.cn [IPv6:2001:da8:d800::8])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 0841CC0619D4;
        Tue, 28 Jul 2020 08:37:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mail.ustc.edu.cn; s=dkim; h=Received:Date:From:To:Cc:Subject:
        Message-ID:In-Reply-To:References:MIME-Version:Content-Type:
        Content-Transfer-Encoding; bh=h+0pP1uEU51MnCBvLri0WdjAedk8MQ25Uk
        FDBKwheRg=; b=C5d3mtrXz2tvbGAO7LkdNnSNHBmpJYgYB3oRS4wchRG1q/4nEM
        lYFp4IbNSl8vLylt5ynltQGOqArbeFlNzVya2l/eCV77mLQh6M0Ar61zyEpTS8kr
        2jB2GO0VGD4UCzW9L0xIkps6gDxUBI1isq4/IhqKbam0Gcq4YtEmbiJIw=
Received: from xhacker (unknown [101.86.17.135])
        by newmailweb.ustc.edu.cn (Coremail) with SMTP id LkAmygCHj_diRCBfgxI2AA--.17695S6;
        Tue, 28 Jul 2020 23:29:47 +0800 (CST)
Date:   Tue, 28 Jul 2020 23:26:10 +0800
From:   Jisheng Zhang <jszhang3@mail.ustc.edu.cn>
To:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Saravanan Sekar <sravanhome@gmail.com>
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: [PATCH 4/4] regulator: mp886x: support setting switch freq
Message-ID: <20200728232610.10197f23@xhacker>
In-Reply-To: <20200728232327.71ab3729@xhacker>
References: <20200728232327.71ab3729@xhacker>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-CM-TRANSID: LkAmygCHj_diRCBfgxI2AA--.17695S6
X-Coremail-Antispam: 1UD129KBjvJXoWxGF1rArW7Ar1xAw43WrW5trb_yoW5XF4kpw
        45GF4Ykr4kJ3WSgr4fCFn2ka43Kr4kC34fArW2yw4Ska13tFZxJFy8JFy2yF1rGryrJFyY
        y34093yqgw1UJ3DanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUU92b7Iv0xC_tr1lb4IE77IF4wAFF20E14v26rWj6s0DM7CY07I2
        0VC2zVCF04k26cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28IrcIa0xkI8VA2jI
        8067AKxVWUAVCq3wA2048vs2IY020Ec7CjxVAFwI0_Xr0E3s1l8cAvFVAK0II2c7xJM28C
        jxkF64kEwVA0rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVW5JVW7JwA2z4x0Y4vE2Ix0cI
        8IcVCY1x0267AKxVWxJVW8Jr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2
        jsIEc7CjxVAFwI0_GcCE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4
        CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r4UMcvj
        eVCFs4IE7xkEbVWUJVW8JwACjcxG0xvEwIxGrwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4
        IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1r
        MI8E67AF67kF1VAFwI0_JF0_Jw1lIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJV
        WUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6r1j
        6r1xMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYx
        BIdaVFxhVjvjDU0xZFpf9x07j0uWLUUUUU=
X-CM-SenderInfo: xmv2xttqjtqzxdloh3xvwfhvlgxou0/
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jisheng Zhang <Jisheng.Zhang@synaptics.com>

Both MP8867 and MP8869 support different switch frequency.

Signed-off-by: Jisheng Zhang <Jisheng.Zhang@synaptics.com>
---
 drivers/regulator/mp886x.c | 42 ++++++++++++++++++++++++++++++++++++++
 1 file changed, 42 insertions(+)

diff --git a/drivers/regulator/mp886x.c b/drivers/regulator/mp886x.c
index 3c9a6605b115..e3c7813bed4b 100644
--- a/drivers/regulator/mp886x.c
+++ b/drivers/regulator/mp886x.c
@@ -22,10 +22,14 @@
 #define  MP886X_SLEW_MASK	(0x7 << MP886X_SLEW_SHIFT)
 #define  MP886X_GO		(1 << 6)
 #define  MP886X_EN		(1 << 7)
+#define MP8869_SYSCNTLREG2	0x02
 
 struct mp886x_cfg_info {
 	const struct regulator_ops *rops;
 	const int slew_rates[8];
+	const int switch_freq[4];
+	const u8 fs_reg;
+	const u8 fs_shift;
 };
 
 struct mp886x_device_info {
@@ -60,6 +64,24 @@ static int mp886x_set_ramp(struct regulator_dev *rdev, int ramp)
 				  MP886X_SLEW_MASK, reg << MP886X_SLEW_SHIFT);
 }
 
+static void mp886x_set_switch_freq(struct mp886x_device_info *di,
+				   struct regmap *regmap,
+				   u32 freq)
+{
+	const struct mp886x_cfg_info *ci = di->ci;
+	int i;
+
+	for (i = 0; i < ARRAY_SIZE(ci->switch_freq); i++) {
+		if (freq == ci->switch_freq[i]) {
+			regmap_update_bits(regmap, ci->fs_reg,
+				  0x3 << ci->fs_shift, i << ci->fs_shift);
+			return;
+		}
+	}
+
+	dev_err(di->dev, "invalid frequency %d\n", freq);
+}
+
 static int mp886x_set_mode(struct regulator_dev *rdev, unsigned int mode)
 {
 	switch (mode) {
@@ -162,6 +184,14 @@ static const struct mp886x_cfg_info mp8869_ci = {
 		1250,
 		625,
 	},
+	.switch_freq = {
+		500000,
+		750000,
+		1000000,
+		1250000,
+	},
+	.fs_reg = MP8869_SYSCNTLREG2,
+	.fs_shift = 4,
 };
 
 static int mp8867_set_voltage_sel(struct regulator_dev *rdev, unsigned int sel)
@@ -233,6 +263,14 @@ static const struct mp886x_cfg_info mp8867_ci = {
 		1000,
 		500,
 	},
+	.switch_freq = {
+		500000,
+		750000,
+		1000000,
+		1500000,
+	},
+	.fs_reg = MP886X_SYSCNTLREG1,
+	.fs_shift = 1,
 };
 
 static int mp886x_regulator_register(struct mp886x_device_info *di,
@@ -274,6 +312,7 @@ static int mp886x_i2c_probe(struct i2c_client *client,
 	struct mp886x_device_info *di;
 	struct regulator_config config = { };
 	struct regmap *regmap;
+	u32 freq;
 	int ret;
 
 	di = devm_kzalloc(dev, sizeof(struct mp886x_device_info), GFP_KERNEL);
@@ -311,6 +350,9 @@ static int mp886x_i2c_probe(struct i2c_client *client,
 	config.driver_data = di;
 	config.of_node = np;
 
+	if (!of_property_read_u32(np, "mps,switch-frequency", &freq))
+		mp886x_set_switch_freq(di, regmap, freq);
+
 	ret = mp886x_regulator_register(di, &config);
 	if (ret < 0)
 		dev_err(dev, "Failed to register regulator!\n");
-- 
2.28.0.rc0


