Return-Path: <SRS0=8+oI=7O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2437C433DF
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jun 2020 19:35:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BCA062065C
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jun 2020 19:35:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1591040114;
	bh=7bMaE1BmVXH0C5ALZi4PP2JLkyi4q3XnWCx+197tjbU=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=BH1UkF8r7GEaBNNCrL26s2z+aW2kc6gYiWXXnRjeP71renM/rqYlfo40Hrr9Kp6Bb
	 y6Zgc2rdav6y8Y4ar3PYUxa2sscgwPGBFCPZMZeIDXyZ5zM6ChK7ygIzyj3ekwYIR2
	 x46EFPHDhSM02XYvuhCrjhgEe8WszbAG2ea/0CE0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729646AbgFATfO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Jun 2020 15:35:14 -0400
Received: from mail.kernel.org ([198.145.29.99]:57892 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729597AbgFATfJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Jun 2020 15:35:09 -0400
Subject: Re: [GIT PULL] x86/microcode for 5.8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1591040109;
        bh=7bMaE1BmVXH0C5ALZi4PP2JLkyi4q3XnWCx+197tjbU=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=y1FadWCYXrwK95X4jszcO9NyuZJUKEnVYK0UNhP1MSkjpE9R2B6XvUXqR70AhDxLt
         VdhVN1N+LeTamuJzXOj+kMLetkC3jeeaGY3I8our3X7aSbWcX3/dn2Gax1JSGPYOGc
         zIXL2kxyjuexeFIO3EaLw9CLqIqdrbbbRyur8QH4=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20200601093113.GA30795@zn.tnic>
References: <20200601093113.GA30795@zn.tnic>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20200601093113.GA30795@zn.tnic>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git
 tags/x86_microcode_for_5.8
X-PR-Tracked-Commit-Id: 9adbf3c609af92a57a73000a3cb8f4c2d307dfa3
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: ef34ba6d36af9e6f5918f7f7e287be4b70a358b4
Message-Id: <159104010914.18844.11094578066329972974.pr-tracker-bot@kernel.org>
Date:   Mon, 01 Jun 2020 19:35:09 +0000
To:     Borislav Petkov <bp@suse.de>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        x86-ml <x86@kernel.org>, lkml <linux-kernel@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Mon, 1 Jun 2020 11:31:13 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git tags/x86_microcode_for_5.8

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/ef34ba6d36af9e6f5918f7f7e287be4b70a358b4

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
