Return-Path: <SRS0=CsDi=3F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93B90C33CB1
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jan 2020 14:18:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 664DA207E0
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jan 2020 14:18:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="X8hO/Mgb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726928AbgAPOSO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Jan 2020 09:18:14 -0500
Received: from mail-pj1-f68.google.com ([209.85.216.68]:34877 "EHLO
        mail-pj1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726084AbgAPOSM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jan 2020 09:18:12 -0500
Received: by mail-pj1-f68.google.com with SMTP id s7so1658662pjc.0;
        Thu, 16 Jan 2020 06:18:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=SqNU8BEvRrh7CzCA9+xl9QuecJJq2yOX0LpeNCA/PXU=;
        b=X8hO/Mgb+y4D9pAMDjiETjqRKyud+waS+FpHvHdSjok/cIJkRK6PQ6kD/in+MjIsjX
         /9SWNF9oESyzACPDOPx4wNP9UiJFQ8VBQtzcIf0yjPV9/JN73utSZaKa4CPdDiXnILkn
         K94ohtZZduWays/+X9nDp5X07lo2YbZ8HLnlJqaM2rJ2G7FLpyEg7o4fUSxlfr4t2IoR
         fnxznViAfEG7O90bJJLyiyIcbxenFPOurx7baKLaSxIhbI/z5YHkw26x4fPld2hGYcu5
         +4mXSlUUTNazjz6SahWeNuJn6c/BGRwJa0RNN4Kgvt7DUQXz6eeWF+ywP9Yt/PwxeMYs
         Hjsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references;
        bh=SqNU8BEvRrh7CzCA9+xl9QuecJJq2yOX0LpeNCA/PXU=;
        b=j9yNiFVo2MyVCA1uwkjnNGapk74u/6s1AP0dgtSIVHEo2QPrZJ6QqmdNr7SoiCEHRL
         aC2YiQilGIBP+P0W9E8cqdKkkuf7/DqJt5i/N46OtjeGb75EyE0MTboL60Sf0/JioCxO
         D0G6fL0WyP3XPZs5ocvX1UXor8Ex/9k0rMzVZf58Dgze0U8+FwphoJ+131tLxKq5C2ED
         NlgVt9y5JU+XOxKZcIXMIJDIuFDemmiPTwFL3BR4nhKyqLq1iraMB5060FVItF5X0Q/S
         GXenUA/82Xj0ItNTRfG9+Ohkrtp2kQAjFF1XkHc/ESdMCQQfJB6V6G5pMe/zUj87JAiU
         4Apw==
X-Gm-Message-State: APjAAAWH4KSltyAkqIa6Pgf0SPUoCia6+ofpyAVr3ic+IFiGts1kPULq
        jCIda6AnJkEw0YA5h+CXDXE10YJ/
X-Google-Smtp-Source: APXvYqz4a+aYwqPdyN/YziCPmczd+nVvO2sv35M0TgKAX06/jm2IhIyBbqze+6JTW/R9hQWGPu1aeQ==
X-Received: by 2002:a17:902:9a08:: with SMTP id v8mr32760182plp.134.1579184291553;
        Thu, 16 Jan 2020 06:18:11 -0800 (PST)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id a10sm25244078pgm.81.2020.01.16.06.18.10
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 16 Jan 2020 06:18:11 -0800 (PST)
From:   Guenter Roeck <linux@roeck-us.net>
To:     linux-hwmon@vger.kernel.org
Cc:     Clemens Ladisch <clemens@ladisch.de>,
        Jean Delvare <jdelvare@suse.com>, linux-kernel@vger.kernel.org,
        Guenter Roeck <linux@roeck-us.net>
Subject: [RFT PATCH 1/4] hwmon: (k10temp) Use bitops
Date:   Thu, 16 Jan 2020 06:17:57 -0800
Message-Id: <20200116141800.9828-2-linux@roeck-us.net>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200116141800.9828-1-linux@roeck-us.net>
References: <20200116141800.9828-1-linux@roeck-us.net>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Using bitops makes bit masks and shifts easier to read.

Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
 drivers/hwmon/k10temp.c | 16 ++++++++++------
 1 file changed, 10 insertions(+), 6 deletions(-)

diff --git a/drivers/hwmon/k10temp.c b/drivers/hwmon/k10temp.c
index 5c1dddde193c..8807d7da68db 100644
--- a/drivers/hwmon/k10temp.c
+++ b/drivers/hwmon/k10temp.c
@@ -5,6 +5,7 @@
  * Copyright (c) 2009 Clemens Ladisch <clemens@ladisch.de>
  */
 
+#include <linux/bitops.h>
 #include <linux/err.h>
 #include <linux/hwmon.h>
 #include <linux/hwmon-sysfs.h>
@@ -31,22 +32,22 @@ static DEFINE_MUTEX(nb_smu_ind_mutex);
 #endif
 
 /* CPUID function 0x80000001, ebx */
-#define CPUID_PKGTYPE_MASK	0xf0000000
+#define CPUID_PKGTYPE_MASK	GENMASK(31, 28)
 #define CPUID_PKGTYPE_F		0x00000000
 #define CPUID_PKGTYPE_AM2R2_AM3	0x10000000
 
 /* DRAM controller (PCI function 2) */
 #define REG_DCT0_CONFIG_HIGH		0x094
-#define  DDR3_MODE			0x00000100
+#define  DDR3_MODE			BIT(8)
 
 /* miscellaneous (PCI function 3) */
 #define REG_HARDWARE_THERMAL_CONTROL	0x64
-#define  HTC_ENABLE			0x00000001
+#define  HTC_ENABLE			BIT(0)
 
 #define REG_REPORTED_TEMPERATURE	0xa4
 
 #define REG_NORTHBRIDGE_CAPABILITIES	0xe8
-#define  NB_CAP_HTC			0x00000400
+#define  NB_CAP_HTC			BIT(10)
 
 /*
  * For F15h M60h and M70h, REG_HARDWARE_THERMAL_CONTROL
@@ -60,6 +61,9 @@ static DEFINE_MUTEX(nb_smu_ind_mutex);
 /* F17h M01h Access througn SMN */
 #define F17H_M01H_REPORTED_TEMP_CTRL_OFFSET	0x00059800
 
+#define CUR_TEMP_SHIFT				21
+#define CUR_TEMP_RANGE_SEL_MASK			BIT(19)
+
 struct k10temp_data {
 	struct pci_dev *pdev;
 	void (*read_htcreg)(struct pci_dev *pdev, u32 *regval);
@@ -129,7 +133,7 @@ static unsigned int get_raw_temp(struct k10temp_data *data)
 	u32 regval;
 
 	data->read_tempreg(data->pdev, &regval);
-	temp = (regval >> 21) * 125;
+	temp = (regval >> CUR_TEMP_SHIFT) * 125;
 	if (regval & data->temp_adjust_mask)
 		temp -= 49000;
 	return temp;
@@ -312,7 +316,7 @@ static int k10temp_probe(struct pci_dev *pdev,
 		data->read_htcreg = read_htcreg_nb_f15;
 		data->read_tempreg = read_tempreg_nb_f15;
 	} else if (boot_cpu_data.x86 == 0x17 || boot_cpu_data.x86 == 0x18) {
-		data->temp_adjust_mask = 0x80000;
+		data->temp_adjust_mask = CUR_TEMP_RANGE_SEL_MASK;
 		data->read_tempreg = read_tempreg_nb_f17;
 		data->show_tdie = true;
 	} else {
-- 
2.17.1

