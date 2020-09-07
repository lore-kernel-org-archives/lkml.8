Return-Path: <SRS0=/EmK=CQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F1EBC43461
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Sep 2020 07:22:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 13CCC215A4
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Sep 2020 07:22:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727033AbgIGHWY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Sep 2020 03:22:24 -0400
Received: from relay8-d.mail.gandi.net ([217.70.183.201]:52589 "EHLO
        relay8-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726410AbgIGHWW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Sep 2020 03:22:22 -0400
X-Originating-IP: 91.224.148.103
Received: from localhost.localdomain (unknown [91.224.148.103])
        (Authenticated sender: miquel.raynal@bootlin.com)
        by relay8-d.mail.gandi.net (Postfix) with ESMTPSA id 5A70A1BF21D;
        Mon,  7 Sep 2020 07:22:18 +0000 (UTC)
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     YouChing Lin <ycllin@mxic.com.tw>, miquel.raynal@bootlin.com,
        richard@nod.at, vigneshr@ti.com
Cc:     juliensu@mxic.com.tw, linux-mtd@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] mtd: spinand: macronix: Add support for MX31LF1GE4BC
Date:   Mon,  7 Sep 2020 09:22:17 +0200
Message-Id: <20200907072217.3630-1-miquel.raynal@bootlin.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <1595404978-31079-2-git-send-email-ycllin@mxic.com.tw>
References: 
MIME-Version: 1.0
X-linux-mtd-patch-notification: thanks
X-linux-mtd-patch-commit: f912b63b9462c0476c34c4ae205fe88bcb093737
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2020-07-22 at 08:02:57 UTC, YouChing Lin wrote:
> The Macronix MX31LF1GE4BC is a 3V, 1Gbit (128MB) serial
> NAND flash device.
> 
> Validated by read, erase, read back, write and read back
> on Xilinx Zynq PicoZed FPGA board which included
> Macronix SPI Host (driver/spi/spi-mxic.c).
> 
> Signed-off-by: YouChing Lin <ycllin@mxic.com.tw>

Applied to https://git.kernel.org/pub/scm/linux/kernel/git/mtd/linux.git nand/next, thanks.

Miquel
