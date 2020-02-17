Return-Path: <SRS0=PfNx=4F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EAA7BC34022
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Feb 2020 23:47:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BEBBD208C4
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Feb 2020 23:47:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=alliedtelesis.co.nz header.i=@alliedtelesis.co.nz header.b="fMOLdjrZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726482AbgBQXrN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Feb 2020 18:47:13 -0500
Received: from gate2.alliedtelesis.co.nz ([202.36.163.20]:48822 "EHLO
        gate2.alliedtelesis.co.nz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725997AbgBQXrF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Feb 2020 18:47:05 -0500
Received: from mmarshal3.atlnz.lc (mmarshal3.atlnz.lc [10.32.18.43])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by gate2.alliedtelesis.co.nz (Postfix) with ESMTPS id BD63B891AC;
        Tue, 18 Feb 2020 12:47:00 +1300 (NZDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alliedtelesis.co.nz;
        s=mail181024; t=1581983220;
        bh=Qcs5L20LNgbbFFaZG63R6OuduRgEp8/3wC+dSc2nhA8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References;
        b=fMOLdjrZw+oVl9UKJeFT48MXGyeHCAqKxbztTP5CFC0s096+7Wu0CY/Th7eTVWQW0
         CZmZuIsoZLJttuo/WQwjyZByPuRr3YHvMiy34AICWibyaqLphhw145r1uagjM1f3MD
         zYlAo43t7sKDXG8NS2txEYdMZZiJS43ENPtScUTo3aOoCZWpas8u9XX+uVXIWIfusj
         fH50s0/ksLS8JVEaJPCoItf3p/xi2BZz9wdILrMOVNhBNLvVhtx7tbZo5cOVygo1jT
         EoH4VwEwHHePhSAidLjQDLFcBgaVdbt8lOVmxRy6/t29K4StZvDNO3gKJhB1/hOAZJ
         PDZ/pv5cuqXkw==
Received: from smtp (Not Verified[10.32.16.33]) by mmarshal3.atlnz.lc with Trustwave SEG (v7,5,8,10121)
        id <B5e4b25f40001>; Tue, 18 Feb 2020 12:47:00 +1300
Received: from chrisp-dl.ws.atlnz.lc (chrisp-dl.ws.atlnz.lc [10.33.22.20])
        by smtp (Postfix) with ESMTP id 1CA5613EED4;
        Tue, 18 Feb 2020 12:47:00 +1300 (NZDT)
Received: by chrisp-dl.ws.atlnz.lc (Postfix, from userid 1030)
        id 8B6BF28006C; Tue, 18 Feb 2020 12:47:00 +1300 (NZDT)
From:   Chris Packham <chris.packham@alliedtelesis.co.nz>
To:     jdelvare@suse.com, linux@roeck-us.net, robh+dt@kernel.org,
        mark.rutland@arm.com
Cc:     logan.shaw@alliedtelesis.co.nz, linux-hwmon@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Chris Packham <chris.packham@alliedtelesis.co.nz>
Subject: [PATCH 5/5] hwmon: (adt7475) Add support for inverting pwm output
Date:   Tue, 18 Feb 2020 12:46:57 +1300
Message-Id: <20200217234657.9413-6-chris.packham@alliedtelesis.co.nz>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200217234657.9413-1-chris.packham@alliedtelesis.co.nz>
References: <20200217234657.9413-1-chris.packham@alliedtelesis.co.nz>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
x-atlnz-ls: pat
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a "invert-pwm" device-tree property to allow hardware designs to use
inverted logic on the PWM output. Preserve the invert PWM output bit if
the property is not found to allow for bootloaders/bios which may have
configured this earlier.

Signed-off-by: Chris Packham <chris.packham@alliedtelesis.co.nz>
---
 drivers/hwmon/adt7475.c | 39 +++++++++++++++++++++++++++++++++++++++
 1 file changed, 39 insertions(+)

diff --git a/drivers/hwmon/adt7475.c b/drivers/hwmon/adt7475.c
index 4a62d633a2f5..dccb1c78a57d 100644
--- a/drivers/hwmon/adt7475.c
+++ b/drivers/hwmon/adt7475.c
@@ -1509,6 +1509,41 @@ static int load_attenuators(const struct i2c_clien=
t *client, int chip,
 	return 0;
 }
=20
+static int adt7475_set_pwm_polarity(struct i2c_client *client)
+{
+	char *prop;
+	int ret, i;
+	u8 val;
+
+	for (i =3D 0; i < ADT7475_PWM_COUNT; i++) {
+		ret =3D adt7475_read(PWM_CONFIG_REG(i));
+		if (ret < 0)
+			return ret;
+		val =3D ret;
+		switch (i) {
+		case 0:
+			prop =3D "invert-pwm1";
+			break;
+		case 1:
+			prop =3D "invert-pwm2";
+			break;
+		case 2:
+			prop =3D "invert-pwm3";
+			break;
+		}
+
+		ret =3D set_property_bit(client, prop, &val, 4);
+		if (ret)
+			continue;
+
+		ret =3D i2c_smbus_write_byte_data(client, PWM_CONFIG_REG(i), val);
+		if (ret)
+			return ret;
+	}
+
+	return 0;
+}
+
 static int adt7475_probe(struct i2c_client *client,
 			 const struct i2c_device_id *id)
 {
@@ -1617,6 +1652,10 @@ static int adt7475_probe(struct i2c_client *client=
,
 	for (i =3D 0; i < ADT7475_PWM_COUNT; i++)
 		adt7475_read_pwm(client, i);
=20
+	ret =3D adt7475_set_pwm_polarity(client);
+	if (ret)
+		dev_err(&client->dev, "Error configuring pwm polarity");
+
 	/* Start monitoring */
 	switch (chip) {
 	case adt7475:
--=20
2.25.0

