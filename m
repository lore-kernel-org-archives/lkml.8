Return-Path: <SRS0=3tRb=3K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B68BAC32771
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jan 2020 02:30:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 83C8822522
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jan 2020 02:30:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CuN7tAkv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729099AbgAUCaq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Jan 2020 21:30:46 -0500
Received: from mail-pf1-f196.google.com ([209.85.210.196]:35732 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726890AbgAUCan (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jan 2020 21:30:43 -0500
Received: by mail-pf1-f196.google.com with SMTP id i23so682247pfo.2;
        Mon, 20 Jan 2020 18:30:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=VxnzGBrXJdc5++MOR2PqTgd6vfK8aKrNf+LXo8LzP7Q=;
        b=CuN7tAkvF69MjbBbO/7wkB6L/LvGQYHD5+0UK8jbCJWc+xDxOQnQFEY2QarMSr3RTZ
         rMEOKMoZv5eD22/AQsxDqxyqDwtRrZ/xzdAEPX9FurWrS1wR5kQuqnbFLgm+tNsAMuIp
         WWr1WHok7xVfg7jg7VKrm6uo9HvGySIuZEXLvCrwOnd5PmmmvsW2+vPyPH/l47r0I4NX
         p0GHf2m5qdI/sAjUNk4qwsSa8nbKTo5QYRM/CeZheQ71oXi8dbTpGD+8mIweiwLN8CS2
         JcCB5FpuzmBS3t8nv8T2acvRnAxTrp5ZJfUssHDCvC7i6Ike2XZVwq8ZQKrCQWzSp2su
         aQow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references;
        bh=VxnzGBrXJdc5++MOR2PqTgd6vfK8aKrNf+LXo8LzP7Q=;
        b=cx0E3v0mWBBl+0xfpJc0e/CGWi4yd2fxs3Iil1QzeNvXrhrSN92M0hDawjzx8ht/SQ
         FXZVk75DS9JoHn6pVqCB+NudvZHLmluBDt0ogs4/5r22/w9rytj3irVid2/sov4Ee6Cu
         F+bUWBMqIasH5buxboYI5ylLdZziTAyeGBFxM/P10svHpvbylfHuyfHQGFt+zTnE3wTR
         VUezxQPkZOreCiQX3YQwdkbk4y9ufhbsBHsJ1f7/EabJU8wh/LT1hVPV9+6rhJum4hdW
         AN5DgMgnW5AfpAsoAwY9UmXgWjcO7KaxPLwiVN93X7lsK/L1eKGA+CawEvm0sgVlnjPr
         QKzg==
X-Gm-Message-State: APjAAAVUL/E9uLksuKS0CUH6OZH/913OVb3ESUSmm5/Mh1xopco8Syo0
        C/XQK2IR9vAc8fqdfjiOxBw0kbbE
X-Google-Smtp-Source: APXvYqzSmaj2Dytxc2KGcbld/0cFQJlV4FAPUWc1PHXVqCkpgf32TwglJ+o/g4+mu7JGYZnFuvkm8Q==
X-Received: by 2002:a62:5214:: with SMTP id g20mr2197850pfb.101.1579573843040;
        Mon, 20 Jan 2020 18:30:43 -0800 (PST)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id y14sm40211391pfe.147.2020.01.20.18.30.39
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 20 Jan 2020 18:30:39 -0800 (PST)
From:   Guenter Roeck <linux@roeck-us.net>
To:     linux-hwmon@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, Clemens Ladisch <clemens@ladisch.de>,
        Jean Delvare <jdelvare@suse.com>,
        Brad Campbell <lists2009@fnarfbargle.com>,
        =?UTF-8?q?Ondrej=20=C4=8Cerman?= <ocerman@sda1.eu>,
        Bernhard Gebetsberger <bernhard.gebetsberger@gmx.at>,
        Holger Kiehl <Holger.Kiehl@dwd.de>,
        Michael Larabel <michael@phoronix.com>,
        Jonathan McDowell <noodles@earth.li>,
        Ken Moffat <zarniwhoop73@googlemail.com>,
        Sebastian Reichel <sebastian.reichel@collabora.com>,
        Darren Salt <devspam@moreofthesa.me.uk>,
        Guenter Roeck <linux@roeck-us.net>
Subject: [PATCH v3 3/5] hwmon: (k10temp) Report temperatures per CPU die
Date:   Mon, 20 Jan 2020 18:30:25 -0800
Message-Id: <20200121023027.2081-4-linux@roeck-us.net>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200121023027.2081-1-linux@roeck-us.net>
References: <20200121023027.2081-1-linux@roeck-us.net>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Zen2 reports reporting temperatures per CPU die (called Core Complex Dies,
or CCD, by AMD). Add support for it to the k10temp driver.

Tested-by: Brad Campbell <lists2009@fnarfbargle.com>
Tested-by: Bernhard Gebetsberger <bernhard.gebetsberger@gmx.at>
Tested-by: Holger Kiehl <holger.kiehl@dwd.de>
Tested-by: Michael Larabel <michael@phoronix.com>
Tested-by: Jonathan McDowell <noodles@earth.li>
Tested-by: Ken Moffat <zarniwhoop73@googlemail.com>
Tested-by: Darren Salt <devspam@moreofthesa.me.uk>
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
 drivers/hwmon/k10temp.c | 80 ++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 79 insertions(+), 1 deletion(-)

diff --git a/drivers/hwmon/k10temp.c b/drivers/hwmon/k10temp.c
index c45f6498a59b..0af096b061fa 100644
--- a/drivers/hwmon/k10temp.c
+++ b/drivers/hwmon/k10temp.c
@@ -5,6 +5,12 @@
  *
  * Copyright (c) 2009 Clemens Ladisch <clemens@ladisch.de>
  * Copyright (c) 2020 Guenter Roeck <linux@roeck-us.net>
+ *
+ * Implementation notes:
+ * - CCD1 and CCD2 register address information as well as the calculation to
+ *   convert raw register values is from https://github.com/ocerman/zenpower.
+ *   The information is not confirmed from chip datasheets, but experiments
+ *   suggest that it provides reasonable temperature values.
  */
 
 #include <linux/bitops.h>
@@ -61,6 +67,8 @@ static DEFINE_MUTEX(nb_smu_ind_mutex);
 
 /* F17h M01h Access througn SMN */
 #define F17H_M01H_REPORTED_TEMP_CTRL_OFFSET	0x00059800
+#define F17H_M70H_CCD1_TEMP			0x00059954
+#define F17H_M70H_CCD2_TEMP			0x00059958
 
 #define CUR_TEMP_SHIFT				21
 #define CUR_TEMP_RANGE_SEL_MASK			BIT(19)
@@ -72,6 +80,8 @@ struct k10temp_data {
 	int temp_offset;
 	u32 temp_adjust_mask;
 	bool show_tdie;
+	bool show_tccd1;
+	bool show_tccd2;
 };
 
 struct tctl_offset {
@@ -143,6 +153,8 @@ static long get_raw_temp(struct k10temp_data *data)
 const char *k10temp_temp_label[] = {
 	"Tdie",
 	"Tctl",
+	"Tccd1",
+	"Tccd2",
 };
 
 static int k10temp_read_labels(struct device *dev,
@@ -172,6 +184,16 @@ static int k10temp_read(struct device *dev, enum hwmon_sensor_types type,
 			if (*val < 0)
 				*val = 0;
 			break;
+		case 2:		/* Tccd1 */
+			amd_smn_read(amd_pci_dev_to_node_id(data->pdev),
+				     F17H_M70H_CCD1_TEMP, &regval);
+			*val = (regval & 0xfff) * 125 - 305000;
+			break;
+		case 3:		/* Tccd2 */
+			amd_smn_read(amd_pci_dev_to_node_id(data->pdev),
+				     F17H_M70H_CCD2_TEMP, &regval);
+			*val = (regval & 0xfff) * 125 - 305000;
+			break;
 		default:
 			return -EOPNOTSUPP;
 		}
@@ -206,8 +228,24 @@ static umode_t k10temp_is_visible(const void *_data,
 	case hwmon_temp:
 		switch (attr) {
 		case hwmon_temp_input:
-			if (channel && !data->show_tdie)
+			switch (channel) {
+			case 0:		/* Tdie, or Tctl if we don't show it */
+				break;
+			case 1:		/* Tctl */
+				if (!data->show_tdie)
+					return 0;
+				break;
+			case 2:		/* Tccd1 */
+				if (!data->show_tccd1)
+					return 0;
+				break;
+			case 3:		/* Tccd2 */
+				if (!data->show_tccd2)
+					return 0;
+				break;
+			default:
 				return 0;
+			}
 			break;
 		case hwmon_temp_max:
 			if (channel)
@@ -229,8 +267,24 @@ static umode_t k10temp_is_visible(const void *_data,
 				return 0;
 			break;
 		case hwmon_temp_label:
+			/* No labels if we don't show the die temperature */
 			if (!data->show_tdie)
 				return 0;
+			switch (channel) {
+			case 0:		/* Tdie */
+			case 1:		/* Tctl */
+				break;
+			case 2:		/* Tccd1 */
+				if (!data->show_tccd1)
+					return 0;
+				break;
+			case 3:		/* Tccd2 */
+				if (!data->show_tccd2)
+					return 0;
+				break;
+			default:
+				return 0;
+			}
 			break;
 		default:
 			return 0;
@@ -281,6 +335,8 @@ static const struct hwmon_channel_info *k10temp_info[] = {
 			   HWMON_T_INPUT | HWMON_T_MAX |
 			   HWMON_T_CRIT | HWMON_T_CRIT_HYST |
 			   HWMON_T_LABEL,
+			   HWMON_T_INPUT | HWMON_T_LABEL,
+			   HWMON_T_INPUT | HWMON_T_LABEL,
 			   HWMON_T_INPUT | HWMON_T_LABEL),
 	NULL
 };
@@ -326,9 +382,31 @@ static int k10temp_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 		data->read_htcreg = read_htcreg_nb_f15;
 		data->read_tempreg = read_tempreg_nb_f15;
 	} else if (boot_cpu_data.x86 == 0x17 || boot_cpu_data.x86 == 0x18) {
+		u32 regval;
+
 		data->temp_adjust_mask = CUR_TEMP_RANGE_SEL_MASK;
 		data->read_tempreg = read_tempreg_nb_f17;
 		data->show_tdie = true;
+
+		switch (boot_cpu_data.x86_model) {
+		case 0x1:	/* Zen */
+		case 0x8:	/* Zen+ */
+		case 0x11:	/* Zen APU */
+		case 0x18:	/* Zen+ APU */
+			break;
+		case 0x31:	/* Zen2 Threadripper */
+		case 0x71:	/* Zen2 */
+			amd_smn_read(amd_pci_dev_to_node_id(pdev),
+				     F17H_M70H_CCD1_TEMP, &regval);
+			if (regval & 0xfff)
+				data->show_tccd1 = true;
+
+			amd_smn_read(amd_pci_dev_to_node_id(pdev),
+				     F17H_M70H_CCD2_TEMP, &regval);
+			if (regval & 0xfff)
+				data->show_tccd2 = true;
+			break;
+		}
 	} else {
 		data->read_htcreg = read_htcreg_pci;
 		data->read_tempreg = read_tempreg_pci;
-- 
2.17.1

