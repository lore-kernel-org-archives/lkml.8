Return-Path: <SRS0=K2g5=43=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0EA8DC10F27
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Mar 2020 18:33:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DD22021D56
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Mar 2020 18:33:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727488AbgCJSdl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Mar 2020 14:33:41 -0400
Received: from relay7-d.mail.gandi.net ([217.70.183.200]:58085 "EHLO
        relay7-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727451AbgCJSdl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Mar 2020 14:33:41 -0400
X-Originating-IP: 91.224.148.103
Received: from localhost.localdomain (unknown [91.224.148.103])
        (Authenticated sender: miquel.raynal@bootlin.com)
        by relay7-d.mail.gandi.net (Postfix) with ESMTPSA id 67E8D20008;
        Tue, 10 Mar 2020 18:33:39 +0000 (UTC)
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Chuanhong Guo <gch981213@gmail.com>, linux-mtd@lists.infradead.org,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Boris Brezillon <bbrezillon@kernel.org>
Cc:     Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4] mtd: nand: spi: rework detect procedure for different read id op
Date:   Tue, 10 Mar 2020 19:33:38 +0100
Message-Id: <20200310183338.19961-1-miquel.raynal@bootlin.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200208074439.146296-1-gch981213@gmail.com>
References: 
MIME-Version: 1.0
X-linux-mtd-patch-notification: thanks
X-linux-mtd-patch-commit: f1541773af49ecd1edae29c8ac0775253a0b0760
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2020-02-08 at 07:43:50 UTC, Chuanhong Guo wrote:
> Currently there are 3 different variants of read_id implementation:
> 1. opcode only. Found in GD5FxGQ4xF.
> 2. opcode + 1 addr byte. Found in GD5GxGQ4xA/E
> 3. opcode + 1 dummy byte. Found in other currently supported chips.
> 
> Original implementation was for variant 1 and let detect function
> of chips with variant 2 and 3 to ignore the first byte. This isn't
> robust:
> 
> 1. For chips of variant 2, if SPI master doesn't keep MOSI low
> during read, chip will get a random id offset, and the entire id
> buffer will shift by that offset, causing detect failure.
> 
> 2. For chips of variant 1, if it happens to get a devid that equals
> to manufacture id of variant 2 or 3 chips, it'll get incorrectly
> detected.
> 
> This patch reworks detect procedure to address problems above. New
> logic do detection for all variants separatedly, in 1-2-3 order.
> Since all current detect methods do exactly the same id matching
> procedure, unify them into core.c and remove detect method from
> manufacture_ops.
> 
> Tested on GD5F1GQ4UAYIG and W25N01GVZEIG.
> 
> Signed-off-by: Chuanhong Guo <gch981213@gmail.com>

Applied to https://git.kernel.org/pub/scm/linux/kernel/git/mtd/linux.git nand/next, thanks.

Miquel
