Return-Path: <SRS0=bWCJ=AA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A20ABC433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jun 2020 15:32:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 81B5420757
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jun 2020 15:32:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1592580753;
	bh=dCNKZt2vzXQyX7n5Z8K3XEJ/qwtJSmWy73gkWpZ/lnA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=bPa2taKO9xzAXt9XbRTE5vP230zU1m5WV9qpt9WzyGvAh03/w6bRHZ1CJ84zb/Rbr
	 fuf2z8QMejlbsuSnxqiS7sMhQmLl8l517nUcCdDkKp3llh2LfaNqS6+UjWvmv5wAmj
	 rpG51VSG4+1umoWP0C//htfNqpjbCZpSr+C+/e7o=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393890AbgFSPcb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Jun 2020 11:32:31 -0400
Received: from mail.kernel.org ([198.145.29.99]:36150 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2393621AbgFSPcJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Jun 2020 11:32:09 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9F93E20757;
        Fri, 19 Jun 2020 15:32:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592580729;
        bh=dCNKZt2vzXQyX7n5Z8K3XEJ/qwtJSmWy73gkWpZ/lnA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=AN8e1urm9OFvsz9GhJT9oQgCi+br/5/qandq62FMK1M5GLkkU/KIvmiRuQzP+HwFB
         CkxlC24i3lSJT2aZw0+zbDnlolUm5DjhKpbvi5E1usAT7nBq19VEypcBBJqghkGlsx
         r1/PEsh0BNdUsHylOib26NkzEBhmcesLCFq4gyxU=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Miquel Raynal <miquel.raynal@bootlin.com>
Subject: [PATCH 5.7 361/376] mtd: rawnand: oxnas: Fix the probe error path
Date:   Fri, 19 Jun 2020 16:34:39 +0200
Message-Id: <20200619141727.403567869@linuxfoundation.org>
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

commit 154298e2a3f6c9ce1d76cdb48d89fd5b107ea1a3 upstream.

nand_release() is supposed be called after MTD device registration.
Here, only nand_scan() happened, so use nand_cleanup() instead.

While at it, be consistent and move the function call in the error
path thanks to a goto statement.

Fixes: 668592492409 ("mtd: nand: Add OX820 NAND Support")
Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
Cc: stable@vger.kernel.org
Link: https://lore.kernel.org/linux-mtd/20200519130035.1883-37-miquel.raynal@bootlin.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/mtd/nand/raw/oxnas_nand.c |    8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

--- a/drivers/mtd/nand/raw/oxnas_nand.c
+++ b/drivers/mtd/nand/raw/oxnas_nand.c
@@ -140,10 +140,8 @@ static int oxnas_nand_probe(struct platf
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
@@ -159,6 +157,8 @@ static int oxnas_nand_probe(struct platf
 
 	return 0;
 
+err_cleanup_nand:
+	nand_cleanup(chip);
 err_release_child:
 	of_node_put(nand_np);
 err_clk_unprepare:


