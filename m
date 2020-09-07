Return-Path: <SRS0=/EmK=CQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D044C43461
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Sep 2020 07:34:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 24FD821556
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Sep 2020 07:34:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727937AbgIGHex (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Sep 2020 03:34:53 -0400
Received: from relay3-d.mail.gandi.net ([217.70.183.195]:56399 "EHLO
        relay3-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727001AbgIGHeu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Sep 2020 03:34:50 -0400
X-Originating-IP: 91.224.148.103
Received: from localhost.localdomain (unknown [91.224.148.103])
        (Authenticated sender: miquel.raynal@bootlin.com)
        by relay3-d.mail.gandi.net (Postfix) with ESMTPSA id 4524D60014;
        Mon,  7 Sep 2020 07:34:47 +0000 (UTC)
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        linux-kernel@vger.kernel.org
Cc:     Miquel Raynal <miquel.raynal@bootlin.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Richard Weinberger <richard@nod.at>,
        linux-mtd@lists.infradead.org, Joe Perches <joe@perches.com>
Subject: Re: [PATCH v2 1/3] mtd: lpddr: Fix bad logic in print_drs_error
Date:   Mon,  7 Sep 2020 09:34:46 +0200
Message-Id: <20200907073446.27727-1-miquel.raynal@bootlin.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <3fb0e29f5b601db8be2938a01d974b00c8788501.1588016644.git.gustavo@embeddedor.com>
References: 
MIME-Version: 1.0
X-linux-mtd-patch-notification: thanks
X-linux-mtd-patch-commit: 1c9c02bb22684f6949d2e7ddc0a3ff364fd5a6fc
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2020-04-27 at 19:50:37 UTC, "Gustavo A. R. Silva" wrote:
> Update logic for broken test. Use a more common logging style.
> 
> It appears the logic in this function is broken for the
> consecutive tests of
> 
>         if (prog_status & 0x3)
>                 ...
>         else if (prog_status & 0x2)
>                 ...
>         else (prog_status & 0x1)
>                 ...
> 
> Likely the first test should be
> 
>         if ((prog_status & 0x3) == 0x3)
> 
> Found by inspection of include files using printk.
> 
> Fixes: eb3db27507f7 ("[MTD] LPDDR PFOW definition")
> Cc: stable@vger.kernel.org
> Reported-by: Joe Perches <joe@perches.com>
> Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
> Acked-by: Miquel Raynal <miquel.raynal@bootlin.com>

Applied to https://git.kernel.org/pub/scm/linux/kernel/git/mtd/linux.git mtd/next, thanks.

Miquel
