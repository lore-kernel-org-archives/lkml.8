Return-Path: <SRS0=AM+j=AE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06C4EC433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 20:42:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CC2532078A
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 20:42:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1592944956;
	bh=CXAc/dSOE3Fqq4QhF7F5aldHNukvAgSch4BT6QF4EZw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Oql7iurlVpOcO/V1w3YQ7Ukp8FSFW2jAIpWDSQvq15ZIYZ3ejUMruKlf4C8hrOU/2
	 BoSUWDjZrIseCVQcAiQEJESMGDIvcpv4PwXaQlaZNoUAeIihh1Kbi+ljNPDX3/OqPD
	 Bs+qTXfbYHgtPSyqJBIH5CudfFFENMizeCG73RmU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392432AbgFWUme (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Jun 2020 16:42:34 -0400
Received: from mail.kernel.org ([198.145.29.99]:39052 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2392421AbgFWUm0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Jun 2020 16:42:26 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 817302070E;
        Tue, 23 Jun 2020 20:42:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592944947;
        bh=CXAc/dSOE3Fqq4QhF7F5aldHNukvAgSch4BT6QF4EZw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=r1nnAmY6+zwbm4cc4GbgD+IaTWgCVrtj/YdW8dehypJWWyxpa2uh22UnusOwxyn93
         bpBHBDDA3wmOb3Tc04A7oZwYvDUV3ayNA5log5bTqgZjhRzY+6SClUG2oi6zaxGBU4
         hHKcpIP4embXTwR+xweBnsxcAgKqvudG63+q6isk=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Miquel Raynal <miquel.raynal@bootlin.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 186/206] mtd: rawnand: sharpsl: Fix the probe error path
Date:   Tue, 23 Jun 2020 21:58:34 +0200
Message-Id: <20200623195326.187325908@linuxfoundation.org>
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

From: Miquel Raynal <miquel.raynal@bootlin.com>

[ Upstream commit 0f44b3275b3798ccb97a2f51ac85871c30d6fbbc ]

nand_release() is supposed be called after MTD device registration.
Here, only nand_scan() happened, so use nand_cleanup() instead.

There is no Fixes tag applying here as the use of nand_release()
in this driver predates by far the introduction of nand_cleanup() in
commit d44154f969a4 ("mtd: nand: Provide nand_cleanup() function to free NAND related resources")
which makes this change possible. However, pointing this commit as the
culprit for backporting purposes makes sense.

Fixes: d44154f969a4 ("mtd: nand: Provide nand_cleanup() function to free NAND related resources")
Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
Cc: stable@vger.kernel.org
Link: https://lore.kernel.org/linux-mtd/20200519130035.1883-49-miquel.raynal@bootlin.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/mtd/nand/raw/sharpsl.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mtd/nand/raw/sharpsl.c b/drivers/mtd/nand/raw/sharpsl.c
index c8eb4654bb1c7..4544753e6a1b8 100644
--- a/drivers/mtd/nand/raw/sharpsl.c
+++ b/drivers/mtd/nand/raw/sharpsl.c
@@ -187,7 +187,7 @@ static int sharpsl_nand_probe(struct platform_device *pdev)
 	return 0;
 
 err_add:
-	nand_release(this);
+	nand_cleanup(this);
 
 err_scan:
 	iounmap(sharpsl->io);
-- 
2.25.1



