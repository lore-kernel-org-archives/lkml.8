Return-Path: <SRS0=0vny=62=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,FROM_STARTS_WITH_NUMS,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16CB7C2D0F7
	for <linux-kernel@archiver.kernel.org>; Tue, 12 May 2020 20:53:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E720320753
	for <linux-kernel@archiver.kernel.org>; Tue, 12 May 2020 20:53:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Uz0A7RWo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731170AbgELUxT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 May 2020 16:53:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725938AbgELUxS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 May 2020 16:53:18 -0400
Received: from mail-qk1-x742.google.com (mail-qk1-x742.google.com [IPv6:2607:f8b0:4864:20::742])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 756DEC061A0C;
        Tue, 12 May 2020 13:53:18 -0700 (PDT)
Received: by mail-qk1-x742.google.com with SMTP id g185so15161708qke.7;
        Tue, 12 May 2020 13:53:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=PwIASv/vhd/qRGtzr/TQ79wPBnNWX1XktPXzdN45PYQ=;
        b=Uz0A7RWoZ1quDAqVxJAzo+fnpEPgA00dcQ8c0v7lWV3lxQ8kWiT6sT6jNRnreRn9O0
         kkibGiJXw3E+hvr6tBfeBWjBIYr2SyEprqLPu5ju2upXf/JbkCXt/RRAUi5umt0hImC8
         RftDgpDFclwPr9Hb7NUsMXR2JHWX0Br0yts0sd0f3ZGLCyuiZRDWfnCdTAdKXL9euUJj
         TRrrnWRmmv0fEYOjb9Qey3lpywCXTSJkCUVvXkSEM+a1EoIMqPzFWg5QVNVkCthuOruW
         zmynbk8bmUYiUuHlwPJxVPJxIwqWzOikRWl6wtnsAERS427pWk5AmVGyEOcgYE2hPQE4
         IUnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=PwIASv/vhd/qRGtzr/TQ79wPBnNWX1XktPXzdN45PYQ=;
        b=HI4nzgjIcAskWUSi25y/dLPvr5m0KeM3TXdjGx7cM6lYdKEAziVUDuso7PyFjUSzcq
         QAEedBsE4uQqWsN3mnpzg9x8xK404s5f16CtP8fYIz0ZKC7iRw0JoGhWShmjOG/2LJQQ
         zqpU90pV9bG6ekb8LK4Je9kblcAzZmJlkgizkKwO0Kj4kws65bfIVBPdJ+xq0pIrTKXh
         W3PJDh2lW+w8KAqFksL/w4BMlyTwPV5XGyxQp89ghgKCmaCEMFblAIYa/d3rnk/mjTFC
         6D3B/rU4uB2AVT9keiA2hBdu45xX+eqWkH6oRjiEmOakbjWnxlyhvAPiN0ad3N5Ocn+3
         Jblw==
X-Gm-Message-State: AOAM532cVza6U6UJ+jmZTbgrHA/39YiVGTVwRGcb0WwqGMzLSccvKryh
        GMwTc2PxYQqHyG3JMYM3kXlnOnVc2JC6eg==
X-Google-Smtp-Source: ABdhPJy7cc7mfQY0TzVYXpHv6JOuNU3+msIJpUP//ezvdJM4xXgs7lmdlDWrQyj3wI5VtHWN4sURjQ==
X-Received: by 2002:a37:a3d6:: with SMTP id m205mr4731164qke.241.1589316797287;
        Tue, 12 May 2020 13:53:17 -0700 (PDT)
Received: from sca.dev ([201.17.110.164])
        by smtp.gmail.com with ESMTPSA id h6sm9503374qkf.61.2020.05.12.13.53.15
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 12 May 2020 13:53:16 -0700 (PDT)
From:   Rodrigo Rolim Mendes de Alencar <455.rodrigo.alencar@gmail.com>
X-Google-Original-From: Rodrigo Rolim Mendes de Alencar <alencar.fmce@imbel.gov.br>
To:     linux-fbdev@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, maxime.ripard@free-electrons.com,
        alencar.fmce@imbel.gov.br,
        Rodrigo Alencar <455.rodrigo.alencar@gmail.com>
