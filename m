Return-Path: <SRS0=BhYR=34=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1BADC352A1
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Feb 2020 22:35:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9935921775
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Feb 2020 22:35:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1581201341;
	bh=4c5cqn5fMiAsdej8BEH6JLjj+tw5b+FNypiFZsB+ClM=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=Rv1rWyqhRM6DnJlulIfTqxLoI20wtR/V4fGNacdwKWtBiHuclad6t76iOqUfmmlDP
	 ZAwRJdFATLUdAHsH4yfCiqwXdkd+lvCfN8IWCkJ6/3vs8RN4v/JlJBtpBQXUPjEd/9
	 HxeA1C9Zs2gh+ckke0XcmDjeLQXpUUuxgjAS+Hwo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727649AbgBHWf2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 8 Feb 2020 17:35:28 -0500
Received: from mail.kernel.org ([198.145.29.99]:56772 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727617AbgBHWfZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Feb 2020 17:35:25 -0500
Subject: Re: [GIT PULL 3/5] ARM: SoC-related driver updates
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1581201325;
        bh=4c5cqn5fMiAsdej8BEH6JLjj+tw5b+FNypiFZsB+ClM=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=Ojj4vdxVKn6Bg9Jix+CbPnBVGbdIg/4jSVvERmL73U5+phpb2oxMQvNIP4OMMSRUx
         HfQKv3FZ+/q5kj888/kyPiFBlgCdHdVkSW/4XZvMt3W98Pk6N75zdgSrQ1Brg1DQ77
         NSNIFOQ5qCyBPPyY+GHjuNACkn7w+setUVD/cC2Y=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20200208112018.29819-4-olof@lixom.net>
References: <20200208112018.29819-1-olof@lixom.net>
 <20200208112018.29819-4-olof@lixom.net>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20200208112018.29819-4-olof@lixom.net>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/soc/soc.git tags/armsoc-drivers
X-PR-Tracked-Commit-Id: 88b4750151a2739761bb1af7fedeae1ff5d9aed9
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: eab3540562fb44f830e09492374fcc69a283ce47
Message-Id: <158120132554.28764.8597223469049069680.pr-tracker-bot@kernel.org>
Date:   Sat, 08 Feb 2020 22:35:25 +0000
To:     Olof Johansson <olof@lixom.net>
Cc:     torvalds@linux-foundation.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, arm@kernel.org,
        soc@kernel.org, Olof Johansson <olof@lixom.net>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sat,  8 Feb 2020 03:20:16 -0800:

> git://git.kernel.org/pub/scm/linux/kernel/git/soc/soc.git tags/armsoc-drivers

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/eab3540562fb44f830e09492374fcc69a283ce47

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
