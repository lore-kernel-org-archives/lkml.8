Return-Path: <SRS0=9JlO=3L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B51CAC2D0DB
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jan 2020 16:08:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7AF5724673
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jan 2020 16:08:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qxR1XMuT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729095AbgAVQIf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Jan 2020 11:08:35 -0500
Received: from mail-pl1-f196.google.com ([209.85.214.196]:37090 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728709AbgAVQIM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jan 2020 11:08:12 -0500
Received: by mail-pl1-f196.google.com with SMTP id c23so3205187plz.4;
        Wed, 22 Jan 2020 08:08:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=VxnzGBrXJdc5++MOR2PqTgd6vfK8aKrNf+LXo8LzP7Q=;
        b=qxR1XMuTLp+SYfGdNoCDzUDWY2LBbgQYgk6BKHo+yZqVB1gP1XGJyqQFTzyzw0A5Uj
         2ovBzdmFXhO5IDVRBLsmgRW7r6QVoSW/Zbizt65D6NHopegfWW8r66HKp/e9PY/RkCTp
         tfwLBuYZ3x+p3qfGkx6BgZXa4v8zbEWC2iR/Pdh2HlS1i8QXXD8CR98pSfyPEDlzOecV
         rSBe8TXJvEwnQYoMlml8yojC5AVD6K6nlDq34E/qv7shMP9I/7eyL24BCj4/jtRVXYqx
         VjGJ+aHRqSA//wuQe6+lADqD3AhoJHXbse3kUHJIaGUQsMVdeAecGZLI45+qJbt+uR7C
         4Lng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references;
        bh=VxnzGBrXJdc5++MOR2PqTgd6vfK8aKrNf+LXo8LzP7Q=;
        b=jPHrM0Ja7CFWBrodNKgGM7kNju/ZzOB9yS+6QY+7d7gAlqsUIBFtTYGhy7iFZKQ/NP
         NMcGdG23CNdaQwMUhj70LDX61EWAdU/fXXHIFhgyTiGeWnPw/BVn88U6IZtrDASvdujc
         LOyG8AqkWOyJ30/DUfqaFpXOhtzlKuxtloxRQKgdHOMxOBKaaztQW1QweMAIGuMawTsQ
         vZ0gARyo8BdcLt36/L4D0/pdT9KSqePP4fqDPRez12kCR68PH8WHBV2awZ1gODQdIQI1
         iYPB7+Awk3GjHBFCTuEvejasuIxwu2a8iWhmMDJeC4oAf4qbyiSURTD2LtM0bHnNfnyS
         TeqA==
X-Gm-Message-State: APjAAAUVN0Y6WDX4LsMYzWzD0EJKg+QceM0SVOkaKdImpOH3sgrvsAok
        kyijn2GDschfTO5WOPlfDeUkZv2Z
X-Google-Smtp-Source: APXvYqwgKNIUNsIlWiMLsFJLeJ/lXu4wUSRpB8XIOzO0zJ5S0pvS9BmvMxVBpXHwIvoELl2RubWuNQ==
X-Received: by 2002:a17:90a:c691:: with SMTP id n17mr3870151pjt.41.1579709291402;
        Wed, 22 Jan 2020 08:08:11 -0800 (PST)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id l2sm47959028pff.59.2020.01.22.08.08.10
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 22 Jan 2020 08:08:10 -0800 (PST)
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
Subject: [PATCH v4 3/6] hwmon: (k10temp) Report temperatures per CPU die
Date:   Wed, 22 Jan 2020 08:07:57 -0800
Message-Id: <20200122160800.12560-4-linux@roeck-us.net>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200122160800.12560-1-linux@roeck-us.net>
References: <20200122160800.12560-1-linux@roeck-us.net>
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

