Return-Path: <SRS0=fzvl=3P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F35C0C2D0DB
	for <linux-kernel@archiver.kernel.org>; Sun, 26 Jan 2020 22:10:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C42C020716
	for <linux-kernel@archiver.kernel.org>; Sun, 26 Jan 2020 22:10:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=alliedtelesis.co.nz header.i=@alliedtelesis.co.nz header.b="hWmywt9R"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728236AbgAZWKd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 26 Jan 2020 17:10:33 -0500
Received: from gate2.alliedtelesis.co.nz ([202.36.163.20]:40316 "EHLO
        gate2.alliedtelesis.co.nz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726252AbgAZWKc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Jan 2020 17:10:32 -0500
Received: from mmarshal3.atlnz.lc (mmarshal3.atlnz.lc [10.32.18.43])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by gate2.alliedtelesis.co.nz (Postfix) with ESMTPS id 6C1FA886BF;
        Mon, 27 Jan 2020 11:10:31 +1300 (NZDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alliedtelesis.co.nz;
        s=mail181024; t=1580076631;
        bh=vfOUd83vLniAyLu6CP72Bs9UFXDfxICC0fERRfGsS9I=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References;
        b=hWmywt9ReGC2OcMBw7s0lcrsCgV031LGp3Zs7/5p8e4YL2rcfkpCdMdqSfijx5Zj+
         TFk+pSxuXoF6sFffG+33eUNR2EoNFEOk97nCK6zKM5HH5jPlTSZES8hme8j4v1Oksu
         IEKrfP4iw13F1KLRvHmycj6wetPMndlfirQ8ot4MyxpFI7iQJ2/AM3w4I0fycR1SKO
         1pSJyM14FC0Ktn5WEk7LpR5RTaXSP89fa6KYOgFHeGbMs6HIwoOyhm5AaVk7JZ7IIO
         6mueltACEb1ChkDE3IsglI6lN+FxnCvasRogbXg70oVnIKyqaBckvmxGqMo8HUixuj
         /nRar8Det1Few==
Received: from smtp (Not Verified[10.32.16.33]) by mmarshal3.atlnz.lc with Trustwave SEG (v7,5,8,10121)
        id <B5e2e0e570000>; Mon, 27 Jan 2020 11:10:31 +1300
Received: from logans-dl.ws.atlnz.lc (logans-dl.ws.atlnz.lc [10.33.25.61])
        by smtp (Postfix) with ESMTP id 22B3413EEB9;
        Mon, 27 Jan 2020 11:10:30 +1300 (NZDT)
Received: by logans-dl.ws.atlnz.lc (Postfix, from userid 1820)
        id 38F71C0DF6; Mon, 27 Jan 2020 11:10:31 +1300 (NZDT)
From:   Logan Shaw <logan.shaw@alliedtelesis.co.nz>
To:     linux@roeck-us.net, jdelvare@suse.com, robh+dt@kernel.org
Cc:     linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, Joshua.Scott@alliedtelesis.co.nz,
        Chris.Packham@alliedtelesis.co.nz, logan.shaw@alliedtelesis.co.nz
Subject: [PATCH v6 1/2] hwmon: (adt7475) Added attenuator bypass support
Date:   Mon, 27 Jan 2020 11:10:13 +1300
Message-Id: <20200126221014.2978-2-logan.shaw@alliedtelesis.co.nz>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200126221014.2978-1-logan.shaw@alliedtelesis.co.nz>
References: <20200126221014.2978-1-logan.shaw@alliedtelesis.co.nz>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
x-atlnz-ls: pat
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Added support for reading DTS properties to set attenuators on
device probe for the ADT7473, ADT7475, ADT7476, and ADT7490.

Signed-off-by: Logan Shaw <logan.shaw@alliedtelesis.co.nz>
---
---
 drivers/hwmon/adt7475.c | 55 +++++++++++++++++++++++++++++++++++++++++
 1 file changed, 55 insertions(+)

diff --git a/drivers/hwmon/adt7475.c b/drivers/hwmon/adt7475.c
index 6c64d50c9aae..3f4bdc1eaaec 100644
--- a/drivers/hwmon/adt7475.c
+++ b/drivers/hwmon/adt7475.c
@@ -19,6 +19,7 @@
 #include <linux/hwmon-vid.h>
 #include <linux/err.h>
 #include <linux/jiffies.h>
+#include <linux/of.h>
 #include <linux/util_macros.h>
=20
 /* Indexes for the sysfs hooks */
@@ -1457,6 +1458,57 @@ static int adt7475_update_limits(struct i2c_client=
 *client)
 	return 0;
 }
=20
+static void modify_config(const struct i2c_client *client, char *propert=
y,
+			  u8 *config, u8 bit_index)
+{
+	u32 prop_value =3D 0;
+	int ret =3D of_property_read_u32(client->dev.of_node, property,
+					&prop_value);
+
+	if (!ret) {
+		if (prop_value)
+			*config |=3D (1 << bit_index);
+		else
+			*config &=3D ~(1 << bit_index);
+	}
+}
+
+static int load_attenuators(const struct i2c_client *client, int chip,
+			    u8 *config2, u8 *config4)
+{
+	u8 conf_copy;
+	int ret;
+
+	if (chip =3D=3D adt7476 || chip =3D=3D adt7490) {
+		conf_copy =3D *config4;
+
+		modify_config(client, "bypass-attenuator-in0", &conf_copy, 4);
+		modify_config(client, "bypass-attenuator-in1", &conf_copy, 5);
+		modify_config(client, "bypass-attenuator-in3", &conf_copy, 6);
+		modify_config(client, "bypass-attenuator-in4", &conf_copy, 7);
+
+		ret =3D i2c_smbus_write_byte_data(client, REG_CONFIG4,
+						conf_copy);
+		if (ret < 0)
+			return ret;
+
+		*config4 =3D conf_copy;
+	} else if (chip =3D=3D adt7473 || chip =3D=3D adt7475) {
+		conf_copy =3D *config2;
+
+		modify_config(client, "bypass-attenuator-in1", &conf_copy, 5);
+
+		ret =3D i2c_smbus_write_byte_data(client, REG_CONFIG2,
+						conf_copy);
+		if (ret < 0)
+			return ret;
+
+		*config2 =3D conf_copy;
+	}
+
+	return 0;
+}
+
 static int adt7475_probe(struct i2c_client *client,
 			 const struct i2c_device_id *id)
 {
@@ -1546,6 +1598,9 @@ static int adt7475_probe(struct i2c_client *client,
=20
 	/* Voltage attenuators can be bypassed, globally or individually */
 	config2 =3D adt7475_read(REG_CONFIG2);
+	if (load_attenuators(client, chip, &config2, &data->config4) < 0)
+		dev_warn(&client->dev, "Error setting bypass attenuators\n");
+
 	if (config2 & CONFIG2_ATTN) {
 		data->bypass_attn =3D (0x3 << 3) | 0x3;
 	} else {
--=20
2.25.0

