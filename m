Return-Path: <SRS0=y5Sx=A3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1643BC433E5
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jul 2020 19:05:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E3E912076A
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jul 2020 19:05:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1594926310;
	bh=Ui8MvdHcSMIVI9Y+GYo/n8FZ3RdCwTYMUWA1bu+K1cc=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=Y71aud5XVTjBkeOKETv/in3GYsQp2ofNcpxTW7zHA5aZvo/UILviQx1h4oa511ODK
	 p48o8hkSolsKx8RohyiCVdVG8Ee/kluDyJgL12eS1P67LFWIGtAR9p+i+keHTIUuR+
	 4lMk+uzjHJhKW40/beHxCApObOCF/DVhTRN0qOHo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729615AbgGPTFJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Jul 2020 15:05:09 -0400
Received: from mail.kernel.org ([198.145.29.99]:60124 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728163AbgGPTFE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jul 2020 15:05:04 -0400
Subject: Re: [GIT PULL] Staging/IIO driver fixes for 5.8-rc6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1594926304;
        bh=Ui8MvdHcSMIVI9Y+GYo/n8FZ3RdCwTYMUWA1bu+K1cc=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=2fEvhZ//b2ZLtdSJMhca7GoaeVk+LS3ZAzqyB6E0s2QRUakm50W6x3R+1cbgPkTGy
         FATCBSL8Z9IufKyQIqzwojAsPNumPZj91upwCi3mCfc/cG1BABbzTGfxkVX3/ZPSxt
         eoCpWg4Iv+rlgiYFB67L7ouKzYuMGAdnYW5mKQmQ=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20200716152939.GA2378914@kroah.com>
References: <20200716152939.GA2378914@kroah.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20200716152939.GA2378914@kroah.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/staging.git
 tags/staging-5.8-rc6
X-PR-Tracked-Commit-Id: ef75e14a6c935eec82abac07ab68e388514e39bc
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 6a058f0be518bbb10aadd3c5d18516f91b1a4a04
Message-Id: <159492630464.21154.1782207197856638176.pr-tracker-bot@kernel.org>
Date:   Thu, 16 Jul 2020 19:05:04 +0000
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        devel@linuxdriverproject.org, linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Thu, 16 Jul 2020 17:29:39 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/staging.git tags/staging-5.8-rc6

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/6a058f0be518bbb10aadd3c5d18516f91b1a4a04

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
