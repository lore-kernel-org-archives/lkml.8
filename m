Return-Path: <SRS0=boYM=7Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F928C433E0
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jun 2020 21:05:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3CD35207D0
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jun 2020 21:05:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1591218313;
	bh=TTMEjxQVEJ1nVyi7S84VHvsSlUdNNhPD3/vt0AsWsZw=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=dqVjZVpsfEjtbj8WeuhKiIIlz6IL16OByYnVt84v5NFOaC5UJxf6J5bXsudIXAdnc
	 GJ2dYvbzVEQq3fgxCuD0YhHkZn6dUIevMaZ7QDqdyta1Tcc8sDF0TygQEeDUdfpPR/
	 cHB5F0M+c7CJ3Gd2y96GF5swD0GIr1i91tqBZj3U=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726957AbgFCVFM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Jun 2020 17:05:12 -0400
Received: from mail.kernel.org ([198.145.29.99]:33644 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726479AbgFCVFJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Jun 2020 17:05:09 -0400
Subject: Re: [GIT PULL] MIPS changes for v5.8-rc1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1591218308;
        bh=TTMEjxQVEJ1nVyi7S84VHvsSlUdNNhPD3/vt0AsWsZw=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=oZ6Zy63+ndmFKCHGwIResvWAKZqh7KC4+a5GsSEZ8KD/5ARuqDu0xsV9ByaWWyq4J
         hfEGcV15lO7/aQGQHU9T393lMQuP11LHWUNkW5KfT7TPFyHoIzscVh3bBY8RMx8rt5
         Yv1Cx6UvvNlQxCr2Fq5YQXNxTjRY3j8iUKeKCq3Q=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20200602125445.GA12527@alpha.franken.de>
References: <20200602125445.GA12527@alpha.franken.de>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20200602125445.GA12527@alpha.franken.de>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/mips/linux
 tags/mips_5.8
X-PR-Tracked-Commit-Id: 9bd0bd264578fe191bf5d2ff23f9887b91862536
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 8226f11318bd03ae0dbf028f7c433071cf4927f4
Message-Id: <159121830857.19900.9232810382803608178.pr-tracker-bot@kernel.org>
Date:   Wed, 03 Jun 2020 21:05:08 +0000
To:     Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Cc:     torvalds@linux-foundation.org, linux-mips@vger.kernel.org,
        linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Tue, 2 Jun 2020 14:54:45 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/mips/linux tags/mips_5.8

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/8226f11318bd03ae0dbf028f7c433071cf4927f4

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
