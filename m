Return-Path: <SRS0=/A4t=3B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4624C3F68F
	for <linux-kernel@archiver.kernel.org>; Sun, 12 Jan 2020 06:03:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 99649214AF
	for <linux-kernel@archiver.kernel.org>; Sun, 12 Jan 2020 06:03:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Hnjy/C9/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732232AbgALFtu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 12 Jan 2020 00:49:50 -0500
Received: from mail-pj1-f66.google.com ([209.85.216.66]:56235 "EHLO
        mail-pj1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732217AbgALFtu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Jan 2020 00:49:50 -0500
Received: by mail-pj1-f66.google.com with SMTP id d5so2739517pjz.5
        for <linux-kernel@vger.kernel.org>; Sat, 11 Jan 2020 21:49:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=yuiiLxis7UmO7qtPOBKseQeFyLzKkWcOkkI4cfgxzbE=;
        b=Hnjy/C9/lwj/YKklYxYqjyFlS0dhjQpRJdoiGfZpQuJFrG1CepD+olnANXmyvYt9HK
         IRL19y5/rQazLK5XRskk+rP51oky7FAFgyiPFNrOsrJfnEt9WhV6HMAFaQ1pEJEI6f3a
         686+XrmUmriSvDu2DbPi29ukU6EcAR2Wqs16w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=yuiiLxis7UmO7qtPOBKseQeFyLzKkWcOkkI4cfgxzbE=;
        b=ryW4BSVSB7ECMBlwQzDGtZHcfKy1UIejuM9jPhFF3IzDk/lElbYlfpjOJnYtrtVa70
         vWTara8GTHr/LG+G/jyNqyBHaezQxzzbOOXg8yije7LezNYt7XsSJf38bU8P4ZyZjsnp
         qG0TB7V5dH/UElQLTKhElRa7Ez/3YTs3kE7UX7ajRrjgM3xxH3PRoLob56rfEIpQ4vkd
         obKXBNsOJxlxkCHkz74zLCEbFk056pu7yTviwo2zAoCzya5Xw/r7fZGKLR1PcBInF9jy
         5TAr+O8oKVfQC6TVAqbf69lkgZESYqZCiZBIVkJ/Ykc2Wo9AsMOkUZ9Xtk5WKzLwLcy4
         rBwA==
X-Gm-Message-State: APjAAAUJIC/DOGZEpJ/Hkj52mtbAceXbjZmS41IEAK/2efjBFY9OiMQn
        ArzGWGsJt6LJ0f1sMqVeU3sC1gAMK+c=
X-Google-Smtp-Source: APXvYqw8H+bveIPPoAnKYh5V1Z9dF/usIOThJroMZwLFSgEzbsKYs+qEUkX4u5ynq1X/6egf2QW76Q==
X-Received: by 2002:a17:90a:3244:: with SMTP id k62mr16102028pjb.43.1578808189512;
        Sat, 11 Jan 2020 21:49:49 -0800 (PST)
Received: from localhost ([2401:fa00:1:10:845f:e35d:e30c:4b47])
        by smtp.gmail.com with ESMTPSA id i127sm9575396pfe.54.2020.01.11.21.49.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 11 Jan 2020 21:49:48 -0800 (PST)
From:   Yu-Hsuan Hsu <yuhsuan@chromium.org>
To:     linux-kernel@vger.kernel.org
Cc:     Cheng-Yi Chiang <cychiang@chromium.org>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Guenter Roeck <groeck@chromium.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Benson Leung <bleung@chromium.org>,
        alsa-devel@alsa-project.org, Tzung-Bi Shih <tzungbi@chromium.org>,
        Yu-Hsuan Hsu <yuhsuan@chromium.org>,
        Akshu Agrawal <akshu.agrawal@amd.com>
Subject: [PATCH] ASoC: cros_ec_codec: Make the device acpi compatible
Date:   Sun, 12 Jan 2020 13:49:00 +0800
Message-Id: <20200112054900.236576-1-yuhsuan@chromium.org>
X-Mailer: git-send-email 2.25.0.rc1.283.g88dfdc4193-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add ACPI entry for cros_ec_codec.

Signed-off-by: Yu-Hsuan Hsu <yuhsuan@chromium.org>
---
 sound/soc/codecs/cros_ec_codec.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/sound/soc/codecs/cros_ec_codec.c b/sound/soc/codecs/cros_ec_codec.c
index c81bbef2367a0f..6a24f570c5e86f 100644
--- a/sound/soc/codecs/cros_ec_codec.c
+++ b/sound/soc/codecs/cros_ec_codec.c
@@ -10,6 +10,7 @@
 
 #include <crypto/hash.h>
 #include <crypto/sha.h>
+#include <linux/acpi.h>
 #include <linux/delay.h>
 #include <linux/device.h>
 #include <linux/io.h>
@@ -1047,10 +1048,17 @@ static const struct of_device_id cros_ec_codec_of_match[] = {
 MODULE_DEVICE_TABLE(of, cros_ec_codec_of_match);
 #endif
 
+static const struct acpi_device_id cros_ec_codec_acpi_id[] = {
+	{ "GOOG0013", 0 },
+	{ }
+};
+MODULE_DEVICE_TABLE(acpi, cros_ec_codec_acpi_id);
+
 static struct platform_driver cros_ec_codec_platform_driver = {
 	.driver = {
 		.name = "cros-ec-codec",
 		.of_match_table = of_match_ptr(cros_ec_codec_of_match),
+		.acpi_match_table = ACPI_PTR(cros_ec_codec_acpi_id),
 	},
 	.probe = cros_ec_codec_platform_probe,
 };
-- 
2.25.0.rc1.283.g88dfdc4193-goog

