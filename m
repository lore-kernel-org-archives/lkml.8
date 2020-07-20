Return-Path: <SRS0=bl3x=A7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5760C433E3
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jul 2020 16:11:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A5CE5206E9
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jul 2020 16:11:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1595261493;
	bh=J6D3S30ahjRUeLrBap+5HbB0G8gUAQcnb7opceuRGvc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=hQU60j1FXWSJ6SQnmb2VB/tdcatCF1tMFOdwTUdCwAWJZPYtvMx39cp8X4Pu+DZ1l
	 N/Tju60FakmDe2LjHKlZ6n4llb8pLZsFpA9SBXrMGZDA6e0S7LJaEc3gIG1x/opvFw
	 fAto/ZALkjt8pou17KtghzJWBHrzD7cLiUKcCPa8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387815AbgGTQLb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Jul 2020 12:11:31 -0400
Received: from mail.kernel.org ([198.145.29.99]:50528 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387800AbgGTQL1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jul 2020 12:11:27 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3363920734;
        Mon, 20 Jul 2020 16:11:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1595261486;
        bh=J6D3S30ahjRUeLrBap+5HbB0G8gUAQcnb7opceuRGvc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Qg6r+lDV4WiLe+68kUbLQqabnDP2M0vYRhWaCId+j3hGQKMEiZgvyZ7RSTQD5UQun
         zwv9zOH3d790zxE8cfxGh778RCLltlbeDCCvucrxs2EDqFg5DGuC87QpQFnSjIPTtm
         njojwZDt6U6LLM3VymEsZtThqCH2+xsrmNUu1gyU=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>,
        Alexander Sverdlin <alexander.sverdlin@nokia.com>,
        Kuldeep Singh <kuldeep.singh@nxp.com>,
        Tudor Ambarus <tudor.ambarus@microchip.com>
Subject: [PATCH 5.7 133/244] mtd: spi-nor: spansion: fix writes on S25FS512S
Date:   Mon, 20 Jul 2020 17:36:44 +0200
Message-Id: <20200720152832.172014628@linuxfoundation.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200720152825.863040590@linuxfoundation.org>
References: <20200720152825.863040590@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>

commit 5587fa489747a8e6cbd0558890458c862b797485 upstream.

Spansion S25FS-S family has an issue in the Basic Flash Parameter Table
(BFPT): Dword-11 bits 7:4 specify a page size of 512 bytes.  Actually
this is configurable in the vendor unique register (CR3V) and even the
factory default setting is to "wrap at 256 bytes", so blindly relying
on BFPT breaks the page writes on these chips. Add the post-BFPT fixup
which restores the default page size of 256 bytes -- to properly read
CR3V this early is quite intrusive and should better be done as a new
feature; Alexander Sverdlin had the patch doing that:

https://patchwork.ozlabs.org/project/linux-mtd/patch/20200227123657.26030-1-alexander.sverdlin@nokia.com/

Fixes: dfd2b74530e ("mtd: spi-nor: add Spansion S25FS512S ID")
Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Reviewed-by: Alexander Sverdlin <alexander.sverdlin@nokia.com>
Tested-by: Kuldeep Singh <kuldeep.singh@nxp.com>
Signed-off-by: Tudor Ambarus <tudor.ambarus@microchip.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/mtd/spi-nor/spansion.c |   25 +++++++++++++++++++++++--
 1 file changed, 23 insertions(+), 2 deletions(-)

--- a/drivers/mtd/spi-nor/spansion.c
+++ b/drivers/mtd/spi-nor/spansion.c
@@ -8,6 +8,27 @@
 
 #include "core.h"
 
+static int
+s25fs_s_post_bfpt_fixups(struct spi_nor *nor,
+			 const struct sfdp_parameter_header *bfpt_header,
+			 const struct sfdp_bfpt *bfpt,
+			 struct spi_nor_flash_parameter *params)
+{
+	/*
+	 * The S25FS-S chip family reports 512-byte pages in BFPT but
+	 * in reality the write buffer still wraps at the safe default
+	 * of 256 bytes.  Overwrite the page size advertised by BFPT
+	 * to get the writes working.
+	 */
+	params->page_size = 256;
+
+	return 0;
+}
+
+static struct spi_nor_fixups s25fs_s_fixups = {
+	.post_bfpt = s25fs_s_post_bfpt_fixups,
+};
+
 static const struct flash_info spansion_parts[] = {
 	/* Spansion/Cypress -- single (large) sector size only, at least
 	 * for the chips listed here (without boot sectors).
@@ -30,8 +51,8 @@ static const struct flash_info spansion_
 			      SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ |
 			      SPI_NOR_HAS_LOCK | USE_CLSR) },
 	{ "s25fs512s",  INFO6(0x010220, 0x4d0081, 256 * 1024, 256,
-			      SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ |
-			      USE_CLSR) },
+			      SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ | USE_CLSR)
+	  .fixups = &s25fs_s_fixups, },
 	{ "s70fl01gs",  INFO(0x010221, 0x4d00, 256 * 1024, 256, 0) },
 	{ "s25sl12800", INFO(0x012018, 0x0300, 256 * 1024,  64, 0) },
 	{ "s25sl12801", INFO(0x012018, 0x0301,  64 * 1024, 256, 0) },


