Return-Path: <SRS0=aTFg=AS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52BC2C433DF
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jul 2020 21:25:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2F7D520720
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jul 2020 21:25:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1594157108;
	bh=/hFxyPdJkVEBb+4BKyEtpVmOBbZlj2PiEuIWvGs35Zs=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=ePvikBG6SEIVSqNHUp7jiHaCGmiNZtPqb15YT5AGDEu0tTE4smESW2kRu8quuPJT2
	 PCILksXdo0VSR228YTtQHqGWTIj6H8TB1rDh798UFcvff+CVf5kDvJPahpXxVW/Gyx
	 qFqDS4TYz0GqVEbsAG6mz9yVeqUWg385QiCF4QlU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729276AbgGGVZH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Jul 2020 17:25:07 -0400
Received: from mail.kernel.org ([198.145.29.99]:34230 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729085AbgGGVZF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jul 2020 17:25:05 -0400
Subject: Re: [GIT PULL] ARC updates for 5.8-rc5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1594157105;
        bh=/hFxyPdJkVEBb+4BKyEtpVmOBbZlj2PiEuIWvGs35Zs=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=QUCvcReV0SFWH56zVJsPGmj02jUFPVzkc6cnm2UzA9xDApA9WAUcNIh0JYK03CxFN
         VefL4o0pa/MyAbSJdoAHLr92pvknLqegZmPxuN6QTCM8/hbmY3HR8S9QHQf1SlYIJP
         A1x5AFaIBcTXMPN/pXljq7ycCrU9rgGbE04uF/iQ=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <41052a3e-c51d-a0d8-06ea-af1e30fb097a@synopsys.com>
References: <41052a3e-c51d-a0d8-06ea-af1e30fb097a@synopsys.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <41052a3e-c51d-a0d8-06ea-af1e30fb097a@synopsys.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/vgupta/arc.git/
 tags/arc-5.8-rc5
X-PR-Tracked-Commit-Id: 10011f7d95dea311c0f2a3ea6725b5a2e97015a8
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 9e4d7696213f0231f7a54512da4b8514eb316edb
Message-Id: <159415710502.29940.10137709672282322588.pr-tracker-bot@kernel.org>
Date:   Tue, 07 Jul 2020 21:25:05 +0000
To:     Vineet Gupta <Vineet.Gupta1@synopsys.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        lkml <linux-kernel@vger.kernel.org>,
        arcml <linux-snps-arc@lists.infradead.org>,
        Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Tue, 7 Jul 2020 06:18:57 +0000:

> git://git.kernel.org/pub/scm/linux/kernel/git/vgupta/arc.git/ tags/arc-5.8-rc5

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/9e4d7696213f0231f7a54512da4b8514eb316edb

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
