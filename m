Return-Path: <SRS0=za8s=32=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB510C2D0B1
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Feb 2020 08:20:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8C621214AF
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Feb 2020 08:20:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1580977218;
	bh=+a8SlHhRX279q2JAwWIk7frfnbVohQ6cL/UcWS0GeC4=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=qMAVMULKHYP8jsp+8Y4FH0HFNhw2lAPe7PhVP9/BH3YukCAf31OMlgLDMdjT2TlYb
	 g4Amb9arBAj0fMVhcO4hGXM0dbRUHwvFO2UjLhvJK3uc8/G6W93BjoHOyw8/bTz25s
	 xp6BUkyHOCknT5x1dUHm3+t1cGbvoZyIoz6WQTvo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727975AbgBFIUR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Feb 2020 03:20:17 -0500
Received: from mail.kernel.org ([198.145.29.99]:39700 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726673AbgBFIUR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Feb 2020 03:20:17 -0500
Subject: Re: [GIT PULL] Smack patch for v5.6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1580977216;
        bh=+a8SlHhRX279q2JAwWIk7frfnbVohQ6cL/UcWS0GeC4=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=e7UofIQxwpu0b5wkUFYZsK6p77PWWqdkpgJNwAm01NW+IMfmr0NL3ppwrGDPZwU8g
         VNcnIr3AzVwZibobzN7vwKklh9v0NFsL9rme6Fk8OxhkpIYzWSemXqOy3sagJ1Wj2P
         LTyLpr+HR8mkQz5vbPlKFlpAKhnhp6Htwd5OKshU=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <7300e604-6fb5-16b1-4e1b-dfae7b494853@schaufler-ca.com>
References: <7300e604-6fb5-16b1-4e1b-dfae7b494853.ref@schaufler-ca.com>
 <7300e604-6fb5-16b1-4e1b-dfae7b494853@schaufler-ca.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <7300e604-6fb5-16b1-4e1b-dfae7b494853@schaufler-ca.com>
X-PR-Tracked-Remote: https://github.com/cschaufler/smack-next
 tags/Smack-for-5.6
X-PR-Tracked-Commit-Id: 87fbfffcc89b92a4281b0aa53bd06af714087889
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 85e5529625f0e41beefe8939eb08baf33131f7d6
Message-Id: <158097721690.4470.13197189246194891263.pr-tracker-bot@kernel.org>
Date:   Thu, 06 Feb 2020 08:20:16 +0000
To:     Casey Schaufler <casey@schaufler-ca.com>
Cc:     Linux Security Module list 
        <linux-security-module@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Casey Schaufler <casey@schaufler-ca.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Wed, 5 Feb 2020 18:07:09 -0800:

> https://github.com/cschaufler/smack-next tags/Smack-for-5.6

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/85e5529625f0e41beefe8939eb08baf33131f7d6

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
