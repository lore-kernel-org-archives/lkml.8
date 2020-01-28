Return-Path: <SRS0=OrIQ=3R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C99A5C33CB3
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jan 2020 21:15:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9709B24692
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jan 2020 21:15:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1580246109;
	bh=sxgy58+Y1lGP9u7dSaQCmkRswWNF5lmHnxZRGPN7kbg=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=lLbfPilHY9KFY7Mf9ShmI6S2RbiTgqJGKuuJyPVbTvctzYc3r/AQu5uekokqqz2MP
	 9GsnVAk3A3/pwEEXqw+ZiGDX5qcZRg0lCJMKuxtlKOzrqhMcCV1nzfP4tqsRRTs3uc
	 GTZjAg9eJWl2r7XeTJNJD6lH+46pjMfi6SjVgCU4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726443AbgA1VPH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Jan 2020 16:15:07 -0500
Received: from mail.kernel.org ([198.145.29.99]:43614 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726143AbgA1VPG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jan 2020 16:15:06 -0500
Subject: Re: [GIT PULL] x86/boot changes for v5.6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1580246105;
        bh=sxgy58+Y1lGP9u7dSaQCmkRswWNF5lmHnxZRGPN7kbg=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=w0HzZXCYtQ0Z5/1FsWF7FRiS07833alkDLRywZ1wrrmZ5VBlfp1jZQMxOV0Vi1riY
         m0+NLivtf1okAByTyLM50HWASGSAoC2j0KA+VBJOZwLzrfoLv0Gpde83YvR9JXzKyN
         R6R4ARILbLs0f8lRFtLx/LXSlLPaWrhKhoPM5QvA=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20200128171213.GA11313@gmail.com>
References: <20200128171213.GA11313@gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20200128171213.GA11313@gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86-boot-for-linus
X-PR-Tracked-Commit-Id: dacc9092336be20b01642afe1a51720b31f60369
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 6b90e71a472be131186276a5fd19d319fa2125d9
Message-Id: <158024610592.20407.13456645059358204941.pr-tracker-bot@kernel.org>
Date:   Tue, 28 Jan 2020 21:15:05 +0000
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Andrew Morton <akpm@linux-foundation.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Tue, 28 Jan 2020 18:12:13 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86-boot-for-linus

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/6b90e71a472be131186276a5fd19d319fa2125d9

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
