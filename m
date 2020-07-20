Return-Path: <SRS0=bl3x=A7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29664C433EC
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jul 2020 16:19:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0771B207DD
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jul 2020 16:19:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1595261942;
	bh=3DIIuFvolpU1ejUNjM2ZXn6NWLeSQpweIh1U63zDc4M=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=LvMLUMjBrUToWx3C0RePEYx92s6q43WBFrriMCwKAlYE0xXX5BdpNnK26PlJjZ+AQ
	 cSboFn4q2BS1nWFV/8u7VdA5o1IKfW/2q00jgOb55WUbNoZLBIDN92p6/eJCiXZRib
	 OGSwV4V0lFUboQMPKQrEhwKMQLQHdZgbMrleNa4Q=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387998AbgGTQMi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Jul 2020 12:12:38 -0400
Received: from mail.kernel.org ([198.145.29.99]:52192 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387985AbgGTQMg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jul 2020 12:12:36 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9B5C120684;
        Mon, 20 Jul 2020 16:12:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1595261556;
        bh=3DIIuFvolpU1ejUNjM2ZXn6NWLeSQpweIh1U63zDc4M=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=lMPBrbVY40RBdcgE4vh3PmDgFO7xTex1VDtsdHScQ167nyAox1Cl5zrCV1vx0mCfp
         KGxqyg0QK3lhGwFuGj2ePq1ygiUwKJIBBNOSk4KjFuwX3sflnfXG36K/knl2BtlUvS
         rxQuW4PMdY0t46n/zaOLUJe1/qvvHrksVEREGZwA=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Miquel Raynal <miquel.raynal@bootlin.com>
Subject: [PATCH 5.7 141/244] mtd: rawnand: oxnas: Unregister all devices on error
Date:   Mon, 20 Jul 2020 17:36:52 +0200
Message-Id: <20200720152832.559295181@linuxfoundation.org>
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


