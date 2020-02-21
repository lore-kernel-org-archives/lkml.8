Return-Path: <SRS0=1210=4J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 992EFC11D28
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Feb 2020 04:16:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6EC2F20722
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Feb 2020 04:16:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=alliedtelesis.co.nz header.i=@alliedtelesis.co.nz header.b="Unt39Dbi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729783AbgBUEQ6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Feb 2020 23:16:58 -0500
Received: from gate2.alliedtelesis.co.nz ([202.36.163.20]:58170 "EHLO
        gate2.alliedtelesis.co.nz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729703AbgBUEQs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Feb 2020 23:16:48 -0500
Received: from mmarshal3.atlnz.lc (mmarshal3.atlnz.lc [10.32.18.43])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by gate2.alliedtelesis.co.nz (Postfix) with ESMTPS id 4513A891AC;
        Fri, 21 Feb 2020 17:16:44 +1300 (NZDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alliedtelesis.co.nz;
        s=mail181024; t=1582258604;
        bh=JWoAVIXnFFzFVezqCwzPVSnstWKKJ4H9zsN13AoZIc4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References;
        b=Unt39DbiIhM8Y30Z+43V2P8Oj85hivyAj2GxRhd6gFw4bfkDKJQh+MvdYC1xmLjrQ
         EazolKvmU58PX7fJR+GGhUXHwOuy2tDulGlTzB0FKdqwi/NlRCC9NpysiJS3HyldxM
         7N8RhzRdylrLVWuYbMtF6CHIRMSiGn8eHVC5E995xpROyG2aA6fx5N5Z/g+WP17y7U
         0jMj2IX3A6AIOW9jQO2ZdfmJSTCZEX4Cz2LfjZfl2M7l3cGvKOKPIDVBAzPY5HB5Tv
         hAolzC6j3xamgbDloyGCy0nrC7lSfsJ2WdPb5bI4TgtROVeh4bbPQFU8iPSIKbkWk3
         LsbskQ1jt7OSg==
Received: from smtp (Not Verified[10.32.16.33]) by mmarshal3.atlnz.lc with Trustwave SEG (v7,5,8,10121)
        id <B5e4f59ac0003>; Fri, 21 Feb 2020 17:16:44 +1300
Received: from chrisp-dl.ws.atlnz.lc (chrisp-dl.ws.atlnz.lc [10.33.22.20])
        by smtp (Postfix) with ESMTP id 5D5BC13EECD;
        Fri, 21 Feb 2020 17:16:43 +1300 (NZDT)
Received: by chrisp-dl.ws.atlnz.lc (Postfix, from userid 1030)
        id E53AF28006D; Fri, 21 Feb 2020 17:16:43 +1300 (NZDT)
From:   Chris Packham <chris.packham@alliedtelesis.co.nz>
To:     jdelvare@suse.com, linux@roeck-us.net, robh+dt@kernel.org,
        mark.rutland@arm.com
Cc:     linux-hwmon@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, logan.shaw@alliedtelesis.co.nz,
        Chris Packham <chris.packham@alliedtelesis.co.nz>
Subject: [PATCH v4 4/5] hwmon: (adt7475) Add attenuator bypass support
Date:   Fri, 21 Feb 2020 17:16:30 +1300
Message-Id: <20200221041631.10960-5-chris.packham@alliedtelesis.co.nz>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200221041631.10960-1-chris.packham@alliedtelesis.co.nz>
References: <20200221041631.10960-1-chris.packham@alliedtelesis.co.nz>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
x-atlnz-ls: pat
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Logan Shaw <logan.shaw@alliedtelesis.co.nz>

Added support for reading DTS properties to set attenuators on
device probe for the ADT7473, ADT7475, ADT7476, and ADT7490.

Signed-off-by: Logan Shaw <logan.shaw@alliedtelesis.co.nz>
Signed-off-by: Chris Packham <chris.packham@alliedtelesis.co.nz>
---

Notes:
    Changes in v4:
    - use vendor prefix for new property
   =20
    Changes in v3:
    - move config2 to struct adt7475_data
    - set_property_bit() new helper function to set/clear bit based on dt
      property value.
    - rename to use load_attenuators()

 drivers/hwmon/adt7475.c | 61 +++++++++++++++++++++++++++++++++++++++--
 1 file changed, 58 insertions(+), 3 deletions(-)

diff --git a/drivers/hwmon/adt7475.c b/drivers/hwmon/adt7475.c
index 01c2eeb02aa9..3649b18359dc 100644
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
@@ -193,6 +194,7 @@ struct adt7475_data {
 	unsigned long measure_updated;
 	bool valid;
=20
+	u8 config2;
 	u8 config4;
 	u8 config5;
 	u8 has_voltage;
@@ -1458,6 +1460,55 @@ static int adt7475_update_limits(struct i2c_client=
 *client)
 	return 0;
 }
=20
+static int set_property_bit(const struct i2c_client *client, char *prope=
rty,
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
+
+	return ret;
+}
+
+static int load_attenuators(const struct i2c_client *client, int chip,
+			    struct adt7475_data *data)
+{
+	int ret;
+
+	if (chip =3D=3D adt7476 || chip =3D=3D adt7490) {
+		set_property_bit(client, "adi,bypass-attenuator-in0",
+				 &data->config4, 4);
+		set_property_bit(client, "adi,bypass-attenuator-in1",
+				 &data->config4, 5);
+		set_property_bit(client, "adi,bypass-attenuator-in3",
+				 &data->config4, 6);
+		set_property_bit(client, "adi,bypass-attenuator-in4",
+				 &data->config4, 7);
+
+		ret =3D i2c_smbus_write_byte_data(client, REG_CONFIG4,
+						data->config4);
+		if (ret < 0)
+			return ret;
+	} else if (chip =3D=3D adt7473 || chip =3D=3D adt7475) {
+		set_property_bit(client, "adi,bypass-attenuator-in1",
+				 &data->config2, 5);
+
+		ret =3D i2c_smbus_write_byte_data(client, REG_CONFIG2,
+						data->config2);
+		if (ret < 0)
+			return ret;
+	}
+
+	return 0;
+}
+
 static int adt7475_probe(struct i2c_client *client,
 			 const struct i2c_device_id *id)
 {
@@ -1472,7 +1523,7 @@ static int adt7475_probe(struct i2c_client *client,
 	struct adt7475_data *data;
 	struct device *hwmon_dev;
 	int i, ret =3D 0, revision, group_num =3D 0;
-	u8 config2, config3;
+	u8 config3;
=20
 	data =3D devm_kzalloc(&client->dev, sizeof(*data), GFP_KERNEL);
 	if (data =3D=3D NULL)
@@ -1546,8 +1597,12 @@ static int adt7475_probe(struct i2c_client *client=
,
 	}
=20
 	/* Voltage attenuators can be bypassed, globally or individually */
-	config2 =3D adt7475_read(REG_CONFIG2);
-	if (config2 & CONFIG2_ATTN) {
+	data->config2 =3D adt7475_read(REG_CONFIG2);
+	ret =3D load_attenuators(client, chip, data);
+	if (ret)
+		dev_err(&client->dev, "Error configuring attenuator bypass\n");
+
+	if (data->config2 & CONFIG2_ATTN) {
 		data->bypass_attn =3D (0x3 << 3) | 0x3;
 	} else {
 		data->bypass_attn =3D ((data->config4 & CONFIG4_ATTN_IN10) >> 4) |
--=20
2.25.0

