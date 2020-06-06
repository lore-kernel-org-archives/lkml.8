Return-Path: <SRS0=ne2O=7T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B165EC433DF
	for <linux-kernel@archiver.kernel.org>; Sat,  6 Jun 2020 19:15:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 901F220723
	for <linux-kernel@archiver.kernel.org>; Sat,  6 Jun 2020 19:15:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1591470921;
	bh=O2UFrw3CjqzF9TTixGBIaE373RNRtp+F3lZVcFWKefc=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=RasuC1fTCSvlfnUO7a/Vmkm2l6LR1/jBP7flfyxZ1eCdqRCYNwIFQBM+BF6K/hHGg
	 ZPE90jXaL90npZxF76Nug1YW4K6VVdWobxv0Af+7+dZta990UaywbmB6Qga2o2ctlR
	 2A8Oj9n/sHZL/xLfDjMN8GcBrjDg0nlP1N4faD4E=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728941AbgFFTPT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 6 Jun 2020 15:15:19 -0400
Received: from mail.kernel.org ([198.145.29.99]:34218 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728866AbgFFTPP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 6 Jun 2020 15:15:15 -0400
Subject: Re: [GIT PULL] dmi update for v5.8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1591470915;
        bh=O2UFrw3CjqzF9TTixGBIaE373RNRtp+F3lZVcFWKefc=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=Mj1B8ieqqnFUR4L5pq7qSsN6qAR3XqZaqz1bNRRIn3hRL8Z9P5HY847ZtjJDV82sU
         gb8Yj99BtuTO2pgHvIZPWmYhkMeEy1oMNMm+OkkJPV/CBy3hKJLjWFY4xlnNSPLnPt
         sy4WHtA8ux5On04MJf5VNFYqnV2HFC81P8pRhShs=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20200606171320.6023bedd@endymion>
References: <20200606171320.6023bedd@endymion>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20200606171320.6023bedd@endymion>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/jdelvare/staging.git
 dmi-for-linus
X-PR-Tracked-Commit-Id: f5152f4ded3ce6d332d5e4f9d7e325c3b81cae1b
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: e542e0dc3ee3eafc46dd8e3073388079d69cace0
Message-Id: <159147091553.3313.4493034952181370793.pr-tracker-bot@kernel.org>
Date:   Sat, 06 Jun 2020 19:15:15 +0000
To:     Jean Delvare <jdelvare@suse.de>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sat, 6 Jun 2020 17:13:20 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/jdelvare/staging.git dmi-for-linus

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/e542e0dc3ee3eafc46dd8e3073388079d69cace0

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
