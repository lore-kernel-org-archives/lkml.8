Return-Path: <SRS0=kGB5=CE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A26DFC433E1
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Aug 2020 21:06:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 488F420737
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Aug 2020 21:06:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=maximintegrated.onmicrosoft.com header.i=@maximintegrated.onmicrosoft.com header.b="Hl/L0hHp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726790AbgHZVGN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Aug 2020 17:06:13 -0400
Received: from mail-eopbgr770090.outbound.protection.outlook.com ([40.107.77.90]:2438
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726739AbgHZVGK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Aug 2020 17:06:10 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oNPTZUuplNjQufHD7Ycb26X3HZprVh3fpI5yh+axcUh8lr0qVd9euKKOOiN/WQUBHlYQgEZMXMs7rLl6qaGCPGmWweCWfC8cLjKuV9IJOJxNHknW5EmBKLvBbtHdv1lQPa+AIgua1KZEL4ZiIxWNeRQC/E7+Xg140vmYXzHx8OZ4rx5AtLGJyPGTVc9n99FW+ktBv5P4+AuKcWrlJfe5G3vahBAQX+9gXdlPhPIspkJXUfQJABOs3sVW/4g/Jy862Xv7A3FDYkKGzlVsUQ7Sv8UB8h7pGUszRvJQ7Gp1Gy4oRr8dCOATFZ6Lpujvxnq631p+x7GKhPOI/SjbHlgozg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ik5EpJAtZbFGT16VF8CwVv1P2wZMvyYdAMcJicWsgIw=;
 b=OytSWOAs5ciQKLGnEHD1fXUv+Ea6YxAo1BEeD7qWBfKCJM75msenBqjczPX+Z99JfvLghE3fcXrbFXj3m7y7Mh+b/yiPBzm7SeWuVAi9e/sodU9rW19v0XUjWRVUFOXdCAdHyiaWeNYJZ908fRATTgtlxcKIN0GDruLpCOVXwVqOEhQtOWUju3B8ykzaIL+ZqwkuB3d6/ttyk/SziWWIKLBBgC0egwA+GxCB9LUSdsYMHL0V/yLz0tnX7ddnEAewlqxAkVGX1l61QCXCf31vYCODr18U8+VhvjDa80L491vbYDF1k2RWAIpRlkCBJo99EAFHDP7MnmST7ldxey+oXQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=maximintegrated.com; dmarc=pass action=none
 header.from=maximintegrated.com; dkim=pass header.d=maximintegrated.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=maximintegrated.onmicrosoft.com;
 s=selector2-maximintegrated-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ik5EpJAtZbFGT16VF8CwVv1P2wZMvyYdAMcJicWsgIw=;
 b=Hl/L0hHpNGpNy382sFqnkOmYf28p1mAKGyzPmJ9uh7+mxphshjKqqoXa0P5Ob4cVH93uBo+mWaAo9yTX5iWPMeIVv9vDRw2R1muJ6Pk4k+2HMHqx9bDCFSoZlgPRpC+RyWGKmkxmTPZO4Vu107DIoT/qZG62qOR/M4imvhkMBOk=
Received: from MWHPR11MB1965.namprd11.prod.outlook.com (2603:10b6:300:110::15)
 by MWHPR11MB1294.namprd11.prod.outlook.com (2603:10b6:300:2a::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3305.26; Wed, 26 Aug
 2020 21:06:04 +0000
Received: from MWHPR11MB1965.namprd11.prod.outlook.com
 ([fe80::249b:cc2:bbd2:31a6]) by MWHPR11MB1965.namprd11.prod.outlook.com
 ([fe80::249b:cc2:bbd2:31a6%4]) with mapi id 15.20.3326.019; Wed, 26 Aug 2020
 21:06:04 +0000
From:   Ugur Usug <Ugur.Usug@maximintegrated.com>
To:     Guenter Roeck <linux@roeck-us.net>
CC:     "linux-hwmon@vger.kernel.org" <linux-hwmon@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: [PATCH v2] hwmon (pmbus/max20730): add device monitoring via debugfs
Thread-Topic: [PATCH v2] hwmon (pmbus/max20730): add device monitoring via
 debugfs
Thread-Index: AdZ77Eqitxw+pOS/TGevaSX2YS5X5A==
Date:   Wed, 26 Aug 2020 21:06:04 +0000
Message-ID: <MWHPR11MB19659276002CE27A5E36DAD2FD540@MWHPR11MB1965.namprd11.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: roeck-us.net; dkim=none (message not signed)
 header.d=none;roeck-us.net; dmarc=none action=none
 header.from=maximintegrated.com;
x-originating-ip: [159.146.48.54]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 95bbe51b-3b5b-4b1e-9e62-08d84a03d802
x-ms-traffictypediagnostic: MWHPR11MB1294:
x-microsoft-antispam-prvs: <MWHPR11MB1294D3A08A7332BCBC82B2BEFD540@MWHPR11MB1294.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:551;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: GfVrACpNjb5vtrswCTL/Yb4Rji77qm0s4LBcZyl4UxX/iOmtXSDLbzUXwEjqP1MUYYnsQcuGDlKJ4XbnPnBzrdxT1pcpsssXRWJ8KdJBG5tNuxc3OvgjN66S/vbBpGTHeuIMGSiUrTjoxfyXQee3Lq79dAh7kDbF6KJolDoW+PVgX+QqOjY7zWDDZ9wEjbezdQWt+pWzxeA6rdlJY+A/r9K5yMSOd4SRLgzQYrt91JfKyK7fXN6FNql5tB8csQXPmuJaJB3yV0mpwpcW2RjAfbIZPe7kZfKIXn0W9Bhces0WmfjRbk6KFFaVctiMXlPjxpOk8Lwh7yrVL88METm4Jg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR11MB1965.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(396003)(39860400002)(366004)(376002)(346002)(136003)(33656002)(54906003)(66946007)(64756008)(66446008)(66556008)(9686003)(66476007)(30864003)(26005)(52536014)(71200400001)(86362001)(316002)(6916009)(478600001)(5660300002)(76116006)(2906002)(6506007)(186003)(7696005)(83380400001)(8936002)(8676002)(4326008)(55016002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: UWwWS05ufinknbPIolokD4FfotsRqZdLLPuciRkKdxl+AAi1yKoDojH3KOIz3SmrkpWgRYUMgOAmKQVy95lD53Gyb6wufQaQSSqFiXsBTD3YcaZcyBF2nU51VMWxMM8Iy0b4nJ0+mDFym/jnJtA8Bwx9kVgQ/JXmQVX7M46q7vjVtHZlo+Pgeo7EX4UATJRqyNcuLf+uJueNuiMuz4g9XQTxmT+HQt/suv9Symg6FDjWW7eO4wpFORV4FQ5/hxfeLQn2+myhqfuTQySp/z7g9bP+yZjoiLZVD/fMqW6udsK3sxVM9R2t97HB85+WFyBJBbISX0RNZe4dIZhYRMr2p7LXdPngl2cYmxzYebH6OO6ookDg3zYm0y8CJ4ztnMW83iZjEQx3K/WAUgwT22Y8zy13C4nuOlnHYJ3vmYCGCUv35I0nPCTFvaUEW+0934wnyi/ylE657jN+K0NEPFPcvi19ldRQtJ/8kxZ+nG0B61muzjvJiFU0TQabxQ7vxbpT4r2XPP3+Rm0FTC062EbjOBhDSV3TfD7qd0KoxNL5YD7eTxjW2Rsd3yelo96nom66HwuI3KghmzKf/DWnXXxTzOwuVdCJodNCrStqdQUZoT9sbypxoqyG/8LwtMUeTyXRYjzueIgfKPcN8DSabD71fg==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: maximintegrated.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MWHPR11MB1965.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 95bbe51b-3b5b-4b1e-9e62-08d84a03d802
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Aug 2020 21:06:04.1073
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: fbd909df-ea69-4788-a554-f24b7854ad03
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: w/8jVb6AVZkHjGPczxmlotLzPZrwgRlkpEeacmQrPtSoZK8sRiAj9bKBeZaxi6FUvUmSgOewCb9YOoUnXcK/gMsMH6uGO3T5gepTkLLFnDk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR11MB1294
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add debugfs interface support for accessing device specific registers (MFR_=
VOUT_MIN, MFR_DEVSET1 and MFR_DEVSET2) and others including OPERATION, ON_O=
FF_CONFIG, SMB_ALERT_MASK, VOUT_MODE, VOUT_COMMAND and VOUT_MAX.

Signed-off-by: Ugur Usug <ugur.usug@maximintegrated.com>
---
 drivers/hwmon/pmbus/max20730.c | 364 +++++++++++++++++++++++++++++++++++++=
+++-
 1 file changed, 363 insertions(+), 1 deletion(-)

diff --git a/drivers/hwmon/pmbus/max20730.c b/drivers/hwmon/pmbus/max20730.=
c
index a151a2b..aa5e2be 100644
--- a/drivers/hwmon/pmbus/max20730.c
+++ b/drivers/hwmon/pmbus/max20730.c
@@ -8,6 +8,7 @@
  */
=20
 #include <linux/bits.h>
+#include <linux/debugfs.h>
 #include <linux/err.h>
 #include <linux/i2c.h>
 #include <linux/init.h>
@@ -26,16 +27,368 @@ enum chips {
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
+#define MAX20730_MFR_VOUT_MIN_MASK		GENMASK(9, 0)
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
+#define MAX20730_MFR_DEVSET2_VRATE		(BIT(6) | BIT(7))
+#define MAX20730_MFR_DEVSET2_OCPM_MASK		BIT(5)
+#define MAX20730_MFR_DEVSET2_SS_MASK		(BIT(0) | BIT(1))
+
+#define MAX20730_MFR_DEVSET2_IMAX_BIT_POS	8
+#define MAX20730_MFR_DEVSET2_VRATE_BIT_POS	6
+#define MAX20730_MFR_DEVSET2_OCPM_BIT_POS	5
+#define MAX20730_MFR_DEVSET2_SS_BIT_POS		0
+
+#define DEBUG_FS_DATA_MAX			8
+
+struct max20730_debugfs_data {
+	struct i2c_client *client;
+	int debugfs_entries[MAX20730_DEBUGFS_NUM_ENTRIES];
+};
+
+#define to_psu(x, y) container_of((x), \
+			struct max20730_debugfs_data, debugfs_entries[(y)])
+
+#ifdef CONFIG_DEBUG_FS
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
+		if (ret < 0)
+			return ret;
+		len =3D snprintf(tbuf, 2, "%d", ret);
+		break;
+	case MAX20730_DEBUGFS_ON_OFF_CONFIG:
+		ret =3D i2c_smbus_read_byte_data(psu->client, PMBUS_ON_OFF_CONFIG);
+		if (ret < 0)
+			return ret;
+		len =3D snprintf(tbuf, 2, "%d", ret);
+		break;
+	case MAX20730_DEBUGFS_SMBALERT_MASK:
+		ret =3D i2c_smbus_read_word_data(psu->client,
+							PMBUS_SMB_ALERT_MASK);
+		if (ret < 0)
+			return ret;
+		len =3D snprintf(tbuf, 3, "%d", ret);
+		break;
+	case MAX20730_DEBUGFS_VOUT_MODE:
+		ret =3D i2c_smbus_read_byte_data(psu->client, PMBUS_VOUT_MODE);
+		if (ret < 0)
+			return ret;
+		len =3D snprintf(tbuf, 2, "%d", ret);
+		break;
+	case MAX20730_DEBUGFS_VOUT_COMMAND:
+		ret =3D i2c_smbus_read_word_data(psu->client, PMBUS_VOUT_COMMAND);
+		if (ret < 0)
+			return ret;
+		len =3D snprintf(tbuf, 3, "%d", ret);
+		break;
+	case MAX20730_DEBUGFS_VOUT_MAX:
+		ret =3D i2c_smbus_read_word_data(psu->client, PMBUS_VOUT_MAX);
+		if (ret < 0)
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
+
+static int max20730_init_debugfs(struct i2c_client *client,
+				struct max20730_data *data)
+{
+	int ret, i;
+	struct dentry *debugfs;
+	struct dentry *max20730_dir;
+	struct max20730_debugfs_data *psu;
+
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
+	psu =3D devm_kzalloc(&client->dev, sizeof(*psu), GFP_KERNEL);
+	if (!psu)
+		return -ENOMEM;
+	psu->client =3D client;
+
+	debugfs =3D pmbus_get_debugfs_dir(client);
+	if (!debugfs)
+		return -ENOENT;
+
+	max20730_dir =3D debugfs_create_dir(client->name, debugfs);
+	if (!max20730_dir)
+		return -ENOENT;
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
+			    &max20730_fops);
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
+
+	return 0;
+}
+#else
+static int max20730_init_debugfs(struct i2c_client *client,
+				struct max20730_data *data)
+{
+	return 0;
+}
+#endif /* CONFIG_DEBUG_FS */
=20
 /*
  * Convert discreet value to direct data format. Strictly speaking, all pa=
ssed
@@ -370,7 +723,16 @@ static int max20730_probe(struct i2c_client *client,
 		return ret;
 	data->mfr_devset1 =3D ret;
=20
-	return pmbus_do_probe(client, id, &data->info);
+	ret =3D pmbus_do_probe(client, id, &data->info);
+	if (ret < 0)
+		return ret;
+
+	ret =3D max20730_init_debugfs(client, data);
+	if (ret)
+		dev_warn(dev, "Failed to register debugfs: %d\n",
+			 ret);
+
+	return 0;
 }
=20
 static const struct i2c_device_id max20730_id[] =3D {
--=20
2.7.4
