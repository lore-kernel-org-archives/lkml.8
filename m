Return-Path: <SRS0=t9Lj=3Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4E19C2D0B1
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Feb 2020 13:25:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B5398217BA
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Feb 2020 13:25:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1580822717;
	bh=zWecOsuswcRe5ymy/QZcCUNLiCf/++nueeTEOX88OtM=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=2arU4+CSPFJa+QJXrcHPjtJUarfBmXZK1wdCP5BtSAat43XsGM1e9kEJW9s5PeZrr
	 uZcp9hI0DhkV5Hm0t2W1sPaqJ64mil8HWjHo0BASscqJK+jdZY9hkih6wXmEc6gHWS
	 OSYmWZm0e4CbOJSH88/CmFx903Dd76qUsRZOmKVw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727494AbgBDNZR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Feb 2020 08:25:17 -0500
Received: from mail.kernel.org ([198.145.29.99]:35494 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727481AbgBDNZQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Feb 2020 08:25:16 -0500
Subject: Re: [GIT PULL] arch/microblaze patches for 5.6-rc1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1580822716;
        bh=zWecOsuswcRe5ymy/QZcCUNLiCf/++nueeTEOX88OtM=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=zjeIPcsmShi/UGq4KkVE4tSD0Rax8TjjhyqhoGYa4j1gO5D5+omoXjqNYIIhJ7lx+
         w5wKWPzzuSqRMK6CYyNZjPB582EJ0tbLdQPMv0Cw+cvOMB473jPW5PQfZLrO89/kK+
         lnp5CdxHwZqhbb5psvSIKmhHNd3wb5ZJU1r0poAo=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <92cc6617-e2c3-e3b8-cf20-c8ccf748d37a@monstr.eu>
References: <92cc6617-e2c3-e3b8-cf20-c8ccf748d37a@monstr.eu>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <92cc6617-e2c3-e3b8-cf20-c8ccf748d37a@monstr.eu>
X-PR-Tracked-Remote: git://git.monstr.eu/linux-2.6-microblaze.git
 tags/microblaze-v5.6-rc1
X-PR-Tracked-Commit-Id: 6aa71ef9bcf9d8688c777dfbff340348cb89a5b4
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 153b5c566d30fb984827acb12fd93c3aa6c147d3
Message-Id: <158082271623.19118.12820077347343651549.pr-tracker-bot@kernel.org>
Date:   Tue, 04 Feb 2020 13:25:16 +0000
To:     Michal Simek <monstr@monstr.eu>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Tue, 4 Feb 2020 12:08:25 +0100:

> git://git.monstr.eu/linux-2.6-microblaze.git tags/microblaze-v5.6-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/153b5c566d30fb984827acb12fd93c3aa6c147d3

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
