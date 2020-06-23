Return-Path: <SRS0=AM+j=AE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 121A0C433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 20:57:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DAD8320724
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 20:57:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1592945862;
	bh=AbtKSSDXJJ7psYsWDTWBgkzCW4eFI1zmmmtpPytZzpI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=XmRfQlh+YbI6rXxv+dxdDcF6KhjWIBF5MzzHStAJRdKQGDTTCvx7ndh3bXfx0kVP4
	 Ii8wBWlVqkevgBV7fpr9zZ1Ue+GFUOldpDCwUXl3WKtvDYr1bz3xCGQcElKbVMxJfO
	 WVapNCYsPvmcUFy5PY49xy8viO3OFrCpB52p1gZU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404152AbgFWU5k (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Jun 2020 16:57:40 -0400
Received: from mail.kernel.org ([198.145.29.99]:39268 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2391727AbgFWUmj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Jun 2020 16:42:39 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 109A32070E;
        Tue, 23 Jun 2020 20:42:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592944959;
        bh=AbtKSSDXJJ7psYsWDTWBgkzCW4eFI1zmmmtpPytZzpI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=2k6TugW0aeokrgz3ZrQYORcXTUHQFtud1hAjtunPH9gXyOagDaiVW6ML9GGucKeLi
         QDQFavzfyNASL5aB9uYWOMOQ0IAwzxekC4efTSnlpCDrK9VveItmSKDl6XFlRtj1zC
         H/Pyd6s8GjnTI1X9sq0dsq0+gkeEjSAS9+5TbbwI=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Miquel Raynal <miquel.raynal@bootlin.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 190/206] mtd: rawnand: oxnas: Fix the probe error path
Date:   Tue, 23 Jun 2020 21:58:38 +0200
Message-Id: <20200623195326.373390811@linuxfoundation.org>
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

[ Upstream commit 154298e2a3f6c9ce1d76cdb48d89fd5b107ea1a3 ]

nand_release() is supposed be called after MTD device registration.
Here, only nand_scan() happened, so use nand_cleanup() instead.

While at it, be consistent and move the function call in the error
path thanks to a goto statement.

Fixes: 668592492409 ("mtd: nand: Add OX820 NAND Support")
Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
Cc: stable@vger.kernel.org
Link: https://lore.kernel.org/linux-mtd/20200519130035.1883-37-miquel.raynal@bootlin.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/mtd/nand/raw/oxnas_nand.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/mtd/nand/raw/oxnas_nand.c b/drivers/mtd/nand/raw/oxnas_nand.c
index 7509bcd961351..d3f274b2e56d2 100644
--- a/drivers/mtd/nand/raw/oxnas_nand.c
+++ b/drivers/mtd/nand/raw/oxnas_nand.c
@@ -147,10 +147,8 @@ static int oxnas_nand_probe(struct platform_device *pdev)
 			goto err_release_child;
 
 		err = mtd_device_register(mtd, NULL, 0);
-		if (err) {
-			nand_release(chip);
-			goto err_release_child;
-		}
+		if (err)
+			goto err_cleanup_nand;
 
 		oxnas->chips[nchips] = chip;
 		++nchips;
@@ -166,6 +164,8 @@ static int oxnas_nand_probe(struct platform_device *pdev)
 
 	return 0;
 
+err_cleanup_nand:
+	nand_cleanup(chip);
 err_release_child:
 	of_node_put(nand_np);
 err_clk_unprepare:
-- 
2.25.1



