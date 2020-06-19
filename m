Return-Path: <SRS0=bWCJ=AA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ABF64C433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jun 2020 16:12:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 86D7021707
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jun 2020 16:12:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1592583174;
	bh=3xz76eFH3Rk6ECGnzWsr2A5OJGdDAjvgNxRKMAjuu2c=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=1x9eT0SV79937bXrC509ycGi1HtXEB+a1ABCdJbWa1o/gvkt+Mo/YLN1WeOd4D8b+
	 m0nA+tPqWRrUgA+lHeUNNdtjBtvZThMP5QLHRms97nAtIu0S/8amAagLjhF/mcz1ou
	 XAYs22PRPlKQ2hAtHOKCWejEHku25pro9lhufOx8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391132AbgFSPE0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Jun 2020 11:04:26 -0400
Received: from mail.kernel.org ([198.145.29.99]:33000 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2391123AbgFSPEV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Jun 2020 11:04:21 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1946E2193E;
        Fri, 19 Jun 2020 15:04:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592579060;
        bh=3xz76eFH3Rk6ECGnzWsr2A5OJGdDAjvgNxRKMAjuu2c=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=mtaQF16x8x8TtoNmajBAQsFBQcyz452I8zaezPy2IajXIEuV41jKUuqBPXnhugJ3A
         On8LKmq93MgBiXxvV5HUMEsaw28tCN33h3q0E+YpsAnmq/vq/C6qbPf7qQr9wPrHgd
         mFBLffGq6n9Y40gsEzihQ1NEhHYsHA7sYxWgbn/Y=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        =?UTF-8?q?=C3=81lvaro=20Fern=C3=A1ndez=20Rojas?= 
        <noltari@gmail.com>, Miquel Raynal <miquel.raynal@bootlin.com>
Subject: [PATCH 4.19 261/267] mtd: rawnand: brcmnand: fix hamming oob layout
Date:   Fri, 19 Jun 2020 16:34:06 +0200
Message-Id: <20200619141701.183626966@linuxfoundation.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200619141648.840376470@linuxfoundation.org>
References: <20200619141648.840376470@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Álvaro Fernández Rojas <noltari@gmail.com>

commit 130bbde4809b011faf64f99dddc14b4b01f440c3 upstream.

First 2 bytes are used in large-page nand.

Fixes: ef5eeea6e911 ("mtd: nand: brcm: switch to mtd_ooblayout_ops")
Cc: stable@vger.kernel.org
Signed-off-by: Álvaro Fernández Rojas <noltari@gmail.com>
Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
Link: https://lore.kernel.org/linux-mtd/20200512075733.745374-2-noltari@gmail.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/mtd/nand/raw/brcmnand/brcmnand.c |   11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

--- a/drivers/mtd/nand/raw/brcmnand/brcmnand.c
+++ b/drivers/mtd/nand/raw/brcmnand/brcmnand.c
@@ -911,11 +911,14 @@ static int brcmnand_hamming_ooblayout_fr
 		if (!section) {
 			/*
 			 * Small-page NAND use byte 6 for BBI while large-page
-			 * NAND use byte 0.
+			 * NAND use bytes 0 and 1.
 			 */
-			if (cfg->page_size > 512)
-				oobregion->offset++;
-			oobregion->length--;
+			if (cfg->page_size > 512) {
+				oobregion->offset += 2;
+				oobregion->length -= 2;
+			} else {
+				oobregion->length--;
+			}
 		}
 	}
 


