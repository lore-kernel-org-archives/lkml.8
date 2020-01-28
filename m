Return-Path: <SRS0=OrIQ=3R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C920EC2D0DB
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jan 2020 19:10:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A32812467E
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jan 2020 19:10:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1580238621;
	bh=4iaZLGa3PIw4sGu+TyRqH9xumveFNxmB/zV3I6LlH6I=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=m/nHsOIWCjIBb7oXk2wwIV5guB55JBZMHmMAHCSVZNtKLV/V987DHINW6Ah5VTcln
	 Es05z98ezWS4RO1xf0/wOzmy3d+B5rQVPX3hZUXsIda7uT2pZkDD1t7zHl726Szq2y
	 JEDVvlzXyVYctKHykdfPT0kyA0hTIhOf2nMMPOpI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727327AbgA1TKU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Jan 2020 14:10:20 -0500
Received: from mail.kernel.org ([198.145.29.99]:45796 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727267AbgA1TKG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jan 2020 14:10:06 -0500
Subject: Re: [GIT PULL] locking changes for v5.6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1580238606;
        bh=4iaZLGa3PIw4sGu+TyRqH9xumveFNxmB/zV3I6LlH6I=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=i2q2/o5LVxI6QqHCova34JY1Lc8XDMs2OJdqZBzmanUR8vd5Fxia0KzLTUoXOwvY7
         OOsJNVEX722Hdi+00rzyxDkIGNtTE6sJ6GphWGph7x2vsn25HhPEOyzPOJDfEpbV89
         OGOjqMj3e2YMjDEabzSzvuX2FcPx7YfMDeAL5u80=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20200128080855.GA105098@gmail.com>
References: <20200128080855.GA105098@gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20200128080855.GA105098@gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git
 locking-core-for-linus
X-PR-Tracked-Commit-Id: f5bfdc8e3947a7ae489cf8ae9cfd6b3fb357b952
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 2180f214f4a5d8e2d8b7138d9a59246ee05753b9
Message-Id: <158023860602.9583.10471710086218741855.pr-tracker-bot@kernel.org>
Date:   Tue, 28 Jan 2020 19:10:06 +0000
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Thomas Gleixner <tglx@linutronix.de>,
        Andrew Morton <akpm@linux-foundation.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Tue, 28 Jan 2020 09:08:55 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git locking-core-for-linus

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/2180f214f4a5d8e2d8b7138d9a59246ee05753b9

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
