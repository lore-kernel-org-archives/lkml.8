Return-Path: <SRS0=3sb/=3H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC572C32771
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Jan 2020 21:05:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9EE93246A2
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Jan 2020 21:05:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1579381541;
	bh=I0t0rw5Xxk44pnXlbNBq7Oxw8U763HkZvNptywo5WAw=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=E5J6xuH5SLPhG2GN5ruiOMjKh6SZa8G4dNUKOC6xugPT+oziu1j13UwJn0iq+aRPK
	 Y6BA3s9WZnqKE5AOEjXln8ZzQYLxZLquBezHhfz64du0cUniwruF+R8+1AultKgoP+
	 WGQuKglJeMrPkN+ngC2dsHyMFStB2qKm9l53btio=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729163AbgARVFk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 18 Jan 2020 16:05:40 -0500
Received: from mail.kernel.org ([198.145.29.99]:37406 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726935AbgARVFE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Jan 2020 16:05:04 -0500
Subject: Re: [GIT PULL] thread fixes v5.5-rc7
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1579381503;
        bh=I0t0rw5Xxk44pnXlbNBq7Oxw8U763HkZvNptywo5WAw=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=y7hTKoHHiMHXc/zyjgQ+HYR06Qsq1HNJciBxMQ3R3JL3J+9kWnylqEveWw9BGcROz
         JemAoVo+bCGDDmmqXiya5gplzCbOzSavg9Y48HHal135Tz4nf4Xc60BbVhyo4+gcdL
         AaMRk1qhYN/YdrY8PUTEPPNLHvvJYJ+EhIkAKZB8=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20200118144914.25322-1-christian.brauner@ubuntu.com>
References: <20200118144914.25322-1-christian.brauner@ubuntu.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20200118144914.25322-1-christian.brauner@ubuntu.com>
X-PR-Tracked-Remote: git@gitolite.kernel.org:pub/scm/linux/kernel/git/brauner/linux
 tags/for-linus-2020-01-18
X-PR-Tracked-Commit-Id: 6b3ad6649a4c75504edeba242d3fd36b3096a57f
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 8cac89909a30807eb4aba56a0e29f55e3b6df42f
Message-Id: <157938150347.20598.11869740443885595690.pr-tracker-bot@kernel.org>
Date:   Sat, 18 Jan 2020 21:05:03 +0000
To:     Christian Brauner <christian.brauner@ubuntu.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Jann Horn <jannh@google.com>, Serge Hallyn <serge@hallyn.com>,
        stable@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sat, 18 Jan 2020 15:49:14 +0100:

> git@gitolite.kernel.org:pub/scm/linux/kernel/git/brauner/linux tags/for-linus-2020-01-18

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/8cac89909a30807eb4aba56a0e29f55e3b6df42f

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
