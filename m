Return-Path: <SRS0=3W8M=6B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7D69C38A2B
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Apr 2020 19:15:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9A2912076D
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Apr 2020 19:15:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1587150926;
	bh=59QsyVQ+uH21tLg/8z12tr1wiCiqmq20dLhe9KhICgs=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=pUBdPjpisx6vDKQ+RHmjiRPxUUsletvLPXXT+ZECtqtrNdnemrOQxPMbLjTLdOlbo
	 10t9nCeaHvT4kX3NifhrrYvD4HVMhZ9PzCXtJdpuIpOjclKHAnrqcRJSewR1oQkW8R
	 UvdDo4iBzcLs0MX7+qI2ZzdR2t4kfgVbkBjpwH2w=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730504AbgDQTPZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Apr 2020 15:15:25 -0400
Received: from mail.kernel.org ([198.145.29.99]:38762 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729817AbgDQTPX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Apr 2020 15:15:23 -0400
Subject: Re: [GIT PULL] Please pull proc fixes for v5.7-rc2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1587150923;
        bh=59QsyVQ+uH21tLg/8z12tr1wiCiqmq20dLhe9KhICgs=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=uY6ToPLdls/QzmoR/6ifqiKyPPsEY9axtnMxGXdJ38GjV7CdtBheaN9c+GlUrttOw
         NZhhpJ/R5dPRSk6tfWoN3BEQGuCiduYTGnHxaAekQUGT6jdQctRej+e1HAp18X1HhZ
         4nm1IHDMv/uidXRYodg3wNiSoAHhRuPN9S+EUVG0=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <87y2quc7ug.fsf@x220.int.ebiederm.org>
References: <87y2quc7ug.fsf@x220.int.ebiederm.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <87y2quc7ug.fsf@x220.int.ebiederm.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/ebiederm/user-namespace.git
 for-linus
X-PR-Tracked-Commit-Id: 4fa3b1c417377c352208ee9f487e17cfcee32348
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 5d286d5ebcf6cb93b340f2439fe16a90b544c6e5
Message-Id: <158715092303.7925.4541101563964901618.pr-tracker-bot@kernel.org>
Date:   Fri, 17 Apr 2020 19:15:23 +0000
To:     "Eric W. Biederman" <ebiederm@xmission.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Alexey Gladkov <gladkov.alexey@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 17 Apr 2020 12:58:31 -0500:

> git://git.kernel.org/pub/scm/linux/kernel/git/ebiederm/user-namespace.git for-linus

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/5d286d5ebcf6cb93b340f2439fe16a90b544c6e5

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
