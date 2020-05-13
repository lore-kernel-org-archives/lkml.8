Return-Path: <SRS0=g10L=63=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,FROM_STARTS_WITH_NUMS,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B49AC433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 13 May 2020 16:56:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7553220671
	for <linux-kernel@archiver.kernel.org>; Wed, 13 May 2020 16:56:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="L1RIAufN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389755AbgEMQ4e (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 May 2020 12:56:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727120AbgEMQ4e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 May 2020 12:56:34 -0400
Received: from mail-qt1-x844.google.com (mail-qt1-x844.google.com [IPv6:2607:f8b0:4864:20::844])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D58A0C061A0C;
        Wed, 13 May 2020 09:56:33 -0700 (PDT)
Received: by mail-qt1-x844.google.com with SMTP id p12so339813qtn.13;
        Wed, 13 May 2020 09:56:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=qBVZWFtAh+7DORRPK/TwdIKVsq3QEyyzn54AuQWxNP0=;
        b=L1RIAufNL98urjz7BCnrWRTjugA6uPmGbIYVboOjQ8V2QimJ0n2VXOnIUHzoJXQ+/4
         99TyMq6RTSQQHgGIGsLEycE/uc0bfxNjQjAyR6mNiV0XsOPBxN0866iXF/qdvYHXD9lO
         seFml3FmDCb8GYPQ6g6T02+IWklFe1aBMnmYyU05b2M/XfP7lWQKxR2qUPovUERYPE9+
         8UkY07ADa/IBpVT6h+JK4JesJLZMLRJOtSx7DGAuT2EosWrOnvJBC98jUR5ipXo9SDem
         cA+0tf1mxDxu3VM39aZLY39w7aQGmIJEPnpfHpibNKEcu7/rhL2PhnWVDPPZhq+A7RRg
         7Pgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=qBVZWFtAh+7DORRPK/TwdIKVsq3QEyyzn54AuQWxNP0=;
        b=dWOdnfYuw6Nw0ktwbam8O+FWbMtur1pLF5EcFSFfCrhQ2MUwZGOLXR3fmzT3J7cCQB
         TVwRBusYZukgUdSwXHnRbX0+QPrB2NThWj4aZjIzUPovqbjanV/C56jQ5gxlRW94ZdIX
         b6mNTQ7Vawi/d9R1jXMRWD2HUxnWT0p8mrkHU5Bdzd01F49RBb7mbLUZyDzCbT5qizpa
         EyFUAlZPF3u8NZr6G1nORJhvhc0y13UJMXyLsMliSAOVFvbqCHxMQvm/H8ikw94vdpuH
         nS3cREhAO/Gl78rr8iSoZhdPaJJmksIbxwGLzFNaPIYy0OyYTKHYuFSOFPxodk+qMgNK
         S9KA==
X-Gm-Message-State: AOAM532I784rZaQIUNBTnZZKfz/T6ot7UYjAaCEYwggUcIlBJVYIS2Vb
        iooBniN0oC76LMDhcgjnAjDR41cLHWP3IQ==
X-Google-Smtp-Source: ABdhPJz4BxcVN1K+jM+GD0D/sMOhctEOtpVMtMUtfe8GhLvP3oAgnfwMAJRnU/Yz/g6xusJ+o4e8oA==
X-Received: by 2002:ac8:4890:: with SMTP id i16mr7909qtq.299.1589388992616;
        Wed, 13 May 2020 09:56:32 -0700 (PDT)
Received: from sca.dev ([201.17.110.164])
        by smtp.gmail.com with ESMTPSA id m59sm136795qtd.46.2020.05.13.09.56.30
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 13 May 2020 09:56:31 -0700 (PDT)
From:   Rodrigo Rolim Mendes de Alencar <455.rodrigo.alencar@gmail.com>
X-Google-Original-From: Rodrigo Rolim Mendes de Alencar <alencar.fmce@imbel.gov.br>
To:     linux-fbdev@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, b.zolnierkie@samsung.com,
        andy.shevchenko@gmail.com, devicetree@vger.kernel.org,
        Rodrigo Rolim Mendes de Alencar <alencar.fmce@imbel.gov.br>,
        Rodrigo Alencar <455.rodrigo.alencar@gmail.com>
Subject: [PATCH v2] video: fbdev: ssd1307fb: Added support to Column offset
Date:   Wed, 13 May 2020 13:56:15 -0300
Message-Id: <1589388975-15499-1-git-send-email-alencar.fmce@imbel.gov.br>
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
index 8e06ba912d60..f135b2959f87 100644
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
 
+	if (device_property_read_u32(node, "solomon,col-offset", &par->col_offset))
+		par->col_offset = 0;
+
 	if (device_property_read_u32(dev, "solomon,com-offset", &par->com_offset))
 		par->com_offset = 0;
 
-- 
2.23.0.rc1

