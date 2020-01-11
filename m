Return-Path: <SRS0=GvTR=3A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C142C282DD
	for <linux-kernel@archiver.kernel.org>; Sat, 11 Jan 2020 14:45:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 141B820842
	for <linux-kernel@archiver.kernel.org>; Sat, 11 Jan 2020 14:45:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1578753940;
	bh=9ScKvS8kQxXGTEoGGcCyHr0nk8zo26T+uw4ZzvyRijE=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=K/H4O7z5y7OOZcR26nJBfTehbx2VzHZ+5nsgx2opieyR2umQ7AK4jntXDPnVOD9pJ
	 TfynIKbYcVtkrk1VzsHUXrqLG6mOn1/pj5pL3nREXEc+PFKdjTa3LO2hwXtNcqHCwb
	 rAhd/B1YCP0WaJ6TVQRUN9jq4y2MVUGyYAqBj694=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730107AbgAKOpi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 11 Jan 2020 09:45:38 -0500
Received: from mail.kernel.org ([198.145.29.99]:36024 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729855AbgAKOpF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Jan 2020 09:45:05 -0500
Subject: Re: [GIT PULL] Power management fixes for v5.5-rc6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1578753905;
        bh=9ScKvS8kQxXGTEoGGcCyHr0nk8zo26T+uw4ZzvyRijE=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=GSk1g4jmGhQXRHYIhORDZIwNLZfc5D03EJ8VTrqsoCjTRKDpXQSOeY+hhRbc1EHiz
         Xy8WimbwZZaACFimp9rhttbO5A3LM1SLuO8yt2J2L1xRcq6j7MaGgEvDKX4t4vfnYI
         IiJFrcIEoPoOZgEnsJO5VKs6TRgIIzjJkox0Eyjs=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <CAJZ5v0g27E7+wsrMXw1KhUQV6PZJhWcSQ5VG_HTZ5JgYejh15w@mail.gmail.com>
References: <CAJZ5v0g27E7+wsrMXw1KhUQV6PZJhWcSQ5VG_HTZ5JgYejh15w@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAJZ5v0g27E7+wsrMXw1KhUQV6PZJhWcSQ5VG_HTZ5JgYejh15w@mail.gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git pm-5.5-rc6
X-PR-Tracked-Commit-Id: 10674d97c4e266e8c50ce794d1c470c26228d52b
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: c23e744b59efcf546b2b16834c68b85248d6bf3b
Message-Id: <157875390529.30634.2723351899925028830.pr-tracker-bot@kernel.org>
Date:   Sat, 11 Jan 2020 14:45:05 +0000
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 10 Jan 2020 11:23:29 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git pm-5.5-rc6

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/c23e744b59efcf546b2b16834c68b85248d6bf3b

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
