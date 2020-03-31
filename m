Return-Path: <SRS0=6o4L=5Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9AF36C43331
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Mar 2020 16:30:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6CE0120784
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Mar 2020 16:30:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1585672216;
	bh=PZDhRdp2Qozc2Bp0r0cVTV94ZTDIf2Rdh8BgCG+nkWo=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=leMlqxEUEpumOCrsxS5Z5345JyaSww9TwBUX/12ydWV1ItPfd9tsFKBVQ9D65SP9Q
	 xrLe9BBYepjKpbaIAifLBNNHyzJjgFJgPm2d2aiaZlwJ413qA2gulG5XAUeiFrLUaN
	 JUXpnAl3WEAZ+uCBvpVtldqAP1bhYC5xJRsyHjjI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731277AbgCaQaP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 31 Mar 2020 12:30:15 -0400
Received: from mail.kernel.org ([198.145.29.99]:39766 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731054AbgCaQaM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Mar 2020 12:30:12 -0400
Subject: Re: [GIT PULL] ia64 for v5.7
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1585672211;
        bh=PZDhRdp2Qozc2Bp0r0cVTV94ZTDIf2Rdh8BgCG+nkWo=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=Zc9rB9ZJ8hYeQY/d+Fhl1IOdSwD3sqbriDdevjWyl/ounbuJ8QhWCJNazhhRrWj8G
         HrOokA8jTfTE7LXbkKSaRJ/ooHp3CdIIwFLNytajkeMV+RFV3b/iWRHU5MuWIwqoSn
         ybKLg83TNy9DzA/CfajzD3XdKe/CF3YgjAwDUZvA=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20200330183912.GA27085@agluck-desk2.amr.corp.intel.com>
References: <20200330183912.GA27085@agluck-desk2.amr.corp.intel.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20200330183912.GA27085@agluck-desk2.amr.corp.intel.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/aegl/linux.git
 please-pull-ia64_for_5.7
X-PR-Tracked-Commit-Id: 172e7890406d6183b9b39271ffb434ff0a97ce72
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: cad18da0afb1bc7b37d73a74067ab7ff5974897c
Message-Id: <158567221176.1514.14157609099591251337.pr-tracker-bot@kernel.org>
Date:   Tue, 31 Mar 2020 16:30:11 +0000
To:     "Luck, Tony" <tony.luck@intel.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-ia64@vger.kernel.org, linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Mon, 30 Mar 2020 11:39:12 -0700:

> git://git.kernel.org/pub/scm/linux/kernel/git/aegl/linux.git please-pull-ia64_for_5.7

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/cad18da0afb1bc7b37d73a74067ab7ff5974897c

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
