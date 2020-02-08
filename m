Return-Path: <SRS0=BhYR=34=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D927C35242
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Feb 2020 22:35:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 268FD24676
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Feb 2020 22:35:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1581201330;
	bh=UNNYQJmN8ToxupVYn5auqyobsHUxANArpSrNy+gBrk0=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=cvEvbPoIAmTOvw6slH1vo8st3sOeqDJqDdCfwLDCYrJaSxnbG/4gSN5AzVImlnuyf
	 WSI+Yb/t+ZJKAgznblfHzZO27F2PcsiAox8TzYYeYGPy5dtEPNRF2icqKLTatlX3gg
	 nwRupUP3lVqAw1mtOIxPnQLHGFpEpk2UPOqDCLkM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727665AbgBHWf3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 8 Feb 2020 17:35:29 -0500
Received: from mail.kernel.org ([198.145.29.99]:56866 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727621AbgBHWf1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Feb 2020 17:35:27 -0500
Subject: Re: [GIT PULL 4/5] ARM: SoC defconfig updates
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1581201326;
        bh=UNNYQJmN8ToxupVYn5auqyobsHUxANArpSrNy+gBrk0=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=XXPvlC/XVNTY7qU4YBHQg8LeiSlk1qPGDWWXNiSXcFqHzTltvKliATmsZFFtdiYr1
         yIHJubOGE+eIhRQz4P9TCZmALI0+7QvHiijIsgWCK0VT0tyE+QsnQWfbdEHH41oEvi
         zskz243XT/3x+s2vnnR8XZW3sgbt/Q3U22fnuciY=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20200208112018.29819-5-olof@lixom.net>
References: <20200208112018.29819-1-olof@lixom.net>
 <20200208112018.29819-5-olof@lixom.net>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20200208112018.29819-5-olof@lixom.net>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/soc/soc.git
 tags/armsoc-defconfig
X-PR-Tracked-Commit-Id: 1342a6aa4abf6a56e83ce24ce5e84243c365ab4d
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 5939224ccdcc9244ab82cdbdc9d21eb019f7db6a
Message-Id: <158120132692.28764.14111524233349956571.pr-tracker-bot@kernel.org>
Date:   Sat, 08 Feb 2020 22:35:26 +0000
To:     Olof Johansson <olof@lixom.net>
Cc:     torvalds@linux-foundation.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, arm@kernel.org,
        soc@kernel.org, Olof Johansson <olof@lixom.net>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sat,  8 Feb 2020 03:20:17 -0800:

> git://git.kernel.org/pub/scm/linux/kernel/git/soc/soc.git tags/armsoc-defconfig

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/5939224ccdcc9244ab82cdbdc9d21eb019f7db6a

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
