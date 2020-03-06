Return-Path: <SRS0=glOU=4X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25710C10F25
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Mar 2020 20:55:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EF0FD206D7
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Mar 2020 20:55:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1583528113;
	bh=onhP/41HYZr5YmD1bk8FLUTpUtKJowNacFDouzGB/Ts=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=Z7LcC+hvQqA1N4yZOUU7FUcxKZqqFFJ1UVodkOoK8kuGxdmK3oliiWUL/QlUlCLsV
	 W/4zpSb/KesEHKw8Snr1gzuxn2AUlxAD0OUrD9XJHFyjAFNjf9blgakhNNehNyxvum
	 eUkYpHU1Dbd0rtiL8uScrCVF09p9DDQeGV232+hQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726973AbgCFUzL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Mar 2020 15:55:11 -0500
Received: from mail.kernel.org ([198.145.29.99]:43472 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726769AbgCFUzI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Mar 2020 15:55:08 -0500
Subject: Re: [GIT PULL] regulator fixes for v5.6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1583528107;
        bh=onhP/41HYZr5YmD1bk8FLUTpUtKJowNacFDouzGB/Ts=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=J+udSbFIHI61V9Wtl3XukEHOR5sEhrnPLGu+40Q8yEZU9hl6XNFayW9gUtkU8YV5o
         qaEf9hJZbZfOuSYRjIo4cSiOZGr+fRn64zi89UcEejEdiqjYy74N2Y3No994zog0iD
         khOyHUDwIvHJQmA0EDMKREWb/AvFAUyv+0G7WSk4=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20200306163906.GD4114@sirena.org.uk>
References: <20200306163906.GD4114@sirena.org.uk>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20200306163906.GD4114@sirena.org.uk>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git
 tags/regulator-fix-v5.6-rc4
X-PR-Tracked-Commit-Id: 02fbabd5f4ed182d2c616e49309f5a3efd9ec671
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 43c63729c96f06f97367edf680d42d634041fd6a
Message-Id: <158352810791.1815.5239989648101354919.pr-tracker-bot@kernel.org>
Date:   Fri, 06 Mar 2020 20:55:07 +0000
To:     Mark Brown <broonie@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, Liam Girdwood <lgirdwood@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 6 Mar 2020 16:39:06 +0000:

> https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git tags/regulator-fix-v5.6-rc4

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/43c63729c96f06f97367edf680d42d634041fd6a

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
