Return-Path: <SRS0=RcPI=7S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A460C433DF
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Jun 2020 17:08:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 03ECB2074B
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Jun 2020 17:08:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MfmHhx/s"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727041AbgFERIA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Jun 2020 13:08:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726044AbgFERH7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Jun 2020 13:07:59 -0400
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EACD4C08C5C2;
        Fri,  5 Jun 2020 10:07:57 -0700 (PDT)
Received: by mail-wr1-x441.google.com with SMTP id t18so10506843wru.6;
        Fri, 05 Jun 2020 10:07:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=rDqQJ0wEgnJldHfGesJHf9Wkye5+SA00t8jjMKl0QrU=;
        b=MfmHhx/s/MTQcyaBDQ3BExt/ArOMQW+pjtqKR8qDzCdLrlOhZs5baL0eeGXWaOYUfY
         zXmD41obhUqDcVNLvecHxsXpuXdSnAKrLFNKqrCcB/ZH+kSw7vjkfjbhljGI+F7FQ//Y
         XgJCzLXSkN2JcXS3qmAy/3p4frjkltzSNj3nBxoacJ/axaEk45gcMBdX0CFsUNybuxzY
         RpudbUm3VCdtS+IOZ5UPxPEpQ9FUB7PtJlIcU+mgMcuNHF6LpchQzs3DGzhMhjPLVGCc
         FmDm6Q3Gua8ngZaNaFnW/S6G5JgXfU2SZncCrg/KQ60g712xnsoFZS6SW+9o9LLc3pv4
         hRoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=rDqQJ0wEgnJldHfGesJHf9Wkye5+SA00t8jjMKl0QrU=;
        b=NFImlL0txZr5HAl/z7SRb3GkxRjDqyrUJTet4vSZxutNyPDyndhXWoOCX8yqxAscfF
         FMDhk1eyg4X/EyYHzAY+FhhfHrKXDW1UQMekyj1XtB1/UxNGAE9N22EsN9VFyf1J5NrE
         OQvIXYWDVbc6nnnRKwD1ozA1t/jm0A/cGJGZqpoOWDBWtnKbXyng9eRBrnVeaybZ5VZt
         CKZ9xZYIAcnwPlF/ZoYeoWMmitt3WwHjAaz8kfJ9vl2nUt35tlxtpI0juYmgnPJPSLoL
         zmcmIyRP34bwzLKI8aQUCRtdPNxNJ25aXjVpz1pM361rU+UKjExF6F5U5pNBweMDHI0J
         6oQg==
X-Gm-Message-State: AOAM531rhVvxgkDrgyw0h9y+Cv6B3W4PH+7qa/3OVvU31+1tN5SdlTD2
        i3P8f9Blx5f3nZpKcSDl0Dc=
X-Google-Smtp-Source: ABdhPJzDT5SK9P6EKvrzWRuo4fxLa13YPkg+G9cBgaVHHl8YQkloc/wJYK3pvB31wWuMlrG3msflAw==
X-Received: by 2002:adf:f988:: with SMTP id f8mr11453118wrr.81.1591376876540;
        Fri, 05 Jun 2020 10:07:56 -0700 (PDT)
Received: from skynet.lan (28.red-83-49-61.dynamicip.rima-tde.net. [83.49.61.28])
        by smtp.gmail.com with ESMTPSA id h7sm11820797wml.24.2020.06.05.10.07.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Jun 2020 10:07:56 -0700 (PDT)
From:   =?UTF-8?q?=C3=81lvaro=20Fern=C3=A1ndez=20Rojas?= 
        <noltari@gmail.com>
To:     computersforpeace@gmail.com, kdasu.kdev@gmail.com,
        miquel.raynal@bootlin.com, richard@nod.at, vigneshr@ti.com,
        sumit.semwal@linaro.org, linux-mtd@lists.infradead.org,
        bcm-kernel-feedback-list@broadcom.com,
        linux-kernel@vger.kernel.org, linux-media@vger.kernel.org,
        dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org
Cc:     =?UTF-8?q?=C3=81lvaro=20Fern=C3=A1ndez=20Rojas?= 
        <noltari@gmail.com>
Subject: [PATCH] mtd: rawnand: brcmnand: force raw OOB writes
Date:   Fri,  5 Jun 2020 19:07:20 +0200
Message-Id: <20200605170720.2478262-1-noltari@gmail.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

MTD_OPS_AUTO_OOB is writting OOB with ECC enabled, which changes all ECC bytes
from an erased page to 0x00 when JFFS2 cleanmarkers are added with mtd-utils.
         | BBI |   JFFS2   |   ECC   |   JFFS2   | Spare  |
00000800  ff ff 19 85 20 03 00 00  00 00 00 00 08 ff ff ff

However, if OOB is written with ECC disabled, the JFFS2 cleanmarkers are
correctly written without changing the ECC bytes:
         | BBI |   JFFS2   |   ECC   |   JFFS2   | Spare  |
00000800  ff ff 19 85 20 03 ff ff  ff 00 00 00 08 ff ff ff

Signed-off-by: Álvaro Fernández Rojas <noltari@gmail.com>
---
 drivers/mtd/nand/raw/brcmnand/brcmnand.c | 9 +--------
 1 file changed, 1 insertion(+), 8 deletions(-)

diff --git a/drivers/mtd/nand/raw/brcmnand/brcmnand.c b/drivers/mtd/nand/raw/brcmnand/brcmnand.c
index 8f9ffb46a09f..566281770841 100644
--- a/drivers/mtd/nand/raw/brcmnand/brcmnand.c
+++ b/drivers/mtd/nand/raw/brcmnand/brcmnand.c
@@ -2279,13 +2279,6 @@ static int brcmnand_write_page_raw(struct nand_chip *chip, const uint8_t *buf,
 	return nand_prog_page_end_op(chip);
 }
 
-static int brcmnand_write_oob(struct nand_chip *chip, int page)
-{
-	return brcmnand_write(nand_to_mtd(chip), chip,
-			      (u64)page << chip->page_shift, NULL,
-			      chip->oob_poi);
-}
-
 static int brcmnand_write_oob_raw(struct nand_chip *chip, int page)
 {
 	struct mtd_info *mtd = nand_to_mtd(chip);
@@ -2642,7 +2635,7 @@ static int brcmnand_init_cs(struct brcmnand_host *host, struct device_node *dn)
 	chip->ecc.write_oob_raw = brcmnand_write_oob_raw;
 	chip->ecc.read_oob_raw = brcmnand_read_oob_raw;
 	chip->ecc.read_oob = brcmnand_read_oob;
-	chip->ecc.write_oob = brcmnand_write_oob;
+	chip->ecc.write_oob = brcmnand_write_oob_raw;
 
 	chip->controller = &ctrl->controller;
 
-- 
2.26.2

