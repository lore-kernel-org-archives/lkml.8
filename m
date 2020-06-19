Return-Path: <SRS0=bWCJ=AA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B678C433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jun 2020 15:22:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 223902186A
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jun 2020 15:22:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1592580154;
	bh=L6uAw5u2g44VN+ZMX5Ve2cEJ80HOp3drfSC9s8OfhG0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=J4MtG6iGSv2JknReI1ziBlZY6tEJR2+CKjpRqa6uqwPaNsuAv1Rokwa0vN2f8VN8t
	 lIwPyjfHVhyRx68+Jb55Ze4rpthBnoyywjZUdaL6HrsHL6+LxpInz4DkMmbaHclMvB
	 xN8Q85On2/2ihR6ZGibOOwlFFHu60qXijIi4eX7U=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393014AbgFSPWd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Jun 2020 11:22:33 -0400
Received: from mail.kernel.org ([198.145.29.99]:46210 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2404033AbgFSPPj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Jun 2020 11:15:39 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D9AB72080C;
        Fri, 19 Jun 2020 15:15:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592579738;
        bh=L6uAw5u2g44VN+ZMX5Ve2cEJ80HOp3drfSC9s8OfhG0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=n6TjL3YWMqLqMU/DzhV1qynznEUdmjA4L0p35o8HJZIly+YFZDyoi658iPl+bM5uv
         pgbu2/mahD8bnimudHRY7mbIDrVgcSBEg6mRm2wtB+BM7w2HK3hxlMeiq72KD4CqjU
         g8wJP+9MlJlKfs2GPswF+RCpe252h3xUhD4Bbc5M=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Miquel Raynal <miquel.raynal@bootlin.com>
Subject: [PATCH 5.4 247/261] mtd: rawnand: orion: Fix the probe error path
Date:   Fri, 19 Jun 2020 16:34:18 +0200
Message-Id: <20200619141701.727685758@linuxfoundation.org>
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

commit be238fbf78e4c7c586dac235ab967d3e565a4d1a upstream.

nand_release() is supposed be called after MTD device registration.
Here, only nand_scan() happened, so use nand_cleanup() instead.

There is no real Fixes tag applying here as the use of nand_release()
in this driver predates by far the introduction of nand_cleanup() in
commit d44154f969a4 ("mtd: nand: Provide nand_cleanup() function to free NAND related resources")
which makes this change possible. However, pointing this commit as the
culprit for backporting purposes makes sense even if this commit is not
introducing any bug.

Fixes: d44154f969a4 ("mtd: nand: Provide nand_cleanup() function to free NAND related resources")
Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
Cc: stable@vger.kernel.org
Link: https://lore.kernel.org/linux-mtd/20200519130035.1883-34-miquel.raynal@bootlin.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/mtd/nand/raw/orion_nand.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/mtd/nand/raw/orion_nand.c
+++ b/drivers/mtd/nand/raw/orion_nand.c
@@ -180,7 +180,7 @@ static int __init orion_nand_probe(struc
 	mtd->name = "orion_nand";
 	ret = mtd_device_register(mtd, board->parts, board->nr_parts);
 	if (ret) {
-		nand_release(nc);
+		nand_cleanup(nc);
 		goto no_dev;
 	}
 


