Return-Path: <SRS0=bl3x=A7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1835DC433E8
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jul 2020 16:25:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E371B206E9
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jul 2020 16:25:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1595262306;
	bh=G6grlKMU6pQDo+gnmy7e/hFyDcZuhNSA3mSJdCviRq8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=X8PsuT524+kReyGhCDOqDeYnDem6Jpmrz/v+SBIX/qpIGpWAUiFW22rc5TasL5b5f
	 7GR/OHMh3/Jq7n0NuacIG8r9HbHM0L3edRQyloXUZ3qcIaY9Gr3e9tF2BMlTdft8wm
	 jxWYaI+Wh28z3FLjovr6m33mZVLBCSkHu+lehFgo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732584AbgGTQBz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Jul 2020 12:01:55 -0400
Received: from mail.kernel.org ([198.145.29.99]:35342 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732557AbgGTQBp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jul 2020 12:01:45 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8C60D20672;
        Mon, 20 Jul 2020 16:01:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1595260905;
        bh=G6grlKMU6pQDo+gnmy7e/hFyDcZuhNSA3mSJdCviRq8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=QzzmEnGGPpFXnEKZMan2ztGm+qs8EnfvBJcjFUXWur0u1SQYHP1gam3qwjRMPrCGD
         3UqYkNj7i8uDWHZEy+uvMJs6zWQLUSaoToniRnLV8thcvneXOCDBosKnGS9zmNwGVr
         RL+aCBacsEz4nkn9KRdp89trWRG9SAg7vgFrQCq0=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Miquel Raynal <miquel.raynal@bootlin.com>
Subject: [PATCH 5.4 139/215] mtd: rawnand: oxnas: Release all devices in the _remove() path
Date:   Mon, 20 Jul 2020 17:37:01 +0200
Message-Id: <20200720152826.803304139@linuxfoundation.org>
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

commit 0a5f45e57e35d0840bedb816974ce2e63406cd8b upstream.

oxnans_nand_remove() should release all MTD devices and clean all NAND
devices, not only the first one registered.

Fixes: 668592492409 ("mtd: nand: Add OX820 NAND Support")
Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
Link: https://lore.kernel.org/linux-mtd/20200519130035.1883-39-miquel.raynal@bootlin.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/mtd/nand/raw/oxnas_nand.c |    8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

--- a/drivers/mtd/nand/raw/oxnas_nand.c
+++ b/drivers/mtd/nand/raw/oxnas_nand.c
@@ -177,9 +177,13 @@ err_clk_unprepare:
 static int oxnas_nand_remove(struct platform_device *pdev)
 {
 	struct oxnas_nand_ctrl *oxnas = platform_get_drvdata(pdev);
+	struct nand_chip *chip;
+	int i;
 
-	if (oxnas->chips[0])
-		nand_release(oxnas->chips[0]);
+	for (i = 0; i < oxnas->nchips; i++) {
+		chip = oxnas->chips[i];
+		nand_release(chip);
+	}
 
 	clk_disable_unprepare(oxnas->clk);
 


