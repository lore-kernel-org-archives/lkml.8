Return-Path: <SRS0=xbEg=53=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2EF8EC2BA19
	for <linux-kernel@archiver.kernel.org>; Sat, 11 Apr 2020 20:10:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EDAEF20CC7
	for <linux-kernel@archiver.kernel.org>; Sat, 11 Apr 2020 20:10:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1586635845;
	bh=ZkHduaC8Fz/+ntfA7l6Wy9v8DAE4WDmXiHUDRkRq2ag=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=Z8lhopsQP6C44Odj5Es94HtUlZYuUa1fM89FkrUVA/ziwRYP7vg0FZ5EoK1uAqkC8
	 SEX7qgg8O9i1L1PMof5PirhMdvgjYm0u1yarT3O6zS1vvTM2cjdmDjVUK975FQO77r
	 UKBmTp8HWiHx7TwJatZQQU9uOhOBp7yfESCEGG8E=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726869AbgDKUK0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 11 Apr 2020 16:10:26 -0400
Received: from mail.kernel.org ([198.145.29.99]:53420 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726167AbgDKUKZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Apr 2020 16:10:25 -0400
Subject: Re: [GIT PULL] arch/nios2 update for 5.7-rc1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1586635826;
        bh=ZkHduaC8Fz/+ntfA7l6Wy9v8DAE4WDmXiHUDRkRq2ag=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=QeBF1UEt4HB+vQvxUWm67LPB0VDik3xGH1bR+kxWGTrjvDRb89V7qpPXSXy+zAzt1
         LOf+LNrOAEYpWmT4LG9fJBGUCHh6GJquZ6RWzsyP4g3jTCUYdi3yTtaaDx8jzoqBYU
         Z6n8Mng5gG3C2nTqBOSs0Svhsh64Jutz0f0lgobM=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <BY5PR11MB3893C6C552E66D3BCEFADF28CCDF0@BY5PR11MB3893.namprd11.prod.outlook.com>
References: <BY5PR11MB3893C6C552E66D3BCEFADF28CCDF0@BY5PR11MB3893.namprd11.prod.outlook.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <BY5PR11MB3893C6C552E66D3BCEFADF28CCDF0@BY5PR11MB3893.namprd11.prod.outlook.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/lftan/nios2.git
 tags/nios2-v5.7-rc1
X-PR-Tracked-Commit-Id: 0ec8a5054d7fc5e31509fed7893358564ede2477
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: b032227c62939b5481bcd45442b36dfa263f4a7c
Message-Id: <158663582604.1053.16390522873140113334.pr-tracker-bot@kernel.org>
Date:   Sat, 11 Apr 2020 20:10:26 +0000
To:     "Tan, Ley Foon" <ley.foon.tan@intel.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Ley Foon Tan <lftan.linux@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sat, 11 Apr 2020 15:37:01 +0000:

> git://git.kernel.org/pub/scm/linux/kernel/git/lftan/nios2.git tags/nios2-v5.7-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/b032227c62939b5481bcd45442b36dfa263f4a7c

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
