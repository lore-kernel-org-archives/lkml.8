Return-Path: <SRS0=Cjtw=7V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0CC6CC433DF
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jun 2020 19:15:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D5F0D206A4
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jun 2020 19:15:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1591643724;
	bh=S2dgdKz0qpO5K3PKpxbGMyF2LqS48LdWq9imrKc7RwY=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=ig8AwQHrBFV59DAZlCtdwx9/sPWvHehA5BiiIdXrCO/1BP/z3uh1dLLwXQektUTNV
	 rXTvBdaxfn4x9RoaRuslEzNKoSyo3U497/DEc2sBKSGgY4UwAtNZjR2sj8ohY4SOeI
	 2TvQw+m78bZh4GV5Dm2++i3BGr/cRyTdv19jzR5o=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726592AbgFHTPX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Jun 2020 15:15:23 -0400
Received: from mail.kernel.org ([198.145.29.99]:43842 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726409AbgFHTPX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Jun 2020 15:15:23 -0400
Subject: Re: [GIT PULL] s390 patches for the 5.8 merge window
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1591643722;
        bh=S2dgdKz0qpO5K3PKpxbGMyF2LqS48LdWq9imrKc7RwY=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=C6rCccSUVHRx/QiTwJCp/8mL7wXj7NrwNlXoUP48rluYUlHr4viCd4HBqjKk6aJry
         brnHZKSmkUvXzjOr7L9kjDLiEJY5vt8FsXmDGxFfgp27fpKKc4pSrKKvPUIj8DDF1N
         ZEiQcYX4+i76yogrSBO10aDCsXKiorPc3feNmaDM=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <your-ad-here.call-01591630479-ext-3636@work.hours>
References: <your-ad-here.call-01591630479-ext-3636@work.hours>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <your-ad-here.call-01591630479-ext-3636@work.hours>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/s390/linux.git tags/s390-5.8-1
X-PR-Tracked-Commit-Id: bfa50e1427e4608ce6941d3d0855445fcaa7dbb7
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 23fc02e36e4f657af242e59175c891b27c704935
Message-Id: <159164372283.1639.1958353358477472739.pr-tracker-bot@kernel.org>
Date:   Mon, 08 Jun 2020 19:15:22 +0000
To:     Vasily Gorbik <gor@linux.ibm.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Mon, 8 Jun 2020 17:34:39 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/s390/linux.git tags/s390-5.8-1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/23fc02e36e4f657af242e59175c891b27c704935

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
