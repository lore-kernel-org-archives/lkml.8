Return-Path: <SRS0=bQGS=5U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA150C2BA15
	for <linux-kernel@archiver.kernel.org>; Sat,  4 Apr 2020 20:49:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 88259206F7
	for <linux-kernel@archiver.kernel.org>; Sat,  4 Apr 2020 20:49:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ODYtdzl4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726543AbgDDUtL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 4 Apr 2020 16:49:11 -0400
Received: from mail-qv1-f65.google.com ([209.85.219.65]:38670 "EHLO
        mail-qv1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726278AbgDDUtJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Apr 2020 16:49:09 -0400
Received: by mail-qv1-f65.google.com with SMTP id p60so5502945qva.5;
        Sat, 04 Apr 2020 13:49:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=V17USKSZGK1zq8OMwgNRwDUSyCQr1dytgVBE6IBVxs0=;
        b=ODYtdzl4M0o5uInqF4kh1UpT2WiPKrQD/6QJPNgk8vwiwdEKSByoI+eU2phHyAK7gu
         eXEdFRmBe9XGHrz8DZerkEyYxHCXjOnzXyCFj56/O6wE1cpSuxZcWLnWIoJv2k9M3UIF
         aLntSTRSLweCYcH+WzI9PSlY16yMbPfv9XoqtneNWZSWIerRyrpWOJpN2Q94MFTPy8Sn
         d6sBl9mXIFa/Mo/PTPpi/aZyy6nRYingcrlnbufVia7hdiz/UPZxdJCqxuo3skOZCeq6
         rLnr59URH1RtTpB/xXTqYgda8TjcWxQ29cRcXkaL2B7X0ujB7bJFk/i2Fmk4enyJA/YR
         of8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=V17USKSZGK1zq8OMwgNRwDUSyCQr1dytgVBE6IBVxs0=;
        b=APCYw/QG53tH/XKI/faaX+ARCKXzLI7+LA/guH9MX5z4uKTk7cIkyd+s9wTLk3YD1Q
         ynvbBK0pHGjuhuX2iWXYwdCzcl7XRIcWBZXzbeKvPgUWXicY0gOMLOo/MPgQyfW64uTc
         qVJQ9fSgHxNVk7jFEj8Vd55Rs25cAJ2txTtHxMRoLOLfLNevwoe+2RFHi7SNCF7tMUM/
         ybVEtxqDOhpz+2s7o55M/7ic3NZAx0hlG3k7+3tn1ofbxEv/xUInrUUxBg2NgGL4W0NF
         ba9g2ZFqsmI/ZH7oj4Z6KA0hu/hEfnHbVLcuSMcUqn2obnwDDfV5KLDiGQMScAfLro9j
         K46g==
X-Gm-Message-State: AGi0PubqPXAo+9aa2GzxmrMP92j4uaQo6Kuiwj9w7bJoTvwhoOyFF2B3
        kGYq2nS7J/EBew+hFKAjBS7cmRD8DG7l1g==
X-Google-Smtp-Source: APiQypJYde4aVYODjdOw9wXEMq5i7V7wiB0jpnIYLb5PUKK1v/Me46IjlIFec6vYp30qzKz3mWWXww==
X-Received: by 2002:a0c:ba08:: with SMTP id w8mr13846632qvf.77.1586033348084;
        Sat, 04 Apr 2020 13:49:08 -0700 (PDT)
Received: from stingray.lan (pool-173-76-255-234.bstnma.fios.verizon.net. [173.76.255.234])
        by smtp.gmail.com with ESMTPSA id 128sm10263906qki.103.2020.04.04.13.49.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 04 Apr 2020 13:49:07 -0700 (PDT)
From:   Thomas Hebb <tommyhebb@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     Guenter Roeck <linux@roeck-us.net>,
        Thomas Hebb <tommyhebb@gmail.com>,
        Jean Delvare <jdelvare@suse.com>,
        =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali.rohar@gmail.com>,
        linux-hwmon@vger.kernel.org
Subject: [PATCH v2] hwmon: (dell-smm) Use one DMI match for all XPS models
Date:   Sat,  4 Apr 2020 16:49:00 -0400
Message-Id: <5d7e498b83e89ce7c41a449b61919c65d0770b73.1586033337.git.tommyhebb@gmail.com>
X-Mailer: git-send-email 2.25.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently, each new XPS has to be added manually for module autoloading
to work. Since fan multiplier autodetection should work fine on all XPS
models, just match them all with one block like is done for Precision
and Studio.

The only match we replace that doesn't already use autodetection is
"XPS13" which, according to Google, only matches the XPS 13 9333. (All
other XPS 13 models have "XPS" as its own word, surrounded by spaces.)
According to the thread at [1], autodetection works for the XPS 13 9333,
meaning this shouldn't regress it. I do not own one to confirm with,
though.

Tested on an XPS 13 9350 and confirmed the module now autoloads and
reports reasonable-looking data. I am using BIOS 1.12.2 and do not see
any freezes when querying fan speed.

[1] https://lore.kernel.org/patchwork/patch/525367/

Signed-off-by: Thomas Hebb <tommyhebb@gmail.com>
---

Changes in v2:
- Remove another now-redundant XPS entry that I'd missed.

 drivers/hwmon/dell-smm-hwmon.c | 26 ++------------------------
 1 file changed, 2 insertions(+), 24 deletions(-)

diff --git a/drivers/hwmon/dell-smm-hwmon.c b/drivers/hwmon/dell-smm-hwmon.c
index d4c83009d625..ca30bf903ec7 100644
--- a/drivers/hwmon/dell-smm-hwmon.c
+++ b/drivers/hwmon/dell-smm-hwmon.c
@@ -1072,13 +1072,6 @@ static const struct dmi_system_id i8k_dmi_table[] __initconst = {
 			DMI_MATCH(DMI_PRODUCT_NAME, "Vostro"),
 		},
 	},
