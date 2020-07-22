Return-Path: <SRS0=5pK+=BB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B3CEC433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jul 2020 09:00:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4D1DF20792
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jul 2020 09:00:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="o+3rLH0v"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731217AbgGVJAx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Jul 2020 05:00:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730189AbgGVJAw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jul 2020 05:00:52 -0400
Received: from mail-pj1-x1043.google.com (mail-pj1-x1043.google.com [IPv6:2607:f8b0:4864:20::1043])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6D31C0619DC
        for <linux-kernel@vger.kernel.org>; Wed, 22 Jul 2020 02:00:52 -0700 (PDT)
Received: by mail-pj1-x1043.google.com with SMTP id gc15so2607841pjb.0
        for <linux-kernel@vger.kernel.org>; Wed, 22 Jul 2020 02:00:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=HeJFPP0igl7ucLvw13yGaRspBn89FalzpCYxP/ySa+U=;
        b=o+3rLH0vwsDC9Oi3Q50ZpevG3jnNOBflXdtW+rK6eqk/fPTzaYXZrUx4WjIVxSt7fI
         4wf138LnoK//Jx/+mfCgrJWMYatTOR8dghdLI0Q1gINrl/BU3+hqOZ/tadbirmP/if0J
         fQtQ6YgsXuxKEvM8tvfdpeCzpEBgw/vNotbzHkkWaufNiu4LtIn8QQD+NcY+uOajEoVa
         m/kHJotYlKk8FvhoK+ZXVlDzXl1HqaNnOtcy50ZYkM3yjygqnwqGpL7n/lNF7MEzVzvA
         /CxxviS89MshTSmT8c+o9zLCg9xveoLsbuIiBiQcXpU+F7ZVUuDWjJEEuaf+x6dO5tQb
         fNxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :mime-version:content-transfer-encoding;
        bh=HeJFPP0igl7ucLvw13yGaRspBn89FalzpCYxP/ySa+U=;
        b=UxODaC08boMl2GD17rW/MmMmg79nUc07sdFxH8MBlhUgK1cIFbP1tTlKI2GQJFRzAU
         BwX1S22B4tL8sRrw4fmZ4pwpxY6Aan505g28MHZagG1ZD7Z4OKxwNRJo2ZRQwMObedWX
         CTukUTBWgAsAUccppBYw9vaC/QZ7K96XkjWNtc7qZrzv5LKGgvGy0TfFI/HQ9+/E32qS
         ACa5/J92FtvYRzVm2J4fU5LDFPya7Mna4smu/GOOb0e2aZFoHuQTXGKrq7dZPQBZenVc
         zA4L1dls+XfYLkSosrpsg/CyT46a+O+JoKJ7cI0Ffpzxmpd7K5QJk4HoB+3bR1j1ngUJ
         uWOw==
X-Gm-Message-State: AOAM533zmKb92PV+IoqjEg2rwrR1nWDXTkBAjC0DJbf5WQOEnOmHwLfZ
        RKJBFN9LowBcSTR9Wf4WViU=
X-Google-Smtp-Source: ABdhPJyRAVWCtdDAaK9Vn98PaP4I9Lj/ivxP2G6XCiOitEIGND6TVYdH88Kut01lmMqc/5phmaICTw==
X-Received: by 2002:a17:902:8490:: with SMTP id c16mr25199141plo.153.1595408452207;
        Wed, 22 Jul 2020 02:00:52 -0700 (PDT)
Received: from localhost.localdomain ([45.124.203.15])
        by smtp.gmail.com with ESMTPSA id 4sm19645167pgk.68.2020.07.22.02.00.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Jul 2020 02:00:51 -0700 (PDT)
From:   Joel Stanley <joel@jms.id.au>
To:     Tudor Ambarus <tudor.ambarus@microchip.com>,
        Boris Brezillon <bbrezillon@kernel.org>
Cc:     =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
        linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH] spi-nor: Remove unused spi-nor.o rule
Date:   Wed, 22 Jul 2020 18:12:41 +0930
Message-Id: <20200722084241.193470-1-joel@jms.id.au>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In "mtd: spi-nor: Prepare core / manufacturer code split" the file was
refactored into seperate files, so the rule is no longer required.

Fixes: a0900d0195d2 ("mtd: spi-nor: Prepare core / manufacturer code split")
Reported-by: Cédric Le Goater <clg@kaod.org>
Signed-off-by: Joel Stanley <joel@jms.id.au>
---
 drivers/mtd/spi-nor/Makefile | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/mtd/spi-nor/Makefile b/drivers/mtd/spi-nor/Makefile
index 653923896205..2ede5ef79b01 100644
--- a/drivers/mtd/spi-nor/Makefile
+++ b/drivers/mtd/spi-nor/Makefile
@@ -17,6 +17,5 @@ spi-nor-objs			+= sst.o
 spi-nor-objs			+= winbond.o
 spi-nor-objs			+= xilinx.o
 spi-nor-objs			+= xmc.o
-obj-$(CONFIG_MTD_SPI_NOR)	+= spi-nor.o
 
 obj-$(CONFIG_MTD_SPI_NOR)	+= controllers/
-- 
2.27.0

