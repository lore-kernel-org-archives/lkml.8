Return-Path: <SRS0=pusq=BO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EAF70C433DF
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Aug 2020 22:25:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D40DB22B42
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Aug 2020 22:25:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1596579912;
	bh=PqIbOlafAYpOsjGPoxDnNq4wVnz3rzBk0pVEmOUMA6M=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=sV705/vPI1ZHqWpxi8gcIv2qQ2bEq4vec/9hvKHyOq70Rld5Y+DVeZD8/vEqNSh54
	 0TkUzp2xhqEUnZu5Jvo7cVA7GByDF6cazi9yknB32DS02dCE28PcfDcd4WZ0gXTDWu
	 d3sGoQ6Zp+mwwr0K8C6mOBOdKuBcEkwUwApA8vTk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727078AbgHDWZL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Aug 2020 18:25:11 -0400
Received: from mail.kernel.org ([198.145.29.99]:43788 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726877AbgHDWZK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Aug 2020 18:25:10 -0400
Subject: Re: [GIT PULL] close_range for v5.9
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1596579910;
        bh=PqIbOlafAYpOsjGPoxDnNq4wVnz3rzBk0pVEmOUMA6M=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=ti1ptFmvEvq/c1gtcpGVZERiAo3oTuEySiTcR5pLFDd/+Dvp4o39WOeNC0TXQmCfp
         jNj+p5yMlSTZGwPPd3dvufmV6s/NU9vctMhuVNv9dmbHhMr67nPh4KdN9OQROVULPd
         KfhZ5HBhphoolxUb3RUJqbatkSzHcYkRPT8110PQ=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20200804113358.72985-1-christian.brauner@ubuntu.com>
References: <20200804113358.72985-1-christian.brauner@ubuntu.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20200804113358.72985-1-christian.brauner@ubuntu.com>
X-PR-Tracked-Remote: git@gitolite.kernel.org:pub/scm/linux/kernel/git/brauner/linux
 tags/close-range-v5.9
X-PR-Tracked-Commit-Id: a5161eeef97cb0cdc4de966005926db2f5894af4
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 4f30a60aa78410496e5ffe632a371c00f0d83a8d
Message-Id: <159657990989.8406.19203034228653427.pr-tracker-bot@kernel.org>
Date:   Tue, 04 Aug 2020 22:25:09 +0000
To:     Christian Brauner <christian.brauner@ubuntu.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Tue,  4 Aug 2020 13:33:58 +0200:

> git@gitolite.kernel.org:pub/scm/linux/kernel/git/brauner/linux tags/close-range-v5.9

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/4f30a60aa78410496e5ffe632a371c00f0d83a8d

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
