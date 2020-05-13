Return-Path: <SRS0=g10L=63=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,FROM_STARTS_WITH_NUMS,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D6BDCA90AF
	for <linux-kernel@archiver.kernel.org>; Wed, 13 May 2020 11:51:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 08426206CC
	for <linux-kernel@archiver.kernel.org>; Wed, 13 May 2020 11:51:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="m2MjvC9z"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730978AbgEMLvs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 May 2020 07:51:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725982AbgEMLvr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 May 2020 07:51:47 -0400
Received: from mail-qk1-x744.google.com (mail-qk1-x744.google.com [IPv6:2607:f8b0:4864:20::744])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9ECBEC061A0C;
        Wed, 13 May 2020 04:51:47 -0700 (PDT)
Received: by mail-qk1-x744.google.com with SMTP id g185so16930093qke.7;
        Wed, 13 May 2020 04:51:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=Gwpqh921Hf6wzA5AMDQSYWZ5UpHdH6Jqwq1eRKuvGKQ=;
        b=m2MjvC9z7cCTNiR3FWhmuuVKx5AHNcn5GnriRNuHcXKLp8W8bF+7C416Rt/aQxAKAE
         FLZl9wOcUrjZV7L+SGD0YsiB1MThdrmG2vT3tfes7/cTaDq2plUx1kq2oLhRbzGtL0K7
         jsf1zwRe1Kh5FezfovCo3orbZyqr+kbrsIXqtcLNFRW7wpt71fEFR4QSPvXWXpKRhzyq
         6VHQ4gHqhVE6FWANf4wnmBmSKny+D7/9KJhZcvjsct/UNkQ6OfVfOWm+Pm34C0Z5CKiQ
         TsleYb7wz/uQDsIcFpQJbaldGSfhq0uAeJTthenOs/nvoAG5Dbz4GZlzU1JH30rjls7o
         XH8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=Gwpqh921Hf6wzA5AMDQSYWZ5UpHdH6Jqwq1eRKuvGKQ=;
        b=FAtme6Gw5+HYRUlIeR3y7iwHGfRULoyeI3jJuAXhC6mmWko1HUKkVwNKtWtnhfal93
         6jxfLGT+MxE0/5HaDGHVobHGJ1EKUefmEpDUfdaatRzYP6zhfz4URW05w/s5xU1R4OtY
         vDPizMVCiXxscz7Yo11konp/wEAf6cAY3WkjP3lKzbsWJaJZQyU7T3Aw6dMX7ZstMuCs
         JoJ1EPupyBVf2QbWZV5aZw6CVfxwbHbRe2rmfKkYjjZn7J40Iu92Y+sKBosLBQGdtdOH
         TEGWD//v1mjAiQGrzCnF6p6CdY+m3MbtsDt1vkkuttyr90RBrvHhErVwu/uNUYJSqadu
         tVmQ==
X-Gm-Message-State: AOAM530vUB1FO5HMAv0Vs5QwwnEAMfITmQ4nmyek8X6LdA83gMIz73t6
        kFp6By+FDmcBoynWYXteEufSo7Zwzd7cOw==
X-Google-Smtp-Source: ABdhPJxApCjQCUHEkH+244z8ftz/jYBy6PM/euMt6f7ynylTtWESS8RV2jzthXzvhDLxG/bW02bp3w==
X-Received: by 2002:a05:620a:14ac:: with SMTP id x12mr6315219qkj.262.1589370706284;
        Wed, 13 May 2020 04:51:46 -0700 (PDT)
Received: from sca.dev ([201.17.110.164])
        by smtp.gmail.com with ESMTPSA id r128sm13846699qke.109.2020.05.13.04.51.44
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 13 May 2020 04:51:45 -0700 (PDT)
From:   Rodrigo Rolim Mendes de Alencar <455.rodrigo.alencar@gmail.com>
X-Google-Original-From: Rodrigo Rolim Mendes de Alencar <alencar.fmce@imbel.gov.br>
To:     linux-fbdev@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, alencar.fmce@imbel.gov.br,
        andy.shevchenko@gmail.com,
        Rodrigo Alencar <455.rodrigo.alencar@gmail.com>
Subject: [PATCH] video: fbdev: ssd1307fb: Added support to Column offset
Date:   Wed, 13 May 2020 08:51:34 -0300
Message-Id: <1589370694-14327-1-git-send-email-alencar.fmce@imbel.gov.br>
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
index 27333b9551b3..a9b51fd724a9 100644
--- a/Documentation/devicetree/bindings/display/ssd1307fb.txt
+++ b/Documentation/devicetree/bindings/display/ssd1307fb.txt
@@ -19,6 +19,7 @@ Optional properties:
   - vbat-supply: The supply for VBAT
   - solomon,segment-no-remap: Display needs normal (non-inverted) data column
                               to segment mapping
+  - solomon,col-offset: Offset of columns (SEG) that the screen is mapped to.
   - solomon,com-seq: Display uses sequential COM pin configuration
   - solomon,com-lrremap: Display uses left-right COM pin remap
   - solomon,com-invdir: Display uses inverted COM pin scan direction
diff --git a/drivers/video/fbdev/ssd1307fb.c b/drivers/video/fbdev/ssd1307fb.c
index 8e06ba912d60..0241585bfbcc 100644
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
 
+	if (of_property_read_u32(node, "solomon,col-offset", &par->col_offset))
+		par->col_offset = 0;
+
 	if (device_property_read_u32(dev, "solomon,com-offset", &par->com_offset))
 		par->com_offset = 0;
 
-- 
2.23.0.rc1

