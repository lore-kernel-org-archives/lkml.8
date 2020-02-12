Return-Path: <SRS0=shi3=4A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ACEA6C352A3
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Feb 2020 03:06:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7B4CC2082F
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Feb 2020 03:06:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=alliedtelesis.co.nz header.i=@alliedtelesis.co.nz header.b="z+tmd1Ba"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727942AbgBLDGb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Feb 2020 22:06:31 -0500
Received: from gate2.alliedtelesis.co.nz ([202.36.163.20]:39401 "EHLO
        gate2.alliedtelesis.co.nz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727710AbgBLDG2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Feb 2020 22:06:28 -0500
Received: from mmarshal3.atlnz.lc (mmarshal3.atlnz.lc [10.32.18.43])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by gate2.alliedtelesis.co.nz (Postfix) with ESMTPS id 0E90D891AA;
        Wed, 12 Feb 2020 16:06:26 +1300 (NZDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alliedtelesis.co.nz;
        s=mail181024; t=1581476786;
        bh=BS4SIJJXkPfD3uRSfaxuBqFgO6t+gHHcevTuB9owsIE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References;
        b=z+tmd1BaPSpks5VQvfdyS3YdeIQddbiXVMpVyvByPVuKU9Tpp8k/LZpCuZrAN6qYN
         S4azscTOe1qdxbho+BJOgQVkZVObciwjZYg8O7YACab+95l8iuVCjbmEIXwXAM5ZPZ
         yO6qSvuyYv6pPgkyDmnQ0nLB4iOtAfLWcoxOgCGlZJqZy5Oo9vDq7y870AvA+gLXAr
         2ILKQ6/kubB4ajpkiKSyTx3hkjP677CHe4c/NCyY62YHArwAdwf+i3tF4np9byt/n/
         X8uH7Nvljg8pzFS3kEIuRTHx53qtHuKbc+Acghv6JEnBpi2nXYuwaWVpYqkPgRFrhg
         Rp1O66kYOZbDw==
Received: from smtp (Not Verified[10.32.16.33]) by mmarshal3.atlnz.lc with Trustwave SEG (v7,5,8,10121)
        id <B5e436bb10000>; Wed, 12 Feb 2020 16:06:25 +1300
Received: from henrys-dl.ws.atlnz.lc (henrys-dl.ws.atlnz.lc [10.33.23.26])
        by smtp (Postfix) with ESMTP id 9BF0413EED4;
        Wed, 12 Feb 2020 16:06:25 +1300 (NZDT)
Received: by henrys-dl.ws.atlnz.lc (Postfix, from userid 1052)
        id C40CB4E1463; Wed, 12 Feb 2020 16:06:25 +1300 (NZDT)
From:   Henry Shen <henry.shen@alliedtelesis.co.nz>
To:     robh+dt@kernel.org, mark.rutland@arm.com,
        guillaume.ligneul@gmail.com, jdelvare@suse.com, linux@roeck-us.net,
        trivial@kernel.org, venture@google.com
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-hwmon@vger.kernel.org,
        Henry Shen <henry.shen@alliedtelesis.co.nz>
Subject: [PATCH v2 2/2] hwmon: (lm73) Add support for of_match_table
Date:   Wed, 12 Feb 2020 16:06:15 +1300
Message-Id: <20200212030615.28537-3-henry.shen@alliedtelesis.co.nz>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200212030615.28537-1-henry.shen@alliedtelesis.co.nz>
References: <20200212030615.28537-1-henry.shen@alliedtelesis.co.nz>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
x-atlnz-ls: pat
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the of_match_table.

Signed-off-by: Henry Shen <henry.shen@alliedtelesis.co.nz>
---
Change in v2:
- add missing sign-off

 drivers/hwmon/lm73.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/hwmon/lm73.c b/drivers/hwmon/lm73.c
index 1eeb9d7de2a0..733c48bf6c98 100644
--- a/drivers/hwmon/lm73.c
+++ b/drivers/hwmon/lm73.c
@@ -262,10 +262,20 @@ static int lm73_detect(struct i2c_client *new_clien=
t,
 	return 0;
 }
=20
+static const struct of_device_id lm73_of_match[] =3D {
+	{
+		.compatible =3D "ti,lm73",
+	},
+	{ },
+};
+
+MODULE_DEVICE_TABLE(of, lm73_of_match);
+
 static struct i2c_driver lm73_driver =3D {
 	.class		=3D I2C_CLASS_HWMON,
 	.driver =3D {
 		.name	=3D "lm73",
+		.of_match_table =3D lm73_of_match,
 	},
 	.probe		=3D lm73_probe,
 	.id_table	=3D lm73_ids,
--=20
2.25.0

