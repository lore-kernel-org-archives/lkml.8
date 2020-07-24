Return-Path: <SRS0=4orP=BD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_STARTS_WITH_NUMS,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05F68C433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jul 2020 20:22:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D7263206F0
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jul 2020 20:22:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aEQIKERb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726607AbgGXUWv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Jul 2020 16:22:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726083AbgGXUWu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jul 2020 16:22:50 -0400
Received: from mail-qk1-x744.google.com (mail-qk1-x744.google.com [IPv6:2607:f8b0:4864:20::744])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66EFCC0619D3;
        Fri, 24 Jul 2020 13:22:50 -0700 (PDT)
Received: by mail-qk1-x744.google.com with SMTP id l64so3044285qkb.8;
        Fri, 24 Jul 2020 13:22:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=lNR7DPSMAwlmETRQaRKF86lK9EAXVZqsRz6IdvChwL8=;
        b=aEQIKERbPHew6ZDI5bdSF6tatle/XyWIU0ajOfQxM3hEffkJ2qrIX+Z7KwCj1qEbv2
         A5D5D2zD3RDGs9k4ztj9rSAFsV0S0bpsjEcA5J/K+835wPu6MtQhAqiHphnYSas4YVKd
         kUrv0ZLC9yNtbsj/PTgUBoUqEJo/bduGltR9bKUNYAs2lZCHbdlXVSJLqL0t7iLk2cOn
         fVSBtE+U12ZVgTTi5pcc5sGhN79Yoac2rjtjFwh3h+qUmQPcBd3xQ9tRYkSx0Y9U8Y2E
         WOtZktziNqGWEpaAR+A3N11ojtTlJSs5sYo4hxTOFJIcwVCap/dko5O1n52b5PVGKcEu
         k+1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=lNR7DPSMAwlmETRQaRKF86lK9EAXVZqsRz6IdvChwL8=;
        b=QKzm/WnpoaVkW9FDZQkNlWVNN/j4UxsCv36MnFp6/Y0gnIaQak7vsMQ5YI92ySHPi6
         whntHY3fTV1O/22YNeYcF2UJQuEZfwFfVNCRt39s5hpR0wlmxYWT1+f93UFU7trVc3h+
         y1ej/nr4zdZMK/6zoq55ZosHDRh9yvDzS+4RftkHUdjeqfvMUFrkdFR9+OaYCDNJLf+5
         TYggnWCHejJbaQa2e2pzB6Oc2Q8WkXf5iAwDtemE1itztPQvFpqwZMmhK7SxFNtCV99A
         37auO7lyvAtqT0k4JNS2SKr434pr/DECWsZC8pluMEZxk9vCcGfQyhxplPBBVVC+fiOZ
         mWoA==
X-Gm-Message-State: AOAM530NRGBgWNM+iKLYzfwUvtM35RV8K/BNjIteMCXhR3d+a0rQsk/E
        7eIhcqlCLaGTLwHgjBO/5GI2aYAD5Aggzw==
X-Google-Smtp-Source: ABdhPJz/GdyBMKud4cVr8jFLYphSosBSdXKBZz50OQc+rqrTC6Ag8Zv9oh/AkVwgiCnnnt9uBpIGOA==
X-Received: by 2002:a05:620a:2482:: with SMTP id i2mr12067683qkn.364.1595622169152;
        Fri, 24 Jul 2020 13:22:49 -0700 (PDT)
Received: from sca.dev ([201.17.127.164])
        by smtp.gmail.com with ESMTPSA id 94sm2696319qtc.88.2020.07.24.13.22.45
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 24 Jul 2020 13:22:48 -0700 (PDT)
From:   Rodrigo Alencar <455.rodrigo.alencar@gmail.com>
To:     linux-fbdev@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, b.zolnierkie@samsung.com,
        devicetree@vger.kernel.org,
        Rodrigo Alencar <455.rodrigo.alencar@gmail.com>
Subject: [PATCH v4] video: fbdev: ssd1307fb: Added support to Column offset
Date:   Fri, 24 Jul 2020 17:22:18 -0300
Message-Id: <1595622138-3965-1-git-send-email-455.rodrigo.alencar@gmail.com>
X-Mailer: git-send-email 1.9.3
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch provides support for displays like VGM128064B0W10,
which requires a column offset of 2, i.e., its segments starts
in SEG2 and ends in SEG129.

Signed-off-by: Rodrigo Alencar <455.rodrigo.alencar@gmail.com>
---
 Documentation/devicetree/bindings/display/ssd1307fb.txt | 1 +
 drivers/video/fbdev/ssd1307fb.c                         | 8 ++++++--
 2 files changed, 7 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/display/ssd1307fb.txt b/Documentation/devicetree/bindings/display/ssd1307fb.txt
index 27333b9551b3..2dcb6d12d137 100644
--- a/Documentation/devicetree/bindings/display/ssd1307fb.txt
+++ b/Documentation/devicetree/bindings/display/ssd1307fb.txt
@@ -19,6 +19,7 @@ Optional properties:
   - vbat-supply: The supply for VBAT
   - solomon,segment-no-remap: Display needs normal (non-inverted) data column
                               to segment mapping
+  - solomon,col-offset: Offset of columns (COL/SEG) that the screen is mapped to.
   - solomon,com-seq: Display uses sequential COM pin configuration
   - solomon,com-lrremap: Display uses left-right COM pin remap
   - solomon,com-invdir: Display uses inverted COM pin scan direction
diff --git a/drivers/video/fbdev/ssd1307fb.c b/drivers/video/fbdev/ssd1307fb.c
index 09425ec317ba..eda448b7a0c9 100644
--- a/drivers/video/fbdev/ssd1307fb.c
+++ b/drivers/video/fbdev/ssd1307fb.c
@@ -74,6 +74,7 @@ struct ssd1307fb_par {
 	struct fb_info *info;
 	u8 lookup_table[4];
 	u32 page_offset;
+	u32 col_offset;
 	u32 prechargep1;
 	u32 prechargep2;
 	struct pwm_device *pwm;
@@ -458,11 +459,11 @@ static int ssd1307fb_init(struct ssd1307fb_par *par)
 	if (ret < 0)
 		return ret;
 
-	ret = ssd1307fb_write_cmd(par->client, 0x0);
+	ret = ssd1307fb_write_cmd(par->client, par->col_offset);
 	if (ret < 0)
 		return ret;
 
-	ret = ssd1307fb_write_cmd(par->client, par->width - 1);
+	ret = ssd1307fb_write_cmd(par->client, par->col_offset + par->width - 1);
 	if (ret < 0)
 		return ret;
 
@@ -626,6 +627,9 @@ static int ssd1307fb_probe(struct i2c_client *client)
 	if (device_property_read_u32(dev, "solomon,page-offset", &par->page_offset))
 		par->page_offset = 1;
 
+	if (device_property_read_u32(dev, "solomon,col-offset", &par->col_offset))
+		par->col_offset = 0;
+
 	if (device_property_read_u32(dev, "solomon,com-offset", &par->com_offset))
 		par->com_offset = 0;
 
-- 
2.23.0.rc1

