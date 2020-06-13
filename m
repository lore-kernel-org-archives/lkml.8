Return-Path: <SRS0=WLRa=72=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D078AC433E0
	for <linux-kernel@archiver.kernel.org>; Sat, 13 Jun 2020 20:25:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A34B1207DD
	for <linux-kernel@archiver.kernel.org>; Sat, 13 Jun 2020 20:25:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1592079959;
	bh=BeKjUx8FDHHmJP6uCGCIthRnl0HyKI9nbGe0GQeMLB4=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=l4ibzVI6uYQ2ZnDkbi0kxWBGWArBxXK0OUpYeNOZmBnSUA27wKgCXaEta7AQIQzQE
	 28Ez8oEUHfBT0jz9iGYSFX3DruJTBAAB1HJwlMTHUv2SS3bKW38FHBBaTv/MP2IIvA
	 KyHlSutqOVjcs6nyvwm965515yLo/vwqGFc9/Fkw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726969AbgFMUZx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 13 Jun 2020 16:25:53 -0400
Received: from mail.kernel.org ([198.145.29.99]:38390 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726905AbgFMUZa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 13 Jun 2020 16:25:30 -0400
Subject: Re: [PULL REQUEST] i2c for 5.8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592079930;
        bh=BeKjUx8FDHHmJP6uCGCIthRnl0HyKI9nbGe0GQeMLB4=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=ZJ4eYieVsDLx7PyBtMWK9A5Kp8LgLbUCwGEzckum6m96BvNtwDTVbn0tapGt+efRi
         5XEoeNv1Pl5/5wEubhsQdKqjc19y19AjJ2fsPisP0b9FXiWqvIa1oA0Jbmiwj1m9XO
         am5e7ybBxQrnVftbUV90NaSqQnkcycM6J+Fxyw9Q=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20200613113328.GA5400@kunai>
References: <20200613113328.GA5400@kunai>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20200613113328.GA5400@kunai>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/wsa/linux.git i2c/for-5.8
X-PR-Tracked-Commit-Id: d790eeb3db6aefac39ffa06e598eb31b7352ca4f
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 91fa58840ae22cbf6d7c505ce6564c4c48f29af3
Message-Id: <159207993040.31508.10932145461914178452.pr-tracker-bot@kernel.org>
Date:   Sat, 13 Jun 2020 20:25:30 +0000
To:     Wolfram Sang <wsa@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org,
        Peter Rosin <peda@axentia.se>,
        Bartosz Golaszewski <brgl@bgdev.pl>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sat, 13 Jun 2020 13:33:28 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/wsa/linux.git i2c/for-5.8

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/91fa58840ae22cbf6d7c505ce6564c4c48f29af3

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
