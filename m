Return-Path: <SRS0=wESH=6W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A59DC38A2A
	for <linux-kernel@archiver.kernel.org>; Fri,  8 May 2020 16:15:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E5E4D206B9
	for <linux-kernel@archiver.kernel.org>; Fri,  8 May 2020 16:15:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1588954520;
	bh=INzBQ0xINSFbpI5vhMT4ShbHe9Hgk5/90am2R/Ofgjk=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=fSZLWQAKk0pfcm09Gdga1h+ukkbiBMVAT7N2nTNBYHLR7B6EdHscWNOGMmS8KIFP2
	 yAhz3XiJRdU9zNS7ENmqxdurTP6bWAcdIT5z/qWgm+P0t9HMJVkXGplYcpV+l1izCf
	 +hjUBtZqNmuD82txX6i3bGhr7AQhwMKOWCNTt4Mk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727975AbgEHQPU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 May 2020 12:15:20 -0400
Received: from mail.kernel.org ([198.145.29.99]:39022 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727832AbgEHQPF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 May 2020 12:15:05 -0400
Subject: Re: [GIT PULL] Staging driver fixes for 5.7-rc5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588954505;
        bh=INzBQ0xINSFbpI5vhMT4ShbHe9Hgk5/90am2R/Ofgjk=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=JiXrccatrDtgpiztF8dSgwvfEFjWDgKJtbGgm5LvzqcQ3SbuZFEpXtugyPS0n0A9I
         IXBKYri2CEfUv5t7GOAFGdh9KN+c9d8WvY1sxDVIMhtodiW/FWy14tNhmfIP6tGw0U
         qNFoUOCzHooNh9fHY10n8UeS3FP5VoccZj2nH2Tw=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20200508141807.GA353767@kroah.com>
References: <20200508141807.GA353767@kroah.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20200508141807.GA353767@kroah.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/staging.git
 tags/staging-5.7-rc5
X-PR-Tracked-Commit-Id: 769acc3656d93aaacada814939743361d284fd87
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: e7a1c733fecd6bf71f87f74b36ab51bb3eafd8b3
Message-Id: <158895450551.20886.7356855581138654992.pr-tracker-bot@kernel.org>
Date:   Fri, 08 May 2020 16:15:05 +0000
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        devel@linuxdriverproject.org, linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 8 May 2020 16:18:07 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/staging.git tags/staging-5.7-rc5

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/e7a1c733fecd6bf71f87f74b36ab51bb3eafd8b3

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
