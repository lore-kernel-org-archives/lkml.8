Return-Path: <SRS0=qsSF=76=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83DC4C433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jun 2020 00:50:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5878620786
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jun 2020 00:50:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1592355025;
	bh=m6z2ahPRmYR+C5h8JIEjjQwgOKPybyhc+OVDqdoazgs=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=kjqGVhNc0/Iwxtx659PHEUstd4xvKzbIBzu+2JTzjmcW2q4/6VWEUJCWXvFKJewZq
	 4MohiDVlX7X9O2BFvo9hjO67JXH2WrM2j3JtU73906iJiMbgOVZcMvQMz/wFEyZohJ
	 LG0euh72WDuL6PAdn8k5NCKBOsAGN+UU3i0xOK8U=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726564AbgFQAuY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Jun 2020 20:50:24 -0400
Received: from mail.kernel.org ([198.145.29.99]:42292 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725894AbgFQAuX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Jun 2020 20:50:23 -0400
Subject: Re: [GIT] Networking
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592355023;
        bh=m6z2ahPRmYR+C5h8JIEjjQwgOKPybyhc+OVDqdoazgs=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=Yo+ZeMxIJpcS5MZpVPqRG7+oEV3AOP20+cDA7dRIi4/L2i2RW/ySh6pNeORoA6nej
         wrioRE+PmfQREVgbgtGGeGUiMQdw/gzbOIvlLeTe6vhb7BcfGUNmbBCiQRWbzZpcTr
         SZeMLjDtpWgee/Qd2W8c0LCr25jSRC0djH72opIo=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20200616.162551.466272432384185418.davem@davemloft.net>
References: <20200616.162551.466272432384185418.davem@davemloft.net>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20200616.162551.466272432384185418.davem@davemloft.net>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net
 refs/heads/master
X-PR-Tracked-Commit-Id: c9f66b43ee27409e1b614434d87e0e722efaa5f2
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 69119673bd50b176ded34032fadd41530fb5af21
Message-Id: <159235502302.21332.14231690259220652113.pr-tracker-bot@kernel.org>
Date:   Wed, 17 Jun 2020 00:50:23 +0000
To:     David Miller <davem@davemloft.net>
Cc:     torvalds@linux-foundation.org, akpm@linux-foundation.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Tue, 16 Jun 2020 16:25:51 -0700 (PDT):

> git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net refs/heads/master

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/69119673bd50b176ded34032fadd41530fb5af21

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
