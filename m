Return-Path: <SRS0=MXgo=BP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34644C433E1
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Aug 2020 01:05:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1A63F20792
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Aug 2020 01:05:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1596589511;
	bh=uwX22/UTZ4garRiwRVMyn8Gko1SVHmcHfUHlKvyKjVs=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=OlCal7AoJPyHVYgASuYp22WbVIwslnQsPVM/LtOAP9Qtlk9Q6L+UMguqfM4+z0/eP
	 /lbwy06KcNRXD41om0I4InUVwq8mQSFIv46fLiodmvduvA0vIsGMxprKZPVN5HoaGj
	 doPTTt1GyLFZVrUUNNBHRAxE3DEntfSuEPRzWuOw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727092AbgHEBFK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Aug 2020 21:05:10 -0400
Received: from mail.kernel.org ([198.145.29.99]:60196 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725863AbgHEBFI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Aug 2020 21:05:08 -0400
Subject: Re: [GIT PULL] uuid update for 5.9
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1596589507;
        bh=uwX22/UTZ4garRiwRVMyn8Gko1SVHmcHfUHlKvyKjVs=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=StTuQx+ErNFy7nGMLOOylcWzLg9x2LDDW0knsqqYjQ0oVdX5kbeWSqVBK/5jdkn9j
         trNTgejHKjmyNuS0zTzUVACweg7shaYlW4HpWoCkIDGIIwoXdNjszz+EwWoIjisbs4
         OkUL8Op+PDgu6T80XEKrZnTHCr/sSDstE5+z0cdo=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20200803140432.GA751849@infradead.org>
References: <20200803140432.GA751849@infradead.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20200803140432.GA751849@infradead.org>
X-PR-Tracked-Remote: git://git.infradead.org/users/hch/uuid.git
 tags/uuid-for-5.9
X-PR-Tracked-Commit-Id: 3c8387d234f75887a2d78972ab0f764fe9f756e4
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 9fa867d2acbca6c4cd317ab75c0e94e1703af2b0
Message-Id: <159658950777.28431.5630407975177528690.pr-tracker-bot@kernel.org>
Date:   Wed, 05 Aug 2020 01:05:07 +0000
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Mon, 3 Aug 2020 16:04:32 +0200:

> git://git.infradead.org/users/hch/uuid.git tags/uuid-for-5.9

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/9fa867d2acbca6c4cd317ab75c0e94e1703af2b0

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
