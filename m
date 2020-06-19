Return-Path: <SRS0=bWCJ=AA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C437CC433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jun 2020 15:32:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 978A720786
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jun 2020 15:32:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1592580776;
	bh=8suDrORI8J9gLI9SPd4KuWsQj2lnHj8vnNhBrFPsNgo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=EcaR57QvcuN0WuVRORYjmRRJvMZCZ0Sn9gcX7oRo+x2Wl16jY1Zv67TjHj+2/hg2B
	 6zoX/fOWzuDGJDyEd4oM0JiMKDFixDyVKwc5mfrIJS2HYfQgQI5XXy3BSGP6QK6Jnu
	 Ci5UKUxIhEo/4PqDzaVK/z+MCz1HzQ6Bw+PZEKg0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393937AbgFSPcz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Jun 2020 11:32:55 -0400
Received: from mail.kernel.org ([198.145.29.99]:36318 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2404604AbgFSPcX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Jun 2020 11:32:23 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C98B620786;
        Fri, 19 Jun 2020 15:32:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592580742;
        bh=8suDrORI8J9gLI9SPd4KuWsQj2lnHj8vnNhBrFPsNgo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=M5yjreBywA+ZyMiOT19sycxHZrhOZvFX1MofSEc0f/Uv5pOViLFwu4Bw/Qq3wbNRq
         dfy7YYXZdpxCLxO/sIWnM/bILLVwZReJWFedaI/Yp4QL5fT/YZps6AsLjb67mQnmY0
         KFiGMZiEDoyq8PDFpdZfCtoFaVTiYvtoWHBzP9OE=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Miquel Raynal <miquel.raynal@bootlin.com>
Subject: [PATCH 5.7 365/376] mtd: rawnand: mtk: Fix the probe error path
Date:   Fri, 19 Jun 2020 16:34:43 +0200
Message-Id: <20200619141727.592220676@linuxfoundation.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200619141710.350494719@linuxfoundation.org>
References: <20200619141710.350494719@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Miquel Raynal <miquel.raynal@bootlin.com>

commit 8a82bbcadec877f5f938c54026278dfc1f05a332 upstream.

nand_release() is supposed be called after MTD device registration.
Here, only nand_scan() happened, so use nand_cleanup() instead.

There is no real Fixes tag applying here as the use of nand_release()
in this driver predates the introduction of nand_cleanup() in
commit d44154f969a4 ("mtd: nand: Provide nand_cleanup() function to free NAND related resources")
which makes this change possible. However, pointing this commit as the
culprit for backporting purposes makes sense even if this commit is not
introducing any bug.

Fixes: d44154f969a4 ("mtd: nand: Provide nand_cleanup() function to free NAND related resources")
Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
Cc: stable@vger.kernel.org
Link: https://lore.kernel.org/linux-mtd/20200519130035.1883-28-miquel.raynal@bootlin.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/mtd/nand/raw/mtk_nand.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/mtd/nand/raw/mtk_nand.c
+++ b/drivers/mtd/nand/raw/mtk_nand.c
@@ -1419,7 +1419,7 @@ static int mtk_nfc_nand_chip_init(struct
 	ret = mtd_device_register(mtd, NULL, 0);
 	if (ret) {
 		dev_err(dev, "mtd parse partition error\n");
-		nand_release(nand);
+		nand_cleanup(nand);
 		return ret;
 	}
 


