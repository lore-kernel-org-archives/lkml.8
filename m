Return-Path: <SRS0=iZC5=5S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E76EC2D0E9
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Apr 2020 04:02:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 530A6206E9
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Apr 2020 04:02:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RgO2uaxF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728394AbgDBECc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Apr 2020 00:02:32 -0400
Received: from mail-qt1-f196.google.com ([209.85.160.196]:39313 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727109AbgDBECb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Apr 2020 00:02:31 -0400
Received: by mail-qt1-f196.google.com with SMTP id f20so2225472qtq.6;
        Wed, 01 Apr 2020 21:02:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=/jw2WZ6aHnORJ8qH5PbT0GtwmWt6wJffdnj2epPitNs=;
        b=RgO2uaxFVrmvxGIheHJFmd2euaYJzPmwzonN/sulS7pSoSDC32XNN4/VzwiXOPczrg
         N4DBS4HIMwKOHo/iwfYgdScX7uy+2fhomXdO4l30X/PsztnSa6JxV21zWMZuQ0e+Sl9N
         o8LjJYYb5Zu79X+0e35dqfIX0mFFZFY6rlkQ4yqbISrpXN+4z39PyJCQXPiePV8ZjJXS
         fYfP1daGeG1hYtA6RSetq3ud5i4FYK5evGbY3VNU+Crfi/c4nbiiDCjqLA9lnvv59d5k
         6saQEsT9ChKQZVs6RzDu7lAgSBQSH22bdWP3Yp46jQ9Pyui9u10+sX5fAFaz0a6S8D3e
         uBEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=/jw2WZ6aHnORJ8qH5PbT0GtwmWt6wJffdnj2epPitNs=;
        b=PwUYZtartRNbSwa0unlWa6NCYhlj1jGUr2DzIM5laVknInqvYAHzpqMttMs7PfAYr5
         Eqt+La1iE7NPSPjkhba9Uy4UasOMIJkg1BJdCDiVyTK1GwNibyzS7jFbHZLCvyMjeQZy
         d2GHfXt7TU+dRaMoSqz4VGtjWCVk/L4M1BguNZSKyPbOAEgXHYeOtVTmCa/aMccGqcME
         tNvi78cMJsA1PPwYvld3ATCweHnJ9GQD35WKVTCB5dU8p4sPCfXzQZv00S74iEFvdPp7
         hOyb2n5jZ/4wg09vpdqkoHMsgwMsiAmMmKUS20hjyAz5K/bm5Iua6aOMN8Jp8TID2EST
         DxuA==
X-Gm-Message-State: AGi0PuatVxtp+LGZy2LXpas+3nfve2zp8zzBI4KjoZTvxk3D0BWsRJw+
        QYNnPK4iR4UfO6KOtmKkXx3fiP6B5JabVA==
X-Google-Smtp-Source: APiQypLHBdJLcacAP39uZyzAC5X3t9Jb0FA3mUxgEx6ZlY/YRiBYA3sNmCO3+ecWdvQsu0NGw7gpTw==
X-Received: by 2002:ac8:358f:: with SMTP id k15mr1019998qtb.113.1585800148357;
        Wed, 01 Apr 2020 21:02:28 -0700 (PDT)
Received: from stingray.lan (pool-173-76-255-234.bstnma.fios.verizon.net. [173.76.255.234])
        by smtp.gmail.com with ESMTPSA id c6sm627749qkg.88.2020.04.01.21.02.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Apr 2020 21:02:27 -0700 (PDT)
From:   Thomas Hebb <tommyhebb@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     Thomas Hebb <tommyhebb@gmail.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Jean Delvare <jdelvare@suse.com>,
        =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali.rohar@gmail.com>,
        linux-hwmon@vger.kernel.org
Subject: [PATCH] hwmon: (dell-smm) Use one DMI match for all XPS models
Date:   Thu,  2 Apr 2020 00:02:21 -0400
Message-Id: <be17c0a111983e886d871db8dc2fc8fbfe8e2da0.1585800134.git.tommyhebb@gmail.com>
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

 drivers/hwmon/dell-smm-hwmon.c | 19 ++-----------------
 1 file changed, 2 insertions(+), 17 deletions(-)

diff --git a/drivers/hwmon/dell-smm-hwmon.c b/drivers/hwmon/dell-smm-hwmon.c
index d4c83009d625..c1af4c801dd8 100644
--- a/drivers/hwmon/dell-smm-hwmon.c
+++ b/drivers/hwmon/dell-smm-hwmon.c
@@ -1087,14 +1087,6 @@ static const struct dmi_system_id i8k_dmi_table[] __initconst = {
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
@@ -1104,17 +1096,10 @@ static const struct dmi_system_id i8k_dmi_table[] __initconst = {
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

