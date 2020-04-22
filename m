Return-Path: <SRS0=eifh=6G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C791CC55189
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Apr 2020 10:41:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A645920780
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Apr 2020 10:41:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1587552069;
	bh=z8g8OdfadhKw32Sk4wBRsKxWdO7/BnY8Qy81U8Uxue4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=OhNpMF7BSJMK7goIRslNqrqoSZu8lLcbtehS8ukMu3qp+RiIDAtzYV2QwMdvCziX7
	 CJNyjxL3bM8HCX4j1ow9SnC79UljiHSkAZOdUBxj0Q+37iWd0LzVqdpJRQIJUuNxuW
	 lC1jbOb9DFgNSEHpp5mSuiZKvhBEB1VxXxSokRTM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731355AbgDVKlJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Apr 2020 06:41:09 -0400
Received: from mail.kernel.org ([198.145.29.99]:57214 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730091AbgDVKUa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Apr 2020 06:20:30 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 657472098B;
        Wed, 22 Apr 2020 10:20:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1587550829;
        bh=z8g8OdfadhKw32Sk4wBRsKxWdO7/BnY8Qy81U8Uxue4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=kuhxtKWMX/3GERoy9iyou3U4DDwjHUSLJV+YXQ2WFNO9mUJQ5XoAIv+Hb9uNfMN8P
         jJ2c7bjtgRriOXjrugbHXv5Wyg6RHXJx9ixuFMbpWeLPdhywPzhZiD6CPRqLXfjuNV
         POnTDuOf2OOu+PU8eXxK9BGygc+Oi8vyL3creXU0=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Frieder Schrempf <frieder.schrempf@kontron.de>,
        Boris Brezillon <boris.brezillon@collabora.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>
Subject: [PATCH 5.4 110/118] mtd: spinand: Explicitly use MTD_OPS_RAW to write the bad block marker to OOB
Date:   Wed, 22 Apr 2020 11:57:51 +0200
Message-Id: <20200422095049.001390567@linuxfoundation.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200422095031.522502705@linuxfoundation.org>
References: <20200422095031.522502705@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Frieder Schrempf <frieder.schrempf@kontron.de>

commit 621a7b780bd8b7054647d53d5071961f2c9e0873 upstream.

When writing the bad block marker to the OOB area the access mode
should be set to MTD_OPS_RAW as it is done for reading the marker.
Currently this only works because req.mode is initialized to
MTD_OPS_PLACE_OOB (0) and spinand_write_to_cache_op() checks for
req.mode != MTD_OPS_AUTO_OOB.

Fix this by explicitly setting req.mode to MTD_OPS_RAW.

Fixes: 7529df465248 ("mtd: nand: Add core infrastructure to support SPI NANDs")
Signed-off-by: Frieder Schrempf <frieder.schrempf@kontron.de>
Reviewed-by: Boris Brezillon <boris.brezillon@collabora.com>
Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
Link: https://lore.kernel.org/linux-mtd/20200218100432.32433-3-frieder.schrempf@kontron.de
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/mtd/nand/spi/core.c |    1 +
 1 file changed, 1 insertion(+)

--- a/drivers/mtd/nand/spi/core.c
+++ b/drivers/mtd/nand/spi/core.c
@@ -609,6 +609,7 @@ static int spinand_markbad(struct nand_d
 		.ooboffs = 0,
 		.ooblen = sizeof(marker),
 		.oobbuf.out = marker,
+		.mode = MTD_OPS_RAW,
 	};
 	int ret;
 


