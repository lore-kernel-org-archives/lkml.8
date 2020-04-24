Return-Path: <SRS0=nwpL=6I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A68AC54FD0
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Apr 2020 12:34:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 75CCB20700
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Apr 2020 12:34:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KIDonkH3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727773AbgDXMeD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Apr 2020 08:34:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726915AbgDXMeD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Apr 2020 08:34:03 -0400
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com [IPv6:2607:f8b0:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6097C09B045
        for <linux-kernel@vger.kernel.org>; Fri, 24 Apr 2020 05:34:01 -0700 (PDT)
Received: by mail-pf1-x442.google.com with SMTP id z1so3046798pfn.3
        for <linux-kernel@vger.kernel.org>; Fri, 24 Apr 2020 05:34:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=1Y+Ajhx8oaHnO6WllXnJnLAen9GDrYTuF7t48XuYDJ0=;
        b=KIDonkH3F+3QhSX+544sJxfiFRSK7IsnLOADaPhxGUrVjnLix5UidyTs5JFWUEdpuZ
         UKv7fW04t7z0ZzQrSaCv6cmFpksmHyghMoEVwG0+vV5abJi8sJnqQfsH85qNjqWhw/bm
         AOnEuBLDfQ6AnnIx7SR2oYzTeEiChnlQjrffsfNndUMUoTdPO2bsJrVr9hN1nXE4Xu1b
         yHp354nl2NdxeDIGv75nD05c68o93D/9dAwPbIXP80b3/au+CAgSIf/cSaVah8D680Ct
         LEI6n19GSHYNVE8uCUcFz+UiCLQ+nzm28nA+a1qbVLe5Bju4+a14M+b4EbM0w2FEexXC
         ebpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:subject:date:message-id
         :mime-version:content-transfer-encoding;
        bh=1Y+Ajhx8oaHnO6WllXnJnLAen9GDrYTuF7t48XuYDJ0=;
        b=NmZq/eoTJI86V6QPYZGDDkYpiNKwiwCBPBZnnKEy7Gt5Mls31FpPwf1xYgVDsE9fZb
         AYbjG3LEKN/eRx1fgUEtWWkvRlWkfaCKtyFHBbmDp5gYXyPbhUqZv3cawNSdrym4vvRZ
         egD9YG0WVs0pViuw5m7xbS8oZZoVMDHDCHkX0ejcRLh1DWBm8f7AKmtzTD6IBAlRrOcP
         jB4aPxttSC59Dn8vn9VToKry+5vf/714eAKEIu1rBvHgoQ3ilyfc5OSi0CyXy3C+ZMjL
         gxiW0X2iGxcTCqbii5idlzX68eRmZfYPjjodqLbcYJouvcDsxtVmbMJEW/fwC9sbjVKO
         G4Jg==
X-Gm-Message-State: AGi0PuZaBWrNd1X+vKEJabGd8FoVbJWvkVMN30We9x+exdsK0fgk9vIq
        3xxQAzUZRx5RBD4XKqPfekQ=
X-Google-Smtp-Source: APiQypLOLJ35+WgLxfk2EwPnCh+DT40M0tiM9S69p9cDC76eZfmXMWAEBP6gBzP6+DY8ko5iWT7GBw==
X-Received: by 2002:a63:f46:: with SMTP id 6mr9089714pgp.367.1587731640991;
        Fri, 24 Apr 2020 05:34:00 -0700 (PDT)
Received: from localhost (220-135-95-34.HINET-IP.hinet.net. [220.135.95.34])
        by smtp.gmail.com with ESMTPSA id p16sm4614475pjz.2.2020.04.24.05.34.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Apr 2020 05:34:00 -0700 (PDT)
From:   AceLan Kao <acelan.kao@canonical.com>
To:     Mark Brown <broonie@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Aaron Sierra <asierra@xes-inc.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2] regmap-i2c: add 16-bit width registers support
Date:   Fri, 24 Apr 2020 20:33:58 +0800
Message-Id: <20200424123358.144850-1-acelan.kao@canonical.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This allows to access data with 16-bit width of registers
via i2c SMBus block functions.

The multi-command sequence of the reading function is not safe
and may read the wrong data from other address if other commands
are sent in-between the SMBus commands in the read function.

Read performance:
   32768 bytes (33 kB, 32 KiB) copied, 11.4869 s, 2.9 kB/s
Write performance(with 1-byte page):
   32768 bytes (33 kB, 32 KiB) copied, 129.591 s, 0.3 kB/s

The implementation is inspired by below commit
https://patchwork.ozlabs.org/patch/545292/

v2: add more descriptions about the issue that maybe introduced
    by this commit

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

