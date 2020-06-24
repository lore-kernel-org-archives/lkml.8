Return-Path: <SRS0=sD2I=AF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3FD95C433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jun 2020 21:25:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 17900207FC
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jun 2020 21:25:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1593033921;
	bh=loD0WLhHs7MhFPX2AQkwfVgfn8vb4ff72svvg6ocrS8=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=kS6l1kS1METiX2I2ToAONNkncTdi1EQZJ17tny0VtMC1XTXLptwQwSmQE5uw6TX+0
	 5VRu6StPrsXko7zuep1dIfGd3rRXGaHHP/1D+X+pZOJQI7a0EDSPjsqm58A614EtN9
	 rpehig1F1XtOkVKf609pEar76eg1bVhLND9766Rc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403789AbgFXVZT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Jun 2020 17:25:19 -0400
Received: from mail.kernel.org ([198.145.29.99]:59572 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390671AbgFXVZT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Jun 2020 17:25:19 -0400
Subject: Re: [GIT PULL] thread fixes v5.8-rc3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1593033918;
        bh=loD0WLhHs7MhFPX2AQkwfVgfn8vb4ff72svvg6ocrS8=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=IBJkgYX/yvNtyljA3ok5jxQmTs6IhFGYaaeofV2x60XcXHsESq3Coeh+ox2EUbROE
         xxvAOWg6yw0mEw5VaCSQcYqT6y+sBgGTrTBs9ik6GJopfqoYzQTdD6ghWYD67EsbZ+
         n4gCIwvXJeWBVjdTIpYeYUyxrvEVD46kjVfJe+5g=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20200624130712.1080689-1-christian.brauner@ubuntu.com>
References: <20200624130712.1080689-1-christian.brauner@ubuntu.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20200624130712.1080689-1-christian.brauner@ubuntu.com>
X-PR-Tracked-Remote: git@gitolite.kernel.org:pub/scm/linux/kernel/git/brauner/linux
 tags/for-linus-2020-06-24
X-PR-Tracked-Commit-Id: 86f56395feb2b106b125c47e72192e37da5dd088
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: fbb58011fdd9ca2e2f0e329d11085ddf46830c5a
Message-Id: <159303391856.29026.4904181836899045345.pr-tracker-bot@kernel.org>
Date:   Wed, 24 Jun 2020 21:25:18 +0000
To:     Christian Brauner <christian.brauner@ubuntu.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Wed, 24 Jun 2020 15:07:12 +0200:

> git@gitolite.kernel.org:pub/scm/linux/kernel/git/brauner/linux tags/for-linus-2020-06-24

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/fbb58011fdd9ca2e2f0e329d11085ddf46830c5a

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
