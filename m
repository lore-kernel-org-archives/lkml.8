Return-Path: <SRS0=4r1w=5T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B1A9C43331
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Apr 2020 00:40:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E2C6720675
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Apr 2020 00:40:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1585874428;
	bh=AvTELZADH9IOKaT0E3zi5IeET7bjiewk+pSbc0nxanI=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=zSKyS+dnzeTdD57EqfATyvwF9kO3sV0Bk6wk0TQ/IMCRjLhosWjf/1/iUKwnC2GQS
	 8DenThzxUV51Eh5TxgDd5Ob8vsy4r/OnQVN2zzqyd1IaJKNn/+mXbGyJK5Sz/CShcU
	 ST6IpS3/YRdJ6bJTShFvRw2LV8m/URGm1NqRf8Tk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390490AbgDCAk1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Apr 2020 20:40:27 -0400
Received: from mail.kernel.org ([198.145.29.99]:39196 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390468AbgDCAkX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Apr 2020 20:40:23 -0400
Subject: Re: [GIT PULL] mtd: Changes for 5.7
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1585874423;
        bh=AvTELZADH9IOKaT0E3zi5IeET7bjiewk+pSbc0nxanI=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=LWs2XNaWtL8PWx/qskdiWYZxBgoZE1JqwQFrVrqglfRp+oeoJg4yuFVRR5AaZI2MV
         wt3P61S9m6rS7NNyxJyJdPhPs1MkESfycWfqDDInK8OjFb0hmRT7LcB2jKIpJTqQ+5
         lkRNbpRGz2ViBtKtPcOnX4MLmweC+WZkEX3kgG+U=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20200402182811.457e9220@xps13>
References: <20200402182811.457e9220@xps13>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20200402182811.457e9220@xps13>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/mtd/linux.git tags/mtd/for-5.7
X-PR-Tracked-Commit-Id: 025a06c1104cd8995646b761d117816b5f28c873
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: e109f506074152b7241bcbd3949a099e776cb802
Message-Id: <158587442328.31624.4354605256453876674.pr-tracker-bot@kernel.org>
Date:   Fri, 03 Apr 2020 00:40:23 +0000
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

The pull request you sent on Thu, 2 Apr 2020 18:28:11 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/mtd/linux.git tags/mtd/for-5.7

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/e109f506074152b7241bcbd3949a099e776cb802

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
