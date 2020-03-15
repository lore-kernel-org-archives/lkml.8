Return-Path: <SRS0=iqK9=5A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 596E2C0044D
	for <linux-kernel@archiver.kernel.org>; Sun, 15 Mar 2020 02:30:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2D597205C9
	for <linux-kernel@archiver.kernel.org>; Sun, 15 Mar 2020 02:30:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1584239411;
	bh=1q6bajXbqbxUwzuEHjZRZVpvqQfxgasrtsrSb01PJ6U=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=z6TWWUCESNj0w1yI22udaz7ZkpHUApR7XaD5WojkxWIpE1pRyrk0FaUI6Mw9w6m2m
	 3SXgRtxDZ9gN++T4XJsE75YyWGmN42/gMIMKLn4/+GKHHHjWJgsu2cz5ELeJlCjC5g
	 j1WeIlDZWRAYyXtYcYvTIEhXsyJu66xq1UC0fvwU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727880AbgCOCaK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 14 Mar 2020 22:30:10 -0400
Received: from mail.kernel.org ([198.145.29.99]:41046 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727473AbgCOCaI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 14 Mar 2020 22:30:08 -0400
Subject: Re: [GIT PULL] ARC updates for 5.6-rc6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1584239408;
        bh=1q6bajXbqbxUwzuEHjZRZVpvqQfxgasrtsrSb01PJ6U=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=OC5du9q+syctdkhADLUQjg99vYSPT6Tl+wnFliudkCfYzW5FoJzKye7PdQSW58Q2I
         KDqlwCPiLYcsbjXlzDv0fEDukscU5ZDP7v7MdezI/KgjXOw/ycWLj5zIaXApJ9CQN9
         vtucPQXTt66d85jvc0H27GCCzoY87VqPN62/oxBY=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <e38a57cc-3744-e3b8-3c5f-b96b218aebd4@synopsys.com>
References: <e38a57cc-3744-e3b8-3c5f-b96b218aebd4@synopsys.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <e38a57cc-3744-e3b8-3c5f-b96b218aebd4@synopsys.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/vgupta/arc.git/
 tags/arc-5.6-rc6
X-PR-Tracked-Commit-Id: 8d92e992a785f35d23f845206cf8c6cafbc264e0
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 3086ae071686e0fff1c0006a635f101edc5f3540
Message-Id: <158423940813.21543.9361557527358610579.pr-tracker-bot@kernel.org>
Date:   Sun, 15 Mar 2020 02:30:08 +0000
To:     Vineet Gupta <Vineet.Gupta1@synopsys.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        arcml <linux-snps-arc@lists.infradead.org>,
        lkml <linux-kernel@vger.kernel.org>,
        Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sat, 14 Mar 2020 19:15:03 +0000:

> git://git.kernel.org/pub/scm/linux/kernel/git/vgupta/arc.git/ tags/arc-5.6-rc6

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/3086ae071686e0fff1c0006a635f101edc5f3540

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
