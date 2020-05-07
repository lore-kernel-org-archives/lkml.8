Return-Path: <SRS0=0sZ+=6V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3BF5CC47247
	for <linux-kernel@archiver.kernel.org>; Thu,  7 May 2020 23:00:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 15C2F21655
	for <linux-kernel@archiver.kernel.org>; Thu,  7 May 2020 23:00:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1588892407;
	bh=e1Pue7LzbDO9XPzNxivk6GPgnsB6JCC0JqS1+Y5F2ZY=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=mucZBuFjqT4SzoBslEev+BjlReRad+9eeRe7LGfUovLxh69D/FHj4dq0IAKqKKgJj
	 3vHgtOzLxVuA9jTlVxIlDbSSPk3f5vv+BM9uOJ+NwRFywXUBSBlOpEkk0/ka5qINkF
	 spEbCC+5ChFSA8mKHF65gKBEOuFNPxFpL0Zi+Z6Q=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727798AbgEGXAG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 May 2020 19:00:06 -0400
Received: from mail.kernel.org ([198.145.29.99]:57082 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726897AbgEGXAF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 May 2020 19:00:05 -0400
Subject: Re: [GIT PULL] Kselftest update for Linux 5.7-rc5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588892404;
        bh=e1Pue7LzbDO9XPzNxivk6GPgnsB6JCC0JqS1+Y5F2ZY=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=LEnetE5xKRd8T0aJuAp/jzmjROWEbRIx8fGaMy2J+jJV4zBO+3d5RiD2C+P6WY2ri
         IRBPITpJbGgnQl3CkuDP7tVxUv6m2Qv31yGS6Z++8Lcf53SC6UsYO2mngYJwRPEAA5
         S0qMCSwQR/kCwOc819O2pQYHLirmYtXFtZKcbF9Q=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <357f0c72-ecb3-021e-4f5a-7ddc649688f2@linuxfoundation.org>
References: <357f0c72-ecb3-021e-4f5a-7ddc649688f2@linuxfoundation.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <357f0c72-ecb3-021e-4f5a-7ddc649688f2@linuxfoundation.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kselftest
 tags/linux-kselftest-5.7-rc5
X-PR-Tracked-Commit-Id: 66d69e081b526b6a6031f0d3ca8ddff71e5707a5
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 9ecc4d775f61fb3fd26a1b8cc70a56a98b3b40d3
Message-Id: <158889240492.3631.5791202315097987288.pr-tracker-bot@kernel.org>
Date:   Thu, 07 May 2020 23:00:04 +0000
To:     Shuah Khan <skhan@linuxfoundation.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        skhan@linuxfoundation.org, linux-kselftest@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Thu, 7 May 2020 12:23:39 -0600:

> git://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kselftest tags/linux-kselftest-5.7-rc5

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/9ecc4d775f61fb3fd26a1b8cc70a56a98b3b40d3

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
