Return-Path: <SRS0=QAx1=7P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38483C433DF
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jun 2020 20:35:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0C0A320663
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jun 2020 20:35:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1591130112;
	bh=AzQpm6zvLsdSvltGnPNMf4vOTFlF5jt62UE7unJ36jM=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=wRoQjck5FABrm55QtNwOA8L09W8yHzuNVg/uyEVWDz658ll+KtnE3xVbBtrIHmQMM
	 ba3yePq10I6OnCQYI+8oCcyjTRMTwsZBm/AiRbLm7EBOlATJf3ioXb8aIeF4pJfG/s
	 8cbbKtDcsVZ+tY6qUViIB21exzT/TCBwzluorLho=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728501AbgFBUfL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Jun 2020 16:35:11 -0400
Received: from mail.kernel.org ([198.145.29.99]:46344 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728458AbgFBUfI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Jun 2020 16:35:08 -0400
Subject: Re: [GIT PULL] PNP update for v5.8-rc1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1591130107;
        bh=AzQpm6zvLsdSvltGnPNMf4vOTFlF5jt62UE7unJ36jM=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=UL1FxptCYkY+7dSu2xK0XA750w81KXlSY+yFF0uSAgsy3ARiRBtzsM70mi6zWgJxX
         0cHeAxxc94bD6IWKP+vImTD4RFBVcZgjFKGhEp2yWE7QovmRnGQXYZzwYciheBZVfJ
         IYxPQ/FI54BBhLibIVjdJYBgyowYGqAQd1700nHI=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <CAJZ5v0iimLWRbrwFy51oC-ZGhuVax5zfcXy2O+O-vchjyY3i-Q@mail.gmail.com>
References: <CAJZ5v0iimLWRbrwFy51oC-ZGhuVax5zfcXy2O+O-vchjyY3i-Q@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAJZ5v0iimLWRbrwFy51oC-ZGhuVax5zfcXy2O+O-vchjyY3i-Q@mail.gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git pnp-5.8-rc1
X-PR-Tracked-Commit-Id: 9361797c7696874a1136442b5ee69c62b0e54738
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 194098915ac74daddca9d6ed46fd11be57f45e16
Message-Id: <159113010774.19446.17530901992496651459.pr-tracker-bot@kernel.org>
Date:   Tue, 02 Jun 2020 20:35:07 +0000
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Mon, 1 Jun 2020 17:51:26 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git pnp-5.8-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/194098915ac74daddca9d6ed46fd11be57f45e16

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
