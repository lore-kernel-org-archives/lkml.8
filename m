Return-Path: <SRS0=N8G3=3G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AFFE1C33CB6
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jan 2020 21:47:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 906432072B
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jan 2020 21:47:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729423AbgAQVrr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Jan 2020 16:47:47 -0500
Received: from relay6-d.mail.gandi.net ([217.70.183.198]:55869 "EHLO
        relay6-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726587AbgAQVrr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jan 2020 16:47:47 -0500
X-Originating-IP: 91.224.148.103
Received: from localhost.localdomain (unknown [91.224.148.103])
        (Authenticated sender: miquel.raynal@bootlin.com)
        by relay6-d.mail.gandi.net (Postfix) with ESMTPSA id 38CC7C0006;
        Fri, 17 Jan 2020 21:47:45 +0000 (UTC)
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Michael Walle <michael@walle.cc>, linux-mtd@lists.infradead.org,
        linux-kernel@vger.kernel.org
Cc:     Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Tudor Ambarus <tudor.ambarus@microchip.com>
Subject: Re: [PATCH] mtd: spi-nor: Fix quad enable for Spansion like flashes
Date:   Fri, 17 Jan 2020 22:47:44 +0100
Message-Id: <20200117214744.21608-1-miquel.raynal@bootlin.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200116093700.28308-1-michael@walle.cc>
References: 
MIME-Version: 1.0
X-linux-mtd-patch-notification: thanks
X-linux-mtd-patch-commit: da2ef8124f20b4ce18d1d3d24fc7b88e687e10bb
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2020-01-16 at 09:37:00 UTC, Michael Walle wrote:
> The commit 7b678c69c0ca ("mtd: spi-nor: Merge spansion Quad Enable
> methods") forgot to actually set the QE bit in some cases. Thus this
> breaks quad mode accesses to flashes which support readback of the
> status register-2. Fix it.
> 
> Fixes: 7b678c69c0ca ("mtd: spi-nor: Merge spansion Quad Enable methods")
> Signed-off-by: Michael Walle <michael@walle.cc>
> Reviewed-by: Tudor Ambarus <tudor.ambarus@microchip.com>

Applied to https://git.kernel.org/pub/scm/linux/kernel/git/mtd/linux.git mtd/fixes, thanks.

Miquel
