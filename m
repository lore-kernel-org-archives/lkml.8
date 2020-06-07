Return-Path: <SRS0=HPGY=7U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC8F1C433E0
	for <linux-kernel@archiver.kernel.org>; Sun,  7 Jun 2020 23:20:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BAE8A2076A
	for <linux-kernel@archiver.kernel.org>; Sun,  7 Jun 2020 23:20:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1591572004;
	bh=TNNojJuRTYQcB7kszSbgG305WEICZvVReDOnu4sPol4=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=ilECh9DF4jKu5rOdTIaxunJ5nIuU0f6JKge/OLQBNr5coO1ElSzbZewWmGz2ku+8P
	 bSTCfR2B+ZWbfrAysFVtx8u1bLoa/wAWjoLKol51v92QwQdL38pnhN9m3X+08z+w6a
	 AZVmecmprojrdX1+6OosDje4zrBdbjYuHaKCtqBI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727961AbgFGXUE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 7 Jun 2020 19:20:04 -0400
Received: from mail.kernel.org ([198.145.29.99]:60850 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726922AbgFGXUD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 7 Jun 2020 19:20:03 -0400
Subject: Re: [GIT PULL] RTC for 5.8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1591572003;
        bh=TNNojJuRTYQcB7kszSbgG305WEICZvVReDOnu4sPol4=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=j5kMf1/F2O2P/UlWY5l+RdNwekOWAuMdfIAQ9QFt0rS7y1WRqi1RnJ63uxVYLl4To
         vfxV5Wmev+0P6gPb3pdC8Zq/KQVdJaU8I95XzSo0An+w2WBFZLTWCBqrUJpA7j3uBF
         o+U1xWnMa+XRxInwIX9gkLBdlkxEqWSl0u364/mc=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20200607212943.GA1821798@piout.net>
References: <20200607212943.GA1821798@piout.net>
X-PR-Tracked-List-Id: <linux-rtc.vger.kernel.org>
X-PR-Tracked-Message-Id: <20200607212943.GA1821798@piout.net>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/abelloni/linux.git tags/rtc-5.8
X-PR-Tracked-Commit-Id: 4601e24a6fb819d38d1156d0f690cbe6a42c6d76
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: e8dff03aef6a76c5c9184ed1dd3c770d4ce9c885
Message-Id: <159157200305.17419.303594534018500335.pr-tracker-bot@kernel.org>
Date:   Sun, 07 Jun 2020 23:20:03 +0000
To:     Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-rtc@vger.kernel.org, linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sun, 7 Jun 2020 23:29:43 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/abelloni/linux.git tags/rtc-5.8

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/e8dff03aef6a76c5c9184ed1dd3c770d4ce9c885

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
