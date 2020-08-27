Return-Path: <SRS0=OCv1=CF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.4 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,RCVD_ILLEGAL_IP,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5BB4C433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Aug 2020 05:42:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 99C4E2078A
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Aug 2020 05:42:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="veC7DOz5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726967AbgH0Fmz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Aug 2020 01:42:55 -0400
Received: from mail-eopbgr680079.outbound.protection.outlook.com ([40.107.68.79]:30854
        "EHLO NAM04-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726070AbgH0Fmy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Aug 2020 01:42:54 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=afHQMzliNRiLbw5e2IeqYBX6HR0d/cUe6+iDwDnk/YOzS81e51gyOEHKfbz2DCfiIxPx8kx1UjvwkglCdkL1pVVwptJ0losuLY+bDJo8pW41pJGX1ZjOSipqLf3a0xnHOwhMbOOBak4jRozd9ObdpG8X9IxOeXfz1oLbsUvExZu3r28AOKZwPux5TO2yudLXFVh6LONDQAz4lxo5namZfIZCujJvEmixpVIlx9dCn9OnhCsGNbMqd75SpIJ69kwZSrs0ujdqLK1VfSJfjqhrslR5mIjoLqIMHncmyryyui13aBTqRjqwo9yYozK4sfJlf/Cu/o5URMzv3ciDibkMjA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+AAqdnjDmr4DmQ/J00++mzDgR3p/fc41wMePGuFDggU=;
 b=L7XzVWPkN+2g5ylWU7ySAfAjpQtIL8JD8IHRzqq08EJX6cI6oWIWyuvYSGS/QYs8gc3DP9NbIvxNqaoEAXhWY8VSvxRbTSa6gYymvOvlO6PGvVyDSTiMSNGcngHu9mqtHkn6s4rJ6+VREQdZF/sL8LQfh4/vMxXTzAaBPlEG2q33YbzHvoJS2Mqrof5v2xDkeihhNdWuQctcmM1vuPzKS5EJbWdn5d1KA1/6Hz5qiQaBVAcBHszZpYFVfcO9yDoldgU31ejv+e3EPuiifZp3yJHpN/Q3JwE1J3aBrBquS5jWVb9/lmOOdAtSWY2UG0Fyrq+3D9Er0xJ9viB6urqtoA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+AAqdnjDmr4DmQ/J00++mzDgR3p/fc41wMePGuFDggU=;
 b=veC7DOz5Ft8T4oi7+xgAzR9FuGCYFG7LYOZkQCi94NyQY05IJ8CfsGXpMxVAVJU1+xhDOLPaL1LGu1XXt26sbbu5z9kdkmrUOJVxc+Np1/ycFfZ3TOoQoHaJL/hJt5p7940L7Y6/1/zJhEMsV2IiHDnmAkCSQ7jraiWUIFOZpg4=
Authentication-Results: ladisch.de; dkim=none (message not signed)
 header.d=none;ladisch.de; dmarc=none action=none header.from=amd.com;
Received: from CY4PR12MB1494.namprd12.prod.outlook.com (2603:10b6:910:f::22)
 by CY4PR12MB1224.namprd12.prod.outlook.com (2603:10b6:903:39::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3305.26; Thu, 27 Aug
 2020 05:42:49 +0000
Received: from CY4PR12MB1494.namprd12.prod.outlook.com
 ([fe80::f873:6fc3:45c4:2106]) by CY4PR12MB1494.namprd12.prod.outlook.com
 ([fe80::f873:6fc3:45c4:2106%12]) with mapi id 15.20.3305.032; Thu, 27 Aug
 2020 05:42:49 +0000
From:   Wei Huang <wei.huang2@amd.com>
To:     lemens@ladisch.de
Cc:     jdelvare@suse.com, linux@roeck-us.net, linux-hwmon@vger.kernel.org,
        linux-kernel@vger.kernel.org, wei.huang2@amd.com
Subject: [PATCH 1/2] hwmon: (k10temp) Create common functions and macros for Zen CPU families
Date:   Thu, 27 Aug 2020 00:42:41 -0500
Message-Id: <20200827054242.2347-1-wei.huang2@amd.com>
X-Mailer: git-send-email 2.25.2
Content-Transfer-Encoding: 7bit
Content-Type: text/plain
X-ClientProxiedBy: SN4PR0601CA0013.namprd06.prod.outlook.com
 (2603:10b6:803:2f::23) To CY4PR12MB1494.namprd12.prod.outlook.com
 (2603:10b6:910:f::22)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from 255.255.255.255 (255.255.255.255) by SN4PR0601CA0013.namprd06.prod.outlook.com (2603:10b6:803:2f::23) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3326.19 via Frontend Transport; Thu, 27 Aug 2020 05:42:48 +0000
X-Mailer: git-send-email 2.25.2
X-Originating-IP: [165.204.78.2]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: d2524eea-afe1-4b84-3e79-08d84a4c084b
X-MS-TrafficTypeDiagnostic: CY4PR12MB1224:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <CY4PR12MB12246AA5A84C82BD98227185CF550@CY4PR12MB1224.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:202;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: XVSmJ7wExyjZV4xbLjHfZ3x4lp0ES5/M+GLdidz84rmy8OMJokgOy9OyLJIabgPKB2aqwP+nNYwR+gm6XQ80R9PMPtXj2/lze6k8Ox/5uP2tJlK6isn080rditHfQDcUxasC2AOD3g8/hxCGgNdfand0vYJQuMsaQcQHhMHanD8HnpLN0rjdPrdcbrcgOyiME7KRf6osGx2f5W7KbwTfacBKEPz4orSLQZ6ZLOjUURGhThJhdubF7UDrTSLzxEMtOoJwnBKTd8LnAbx6JZWmuPQHMR8f1vPLEJ4AEg1NFknuhhhnGDRSfiQ76uri3PrkIib+UlcuNKORV/oOIzFuVA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY4PR12MB1494.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(39860400002)(396003)(376002)(136003)(346002)(66476007)(6916009)(66946007)(66556008)(1076003)(2906002)(478600001)(8936002)(4326008)(8676002)(5660300002)(16576012)(186003)(6486002)(36756003)(52116002)(316002)(26005)(2616005)(83380400001)(6666004)(86362001)(956004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: HH3uoj6uYFQOYAk8g37h6LbQONpbchjf21DF+fMvcTtYK8krDYiiXWgTJ/YukdWgg42ElquuXgBonA5KjL4ePqx4gXJIS2zBsWpvFyVkL7OEFP7Zf2o6BI7kp6bSQgElNBeEWDZPwt/lkG8qOI3TY94Be77+uMFzkga6WYbzcpILp05wE5AZsmYjlEmSkxTLAn4lnyNEM79mh9ksa+u2yKSNgfl34i2dKC4zbibGjrrs0gQ3UFDoLmvoydozzzcsBarhwL9Iz0uluLgk3GlRC1BqahmJKJAB+//9+TQRwWnJ9LiWT7+i+3tbgQER2EY36ZDRHg4hppAWYkjP02S8k6MLe9DK5SUEEZ16m2NFmRip1b6KbwDpLy+ljONbY9nsHPmefK0QXvNIrS21BABWmwjKOtB4CEW91yv8te3bOGuWIK0aflYUunHBF7M616GmQuPsfpQoCtKq2YfJStIIrL3g6Sl/acQ7D1gIyMxCy45zQVjCPpU24C/M/5Y8Rcx38T45pahBG0PsGEJAe5gHFtvujUwvMGo5xj29ovbILQuvucVRbJiThYlGF3N63b4F51YNNWNjgN+Oyvg03ykXMg0KevHUYr1nOeEQ3eKGAANOae/SYdar/3G9SfZkmF+hdVJUafte652faaemwNv8LQ==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d2524eea-afe1-4b84-3e79-08d84a4c084b
X-MS-Exchange-CrossTenant-AuthSource: CY4PR12MB1494.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Aug 2020 05:42:49.3212
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: z4DIpv0v8gMKXBGgM/DLm8z2Lyh6tsJ4+ZscmApn0M0LkoxQzDwmUVLp25S5WUN4
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR12MB1224
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Many SMN thermal registers in Zen CPU families are common across different
generations. For long-term code maintenance, it is better to rename these
macro and function names to Zen.

Signed-off-by: Wei Huang <wei.huang2@amd.com>
---
 drivers/hwmon/k10temp.c | 56 +++++++++++++++++++++--------------------
 1 file changed, 29 insertions(+), 27 deletions(-)

diff --git a/drivers/hwmon/k10temp.c b/drivers/hwmon/k10temp.c
index 8f12995ec133..f3addb97b021 100644
--- a/drivers/hwmon/k10temp.c
+++ b/drivers/hwmon/k10temp.c
@@ -73,22 +73,24 @@ static DEFINE_MUTEX(nb_smu_ind_mutex);
 #define F15H_M60H_HARDWARE_TEMP_CTRL_OFFSET	0xd8200c64
 #define F15H_M60H_REPORTED_TEMP_CTRL_OFFSET	0xd8200ca4
 
-/* F17h M01h Access througn SMN */
-#define F17H_M01H_REPORTED_TEMP_CTRL_OFFSET	0x00059800
+/* Common for Zen CPU families (Family 17h and 18h) */
+#define ZEN_REPORTED_TEMP_CTRL_OFFSET		0x00059800
 
-#define F17H_M70H_CCD_TEMP(x)			(0x00059954 + ((x) * 4))
-#define F17H_M70H_CCD_TEMP_VALID		BIT(11)
-#define F17H_M70H_CCD_TEMP_MASK			GENMASK(10, 0)
+#define ZEN_CCD_TEMP(x)				(0x00059954 + ((x) * 4))
+#define ZEN_CCD_TEMP_VALID			BIT(11)
+#define ZEN_CCD_TEMP_MASK			GENMASK(10, 0)
 
-#define F17H_M01H_SVI				0x0005A000
-#define F17H_M01H_SVI_TEL_PLANE0		(F17H_M01H_SVI + 0xc)
-#define F17H_M01H_SVI_TEL_PLANE1		(F17H_M01H_SVI + 0x10)
+#define ZEN_CUR_TEMP_SHIFT			21
+#define ZEN_CUR_TEMP_RANGE_SEL_MASK		BIT(19)
 
-#define CUR_TEMP_SHIFT				21
-#define CUR_TEMP_RANGE_SEL_MASK			BIT(19)
+#define ZEN_SVI_BASE				0x0005A000
 
-#define CFACTOR_ICORE				1000000	/* 1A / LSB	*/
-#define CFACTOR_ISOC				250000	/* 0.25A / LSB	*/
+/* F17h thermal registers through SMN */
+#define F17H_M01H_SVI_TEL_PLANE0		(ZEN_SVI_BASE + 0xc)
+#define F17H_M01H_SVI_TEL_PLANE1		(ZEN_SVI_BASE + 0x10)
+
+#define F17H_CFACTOR_ICORE			1000000	/* 1A / LSB	*/
+#define F17H_CFACTOR_ISOC			250000	/* 0.25A / LSB	*/
 
 struct k10temp_data {
 	struct pci_dev *pdev;
@@ -168,10 +170,10 @@ static void read_tempreg_nb_f15(struct pci_dev *pdev, u32 *regval)
 			  F15H_M60H_REPORTED_TEMP_CTRL_OFFSET, regval);
 }
 
-static void read_tempreg_nb_f17(struct pci_dev *pdev, u32 *regval)
+static void read_tempreg_nb_zen(struct pci_dev *pdev, u32 *regval)
 {
 	amd_smn_read(amd_pci_dev_to_node_id(pdev),
-		     F17H_M01H_REPORTED_TEMP_CTRL_OFFSET, regval);
+		     ZEN_REPORTED_TEMP_CTRL_OFFSET, regval);
 }
 
 static long get_raw_temp(struct k10temp_data *data)
@@ -180,7 +182,7 @@ static long get_raw_temp(struct k10temp_data *data)
 	long temp;
 
 	data->read_tempreg(data->pdev, &regval);
-	temp = (regval >> CUR_TEMP_SHIFT) * 125;
+	temp = (regval >> ZEN_CUR_TEMP_SHIFT) * 125;
 	if (regval & data->temp_adjust_mask)
 		temp -= 49000;
 	return temp;
@@ -288,8 +290,8 @@ static int k10temp_read_temp(struct device *dev, u32 attr, int channel,
 			break;
 		case 2 ... 9:		/* Tccd{1-8} */
 			amd_smn_read(amd_pci_dev_to_node_id(data->pdev),
-				     F17H_M70H_CCD_TEMP(channel - 2), &regval);
-			*val = (regval & F17H_M70H_CCD_TEMP_MASK) * 125 - 49000;
+				     ZEN_CCD_TEMP(channel - 2), &regval);
+			*val = (regval & ZEN_CCD_TEMP_MASK) * 125 - 49000;
 			break;
 		default:
 			return -EOPNOTSUPP;
@@ -438,7 +440,7 @@ static int svi_show(struct seq_file *s, void *unused)
 {
 	struct k10temp_data *data = s->private;
 
-	k10temp_smn_regs_show(s, data->pdev, F17H_M01H_SVI, 32);
+	k10temp_smn_regs_show(s, data->pdev, ZEN_SVI_BASE, 32);
 	return 0;
 }
 DEFINE_SHOW_ATTRIBUTE(svi);
@@ -448,7 +450,7 @@ static int thm_show(struct seq_file *s, void *unused)
 	struct k10temp_data *data = s->private;
 
 	k10temp_smn_regs_show(s, data->pdev,
-			      F17H_M01H_REPORTED_TEMP_CTRL_OFFSET, 256);
+			      ZEN_REPORTED_TEMP_CTRL_OFFSET, 256);
 	return 0;
 }
 DEFINE_SHOW_ATTRIBUTE(thm);
