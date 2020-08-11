Return-Path: <SRS0=vr6t=BV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BDEF7C433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Aug 2020 01:37:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9D061206DA
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Aug 2020 01:37:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1597109857;
	bh=xEbGhnireVGdt46pTRSkRF7mxZ0rK2wJ73BUXjbqdx0=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=Guxtg1vSreskAfxuAXJCgbAPPJaPP3mSacRJjZnw2+03byaSo3DR7yq+6TINHoc3Z
	 mgNBcldwpjluoGAZCRR9ETJr0r0lZallGhnkhC8MkfmIjodaolrcch5fACm+/HrGAU
	 FH+9ISzWTB6kisqgSgcU71IKG3fRyB95F5RlR7M8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728135AbgHKBhh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Aug 2020 21:37:37 -0400
Received: from mail.kernel.org ([198.145.29.99]:52266 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727848AbgHKBhf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Aug 2020 21:37:35 -0400
Subject: Re: [GIT PULL] f2fs update for 5.9-rc1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1597109855;
        bh=xEbGhnireVGdt46pTRSkRF7mxZ0rK2wJ73BUXjbqdx0=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=PsP0YN0dNM5ftz4br8wbHNKOMAVF/ZJErixi769k8GlmyOY+9T6vbylp/coKbwOgf
         F7XCGV7I6vxU8TekeD4Bo1TB9pxQlrIKBzvCYxY3tu/ZKVXnLGTuidNUlfUzgQxVRm
         7/TpTLhxGnJOGaC+T+xDqSskvN8p20RfsGLedymc=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20200810191121.GA2745602@google.com>
References: <20200810191121.GA2745602@google.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20200810191121.GA2745602@google.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/jaegeuk/f2fs.git tags/f2fs-for-5.9-rc1
X-PR-Tracked-Commit-Id: 828add774f0d2bf930cdeca6c982c1fbcdd846bb
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 086ba2ec163b638abd2a90ef3e8bab0238d02e56
Message-Id: <159710985521.12600.4650817315516671423.pr-tracker-bot@kernel.org>
Date:   Tue, 11 Aug 2020 01:37:35 +0000
To:     Jaegeuk Kim <jaegeuk@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux F2FS Dev Mailing List 
        <linux-f2fs-devel@lists.sourceforge.net>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Mon, 10 Aug 2020 12:11:21 -0700:

> git://git.kernel.org/pub/scm/linux/kernel/git/jaegeuk/f2fs.git tags/f2fs-for-5.9-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/086ba2ec163b638abd2a90ef3e8bab0238d02e56

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
