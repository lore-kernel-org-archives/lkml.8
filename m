Return-Path: <SRS0=K2g5=43=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1284DC3F2D0
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Mar 2020 18:31:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E4D8421D7E
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Mar 2020 18:31:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727564AbgCJSbq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Mar 2020 14:31:46 -0400
Received: from relay3-d.mail.gandi.net ([217.70.183.195]:43671 "EHLO
        relay3-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727268AbgCJSbq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Mar 2020 14:31:46 -0400
X-Originating-IP: 91.224.148.103
Received: from localhost.localdomain (unknown [91.224.148.103])
        (Authenticated sender: miquel.raynal@bootlin.com)
        by relay3-d.mail.gandi.net (Postfix) with ESMTPSA id 235AE6000A;
        Tue, 10 Mar 2020 18:31:42 +0000 (UTC)
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Schrempf Frieder <frieder.schrempf@kontron.de>,
        Boris Brezillon <bbrezillon@kernel.org>,
        Jeff Kletsky <git-commits@allycomm.com>,
        liaoweixiong <liaoweixiong@allwinnertech.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>
Cc:     Richard Weinberger <richard@nod.at>,
        "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 2/3] mtd: spinand: Explicitly use MTD_OPS_RAW to write the bad block marker to OOB
Date:   Tue, 10 Mar 2020 19:31:42 +0100
Message-Id: <20200310183142.18777-1-miquel.raynal@bootlin.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200218100432.32433-3-frieder.schrempf@kontron.de>
References: 
MIME-Version: 1.0
X-linux-mtd-patch-notification: thanks
X-linux-mtd-patch-commit: 958272110eefde17d5d97a3e3e7427c97b48f179
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2020-02-18 at 10:05:25 UTC, Schrempf Frieder wrote:
> From: Frieder Schrempf <frieder.schrempf@kontron.de>
> 
> When writing the bad block marker to the OOB area the access mode
> should be set to MTD_OPS_RAW as it is done for reading the marker.
> Currently this only works because req.mode is initialized to
> MTD_OPS_PLACE_OOB (0) and spinand_write_to_cache_op() checks for
> req.mode != MTD_OPS_AUTO_OOB.
> 
> Fix this by explicitly setting req.mode to MTD_OPS_RAW.
> 
> Fixes: 7529df465248 ("mtd: nand: Add core infrastructure to support SPI NANDs")
> Signed-off-by: Frieder Schrempf <frieder.schrempf@kontron.de>
> Reviewed-by: Boris Brezillon <boris.brezillon@collabora.com>

Applied to https://git.kernel.org/pub/scm/linux/kernel/git/mtd/linux.git nand/next, thanks.

Miquel
