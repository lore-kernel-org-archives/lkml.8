Return-Path: <SRS0=6raZ=AQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1E54C433DF
	for <linux-kernel@archiver.kernel.org>; Sun,  5 Jul 2020 19:55:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D258420739
	for <linux-kernel@archiver.kernel.org>; Sun,  5 Jul 2020 19:55:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1593978910;
	bh=8IydK9lCMlUV/6qP9ikyPOb3VarHvjH4ldXeZA+vD1s=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=b6BClKOmVbHPy6OpeheKmf7bieBGYsB+IOsp9ejcahDcdE/lE7PEZEMUupRPZVUw8
	 vT/4y7eoV8U7RDjwnwEWulVpgYd55k4xPnB/HdMTxXjT4s9mI8tHnyH9D9+0rY3cMq
	 U5dlvclKNW6aJtWi3e7mFDJ5sbRyPcpY25p0+q7g=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728201AbgGETzK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 5 Jul 2020 15:55:10 -0400
Received: from mail.kernel.org ([198.145.29.99]:44014 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727891AbgGETzH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Jul 2020 15:55:07 -0400
Subject: Re: [GIT pull] core/urgent for v5.8-rc4
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1593978907;
        bh=8IydK9lCMlUV/6qP9ikyPOb3VarHvjH4ldXeZA+vD1s=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=ceezt0ERNIYiKw2tEqvNJWCDbcaslazRg5GmI1MUSbRxJ0aHxm0eaTQU0KM/Mf3Zq
         A46zlL3R67xEjgFlSYorsVl28qVGFgwvobosY+8LFyzR9JtoV1Z0Y+/SStFLHO5y2c
         WIFJlJnpGeV1eTvV7W2izFDKF+UgZOj5A6jmkGiE=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <159396401414.28963.18435590961866091585.tglx@nanos.tec.linutronix.de>
References: <159396401414.28963.18435590961866091585.tglx@nanos.tec.linutronix.de>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <159396401414.28963.18435590961866091585.tglx@nanos.tec.linutronix.de>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git
 core-urgent-2020-07-05
X-PR-Tracked-Commit-Id: 5fdeefa053df54961c1e9b69a128ddb5185ce150
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 5465a324af6af2f2debd23a9336650457d6cb0fd
Message-Id: <159397890752.7489.10912679311698408345.pr-tracker-bot@kernel.org>
Date:   Sun, 05 Jul 2020 19:55:07 +0000
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, x86@kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sun, 05 Jul 2020 15:46:54 -0000:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git core-urgent-2020-07-05

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/5465a324af6af2f2debd23a9336650457d6cb0fd

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
