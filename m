Return-Path: <SRS0=4zup=3T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0B09C33C9E
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Jan 2020 04:15:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AB50A2083E
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Jan 2020 04:15:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1580357710;
	bh=xH3qxCG13EE5qcOiTBotnx83yBpzmoKFL0gbHyPTglM=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=w8AeBXBXB6u/Sn9vAOHeR1Bol0OmN3Y7X088BHF3gHNkTtcYSaiol90GPHH14r2Q7
	 ySILfiB/E4LIi5ttqfNRAK7GUGVmC64K5FeouHeYtEnCNJLMA6xkkrz3KVJ5s58xIU
	 A+JlsBWoohyf+XBA9EgPfRzythBgoZdYXezgLd6Y=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727464AbgA3EPK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Jan 2020 23:15:10 -0500
Received: from mail.kernel.org ([198.145.29.99]:45686 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727442AbgA3EPJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jan 2020 23:15:09 -0500
Subject: Re: [GIT PULL] thread changes for v5.6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1580357709;
        bh=xH3qxCG13EE5qcOiTBotnx83yBpzmoKFL0gbHyPTglM=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=tOeyqM8k+n8rBw35v9J7DN6y3CCnYdJtaxWo8urAusfGLMXeRpLY3hB6cSNNo2RLV
         8rVAY4fo2C429dbg9td/LIw8r5rQHdtv/BQEKYe4ggZiHrS8CasFiEzyQRAOJkHU+c
         0Q2zZh3EGtfz28ltdpP1aaZvEbHC+lI7O2YqkX5w=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20200129172641.941614-1-christian.brauner@ubuntu.com>
References: <20200129172641.941614-1-christian.brauner@ubuntu.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20200129172641.941614-1-christian.brauner@ubuntu.com>
X-PR-Tracked-Remote: git@gitolite.kernel.org:pub/scm/linux/kernel/git/brauner/linux
 tags/thread_updates_v5.6
X-PR-Tracked-Commit-Id: 8d19f1c8e1937baf74e1962aae9f90fa3aeab463
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 83fa805bcbfc53ae82eedd65132794ae324798e5
Message-Id: <158035770894.9636.3597820720184972181.pr-tracker-bot@kernel.org>
Date:   Thu, 30 Jan 2020 04:15:08 +0000
To:     Christian Brauner <christian.brauner@ubuntu.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Wed, 29 Jan 2020 18:26:44 +0100:

> git@gitolite.kernel.org:pub/scm/linux/kernel/git/brauner/linux tags/thread_updates_v5.6

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/83fa805bcbfc53ae82eedd65132794ae324798e5

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
