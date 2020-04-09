Return-Path: <SRS0=n+Ub=5Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E99ADC2BB55
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Apr 2020 09:34:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B0CE3208FE
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Apr 2020 09:34:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="vVpj55hQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726681AbgDIJeO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Apr 2020 05:34:14 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:51758 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726638AbgDIJeM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Apr 2020 05:34:12 -0400
Received: by mail-wm1-f68.google.com with SMTP id x4so1073412wmj.1;
        Thu, 09 Apr 2020 02:34:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=7Q2NlCB63D2LhEGr0HwhcxP6aGwq461tbuIJ0oEX06M=;
        b=vVpj55hQZQvgH3Z3cGf73X1rvd1ZOVmJt3Ojbs5phtb5O/acyRVL6aXtux8iatz1KW
         X5oGIWVhTAcFuSlTN6gsnCxnj1V62CTHduOJdt3pQ5QlskkmM78GJwS6/I/oUr3Qrxaj
         n+ngvXzE5rJbiNcEToDunyRvf+5xjbYfoswYjfHEds2j93MQ+kAokg+7Bnztmv7TBPvz
         0x9nt1MHgx8bK+aE6PUNX84lPoYI+LUhDQFpxTnxL4fiodyCQQJkmGFuLeAJpGzC3g3e
         C5DWz/P5hQ1Eylw1ZkLkl2zGGSRsmb7uyjTvGD3AOVMZx7Leh0hqKUhfvkgePzvJlywS
         45OQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=7Q2NlCB63D2LhEGr0HwhcxP6aGwq461tbuIJ0oEX06M=;
        b=Cq8oT5+CMHAI++x6HO3lbIWLruT6oywLrMsHT9Rm74w4BQG5oFwBy2Gz64AD+OcG8u
         XkCp9qykXWvlfSR+W5F/iRqSssRKaCIjCcLEnnye+h1KdpMlWhcpZ+tNk7PfdoaPqPE/
         ZQVWqrqfbDD92rizCAZJWFwHTBTzlofu+FK3Rupwbk25jJweDlLjRSgfDPw7T8yvRSeK
         u5y9dETCCu5yKzq8G/arS/mqPy1tB4S8J4ilARN/nifqinzbZETdxhdCTC7G2bJja9Bx
         xFxD+t4TKs2lEXHojcuNkkaJbh/cv4BRxTMNzOYcn/BU84JlyDiINbKhW9Yy742n20VY
         L4Lg==
X-Gm-Message-State: AGi0Pub5cQB/9/3XPIcURQOlq4qHq/pUAqWD+sunp/opIR1cMUvwRNSf
        oJ/cGlH85HVbl4HTSo6Y8SVFKY1svng=
X-Google-Smtp-Source: APiQypKUHubOBZw6V5DlQzjZbiHuk+zbVkHxWC7aj0wXhW0gzw3QUStWWUeaA3X1nOIr1T7nMS9ajQ==
X-Received: by 2002:a7b:c4c9:: with SMTP id g9mr282591wmk.171.1586424850185;
        Thu, 09 Apr 2020 02:34:10 -0700 (PDT)
Received: from localhost (ip1f115f16.dynamic.kabel-deutschland.de. [31.17.95.22])
        by smtp.gmail.com with ESMTPSA id f63sm2764515wma.47.2020.04.09.02.34.09
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 09 Apr 2020 02:34:09 -0700 (PDT)
From:   Oliver Graute <oliver.graute@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     oliver.graute@gmail.com,
        Oliver Graute <oliver.graute@kococonnector.com>,
        dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Subject: [PATCH v1] staging: fbtft: fb_st7789v: Initialize the Display
Date:   Thu,  9 Apr 2020 11:25:32 +0200
Message-Id: <1586424337-26602-1-git-send-email-oliver.graute@gmail.com>
X-Mailer: git-send-email 2.7.4
X-Patchwork-Bot: notify
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Oliver Graute <oliver.graute@kococonnector.com>

Set Gamma Values and Register Values for the HSD20_IPS

Signed-off-by: Oliver Graute <oliver.graute@kococonnector.com>
---
 drivers/staging/fbtft/fb_st7789v.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/staging/fbtft/fb_st7789v.c b/drivers/staging/fbtft/fb_st7789v.c
index 84c5af2dc9a0..b0aa96b703a8 100644
--- a/drivers/staging/fbtft/fb_st7789v.c
+++ b/drivers/staging/fbtft/fb_st7789v.c
@@ -17,8 +17,8 @@
 #define DRVNAME "fb_st7789v"
 
 #define DEFAULT_GAMMA \
-	"70 2C 2E 15 10 09 48 33 53 0B 19 18 20 25\n" \
-	"70 2C 2E 15 10 09 48 33 53 0B 19 18 20 25"
+	"D0 05 0A 09 08 05 2E 44 45 0F 17 16 2B 33\n" \
+	"D0 05 0A 09 08 05 2E 43 45 0F 16 16 2B 33"
 
 /**
  * enum st7789v_command - ST7789V display controller commands
@@ -83,13 +83,13 @@ static int init_display(struct fbtft_par *par)
 	/* set pixel format to RGB-565 */
 	write_reg(par, MIPI_DCS_SET_PIXEL_FORMAT, MIPI_DCS_PIXEL_FMT_16BIT);
 
-	write_reg(par, PORCTRL, 0x08, 0x08, 0x00, 0x22, 0x22);
+	write_reg(par, PORCTRL, 0x05, 0x05, 0x00, 0x33, 0x33);
 
 	/*
 	 * VGH = 13.26V
 	 * VGL = -10.43V
 	 */
-	write_reg(par, GCTRL, 0x35);
+	write_reg(par, GCTRL, 0x75);
 
 	/*
 	 * VDV and VRH register values come from command write
@@ -101,13 +101,13 @@ static int init_display(struct fbtft_par *par)
 	 * VAP =  4.1V + (VCOM + VCOM offset + 0.5 * VDV)
 	 * VAN = -4.1V + (VCOM + VCOM offset + 0.5 * VDV)
 	 */
-	write_reg(par, VRHS, 0x0B);
+	write_reg(par, VRHS, 0x13);
 
 	/* VDV = 0V */
 	write_reg(par, VDVS, 0x20);
 
 	/* VCOM = 0.9V */
-	write_reg(par, VCOMS, 0x20);
+	write_reg(par, VCOMS, 0x22);
 
 	/* VCOM offset = 0V */
 	write_reg(par, VCMOFSET, 0x20);
-- 
2.17.1

