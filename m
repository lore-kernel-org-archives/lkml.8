Return-Path: <SRS0=7zi/=BF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4468DC433E1
	for <linux-kernel@archiver.kernel.org>; Sun, 26 Jul 2020 20:15:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1FE9920715
	for <linux-kernel@archiver.kernel.org>; Sun, 26 Jul 2020 20:15:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1595794504;
	bh=ZmtYLLixjHaFkDHn4/u1RpI2k7yLqaz7EoMJtIM8nRY=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=lcq6l67V4lYwXZK0epEdvvV/YvJua2KXVjTID0ZLppcbQgMXGfPx1m8z7QNda4/Yk
	 eZ8mW55zNyYryZhXmfLVs45va8JKy1EDIMdAPocFGgspPszAFfceygG/ho6YvW4Uaa
	 cL4dOaum/a6CRptdXUa5w9KQwTchYi9VQnUNMP3k=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727852AbgGZUPC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 26 Jul 2020 16:15:02 -0400
Received: from mail.kernel.org ([198.145.29.99]:40640 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726467AbgGZUPC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Jul 2020 16:15:02 -0400
Subject: Re: [GIT PULL] parisc architecture fixes for kernel v5.8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1595794502;
        bh=ZmtYLLixjHaFkDHn4/u1RpI2k7yLqaz7EoMJtIM8nRY=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=hYHpSq+oFWWT4AgYKqMaH2zQo7KyYqsTgBq3y/O0n64aSnxt/miMUbMQdPw3jRDKD
         XaQYlp2IPojggBePxHTAHKWhHBOKQoEpUJE+5RlrcWuBX3uXY6pr5jJIyD04pG1XyG
         Y/xQ/vZceYQ4aZ+J9tU+gjogH6Y4F6gO5jPzz8Dk=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20200726191404.GA10491@ls3530.fritz.box>
References: <20200726191404.GA10491@ls3530.fritz.box>
X-PR-Tracked-List-Id: <linux-parisc.vger.kernel.org>
X-PR-Tracked-Message-Id: <20200726191404.GA10491@ls3530.fritz.box>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/deller/parisc-linux.git
 parisc-5.8-2
X-PR-Tracked-Commit-Id: be6577af0cef934ccb036445314072e8cb9217b9
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 40c60ac32174f0c0c090cd31d0d1712f2478e689
Message-Id: <159579450195.23540.8523708864715554170.pr-tracker-bot@kernel.org>
Date:   Sun, 26 Jul 2020 20:15:01 +0000
To:     Helge Deller <deller@gmx.de>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-parisc@vger.kernel.org,
        James Bottomley <James.Bottomley@hansenpartnership.com>,
        John David Anglin <dave.anglin@bell.net>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sun, 26 Jul 2020 21:14:04 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/deller/parisc-linux.git parisc-5.8-2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/40c60ac32174f0c0c090cd31d0d1712f2478e689

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
