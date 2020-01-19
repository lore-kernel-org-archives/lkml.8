Return-Path: <SRS0=pPEE=3I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D190CC33CB1
	for <linux-kernel@archiver.kernel.org>; Sun, 19 Jan 2020 14:56:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9B97B206D7
	for <linux-kernel@archiver.kernel.org>; Sun, 19 Jan 2020 14:56:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ejm+XPPY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728665AbgASO46 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 19 Jan 2020 09:56:58 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:34363 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726778AbgASO46 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Jan 2020 09:56:58 -0500
Received: by mail-wr1-f66.google.com with SMTP id t2so26964846wrr.1
        for <linux-kernel@vger.kernel.org>; Sun, 19 Jan 2020 06:56:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=AW6o0c/04VtmM4Wr/JwMdnRs9yEuZbHl3Nv4hAkPBgU=;
        b=ejm+XPPY2TzWFTaiaS6jz5ri/6+6mKJffpNjK7NHgP3WzikiM2XAPWV9eM21eni/L3
         RAKD3XVFLjApXTiQTE5c0QKGabNOIBmEIsX13t6Jto4pdV46n6HtPlCwR9G2e8UAUPS8
         shi+C3ddaOr/LtJcOsZr6tIhXU/jMZEqAfYz+oGjsBY0PCZ4Xo5m+5ez/QVeJVV+rwGd
         VUglSjrSXPW6uW09472FgbOKTPuk+RtX263/lDH7hZ4P4tVdGPodRt0LunouzkW5pqXa
         rt4VlRHZUyO6OTxmksvsBusisU/MLKvCuDoQbTEhbMbx6J3Ib5D2w1Xt6OFNytjtrZw8
         pHQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=AW6o0c/04VtmM4Wr/JwMdnRs9yEuZbHl3Nv4hAkPBgU=;
        b=NrCS6WojtbR19zCB6WSWgxKlxaJIyYMMnL6zWRycCYDydjtnJyrzwoPG8+pjnC74Ho
         HtyOJ+GuGr/9gbBIm5KxOjhv/myYGzPZPq1B0//erILYHGm8mX+v2UFJpmvqo1qwf4F7
         84K77qGT3cAuiUrm+oq4sxiknD+G4qh2g8Ul7zVRTwsQyASxBqJlYeZGgWkmrlG3hwCY
         uhZCBOTH1Bd7iLQw6/ywGhCJ5VMTfvUp0DXmG4AFgYCE16hjgZJ3tEcinUGt6fCAWiAm
         3aypORJig0gmHSRtfEYZODM3xlC80M9a1A5kM1+nTEn6kk8sLprRfHk73D34zHkFuEMV
         BjpA==
X-Gm-Message-State: APjAAAVDRq1Nn4LlSvsjuDAm3w4zXGR3smaMRXVK1sIdukay4WZQ9Ue7
        O1hMI0m/z5hvDYCvlRkDxSk=
X-Google-Smtp-Source: APXvYqxM78lY5I9+HBe7+4CcP13C7M2zs76YhQ/QJ8xDc45GVIxEYIgFZ+5+x8+MVQxQDkpo7tSo/Q==
X-Received: by 2002:a5d:558d:: with SMTP id i13mr13580848wrv.364.1579445816214;
        Sun, 19 Jan 2020 06:56:56 -0800 (PST)
Received: from opensdev.fritz.box (business-178-015-117-054.static.arcor-ip.net. [178.15.117.54])
        by smtp.gmail.com with ESMTPSA id p17sm43347877wrx.20.2020.01.19.06.56.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 19 Jan 2020 06:56:55 -0800 (PST)
From:   shiva.linuxworks@gmail.com
X-Google-Original-From: sshivamurthy@micron.com
To:     Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Boris Brezillon <bbrezillon@kernel.org>,
        Frieder Schrempf <frieder.schrempf@kontron.de>,
        linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Shivamurthy Shastri <sshivamurthy@micron.com>
Subject: [PATCH 3/4] mtd: spinand: Add M70A series Micron SPI NAND devices
Date:   Sun, 19 Jan 2020 15:54:31 +0100
Message-Id: <20200119145432.10405-4-sshivamurthy@micron.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200119145432.10405-1-sshivamurthy@micron.com>
References: <20200119145432.10405-1-sshivamurthy@micron.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Shivamurthy Shastri <sshivamurthy@micron.com>

Add device table for M70A series Micron SPI NAND devices.

While at it, disable the Continuous Read feature which is enabled by
default.

Signed-off-by: Shivamurthy Shastri <sshivamurthy@micron.com>
---
 drivers/mtd/nand/spi/micron.c | 31 +++++++++++++++++++++++++++++++
 1 file changed, 31 insertions(+)

diff --git a/drivers/mtd/nand/spi/micron.c b/drivers/mtd/nand/spi/micron.c
index 5fd1f921ef12..45fc37c58f8a 100644
--- a/drivers/mtd/nand/spi/micron.c
+++ b/drivers/mtd/nand/spi/micron.c
@@ -131,6 +131,26 @@ static const struct spinand_info micron_spinand_table[] = {
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
+		     0,
+		     SPINAND_ECCINFO(&micron_8_ooblayout,
+				     micron_8_ecc_get_status)),
+	/* M70A 4Gb 1.8V */
+	SPINAND_INFO("MT29F4G01ABBFD", 0x35,
+		     NAND_MEMORG(1, 4096, 256, 64, 2048, 40, 1, 1, 1),
+		     NAND_ECCREQ(8, 512),
+		     SPINAND_INFO_OP_VARIANTS(&read_cache_variants,
+					      &write_cache_variants,
+					      &update_cache_variants),
+		     0,
+		     SPINAND_ECCINFO(&micron_8_ooblayout,
+				     micron_8_ecc_get_status)),
 };
 
 static int micron_spinand_detect(struct spinand_device *spinand)
@@ -153,8 +173,19 @@ static int micron_spinand_detect(struct spinand_device *spinand)
 	return 1;
 }
 
+static int micron_spinand_init(struct spinand_device *spinand)
+{
+	/*
+	 * M70A device series enable Continuous Read feature at Power-up,
+	 * which is not supported. Disable this bit to avoid any possible
+	 * failure.
+	 */
+	return spinand_upd_cfg(spinand, CFG_QUAD_ENABLE, 0);
+}
+
 static const struct spinand_manufacturer_ops micron_spinand_manuf_ops = {
 	.detect = micron_spinand_detect,
+	.init = micron_spinand_init,
 };
 
 const struct spinand_manufacturer micron_spinand_manufacturer = {
-- 
2.17.1

