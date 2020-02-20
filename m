Return-Path: <SRS0=NukP=4I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE069C761A1
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Feb 2020 01:30:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B6B422465D
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Feb 2020 01:30:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1582162219;
	bh=EpRXWJGGUUbhRf9VzBEnFF/3XdEE4MhQdUCQ0mtrK0E=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=1IFJO7nbH5MJiU3iCRjNWDjl026u4ZzlQxCNxNMzu8SzLuPUctCZREP7JiljEVOpC
	 Rto1DqDWeTrI78WJlo0IX+DhM1JfLAw616XCDGZrhwbCkU/Xg909dXZoyBUGp7AF2I
	 +hF8Ca1Z9j7haw0IfIiXM4E/ivbBhwdjQ6ErreWM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727578AbgBTBaS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Feb 2020 20:30:18 -0500
Received: from mail.kernel.org ([198.145.29.99]:36780 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726962AbgBTBaS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Feb 2020 20:30:18 -0500
Subject: Re: [GIT PULL] Kselftest update for Linux 5.6-rc3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1582162217;
        bh=EpRXWJGGUUbhRf9VzBEnFF/3XdEE4MhQdUCQ0mtrK0E=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=dN7OJdhiFY5BsWz1ezqX84nhsMxOV3svROfrcS5wNwfHdsGHgk5/d5h3lSfhYIbYH
         d0Nd3qMKSFJmRg/WquMkPRHaJ5hBQUOv+7s55nVbTmjP6LelBuqTHiWCuwQAdru3uD
         66EYbTUXJZlc4XsKcpVPxM+jwjZfNoa620GWDW4I=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <a95f0345-405b-82f4-85cd-c0b80ba700e7@linuxfoundation.org>
References: <a95f0345-405b-82f4-85cd-c0b80ba700e7@linuxfoundation.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <a95f0345-405b-82f4-85cd-c0b80ba700e7@linuxfoundation.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kselftest
 tags/linux-kselftest-5.6-rc3
X-PR-Tracked-Commit-Id: 9a0584f05687947d5a0b87f046bcd2592a55e67c
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: ca7e1fd1026c5af6a533b4b5447e1d2f153e28f2
Message-Id: <158216221756.30253.5687014824412252935.pr-tracker-bot@kernel.org>
Date:   Thu, 20 Feb 2020 01:30:17 +0000
To:     Shuah Khan <skhan@linuxfoundation.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Wed, 19 Feb 2020 15:33:51 -0700:

> git://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kselftest tags/linux-kselftest-5.6-rc3

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/ca7e1fd1026c5af6a533b4b5447e1d2f153e28f2

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
