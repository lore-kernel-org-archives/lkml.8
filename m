Return-Path: <SRS0=9JlO=3L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5DCDDC2D0DB
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jan 2020 16:08:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 331192071E
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jan 2020 16:08:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jy+mxbCm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726885AbgAVQIK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Jan 2020 11:08:10 -0500
Received: from mail-pl1-f193.google.com ([209.85.214.193]:40743 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725883AbgAVQII (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jan 2020 11:08:08 -0500
Received: by mail-pl1-f193.google.com with SMTP id s21so3197069plr.7;
        Wed, 22 Jan 2020 08:08:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=nsYKoT1BpY0kUNRQePG66qpdiEA4oi0keuUWKmcNOtI=;
        b=jy+mxbCm8+bLZKM6HnAzYNbYS+soxca+Ssw/R4BBbmfpENNtHaU+QWDMw0e3Picokl
         sDgMFsYRTSbzc5Fj6kl59UwUtWWodb7UwZamGtGrPC219inMk9E+CZQB0k0KjXlNiDgs
         DzJPo1c+v3it0HgEYLiwb+EGBIgnMufePZ7DvjQxYiI24le0sHB/XQZk1UW5aKLAv+QT
         Fo+sHA9XMPYyt0kOA50z7uEPMMie3i7K9VTXX7oOqGolUr3VwE7/5aiUh82+oE3TWGNU
         tWb3MoZ4dk5cJYwEQzxSkPkwI74HrQ4uRWruqTKnvpeLd4dud3h+ocC9dGAnt8+UoUzh
         rOoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references;
        bh=nsYKoT1BpY0kUNRQePG66qpdiEA4oi0keuUWKmcNOtI=;
        b=K43rdb0jZwvirHkslOZsGm5HgCItMVSWbQciD7j0392+Cox503UXQ7YEYqXvJ41otq
         0AiOcQzMbeHwhPVoHvnyGa1bYcCN/j1gaQxGVI9iexJ3grXKoBY3crSkv+nWsWSCBGd/
         dkKW/tG+hmv65+qtiQKRPA92RZKxF6InyEEtPR0nbAHJQkYcohqmHNtjLkgPG3WUMI02
         7bQevmpCppBQff9S54/PrdC8xyouT/0cnDhnfrPN0jGuxUUGVyHlvWKc6ynIl7vWJnrt
         TCNtArr/A/7CY79TzoIJQpZx9hzRV5B0p64UPzkrQbSItGLvEidy5Tnd+ejDWt5mic/T
         mfZA==
X-Gm-Message-State: APjAAAWy4dtHGEY/Q9ZpXmwdBHxcNlVduUwXmExcSDofPxonvz8pxQfM
        MHJHDQL0HKqduGJ+uxt7EUhOVaWK
X-Google-Smtp-Source: APXvYqxMr5RHkiwIgt7zUotQpO0xTyxr5z5dTYzhgTG4zQSiPPNKh8YMuiuR6ZIG9J7SwOxpA62jBA==
X-Received: by 2002:a17:90a:d0c5:: with SMTP id y5mr3777225pjw.126.1579709287742;
        Wed, 22 Jan 2020 08:08:07 -0800 (PST)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id r187sm7027030pgr.56.2020.01.22.08.08.06
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 22 Jan 2020 08:08:07 -0800 (PST)
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
Subject: [PATCH v4 1/6] hwmon: (k10temp) Use bitops
Date:   Wed, 22 Jan 2020 08:07:55 -0800
Message-Id: <20200122160800.12560-2-linux@roeck-us.net>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200122160800.12560-1-linux@roeck-us.net>
References: <20200122160800.12560-1-linux@roeck-us.net>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Using bitops makes bit masks and shifts easier to read.

Tested-by: Brad Campbell <lists2009@fnarfbargle.com>
Tested-by: Bernhard Gebetsberger <bernhard.gebetsberger@gmx.at>
Tested-by: Holger Kiehl <holger.kiehl@dwd.de>
Tested-by: Michael Larabel <michael@phoronix.com>
Tested-by: Jonathan McDowell <noodles@earth.li>
Tested-by: Ken Moffat <zarniwhoop73@googlemail.com>
Tested-by: Darren Salt <devspam@moreofthesa.me.uk>
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

