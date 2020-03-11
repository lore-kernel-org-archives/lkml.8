Return-Path: <SRS0=Ktsx=44=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54F94C0044D
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Mar 2020 17:58:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DB92F20737
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Mar 2020 17:58:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OiOKpPfu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730681AbgCKR6z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Mar 2020 13:58:55 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:55613 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730453AbgCKR6x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Mar 2020 13:58:53 -0400
Received: by mail-wm1-f68.google.com with SMTP id 6so3093990wmi.5
        for <linux-kernel@vger.kernel.org>; Wed, 11 Mar 2020 10:58:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=N4JCBOx8G3oWdvQfPIJ3DTOnZanq5rcB9mg+1By+2ec=;
        b=OiOKpPfuxffO0meppq6Jf7Aci2vKfdixIxWwDO/s/32LA36YZVqgIbf7ssgFJKFtLE
         hbLnhhPrwUOBb+UZ5eYpqi7aiKkS6519Sbfk0Hara2GzdkEKF8NcmbJ2D9ehD7ncd5wb
         Sj1K2kGytTYhIPM2QDs7kfKJ1WtN6iQR2jcmO91n8R9lLJdaSo4LLwwtiKSGQUiTM602
         eVG15XFqU4A+OOHiRcJdpZwdrT4Bg2SuEO4ujsA857Wos8nBQ6FH4vM8UJKoRE6/NEiK
         nYxvfgIxqKd5txo76X34B1xKnkcn40FXZcdAl4tPWBII5jie85W+RFQhYuq7j6OgUJXp
         Opvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=N4JCBOx8G3oWdvQfPIJ3DTOnZanq5rcB9mg+1By+2ec=;
        b=ThgBWB8NXbJoIKuyQZBN+pVAhRrJVSi5d0ZS7BNfG7o2giq092XakQZbNUsKRZJ7l1
         VMAeJP7EvyIBNOZnzgel9mmul4TYJZkkFXOziLpX3x6Rt3RPd684aka9Q6/Y6wMO2/pD
         tLtTyDArU55tusLtk/NAprp74k86WAASbs11ywIYGxLBxP2QLg4dTsdRoNPHWbmsXNbe
         qZzMVpNihMOyC7l+0e8o5FjbirzP1ZgwTeGtbfBEc5aQgS6c+Z2oIft3ec//jknnZwAi
         uiuftcgvXfJbq7UT7aQx2cE1PubroP5pir6ZMnDi+LQAL8DGoyoCnHNyIoR0JIqn6swR
         RqQA==
X-Gm-Message-State: ANhLgQ0FehG1j2qzclkeVYp0nQIWzHDD+zGfYoRVApJ15lkWk5Sf/iil
        dIrNEWwtZNLQptKq6oHPm2k=
X-Google-Smtp-Source: ADFU+vtL22sild8eFvtwYgKPKknFimV2k5Ei0QwvYbIltnqvbf8st8VU95tXL5IPkETRlRNhO5AO/A==
X-Received: by 2002:a1c:a502:: with SMTP id o2mr4692129wme.94.1583949531131;
        Wed, 11 Mar 2020 10:58:51 -0700 (PDT)
Received: from opensdev.fritz.box (business-178-015-117-054.static.arcor-ip.net. [178.15.117.54])
        by smtp.gmail.com with ESMTPSA id l18sm1502107wrr.17.2020.03.11.10.58.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Mar 2020 10:58:50 -0700 (PDT)
From:   shiva.linuxworks@gmail.com
X-Google-Original-From: sshivamurthy@micron.com
To:     Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Boris Brezillon <boris.brezillon@collabora.com>,
        Chuanhong Guo <gch981213@gmail.com>,
        Frieder Schrempf <frieder.schrempf@kontron.de>,
        linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Shivamurthy Shastri <sshivamurthy@micron.com>
Subject: [PATCH v7 3/6] mtd: spinand: micron: Add new Micron SPI NAND devices
Date:   Wed, 11 Mar 2020 18:57:32 +0100
Message-Id: <20200311175735.2007-4-sshivamurthy@micron.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200311175735.2007-1-sshivamurthy@micron.com>
References: <20200311175735.2007-1-sshivamurthy@micron.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Shivamurthy Shastri <sshivamurthy@micron.com>

Add device table for M79A and M78A series Micron SPI NAND devices.

Signed-off-by: Shivamurthy Shastri <sshivamurthy@micron.com>
Reviewed-by: Boris Brezillon <boris.brezillon@collabora.com>
---
 drivers/mtd/nand/spi/micron.c | 33 +++++++++++++++++++++++++++++++++
 1 file changed, 33 insertions(+)

diff --git a/drivers/mtd/nand/spi/micron.c b/drivers/mtd/nand/spi/micron.c
index 4727933c894b..26925714a9fb 100644
--- a/drivers/mtd/nand/spi/micron.c
+++ b/drivers/mtd/nand/spi/micron.c
@@ -102,6 +102,39 @@ static const struct spinand_info micron_spinand_table[] = {
 		     0,
 		     SPINAND_ECCINFO(&micron_8_ooblayout,
 				     micron_8_ecc_get_status)),
+	/* M79A 2Gb 1.8V */
+	SPINAND_INFO("MT29F2G01ABBGD",
+		     SPINAND_ID(SPINAND_READID_METHOD_OPCODE_DUMMY, 0x25),
+		     NAND_MEMORG(1, 2048, 128, 64, 2048, 40, 2, 1, 1),
+		     NAND_ECCREQ(8, 512),
+		     SPINAND_INFO_OP_VARIANTS(&read_cache_variants,
+					      &write_cache_variants,
+					      &update_cache_variants),
+		     0,
+		     SPINAND_ECCINFO(&micron_8_ooblayout,
+				     micron_8_ecc_get_status)),
+	/* M78A 1Gb 3.3V */
+	SPINAND_INFO("MT29F1G01ABAFD",
+		     SPINAND_ID(SPINAND_READID_METHOD_OPCODE_DUMMY, 0x14),
+		     NAND_MEMORG(1, 2048, 128, 64, 1024, 20, 1, 1, 1),
+		     NAND_ECCREQ(8, 512),
+		     SPINAND_INFO_OP_VARIANTS(&read_cache_variants,
+					      &write_cache_variants,
+					      &update_cache_variants),
+		     0,
+		     SPINAND_ECCINFO(&micron_8_ooblayout,
+				     micron_8_ecc_get_status)),
+	/* M78A 1Gb 1.8V */
+	SPINAND_INFO("MT29F1G01ABAFD",
+		     SPINAND_ID(SPINAND_READID_METHOD_OPCODE_DUMMY, 0x15),
+		     NAND_MEMORG(1, 2048, 128, 64, 1024, 20, 1, 1, 1),
+		     NAND_ECCREQ(8, 512),
+		     SPINAND_INFO_OP_VARIANTS(&read_cache_variants,
+					      &write_cache_variants,
+					      &update_cache_variants),
+		     0,
+		     SPINAND_ECCINFO(&micron_8_ooblayout,
+				     micron_8_ecc_get_status)),
 };
 
 static const struct spinand_manufacturer_ops micron_spinand_manuf_ops = {
-- 
2.17.1

