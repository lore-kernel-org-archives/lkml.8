Return-Path: <SRS0=3sb/=3H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE589C32771
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Jan 2020 20:20:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B36E8246B1
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Jan 2020 20:20:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1579378809;
	bh=s7G7i6gkBqXmrWVbT4JB5cysGB9qTx/ee9uL5ehS7co=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=FGKFcxuQhuDPTTP4+/MhnoGSZ/oyKfzb9mnbDkCI8tEeoNEh6hIEFXsBiXRe2tKak
	 Efu6x6hhvs7AguvlJOeSEAIx2DKVKFgajL1UFCFEGAxz5SLqwncWV8WK+Gxg7Wh50Y
	 wth36vTOOest4iXIJpHEIxVvt1jQXvli/B0yUj3c=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728921AbgARUUF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 18 Jan 2020 15:20:05 -0500
Received: from mail.kernel.org ([198.145.29.99]:42294 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727104AbgARUUD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Jan 2020 15:20:03 -0500
Subject: Re: [GIT PULL] Staging and IIO driver fixes for 5.5-rc7
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1579378803;
        bh=s7G7i6gkBqXmrWVbT4JB5cysGB9qTx/ee9uL5ehS7co=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=2U5NlA5s/yPMNwKfM1gz1IpLBvuGfhxBlpaEszAIRmKNebYiN2kHKXgbrQgPfv2Um
         2zsfPkELx3bZQY42fWinUMr8aEbpB2BRX6srF8+SjD0gJR9yZ8ELTHDcQZ8rLF/dUQ
         5pbffEQWQMYcpevqCIGzxP32oE5wqmr3W5RKOymk=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20200118142307.GA80149@kroah.com>
References: <20200118142307.GA80149@kroah.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20200118142307.GA80149@kroah.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/staging.git
 tags/staging-5.5-rc7
X-PR-Tracked-Commit-Id: 9fea3a40f6b07de977a2783270c8c3bc82544d45
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: bf3f401db6cbe010095fe3d1e233a5fde54e8b78
Message-Id: <157937880335.12197.9497146634453796246.pr-tracker-bot@kernel.org>
Date:   Sat, 18 Jan 2020 20:20:03 +0000
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        devel@linuxdriverproject.org, linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sat, 18 Jan 2020 15:23:07 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/staging.git tags/staging-5.5-rc7

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/bf3f401db6cbe010095fe3d1e233a5fde54e8b78

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
