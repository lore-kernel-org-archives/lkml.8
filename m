Return-Path: <SRS0=vr6t=BV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C25FC433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Aug 2020 21:23:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DE176206C3
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Aug 2020 21:23:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1597181010;
	bh=mr6YJD1V4dkwy/Iwhe/jxgg4pJipy7PDAUDoeF1s8c8=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=sufrS89ZETPzYOSVTHErxwL2inw5wer2OP3Y9C1BvIJVTaQvcAJnAJ+sVHXTNtEg3
	 oyKs8g2M8mjyhPyuJ0zV5oPW5M9l6yrO4XgZZUwFR1UZRY4K0HhOeTn7hrgzZQsa7g
	 oimT0uohUBscOXXExaIf9P2eje0SO2eglxLjWsjo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726573AbgHKVX3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Aug 2020 17:23:29 -0400
Received: from mail.kernel.org ([198.145.29.99]:50416 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725987AbgHKVX0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Aug 2020 17:23:26 -0400
Subject: Re: [git pull] IOMMU Updates for Linux v5.9
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1597181006;
        bh=mr6YJD1V4dkwy/Iwhe/jxgg4pJipy7PDAUDoeF1s8c8=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=fwTW2X2J+0qYpKurzFhAD2TPfZWDUy0AJTjxF1gT59wBB3aSP7wnR4dmYBxriOQdw
         xTtVPq9bzmNy6TCqdEB0cEOEMjHTUhAAlVBAluzQcykGACKfrlipurZjAFi6beSd0T
         2cpbZJQG8UkwmVNa6kLgNc0Kvpl9avhn3/pJFkYM=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20200811124747.GA13876@8bytes.org>
References: <20200811124747.GA13876@8bytes.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20200811124747.GA13876@8bytes.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/joro/iommu.git tags/iommu-updates-v5.9
X-PR-Tracked-Commit-Id: e46b3c0d011eab9933c183d5b47569db8e377281
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 952ace797c17d06e50ad2a738babd27159b8d7cc
Message-Id: <159718100611.533.7037020432422807245.pr-tracker-bot@kernel.org>
Date:   Tue, 11 Aug 2020 21:23:26 +0000
To:     Joerg Roedel <joro@8bytes.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Tue, 11 Aug 2020 14:47:53 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/joro/iommu.git tags/iommu-updates-v5.9

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/952ace797c17d06e50ad2a738babd27159b8d7cc

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