-	{
-		.ident = "Dell XPS421",
-		.matches = {
-			DMI_MATCH(DMI_SYS_VENDOR, "Dell Inc."),
-			DMI_MATCH(DMI_PRODUCT_NAME, "XPS L421X"),
-		},
-	},
 	{
 		.ident = "Dell Studio",
 		.matches = {
@@ -1087,14 +1080,6 @@ static const struct dmi_system_id i8k_dmi_table[] __initconst = {
 		},
 		.driver_data = (void *)&i8k_config_data[DELL_STUDIO],
 	},
-	{
-		.ident = "Dell XPS 13",
-		.matches = {
-			DMI_MATCH(DMI_SYS_VENDOR, "Dell Inc."),
-			DMI_MATCH(DMI_PRODUCT_NAME, "XPS13"),
-		},
-		.driver_data = (void *)&i8k_config_data[DELL_XPS],
-	},
 	{
 		.ident = "Dell XPS M140",
 		.matches = {
@@ -1104,17 +1089,10 @@ static const struct dmi_system_id i8k_dmi_table[] __initconst = {
 		.driver_data = (void *)&i8k_config_data[DELL_XPS],
 	},
 	{
-		.ident = "Dell XPS 15 9560",
-		.matches = {
-			DMI_MATCH(DMI_SYS_VENDOR, "Dell Inc."),
-			DMI_MATCH(DMI_PRODUCT_NAME, "XPS 15 9560"),
-		},
-	},
-	{
-		.ident = "Dell XPS 15 9570",
+		.ident = "Dell XPS",
 		.matches = {
 			DMI_MATCH(DMI_SYS_VENDOR, "Dell Inc."),
-			DMI_MATCH(DMI_PRODUCT_NAME, "XPS 15 9570"),
+			DMI_MATCH(DMI_PRODUCT_NAME, "XPS"),
 		},
 	},
 	{ }
-- 
2.25.2

