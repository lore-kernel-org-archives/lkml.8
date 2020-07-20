Return-Path: <SRS0=bl3x=A7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33AD6C433E1
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jul 2020 16:03:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0D4A920773
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jul 2020 16:03:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1595260988;
	bh=V839BRFzkruzT/GCkTOiar1oEa7/OC6IGQ6iENdU+WA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=F3xcXGOEoWe0y3dVLFshQfl4QrKUA3w1/ouuRXlJxxcvAG2DSf1KbBByU0oP89IcJ
	 4fYRBF8atHEDkMCXPQiQGrWqW4LMK7uGKvYMangZ4ZhtPR8uesUJb9E0nnJMes8cRk
	 ubJwKfNN+hMAHunPnTS+RKaFhl6/lqaTxV3+5go4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732009AbgGTQDG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Jul 2020 12:03:06 -0400
Received: from mail.kernel.org ([198.145.29.99]:37066 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728997AbgGTQC5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jul 2020 12:02:57 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8B6F320773;
        Mon, 20 Jul 2020 16:02:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1595260977;
        bh=V839BRFzkruzT/GCkTOiar1oEa7/OC6IGQ6iENdU+WA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=dzhS3RSnE6utTpHOSYzwqa8X3ll7GF938fpiBC5L87vc/hmps+t1TWGH0dZ83L6LI
         PNsu/wY38Cus8u+ZYCBeNS3anIVBClPI4EByCZ+flhzDoJuLtQ5pJtNhqSqEZQsMND
         9pC7TzMEU5zTHrJdd7SsFDuaalP38R83PsD1LznE=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Miquel Raynal <miquel.raynal@bootlin.com>,
        Boris Brezillon <boris.brezillon@collabora.com>
Subject: [PATCH 5.4 134/215] mtd: rawnand: timings: Fix default tR_max and tCCS_min timings
Date:   Mon, 20 Jul 2020 17:36:56 +0200
Message-Id: <20200720152826.567436136@linuxfoundation.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200720152820.122442056@linuxfoundation.org>
References: <20200720152820.122442056@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Miquel Raynal <miquel.raynal@bootlin.com>

commit 4d8ec041d9c454029f6cd90622f6d81eb61e781c upstream.

tR and tCCS are currently wrongly expressed in femtoseconds, while we
expect these values to be expressed in picoseconds. Set right
hardcoded values.

Fixes: 6a943386ee36 mtd: rawnand: add default values for dynamic timings
Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
Reviewed-by: Boris Brezillon <boris.brezillon@collabora.com>
Link: https://lore.kernel.org/linux-mtd/20200428094302.14624-3-miquel.raynal@bootlin.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/mtd/nand/raw/nand_timings.c |    5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

--- a/drivers/mtd/nand/raw/nand_timings.c
+++ b/drivers/mtd/nand/raw/nand_timings.c
@@ -314,10 +314,9 @@ int onfi_fill_data_interface(struct nand
 		/* microseconds -> picoseconds */
 		timings->tPROG_max = 1000000ULL * ONFI_DYN_TIMING_MAX;
 		timings->tBERS_max = 1000000ULL * ONFI_DYN_TIMING_MAX;
-		timings->tR_max = 1000000ULL * 200000000ULL;
 
-		/* nanoseconds -> picoseconds */
-		timings->tCCS_min = 1000UL * 500000;
+		timings->tR_max = 200000000;
+		timings->tCCS_min = 500000;
 	}
 
 	return 0;


