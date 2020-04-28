Return-Path: <SRS0=r24B=6M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D76C3C83001
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Apr 2020 17:30:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B4DD92085B
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Apr 2020 17:30:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JCoj3Iaz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728622AbgD1R37 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Apr 2020 13:29:59 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:35420 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728588AbgD1R3z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Apr 2020 13:29:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1588094994;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=pzhtl1iCIDFNL0daJVFlG/7j/7BUqiBG+ISNSdnAnS0=;
        b=JCoj3IazPgcRYuMffzgFhlQBqAthe+08HDrN4ytHlD1J05NL4uaPg3DwZUU0rj5BoS83Tp
        QYPGvzygT78Dip5gwHnCBNd+qGywdcmbswa+gWok2zs69AVNCqM1apL9beumMgSI1bed5a
        docFX0fJY+eA6L1pLpyORpCIyxGqygY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-412-ibM1c6TIOBWHwQ0Yy_Nbkw-1; Tue, 28 Apr 2020 13:29:50 -0400
X-MC-Unique: ibM1c6TIOBWHwQ0Yy_Nbkw-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 1A338835B42;
        Tue, 28 Apr 2020 17:29:48 +0000 (UTC)
Received: from x1.localdomain.com (ovpn-114-62.ams2.redhat.com [10.36.114.62])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 87CFF5C1D4;
        Tue, 28 Apr 2020 17:29:45 +0000 (UTC)
From:   Hans de Goede <hdegoede@redhat.com>
To:     "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>,
        Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>,
        Jonathan Cameron <jic23@kernel.org>
Cc:     Hans de Goede <hdegoede@redhat.com>, linux-acpi@vger.kernel.org,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        linux-iio@vger.kernel.org,
        Andy Shevchenko <andy.shevchenko@gmail.com>
Subject: [PATCH v3 07/11] iio: light: cm32181: Change reg_init to use a bitmap of which registers to init
Date:   Tue, 28 Apr 2020 19:29:19 +0200
Message-Id: <20200428172923.567806-7-hdegoede@redhat.com>
In-Reply-To: <20200428172923.567806-1-hdegoede@redhat.com>
References: <20200428172923.567806-1-hdegoede@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is a preparation patch for reading some ACPI tables which give
init values for multiple registers.

Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
Changes in v2:
- Use unsigned long for init_regs_bitmap
- Use for_each_set_bit()
---
 drivers/iio/light/cm32181.c | 14 ++++++--------
 1 file changed, 6 insertions(+), 8 deletions(-)

diff --git a/drivers/iio/light/cm32181.c b/drivers/iio/light/cm32181.c
index c23a5c3a86a3..bcea669d20cb 100644
--- a/drivers/iio/light/cm32181.c
+++ b/drivers/iio/light/cm32181.c
@@ -26,7 +26,7 @@
 #define CM32181_REG_ADDR_ID		0x07
=20
 /* Number of Configurable Registers */
-#define CM32181_CONF_REG_NUM		0x01
+#define CM32181_CONF_REG_NUM		4
=20
 /* CMD register */
 #define CM32181_CMD_ALS_DISABLE		BIT(0)
@@ -53,10 +53,6 @@
=20
 #define SMBUS_ALERT_RESPONSE_ADDRESS	0x0c
=20
-static const u8 cm32181_reg[CM32181_CONF_REG_NUM] =3D {
-	CM32181_REG_ADDR_CMD,
-};
-
 /* CM3218 Family */
 static const int cm3218_als_it_bits[] =3D { 0, 1, 2, 3 };
 static const int cm3218_als_it_values[] =3D { 100000, 200000, 400000, 80=
0000 };
@@ -71,6 +67,7 @@ struct cm32181_chip {
 	struct i2c_client *client;
 	struct mutex lock;
 	u16 conf_regs[CM32181_CONF_REG_NUM];
+	unsigned long init_regs_bitmap;
 	int calibscale;
 	int num_als_it;
 	const int *als_it_bits;
@@ -115,12 +112,13 @@ static int cm32181_reg_init(struct cm32181_chip *cm=
32181)
 	/* Default Values */
 	cm32181->conf_regs[CM32181_REG_ADDR_CMD] =3D
 			CM32181_CMD_ALS_IT_DEFAULT | CM32181_CMD_ALS_SM_DEFAULT;
+	cm32181->init_regs_bitmap =3D BIT(CM32181_REG_ADDR_CMD);
 	cm32181->calibscale =3D CM32181_CALIBSCALE_DEFAULT;
=20
 	/* Initialize registers*/
-	for (i =3D 0; i < CM32181_CONF_REG_NUM; i++) {
-		ret =3D i2c_smbus_write_word_data(client, cm32181_reg[i],
-			cm32181->conf_regs[i]);
+	for_each_set_bit(i, &cm32181->init_regs_bitmap, CM32181_CONF_REG_NUM) {
+		ret =3D i2c_smbus_write_word_data(client, i,
+						cm32181->conf_regs[i]);
 		if (ret < 0)
 			return ret;
 	}
--=20
2.26.0

