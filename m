Return-Path: <SRS0=AM+j=AE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92151C433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 20:57:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 686EB20702
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 20:57:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1592945844;
	bh=gTriKvrD/UkzIHrdq373VTGptyXy8RxJVCpAOj9W5wc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=uMrD3yQxmoPfoSqILmrQeKd9BHQpC/iOxvA4y4o1xdsg3Qhlaw9BSypk4kgQbW1FW
	 qZFMnLiQzyH599zOBAs6eBEGqxB5Uadd6fFdBMdUMovXgljV8/xmuVXmhcKUPqD9UP
	 E1t3xhMVvwYNnx+jUSqLyzCd9VZv/bCA3VYIqQ2w=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392450AbgFWUmr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Jun 2020 16:42:47 -0400
Received: from mail.kernel.org ([198.145.29.99]:39190 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390561AbgFWUmh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Jun 2020 16:42:37 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 55C1620767;
        Tue, 23 Jun 2020 20:42:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592944956;
        bh=gTriKvrD/UkzIHrdq373VTGptyXy8RxJVCpAOj9W5wc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=IaA5//WMqW6e0DFwnsexkFNoRCnvnD0gSIHNBPwk0G9k0tkyO5WPqXaYnR38ayliZ
         NvNkEu1+d7sba8fPLDLTxbKNsrHb1ssN+MuxoYRcj4rydzBzJWNYnCICX/jDB2ho36
         kg5ezcVaC6U5Zr6nysCZGik9cwaxg8JPBmSrTvLM=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Nishka Dasgupta <nishkadg.linux@gmail.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 189/206] mtd: rawnand: oxnas: Add of_node_put()
Date:   Tue, 23 Jun 2020 21:58:37 +0200
Message-Id: <20200623195326.327690176@linuxfoundation.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200623195316.864547658@linuxfoundation.org>
References: <20200623195316.864547658@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Nishka Dasgupta <nishkadg.linux@gmail.com>

[ Upstream commit c436f68beeb20f2f92937677db1d9069b0dd2a3d ]

Each iteration of for_each_child_of_node puts the previous node, but in
the case of a goto from the middle of the loop, there is no put, thus
causing a memory leak. Hence add an of_node_put under a new goto to put
the node at a loop exit.
Issue found with Coccinelle.

Signed-off-by: Nishka Dasgupta <nishkadg.linux@gmail.com>
Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/mtd/nand/raw/oxnas_nand.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/mtd/nand/raw/oxnas_nand.c b/drivers/mtd/nand/raw/oxnas_nand.c
index 5bc180536320d..7509bcd961351 100644
--- a/drivers/mtd/nand/raw/oxnas_nand.c
+++ b/drivers/mtd/nand/raw/oxnas_nand.c
@@ -123,7 +123,7 @@ static int oxnas_nand_probe(struct platform_device *pdev)
 				    GFP_KERNEL);
 		if (!chip) {
 			err = -ENOMEM;
-			goto err_clk_unprepare;
+			goto err_release_child;
 		}
 
 		chip->controller = &oxnas->base;
@@ -144,12 +144,12 @@ static int oxnas_nand_probe(struct platform_device *pdev)
 		/* Scan to find existence of the device */
 		err = nand_scan(chip, 1);
 		if (err)
-			goto err_clk_unprepare;
+			goto err_release_child;
 
 		err = mtd_device_register(mtd, NULL, 0);
 		if (err) {
 			nand_release(chip);
-			goto err_clk_unprepare;
+			goto err_release_child;
 		}
 
 		oxnas->chips[nchips] = chip;
@@ -166,6 +166,8 @@ static int oxnas_nand_probe(struct platform_device *pdev)
 
 	return 0;
 
+err_release_child:
+	of_node_put(nand_np);
 err_clk_unprepare:
 	clk_disable_unprepare(oxnas->clk);
 	return err;
-- 
2.25.1



