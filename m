Return-Path: <SRS0=bWCJ=AA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00392C433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jun 2020 15:15:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C2A3D2184D
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jun 2020 15:15:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1592579756;
	bh=LA5Ox6gC4Xm9HE32Ffr8krcP1e7cjY5jlMYQwHg1eAI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=H6U2e/m3uBM4X17sIKC3oX3Dtmewf48K3yF+BrA4w5UaNre1dQ6FkJIPdiqfNME/a
	 Z+jlzn6vs5R7CSvKH4eZcm0rQxLmgPh0vS1M2SiR1GVL0SCbdkZvV4PA365gD/WtHq
	 MA3WbuGkUFJcSfQGadvjHLf52peLVdBt/bTxwSrg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392441AbgFSPPy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Jun 2020 11:15:54 -0400
Received: from mail.kernel.org ([198.145.29.99]:46118 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2392424AbgFSPPd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Jun 2020 11:15:33 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 33C3C21582;
        Fri, 19 Jun 2020 15:15:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592579732;
        bh=LA5Ox6gC4Xm9HE32Ffr8krcP1e7cjY5jlMYQwHg1eAI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=LaBJ2fyc9nXNKtUsy5/KVzpOJHKhke+37om2kLKg5wDwYbyPBnAZsMW60ZmMzN0w3
         Dp8Bvl+A+yGagebGRSt8UVDYtvjnxoBnpucw/cbZ/iRcGiVEMKfLUapC+5+tNeH4gU
         KGXCwLoeXfU3wX8+B9pWi4czryZ/8ynttnZGDnsM=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Miquel Raynal <miquel.raynal@bootlin.com>,
        Paul Cercueil <paul@crapouillou.net>,
        Harvey Hunt <harveyhuntnexus@gmail.com>
Subject: [PATCH 5.4 245/261] mtd: rawnand: ingenic: Fix the probe error path
Date:   Fri, 19 Jun 2020 16:34:16 +0200
Message-Id: <20200619141701.622811509@linuxfoundation.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200619141649.878808811@linuxfoundation.org>
References: <20200619141649.878808811@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Miquel Raynal <miquel.raynal@bootlin.com>

commit de17cade0e034e9b721a6db9b488014effac1e5a upstream.

nand_release() is supposed be called after MTD device registration.
Here, only nand_scan() happened, so use nand_cleanup() instead.

There is no real Fixes tag applying here as the use of nand_release()
in this driver predates the introduction of nand_cleanup() in
commit d44154f969a4 ("mtd: nand: Provide nand_cleanup() function to free NAND related resources")
which makes this change possible. Hence, pointing it as the commit to
fix for backporting purposes, even if this commit is not introducing
any bug makes sense.

Fixes: d44154f969a4 ("mtd: nand: Provide nand_cleanup() function to free NAND related resources")
Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
Cc: stable@vger.kernel.org
Cc: Paul Cercueil <paul@crapouillou.net>
Cc: Harvey Hunt <harveyhuntnexus@gmail.com>
Link: https://lore.kernel.org/linux-mtd/20200519130035.1883-22-miquel.raynal@bootlin.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/mtd/nand/raw/ingenic/ingenic_nand_drv.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/mtd/nand/raw/ingenic/ingenic_nand_drv.c
+++ b/drivers/mtd/nand/raw/ingenic/ingenic_nand_drv.c
@@ -376,7 +376,7 @@ static int ingenic_nand_init_chip(struct
 
 	ret = mtd_device_register(mtd, NULL, 0);
 	if (ret) {
-		nand_release(chip);
+		nand_cleanup(chip);
 		return ret;
 	}
 


