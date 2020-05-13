Return-Path: <SRS0=g10L=63=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,FROM_STARTS_WITH_NUMS,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 016A6C433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 13 May 2020 18:48:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9D391205CB
	for <linux-kernel@archiver.kernel.org>; Wed, 13 May 2020 18:48:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lzM2sulh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390254AbgEMSse (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 May 2020 14:48:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1732218AbgEMSse (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 May 2020 14:48:34 -0400
Received: from mail-qt1-x844.google.com (mail-qt1-x844.google.com [IPv6:2607:f8b0:4864:20::844])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 576C9C061A0C;
        Wed, 13 May 2020 11:48:34 -0700 (PDT)
Received: by mail-qt1-x844.google.com with SMTP id j2so676485qtr.12;
        Wed, 13 May 2020 11:48:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=O+v6/HetATnirOETJaaLYtIOTXHLeVK+a1zo9bE2gjg=;
        b=lzM2sulhP4qvY5Yfcz80VJJ/6KP/AAFPw4Ul23TqYASG7trju8lwDfuL8titQ0jZlv
         pjoiyH9x77REXE2zTeNU96T4g+W9D1X0m42DZkHpTqRfAkeYkwHhAYvSktB38IctD3O5
         MocLBnWco8QQ12xSE+JXVTeLLgMYCqIHQrAPWcTxvXw1XytMrzQu3v7eVuT2jxXSp3st
         whgkxqoPcK3AXknEZPVA2Af5kkKaVA2RYdegbIi0S8NtzUjnO1JSvq4ccIKB7Kit7qGY
         mNJ2dgZ/W1hiO0tKZHtzpOuVtUVzYWtdzHOYX5T/7qkRE0XzGDqrP/zSlVX26slvxzhO
         fG3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=O+v6/HetATnirOETJaaLYtIOTXHLeVK+a1zo9bE2gjg=;
        b=ht0EKmFhaOGZyRGItLrTwmC07qq14Yp8t0U+CZ/qvDYD5GsfW5iBGcvpYevLDQsIDC
         3OAyqX0Y796VyAk+xB/6rJDvStWXOttZ4SztwZKZBUDtTxeMlNcZH/s0/zU0eKutMWRB
         1nZ83apRpaBSWy9YY+L1Th3kU9WxvhjCsvx7jW+C6zLu/1IHpIrtCxnmDyaIjRFgEZWL
         wn4m4ZdNOCFKkVNRf8ug5ZFoEAq9vmmGTmUREMl07H4bauSPicLjMjfvWCrXrRlDSaFu
         mWLYgWSJpJJUSCWPeKTmJq0v0ejA8ysMFlJ1wWzzq01v6SPIaE3WGlAUf4ZtByTQ6SBJ
         vVuQ==
X-Gm-Message-State: AOAM533Z4GnHs/+k01Gicwc7xraXb5tcFQnYMfGyJzhXhkWWh6uLOTLi
        jOwlHSEg5Nmq5K4gKZ9Q1olCsTWrTxtkPQ==
X-Google-Smtp-Source: ABdhPJzo+BKzKMDFOJBotQJKCE9cz6QqtNmPnYV1hMHxXuy6OFQe5eC5fsOpQdPerkDWi5jWYsyDFw==
X-Received: by 2002:aed:3949:: with SMTP id l67mr506854qte.313.1589395713113;
        Wed, 13 May 2020 11:48:33 -0700 (PDT)
Received: from sca.dev ([201.17.110.164])
        by smtp.gmail.com with ESMTPSA id j9sm526484qkg.88.2020.05.13.11.48.30
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 13 May 2020 11:48:32 -0700 (PDT)
From:   Rodrigo Alencar <455.rodrigo.alencar@gmail.com>
X-Google-Original-From: Rodrigo Alencar <alencar.fmce@imbel.gov.br>
To:     linux-fbdev@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, b.zolnierkie@samsung.com,
        andy.shevchenko@gmail.com, devicetree@vger.kernel.org,
        Rodrigo Rolim Mendes de Alencar <alencar.fmce@imbel.gov.br>,
        Rodrigo Alencar <455.rodrigo.alencar@gmail.com>
Subject: [PATCH v3] video: fbdev: ssd1307fb: Added support to Column offset
Date:   Wed, 13 May 2020 15:48:11 -0300
Message-Id: <1589395691-8762-1-git-send-email-alencar.fmce@imbel.gov.br>
X-Mailer: git-send-email 1.9.3
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Rodrigo Rolim Mendes de Alencar <alencar.fmce@imbel.gov.br>

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
index 8e06ba912d60..102f941104c0 100644
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

