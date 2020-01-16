Return-Path: <SRS0=CsDi=3F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED2A7C33CB3
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jan 2020 14:18:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B4B64207E0
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jan 2020 14:18:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jz8cR9sB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727029AbgAPOSX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Jan 2020 09:18:23 -0500
Received: from mail-pf1-f193.google.com ([209.85.210.193]:41155 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726933AbgAPOSP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jan 2020 09:18:15 -0500
Received: by mail-pf1-f193.google.com with SMTP id w62so10278002pfw.8;
        Thu, 16 Jan 2020 06:18:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=seUK/JyxhRWMYA1ja0fRcFl7gNdd11FZuOX5tIhz6o4=;
        b=jz8cR9sBbfsmWSgj6nQuh7q4/DORarQKf7m4rmnFRLbhDxisphLIrI8zkgCk/3U5+S
         K37zkUeZ51c+k9AyhAsP0O9nvx7uzIGzLrCy8/C8GhflXsGlbWDJ/kb2X5GuCpnHJP3/
         mDTwbJz78rq+owL2OReX86ZHk3QOURdLEy80bjCBNE+wFZ33kNk5vVwKPObdAOyjIlKK
         fA7z86+jQS45RnK5aR5HEZuRawJW/buZE3dNLWQtT+E9aoR+UbxzgxSL8HQtHLcLx6Ws
         tDookyPz/NS0YVztp1DnthfVlCGnnKtp4jZbVgbO61nTFEwQCLUludLYEJ8SW6vtHxe3
         IW9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references;
        bh=seUK/JyxhRWMYA1ja0fRcFl7gNdd11FZuOX5tIhz6o4=;
        b=kIv5PfKJReMNtJP2w7hrCCZWgz682Dp9Dmzkypl3Q6wwYFGI2t/YLJ40FjiUgrlFoQ
         ZSIY/e/BsDGoRtwrFbHOM2hydUAkESmn+2hy7HQie+7pmjVu6x+L3GuQZGfCUE2N/01j
         zvJDXaTiBS8MtTY8iplaE+tZ/kYy2CCpT1a5CBlHVwg2lLLSNmdUAXc9PNO3C1gncVXs
         xvqWeELFgBLrOysmp4FD1Q841Ff97LVO7YjE1d7p7UQod6jQZUFWA2k3pCtj4c16yrAK
         sY6RST6CClXzkPCLshCeG5U0j8TuZtLqx76RnrCcnPKren6RP7jcFoH5w2WfdzJkb/cA
         ytbw==
X-Gm-Message-State: APjAAAUvuhi+ctW2YUbgxuehlg1D5PWCuStTC30xUQBO61YSSkUkAQtw
        7kru679VCJQ3oBo2SV0GZLpcrik9
X-Google-Smtp-Source: APXvYqzq0QxK2/ou/gLtw66gjnVeUzZb9qI4LUpHIeA/fI8Zq5pSY2SF9Euu+DmUse5dnhYPOeOHQw==
X-Received: by 2002:a63:1119:: with SMTP id g25mr39349489pgl.359.1579184294488;
        Thu, 16 Jan 2020 06:18:14 -0800 (PST)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id i23sm25641983pfo.11.2020.01.16.06.18.13
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 16 Jan 2020 06:18:14 -0800 (PST)
From:   Guenter Roeck <linux@roeck-us.net>
To:     linux-hwmon@vger.kernel.org
Cc:     Clemens Ladisch <clemens@ladisch.de>,
        Jean Delvare <jdelvare@suse.com>, linux-kernel@vger.kernel.org,
        Guenter Roeck <linux@roeck-us.net>
Subject: [RFT PATCH 3/4] hwmon: (k10temp) Report temperatures per CPU die
Date:   Thu, 16 Jan 2020 06:17:59 -0800
Message-Id: <20200116141800.9828-4-linux@roeck-us.net>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200116141800.9828-1-linux@roeck-us.net>
References: <20200116141800.9828-1-linux@roeck-us.net>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Zen2 reports reporting temperatures per CPU die (called Core Complex Dies,
or CCD, by AMD). Add support for it to the k10temp driver.

Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
 drivers/hwmon/k10temp.c | 79 ++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 78 insertions(+), 1 deletion(-)

diff --git a/drivers/hwmon/k10temp.c b/drivers/hwmon/k10temp.c
index c45f6498a59b..944ba8008bc4 100644
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
@@ -326,9 +382,30 @@ static int k10temp_probe(struct pci_dev *pdev, const struct pci_device_id *id)
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

