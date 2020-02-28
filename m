Return-Path: <SRS0=RI2K=4Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F535C3F2D2
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Feb 2020 15:03:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F0C99246A0
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Feb 2020 15:03:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Yt7bhk+E"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727272AbgB1PDg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Feb 2020 10:03:36 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:40021 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727146AbgB1PDa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Feb 2020 10:03:30 -0500
Received: by mail-wm1-f68.google.com with SMTP id d138so1929954wmd.5
        for <linux-kernel@vger.kernel.org>; Fri, 28 Feb 2020 07:03:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=7lXgaGBU6RYi6U6zxTiRxw0HA/EAYgc0JnTYQzLHUZg=;
        b=Yt7bhk+ENJ0+20JWOjeP07IHp6/l2GaI7OAAmy+wWxJelVnwHkVGJEeZKhp3uMOAlo
         q7h99wMHcYifGhVKjZhcHS7SYPprreZHm8Q3WirytJbBe0/7tUf/VgSxoc0wD3QUF2B3
         LHQOMgRrZ1/p6hxjO2YLEbfCLsMjt/JSF1UkfMCHZoftUoace7tMq75YF87sa+5HgXvG
         0qKH+Hf19+P3rNRPfgE6W9uFhs4HSeBO9Ce4teUIvWj+dfrdCJHpwlhan5hQapuM6/Q0
         K553+xHU/CCwaqg8NbCI4TRp2Jho7GJnz9W+XeqPGLEFu25pjo3BZllZcafRCLI6vg0k
         6KuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=7lXgaGBU6RYi6U6zxTiRxw0HA/EAYgc0JnTYQzLHUZg=;
        b=SuRDVWqxHbOrdTkvSUu2XIjL8a3wti6nfjZupKOhRq5lzftoUl/HAAsUqjLptkM51s
         7Ja37Xv5PPvdV7zg5KznFcxe+jH13+mR20F99aIUT5G4CAzHgM0Yd6pEKv2vwoDL66ad
         u5o7VJ3T3fiflrHFLYB4mjAHnkS5778aeJ3t4tOqb5rnVDKNJebwnsKZRVcnuf//yTPg
         XpUjUKSBUnBmYDB2fCdfgHjqe3VHWJ5MZdYIZO2b+fRhps165WDKsLMhFRzEmFkPT6hV
         yh1NuS8b3mUZgMBf8hUnTIs/eE78JzNs7wWQFctfSdCnjIqOaWkI8uA7V3quXeuKxPYK
         P4Bg==
X-Gm-Message-State: APjAAAUomXI5JK2Tpch1GLHyhQS386blFpLXMuUeMRjtqnq9Z1O3px5g
        tmRNrPX+TxKBxVqvlH19Gsk=
X-Google-Smtp-Source: APXvYqwLtcbwsuxCNxlsNHVIzG6exxjFIwXn6oqPLoldfp0vfOpewiIda5EYmi6CMdBe26/w6qJHWQ==
X-Received: by 2002:a1c:6588:: with SMTP id z130mr5182676wmb.0.1582902208311;
        Fri, 28 Feb 2020 07:03:28 -0800 (PST)
Received: from opensdev.fritz.box (business-178-015-117-054.static.arcor-ip.net. [178.15.117.54])
        by smtp.gmail.com with ESMTPSA id m125sm2540235wmf.8.2020.02.28.07.03.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Feb 2020 07:03:27 -0800 (PST)
From:   shiva.linuxworks@gmail.com
X-Google-Original-From: sshivamurthy@micron.com
To:     Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Boris Brezillon <bbrezillon@kernel.org>,
        Frieder Schrempf <frieder.schrempf@kontron.de>,
        linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Shivamurthy Shastri <sshivamurthy@micron.com>
Subject: [PATCH v5 5/6] mtd: spinand: micron: Add M70A series Micron SPI NAND devices
Date:   Fri, 28 Feb 2020 16:03:10 +0100
Message-Id: <20200228150311.12184-6-sshivamurthy@micron.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200228150311.12184-1-sshivamurthy@micron.com>
References: <20200228150311.12184-1-sshivamurthy@micron.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Shivamurthy Shastri <sshivamurthy@micron.com>

Add device table for M70A series Micron SPI NAND devices.

Signed-off-by: Shivamurthy Shastri <sshivamurthy@micron.com>
Reviewed-by: Boris Brezillon <boris.brezillon@collabora.com>
---
 drivers/mtd/nand/spi/micron.c | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/drivers/mtd/nand/spi/micron.c b/drivers/mtd/nand/spi/micron.c
index ff0a3c01441d..9db1ab71fcae 100644
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

