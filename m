Return-Path: <SRS0=aTFg=AS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA482C433DF
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jul 2020 22:10:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 883CE20720
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jul 2020 22:10:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1594159807;
	bh=yAHAUQjTFiM9h5AbhaXGadEFpmCqHol/fEFrVD8As8E=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=sjZlLzOybE2Ni0pP/dM3N2orokyaP0x/eKrCIydpSimfWVkppByJWXe+IuuG7Lg0h
	 tkugX8Ym7vMPDfpo0VI8K9sKnqfuYZ3ZWRNin+4ghZDIsowgdwXeRDq7sia5EJXIfL
	 rNDrqPJcl0NKA1bJsnH/es+hd57mSQAIHhmZCZu0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729126AbgGGWKG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Jul 2020 18:10:06 -0400
Received: from mail.kernel.org ([198.145.29.99]:44460 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726946AbgGGWKF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jul 2020 18:10:05 -0400
Subject: Re: [GIT PULL] mtd: Fixes for v5.8-rc5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1594159805;
        bh=yAHAUQjTFiM9h5AbhaXGadEFpmCqHol/fEFrVD8As8E=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=Gcu0nYrUGDU3yH3gbVcxaEfwqZNjhNMW7g+s5SF4iQTCbbTr6SydxbZgmIIos5Ybj
         +OXpT+ZQjg24Lra9tnSr0CdzXK9+Pg0pCbAsfAITT0hxd2+pXnrH+195F/umilj12p
         PnDvp9yDMpVp4ZknozzgqQI8fE1xzhoBKWwmTti8=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20200707211531.7f762650@xps13>
References: <20200707211531.7f762650@xps13>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20200707211531.7f762650@xps13>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/mtd/linux.git
 tags/mtd/fixes-for-5.8-rc5
X-PR-Tracked-Commit-Id: 880bc529bae2257d05a767f7f5c24fd61a47b605
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 6d12075ddeedc38d25c5b74e929e686158da728c
Message-Id: <159415980526.15440.15200140158486298200.pr-tracker-bot@kernel.org>
Date:   Tue, 07 Jul 2020 22:10:05 +0000
To:     Miquel Raynal <miquel.raynal@bootlin.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-mtd@lists.infradead.org, Richard Weinberger <richard@nod.at>,
        Tudor Ambarus <Tudor.Ambarus@microchip.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Frieder Schrempf <frieder.schrempf@kontron.de>,
        linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Tue, 7 Jul 2020 21:15:31 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/mtd/linux.git tags/mtd/fixes-for-5.8-rc5

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/6d12075ddeedc38d25c5b74e929e686158da728c

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
