Return-Path: <SRS0=bl3x=A7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC8E3C433E8
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jul 2020 16:03:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CB20720672
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jul 2020 16:03:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1595260991;
	bh=3DIIuFvolpU1ejUNjM2ZXn6NWLeSQpweIh1U63zDc4M=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=G2qpBLUzq+kGg04+3juWI9HfAx3EqOhHBU3nzouMO86GXMQ3ZgGT8NSGpLwRfDyYr
	 OBivPbP9Q8Cqu8X0A9eKaHRTIyv2vdHgTyGrdWIyUDrR8/TMBxPrzY5SuNWo8+OYW3
	 SXt/5BJ5Hm6kst7rWIV6i0tsHav9+56qKL1Fc7S4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729460AbgGTQDL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Jul 2020 12:03:11 -0400
Received: from mail.kernel.org ([198.145.29.99]:37328 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732419AbgGTQDI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jul 2020 12:03:08 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7EB7720672;
        Mon, 20 Jul 2020 16:03:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1595260988;
        bh=3DIIuFvolpU1ejUNjM2ZXn6NWLeSQpweIh1U63zDc4M=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=n8y1E+mw5V1IiSF+LyBxTJ6sPij4VQz7fun6mYSwvqr+428XIqfUseKQKPqx46R1J
         2rNsxB/b21uSmZbNiSNdMakC4K+BsmvBR4NDzNSPA7NDJs8Srm38JeMau4K6ZbDmHT
         MnPaXPaqQJc+K4vkKdjcF+27ltFCf9juHrpjKQ+g=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Miquel Raynal <miquel.raynal@bootlin.com>
Subject: [PATCH 5.4 138/215] mtd: rawnand: oxnas: Unregister all devices on error
Date:   Mon, 20 Jul 2020 17:37:00 +0200
Message-Id: <20200720152826.752938150@linuxfoundation.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200720152820.122442056@linuxfoundation.org>
References: <20200720152820.122442056@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Miquel Raynal <miquel.raynal@bootlin.com>

commit b60391eb17b2956ff2fc4c348e5a464da21ff9cb upstream.

On error, the oxnas probe path just frees the device which failed and
aborts the probe, leaving unreleased resources.

Fix this situation by calling mtd_device_unregister()/nand_cleanup()
on these.

Fixes: 668592492409 ("mtd: nand: Add OX820 NAND Support")
Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
Link: https://lore.kernel.org/linux-mtd/20200519130035.1883-38-miquel.raynal@bootlin.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/mtd/nand/raw/oxnas_nand.c |    8 ++++++++
 1 file changed, 8 insertions(+)

--- a/drivers/mtd/nand/raw/oxnas_nand.c
+++ b/drivers/mtd/nand/raw/oxnas_nand.c
@@ -82,6 +82,7 @@ static int oxnas_nand_probe(struct platf
 	struct resource *res;
 	int count = 0;
 	int err = 0;
+	int i;
 
 	/* Allocate memory for the device structure (and zero it) */
 	oxnas = devm_kzalloc(&pdev->dev, sizeof(*oxnas),
@@ -161,6 +162,13 @@ err_cleanup_nand:
 	nand_cleanup(chip);
 err_release_child:
 	of_node_put(nand_np);
+
+	for (i = 0; i < oxnas->nchips; i++) {
+		chip = oxnas->chips[i];
+		WARN_ON(mtd_device_unregister(nand_to_mtd(chip)));
+		nand_cleanup(chip);
+	}
+
 err_clk_unprepare:
 	clk_disable_unprepare(oxnas->clk);
 	return err;


