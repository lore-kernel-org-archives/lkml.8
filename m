Return-Path: <SRS0=GvTR=3A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96686C33CA3
	for <linux-kernel@archiver.kernel.org>; Sat, 11 Jan 2020 14:45:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 68E6C20848
	for <linux-kernel@archiver.kernel.org>; Sat, 11 Jan 2020 14:45:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1578753917;
	bh=1XBJySitFGv3NCeUviFXxskLZAXGqGoSYgd2XutTIR0=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=pJWflJxTaJu+Gf9mZg8wvkpQCg3QHt6o28UvUzEn8GFbSdDaXkjPPojeu474Ot2iK
	 wz4ZUXTOjAfFLE1+lfv5nx73zSgab1YUjXoPHGpwJcGTyOC8qNWdLn4w1jVHQFb3It
	 AUgwvhN4KW/YahU9M/kXJlhGkHt7fnOHQhWiGSeo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729989AbgAKOpL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 11 Jan 2020 09:45:11 -0500
Received: from mail.kernel.org ([198.145.29.99]:36376 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729824AbgAKOpK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Jan 2020 09:45:10 -0500
Subject: Re: [GIT PULL] HID fix
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1578753910;
        bh=1XBJySitFGv3NCeUviFXxskLZAXGqGoSYgd2XutTIR0=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=btgxChZnDWqzU+q7dCNtfOS8CP4ZN8eUNRTPuzeCkgBCGaH0cLNqpSVPeEuONMYfH
         UP0y4+9Gzvi29KbvDExOufV6ammrs/xixYVYxG47rqCJysJ4y6I7c6orN2V4G2GaO+
         UENEFB6g+x/9KIijQYbMIDGXjUYIp/tCtdpl5JZc=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <nycvar.YFH.7.76.2001102231160.31058@cbobk.fhfr.pm>
References: <nycvar.YFH.7.76.2001102231160.31058@cbobk.fhfr.pm>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <nycvar.YFH.7.76.2001102231160.31058@cbobk.fhfr.pm>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/hid/hid.git for-linus
X-PR-Tracked-Commit-Id: 9e635c2851df6caee651e589fbf937b637973c91
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: ac61145a725ab0411c5f8ed9aeca6202076ecfd8
Message-Id: <157875391003.30634.6168670234232946731.pr-tracker-bot@kernel.org>
Date:   Sat, 11 Jan 2020 14:45:10 +0000
To:     Jiri Kosina <jikos@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 10 Jan 2020 22:32:27 +0100 (CET):

> git://git.kernel.org/pub/scm/linux/kernel/git/hid/hid.git for-linus

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/ac61145a725ab0411c5f8ed9aeca6202076ecfd8

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
