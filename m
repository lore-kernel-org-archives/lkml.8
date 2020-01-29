Return-Path: <SRS0=xNW4=3S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1B59C2D0DB
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Jan 2020 19:10:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9B3A42071E
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Jan 2020 19:10:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1580325008;
	bh=5IGj7XaAlyGABAFyqwwPk8jCEbYUJkHgWFYLKNXdmFc=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=c3C53y+4AiJo0RQerGLuBaf/soJHltbpaDFpG5niOVm3sgrselNy9NRnsGxQlcwfY
	 Q2OhrAXfmIbWx79f3gc1B0OgSYeUdv6FgvOxcZINZr3gUofi8Yav7144nbemsZ+H+a
	 skV0N8uAbi4/3fKUe7SykS6u27vLu7GIi2d7PU7c=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727584AbgA2TKH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Jan 2020 14:10:07 -0500
Received: from mail.kernel.org ([198.145.29.99]:60428 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726332AbgA2TKH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jan 2020 14:10:07 -0500
Subject: Re: [GIT PULL] core kernel fixes
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1580325007;
        bh=5IGj7XaAlyGABAFyqwwPk8jCEbYUJkHgWFYLKNXdmFc=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=deu4O0lI5xvN2Z93vtbWORcTqVzPrEGoZAUBibxsSnIXJ3jv7I0v1r0rJBjqrDbu1
         7hauHAt0kzDl+xJWazUZzIuDXRePmB2U/vsniyQTmwD/b4VmmCikf+saIgvHmqxO/o
         xU/jJFFlDdZ6siSqt2WzI4/OMTUf5j/zd3xGgHvY=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20200129115348.GA128016@gmail.com>
References: <20200129115348.GA128016@gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20200129115348.GA128016@gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git
 core-urgent-for-linus
X-PR-Tracked-Commit-Id: 74777eaf7aef0f80276cb1c3fad5b8292c368859
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 80b60e3849bfe987801a73ebd4bab43b7b591a09
Message-Id: <158032500696.28574.15940097960042411983.pr-tracker-bot@kernel.org>
Date:   Wed, 29 Jan 2020 19:10:06 +0000
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

The pull request you sent on Wed, 29 Jan 2020 12:53:48 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git core-urgent-for-linus

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/80b60e3849bfe987801a73ebd4bab43b7b591a09

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
