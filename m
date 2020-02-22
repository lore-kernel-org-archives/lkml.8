Return-Path: <SRS0=8jYG=4K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29411C35669
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Feb 2020 00:15:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 008AC207FD
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Feb 2020 00:15:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1582330515;
	bh=J6Cc2gYzrzZWbZXyYPz+cfI+3s684n4iE2XGXd/G8nQ=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=QfwAoqBsLGaZF0amZgz1JAQaGvOrePx84gEksKNIoKgBGFaNr5PPy65HUjUe/93YV
	 GdfdpkjYsnDU4iRSHSYS0nIANjb1+So6VFkunaVPg8NOZFK7xt+bvklqDIGwcGQcgn
	 X8KM/eWR0Mymz2m4iS0mIJsauvGYFy0lzj2p2A0E=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726877AbgBVAPO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Feb 2020 19:15:14 -0500
Received: from mail.kernel.org ([198.145.29.99]:38158 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726525AbgBVAPN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Feb 2020 19:15:13 -0500
Subject: Re: [GIT PULL] arm64 fixes for -rc3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1582330513;
        bh=J6Cc2gYzrzZWbZXyYPz+cfI+3s684n4iE2XGXd/G8nQ=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=xy3ImlQNzf6cj2X1XyP0B4fbtrR4IDe/zaCFTlMkxXLh6E0kIVdCO0ZuyDWvDpmFE
         4+BfgmUiyVaqDx3pMYly87f+N6+pHOQz00NhzYxD+Ug7TSlDWQjLR6OgkI5TFLR0aA
         Tg/715V1qyakIYhW5an6piohWtmFbG8TplZWbOL8=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20200221160126.GB19330@willie-the-truck>
References: <20200221160126.GB19330@willie-the-truck>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20200221160126.GB19330@willie-the-truck>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git
 tags/arm64-fixes
X-PR-Tracked-Commit-Id: dcde237319e626d1ec3c9d8b7613032f0fd4663a
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 63f01d852c75366fb4d15ce217d12c48b69a4bcc
Message-Id: <158233051320.15315.16901615049793407371.pr-tracker-bot@kernel.org>
Date:   Sat, 22 Feb 2020 00:15:13 +0000
To:     Will Deacon <will@kernel.org>
Cc:     torvalds@linux-foundation.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        catalin.marinas@arm.com, kernel-team@android.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 21 Feb 2020 16:01:26 +0000:

> git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git tags/arm64-fixes

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/63f01d852c75366fb4d15ce217d12c48b69a4bcc

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
