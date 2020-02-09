Return-Path: <SRS0=6uoK=35=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0473C352A4
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Feb 2020 20:40:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B7D3D20838
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Feb 2020 20:40:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1581280826;
	bh=H7Uxk7iEAhpZLcTPwH7od+oyubtS4S3vJL2HGIdav5M=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=M8tUvRNMeKlFxAKVm99DnVxEYCwzF3of2t/b8/6yE3S349ufiv5emDrtY39V6So8Q
	 rHDbE3D8fwWefAe6FqglS+FPhw99l+W9RtLM8IE8AceFLEuMCYeWfpGS0mBYavxWX0
	 IMHxrU09V6LqYK6eMYSfBSbOCn0jh22Cd343AKME=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727930AbgBIUk0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 9 Feb 2020 15:40:26 -0500
Received: from mail.kernel.org ([198.145.29.99]:43392 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727427AbgBIUkZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Feb 2020 15:40:25 -0500
Subject: Re: [GIT pull] perf fixes for 5.6-rc1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1581280825;
        bh=H7Uxk7iEAhpZLcTPwH7od+oyubtS4S3vJL2HGIdav5M=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=mFNTC8LprqtyECz3Hf9k/IUjEHg0X1GOZFBaepYwbZh2DE2BTQH0qXZh1E65bUTDx
         6DUwhbfAL9MCFjio7HWRWnlDoEzN7I8W2RkIO7zD6HGFfQ4xz4JBv9GwJ/N+SaNi9i
         6LF/JdyE+HdgGDHpO9H6IapNe4dqkarfX0d42IZw=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <158125695732.26104.3631526665331853849.tglx@nanos.tec.linutronix.de>
References: <158125695731.26104.949647922067525745.tglx@nanos.tec.linutronix.de>
 <158125695732.26104.3631526665331853849.tglx@nanos.tec.linutronix.de>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <158125695732.26104.3631526665331853849.tglx@nanos.tec.linutronix.de>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git
 perf-urgent-2020-02-09
X-PR-Tracked-Commit-Id: 45f035748b2aa29840fec6ba01cd8e44c63034c2
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: ca21b9b37059ee07176028de415cc4699db259cb
Message-Id: <158128082500.31187.10552220999784436599.pr-tracker-bot@kernel.org>
Date:   Sun, 09 Feb 2020 20:40:25 +0000
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, x86@kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sun, 09 Feb 2020 14:02:37 -0000:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git perf-urgent-2020-02-09

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/ca21b9b37059ee07176028de415cc4699db259cb

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