Subject: [PATCH 2/3] video: fbdev: ssd1307fb: Support to pixel inversion
Date:   Tue, 12 May 2020 17:52:48 -0300
Message-Id: <1589316769-13277-2-git-send-email-alencar.fmce@imbel.gov.br>
X-Mailer: git-send-email 1.9.3
In-Reply-To: <1589316769-13277-1-git-send-email-alencar.fmce@imbel.gov.br>
References: <1589316769-13277-1-git-send-email-alencar.fmce@imbel.gov.br>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Pixel inversion in hardware is performed by issuing the
command 0xa7. This patch adds a boolean  property to control
color inversion.

Signed-off-by: Rodrigo Alencar <455.rodrigo.alencar@gmail.com>
---
 .../devicetree/bindings/display/ssd1307fb.txt         |  1 +
 drivers/video/fbdev/ssd1307fb.c                       | 11 ++++++++++-
 2 files changed, 11 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/display/ssd1307fb.txt b/Documentation/devicetree/bindings/display/ssd1307fb.txt
index 74a7b228bcef..3076b71ede68 100644
--- a/Documentation/devicetree/bindings/display/ssd1307fb.txt
+++ b/Documentation/devicetree/bindings/display/ssd1307fb.txt
@@ -22,6 +22,7 @@ Optional properties:
   - solomon,com-seq: Display uses sequential COM pin configuration
   - solomon,com-lrremap: Display uses left-right COM pin remap
   - solomon,com-invdir: Display uses inverted COM pin scan direction
+  - solomon,color-inv: Set Inverse display mode (invert pixel color)
   - solomon,com-offset: Number of the COM pin wired to the first display line
   - solomon,col-offset: Offset of columns (SEG) that the screen is mapped to.
   - solomon,prechargep1: Length of deselect period (phase 1) in clock cycles.
diff --git a/drivers/video/fbdev/ssd1307fb.c b/drivers/video/fbdev/ssd1307fb.c
index ac88bbe174b6..748c21c0567b 100644
--- a/drivers/video/fbdev/ssd1307fb.c
+++ b/drivers/video/fbdev/ssd1307fb.c
@@ -31,8 +31,9 @@
 #define SSD1307FB_SET_LOOKUP_TABLE	0x91
 #define	SSD1307FB_CHARGE_PUMP		0x8d
 #define SSD1307FB_SEG_REMAP_ON		0xa1
-#define SSD1307FB_DISPLAY_OFF		0xae
+#define SSD1307FB_DISPLAY_NORMAL	0xa6
 #define SSD1307FB_SET_MULTIPLEX_RATIO	0xa8
+#define SSD1307FB_DISPLAY_OFF		0xae
 #define SSD1307FB_DISPLAY_ON		0xaf
 #define SSD1307FB_START_PAGE_ADDRESS	0xb0
 #define SSD1307FB_SET_DISPLAY_OFFSET	0xd3
@@ -62,6 +63,7 @@ struct ssd1307fb_deviceinfo {
 struct ssd1307fb_par {
 	unsigned area_color_enable : 1;
 	unsigned com_invdir : 1;
+	unsigned color_inv : 1;
 	unsigned com_lrremap : 1;
 	unsigned com_seq : 1;
 	unsigned lookup_table_set : 1;
@@ -492,6 +494,12 @@ static int ssd1307fb_init(struct ssd1307fb_par *par)
 	if (ret < 0)
 		return ret;
 
+	/* Set normal or inverse */
+	ret = ssd1307fb_write_cmd(par->client,
+				  SSD1307FB_DISPLAY_NORMAL | (par->color_inv & 0x1));
+	if (ret < 0)
+		return ret;
+
 	/* Clear the screen */
 	ssd1307fb_update_display(par);
 
@@ -666,6 +674,7 @@ static int ssd1307fb_probe(struct i2c_client *client,
 	par->com_seq = of_property_read_bool(node, "solomon,com-seq");
 	par->com_lrremap = of_property_read_bool(node, "solomon,com-lrremap");
 	par->com_invdir = of_property_read_bool(node, "solomon,com-invdir");
+	par->color_inv = of_property_read_bool(node, "solomon,color-inv");
 	par->area_color_enable =
 		of_property_read_bool(node, "solomon,area-color-enable");
 	par->low_power = of_property_read_bool(node, "solomon,low-power");
-- 
2.23.0.rc1

