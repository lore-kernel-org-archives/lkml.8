Return-Path: <SRS0=za8s=32=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3246EC352A2
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Feb 2020 20:24:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0519E21927
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Feb 2020 20:24:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dvHjQ6F0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727993AbgBFUYm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Feb 2020 15:24:42 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:39595 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727977AbgBFUYj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Feb 2020 15:24:39 -0500
Received: by mail-wm1-f68.google.com with SMTP id c84so233727wme.4
        for <linux-kernel@vger.kernel.org>; Thu, 06 Feb 2020 12:24:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Y1/vJoGTEz84eAnDtx72Ndu+MPAZCnA9yhw+teLVXo0=;
        b=dvHjQ6F0W51wq8W5czfthpMZ1OOWrPNrp5Sxlg31PPtN5sZZ5mjIZ6CJJq/QCdHS+N
         GevcgPNDocAYx3cth54wnX6JdqqDZvzoYE4UY40KZVZGsLUqOkkZBTK40dohqBosbt98
         wRdAOi4FtQrh8Mqu6W4vF1RFfAXsF7hkT8mfpIpTkjTb5LWsKETgmq6B1kzxmUb6OcYa
         dc+ZuP4D9xPYPQAb1C2yGZ1ujWkaiqMGEbkNROXqXFLnqYcB+i7Xb8rC7fwdfKxwhm9j
         UQEGVw0X45ZDnGU7K2+PSD3FJ4pw7JoqoTM+c6GRit0uasA4yWLyHHjnHfFVMPw0z5xi
         n2BA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Y1/vJoGTEz84eAnDtx72Ndu+MPAZCnA9yhw+teLVXo0=;
        b=tAS3XYYPGAu2FAS0gR3lVmJ4FdiT8ljuudRqWqJ8gFnBUL8igrmv5dx00PTX/Wcxyt
         0qxeW37/uIlwREl6g1CB/C69Qmd0xvAPT6Q+OVPe4w95VWLaYtomMeVLoORscdZCZBpL
         SicAYRT8luluVSoD/4nj5Br0vO2SYd0h/GPlSYbx9vM3QkcnqXUCB+6fSQYLV+KC9mK7
         npYGD/ihenU6Lws6Ibtn1ziwdxlAqw40QI9mEjI8nSDQ6Noy9uaa+WNgiPLa5fWfvpAl
         W1KGW+q4ZK0znzw5SdOhrr0cgtEJfYLvMLoaG8xrUeD4MT/T/QjVSHk8MVJ/5V3kkv3R
         vxEQ==
X-Gm-Message-State: APjAAAVvh61xzaTHQ5F9RiEpiEX6WouFLCVoEuM0ULRJ4KOoTSogsxsF
        0OyJCwzFKume1bw20VPetzQ=
X-Google-Smtp-Source: APXvYqx/cxgYne1/eULS2VXuvJcJGurz2A26EKeyBvr3kFw/2Sd/AUf/7GtI4bYoUZi+tIE8evOTog==
X-Received: by 2002:a1c:65d6:: with SMTP id z205mr6254021wmb.38.1581020678504;
        Thu, 06 Feb 2020 12:24:38 -0800 (PST)
Received: from opensdev.fritz.box (business-178-015-117-054.static.arcor-ip.net. [178.15.117.54])
        by smtp.gmail.com with ESMTPSA id c13sm539929wrx.9.2020.02.06.12.24.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Feb 2020 12:24:37 -0800 (PST)
From:   shiva.linuxworks@gmail.com
X-Google-Original-From: sshivamurthy@micron.com
To:     Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Frieder Schrempf <frieder.schrempf@kontron.de>,
        Boris Brezillon <bbrezillon@kernel.org>,
        linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Shivamurthy Shastri <sshivamurthy@micron.com>
Subject: [PATCH v4 4/5] mtd: spinand: micron: Add M70A series Micron SPI NAND devices
Date:   Thu,  6 Feb 2020 21:22:05 +0100
Message-Id: <20200206202206.14770-5-sshivamurthy@micron.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200206202206.14770-1-sshivamurthy@micron.com>
References: <20200206202206.14770-1-sshivamurthy@micron.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Shivamurthy Shastri <sshivamurthy@micron.com>

Add device table for M70A series Micron SPI NAND devices.

Signed-off-by: Shivamurthy Shastri <sshivamurthy@micron.com>
---
 drivers/mtd/nand/spi/micron.c | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/drivers/mtd/nand/spi/micron.c b/drivers/mtd/nand/spi/micron.c
index a8e947609cd9..3d3734afc35e 100644
--- a/drivers/mtd/nand/spi/micron.c
+++ b/drivers/mtd/nand/spi/micron.c
@@ -133,6 +133,26 @@ static const struct spinand_info micron_spinand_table[] = {
 		     0,
 		     SPINAND_ECCINFO(&micron_8_ooblayout,
 				     micron_8_ecc_get_status)),
+	/* M70A 4Gb 3.3V */
+	SPINAND_INFO("MT29F4G01ABAFD", 0x34,
+		     NAND_MEMORG(1, 4096, 256, 64, 2048, 40, 1, 1, 1),
+		     NAND_ECCREQ(8, 512),
+		     SPINAND_INFO_OP_VARIANTS(&read_cache_variants,
+					      &write_cache_variants,
+					      &update_cache_variants),
+		     SPINAND_HAS_CR_FEAT_BIT,
+		     SPINAND_ECCINFO(&micron_8_ooblayout,
+				     micron_8_ecc_get_status)),
+	/* M70A 4Gb 1.8V */
+	SPINAND_INFO("MT29F4G01ABBFD", 0x35,
+		     NAND_MEMORG(1, 4096, 256, 64, 2048, 40, 1, 1, 1),
+		     NAND_ECCREQ(8, 512),
+		     SPINAND_INFO_OP_VARIANTS(&read_cache_variants,
+					      &write_cache_variants,
+					      &update_cache_variants),
+		     SPINAND_HAS_CR_FEAT_BIT,
+		     SPINAND_ECCINFO(&micron_8_ooblayout,
+				     micron_8_ecc_get_status)),
 };
 
 static int micron_spinand_detect(struct spinand_device *spinand)
-- 
2.17.1

