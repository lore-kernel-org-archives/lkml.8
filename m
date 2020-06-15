Return-Path: <SRS0=PJcK=74=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DEB51C433E1
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jun 2020 23:59:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B597A206D8
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jun 2020 23:59:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=maximintegrated.onmicrosoft.com header.i=@maximintegrated.onmicrosoft.com header.b="BocDCpD2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726819AbgFOX72 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Jun 2020 19:59:28 -0400
Received: from mail-bn8nam12on2110.outbound.protection.outlook.com ([40.107.237.110]:28485
        "EHLO NAM12-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725960AbgFOX70 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Jun 2020 19:59:26 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SB0Ufd1Qq7I09xwFT39fxf6kJxKNCpJznhLy5gSfp4b3Ap/6wb4OT4ZspLwnUVv5R4k9nVT4ZTu9el60p0cAfiMi279agHihuTPHUCNf7lX2NNShseVFNB8g/ILHQejvrBgzVDwP7iVhxo+8Q/wZCb0MEQFfEhF51IL7NfgCmv8HC1b8Hq5GhyJIGFRaEcevTqKkurHI1glx/R4XeXfo+3vYw6siiucZkGh0HzLCv7Xsu3rz4FYcf85a7hyVxvATDzsTAtYJScXAjlzG942OzcpkEdhStVd+bVX+Luk9GNYXzbYN1Px8CEbZIoWHHoorGdGFAFrOLfC9gQ3qeLbsHA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UTMU+D2FHHND0JbaeAo3YZ9wNkyaItv1ec34QcYQA5M=;
 b=i9PKF1PnBVoZ89hRmn/yDOPdHp7LkkMs91rHfK1Q4ubwxYl+c6yiTvci3d+MRvzAnPN0u2t+VhHJuNShmNiOGzP+I7qXed56+Lafv8rip69mg+nGjqlpxZRq50KJtFIak++9v4R4IS8jGgp/xyMYLv8zsr5WWwnGInOnBEyeGdUMdajO2KC1Q9HpR6rHKnGZTpBbVvaY11YrguX8JKeAMcEwALSHX4QaX1s8XmrL44cFnxpn8zNe1zqj5hB8q+lvByPPdV62bWlnAIwx/Hx/4y/jSGS/NN2zFLqNmiNyFrr9AMUL6H8XWFp6BTMxl1ur612OrkIZJ5fz0Z3+wNBCkw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=maximintegrated.com; dmarc=pass action=none
 header.from=maximintegrated.com; dkim=pass header.d=maximintegrated.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=maximintegrated.onmicrosoft.com;
 s=selector2-maximintegrated-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UTMU+D2FHHND0JbaeAo3YZ9wNkyaItv1ec34QcYQA5M=;
 b=BocDCpD2sAFaC12p3zQC0zfleFouXKk3UiLIxxS3XZ9v2EfjN8hrxGls4JbkUqrANOgh6fCGi1JCb06F351vDWl/wYxuluqhQCxavYYKmZqXboyntI5G7tbTIxFjWadYijz+wFQpbRjnP38Tvou6kvNElHva1kh4PMARI0dgeB4=
Received: from BYAPR11MB3174.namprd11.prod.outlook.com (2603:10b6:a03:76::27)
 by BYAPR11MB2949.namprd11.prod.outlook.com (2603:10b6:a03:81::32) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3088.25; Mon, 15 Jun
 2020 23:59:20 +0000
Received: from BYAPR11MB3174.namprd11.prod.outlook.com
 ([fe80::35af:2a57:ade8:101f]) by BYAPR11MB3174.namprd11.prod.outlook.com
 ([fe80::35af:2a57:ade8:101f%4]) with mapi id 15.20.3088.029; Mon, 15 Jun 2020
 23:59:20 +0000
From:   Ugur Usug <Ugur.Usug@maximintegrated.com>
To:     Guenter Roeck <linux@roeck-us.net>
CC:     "linux-hwmon@vger.kernel.org" <linux-hwmon@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: [PATCH 2/2] hwmon (pmbus/max20730): add register access via debugfs
Thread-Topic: [PATCH 2/2] hwmon (pmbus/max20730): add register access via
 debugfs
Thread-Index: AdZDcKXhaLF5PT14Q3aCKswk3KXAZg==
Date:   Mon, 15 Jun 2020 23:59:20 +0000
Message-ID: <BYAPR11MB31740655E59B63B3F644396CFD9C0@BYAPR11MB3174.namprd11.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: roeck-us.net; dkim=none (message not signed)
 header.d=none;roeck-us.net; dmarc=none action=none
 header.from=maximintegrated.com;
x-originating-ip: [159.146.48.12]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 733dbd31-33f2-4ffd-c5d2-08d811881ee2
x-ms-traffictypediagnostic: BYAPR11MB2949:
x-microsoft-antispam-prvs: <BYAPR11MB2949DE209B240412007D103AFD9C0@BYAPR11MB2949.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1303;
x-forefront-prvs: 04359FAD81
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: z0tHrFCNzf92gdmBpiHHabIDbA4+Zh69UPCCstte3kKK8QQnjqgYkzjA58aKmDt66Wkiz76oWxplp4Ou+1lFJWWBl3GeOWRvjkpsvBSnbxPb90x7oiOSSy4geDMiZRAaurM+CH4R+Ks6LUXwJWtChEv1B7vBWcEVvwzvPDLTs+lAPBLaH+1Gs6iLytMIC+XQesfMgGlpPukAB8JDwL/DgYl1ej0MEAxFbEg1N3SoNyRotIaVWrDVj6OVAo3t8Tfa2Y1wM7eNc6dkbct0IUPdePHO8ijIeIErzDl8tLi6t7mPXyWUfcN53+kS8LhGQpos5azvpt6rg7TMeZGOH91O+A==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR11MB3174.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(366004)(136003)(376002)(396003)(346002)(39860400002)(316002)(76116006)(6506007)(26005)(55016002)(8676002)(66476007)(86362001)(9686003)(66946007)(71200400001)(83380400001)(66446008)(66556008)(33656002)(8936002)(64756008)(7696005)(30864003)(52536014)(6916009)(2906002)(5660300002)(478600001)(186003)(54906003)(4326008);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: cxzTckAvY9MkNM5BEpcPi51pIjO3JjDxJLzMFhA7JDtjTVKJ8IfXfE81jix7uputKHzZujY83gfWC/kyp8wKiMFOq8mdOsXbWPdqMoOT4LfYvP+yRD5jnlgXA5qLVLtTsw2ulGk1O30qUQvQzGj92dKVhh8mbQPZhxvxRDZgu4AQpsFF5GeN75indUknPnSUjVmYMI6sCNExQuOE95V3ttstKsNWNcFYWb6CAbkAvfGugSJR0hiSGSKX8MBkmao3quyJHsxdkl+XpcMa662Rs1kTiAZWnNw70kHK6PuxPhr6Gf//PPNEsr1/MgYhv6tQxpe/tH2kG0/gBsMoSahcT9ccwnND5Cu3yHdDV0IDIQEmp9WSnA/wmldt9r8NU60scZ/AXW6jDJkEWUrHnlSAcqw/AWduLo2KwdMZG927nCYxJtd0jTaPMQFL/WBGaPxveXMRpEtwHmzft3v8zhusVOFdaLrOdfBReQzePyl8WUuqPBwySYqqUZKJd/xYR58C
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: maximintegrated.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 733dbd31-33f2-4ffd-c5d2-08d811881ee2
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Jun 2020 23:59:20.3968
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: fbd909df-ea69-4788-a554-f24b7854ad03
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: r10KhObx5eTpV/BY28xUGN4L1rmSGDcExbV64AGqFC2voPTZLk5hOHutvL28DZ6ua8GlAb10hn8Qli9jmh+PUAyjWC/YqYKeae/Z6DnNxmI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR11MB2949
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add debugfs interface support for accessing device specific registers (MFR_=
VOUT_MIN, MFR_DEVSET1 and MFR_DEVSET2) and others including OPERATION, ON_O=
FF_CONFIG, SMB_ALERT_MASK, VOUT_MODE, VOUT_COMMAND and VOUT_MAX.

Signed-off-by: Ugur Usug <ugur.usug@maximintegrated.com>
---
 drivers/hwmon/pmbus/max20730.c | 346 +++++++++++++++++++++++++++++++++++++=
++++
 1 file changed, 346 insertions(+)

diff --git a/drivers/hwmon/pmbus/max20730.c b/drivers/hwmon/pmbus/max20730.=
c
index 3ddc19b..c995f4f 100644
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
@@ -26,16 +27,277 @@ enum chips {
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
@@ -303,6 +565,12 @@ static int max20730_probe(struct i2c_client *client,
 	struct max20730_data *data;
 	enum chips chip_id;
 	int ret;
+#if IS_ENABLED(CONFIG_DEBUG_FS)
+	int i;
+	struct dentry *debugfs;
+	struct dentry *max20730_dir;
+	struct max20730_debugfs_data *psu;
+#endif
=20
 	if (!i2c_check_functionality(client->adapter,
 				     I2C_FUNC_SMBUS_READ_BYTE_DATA |
@@ -373,6 +641,84 @@ static int max20730_probe(struct i2c_client *client,
 	ret =3D pmbus_do_probe(client, id, &data->info);
 	if (ret < 0)
 		return ret;
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
 =09
 	return 0;
 }
--=20
2.7.4
