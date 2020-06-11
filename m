Return-Path: <SRS0=NqQd=7Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C662DC433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Jun 2020 01:50:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 98B7D206FA
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Jun 2020 01:50:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1591840233;
	bh=fuKqeMOezbx/AsSm7BSk2JV9+eDVzJDpiXbVf7edQSA=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=Fs2XFBP2PZLRwkIsIxpkgOh1Ru1Q5GrPbU51nBIAp3KmYNskrZpWiXJbcNgxNAV/S
	 VmKAyohpSEITA30K/3F3YKMboj0S34aSFIWCyJcTbWSZ1/6DrfV7rE4rHS2MPcgtm2
	 6dmWmHapwuagFhzPAfUG6WQ4HantRpCpokGwUsao=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726534AbgFKBuc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Jun 2020 21:50:32 -0400
Received: from mail.kernel.org ([198.145.29.99]:53582 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726312AbgFKBuZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Jun 2020 21:50:25 -0400
Subject: Re: [git pull] sysctl fixes
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1591840224;
        bh=fuKqeMOezbx/AsSm7BSk2JV9+eDVzJDpiXbVf7edQSA=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=QRQPxwXJ8buGLabio6vv001Qulxd2RVorobLcwA2adKr1ssZ0tbeDllmKTCSlABGO
         zIihrg7iSkwVsutupCVmkwN+OLS21HPUfsgd2c5s17vR+lvFaO79ew0ZGlVZK2pBLu
         o8VEXR1W9f60arsESOZgSOrS8tWgY2rHhbjoFsJw=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20200610202602.GU23230@ZenIV.linux.org.uk>
References: <20200610202602.GU23230@ZenIV.linux.org.uk>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20200610202602.GU23230@ZenIV.linux.org.uk>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/viro/vfs.git work.sysctl
X-PR-Tracked-Commit-Id: ef9d965bc8b6fce5bcc0ae76a4a5b3ed91ee81eb
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 1c3837266214c1e6fbbb96ff36bee13e923057d8
Message-Id: <159184022493.24802.15989622140997865864.pr-tracker-bot@kernel.org>
Date:   Thu, 11 Jun 2020 01:50:24 +0000
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Christoph Hellwig <hch@lst.de>, linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Wed, 10 Jun 2020 21:26:03 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/viro/vfs.git work.sysctl

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/1c3837266214c1e6fbbb96ff36bee13e923057d8

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
