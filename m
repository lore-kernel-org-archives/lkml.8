Return-Path: <SRS0=MXgo=BP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48013C433E0
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Aug 2020 19:23:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0C6102075D
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Aug 2020 19:23:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1596655404;
	bh=6FllN6phriNHqB/X+N9JSLf4qqJXCNgt3r42QZGk7uQ=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=Tb3Ie0HHN4r04bfF0ryOoVkZNf2NaznKJemvEoOO1JKvCF3O9a9PCqod5Xkp4n5h3
	 XfERSsePPVbLn0C5aAz7b6X1gpK4UwCFnPyidloDo1R9Ri4cjbu4S1WBA3KgUJ5EvG
	 AjbFAIvZnqLR5/ZVBH2FlydQnnWxq99/ni/YfVv8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728964AbgHETXW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Aug 2020 15:23:22 -0400
Received: from mail.kernel.org ([198.145.29.99]:40068 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728732AbgHERdN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Aug 2020 13:33:13 -0400
Subject: Re: [GIT PULL] Kunit update for Linux 5.9-rc1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1596648793;
        bh=6FllN6phriNHqB/X+N9JSLf4qqJXCNgt3r42QZGk7uQ=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=Ojeo4NeUaf9uVgwzGXi8EwuR6CtZA0G4T1JZMFWdQpfhptIbfRfahXsmkZn0ByQln
         +LIAsk3RvVjXjj9hUnGiefUbAdTyMJs5mTqStlG/hfbc57YmWgVEDLOCz4CNSTKyPH
         Jny0qE5pDTFvCH1AzdNsvZFy+wxkwxBmmhz92t5A=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <8d43e88e-1356-cd63-9152-209b81b16746@linuxfoundation.org>
References: <8d43e88e-1356-cd63-9152-209b81b16746@linuxfoundation.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <8d43e88e-1356-cd63-9152-209b81b16746@linuxfoundation.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kselftest tags/linux-kselftest-kunit-5.9-rc1
X-PR-Tracked-Commit-Id: d43c7fb05765152d4d4a39a8ef957c4ea14d8847
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 53e5504bdbdb16548e39a4834c97742693964197
Message-Id: <159664879356.18421.5932211195517412489.pr-tracker-bot@kernel.org>
Date:   Wed, 05 Aug 2020 17:33:13 +0000
To:     Shuah Khan <skhan@linuxfoundation.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        skhan@linuxfoundation.org,
        Brendan Higgins <brendanhiggins@google.com>,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Tue, 4 Aug 2020 14:59:29 -0600:

> git://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kselftest tags/linux-kselftest-kunit-5.9-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/53e5504bdbdb16548e39a4834c97742693964197

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
