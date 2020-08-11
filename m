Return-Path: <SRS0=vr6t=BV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CFE9CC433E1
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Aug 2020 21:59:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AE13C20782
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Aug 2020 21:59:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1597183165;
	bh=caXpSKJLl/H/kbgKiL0Py3zpO3QdrpqXX99iATBhD3U=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=lXmziMpTklu9rZc9cn1/EqJ6ltA8m7NUhpOSqtAByJUsRESndX+jAFG4KQqRj0MUu
	 2RSylBXXSXWn6YaNxhFVXZUcib+Wz0gBt5dfKPEK9xPTWxS/lw+vwhXVBP5SuZUB2g
	 Xn2kqT4tzacS6YTKI7S2PcOvvf7UO3Z43UcxibwA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726488AbgHKV7Y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Aug 2020 17:59:24 -0400
Received: from mail.kernel.org ([198.145.29.99]:45332 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726453AbgHKV7X (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Aug 2020 17:59:23 -0400
Subject: Re: [GIT PULL] Security subsystem updates for v5.9
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1597183163;
        bh=caXpSKJLl/H/kbgKiL0Py3zpO3QdrpqXX99iATBhD3U=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=Rq/JY7KZ1FI10wfRWG0s4V7M6uy3QF9tH17qwXONca5kNkEzGCWi076x3dOzB0gHI
         Kpcyw5NML/wTbQpKq1bIlixIuWIothFW5fRH2XQKl2gAIPpeT68JgMqPmfuKOT+VtM
         4KBQ8opsqV+k9XlbTHhOkrH7ypwx7vHa0BgLgdA8=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <alpine.LRH.2.21.2008110454190.26986@namei.org>
References: <alpine.LRH.2.21.2008110454190.26986@namei.org>
X-PR-Tracked-List-Id: <linux-security-module.vger.kernel.org>
X-PR-Tracked-Message-Id: <alpine.LRH.2.21.2008110454190.26986@namei.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/jmorris/linux-security.git tags/for-v5.9
X-PR-Tracked-Commit-Id: bb22d80b47d5dd641d09d31946c4be0f610f3f45
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: ce13266d97b198934e86166491bfa4938e96508f
Message-Id: <159718316337.19600.2683594569021966590.pr-tracker-bot@kernel.org>
Date:   Tue, 11 Aug 2020 21:59:23 +0000
To:     James Morris <jmorris@namei.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-security-module@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Tue, 11 Aug 2020 04:55:33 +1000 (AEST):

> git://git.kernel.org/pub/scm/linux/kernel/git/jmorris/linux-security.git tags/for-v5.9

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/ce13266d97b198934e86166491bfa4938e96508f

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
