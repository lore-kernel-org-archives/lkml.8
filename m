Return-Path: <SRS0=EowN=3M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36C90C33CB6
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jan 2020 14:20:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0366520718
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jan 2020 14:20:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MA8qtukD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729058AbgAWOUc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Jan 2020 09:20:32 -0500
Received: from mail-pj1-f66.google.com ([209.85.216.66]:38612 "EHLO
        mail-pj1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727235AbgAWOUb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jan 2020 09:20:31 -0500
Received: by mail-pj1-f66.google.com with SMTP id l35so1371667pje.3;
        Thu, 23 Jan 2020 06:20:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id;
        bh=RBoBUzf7ht2wdUJX9bAGZc+dzOz86GZTBPndzLg7K2U=;
        b=MA8qtukDdMaF028dH/9anWxCg0EN8298/9ETFYmnUyyQhLl3U0MtfEtdAGilXW07Vv
         hqnRv17JbbfAIblu6BKESVxON/fikW1wPqI3jsxbDbY3Ru3uL3mNNCDsTY8y9vd+P1Tk
         6UZgL305gE/ThZdSQjjrz6W8Pc0ODd4H1JwPtZHhNc4Q1MA/l9mnDaBHf6SSDAS4N1la
         CJj1CjXJCFWtHNmyz6qIMnGsPgJSrrQia3sGmMi+9VrxeG2az/yGee93Do/FOXO98XQa
         QuWDF9byE+j5yqjNX6qM/l2Va6uPLxatWYKAqpSEwwtRbCeDiYlDpwpsxS0KRweaQ6xI
         halA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id;
        bh=RBoBUzf7ht2wdUJX9bAGZc+dzOz86GZTBPndzLg7K2U=;
        b=fJEg/aqJX0F9mqEhb3a2I5sCS4y0TcieBQLZOD3bG0lwBevnXaZXPnUig7uS0O20eC
         xc01Y6NJN+y+80YGPL8Uy0w5E7vf7d8dSNiTonlLdwlFiLELuVoBNfEsIzPXPqS+7hJ/
         DUrAIbJ2NU0IKYiok5/kCuogW2RFxKfNXFrtLmAOS4bwvybdMt+WMiXOFZbtdrIFQMtI
         rndF/oCWVeFSzmZPY0lOhWZjg78WO3EDX5+Hb3N3q90MuavYigZl8xkD+/ahwxdbLbRH
         BmuKP1qVwYZbaWP4gqleQgfk6Zd6HxJIeN3PSzfs/a9Dak9ZWaI/GgG3QWxY9hfco2CW
         EyuA==
X-Gm-Message-State: APjAAAXlJEVQugdcIbKbugL1cY4nPWmoiSWHZdJ2SztBQ1pbTIVnuFI4
        +5vP8gbwtOsYvF9AQ18CDZ7FWiGR
X-Google-Smtp-Source: APXvYqzyPEPxHfTQyQl01TH5dfJPCvhQdYzPzToAUOBC4J2+U73856+hQtidg4hGHyKSLyxT9Zf3ng==
X-Received: by 2002:a17:902:7b89:: with SMTP id w9mr16905600pll.46.1579789230135;
        Thu, 23 Jan 2020 06:20:30 -0800 (PST)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id 6sm3190545pgh.0.2020.01.23.06.20.29
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 23 Jan 2020 06:20:29 -0800 (PST)
From:   Guenter Roeck <linux@roeck-us.net>
To:     linux-hwmon@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, Clemens Ladisch <clemens@ladisch.de>,
        Jean Delvare <jdelvare@suse.com>,
        =?UTF-8?q?Ondrej=20=C4=8Cerman?= <ocerman@sda1.eu>,
        Michael Larabel <michael@phoronix.com>,
        Guenter Roeck <linux@roeck-us.net>
Subject: [RFT PATCH v2] hwmon: (k10temp) Display up to seven sets of CCD temperatures
Date:   Thu, 23 Jan 2020 06:20:19 -0800
Message-Id: <20200123142019.16491-1-linux@roeck-us.net>
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
v2: Add additional sensors to k10temp_info[].

 drivers/hwmon/k10temp.c | 61 +++++++++++++++++++----------------------
 1 file changed, 28 insertions(+), 33 deletions(-)

diff --git a/drivers/hwmon/k10temp.c b/drivers/hwmon/k10temp.c
index 5e3f43594084..9497f71ca05d 100644
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
@@ -520,6 +513,11 @@ static const struct hwmon_channel_info *k10temp_info[] = {
 			   HWMON_T_LABEL,
 			   HWMON_T_INPUT | HWMON_T_LABEL,
 			   HWMON_T_INPUT | HWMON_T_LABEL,
+			   HWMON_T_INPUT | HWMON_T_LABEL,
+			   HWMON_T_INPUT | HWMON_T_LABEL,
+			   HWMON_T_INPUT | HWMON_T_LABEL,
+			   HWMON_T_INPUT | HWMON_T_LABEL,
+			   HWMON_T_INPUT | HWMON_T_LABEL,
 			   HWMON_T_INPUT | HWMON_T_LABEL),
 	HWMON_CHANNEL_INFO(in,
 			   HWMON_I_INPUT | HWMON_I_LABEL,
@@ -595,15 +593,12 @@ static int k10temp_probe(struct pci_dev *pdev, const struct pci_device_id *id)
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

