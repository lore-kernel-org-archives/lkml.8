Return-Path: <SRS0=HA/2=BM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71233C433DF
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Aug 2020 00:00:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5181020789
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Aug 2020 00:00:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1596326416;
	bh=xNqGqF+iaZJIU4SnRlP+np8iqYjmECkKFtXvpaaE7uk=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=zZKm77c7/kD0EQzlnq2dnQowN5TazHLUBXllDEi2N6K/vrywLa7cu4+MdgmUrGQyH
	 4+sPwZhJNF3Js+3cPWmtWFQmQbbcMvK1T4zIjCJno6xKkUh8JXM1Nq/HjrDl0RIshv
	 tjS2BTwGMLkg6ceh7C1IBvBP+4hvUMJgoQC3X5JU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727988AbgHBAAM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 1 Aug 2020 20:00:12 -0400
Received: from mail.kernel.org ([198.145.29.99]:59628 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727779AbgHBAAF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Aug 2020 20:00:05 -0400
Subject: Re: [GIT PULL] thread fix v5.8-rc8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1596326404;
        bh=xNqGqF+iaZJIU4SnRlP+np8iqYjmECkKFtXvpaaE7uk=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=mvHFhisJnymNh8wBn6TRX2BmoFsJXMYy+w50zeo/HkrVHWbYhlS58p1XDAQqde2VY
         mA7MR/V3wSsfy+IfF4mn8FP65xdrdbAeyrAgtDDlyk1ATkRLB6TNwdevfDL0fLNC7m
         8bMj7AlJte65+WIsybFbkHwgYu0mBRdozA+unJAM=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20200801210552.2150271-1-christian.brauner@ubuntu.com>
References: <20200801210552.2150271-1-christian.brauner@ubuntu.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20200801210552.2150271-1-christian.brauner@ubuntu.com>
X-PR-Tracked-Remote: git@gitolite.kernel.org:pub/scm/linux/kernel/git/brauner/linux
 tags/for-linus-2020-08-01
X-PR-Tracked-Commit-Id: 7665a47f70b3f64bf09c233cc7df73fde9e506f1
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 0ae3495b6502cf93634cbd027cb2f6f9f83a406f
Message-Id: <159632640482.16599.17647484272408965659.pr-tracker-bot@kernel.org>
Date:   Sun, 02 Aug 2020 00:00:04 +0000
To:     Christian Brauner <christian.brauner@ubuntu.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sat,  1 Aug 2020 23:05:52 +0200:

> git@gitolite.kernel.org:pub/scm/linux/kernel/git/brauner/linux tags/for-linus-2020-08-01

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/0ae3495b6502cf93634cbd027cb2f6f9f83a406f

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
