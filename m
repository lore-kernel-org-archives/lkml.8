Return-Path: <SRS0=ne2O=7T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3466C433E0
	for <linux-kernel@archiver.kernel.org>; Sat,  6 Jun 2020 19:15:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7C2C320772
	for <linux-kernel@archiver.kernel.org>; Sat,  6 Jun 2020 19:15:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1591470932;
	bh=VRwezrwpQMvbb3BQiQdBcNFteObyDGAcxsXAXlCuYVo=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=QkK9xj32w4qboIvnK2o7vj+RbpTgkSJ4L9yg/F1Xuq+8am7QES9CHIA5UaF05rkHx
	 PvIDlXPbaya7X6DbjcHK/nFu1A/fvj5jOshz5V2ZyskVDn5rSDnU7okKJ12iE+JAY1
	 FFY2zx7I2I0c11tVPAid6LMSjR3l4Qqrq9kJ9ctQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729163AbgFFTPb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 6 Jun 2020 15:15:31 -0400
Received: from mail.kernel.org ([198.145.29.99]:34332 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728932AbgFFTPS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 6 Jun 2020 15:15:18 -0400
Subject: Re: [GIT PULL] dma-mapping updates for 5.8, part 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1591470918;
        bh=VRwezrwpQMvbb3BQiQdBcNFteObyDGAcxsXAXlCuYVo=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=p+RyqFQl6RcJ2C6Jxr0GZUyxOQhPVjrFqSish2/NsMQsNdnrcqz4ba3jcx/phYUNQ
         VyZo7HkkFskIWIhZKzExtHAHyWQeD/iFYhIJte+gLS6HD5yWVPYAEINc46k8e6TV1j
         pyu3m+AaYBzvZWkDAECQk4yu8ssMWdZusSdU2N6U=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20200606160657.GA3482728@infradead.org>
References: <20200606160657.GA3482728@infradead.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20200606160657.GA3482728@infradead.org>
X-PR-Tracked-Remote: git://git.infradead.org/users/hch/dma-mapping.git
 tags/dma-mapping-5.8
X-PR-Tracked-Commit-Id: 298f3db6ee690259927b105d5ad1079563361323
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 1ee18de92927f37e6948d5a6fc73cbf89f806905
Message-Id: <159147091841.3313.2281337702762277498.pr-tracker-bot@kernel.org>
Date:   Sat, 06 Jun 2020 19:15:18 +0000
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sat, 6 Jun 2020 18:06:57 +0200:

> git://git.infradead.org/users/hch/dma-mapping.git tags/dma-mapping-5.8

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/1ee18de92927f37e6948d5a6fc73cbf89f806905

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
