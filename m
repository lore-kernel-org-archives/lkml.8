Return-Path: <SRS0=1dCa=6A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 082AEC2BB85
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Apr 2020 13:35:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D02CA21BE5
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Apr 2020 13:35:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1587044121;
	bh=uc2WFeTP9ZQp7zqVBrzjhUU/CrvVJFCPtT01ZokVjto=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=RZFhUgma3G3DONwHeFsrqWyZKtjO3DMfO6bKSSiOAVL1QfMAEKDBIgWK4VgbhyKjs
	 AH4NS+lSSlz0csx9Q0go65gcIUm3l4HafjVH0E0CseJcVRbHF4kbLvVDd6vNHu1/3E
	 qoMsX+fuxNXLgt/65ocRTVNdkUnbLbXpmoXNYqyg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2897119AbgDPNfR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Apr 2020 09:35:17 -0400
Received: from mail.kernel.org ([198.145.29.99]:39002 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2895984AbgDPN3R (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Apr 2020 09:29:17 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1EAE2208E4;
        Thu, 16 Apr 2020 13:29:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1587043756;
        bh=uc2WFeTP9ZQp7zqVBrzjhUU/CrvVJFCPtT01ZokVjto=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=F1oCpLhK5Y0izZd47mEl1RGrgrxTeL7m8BgmqFwhfLbZmnV2ENBDlkw/lzb3ckKQh
         ZuNF6ftdI5hQEYhjD0p2Wji+pNZKLwA6Qj0IbCgN9nEbOzvpyw9q1fU6irndXQbOjA
         Mz2uIoHgoFaUgnyE0HJPehLKflu2uRZuiA/iqI5M=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Frieder Schrempf <frieder.schrempf@kontron.de>,
        Boris Brezillon <boris.brezillon@collabora.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>
Subject: [PATCH 4.19 088/146] mtd: spinand: Do not erase the block before writing a bad block marker
Date:   Thu, 16 Apr 2020 15:23:49 +0200
Message-Id: <20200416131254.819451714@linuxfoundation.org>
X-Mailer: git-send-email 2.26.1
In-Reply-To: <20200416131242.353444678@linuxfoundation.org>
References: <20200416131242.353444678@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Frieder Schrempf <frieder.schrempf@kontron.de>

commit b645ad39d56846618704e463b24bb994c9585c7f upstream.

Currently when marking a block, we use spinand_erase_op() to erase
the block before writing the marker to the OOB area. Doing so without
waiting for the operation to finish can lead to the marking failing
silently and no bad block marker being written to the flash.

In fact we don't need to do an erase at all before writing the BBM.
The ECC is disabled for raw accesses to the OOB data and we don't
need to work around any issues with chips reporting ECC errors as it
is known to be the case for raw NAND.

Fixes: 7529df465248 ("mtd: nand: Add core infrastructure to support SPI NANDs")
Cc: stable@vger.kernel.org
Signed-off-by: Frieder Schrempf <frieder.schrempf@kontron.de>
Reviewed-by: Boris Brezillon <boris.brezillon@collabora.com>
Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
Link: https://lore.kernel.org/linux-mtd/20200218100432.32433-4-frieder.schrempf@kontron.de
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/mtd/nand/spi/core.c |    3 ---
 1 file changed, 3 deletions(-)

--- a/drivers/mtd/nand/spi/core.c
+++ b/drivers/mtd/nand/spi/core.c
@@ -673,7 +673,6 @@ static int spinand_markbad(struct nand_d
 	};
 	int ret;
 
-	/* Erase block before marking it bad. */
 	ret = spinand_select_target(spinand, pos->target);
 	if (ret)
 		return ret;
@@ -682,8 +681,6 @@ static int spinand_markbad(struct nand_d
 	if (ret)
 		return ret;
 
-	spinand_erase_op(spinand, pos);
-
 	return spinand_write_page(spinand, &req);
 }
 


