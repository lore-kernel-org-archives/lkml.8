Return-Path: <SRS0=CUu6=46=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BBDE2C5ACBF
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Mar 2020 14:49:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9D01B20409
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Mar 2020 14:49:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726795AbgCMOtf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Mar 2020 10:49:35 -0400
Received: from smtp2.ustc.edu.cn ([202.38.64.46]:58941 "EHLO ustc.edu.cn"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726591AbgCMOtf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Mar 2020 10:49:35 -0400
Received: from xhacker (unknown [101.86.20.80])
        by newmailweb.ustc.edu.cn (Coremail) with SMTP id LkAmygDn7ZF7nWteRsk8AA--.11228S2;
        Fri, 13 Mar 2020 22:49:31 +0800 (CST)
Date:   Fri, 13 Mar 2020 22:47:39 +0800
From:   Jisheng Zhang <jszhang3@mail.ustc.edu.cn>
To:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: [PATCH 4/4] regulator: mp886x: add MP8867 support
Message-ID: <20200313224739.17b5ed70@xhacker>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-CM-TRANSID: LkAmygDn7ZF7nWteRsk8AA--.11228S2
X-Coremail-Antispam: 1UD129KBjvJXoWxWry5Wr1rWFyUGryDuw1DAwb_yoW5Aw1DpF
        W5WrsIkrWkXa4xGF4xCFya93Wa9wn7t3s7ZryIkw4ay3ZxJF4fXFn7ZFySvFyrCrWkJF1j
        yayUCry09F4UJrJanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUyFb7Iv0xC_Cr1lb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I2
        0VC2zVCF04k26cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rw
        A2F7IY1VAKz4vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xII
        jxv20xvEc7CjxVAFwI0_Cr0_Gr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I
        8E87Iv6xkF7I0E14v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI
        64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r126r1DMcIj6I8E87Iv67AKxVWUJVW8Jw
        Am72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41l42xK82IYc2Ij64vIr41l4I8I3I0E
        4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGV
        WUWwC2zVAF1VAY17CE14v26r126r1DMIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_
        Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rV
        W3JVWrJr1lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8
        JrUvcSsGvfC2KfnxnUUI43ZEXa7IU8TCJPUUUUU==
X-CM-SenderInfo: xmv2xttqjtqzxdloh3xvwfhvlgxou0/
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jisheng Zhang <Jisheng.Zhang@synaptics.com>

MP8867 is an I2C-controlled adjustable voltage regulator made by
Monolithic Power Systems. The difference between MP8867 and MP8869
are:
1.If V_BOOT, the vref of MP8869 is fixed at 600mv while vref of
MP8867 is determined by the I2C control.
2.For MP8867, when setting voltage, if the steps is within 5, we
need to manually set the GO BIT to 0.

Signed-off-by: Jisheng Zhang <Jisheng.Zhang@synaptics.com>
---
 drivers/regulator/mp886x.c | 62 +++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 61 insertions(+), 1 deletion(-)

diff --git a/drivers/regulator/mp886x.c b/drivers/regulator/mp886x.c
index 2f0f54b..721f982 100644
--- a/drivers/regulator/mp886x.c
+++ b/drivers/regulator/mp886x.c
@@ -1,6 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0
 //
-// MP8869 regulator driver
+// MP8867/MP8869 regulator driver
 //
 // Copyright (C) 2020 Synaptics Incorporated
 //
@@ -118,6 +118,62 @@ static const struct regulator_ops mp8869_regulator_ops = {
 	.get_mode = mp886x_get_mode,
 };
 
+static int mp8867_set_voltage_sel(struct regulator_dev *rdev, unsigned sel)
+{
+	struct mp886x_device_info *di = rdev_get_drvdata(rdev);
+	int ret, delta;
+
+	ret = mp8869_set_voltage_sel(rdev, sel);
+	if (ret < 0)
+		return ret;
+
+	delta = di->sel - sel;
+	if (abs(delta) <= 5)
+		ret = regmap_update_bits(rdev->regmap, MP886X_SYSCNTLREG1,
+					 MP886X_GO, 0);
+	di->sel = sel;
+
+	return ret;
+}
+
+static int mp8867_get_voltage_sel(struct regulator_dev *rdev)
+{
+	struct mp886x_device_info *di = rdev_get_drvdata(rdev);
+	int ret, uv;
+	unsigned int val;
+	bool fbloop;
+
+	ret = regmap_read(rdev->regmap, rdev->desc->vsel_reg, &val);
+	if (ret)
+		return ret;
+
+	fbloop = val & MP886X_V_BOOT;
+
+	val &= rdev->desc->vsel_mask;
+	val >>= ffs(rdev->desc->vsel_mask) - 1;
+
+	if (fbloop) {
+		uv = regulator_list_voltage_linear(rdev, val);
+		uv = mp8869_scale(uv, di->r[0], di->r[1]);
+		return regulator_map_voltage_linear(rdev, uv, uv);
+	}
+
+	return val;
+}
+
+static const struct regulator_ops mp8867_regulator_ops = {
+	.set_voltage_sel = mp8867_set_voltage_sel,
+	.get_voltage_sel = mp8867_get_voltage_sel,
+	.set_voltage_time_sel = regulator_set_voltage_time_sel,
+	.map_voltage = regulator_map_voltage_linear,
+	.list_voltage = regulator_list_voltage_linear,
+	.enable = regulator_enable_regmap,
+	.disable = regulator_disable_regmap,
+	.is_enabled = regulator_is_enabled_regmap,
+	.set_mode = mp886x_set_mode,
+	.get_mode = mp886x_get_mode,
+};
+
 static int mp886x_regulator_register(struct mp886x_device_info *di,
 				     struct regulator_config *config)
 {
@@ -201,6 +257,10 @@ static int mp886x_i2c_probe(struct i2c_client *client,
 
 static const struct of_device_id mp886x_dt_ids[] = {
 	{
+		.compatible = "mps,mp8867",
+		.data = &mp8867_regulator_ops
+	},
+	{
 		.compatible = "mps,mp8869",
 		.data = &mp8869_regulator_ops
 	},
-- 
2.7.4


