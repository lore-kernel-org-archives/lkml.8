Return-Path: <SRS0=1dCa=6A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E460CC2BB55
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Apr 2020 13:55:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B12472078B
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Apr 2020 13:55:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1587045317;
	bh=1W5KIwf4IEZ/S6UWBR0GAJ66klrhUvvnU62RubpXa4Q=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=TpiHGAyOnaEBPECww766XgI5SL4xpVcn9Gh+e3tg6aLFzC23iMXHojl1mE84eZCrX
	 mndiUwxnxj+xoJKnc8wIl5m541xRLiun6SsF3LLC12Ht9RKHUGkrwBYw31N5HEAWFd
	 LiWouR5zU75PrQuiBn/sGPwwYAerbwnHmNd42l0c=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2409122AbgDPNzK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Apr 2020 09:55:10 -0400
Received: from mail.kernel.org ([198.145.29.99]:50586 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2897651AbgDPNiJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Apr 2020 09:38:09 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7326921BE5;
        Thu, 16 Apr 2020 13:38:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1587044288;
        bh=1W5KIwf4IEZ/S6UWBR0GAJ66klrhUvvnU62RubpXa4Q=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=cGmXZODKtsYuFzVEUaK/2ppN+Oxot06WimN4rSJwuFbknERLojcYrjufN7HypER8Y
         3z+EsV0kmjWtG3Uw2olL7V2Cr0opjGB6OT+wx2UkpoIzVYxye0FxiXGJxa03UHF74I
         kzmw1u7TgPvg3HlDgBHNAVikSuz2l4oyDmVsk/oY=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Piotr Sroka <piotrs@cadence.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>
Subject: [PATCH 5.5 155/257] mtd: rawnand: cadence: fix the calculation of the avaialble OOB size
Date:   Thu, 16 Apr 2020 15:23:26 +0200
Message-Id: <20200416131345.945130591@linuxfoundation.org>
X-Mailer: git-send-email 2.26.1
In-Reply-To: <20200416131325.891903893@linuxfoundation.org>
References: <20200416131325.891903893@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Piotr Sroka <piotrs@cadence.com>

commit e4578af0354176ff6b4ae78b9998b4f479f7c31c upstream.

The value of cdns_chip->sector_count is not known at the moment
of the derivation of ecc_size, leading to a zero value. Fix
this by assigning ecc_size later in the code.

Fixes: ec4ba01e894d ("mtd: rawnand: Add new Cadence NAND driver to MTD subsystem")
Cc: stable@vger.kernel.org
Signed-off-by: Piotr Sroka <piotrs@cadence.com>
Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
Link: https://lore.kernel.org/linux-mtd/1581328530-29966-2-git-send-email-piotrs@cadence.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/mtd/nand/raw/cadence-nand-controller.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

--- a/drivers/mtd/nand/raw/cadence-nand-controller.c
+++ b/drivers/mtd/nand/raw/cadence-nand-controller.c
@@ -2585,7 +2585,7 @@ int cadence_nand_attach_chip(struct nand
 {
 	struct cdns_nand_ctrl *cdns_ctrl = to_cdns_nand_ctrl(chip->controller);
 	struct cdns_nand_chip *cdns_chip = to_cdns_nand_chip(chip);
-	u32 ecc_size = cdns_chip->sector_count * chip->ecc.bytes;
+	u32 ecc_size;
 	struct mtd_info *mtd = nand_to_mtd(chip);
 	u32 max_oob_data_size;
 	int ret;
@@ -2625,6 +2625,7 @@ int cadence_nand_attach_chip(struct nand
 	/* Error correction configuration. */
 	cdns_chip->sector_size = chip->ecc.size;
 	cdns_chip->sector_count = mtd->writesize / cdns_chip->sector_size;
+	ecc_size = cdns_chip->sector_count * chip->ecc.bytes;
 
 	cdns_chip->avail_oob_size = mtd->oobsize - ecc_size;
 


