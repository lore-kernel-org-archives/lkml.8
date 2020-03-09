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
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0D68C10F29
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Mar 2020 11:55:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7493C227BF
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Mar 2020 11:55:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VY3Na1mL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726621AbgCILzo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Mar 2020 07:55:44 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:50823 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726556AbgCILzm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Mar 2020 07:55:42 -0400
Received: by mail-wm1-f68.google.com with SMTP id a5so9551903wmb.0
        for <linux-kernel@vger.kernel.org>; Mon, 09 Mar 2020 04:55:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=7lXgaGBU6RYi6U6zxTiRxw0HA/EAYgc0JnTYQzLHUZg=;
        b=VY3Na1mLM78VKAyOTeoV1Njv3SZVtsUYheUrE33KJg1MCMxT0E6frrxkRQzFh+TaGp
         7K1LE7UV+tI8XBABegzy8dWa1xZfaDGIS+9pYWHLZGmB6m9NmyVgXRHwJKp8rFCZETd1
         7Y+4CKw1rya+E9PBH333GawS2NLDRSOKxQ7qZ2tS/7hiRTmzAOob4zOZdtHeB8oNuCOE
         CVp/LIh9z5Yw9IZAujMMymIZasQIS92aeNTgdQcKrco3cPO9v6xxMnk9rgA/BJtdUmGH
         v4sOKpCrAfM4jClj62oQcBb562MjcrastX+X1wMrblktCqFg4A99iqPVa0/MlV3RZg4E
         i4NA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=7lXgaGBU6RYi6U6zxTiRxw0HA/EAYgc0JnTYQzLHUZg=;
        b=XpWMPjXCcKhQlVBiXJSwPf+X3OOCzrAQRfqOA9LYcZziMIiP654jvP5gVR0Wes2Jp0
         R+NFaPaCDIWpjwBK7ZOjB34s/gJUvHYhAUnpDPcoT+FZQX11Eld0/K/RZBYY2H2/Aljp
         Pa0IemACrTuUuAXJPyhLKGtVi/pnEGvl76CK7Gt8GOAxx0l8w9Wxt7JPd+ZGkLshhNza
         0URsgKsXHkRH+8ceOfc/0hjccH57FUi6WtAweP6tdJhTAl4pz1t67Crs2zuNDph9t7On
         Yf4drmLFlSYU2GqdEay6lsI36r4BGP+N3Eso465MIS0CgqbnqtLr2mkKAmXM1RErI2bA
         VEEw==
X-Gm-Message-State: ANhLgQ3DrGTOaScRjSlAKUI/HqjrOir2V9hP/odaz1CRopr+07by9BbO
        1yWo5EsqjarEGD9GFlnTL5c=
X-Google-Smtp-Source: ADFU+vvejN3V2BjAHmFzd1LQdR64g8eDfBcDa6OWHYqV6LCuJXOwg9pJLSW6FlI5cvJYQ97jFw4lvw==
X-Received: by 2002:a7b:c189:: with SMTP id y9mr7341078wmi.47.1583754940859;
        Mon, 09 Mar 2020 04:55:40 -0700 (PDT)
Received: from opensdev.fritz.box (business-178-015-117-054.static.arcor-ip.net. [178.15.117.54])
        by smtp.gmail.com with ESMTPSA id m21sm25035226wmi.27.2020.03.09.04.55.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Mar 2020 04:55:40 -0700 (PDT)
From:   shiva.linuxworks@gmail.com
X-Google-Original-From: sshivamurthy@micron.com
To:     Miquel Raynal <miquel.raynal@bootlin.com>,
        Boris Brezillon <boris.brezillon@collabora.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Frieder Schrempf <frieder.schrempf@kontron.de>,
        linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Shivamurthy Shastri <sshivamurthy@micron.com>
Subject: [PATCH v6 5/6] mtd: spinand: micron: Add M70A series Micron SPI NAND devices
Date:   Mon,  9 Mar 2020 12:52:29 +0100
Message-Id: <20200309115230.7207-6-sshivamurthy@micron.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200309115230.7207-1-sshivamurthy@micron.com>
References: <20200309115230.7207-1-sshivamurthy@micron.com>
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

