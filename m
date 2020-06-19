Return-Path: <SRS0=bWCJ=AA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C87FC433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jun 2020 15:53:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 12E7B20809
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jun 2020 15:53:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1592582039;
	bh=59NqwUWWhjfYF1vPj0tVIAxyPg99f5wPdqso9o8QcF4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=zVuofU9liGhFQGqxDTlmbJqi7RS4XHxmMHwvjzHISY8XNJf/gGhwuYPhe3W/iheCJ
	 30dBLOVfIL/yeEO6qGt2d4hY2uTsOMTX80Ts0ATzLpjot0krYO34ZGcHPvr6dCOuN2
	 gmbYvRFi3XgowUZR8Bpoz9BCqIx9ohB8sqHSxZPA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390670AbgFSPWG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Jun 2020 11:22:06 -0400
Received: from mail.kernel.org ([198.145.29.99]:46364 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2392431AbgFSPPt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Jun 2020 11:15:49 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 208D121582;
        Fri, 19 Jun 2020 15:15:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592579748;
        bh=59NqwUWWhjfYF1vPj0tVIAxyPg99f5wPdqso9o8QcF4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=g1jhIjomShVPaxuYBsReBQcupToAqtr+m+wbuw355HGKP8glxWoN7NA/5EbaqClv7
         /I3ME4M2mnSLGtkrQWeCtO5LxFGf6+OOn1sTg2Bi09TxoYHuXvO4Hkwoyy0rm6vz6u
         Lbdj25OjhfIoQJHTcwegB80WrvUCKdlK6/+D5JM4=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Miquel Raynal <miquel.raynal@bootlin.com>
Subject: [PATCH 5.4 250/261] mtd: rawnand: sunxi: Fix the probe error path
Date:   Fri, 19 Jun 2020 16:34:21 +0200
Message-Id: <20200619141701.866294761@linuxfoundation.org>
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

commit 3d84515ffd8fb657e10fa5b1215e9f095fa7efca upstream.

nand_release() is supposed be called after MTD device registration.
Here, only nand_scan() happened, so use nand_cleanup() instead.

Fixes: 1fef62c1423b ("mtd: nand: add sunxi NAND flash controller support")
Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
Cc: stable@vger.kernel.org
Link: https://lore.kernel.org/linux-mtd/20200519130035.1883-54-miquel.raynal@bootlin.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/mtd/nand/raw/sunxi_nand.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/mtd/nand/raw/sunxi_nand.c
+++ b/drivers/mtd/nand/raw/sunxi_nand.c
@@ -2003,7 +2003,7 @@ static int sunxi_nand_chip_init(struct d
 	ret = mtd_device_register(mtd, NULL, 0);
 	if (ret) {
 		dev_err(dev, "failed to register mtd device: %d\n", ret);
-		nand_release(nand);
+		nand_cleanup(nand);
 		return ret;
 	}
 


