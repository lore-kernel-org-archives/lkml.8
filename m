Return-Path: <SRS0=fsZL=42=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DAC7BC10F27
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Mar 2020 11:55:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B2114205ED
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Mar 2020 11:55:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="C5LI8m8X"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726656AbgCILzy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Mar 2020 07:55:54 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:46185 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725942AbgCILzj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Mar 2020 07:55:39 -0400
Received: by mail-wr1-f67.google.com with SMTP id n15so10676132wrw.13
        for <linux-kernel@vger.kernel.org>; Mon, 09 Mar 2020 04:55:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=z66mLROcRb3dfNo7Pup4ya4KCgpDgjiDJSKhfyea8EI=;
        b=C5LI8m8XGg1Da5YEMZokiczeYXHDjbtXmogn0yFNebuJYcxWCAzewHRqGcjvTHxGZ7
         o8qpUoBMpO3KvnqC540gtySoZ9HVSLcNMJ1fEE96pxJV31UjaSB80ayRSwzwRsSUwfoE
         6J8qWiU4UU5U8UA0exmkktcjI3SusYLLmH+fcEKkB8vhbThvyjSA2sXmX6lPWpnhe7/h
         zubFc1sQqQWDNRprFfbST3DYQHH6r7wGiM24Dj/RhAfXB4TPdnadO8pKx7LHaUvyukdt
         Mpv+CJIwUhElZ1lxxbrMRwj/eRUbMK8FZ0QPMB0gLUqr6oUj/jIVY4XywgOfXVIINHho
         RWww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=z66mLROcRb3dfNo7Pup4ya4KCgpDgjiDJSKhfyea8EI=;
        b=M5xnYsWAP1oWbDwPdZX3i932jrtoGUm0VgfLlLjTqXH7u/NfQIom4VENrq+e0iK9Pb
         Z3nqbvOzmn9mYKjk6spLsCbYzv4FZaBJyn/fbXoCZS6gVl9gXQZon/LmeccTaO0PGTzm
         NksRZzXlqou3QyWEfPF1krM1RraLlyuIQbvbNogA7n6HiPWFG0JX4slT4hgc8cwNW385
         eoppFW3igqs20efV+TnGa4grw5bqpwiNHS9fCGMspb6c/OeO4Ostjjjcp8ArVZc+miB5
         lkg9CdkyAkeOIAhHN+nTc/2k1/9qSf30dQUE75vrOGw2yRTpF1GzZM/stYWW7ZWpcqUa
         uuMw==
X-Gm-Message-State: ANhLgQ3cyj+m+twy+djICgRWXncBcq0QBIc8bn43sqsck2NnIu7RZUZ3
        zKOahmjazr8HOYiOsLdtUDs=
X-Google-Smtp-Source: ADFU+vuFhLKerED7/hwBHARTqvsG0m5QiOg9kGgkhvKZSqKwWDcZkDRZx3aa74XyqUaBz0k4PW1kmw==
X-Received: by 2002:adf:ee52:: with SMTP id w18mr14485829wro.369.1583754938144;
        Mon, 09 Mar 2020 04:55:38 -0700 (PDT)
Received: from opensdev.fritz.box (business-178-015-117-054.static.arcor-ip.net. [178.15.117.54])
        by smtp.gmail.com with ESMTPSA id m21sm25035226wmi.27.2020.03.09.04.55.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Mar 2020 04:55:37 -0700 (PDT)
From:   shiva.linuxworks@gmail.com
X-Google-Original-From: sshivamurthy@micron.com
To:     Miquel Raynal <miquel.raynal@bootlin.com>,
        Boris Brezillon <boris.brezillon@collabora.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Frieder Schrempf <frieder.schrempf@kontron.de>,
        linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Shivamurthy Shastri <sshivamurthy@micron.com>
Subject: [PATCH v6 3/6] mtd: spinand: micron: Add new Micron SPI NAND devices
Date:   Mon,  9 Mar 2020 12:52:27 +0100
Message-Id: <20200309115230.7207-4-sshivamurthy@micron.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200309115230.7207-1-sshivamurthy@micron.com>
References: <20200309115230.7207-1-sshivamurthy@micron.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Shivamurthy Shastri <sshivamurthy@micron.com>

Add device table for M79A and M78A series Micron SPI NAND devices.

Signed-off-by: Shivamurthy Shastri <sshivamurthy@micron.com>
---
 drivers/mtd/nand/spi/micron.c | 30 ++++++++++++++++++++++++++++++
 1 file changed, 30 insertions(+)

diff --git a/drivers/mtd/nand/spi/micron.c b/drivers/mtd/nand/spi/micron.c
index e4aeafc56f4e..5fd1f921ef12 100644
--- a/drivers/mtd/nand/spi/micron.c
+++ b/drivers/mtd/nand/spi/micron.c
@@ -101,6 +101,36 @@ static const struct spinand_info micron_spinand_table[] = {
 		     0,
 		     SPINAND_ECCINFO(&micron_8_ooblayout,
 				     micron_8_ecc_get_status)),
+	/* M79A 2Gb 1.8V */
+	SPINAND_INFO("MT29F2G01ABBGD", 0x25,
+		     NAND_MEMORG(1, 2048, 128, 64, 2048, 40, 2, 1, 1),
+		     NAND_ECCREQ(8, 512),
+		     SPINAND_INFO_OP_VARIANTS(&read_cache_variants,
+					      &write_cache_variants,
+					      &update_cache_variants),
+		     0,
+		     SPINAND_ECCINFO(&micron_8_ooblayout,
+				     micron_8_ecc_get_status)),
+	/* M78A 1Gb 3.3V */
+	SPINAND_INFO("MT29F1G01ABAFD", 0x14,
+		     NAND_MEMORG(1, 2048, 128, 64, 1024, 20, 1, 1, 1),
+		     NAND_ECCREQ(8, 512),
+		     SPINAND_INFO_OP_VARIANTS(&read_cache_variants,
+					      &write_cache_variants,
+					      &update_cache_variants),
+		     0,
+		     SPINAND_ECCINFO(&micron_8_ooblayout,
+				     micron_8_ecc_get_status)),
+	/* M78A 1Gb 1.8V */
+	SPINAND_INFO("MT29F1G01ABAFD", 0x15,
+		     NAND_MEMORG(1, 2048, 128, 64, 1024, 20, 1, 1, 1),
+		     NAND_ECCREQ(8, 512),
+		     SPINAND_INFO_OP_VARIANTS(&read_cache_variants,
+					      &write_cache_variants,
+					      &update_cache_variants),
+		     0,
+		     SPINAND_ECCINFO(&micron_8_ooblayout,
+				     micron_8_ecc_get_status)),
 };
 
 static int micron_spinand_detect(struct spinand_device *spinand)
-- 
2.17.1

