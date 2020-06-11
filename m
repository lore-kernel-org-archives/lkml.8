Return-Path: <SRS0=NqQd=7Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA711C433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Jun 2020 22:00:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 95587206D7
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Jun 2020 22:00:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1591912834;
	bh=ZmK8pfb+oDN1hKGoI5u7d/FI9HDq7ElXSgVCF+NMVfM=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=Rl83lQVtnkMEBd1WZOn5mOZQcOZoDu/iWIjf8tGmBjm42tVu7Cb+E1c339wFawvTn
	 /zbtWfihaK7tGodWEgyC69R9iW/6LqC+ymdbRdfba/sCB/+Ud96Px13/TLcP8rMlLR
	 3BIVbZeZyeqzF/ktia0ZILURGZZQTB2J0twz+feY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726353AbgFKWA1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Jun 2020 18:00:27 -0400
Received: from mail.kernel.org ([198.145.29.99]:47930 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726303AbgFKWAY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Jun 2020 18:00:24 -0400
Subject: Re: [GIT PULL] arm64 merge window fixes for -rc1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1591912823;
        bh=ZmK8pfb+oDN1hKGoI5u7d/FI9HDq7ElXSgVCF+NMVfM=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=JMw/jV8GOn8CIGs6/R52uxBIyzB35huBTj1LOOjHIka8V2ihZsNkjDvQlNd437EjP
         4boGksdZIZvlelFRGR0kk1TQo0Z+woTiD5+ySpa5IZXL9NMAJa5kHuVPiwlKx8ENMp
         NPjUjbmxurOFK63W/4au2nrlCONQYdw7pq5HxitA=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20200611173412.GA9575@willie-the-truck>
References: <20200611173412.GA9575@willie-the-truck>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20200611173412.GA9575@willie-the-truck>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git
 tags/arm64-upstream
X-PR-Tracked-Commit-Id: dd4bc60765873445893037ae73a5f75398a8cd19
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 55d728b2b05fb0377a9048af3460c375b54619e2
Message-Id: <159191282361.15411.4266634913208275603.pr-tracker-bot@kernel.org>
Date:   Thu, 11 Jun 2020 22:00:23 +0000
To:     Will Deacon <will@kernel.org>
Cc:     torvalds@linux-foundation.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        catalin.marinas@arm.com, kernel-team@android.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Thu, 11 Jun 2020 18:34:12 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git tags/arm64-upstream

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/55d728b2b05fb0377a9048af3460c375b54619e2

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
