Return-Path: <SRS0=faA3=B4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96C37C433E1
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Aug 2020 21:33:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6C4CF206DA
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Aug 2020 21:33:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1597786430;
	bh=cNUrLK+X4dZ3cJneIUdks56upA/Yo4qs7Nws4YCabGE=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=tRgD6415zTHQRNnIle6TXi3/kkfzhAT8+d8JXubw8CYEAInCqbH/PJM47I3coHxom
	 dKFPu74+/ZuXjUEe5Jos2ijSCzCDvZn9cvvvpvPKq3o+rGQlYiG0/1teBqIugVp+9y
	 q1FokBLj79IG7SYW0qCrbs4PyhIYI3tK6DmJMKNA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726778AbgHRVds (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Aug 2020 17:33:48 -0400
Received: from mail.kernel.org ([198.145.29.99]:56198 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726366AbgHRVdp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Aug 2020 17:33:45 -0400
Subject: Re: [GIT PULL] SPI fixes for v5.9-rc1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1597786424;
        bh=cNUrLK+X4dZ3cJneIUdks56upA/Yo4qs7Nws4YCabGE=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=IcOuSLKWn6+i4LDQ977EbwgFvFyj0d1J3KgWkjTZ6Spu96qxkG7/W+psHmb7NGmMx
         q5Fb6Fsjajyz4iJ58ylQfF1Y6xt0z1lfjOlzaiprMCN9aDBwzkhA7HoA9G056NWS1T
         lPU1ReHFjSIFohL08BxymyxzLj2j8a2Rc6dGOHao=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20200818183327.30A0E2075E@mail.kernel.org>
References: <20200818183327.30A0E2075E@mail.kernel.org>
X-PR-Tracked-List-Id: <linux-spi.vger.kernel.org>
X-PR-Tracked-Message-Id: <20200818183327.30A0E2075E@mail.kernel.org>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git tags/spi-fix-v5.9-rc1
X-PR-Tracked-Commit-Id: 8cb61d65b1c8d5bc5b37ebab498ca2f78d264ddb
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 18445bf405cb331117bc98427b1ba6f12418ad17
Message-Id: <159778642459.7307.9543642986732637888.pr-tracker-bot@kernel.org>
Date:   Tue, 18 Aug 2020 21:33:44 +0000
To:     Mark Brown <broonie@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Mark Brown <broonie@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Tue, 18 Aug 2020 19:32:51 +0100:

> https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git tags/spi-fix-v5.9-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/18445bf405cb331117bc98427b1ba6f12418ad17

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
