Return-Path: <SRS0=bWCJ=AA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E84A7C433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jun 2020 15:32:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CA60E20786
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jun 2020 15:32:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1592580765;
	bh=8s7unfe+GuuuqKiQwBF2A355/C9ArBFhCefUl/pMFy0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=gHA9AQto47UUCbrha4AdJ1QELLw93nkEOCInP/+lq5K1rpe9SMavVzoM2/n4COuGU
	 8WQPLBKdUwniQbMNckZDNev874i+yu0+vFVR7iZKsl9XkXRVPv0sGRnjkp7yYyaFo6
	 toFWLpacmyZ81y4nEzVu/emmB2zzgARQkbwYBRmg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393918AbgFSPcm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Jun 2020 11:32:42 -0400
Received: from mail.kernel.org ([198.145.29.99]:36278 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2393650AbgFSPcU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Jun 2020 11:32:20 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0E6DA20734;
        Fri, 19 Jun 2020 15:32:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592580739;
        bh=8s7unfe+GuuuqKiQwBF2A355/C9ArBFhCefUl/pMFy0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=avqxfyIUJEKNIfupJ7aOqOELYJ/KfHmnFpZh80RPnQzLkx2/HoFhRRQ3wqaWVcVYe
         Zv12j6YDI43xHVVSqOwjmzIOtUobjFxLgg/YqbrkbGWk5UZv0iJm/HjHLrwtHNzeIs
         bXVK0IikK5R7u4xB+Jf1JGsWp/8PQr4GpQqohHRA=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Miquel Raynal <miquel.raynal@bootlin.com>
Subject: [PATCH 5.7 364/376] mtd: rawnand: pasemi: Fix the probe error path
Date:   Fri, 19 Jun 2020 16:34:42 +0200
Message-Id: <20200619141727.544165661@linuxfoundation.org>
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

commit f51466901c07e6930435d30b02a21f0841174f61 upstream.

nand_cleanup() is supposed to be called on error after a successful
call to nand_scan() to free all NAND resources.

There is no real Fixes tag applying here as the use of nand_release()
in this driver predates by far the introduction of nand_cleanup() in
commit d44154f969a4 ("mtd: nand: Provide nand_cleanup() function to free NAND related resources")
which makes this change possible, hence pointing it as the commit to
fix for backporting purposes, even if this commit is not introducing
any bug.

Fixes: d44154f969a4 ("mtd: nand: Provide nand_cleanup() function to free NAND related resources")
Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
Cc: stable@vger.kernel.org
Link: https://lore.kernel.org/linux-mtd/20200519130035.1883-41-miquel.raynal@bootlin.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/mtd/nand/raw/pasemi_nand.c |    4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

--- a/drivers/mtd/nand/raw/pasemi_nand.c
+++ b/drivers/mtd/nand/raw/pasemi_nand.c
@@ -146,7 +146,7 @@ static int pasemi_nand_probe(struct plat
 	if (mtd_device_register(pasemi_nand_mtd, NULL, 0)) {
 		dev_err(dev, "Unable to register MTD device\n");
 		err = -ENODEV;
-		goto out_lpc;
+		goto out_cleanup_nand;
 	}
 
 	dev_info(dev, "PA Semi NAND flash at %pR, control at I/O %x\n", &res,
@@ -154,6 +154,8 @@ static int pasemi_nand_probe(struct plat
 
 	return 0;
 
+ out_cleanup_nand:
+	nand_cleanup(chip);
  out_lpc:
 	release_region(lpcctl, 4);
  out_ior:


