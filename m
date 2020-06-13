Return-Path: <SRS0=WLRa=72=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF128C433E0
	for <linux-kernel@archiver.kernel.org>; Sat, 13 Jun 2020 23:54:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B553B2065D
	for <linux-kernel@archiver.kernel.org>; Sat, 13 Jun 2020 23:54:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nmpur7Ku"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726801AbgFMXxg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 13 Jun 2020 19:53:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726272AbgFMXxg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 13 Jun 2020 19:53:36 -0400
Received: from mail-qk1-x741.google.com (mail-qk1-x741.google.com [IPv6:2607:f8b0:4864:20::741])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2DB58C03E96F
        for <linux-kernel@vger.kernel.org>; Sat, 13 Jun 2020 16:53:36 -0700 (PDT)
Received: by mail-qk1-x741.google.com with SMTP id n141so12535773qke.2
        for <linux-kernel@vger.kernel.org>; Sat, 13 Jun 2020 16:53:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=8/ZkbH0LJ/L7pCqBw9Gi2WSPLjhSXxaxLoaVym36vd8=;
        b=nmpur7Ku4Wyb0Pjg7P+Sfhxfs/vzTM42xwEuIpUJNOXU2jgjtKpKX6YI4Recer518T
         vIuT5WdE5H7ktkiBKQNvko+QXX0k7OWJaFSxJLViJMdaLgLiboUz+f2fuT0K7hHV4Gl7
         mmeIZFGLPhlzIC1AEYiDoUPzkLniF2+XuYjwV0JPOUA3ZCYuD+UTV7xFwvZBK7QeyZJW
         4yeDORcNpbhyNscBBjN52N/nPnDNnqG85YLr83FUQINjB4VLN6DpIoUZUISI0nP7kozR
         dOT4UqZEGTBrMq+IP91zA4bBHuIpMq1DsTTIIYnNbe2kU1McVyyo8JFNVf8Y47g+q5mq
         79uA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=8/ZkbH0LJ/L7pCqBw9Gi2WSPLjhSXxaxLoaVym36vd8=;
        b=SsFqXrFEqMwaB700Yk963flVaKrEWlx02IiQqh+6nGXrf5KdjQ12B3LAXoFTnvSIyg
         1dLqfkRvZ8Adci1AONfoUU+XDv6kb63MKzo0xEo2lz2VDQQt5A92V14AWvGpvH89vMd2
         ZZRxaW3So86E2igQTd27PzSd187oRi2o/DPYvK0ukLZImL5AYQ53/gWiI2COk33RBp8O
         V8kIQremhXB+WcocBJuIw+LiiCkBgBf3Dskv6DEaO0rI1jKPJhiIiqmiEw0JSIigLUkc
         h+8J8dwiZz+q7asHgAxYSpz+ltO2+3fqI1c8Ip2YTp1hLdgTRWP+w1S7LM9KnDqi2K8J
         5xZg==
X-Gm-Message-State: AOAM5322GDMb4j9vuXihzDAC64sjQrL1dJRFPd4qY1igz+TCYSQHAJO2
        mgipMZdohEVcZLS5CkMish8Zu32f
X-Google-Smtp-Source: ABdhPJwTRHsjpAuwKdwG/QDHbAkp3CsUWbiHue2lbwsCSmxvGKuDIxluwohyfo0Gs8lMSqU+WhWCBg==
X-Received: by 2002:ae9:ef8c:: with SMTP id d134mr9481262qkg.66.1592092415297;
        Sat, 13 Jun 2020 16:53:35 -0700 (PDT)
Received: from localhost.localdomain ([72.53.229.195])
        by smtp.gmail.com with ESMTPSA id v14sm8614538qtj.31.2020.06.13.16.53.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 13 Jun 2020 16:53:34 -0700 (PDT)
From:   Sven Van Asbroeck <thesven73@gmail.com>
X-Google-Original-From: Sven Van Asbroeck <TheSven73@gmail.com>
To:     Tudor Ambarus <tudor.ambarus@microchip.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>
Cc:     linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v1] mtd: spi-nor: Add support for Winbond w25q64jv spi flash
Date:   Sat, 13 Jun 2020 19:53:31 -0400
Message-Id: <20200613235331.24678-1-TheSven73@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This chip is (nearly) identical to the Winbond w25q64 which is
already supported by Linux. Compared to the w25q64, the 'jv'
does not support Quad SPI mode, and has a different JEDEC ID.

To: Tudor Ambarus <tudor.ambarus@microchip.com>
To: Miquel Raynal <miquel.raynal@bootlin.com>
To: Richard Weinberger <richard@nod.at>
To: Vignesh Raghavendra <vigneshr@ti.com>
Cc: linux-mtd@lists.infradead.org
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Sven Van Asbroeck <TheSven73@gmail.com>
---

Tree: next-20200613

 drivers/mtd/spi-nor/winbond.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/mtd/spi-nor/winbond.c b/drivers/mtd/spi-nor/winbond.c
index 5062af10f138..18bdff02f57f 100644
--- a/drivers/mtd/spi-nor/winbond.c
+++ b/drivers/mtd/spi-nor/winbond.c
@@ -65,6 +65,7 @@ static const struct flash_info winbond_parts[] = {
 			    SPI_NOR_HAS_LOCK | SPI_NOR_HAS_TB) },
 	{ "w25x64", INFO(0xef3017, 0, 64 * 1024, 128, SECT_4K) },
 	{ "w25q64", INFO(0xef4017, 0, 64 * 1024, 128, SECT_4K) },
+	{ "w25q64jv", INFO(0xef7017, 0, 64 * 1024, 128, SECT_4K) },
 	{ "w25q64dw", INFO(0xef6017, 0, 64 * 1024, 128,
 			   SECT_4K | SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ |
 			   SPI_NOR_HAS_LOCK | SPI_NOR_HAS_TB) },
-- 
2.17.1

