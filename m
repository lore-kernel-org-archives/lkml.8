Return-Path: <SRS0=qKPt=7M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55961C433E0
	for <linux-kernel@archiver.kernel.org>; Sat, 30 May 2020 19:35:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3525A206F1
	for <linux-kernel@archiver.kernel.org>; Sat, 30 May 2020 19:35:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1590867306;
	bh=ng4f9RxzP/Ig0BQgTaS6OyObrPJMyf+7HgLX1sLIp6Y=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=akQE2dNr+xJchCQmvvyJ354V4JlatePNCUvot3+PKp00Kq33s5/Mz4aL52Ge8i/o3
	 jMjMjLpHFijh6hYXf1dQUrDB1EwWQ0bpEJavS5qSNEHHzU9T7iEwVBnuKJCyezfUDD
	 1RgcTG5lQCK+gwoEzb4wulcNELEV5rEw1euXBens=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729311AbgE3TfF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 30 May 2020 15:35:05 -0400
Received: from mail.kernel.org ([198.145.29.99]:37430 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728999AbgE3TfC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 May 2020 15:35:02 -0400
Subject: Re: [GIT PULL] Please pull powerpc/linux.git powerpc-5.7-6 tag
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1590867302;
        bh=ng4f9RxzP/Ig0BQgTaS6OyObrPJMyf+7HgLX1sLIp6Y=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=dJJG5mseTFFXjgCcCtJ8ItTnyMqVDYOBIT/peUoA+St05YHa98ilcIXeQP7s5rjZa
         q/LaDV70AqIUxZREYUfhTXfZMjg8dGOaKusGvSeF0jACnxdSOJqHQvadwBa0vRg3Ml
         n1IGIX36cFeTKMXjrCIinoLhAUNuRYLR+fwzwBIg=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <87lfl9ikmp.fsf@mpe.ellerman.id.au>
References: <87lfl9ikmp.fsf@mpe.ellerman.id.au>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <87lfl9ikmp.fsf@mpe.ellerman.id.au>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/powerpc/linux.git
 tags/powerpc-5.7-6
X-PR-Tracked-Commit-Id: 2f26ed1764b42a8c40d9c48441c73a70d805decf
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: ffeb595d84811dde16a28b33d8a7cf26d51d51b3
Message-Id: <159086730247.6123.12368301949308597060.pr-tracker-bot@kernel.org>
Date:   Sat, 30 May 2020 19:35:02 +0000
To:     Michael Ellerman <mpe@ellerman.id.au>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>, ajd@linux.ibm.com,
        dja@axtens.net, linux-kernel@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sun, 31 May 2020 00:05:02 +1000:

> https://git.kernel.org/pub/scm/linux/kernel/git/powerpc/linux.git tags/powerpc-5.7-6

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/ffeb595d84811dde16a28b33d8a7cf26d51d51b3

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
