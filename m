Return-Path: <SRS0=pPEE=3I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8FC4EC32771
	for <linux-kernel@archiver.kernel.org>; Sun, 19 Jan 2020 00:45:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5B4BB246AF
	for <linux-kernel@archiver.kernel.org>; Sun, 19 Jan 2020 00:45:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1579394706;
	bh=4jaTZsPssUnlGROcOhT9Ai+w5KGJFxOEw+2uudQnpy0=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=Hf6GpsjkeICkd/BpkT6zNv4VymC7gNxG3NIFv4ZTIGc1f05Q4xzMucPJQWdDzDgFi
	 L9hlHj3MC53wlu42UY9q5l4EOtjRqaBPKCipSvbxsHPpWuZ8j+SZdFl1FwskQxeD02
	 clZ85VsaWKV8BDTx6kb6F3F32VMnPm0Xp6/K5xg4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727107AbgASApE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 18 Jan 2020 19:45:04 -0500
Received: from mail.kernel.org ([198.145.29.99]:43584 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727028AbgASApE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Jan 2020 19:45:04 -0500
Subject: Re: [GIT PULL] mtd: Fixes for 5.5-rc7 or final
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1579394703;
        bh=4jaTZsPssUnlGROcOhT9Ai+w5KGJFxOEw+2uudQnpy0=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=UWVNFYn/z1ZQgCH7GtDcE6gkEijahAwJrCSjvQbwCoOWR/FM+gfdFJTmQyOJZFTBs
         MSWWzu1UwpfVTFtDIlbm1//YwG2HvAe8CCPJmN8z6JVQB4+qtOkDokGw5WZSE7aWKR
         GmlypmKMC6gETolecujM8ez4+btdv/Jr6BQH2cSM=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20200118231006.6776f277@xps13>
References: <20200118231006.6776f277@xps13>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20200118231006.6776f277@xps13>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/mtd/linux.git
 tags/mtd/fixes-for-5.5-rc7
X-PR-Tracked-Commit-Id: d70486668cdf51b14a50425ab45fc18677a167b2
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 8f8972a3127ff46df62ae30057d29606968ec4aa
Message-Id: <157939470381.10292.5450797739537723471.pr-tracker-bot@kernel.org>
Date:   Sun, 19 Jan 2020 00:45:03 +0000
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

The pull request you sent on Sat, 18 Jan 2020 23:13:07 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/mtd/linux.git tags/mtd/fixes-for-5.5-rc7

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/8f8972a3127ff46df62ae30057d29606968ec4aa

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
