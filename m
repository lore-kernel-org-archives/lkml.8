Return-Path: <SRS0=VV4q=52=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D805C2D0EC
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Apr 2020 17:30:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6622C2082D
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Apr 2020 17:30:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1586539833;
	bh=TsaFm94WpkHZlKPkuswYfk36VrRqoriyPdr5hBgvle0=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=Lr9AzMbfKks3Wmy+LSsIkLPZ4px/+C3PmIiLmhkqvphCEjRWaBTH6NWaoxjsLBkht
	 sJlDwLbh94ZJb2ZHoB4Ppqs6ZzrAzpLx+4nyAxmjnsj+t53TJN7179tKJU0pl5sKKF
	 PHDBUWpp+GU95czFUWom0u8Y6HHsIczqkgjOz/gI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726861AbgDJRab (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Apr 2020 13:30:31 -0400
Received: from mail.kernel.org ([198.145.29.99]:58534 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726816AbgDJRa3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Apr 2020 13:30:29 -0400
Subject: Re: [GIT PULL] s390 patches for the 5.7 merge window #2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1586539829;
        bh=TsaFm94WpkHZlKPkuswYfk36VrRqoriyPdr5hBgvle0=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=ZtxSb5dAYDG1BPuHFn0oGA64Zj3yFnGSCG5am/JMCcZ3RW7zD1Rj31jL6V5AEEllp
         iIPDW6NpeuFlUDp2ogXmI3TH4i9UnITQxBYjs+0ePYcu1drcQ3pjTZ/1fCESDliKq3
         kGKSduqE6/igrjoMh76FaNpFuuqlQOjCu8IrmZmg=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <your-ad-here.call-01586515236-ext-7662@work.hours>
References: <your-ad-here.call-01586515236-ext-7662@work.hours>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <your-ad-here.call-01586515236-ext-7662@work.hours>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/s390/linux
 tags/s390-5.7-2
X-PR-Tracked-Commit-Id: 2bc55eaeb88d30accfc1b6ac2708d4e4b81ca260
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 523a05fc681d139ca98a083fa6685ef22c600326
Message-Id: <158653982944.6431.18240489888820571449.pr-tracker-bot@kernel.org>
Date:   Fri, 10 Apr 2020 17:30:29 +0000
To:     Vasily Gorbik <gor@linux.ibm.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-s390 <linux-s390@vger.kernel.org>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 10 Apr 2020 12:40:36 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/s390/linux tags/s390-5.7-2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/523a05fc681d139ca98a083fa6685ef22c600326

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