@@ -528,8 +530,8 @@ static void k10temp_get_ccd_support(struct pci_dev *pdev,
 
 	for (i = 0; i < limit; i++) {
 		amd_smn_read(amd_pci_dev_to_node_id(pdev),
-			     F17H_M70H_CCD_TEMP(i), &regval);
-		if (regval & F17H_M70H_CCD_TEMP_VALID)
+			     ZEN_CCD_TEMP(i), &regval);
+		if (regval & ZEN_CCD_TEMP_VALID)
 			data->show_temp |= BIT(TCCD_BIT(i));
 	}
 }
@@ -565,8 +567,8 @@ static int k10temp_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 		data->read_htcreg = read_htcreg_nb_f15;
 		data->read_tempreg = read_tempreg_nb_f15;
 	} else if (boot_cpu_data.x86 == 0x17 || boot_cpu_data.x86 == 0x18) {
-		data->temp_adjust_mask = CUR_TEMP_RANGE_SEL_MASK;
-		data->read_tempreg = read_tempreg_nb_f17;
+		data->temp_adjust_mask = ZEN_CUR_TEMP_RANGE_SEL_MASK;
+		data->read_tempreg = read_tempreg_nb_zen;
 		data->show_temp |= BIT(TDIE_BIT);	/* show Tdie */
 		data->is_zen = true;
 
@@ -578,15 +580,15 @@ static int k10temp_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 			data->show_current = !is_threadripper() && !is_epyc();
 			data->svi_addr[0] = F17H_M01H_SVI_TEL_PLANE0;
 			data->svi_addr[1] = F17H_M01H_SVI_TEL_PLANE1;
-			data->cfactor[0] = CFACTOR_ICORE;
-			data->cfactor[1] = CFACTOR_ISOC;
+			data->cfactor[0] = F17H_CFACTOR_ICORE;
+			data->cfactor[1] = F17H_CFACTOR_ISOC;
 			k10temp_get_ccd_support(pdev, data, 4);
 			break;
 		case 0x31:	/* Zen2 Threadripper */
 		case 0x71:	/* Zen2 */
 			data->show_current = !is_threadripper() && !is_epyc();
-			data->cfactor[0] = CFACTOR_ICORE;
-			data->cfactor[1] = CFACTOR_ISOC;
+			data->cfactor[0] = F17H_CFACTOR_ICORE;
+			data->cfactor[1] = F17H_CFACTOR_ISOC;
 			data->svi_addr[0] = F17H_M01H_SVI_TEL_PLANE1;
 			data->svi_addr[1] = F17H_M01H_SVI_TEL_PLANE0;
 			k10temp_get_ccd_support(pdev, data, 8);
-- 
2.25.2

