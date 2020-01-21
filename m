Return-Path: <SRS0=3tRb=3K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD870C33CAA
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jan 2020 02:30:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 931D222522
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jan 2020 02:30:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jhRBqmGW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729031AbgAUCaj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Jan 2020 21:30:39 -0500
Received: from mail-pl1-f193.google.com ([209.85.214.193]:36322 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726890AbgAUCai (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jan 2020 21:30:38 -0500
Received: by mail-pl1-f193.google.com with SMTP id a6so655194plm.3;
        Mon, 20 Jan 2020 18:30:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=nsYKoT1BpY0kUNRQePG66qpdiEA4oi0keuUWKmcNOtI=;
        b=jhRBqmGW1xtgmUKcHugKxEGxLlWOlem2RDuiZSGEqU1r55YLB8bDC459bdovaUb1Er
         F6z2KdOcwJSv9x9+sKOEFM1lNgVIWfkQhsl/XoyowJcr3EfnmCWux2FNk6KjHWZztSYR
         UYsaCKEogJZv3//b8W7pVkBfNeFM0qPvNrLu6qrTfHkbE6yz4rKJ9e6dziYJE6vC5MDh
         kG9DRmTN/uuQ0BBrPqdJukXG25UwUx+l2bcHryO41szwGl9j8wHFQTqFj7wsPQ3GcpFj
         osHyMgsZ+9ExAXofWRwnrgaOfx8oRuLbI5dUy1TIcmvM3oGKqycb5LZNrInDvRNfiRD8
         9mxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references;
        bh=nsYKoT1BpY0kUNRQePG66qpdiEA4oi0keuUWKmcNOtI=;
        b=BxW/AXGTZ4DLwXHJLclT6VQ8Dfxf40ElmKWgH+d2/1SyIH2p2imHMpqZFIGUCTheLQ
         hKmnWubU3c1MXZgYGYoy/aXLZaYnyLT/Vb8It4qEopz5OEz8SNYo1/9JcL19KEXyC4gd
         CTxxNQfNuzoeKUJKM1oX5gRyTeS6FaXlYJdkfHtYz7XCZlfmqqqOqeGQaLqSVpAca3/6
         IiXfqrxe+bBFbO+4Ex0QMt6fNJ9pK8ymVabONETUX21w2Pdf6E5bQiGPoVQ2kyxCLxem
         SCBoeogcz+D9IxPadvcQ0Dl97TvcQuzrCtwnzO5Rcm5FM531OQSj3knJu4S8SNz2uKSL
         EUHQ==
X-Gm-Message-State: APjAAAVbzHjkU/YZGjyy/NupTJb9j6AUfNBV6xI2UPYr/Xl72qhR43vG
        Yg0fvb6AvvRcjG5+svYK+OG284ey
X-Google-Smtp-Source: APXvYqxISNary6tTU/LmG524YDQnM6JO9UU0gNEyDyrVaQh+lxsme2pAabDfHldryk4LfPx8Gp5xkw==
X-Received: by 2002:a17:90a:804a:: with SMTP id e10mr2583574pjw.41.1579573837651;
        Mon, 20 Jan 2020 18:30:37 -0800 (PST)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id n4sm38310219pgg.88.2020.01.20.18.30.36
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 20 Jan 2020 18:30:37 -0800 (PST)
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
Subject: [PATCH v3 1/5] hwmon: (k10temp) Use bitops
Date:   Mon, 20 Jan 2020 18:30:23 -0800
Message-Id: <20200121023027.2081-2-linux@roeck-us.net>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200121023027.2081-1-linux@roeck-us.net>
References: <20200121023027.2081-1-linux@roeck-us.net>
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

