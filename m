Return-Path: <SRS0=VwT+=6S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B48F2C3A5A9
	for <linux-kernel@archiver.kernel.org>; Mon,  4 May 2020 09:42:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 85DE6206D9
	for <linux-kernel@archiver.kernel.org>; Mon,  4 May 2020 09:42:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YAPUKxvx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728419AbgEDJm6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 May 2020 05:42:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726625AbgEDJm6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 May 2020 05:42:58 -0400
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0BE7CC061A0E
        for <linux-kernel@vger.kernel.org>; Mon,  4 May 2020 02:42:58 -0700 (PDT)
Received: by mail-wr1-x443.google.com with SMTP id k1so1247368wro.12
        for <linux-kernel@vger.kernel.org>; Mon, 04 May 2020 02:42:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=2PePijgL48hP/OTqwgfZQihDqRN1L4nqpcMBBw+8WKI=;
        b=YAPUKxvx+4km4cbaUEcywVQhHgIxiSBOQ5OVl/vRzJ2S6bE1gnc9gFa6K9CkC5yi1W
         iQ3S//xRpTSHs2QzUeHCRYVICFmDr/vYtuG/M9t3sjfgWZP51vzjw1KnQz00w6JOoUAE
         yZeo0P/Yz9vYxE+9sFoOStkJ4Im/FxmrR4w9D2fKGURQtgPrPDDfcByfXjyKFGARcOe8
         ETk+bSbup5WIH0xyOLUOcIsdzWKGyC4uaMESxI9WvAtBW1sWajmCduk7qp8sF9lInF4x
         vHKN6VME3dq7701qfMTr33lCNKfSApD7gDWBTXbjYSi1Zdg5CfV2+maidl81rMD0zJUY
         FxBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=2PePijgL48hP/OTqwgfZQihDqRN1L4nqpcMBBw+8WKI=;
        b=OC6aCSCXz2mUOxLXo1iWGcjt8527T8hWs3BrDFGHjHRweJ+oQ255tRZGggpXp/mzqZ
         1nk8G7OWL9hODjcVKEfb5zuc9ObYMoTbXbe8a6FQ4ZrVAQsG9s3rPe4qvgUE4mWIIiej
         OeuUaUy0y2eQNPMD94VfgktrG1bdqu+dJQEXCiT08yiXXVJTcKVHRAURPQMJIoqsTsyL
         DH8EBNqc4IjEiDrZ7lQzdu2FYh0QdHbKD50dR2ulM9ONheGdcjCQQs9Cs713d33F/d5G
         2G9oDTMIhZxHK43vU5ssMkUZxuk+l2Ls+wab+iK+AsiuGG3f+C+KYRTIvhXAtipFfH3x
         i+RQ==
X-Gm-Message-State: AGi0PuYdVSOYFs2JcdBYBbw29CBSGDaInwTfeuBfMe8PHWrqSY01cIRi
        SImuSoLiFhQ7tRcwbbLiDUM=
X-Google-Smtp-Source: APiQypK+dr+ELxw+9DPmzTETNW0ltDp0Q8pW07j0x7GzYI+R7bAmqMx+tn87tLGhzxVjL+7zMe/gfA==
X-Received: by 2002:adf:f34e:: with SMTP id e14mr18325177wrp.193.1588585376769;
        Mon, 04 May 2020 02:42:56 -0700 (PDT)
Received: from skynet.lan (246.red-83-44-9.dynamicip.rima-tde.net. [83.44.9.246])
        by smtp.gmail.com with ESMTPSA id f63sm12349892wma.47.2020.05.04.02.42.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 May 2020 02:42:56 -0700 (PDT)
From:   =?UTF-8?q?=C3=81lvaro=20Fern=C3=A1ndez=20Rojas?= 
        <noltari@gmail.com>
To:     miquel.raynal@bootlin.com, richard@nod.at, vigneshr@ti.com,
        s.hauer@pengutronix.de, masonccyang@mxic.com.tw,
        boris.brezillon@collabora.com, christophe.kerello@st.com,
        stefan@agner.ch, piotrs@cadence.com, devik@eaxlabs.cz,
        tglx@linutronix.de, linux-mtd@lists.infradead.org,
        linux-kernel@vger.kernel.org
Cc:     =?UTF-8?q?=C3=81lvaro=20Fern=C3=A1ndez=20Rojas?= 
        <noltari@gmail.com>
Subject: [PATCH] nand: raw: use write_oob_raw for MTD_OPS_AUTO_OOB mode
Date:   Mon,  4 May 2020 11:42:53 +0200
Message-Id: <20200504094253.2741109-1-noltari@gmail.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some NAND controllers change the ECC bytes when OOB is written with ECC
enabled.
This is a problem in brcmnand, since adding JFFS2 cleanmarkers after the page
has been erased will change the ECC bytes to 0 and the controller will think
the block is bad.
It can be fixed by using write_oob_raw, which ensures ECC is disabled.

Signed-off-by: Álvaro Fernández Rojas <noltari@gmail.com>
---
 drivers/mtd/nand/raw/nand_base.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mtd/nand/raw/nand_base.c b/drivers/mtd/nand/raw/nand_base.c
index c24e5e2ba130..755d25200520 100644
--- a/drivers/mtd/nand/raw/nand_base.c
+++ b/drivers/mtd/nand/raw/nand_base.c
@@ -488,7 +488,7 @@ static int nand_do_write_oob(struct nand_chip *chip, loff_t to,
 
 	nand_fill_oob(chip, ops->oobbuf, ops->ooblen, ops);
 
-	if (ops->mode == MTD_OPS_RAW)
+	if (ops->mode == MTD_OPS_AUTO_OOB || ops->mode == MTD_OPS_RAW)
 		status = chip->ecc.write_oob_raw(chip, page & chip->pagemask);
 	else
 		status = chip->ecc.write_oob(chip, page & chip->pagemask);
-- 
2.26.2

