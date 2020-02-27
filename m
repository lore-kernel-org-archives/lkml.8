Return-Path: <SRS0=BMk7=4P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23121C4BA3E
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Feb 2020 08:47:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E68E824688
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Feb 2020 08:46:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=alliedtelesis.co.nz header.i=@alliedtelesis.co.nz header.b="UYQM+Vkg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728762AbgB0Iq6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Feb 2020 03:46:58 -0500
Received: from gate2.alliedtelesis.co.nz ([202.36.163.20]:40293 "EHLO
        gate2.alliedtelesis.co.nz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728719AbgB0Iqz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Feb 2020 03:46:55 -0500
Received: from mmarshal3.atlnz.lc (mmarshal3.atlnz.lc [10.32.18.43])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by gate2.alliedtelesis.co.nz (Postfix) with ESMTPS id 793B6891AE;
        Thu, 27 Feb 2020 21:46:52 +1300 (NZDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alliedtelesis.co.nz;
        s=mail181024; t=1582793212;
        bh=7ES6tEyEz8XnCzXTzvkZrM7yYWWqjmJ6wjX0UjtGUNo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References;
        b=UYQM+VkgT40nWUTOK56c3OPmdy3/3eNIkjCExJgaJJAg1Y8xboPo5QXITBC4whZdx
         ZkvJcMuRonwPWu4l5dNkvf+zOIq6IR5dl8cfI1GAsTzKsADT8ewSYguM3zUsTsOtQw
         UVbXC9v1JJOdhjFL6GdeudfQ3u3yKw8UY4UtQOafVfjz1aTEYj6cTa+WlG723FlYO1
         stK/R0GBvixN6w4ipNWwzSCM28e+BZcNAcsqBEVZOhMTZI1hOjmlhpqtebCa8EvidO
         uNbvo5N8x+aZGncym8w8VLn+/7ED5vUMeHOoD6pki/WO3Nog6NdEGOaSpszkjmzhV5
         XV21vfKa8+UkQ==
Received: from smtp (Not Verified[10.32.16.33]) by mmarshal3.atlnz.lc with Trustwave SEG (v7,5,8,10121)
        id <B5e5781fb0005>; Thu, 27 Feb 2020 21:46:51 +1300
Received: from chrisp-dl.ws.atlnz.lc (chrisp-dl.ws.atlnz.lc [10.33.22.20])
        by smtp (Postfix) with ESMTP id 810C913EECD;
        Thu, 27 Feb 2020 21:46:51 +1300 (NZDT)
Received: by chrisp-dl.ws.atlnz.lc (Postfix, from userid 1030)
        id 4713C280072; Thu, 27 Feb 2020 21:46:52 +1300 (NZDT)
From:   Chris Packham <chris.packham@alliedtelesis.co.nz>
To:     jdelvare@suse.com, linux@roeck-us.net, robh+dt@kernel.org,
        mark.rutland@arm.com
Cc:     logan.shaw@alliedtelesis.co.nz, linux-hwmon@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Chris Packham <chris.packham@alliedtelesis.co.nz>
Subject: [PATCH v5 5/5] hwmon: (adt7475) Add support for inverting pwm output
Date:   Thu, 27 Feb 2020 21:46:42 +1300
Message-Id: <20200227084642.7057-6-chris.packham@alliedtelesis.co.nz>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200227084642.7057-1-chris.packham@alliedtelesis.co.nz>
References: <20200227084642.7057-1-chris.packham@alliedtelesis.co.nz>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
x-atlnz-ls: pat
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a "adi,pwm-active-state" device-tree property to allow hardware
designs to use inverted logic on the PWM output.

Signed-off-by: Chris Packham <chris.packham@alliedtelesis.co.nz>
---

Notes:
    Changes in v5:
    - change to adi,pwm-active-state
    - uint32 array
   =20
    Changes in v4:
    - use vendor prefix for new property
   =20
    Changes in v3:
    - New

 drivers/hwmon/adt7475.c | 34 ++++++++++++++++++++++++++++++++++
 1 file changed, 34 insertions(+)

diff --git a/drivers/hwmon/adt7475.c b/drivers/hwmon/adt7475.c
index 3649b18359dc..142a4fec688b 100644
--- a/drivers/hwmon/adt7475.c
+++ b/drivers/hwmon/adt7475.c
@@ -1509,6 +1509,36 @@ static int load_attenuators(const struct i2c_clien=
t *client, int chip,
 	return 0;
 }
=20
+static int adt7475_set_pwm_polarity(struct i2c_client *client)
+{
+	u32 states[ADT7475_PWM_COUNT];
+	int ret, i;
+	u8 val;
+
+	ret =3D of_property_read_u32_array(client->dev.of_node,
+					 "adi,pwm-active-state", states,
+					 ARRAY_SIZE(states));
+	if (ret)
+		return ret;
+
+	for (i =3D 0; i < ADT7475_PWM_COUNT; i++) {
+		ret =3D adt7475_read(PWM_CONFIG_REG(i));
+		if (ret < 0)
+			return ret;
+		val =3D ret;
+		if (states[i])
+			val &=3D ~BIT(4);
+		else
+			val |=3D BIT(4);
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
@@ -1617,6 +1647,10 @@ static int adt7475_probe(struct i2c_client *client=
,
 	for (i =3D 0; i < ADT7475_PWM_COUNT; i++)
 		adt7475_read_pwm(client, i);
=20
+	ret =3D adt7475_set_pwm_polarity(client);
+	if (ret && ret !=3D -EINVAL)
+		dev_err(&client->dev, "Error configuring pwm polarity\n");
+
 	/* Start monitoring */
 	switch (chip) {
 	case adt7475:
--=20
2.25.1

