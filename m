Return-Path: <SRS0=fR4S=7I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0C41C433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 26 May 2020 09:42:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A1CFB2070A
	for <linux-kernel@archiver.kernel.org>; Tue, 26 May 2020 09:42:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=maximintegrated.onmicrosoft.com header.i=@maximintegrated.onmicrosoft.com header.b="ju8S5HKH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731803AbgEZJm0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 May 2020 05:42:26 -0400
Received: from mail-dm6nam12on2094.outbound.protection.outlook.com ([40.107.243.94]:24417
        "EHLO NAM12-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1731778AbgEZJmZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 May 2020 05:42:25 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DBpOY5XxZk3YDhTUWLtH14IxW4cETmWJyKbRYdTUeQSZ68k8BF0sVPtT2Af9Seec27jsfVOvorBA6br7SMePXg47qX26X/kVF+4a+NyqoeDgqnx7dQUDtWhGwjx5vvSa9Px//ASLVJChZ7Dq9dn706L/kcEybVJ3VHGavhzasqK/GHfp0wNYaUxglR58f2toM19eOrwFfHguUmm1fK15chP7taz5osRMmp7N4HEgd1ZB4F2S6UJYFR/MyTOfNSGyrxv7V3nR4obj5vMgf0KoPM/bW/15Mo+Ogi9zwObThVZ6eCYE1XO9iqYLEZ4uLdyMLI8aWk0cBjycxQe0yzvuNw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NnuFdwiNuKGUkXSNxYCo5sGyDAwlxWfPRy10G2YFodw=;
 b=PRR6KDVaOWo8Q7EU19C6RnyJ1jh3rx+nRinWd8VBumIhQ3ZeKeun+6GNZbVnWSgNhL9wWbu3YibJCOlQOaMePqXtUhp2tRa0WW1kw38mtEDsB+XT9BV+cZLVXLBDk0cNdQfVbJTUqfABBBHLuODFby7R1njrdeLtNiAbi+fMStFd+rsxLSL2gn3lx4F0658BGqg2PoMV1p+NTDqARkjzNd/yUp6o7F1lsPs8aXvQqkO/2dDt3BvOwNK+ahrUOIkwiFOtt6tsDjqJbeuOyqixImSjW9jk2Ju4bNuDTKKrJRPRO7YGkGmnpur1YT34vIyXRV+pvcxm27dfKTn9uI6vRA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=maximintegrated.com; dmarc=pass action=none
 header.from=maximintegrated.com; dkim=pass header.d=maximintegrated.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=maximintegrated.onmicrosoft.com;
 s=selector2-maximintegrated-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NnuFdwiNuKGUkXSNxYCo5sGyDAwlxWfPRy10G2YFodw=;
 b=ju8S5HKHln0E+8ON6A58wR/gB41zcetl/U1kWdqHdDt8Jv6gD56+oHgkube/O5puzQfORcZacVS7Qr8KGTHHxqNAqNnKXyqD8Spz3et3obPXEuk8yziYBHeOhc88cQeingXmxWW0IIFg4CNp0G3qDBDZJvKFNOOitIryeWkAsEM=
Received: from MWHPR11MB1661.namprd11.prod.outlook.com (2603:10b6:301:b::16)
 by MWHPR11MB1501.namprd11.prod.outlook.com (2603:10b6:301:d::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3021.24; Tue, 26 May
 2020 09:42:19 +0000
Received: from MWHPR11MB1661.namprd11.prod.outlook.com
 ([fe80::6c65:6b11:a837:e9b1]) by MWHPR11MB1661.namprd11.prod.outlook.com
 ([fe80::6c65:6b11:a837:e9b1%10]) with mapi id 15.20.3021.029; Tue, 26 May
 2020 09:42:19 +0000
From:   Ugur Usug <Ugur.Usug@maximintegrated.com>
To:     "linux@roeck-us.net" <linux@roeck-us.net>
CC:     "linux-hwmon@vger.kernel.org" <linux-hwmon@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: [PATCH] hwmon (pmbus/max20730): add max20710 and debugfs access
 support
Thread-Topic: [PATCH] hwmon (pmbus/max20730): add max20710 and debugfs access
 support
Thread-Index: AdYzQEHnSMxxVCd1S2iiEh/Bx2LiAg==
Date:   Tue, 26 May 2020 09:42:19 +0000
Message-ID: <MWHPR11MB1661A23F609D54EAAC93FDE7FDB00@MWHPR11MB1661.namprd11.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: roeck-us.net; dkim=none (message not signed)
 header.d=none;roeck-us.net; dmarc=none action=none
 header.from=maximintegrated.com;
x-originating-ip: [212.125.27.161]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 492c6ab5-1362-4062-288e-08d80159156c
x-ms-traffictypediagnostic: MWHPR11MB1501:
x-microsoft-antispam-prvs: <MWHPR11MB1501083509B818AAE38F6AADFDB00@MWHPR11MB1501.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2803;
x-forefront-prvs: 041517DFAB
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: RvDBJoNbiZkIyH0AJ+wzEPfc75lbLgabDwT9f960yw9yElPZ2vWdzyG3YWSYFqb0McyC97dLi/ICkd1KoKoQ/MBEKaKcRnobcVnl2dwsbJa2TxxhVgdbxYpo4H4Ped08LWG+NyUcw1fO48yvAN25eohnAGWYZnWuyuT0T0uNA9cn2vKqDKwCQxo9wQ7/nLtPFvotj4ufDJNglXUsPsyhH7OQB/VPxfYRgj5LK7x/7y8XCfKyIKnqVZtX7hShyrV3qH64D+RFFQxsMiaq/dCcl/COiSXy0juw0W7DJM9emqCovLqRrpHYI2FFqMWT1aqlNCWHFJWa51yOkaiJ2ADu13zzOPXL8J93MB5qKpbQzidKI1zlybZ3sB0hC/xhlW90bDyanLM2H1UM+ztYj6UwGQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR11MB1661.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(39860400002)(346002)(396003)(366004)(376002)(136003)(66946007)(76116006)(55016002)(66556008)(66476007)(64756008)(66446008)(6916009)(7696005)(9686003)(26005)(5660300002)(186003)(30864003)(6506007)(8676002)(316002)(8936002)(54906003)(71200400001)(33656002)(86362001)(966005)(4326008)(52536014)(478600001)(2906002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: /bKWxu6qrPoHpf6W1SwTRpkGlf4216m0Gs3NIahdt9L5G6oDtM+ECrG3xALlSiiAiDG3xX85y6IMU8pRxekyP7YYPdg7fF5elBPiltB6SA/DWBv+9wBgfsYM+VfmZL4TcvPSDAMPcS+MwOMhubiMD6vnROtJu+Yyn6yLDmbBKsIJBlT06wXqLuDekMlsAdQVfIGyh7GKLVOu2w4IVYtC7dOJ22Bh1N1hImSqiaxRH9xiQe9XX0pte7sIirlIvZIPqhn8tjJ+ELslLSj+WvpxD9cV1ztwgT1iLWQHuwzNWLr1XvZsDURaru59qeHZ9gWkX4rA/PA0bUnrBVFPk5nhv5Y07ar5h4rKFXA+uyvqZkEpHSMzIwFHKmaOFnNFpgf7mcItBPqDrtWhCfTadSqw6YRQb1X7u8MukdIn1JhtVe78aedMAzTn+SqoLZKX36i56YXAr/LRCibzJ7L1UALz2ZJPT2cWM0UXBXVQq5saAKWEOKrXDgsyAc/RVkaNrZy/
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: maximintegrated.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 492c6ab5-1362-4062-288e-08d80159156c
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 May 2020 09:42:19.4922
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: fbd909df-ea69-4788-a554-f24b7854ad03
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 40NYYJmgpbeOab5hyo6yxsBID5/j7pogEhQh/saZYe1jfMXsRYDIPz6U8m+kTizDmrl8iGbnnANHZ0hn/wqA1gAiec5dRRx78aXna/rcZ6c=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR11MB1501
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This change has 2 parts:
1. Add support for max20710 into the existing max20730 driver.

2. Add debugfs interface support for accessing device specific registers=20
(MFR_VOUT_MIN, MFR_DEVSET1 and MFR_DEVSET2) and others=20
including OPERATION, ON_OFF_CONFIG, SMB_ALERT_MASK,=20
VOUT_MODE, VOUT_COMMAND and VOUT_MAX.

Signed-off-by: Ugur Usug <ugur.usug@maximintegrated.com>
---
 Documentation/hwmon/max20730.rst |  10 +-
 drivers/hwmon/pmbus/Kconfig      |   4 +-
 drivers/hwmon/pmbus/max20730.c   | 412 +++++++++++++++++++++++++++++++++++=
+++-
 3 files changed, 414 insertions(+), 12 deletions(-)
 mode change 100644 =3D> 100755 drivers/hwmon/pmbus/max20730.c

diff --git a/Documentation/hwmon/max20730.rst b/Documentation/hwmon/max2073=
0.rst
index cea7ae5..cb0c95b 100644
--- a/Documentation/hwmon/max20730.rst
+++ b/Documentation/hwmon/max20730.rst
@@ -5,6 +5,14 @@ Kernel driver max20730
=20
 Supported chips:
=20
+  * Maxim MAX20710
+
+    Prefix: 'max20710'
+
+    Addresses scanned: -
+
+    Datasheet: https://datasheets.maximintegrated.com/en/ds/MAX20710.pdf
+
   * Maxim MAX20730
=20
     Prefix: 'max20730'
@@ -35,7 +43,7 @@ Author: Guenter Roeck <linux@roeck-us.net>
 Description
 -----------
=20
-This driver implements support for Maxim MAX20730, MAX20734, and MAX20743
+This driver implements support for Maxim MAX20710, MAX20730, MAX20734, and=
 MAX20743
 Integrated, Step-Down Switching Regulators with PMBus support.
=20
 The driver is a client driver to the core PMBus driver.
diff --git a/drivers/hwmon/pmbus/Kconfig b/drivers/hwmon/pmbus/Kconfig
index de12a56..cac96e0 100644
--- a/drivers/hwmon/pmbus/Kconfig
+++ b/drivers/hwmon/pmbus/Kconfig
@@ -147,10 +147,10 @@ config SENSORS_MAX16064
 	  be called max16064.
=20
 config SENSORS_MAX20730
-	tristate "Maxim MAX20730, MAX20734, MAX20743"
+	tristate "Maxim MAX20710, MAX20730, MAX20734, MAX20743"
 	help
 	  If you say yes here you get hardware monitoring support for Maxim
-	  MAX20730, MAX20734, and MAX20743.
+	  MAX20710, MAX20730, MAX20734, and MAX20743.
=20
 	  This driver can also be built as a module. If so, the module will
 	  be called max20730.
diff --git a/drivers/hwmon/pmbus/max20730.c b/drivers/hwmon/pmbus/max20730.=
c
old mode 100644
new mode 100755
index c0bb054..fc38be0
--- a/drivers/hwmon/pmbus/max20730.c
+++ b/drivers/hwmon/pmbus/max20730.c
@@ -1,12 +1,14 @@
 // SPDX-License-Identifier: GPL-2.0-or-later
 /*
- * Driver for MAX20730, MAX20734, and MAX20743 Integrated, Step-Down
- * Switching Regulators
+ * Driver for MAX20710, MAX20730, MAX20734, and MAX20743 Integrated,=20
+ * Step-Down Switching Regulators
  *
  * Copyright 2019 Google LLC.
+ * Copyright 2020 Maxim Integrated
  */
=20
 #include <linux/bits.h>
+#include <linux/debugfs.h>
 #include <linux/err.h>
 #include <linux/i2c.h>
 #include <linux/init.h>
@@ -19,21 +21,283 @@
 #include "pmbus.h"
=20
 enum chips {
+	max20710,
 	max20730,
 	max20734,
 	max20743
 };
=20
+enum {
+	MAX20730_DEBUGFS_VOUT_MIN =3D 0,
+	MAX20730_DEBUGFS_FREQUENCY,
+	MAX20730_DEBUGFS_PG_DELAY,
+	MAX20730_DEBUGFS_INTERNAL_GAIN,
+	MAX20730_DEBUGFS_BOOT_VOLTAGE,
+	MAX20730_DEBUGFS_OUT_V_RAMP_RATE,
+	MAX20730_DEBUGFS_OC_PROTECT_MODE,
+	MAX20730_DEBUGFS_SS_TIMING,
+	MAX20730_DEBUGFS_IMAX,
+	MAX20730_DEBUGFS_OPERATION,
+	MAX20730_DEBUGFS_ON_OFF_CONFIG,
+	MAX20730_DEBUGFS_SMBALERT_MASK,
+	MAX20730_DEBUGFS_VOUT_MODE,
+	MAX20730_DEBUGFS_VOUT_COMMAND,
+	MAX20730_DEBUGFS_VOUT_MAX,
+	MAX20730_DEBUGFS_NUM_ENTRIES
+};
+
 struct max20730_data {
 	enum chips id;
 	struct pmbus_driver_info info;
 	struct mutex lock;	/* Used to protect against parallel writes */
 	u16 mfr_devset1;
+	u16 mfr_devset2;
+	u16 mfr_voutmin;
 };
=20
 #define to_max20730_data(x)  container_of(x, struct max20730_data, info)
=20
+#define PMBUS_SMB_ALERT_MASK	0x1B
+
+#define MAX20730_MFR_VOUT_MIN	0xd1
 #define MAX20730_MFR_DEVSET1	0xd2
+#define MAX20730_MFR_DEVSET2	0xd3
+
+#define MAX20730_MFR_VOUT_MIN_MASK			GENMASK(9, 0)
+#define MAX20730_MFR_VOUT_MIN_BIT_POS		0
+
+#define MAX20730_MFR_DEVSET1_RGAIN_MASK		(BIT(13) | BIT(14))
+#define MAX20730_MFR_DEVSET1_OTP_MASK		(BIT(11) | BIT(12))
+#define MAX20730_MFR_DEVSET1_VBOOT_MASK		(BIT(8) | BIT(9))
+#define MAX20730_MFR_DEVSET1_OCP_MASK		(BIT(5) | BIT(6))
+#define MAX20730_MFR_DEVSET1_FSW_MASK		GENMASK(4, 2)
+#define MAX20730_MFR_DEVSET1_TSTAT_MASK		(BIT(0) | BIT(1))
+
+#define MAX20730_MFR_DEVSET1_RGAIN_BIT_POS	13
+#define MAX20730_MFR_DEVSET1_OTP_BIT_POS	11
+#define MAX20730_MFR_DEVSET1_VBOOT_BIT_POS	8
+#define MAX20730_MFR_DEVSET1_OCP_BIT_POS	5
+#define MAX20730_MFR_DEVSET1_FSW_BIT_POS	2
+#define MAX20730_MFR_DEVSET1_TSTAT_BIT_POS	0
+
+#define MAX20730_MFR_DEVSET2_IMAX_MASK		GENMASK(10, 8)
+#define MAX20730_MFR_DEVSET2_VRATE			(BIT(6) | BIT(7))
+#define MAX20730_MFR_DEVSET2_OCPM_MASK		BIT(5)
+#define MAX20730_MFR_DEVSET2_SS_MASK		(BIT(0) | BIT(1))
+
+#define MAX20730_MFR_DEVSET2_IMAX_BIT_POS	8
+#define MAX20730_MFR_DEVSET2_VRATE_BIT_POS	6
+#define MAX20730_MFR_DEVSET2_OCPM_BIT_POS	5
+#define MAX20730_MFR_DEVSET2_SS_BIT_POS		0
+
+#define DEBUG_FS_DATA_MAX					8
+
+struct max20730_debugfs_data {
+	struct i2c_client *client;
+	int debugfs_entries[MAX20730_DEBUGFS_NUM_ENTRIES];
+};
+
+#define to_psu(x, y) container_of((x), \
+			struct max20730_debugfs_data, debugfs_entries[(y)])
+
+static ssize_t max20730_debugfs_read(struct file *file, char __user *buf,
+				      size_t count, loff_t *ppos)
+{
+	int ret, len;
+	int *idxp =3D file->private_data;
+	int idx =3D *idxp;
+	struct max20730_debugfs_data *psu =3D to_psu(idxp, idx);
+	const struct pmbus_driver_info *info;
+	const struct max20730_data *data;
+	char tbuf[DEBUG_FS_DATA_MAX + 2] =3D { 0 };
+	u16 val;
+
+	info =3D pmbus_get_driver_info(psu->client);
+	data =3D to_max20730_data(info);
+
+	switch (idx) {
+	case MAX20730_DEBUGFS_VOUT_MIN:
+		len =3D snprintf(tbuf, 5, "%d", data->mfr_voutmin);
+		break;
+	case MAX20730_DEBUGFS_FREQUENCY:
+		val =3D (data->mfr_devset1 & MAX20730_MFR_DEVSET1_FSW_MASK)
+			>> MAX20730_MFR_DEVSET1_FSW_BIT_POS;
+		if (val =3D=3D 0)
+			ret =3D 400;
+		else if (val =3D=3D 1)
+			ret =3D 500;
+		else if (val =3D=3D 2 || val =3D=3D 3)
+			ret =3D 600;
+		else if (val =3D=3D 4)
+			ret =3D 700;
+		else if (val =3D=3D 5)
+			ret =3D 800;
+		else
+			ret =3D 900;
+		len =3D snprintf(tbuf, 4, "%d", ret);
+		break;
+	case MAX20730_DEBUGFS_PG_DELAY:
+		val =3D (data->mfr_devset1 & MAX20730_MFR_DEVSET1_TSTAT_MASK)
+			>> MAX20730_MFR_DEVSET1_TSTAT_BIT_POS;
+
+		if (val =3D=3D 0)
+			strcpy(tbuf, "2000");
+		else if (val =3D=3D 1)
+			strcpy(tbuf, "125");
+		else if (val =3D=3D 2)
+			strcpy(tbuf, "62.5");
+		else
+			strcpy(tbuf, "32");
+		len =3D strnlen(tbuf, DEBUG_FS_DATA_MAX);
+		break;
+
+	case MAX20730_DEBUGFS_INTERNAL_GAIN:
+		val =3D (data->mfr_devset1 & MAX20730_MFR_DEVSET1_RGAIN_MASK)
+			>> MAX20730_MFR_DEVSET1_RGAIN_BIT_POS;
+
+		if (data->id =3D=3D max20734) {
+			/* AN6209 */
+			if (val =3D=3D 0)
+				strcpy(tbuf, "0.8");
+			else if (val =3D=3D 1)
+				strcpy(tbuf, "3.2");
+			else if (val =3D=3D 2)
+				strcpy(tbuf, "1.6");
+			else
+				strcpy(tbuf, "6.4");
+		} else if (data->id =3D=3D max20730 || data->id =3D=3D max20710) {
+			/* AN6042 or AN6140 */
+			if (val =3D=3D 0)
+				strcpy(tbuf, "0.9");
+			else if (val =3D=3D 1)
+				strcpy(tbuf, "3.6");
+			else if (val =3D=3D 2)
+				strcpy(tbuf, "1.8");
+			else
+				strcpy(tbuf, "7.2");
+		} else if (data->id =3D=3D max20743) {
+			/* AN6042 */
+			if (val =3D=3D 0)
+				strcpy(tbuf, "0.45");
+			else if (val =3D=3D 1)
+				strcpy(tbuf, "1.8");
+			else if (val =3D=3D 2)
+				strcpy(tbuf, "0.9");
+			else
+				strcpy(tbuf, "3.6");
+		} else
+			return -EINVAL;
+
+		len =3D strnlen(tbuf, DEBUG_FS_DATA_MAX);
+		break;
+	case MAX20730_DEBUGFS_BOOT_VOLTAGE:
+		val =3D (data->mfr_devset1 & MAX20730_MFR_DEVSET1_VBOOT_MASK)
+			>> MAX20730_MFR_DEVSET1_VBOOT_BIT_POS;
+
+		if (val =3D=3D 0)
+			strcpy(tbuf, "0.6484");
+		else if (val =3D=3D 1)
+			strcpy(tbuf, "0.8984");
+		else if (val =3D=3D 2)
+			strcpy(tbuf, "1.0");
+		else
+			return -EINVAL;
+
+		len =3D strnlen(tbuf, DEBUG_FS_DATA_MAX);
+		break;
+	case MAX20730_DEBUGFS_OUT_V_RAMP_RATE:
+		val =3D (data->mfr_devset2 & MAX20730_MFR_DEVSET2_VRATE)
+			>> MAX20730_MFR_DEVSET2_VRATE_BIT_POS;
+
+		if (val =3D=3D 0)
+			ret =3D 4;
+		else if (val =3D=3D 1)
+			ret =3D 2;
+		else if (val =3D=3D 2)
+			ret =3D 1;
+		else
+			return -EINVAL;
+
+		len =3D snprintf(tbuf, 2, "%d", ret);
+		break;
+	case MAX20730_DEBUGFS_OC_PROTECT_MODE:
+		ret =3D (data->mfr_devset2 & MAX20730_MFR_DEVSET2_OCPM_MASK)
+			>> MAX20730_MFR_DEVSET2_OCPM_BIT_POS;
+		len =3D snprintf(tbuf, 2, "%d", ret);
+		break;
+	case MAX20730_DEBUGFS_SS_TIMING:
+		val =3D (data->mfr_devset2 & MAX20730_MFR_DEVSET2_SS_MASK)
+			>> MAX20730_MFR_DEVSET2_SS_BIT_POS;
+
+		if (val =3D=3D 0)
+			strcpy(tbuf, "0.75");
+		else if (val =3D=3D 1)
+			strcpy(tbuf, "1.5");
+		else if (val =3D=3D 2)
+			strcpy(tbuf, "3");
+		else
+			strcpy(tbuf, "6");
+
+		len =3D strnlen(tbuf, DEBUG_FS_DATA_MAX);
+		break;
+	case MAX20730_DEBUGFS_IMAX:
+		ret =3D (data->mfr_devset2 & MAX20730_MFR_DEVSET2_IMAX_MASK)
+			>> MAX20730_MFR_DEVSET2_IMAX_BIT_POS;
+		len =3D snprintf(tbuf, 2, "%d", ret);
+		break;
+	case MAX20730_DEBUGFS_OPERATION:
+		ret =3D i2c_smbus_read_byte_data(psu->client, PMBUS_OPERATION);
+		if(ret < 0)
+			return ret;
+		len =3D snprintf(tbuf, 2, "%d", ret);
+		break;
+	case MAX20730_DEBUGFS_ON_OFF_CONFIG:
+		ret =3D i2c_smbus_read_byte_data(psu->client, PMBUS_ON_OFF_CONFIG);
+		if(ret < 0)
+			return ret;
+		len =3D snprintf(tbuf, 2, "%d", ret);
+		break;
+	case MAX20730_DEBUGFS_SMBALERT_MASK:
+		ret =3D i2c_smbus_read_word_data(psu->client,=20
+							PMBUS_SMB_ALERT_MASK);
+		if(ret < 0)
+			return ret;
+		len =3D snprintf(tbuf, 3, "%d", ret);
+		break;
+	case MAX20730_DEBUGFS_VOUT_MODE:
+		ret =3D i2c_smbus_read_byte_data(psu->client, PMBUS_VOUT_MODE);
+		if(ret < 0)
+			return ret;
+		len =3D snprintf(tbuf, 2, "%d", ret);
+		break;
+	case MAX20730_DEBUGFS_VOUT_COMMAND:
+		ret =3D i2c_smbus_read_word_data(psu->client, PMBUS_VOUT_COMMAND);
+		if(ret < 0)
+			return ret;
+		len =3D snprintf(tbuf, 3, "%d", ret);
+		break;
+	case MAX20730_DEBUGFS_VOUT_MAX:
+		ret =3D i2c_smbus_read_word_data(psu->client, PMBUS_VOUT_MAX);
+		if(ret < 0)
+			return ret;
+		len =3D snprintf(tbuf, 3, "%d", ret);
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	tbuf[len] =3D '\n';
+	len +=3D 2;
+
+	return simple_read_from_buffer(buf, count, ppos, tbuf, len);
+}
+
+static const struct file_operations max20730_fops =3D {
+	.llseek =3D noop_llseek,
+	.read =3D max20730_debugfs_read,
+	.write =3D NULL,
+	.open =3D simple_open,
+};
=20
 /*
  * Convert discreet value to direct data format. Strictly speaking, all pa=
ssed
@@ -80,6 +344,7 @@ static long direct_to_val(u16 w, enum pmbus_sensor_class=
es class,
 }
=20
 static u32 max_current[][5] =3D {
+	[max20710] =3D { 6200, 8000, 9700, 11600 },
 	[max20730] =3D { 13000, 16600, 20100, 23600 },
 	[max20734] =3D { 21000, 27000, 32000, 38000 },
 	[max20743] =3D { 18900, 24100, 29200, 34100 },
@@ -164,6 +429,45 @@ static int max20730_write_word_data(struct i2c_client =
*client, int page,
 }
=20
 static const struct pmbus_driver_info max20730_info[] =3D {
+	[max20710] =3D {
+		.pages =3D 1,
+		.read_word_data =3D max20730_read_word_data,
+		.write_word_data =3D max20730_write_word_data,
+
+		/* Source : Maxim AN6140 and AN6042 */
+		.format[PSC_TEMPERATURE] =3D direct,
+		.m[PSC_TEMPERATURE] =3D 21,
+		.b[PSC_TEMPERATURE] =3D 5887,
+		.R[PSC_TEMPERATURE] =3D -1,
+
+		.format[PSC_VOLTAGE_IN] =3D direct,
+		.m[PSC_VOLTAGE_IN] =3D 3609,
+		.b[PSC_VOLTAGE_IN] =3D 0,
+		.R[PSC_VOLTAGE_IN] =3D -2,
+
+		/*
+		 * Values in the datasheet are adjusted for temperature and
+		 * for the relationship between Vin and Vout.
+		 * Unfortunately, the data sheet suggests that Vout measurement
+		 * may be scaled with a resistor array. This is indeed the case
+		 * at least on the evaulation boards. As a result, any in-driver
+		 * adjustments would either be wrong or require elaborate means
+		 * to configure the scaling. Instead of doing that, just report
+		 * raw values and let userspace handle adjustments.
+		 */
+		.format[PSC_CURRENT_OUT] =3D direct,
+		.m[PSC_CURRENT_OUT] =3D 153,
+		.b[PSC_CURRENT_OUT] =3D 4976,
+		.R[PSC_CURRENT_OUT] =3D -1,
+
+		.format[PSC_VOLTAGE_OUT] =3D linear,
+
+		.func[0] =3D PMBUS_HAVE_VIN |
+			PMBUS_HAVE_VOUT | PMBUS_HAVE_STATUS_VOUT |
+			PMBUS_HAVE_IOUT | PMBUS_HAVE_STATUS_IOUT |
+			PMBUS_HAVE_TEMP | PMBUS_HAVE_STATUS_TEMP |
+			PMBUS_HAVE_STATUS_INPUT,
+	},
 	[max20730] =3D {
 		.pages =3D 1,
 		.read_word_data =3D max20730_read_word_data,
@@ -200,7 +504,8 @@ static const struct pmbus_driver_info max20730_info[] =
=3D {
 		.func[0] =3D PMBUS_HAVE_VIN |
 			PMBUS_HAVE_VOUT | PMBUS_HAVE_STATUS_VOUT |
 			PMBUS_HAVE_IOUT | PMBUS_HAVE_STATUS_IOUT |
-			PMBUS_HAVE_TEMP | PMBUS_HAVE_STATUS_TEMP,
+			PMBUS_HAVE_TEMP | PMBUS_HAVE_STATUS_TEMP |
+			PMBUS_HAVE_STATUS_INPUT,
 	},
 	[max20734] =3D {
 		.pages =3D 1,
@@ -228,7 +533,8 @@ static const struct pmbus_driver_info max20730_info[] =
=3D {
 		.func[0] =3D PMBUS_HAVE_VIN |
 			PMBUS_HAVE_VOUT | PMBUS_HAVE_STATUS_VOUT |
 			PMBUS_HAVE_IOUT | PMBUS_HAVE_STATUS_IOUT |
-			PMBUS_HAVE_TEMP | PMBUS_HAVE_STATUS_TEMP,
+			PMBUS_HAVE_TEMP | PMBUS_HAVE_STATUS_TEMP |
+			PMBUS_HAVE_STATUS_INPUT,
 	},
 	[max20743] =3D {
 		.pages =3D 1,
@@ -256,7 +562,8 @@ static const struct pmbus_driver_info max20730_info[] =
=3D {
 		.func[0] =3D PMBUS_HAVE_VIN |
 			PMBUS_HAVE_VOUT | PMBUS_HAVE_STATUS_VOUT |
 			PMBUS_HAVE_IOUT | PMBUS_HAVE_STATUS_IOUT |
-			PMBUS_HAVE_TEMP | PMBUS_HAVE_STATUS_TEMP,
+			PMBUS_HAVE_TEMP | PMBUS_HAVE_STATUS_TEMP |
+			PMBUS_HAVE_STATUS_INPUT,
 	},
 };
=20
@@ -267,14 +574,17 @@ static int max20730_probe(struct i2c_client *client,
 	u8 buf[I2C_SMBUS_BLOCK_MAX + 1];
 	struct max20730_data *data;
 	enum chips chip_id;
-	int ret;
+	int i, ret;
+	struct dentry *debugfs;
+	struct dentry *max20730_dir;
+	struct max20730_debugfs_data *psu;
=20
 	if (!i2c_check_functionality(client->adapter,
 				     I2C_FUNC_SMBUS_READ_BYTE_DATA |
 				     I2C_FUNC_SMBUS_READ_WORD_DATA |
 				     I2C_FUNC_SMBUS_BLOCK_DATA))
 		return -ENODEV;
-
+=09
 	ret =3D i2c_smbus_read_block_data(client, PMBUS_MFR_ID, buf);
 	if (ret < 0) {
 		dev_err(&client->dev, "Failed to read Manufacturer ID\n");
@@ -335,10 +645,93 @@ static int max20730_probe(struct i2c_client *client,
 		return ret;
 	data->mfr_devset1 =3D ret;
=20
-	return pmbus_do_probe(client, id, &data->info);
+	ret =3D pmbus_do_probe(client, id, &data->info);
+	if (ret < 0)
+		return ret;
+
+#if IS_ENABLED(CONFIG_DEBUG_FS)
+	ret =3D i2c_smbus_read_word_data(client, MAX20730_MFR_DEVSET2);
+	if (ret < 0)
+		return ret;
+	data->mfr_devset2 =3D ret;
+
+	ret =3D i2c_smbus_read_word_data(client, MAX20730_MFR_VOUT_MIN);
+	if (ret < 0)
+		return ret;
+	data->mfr_voutmin =3D ret;
+
+	/*
+	 * Don't fail the probe if there isn't enough memory for debugfs.
+	 */
+	psu =3D devm_kzalloc(&client->dev, sizeof(*psu), GFP_KERNEL);
+	if (!psu)
+		return 0;
+	psu->client =3D client;
+
+	/* Don't fail the probe if we can't create debugfs */
+	debugfs =3D pmbus_get_debugfs_dir(client);
+	if (!debugfs)
+		return 0;
+
+	max20730_dir =3D debugfs_create_dir(client->name, debugfs);
+	if (!max20730_dir)
+		return 0;
+
+	for (i =3D 0; i < MAX20730_DEBUGFS_NUM_ENTRIES; ++i)
+		psu->debugfs_entries[i] =3D i;
+
+	debugfs_create_file("vout_min", 0444, max20730_dir,
+			    &psu->debugfs_entries[MAX20730_DEBUGFS_VOUT_MIN],
+			    &max20730_fops);
+	debugfs_create_file("frequency", 0444, max20730_dir,
+			    &psu->debugfs_entries[MAX20730_DEBUGFS_FREQUENCY],
+			    &max20730_fops);
+	debugfs_create_file("power_good_delay", 0444, max20730_dir,
+			    &psu->debugfs_entries[MAX20730_DEBUGFS_PG_DELAY],
+			    &max20730_fops);
+	debugfs_create_file("internal_gain", 0444, max20730_dir,
+			    &psu->debugfs_entries[MAX20730_DEBUGFS_INTERNAL_GAIN],
+			    &max20730_fops);
+	debugfs_create_file("boot_voltage", 0444, max20730_dir,
+			    &psu->debugfs_entries[MAX20730_DEBUGFS_BOOT_VOLTAGE],
+			    &max20730_fops);
+	debugfs_create_file("out_voltage_ramp_rate", 0444, max20730_dir,
+			    &psu->debugfs_entries[MAX20730_DEBUGFS_OUT_V_RAMP_RATE],
+			    &max20730_fops);
+	debugfs_create_file("oc_protection_mode", 0444, max20730_dir,
+			    &psu->debugfs_entries[MAX20730_DEBUGFS_OC_PROTECT_MODE],
+			    &max20730_fops);
+	debugfs_create_file("soft_start_timing", 0444, max20730_dir,
+			    &psu->debugfs_entries[MAX20730_DEBUGFS_SS_TIMING],
+			    &max20730_fops);
+	debugfs_create_file("imax", 0444, max20730_dir,
+			    &psu->debugfs_entries[MAX20730_DEBUGFS_IMAX],
+			    &max20730_fops);	   =20
+	debugfs_create_file("operation", 0444, max20730_dir,
+			    &psu->debugfs_entries[MAX20730_DEBUGFS_OPERATION],
+			    &max20730_fops);
+	debugfs_create_file("on_off_config", 0444, max20730_dir,
+			    &psu->debugfs_entries[MAX20730_DEBUGFS_ON_OFF_CONFIG],
+			    &max20730_fops);
+	debugfs_create_file("smbalert_mask", 0444, max20730_dir,
+			    &psu->debugfs_entries[MAX20730_DEBUGFS_SMBALERT_MASK],
+			    &max20730_fops);
+	debugfs_create_file("vout_mode", 0444, max20730_dir,
+			    &psu->debugfs_entries[MAX20730_DEBUGFS_VOUT_MODE],
+			    &max20730_fops);
+	debugfs_create_file("vout_command", 0444, max20730_dir,
+			    &psu->debugfs_entries[MAX20730_DEBUGFS_VOUT_COMMAND],
+			    &max20730_fops);
+	debugfs_create_file("vout_max", 0444, max20730_dir,
+			    &psu->debugfs_entries[MAX20730_DEBUGFS_VOUT_MAX],
+			    &max20730_fops);
+#endif
+=09
+	return 0;
 }
=20
 static const struct i2c_device_id max20730_id[] =3D {
+	{ "max20710", max20710 },
 	{ "max20730", max20730 },
 	{ "max20734", max20734 },
 	{ "max20743", max20743 },
@@ -348,6 +741,7 @@ static const struct i2c_device_id max20730_id[] =3D {
 MODULE_DEVICE_TABLE(i2c, max20730_id);
=20
 static const struct of_device_id max20730_of_match[] =3D {
+	{ .compatible =3D "maxim,max20710", .data =3D (void *)max20710 },
 	{ .compatible =3D "maxim,max20730", .data =3D (void *)max20730 },
 	{ .compatible =3D "maxim,max20734", .data =3D (void *)max20734 },
 	{ .compatible =3D "maxim,max20743", .data =3D (void *)max20743 },
@@ -369,5 +763,5 @@ static struct i2c_driver max20730_driver =3D {
 module_i2c_driver(max20730_driver);
=20
 MODULE_AUTHOR("Guenter Roeck <linux@roeck-us.net>");
-MODULE_DESCRIPTION("PMBus driver for Maxim MAX20730 / MAX20734 / MAX20743"=
);
+MODULE_DESCRIPTION("PMBus driver for Maxim MAX20710 / MAX20730 / MAX20734 =
/ MAX20743");
 MODULE_LICENSE("GPL");
--=20
2.7.4

