Return-Path: <SRS0=bl3x=A7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8BE84C433EC
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jul 2020 16:36:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5E75820734
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jul 2020 16:36:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1595262996;
	bh=jBas8mOFlfXh9oYQjcp4y6xEct2sPQmDoIjxVhDWSAA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Sr7rOoGM7YKA67d+6eO2B9F9MAestQtrmdcCUd/sb2pGGOyCDWASqJ4g1BhV1yNix
	 s/wYGv0b8wAFwgiyHmgEVTTvaz7Xe9Mqvux1ggkxkmAZ70vnEyQUUdgc6GxssTBsdR
	 rEP79RoUQmiyiN8miYBWsHnlNwTR2XDIZ0/n1si0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387636AbgGTQgf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Jul 2020 12:36:35 -0400
Received: from mail.kernel.org ([198.145.29.99]:50882 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731378AbgGTPwi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jul 2020 11:52:38 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D2EC22064B;
        Mon, 20 Jul 2020 15:52:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1595260358;
        bh=jBas8mOFlfXh9oYQjcp4y6xEct2sPQmDoIjxVhDWSAA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=11J0xv27DLGFrI2lK05EiH7SQPTLS6euHHQktpr2j+j9PnDJO/z8aRO4jzeR/jCIf
         Ayoq2BkjU477xKSw4sUNTToUShaP52IV96knSdmsB5w4qwYhCvAPE7GSMvxFuFH6uA
         fAVj2gQUtxS1PBbJnowUvWfZOjMcXibyFUIP9VoY=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Miquel Raynal <miquel.raynal@bootlin.com>,
        Boris Brezillon <boris.brezillon@collabora.com>
Subject: [PATCH 4.19 074/133] mtd: rawnand: marvell: Use nand_cleanup() when the device is not yet registered
Date:   Mon, 20 Jul 2020 17:37:01 +0200
Message-Id: <20200720152807.272185792@linuxfoundation.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200720152803.732195882@linuxfoundation.org>
References: <20200720152803.732195882@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Miquel Raynal <miquel.raynal@bootlin.com>

commit 7a0c18fb5c71c6ac7d4662a145e4227dcd4a36a3 upstream.

Do not call nand_release() while the MTD device has not been
registered, use nand_cleanup() instead.

Fixes: 02f26ecf8c77 ("mtd: nand: add reworked Marvell NAND controller driver")
Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
Reviewed-by: Boris Brezillon <boris.brezillon@collabora.com>
Link: https://lore.kernel.org/linux-mtd/20200424164501.26719-4-miquel.raynal@bootlin.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/mtd/nand/raw/marvell_nand.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/mtd/nand/raw/marvell_nand.c
+++ b/drivers/mtd/nand/raw/marvell_nand.c
@@ -2564,7 +2564,7 @@ static int marvell_nand_chip_init(struct
 		ret = mtd_device_register(mtd, NULL, 0);
 	if (ret) {
 		dev_err(dev, "failed to register mtd device: %d\n", ret);
-		nand_release(chip);
+		nand_cleanup(chip);
 		return ret;
 	}
 


