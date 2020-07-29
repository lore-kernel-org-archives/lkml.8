Return-Path: <SRS0=g5yc=BI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C41BC433E1
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Jul 2020 05:13:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2924920786
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Jul 2020 05:13:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mail.ustc.edu.cn header.i=@mail.ustc.edu.cn header.b="Dmh2MC5c"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726890AbgG2FNw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Jul 2020 01:13:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726497AbgG2FNv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jul 2020 01:13:51 -0400
Received: from ustc.edu.cn (email6.ustc.edu.cn [IPv6:2001:da8:d800::8])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id DD247C0619D2;
        Tue, 28 Jul 2020 22:13:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mail.ustc.edu.cn; s=dkim; h=Received:Date:From:To:Cc:Subject:
        Message-ID:In-Reply-To:References:MIME-Version:Content-Type:
        Content-Transfer-Encoding; bh=/6sQl2wgWdy/hnKW/9D4YfPt53HkbPtTeo
        xIiIum0I4=; b=Dmh2MC5cihCspUOjw+jsJ3LTeiNtepKZ3l9zK3hQdKDsm+boc1
        5pXa/mVIF2FmC6fXspi5lNIUNEr7bYD49iekgwa3MpRxq//tfG02SsPkLmcDfw94
        w274A2FuBVd52rhvbZU6UZSjwhgxpeQeHgpdp+e/Mhiok2hCw4QIoXr1Y=
Received: from xhacker (unknown [101.86.17.135])
        by newmailweb.ustc.edu.cn (Coremail) with SMTP id LkAmygCXjUCFBSFfwOg9AA--.30602S6;
        Wed, 29 Jul 2020 13:13:48 +0800 (CST)
Date:   Wed, 29 Jul 2020 13:10:23 +0800
From:   Jisheng Zhang <jszhang3@mail.ustc.edu.cn>
To:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Saravanan Sekar <sravanhome@gmail.com>
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: [PATCH v2 3/4] regulator: mp886x: support setting switch freq
Message-ID: <20200729131023.77cc1dd2@xhacker>
In-Reply-To: <20200729130839.10a9bf88@xhacker>
References: <20200729130839.10a9bf88@xhacker>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-CM-TRANSID: LkAmygCXjUCFBSFfwOg9AA--.30602S6
X-Coremail-Antispam: 1UD129KBjvJXoWxGF1rArW7Ar1xAw43WrW5trb_yoW5XF4kpw
        45GF4Ykr4kJ3WSgr4fCFn2ka43Kr4kC34fArW2yw4Ska13tFZxJFy8JFy2yF1rGryrJFyY
        y34093yqgw1UJ3DanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUU9Fb7Iv0xC_tr1lb4IE77IF4wAFF20E14v26rWj6s0DM7CY07I2
        0VC2zVCF04k26cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28IrcIa0xkI8VA2jI
        8067AKxVWUAVCq3wA2048vs2IY020Ec7CjxVAFwI0_Xr0E3s1l8cAvFVAK0II2c7xJM28C
        jxkF64kEwVA0rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVW5JVW7JwA2z4x0Y4vE2Ix0cI
        8IcVCY1x0267AKxVW8JVWxJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280
        aVCY1x0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzV
        Aqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S
        6xCaFVCjc4AY6r1j6r4UM4x0Y48IcVAKI48JMxAIw28IcxkI7VAKI48JMxC20s026xCaFV
        Cjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWl
        x4CE17CEb7AF67AKxVWUAVWUtwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r
        1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwCI42IY6xAIw20EY4v20xvaj40_Jr0_
        JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcS
        sGvfC2KfnxnUUI43ZEXa7IU8V6wtUUUUU==
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
2.28.0.rc1


