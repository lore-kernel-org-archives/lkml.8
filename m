Return-Path: <SRS0=MXgo=BP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5176C433E0
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Aug 2020 19:30:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 75BBA2084D
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Aug 2020 19:30:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1596655848;
	bh=aQIA7DNdGMpI19qMx6zNcyA1BRXXFMhqMFBGmtpiaFc=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=n9+fGlLPKj9PBHYaWuIaKPyLI7ujGj0bSATqx77hMeUYPSqBacoKNSbrDF1ob6I6R
	 RpS2OFrvlpTm/8mUpbOW7yPKly9ZFyJoiUu6SdINJyqSuRq4j6B7e5ll1WYwvp5Hnz
	 PLGR7AV6yWmqjLflcOqZt+eFwmGcHagYM4FEThDU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728537AbgHETar (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Aug 2020 15:30:47 -0400
Received: from mail.kernel.org ([198.145.29.99]:58588 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728570AbgHETa1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Aug 2020 15:30:27 -0400
Subject: Re: [GIT PULL] Driver core patches for 5.9-rc1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1596655823;
        bh=aQIA7DNdGMpI19qMx6zNcyA1BRXXFMhqMFBGmtpiaFc=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=AHxOpwePK2gWadkH6UiNqqxaMDG+kKwziAn8tFpqQ+YFlsNKKu8r6jcNb1Itgkgxs
         HRpxqf+R8Vgqd0u494YXEVguD4cuZQBvnaQQuxdhDslpyE70LgwoC9tfQHTIbsdIOY
         TDqByj7XlVnk7ATLsDSF+iVGqK/b90u2JJ6Ns3Q4=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20200804173740.GA513646@kroah.com>
References: <20200804173740.GA513646@kroah.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20200804173740.GA513646@kroah.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/driver-core.git tags/driver-core-5.9-rc1
X-PR-Tracked-Commit-Id: 76acb5ee76b1ae5870cac9c8125ca09e9106d5b2
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: dd27111e32572fdd3aaae98ba2817df6d202357a
Message-Id: <159665582356.8842.14799424734932709662.pr-tracker-bot@kernel.org>
Date:   Wed, 05 Aug 2020 19:30:23 +0000
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org,
        Stephen Rothwell <sfr@canb.auug.org.au>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Tue, 4 Aug 2020 19:37:40 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/driver-core.git tags/driver-core-5.9-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/dd27111e32572fdd3aaae98ba2817df6d202357a

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
