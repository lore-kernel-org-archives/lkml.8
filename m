Return-Path: <SRS0=rw9U=6H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42E4FC2BA19
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Apr 2020 08:59:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1BF1721569
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Apr 2020 08:59:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XTtfzJ2q"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726641AbgDWI7C (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Apr 2020 04:59:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725854AbgDWI7B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Apr 2020 04:59:01 -0400
Received: from mail-pl1-x642.google.com (mail-pl1-x642.google.com [IPv6:2607:f8b0:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D7DBC03C1AF
        for <linux-kernel@vger.kernel.org>; Thu, 23 Apr 2020 01:59:00 -0700 (PDT)
Received: by mail-pl1-x642.google.com with SMTP id t4so2091916plq.12
        for <linux-kernel@vger.kernel.org>; Thu, 23 Apr 2020 01:59:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=IcCNtnQvqrlY48W2Rk0zhXrP15vTB4xg2ueMGNg++bg=;
        b=XTtfzJ2qBFmEwaKJFc82fZ3zQhl/skwswoIoFCKOjoOAFWYbKtpVrjY+7dsvqrasvs
         N9lS4MJfkXyVCUHrg0ydmJ4vEsXXd3gqk9njpklLcRisxb4OBlHfmbk51XRdC4sJ7k58
         eHN0PdDrrkFoVWru+X+UYKkyqXGmXZbsgQE2vr3go17JW50QydzjdFlJfUzVyMJLqeBO
         n2PpskbSgxQOescxzTkT+ACWJgTy/PcJcK/B6BYLs3R4Z0EZf5A9+7glsbt6A4+atTSC
         pMjqct4E890GrV/nK1cckgdHaSkq7B0VU+bRkYHAvNVKKHwRpgDRKdoMl5+/+nAoNY6h
         5pXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:subject:date:message-id
         :mime-version:content-transfer-encoding;
        bh=IcCNtnQvqrlY48W2Rk0zhXrP15vTB4xg2ueMGNg++bg=;
        b=YaD7Z4hgB+P0hoc8YB522FuswyaQNpX+pNk19P8LjpsKI6N2iPyWDq6ouArtRS8U+y
         AkncpUHMherVNWF0CmeWq8BzWxS1WUiwWstZFO2eLZX3aJ9TIQVDsIoaI8bzAQkSro87
         v9iThabW/IjNHPxdrZq8EqxzXJ/KL4jNHTWiSBupO23mrRs4ZoQ2JmlV9qAfh7xe+xwk
         OHSQ3O9mFJHglnHmdSzuDWSH57EfB0Ae+H2FbdwSuJTjJI/6awfBxO8v3JBrJVZfx8Hp
         WPlvWLlsZz7PX9ISRRHB6+gETMY5UQDuKTV+adZpJCv5ftMKEawoJdHn/REzS1ZuLxIe
         fM+Q==
X-Gm-Message-State: AGi0Pub+MyPXUc9q96KSTIdMj3eMIJB+4GPu4csqR3kvC9g/yPEhwjuk
        KB7fKXLqAjMO9P8C/JQFFGI=
X-Google-Smtp-Source: APiQypJL4bpIBnLX/jcv9UwA/qf5vjQuQA20Q6+9B6E5ltpnq4GGMm9Nv33nxd1zXGm0D7ZLtT2dlA==
X-Received: by 2002:a17:902:bd87:: with SMTP id q7mr2831361pls.92.1587632339798;
        Thu, 23 Apr 2020 01:58:59 -0700 (PDT)
Received: from localhost (61-220-137-38.HINET-IP.hinet.net. [61.220.137.38])
        by smtp.gmail.com with ESMTPSA id w11sm1695329pjy.11.2020.04.23.01.58.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Apr 2020 01:58:58 -0700 (PDT)
From:   AceLan Kao <acelan.kao@canonical.com>
To:     Mark Brown <broonie@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Aaron Sierra <asierra@xes-inc.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] regmap-i2c: add 16 bits register width support
Date:   Thu, 23 Apr 2020 16:58:57 +0800
Message-Id: <20200423085857.93684-1-acelan.kao@canonical.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This allows to access data with 16 bits register width
via i2c smbus block functions.

The implementation is inspired by below commit
https://patchwork.ozlabs.org/patch/545292/

Signed-off-by: AceLan Kao <acelan.kao@canonical.com>
---
 drivers/base/regmap/regmap-i2c.c | 61 ++++++++++++++++++++++++++++++++
 1 file changed, 61 insertions(+)

diff --git a/drivers/base/regmap/regmap-i2c.c b/drivers/base/regmap/regmap-i2c.c
index 008f8da69d97..62b95a9212ae 100644
--- a/drivers/base/regmap/regmap-i2c.c
+++ b/drivers/base/regmap/regmap-i2c.c
@@ -246,6 +246,63 @@ static const struct regmap_bus regmap_i2c_smbus_i2c_block = {
 	.max_raw_write = I2C_SMBUS_BLOCK_MAX,
 };
 
+static int regmap_i2c_smbus_i2c_write_reg16(void *context, const void *data,
+				      size_t count)
+{
+	struct device *dev = context;
+	struct i2c_client *i2c = to_i2c_client(dev);
+
+	if (count < 2)
+		return -EINVAL;
+
+	count--;
+	return i2c_smbus_write_i2c_block_data(i2c, ((u8 *)data)[0], count,
+					      (u8 *)data + 1);
+}
+
+static int regmap_i2c_smbus_i2c_read_reg16(void *context, const void *reg,
+				     size_t reg_size, void *val,
+				     size_t val_size)
+{
+	struct device *dev = context;
+	struct i2c_client *i2c = to_i2c_client(dev);
+	int ret, count, len = val_size;
+
+	if (reg_size != 2)
+		return -EINVAL;
+
+	ret = i2c_smbus_write_byte_data(i2c, ((u16 *)reg)[0] & 0xff,
+					((u16 *)reg)[0] >> 8);
+	if (ret < 0)
+		return ret;
+
+	count = 0;
+	do {
+		/* Current Address Read */
+		ret = i2c_smbus_read_byte(i2c);
+		if (ret < 0)
+			break;
+
+		*((u8 *)val++) = ret;
+		count++;
+		len--;
+	} while (len > 0);
+
+	if (count == val_size)
+		return 0;
+	else if (ret < 0)
+		return ret;
+	else
+		return -EIO;
+}
+
+static const struct regmap_bus regmap_i2c_smbus_i2c_block_reg16 = {
+	.write = regmap_i2c_smbus_i2c_write_reg16,
+	.read = regmap_i2c_smbus_i2c_read_reg16,
+	.max_raw_read = I2C_SMBUS_BLOCK_MAX,
+	.max_raw_write = I2C_SMBUS_BLOCK_MAX,
+};
+
 static const struct regmap_bus *regmap_get_i2c_bus(struct i2c_client *i2c,
 					const struct regmap_config *config)
 {
@@ -255,6 +312,10 @@ static const struct regmap_bus *regmap_get_i2c_bus(struct i2c_client *i2c,
 		 i2c_check_functionality(i2c->adapter,
 					 I2C_FUNC_SMBUS_I2C_BLOCK))
 		return &regmap_i2c_smbus_i2c_block;
+	else if (config->val_bits == 8 && config->reg_bits == 16 &&
+		i2c_check_functionality(i2c->adapter,
+					I2C_FUNC_SMBUS_I2C_BLOCK))
+		return &regmap_i2c_smbus_i2c_block_reg16;
 	else if (config->val_bits == 16 && config->reg_bits == 8 &&
 		 i2c_check_functionality(i2c->adapter,
 					 I2C_FUNC_SMBUS_WORD_DATA))
-- 
2.25.1

