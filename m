Return-Path: <SRS0=EowN=3M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64C2FC33CB6
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jan 2020 03:15:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3167020718
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jan 2020 03:15:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cocYB9oH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726234AbgAWDPC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Jan 2020 22:15:02 -0500
Received: from mail-pl1-f194.google.com ([209.85.214.194]:34497 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725911AbgAWDPC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jan 2020 22:15:02 -0500
Received: by mail-pl1-f194.google.com with SMTP id q13so3329pls.1;
        Wed, 22 Jan 2020 19:15:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id;
        bh=J7I2Z1NWcAMqFEh8AjlsKjCecBGABZ9IrDTfQaXNNHs=;
        b=cocYB9oHoR6Hg/7wjUTRBLa30I/niLOB2ppj1R8Gidq2Jecd7eGPK2tMvM8TOKHBzH
         8dfTq3RY2S0zZIE1IJy6Ds1OBpiG/N9y6RcGprREfdbpTwb9AejidPN4kV6ZbecBiiVt
         6thn5gEmZPDfIZgnFDotsKbWk7cCUJVKjt/+ZO2TMBTt9VFlKy65CwLSjiU5CCSYqVBH
         Dir6KNE+lMMdxYLyyKWK/NbdJEap9JQM2/31SINIWU+PEez2GIziQaOFImVX3qtdLiC+
         k3khUk+uRnMyfVuZAPgNlRi4OdSNhaJkN/KcI5af9lF7x/Oh2fzbXDunfm7Dbumj3SR8
         oK/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id;
        bh=J7I2Z1NWcAMqFEh8AjlsKjCecBGABZ9IrDTfQaXNNHs=;
        b=r38ABx1CJqxJYbJ8aaebK50nCPx9IwdmghPJhDBXtW9iEQ3mjE5Svgc0XX2/Xu+bY7
         zRDwjOkFeaOubuIvMGmQLct9/O08Gs7QO711uAtcdF7jomu0CLr6loAV2zwOriMu19/a
         NEZA2NMboOGyHj9id44WE174V30i2Lc4YiXNvOjmtrUtKBqUtVXZRdO8cqEkpA4SMhZa
         OwbkYJamQidtGiWqL8VGXCW6kOv0W9WmYEt2erSBVHqU+J8tkUt0/dGahq749Jn8lv0Q
         qHbQh6M2fdV/5b4R0zbyaNuxBnzVse9PrLSziAsTBVnuFYmAoxhIWA6sSE8QYN1SQ8kp
         UN+Q==
X-Gm-Message-State: APjAAAVxnVa5Yqej5EntTtqcPSXWoiQZR272IGEgsjOOtTRhy2GVfkE9
        ikR2BJlnNGB08pqRktbAyBRXLiDs
X-Google-Smtp-Source: APXvYqyakPrHDkuUTIBp5C2VdyAMAGO8FCyYxVXbpzA9gmtkrWtN5AJyG8Wnrn/MUaQO2lj4UF1fMw==
X-Received: by 2002:a17:90a:98d:: with SMTP id 13mr2071820pjo.102.1579749300694;
        Wed, 22 Jan 2020 19:15:00 -0800 (PST)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id w131sm346088pfc.16.2020.01.22.19.14.59
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 22 Jan 2020 19:14:59 -0800 (PST)
From:   Guenter Roeck <linux@roeck-us.net>
To:     linux-hwmon@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, Clemens Ladisch <clemens@ladisch.de>,
        Jean Delvare <jdelvare@suse.com>,
        =?UTF-8?q?Ondrej=20=C4=8Cerman?= <ocerman@sda1.eu>,
        Michael Larabel <michael@phoronix.com>,
        Guenter Roeck <linux@roeck-us.net>
Subject: [RFT PATCH] hwmon: (k10temp) Display up to seven sets of CCD temperatures
Date:   Wed, 22 Jan 2020 19:14:51 -0800
Message-Id: <20200123031451.30320-1-linux@roeck-us.net>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In HWiNFO, we see support for Tccd1, Tccd3, Tccd5, and Tccd7 temperature
sensors on Zen2 based Threadripper CPUs. Checking register maps on
Threadripper 3970X confirms SMN register addresses and values for those
sensors.

Register values observed in an idle system:

0x059950: 00000000 00000abc 00000000 00000ad8
0x059960: 00000000 00000ade 00000000 00000ae4

Under load:

0x059950: 00000000 00000c02 00000000 00000c14
0x059960: 00000000 00000c30 00000000 00000c22

On top of that, in thm_10_0_sh_mask.h in the Linux kernel, we find
definitions for THM_DIE{1-3}_TEMP__VALID_MASK, set to 0x00000800, as well
as matching SMN addresses. This lets us conclude that bit 11 of the
respective registers is a valid bit. With this assumption, the temperature
offset is now 49 degrees C. This conveniently matches the documented
temperature offset for Tdie, again suggesting that above registers indeed
report temperatures sensor values. Assume that bit 11 is indeed a valid
bit, and add support for the additional sensors.

Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
This patch applies on top of the previous set of k10temp patches.

 drivers/hwmon/k10temp.c | 56 +++++++++++++++++------------------------
 1 file changed, 23 insertions(+), 33 deletions(-)

diff --git a/drivers/hwmon/k10temp.c b/drivers/hwmon/k10temp.c
index 5e3f43594084..95eb6ea9f3f3 100644
--- a/drivers/hwmon/k10temp.c
+++ b/drivers/hwmon/k10temp.c
@@ -80,8 +80,10 @@ static DEFINE_MUTEX(nb_smu_ind_mutex);
 
 /* F17h M01h Access througn SMN */
 #define F17H_M01H_REPORTED_TEMP_CTRL_OFFSET	0x00059800
-#define F17H_M70H_CCD1_TEMP			0x00059954
-#define F17H_M70H_CCD2_TEMP			0x00059958
+
+#define F17H_M70H_CCD_TEMP(x)			(0x00059954 + ((x) * 4))
+#define F17H_M70H_CCD_TEMP_VALID		BIT(11)
+#define F17H_M70H_CCD_TEMP_MASK			GENMASK(10, 0)
 
 #define F17H_M01H_SVI				0x0005A000
 #define F17H_M01H_SVI_TEL_PLANE0		(F17H_M01H_SVI + 0xc)
@@ -100,8 +102,7 @@ struct k10temp_data {
 	int temp_offset;
 	u32 temp_adjust_mask;
 	bool show_tdie;
-	bool show_tccd1;
-	bool show_tccd2;
+	u32 show_tccd;
 	u32 svi_addr[2];
 	bool show_current;
 	int cfactor[2];
@@ -188,6 +189,11 @@ const char *k10temp_temp_label[] = {
 	"Tctl",
 	"Tccd1",
 	"Tccd2",
+	"Tccd3",
+	"Tccd4",
+	"Tccd5",
+	"Tccd6",
+	"Tccd7",
 };
 
 const char *k10temp_in_label[] = {
@@ -277,15 +283,10 @@ static int k10temp_read_temp(struct device *dev, u32 attr, int channel,
 			if (*val < 0)
 				*val = 0;
 			break;
-		case 2:		/* Tccd1 */
-			amd_smn_read(amd_pci_dev_to_node_id(data->pdev),
-				     F17H_M70H_CCD1_TEMP, &regval);
-			*val = (regval & 0xfff) * 125 - 305000;
-			break;
-		case 3:		/* Tccd2 */
+		case 2 ... 8:		/* Tccd{1-7} */
 			amd_smn_read(amd_pci_dev_to_node_id(data->pdev),
-				     F17H_M70H_CCD2_TEMP, &regval);
-			*val = (regval & 0xfff) * 125 - 305000;
+				     F17H_M70H_CCD_TEMP(channel - 2), &regval);
+			*val = (regval & F17H_M70H_CCD_TEMP_MASK) * 125 - 49000;
 			break;
 		default:
 			return -EOPNOTSUPP;
@@ -343,12 +344,8 @@ static umode_t k10temp_is_visible(const void *_data,
 				if (!data->show_tdie)
 					return 0;
 				break;
-			case 2:		/* Tccd1 */
-				if (!data->show_tccd1)
-					return 0;
-				break;
-			case 3:		/* Tccd2 */
-				if (!data->show_tccd2)
+			case 2 ... 8:		/* Tccd{1-7} */
+				if (!(data->show_tccd & BIT(channel - 2)))
 					return 0;
 				break;
 			default:
@@ -382,12 +379,8 @@ static umode_t k10temp_is_visible(const void *_data,
 			case 0:		/* Tdie */
 			case 1:		/* Tctl */
 				break;
-			case 2:		/* Tccd1 */
-				if (!data->show_tccd1)
-					return 0;
-				break;
-			case 3:		/* Tccd2 */
-				if (!data->show_tccd2)
+			case 2 ... 8:		/* Tccd{1-7} */
+				if (!(data->show_tccd & BIT(channel - 2)))
 					return 0;
 				break;
 			default:
@@ -595,15 +588,12 @@ static int k10temp_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 			data->cfactor[1] = CFACTOR_ISOC;
 			data->svi_addr[0] = F17H_M01H_SVI_TEL_PLANE1;
 			data->svi_addr[1] = F17H_M01H_SVI_TEL_PLANE0;
-			amd_smn_read(amd_pci_dev_to_node_id(pdev),
-				     F17H_M70H_CCD1_TEMP, &regval);
-			if (regval & 0xfff)
-				data->show_tccd1 = true;
-
-			amd_smn_read(amd_pci_dev_to_node_id(pdev),
-				     F17H_M70H_CCD2_TEMP, &regval);
-			if (regval & 0xfff)
-				data->show_tccd2 = true;
+			for (i = 0; i < 7; i++) {
+				amd_smn_read(amd_pci_dev_to_node_id(pdev),
+					     F17H_M70H_CCD_TEMP(i), &regval);
+				if (regval & F17H_M70H_CCD_TEMP_VALID)
+					data->show_tccd |= BIT(i);
+			}
 			break;
 		}
 	} else {
-- 
2.17.1

