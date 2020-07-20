Return-Path: <SRS0=bl3x=A7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F792C433E4
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jul 2020 16:12:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3172B2064B
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jul 2020 16:12:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1595261535;
	bh=a5p/PGrgE3LfAzXMjOdE76SDBJjokvE6/Vgf84gvCjs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=VmkQ+nqle3s9gEP3/clTfx+1O2ErOfhV0gld333BOepnhsRddkQWuPJIFUAu+cbYS
	 t0w88oXQanWOnjEzyA7a6cLTl5ui8H4msHNzeGa1dU+7l0bP4+kkYAkcDcG6lit9nQ
	 FTY6Hie96EOCpvQuApyshHtEqlMRRYPRJtURLJ5g=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387926AbgGTQMO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Jul 2020 12:12:14 -0400
Received: from mail.kernel.org ([198.145.29.99]:51534 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387499AbgGTQMG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jul 2020 12:12:06 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C9CC82065E;
        Mon, 20 Jul 2020 16:12:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1595261525;
        bh=a5p/PGrgE3LfAzXMjOdE76SDBJjokvE6/Vgf84gvCjs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=o23GEvEdedyfY48MnI/rmOEa8F+GtNELW783EXjHRzRcBytMskmrfruvLoPf3eTjw
         gNXBt+AjaKWd1eObIH3NxlE3b0W0DwtuwzAVLOuEDwlSpcjSK77yU/tZDgtRrRaAiJ
         AlXTIfmuAzUuwNAYMlVRBN3fKvKImNO79vtWrTNs=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Miquel Raynal <miquel.raynal@bootlin.com>
Subject: [PATCH 5.7 140/244] mtd: rawnand: oxnas: Keep track of registered devices
Date:   Mon, 20 Jul 2020 17:36:51 +0200
Message-Id: <20200720152832.508993328@linuxfoundation.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200720152825.863040590@linuxfoundation.org>
References: <20200720152825.863040590@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Miquel Raynal <miquel.raynal@bootlin.com>

commit 383fc3f613e7eac9f2e3c13b6f9fb8c1f39cb9d5 upstream.

All initialized and registered devices should be listed somewhere so
that we can unregister/free them in the _remove() path.

This patch is not a fix per-se but is needed to apply three other
fixes coming right after, explaining the Fixes/Cc: stable tags.

Fixes: 668592492409 ("mtd: nand: Add OX820 NAND Support")
Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
Link: https://lore.kernel.org/linux-mtd/20200519130035.1883-36-miquel.raynal@bootlin.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/mtd/nand/raw/oxnas_nand.c |    8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

--- a/drivers/mtd/nand/raw/oxnas_nand.c
+++ b/drivers/mtd/nand/raw/oxnas_nand.c
@@ -32,6 +32,7 @@ struct oxnas_nand_ctrl {
 	void __iomem *io_base;
 	struct clk *clk;
 	struct nand_chip *chips[OXNAS_NAND_MAX_CHIPS];
+	unsigned int nchips;
 };
 
 static uint8_t oxnas_nand_read_byte(struct nand_chip *chip)
@@ -79,7 +80,6 @@ static int oxnas_nand_probe(struct platf
 	struct nand_chip *chip;
 	struct mtd_info *mtd;
 	struct resource *res;
-	int nchips = 0;
 	int count = 0;
 	int err = 0;
 
@@ -143,12 +143,12 @@ static int oxnas_nand_probe(struct platf
 		if (err)
 			goto err_cleanup_nand;
 
-		oxnas->chips[nchips] = chip;
-		++nchips;
+		oxnas->chips[oxnas->nchips] = chip;
+		++oxnas->nchips;
 	}
 
 	/* Exit if no chips found */
-	if (!nchips) {
+	if (!oxnas->nchips) {
 		err = -ENODEV;
 		goto err_clk_unprepare;
 	}


