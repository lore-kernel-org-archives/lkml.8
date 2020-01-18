Return-Path: <SRS0=3sb/=3H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5307C33CB1
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Jan 2020 17:26:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8D495246A8
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Jan 2020 17:26:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gYDJjvdJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727012AbgARR01 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 18 Jan 2020 12:26:27 -0500
Received: from mail-yb1-f196.google.com ([209.85.219.196]:36258 "EHLO
        mail-yb1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726460AbgARR0Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Jan 2020 12:26:25 -0500
Received: by mail-yb1-f196.google.com with SMTP id w9so7141396ybs.3;
        Sat, 18 Jan 2020 09:26:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=mYutcDqqXCVJkllEBh65f1oEzPxP2d/7QBN12EzRdLI=;
        b=gYDJjvdJYrOL6JKiimJBL3fKckUQQDmkj3e6BpkNgkdg+sTxqu5aOwQoza7msdFR5w
         yYPkx2VBuCWWYMubyQMiZMMu7LSUcjYD2V+yOe0wqzLSJa9VakYrUhKQAMOEcyAxS/Ta
         hkfs/pu6nQcPMalkI0sX70Z4SSiTdJ/r5mIPowq8TXvUhZug73CNrqi6g94SPWH+2uWt
         iJxGif/y1Be7XPGWc4PfU+4R8y4tkHspLH1dX6XTe5qaSyNur8Zpjhma+fCkA3euGn0a
         QaZFGFzW3PbzCK8dGgMnBIr4gs+sneDa9CV47kEijHiFKYCQOauyljUdulwfwX2GRZPa
         C2Kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references;
        bh=mYutcDqqXCVJkllEBh65f1oEzPxP2d/7QBN12EzRdLI=;
        b=g9Xgi2TVjQprIWD/yaFnRBva5c+hfTj3/yX0gq3epupqiHtM05yLYcSUTACQ+2TFgF
         ScO/Z7ZUBgxdAYuEA9SP7iVGstt0H/ejAhBZ1l3XwML9r/ItINvjuPXPSgMJZlmEGttH
         4UFB0AbA+FnfXV4IltViYHIJkbQyeBaooQSf5Afau2j6U9+YhQ5TjO+1hhSwFrLiNnF3
         atpAcq08z78typte2qGdcud/60ZxA423W7KXUIhK8Oml/7K0Hg+CHV7bC/p7vuxCcFcG
         b6oJYRspLSZR0ZA6F1EVMVSduT1mj50B1ZKq2tTMsj6vRITDoXrhkM1FXO1h2mbr6S86
         S9dw==
X-Gm-Message-State: APjAAAW58MoHitTa6O68r0/n8WGmapemzM9KdIR3H/770BjJGobKq7EB
        zVWF1RPPnkpIvSosUTNdn87YTV2X
X-Google-Smtp-Source: APXvYqxco9kMfPRYXynoJ6ZDFZy7d2/TVXiDf0c+DkfwQalvdETa6Qdmcn7YQdIWNLxoxrjA4Thq9w==
X-Received: by 2002:a25:1841:: with SMTP id 62mr36297649yby.405.1579368384383;
        Sat, 18 Jan 2020 09:26:24 -0800 (PST)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id b192sm13252447ywe.2.2020.01.18.09.26.23
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 18 Jan 2020 09:26:24 -0800 (PST)
From:   Guenter Roeck <linux@roeck-us.net>
To:     linux-hwmon@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, Clemens Ladisch <clemens@ladisch.de>,
        Jean Delvare <jdelvare@suse.com>,
        Darren Salt <devspam@moreofthesa.me.uk>,
        Bernhard Gebetsberger <bernhard.gebetsberger@gmx.at>,
        Ken Moffat <zarniwhoop73@googlemail.com>,
        =?UTF-8?q?Ondrej=20=C4=8Cerman?= <ocerman@sda1.eu>,
        Holger Kiehl <Holger.Kiehl@dwd.de>,
        Sebastian Reichel <sebastian.reichel@collabora.com>,
        Brad Campbell <lists2009@fnarfbargle.com>,
        Guenter Roeck <linux@roeck-us.net>
Subject: [PATCH v2 1/5] hwmon: (k10temp) Use bitops
Date:   Sat, 18 Jan 2020 09:26:11 -0800
Message-Id: <20200118172615.26329-2-linux@roeck-us.net>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200118172615.26329-1-linux@roeck-us.net>
References: <20200118172615.26329-1-linux@roeck-us.net>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Using bitops makes bit masks and shifts easier to read.

Tested-by: Bernhard Gebetsberger <bernhard.gebetsberger@gmx.at>
Tested-by: Darren Salt <devspam@moreofthesa.me.uk>
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
v2: Added Tested-by: tags

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

