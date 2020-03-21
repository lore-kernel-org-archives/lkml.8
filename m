Return-Path: <SRS0=DSgr=5G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B20FC4332B
	for <linux-kernel@archiver.kernel.org>; Sat, 21 Mar 2020 19:15:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 10D1920663
	for <linux-kernel@archiver.kernel.org>; Sat, 21 Mar 2020 19:15:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1584818123;
	bh=X6cLDmZep6N2MpMLqEt0HiSjaHs6tK386GRraOG1k2g=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=ed0eTy3qSX3rlFzZRT9htcuXdYOGvDhG+WFD1Op+FJNhPtKZBKXZcZ3TMr++cF+P+
	 pg1T6h8j7BrV7fKQauyjG+72ffoouls1tuFQdU0gu1AQqO9IcXRRr8GBDdhsFvJLX9
	 J7lJ4Z16t7nfkxnURviRnqJ+2D7S7P9YBuERHu5Q=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727904AbgCUTPG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 21 Mar 2020 15:15:06 -0400
Received: from mail.kernel.org ([198.145.29.99]:39188 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727428AbgCUTPG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 Mar 2020 15:15:06 -0400
Subject: Re: [GIT PULL] turbostat version 20.03.20
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1584818106;
        bh=X6cLDmZep6N2MpMLqEt0HiSjaHs6tK386GRraOG1k2g=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=J1VOG6L+oOZc7LMnFFFgUk9TRM3KnGwTa19ZM3gOYA9EEumb8RFqVTrKzoZHToECV
         aYq1TUU5GMvyEg+14mtkj5rHhOzqVpuTUoLQJupnEKNoxyNstBW/+1d6huiNqhJitA
         7ZbmUebyqnQglq1cg0P7RatCMa3Pk1znGigQFt0Q=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <CAJvTdKmNJkx+aeHDcrqRG=0JDfaut5tj4w0oOojGWTjx9tY3qQ@mail.gmail.com>
References: <CAJvTdKmNJkx+aeHDcrqRG=0JDfaut5tj4w0oOojGWTjx9tY3qQ@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAJvTdKmNJkx+aeHDcrqRG=0JDfaut5tj4w0oOojGWTjx9tY3qQ@mail.gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/lenb/linux.git turbostat
X-PR-Tracked-Commit-Id: b95fffb9b4afa8b9aa4a389ec7a0c578811eaf42
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 6c1bae744d5a15108c412336d95f3c4e5db6aff4
Message-Id: <158481810606.2095.279138460899577791.pr-tracker-bot@kernel.org>
Date:   Sat, 21 Mar 2020 19:15:06 +0000
To:     Len Brown <lenb@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux PM list <linux-pm@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sat, 21 Mar 2020 12:41:59 -0400:

> git://git.kernel.org/pub/scm/linux/kernel/git/lenb/linux.git turbostat

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/6c1bae744d5a15108c412336d95f3c4e5db6aff4

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
