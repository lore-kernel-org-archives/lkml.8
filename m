Return-Path: <SRS0=2Lxt=AV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4D1CC433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jul 2020 16:55:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 963DA2078B
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jul 2020 16:55:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1594400130;
	bh=VE7DY6YnrtjXTYheMZhIwnGSPBgXpRG/vER4tHZgbJ4=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=q7ujwZIqMPSskjH4LSVA8pkBebGCdE9a5tl81Hm7+OSdNQjMTU/iVVo3Grog+38IP
	 Wf99hk4XZWhtUnc0RdszSWG3aUL2al6qb5kpWTHDxU6Ghrc21CaWjIbTopqoWE7l0c
	 Y2kAM06GpykPUilO39XKkgD358T4ZycyJN2H3Nto=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728752AbgGJQzS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Jul 2020 12:55:18 -0400
Received: from mail.kernel.org ([198.145.29.99]:33860 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728356AbgGJQzG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jul 2020 12:55:06 -0400
Subject: Re: [GIT PULL] arm64 fixes for -rc5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1594400105;
        bh=VE7DY6YnrtjXTYheMZhIwnGSPBgXpRG/vER4tHZgbJ4=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=Y1PeCyEoqP3YagjQ5TV+t8RkfSgE3f4TUqkpRZxscohs/nxZfreKb44JcktWqEarl
         NfThMFAmGMwuoJMml1dYNSspjhWhnMljFEbwyWVioreZoPYJad3N6SW4sAtF0sxn9V
         pH6BDs5cVG5mFTUK2/6TyP8gd5EonHhGY3K8n1gQ=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20200710143908.GB31036@willie-the-truck>
References: <20200710143908.GB31036@willie-the-truck>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20200710143908.GB31036@willie-the-truck>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git
 tags/arm64-fixes
X-PR-Tracked-Commit-Id: 5679b28142193a62f6af93249c0477be9f0c669b
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: f4c8824cbcc64524905f83388eb1139747829756
Message-Id: <159440010578.18761.6072031596629593926.pr-tracker-bot@kernel.org>
Date:   Fri, 10 Jul 2020 16:55:05 +0000
To:     Will Deacon <will@kernel.org>
Cc:     torvalds@linux-foundation.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        catalin.marinas@arm.com, kernel-team@android.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 10 Jul 2020 15:39:08 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git tags/arm64-fixes

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/f4c8824cbcc64524905f83388eb1139747829756

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
