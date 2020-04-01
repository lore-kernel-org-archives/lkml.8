Return-Path: <SRS0=sqB7=5R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68403C2D0F0
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Apr 2020 23:20:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3E9102082F
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Apr 2020 23:20:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1585783223;
	bh=jZ5R8NLDr2ipcH//ysEPZpf1mo710GFdetvptQop3i4=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=KLUiNMHDrLjC0XJApDJLsC0rbeD+0XLnTsk89Zte8vVq7sAsAvCc3ulsPgf4j7vMf
	 n+VTRZdHEA7nyJicnHuOxCM23jiOTPRQIKf1KeiPwy0OFvPPCqqjpzzG3Udib0jKF1
	 6q7Tku1sqsnZKs1/VC9hJ9sdZj03TBfVmHOOCskI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387578AbgDAXUS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Apr 2020 19:20:18 -0400
Received: from mail.kernel.org ([198.145.29.99]:59218 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387443AbgDAXUQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Apr 2020 19:20:16 -0400
Subject: Re: [GIT PULL] Kselftest-kunit update for Linux 5.7-rc1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1585783216;
        bh=jZ5R8NLDr2ipcH//ysEPZpf1mo710GFdetvptQop3i4=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=B5DRgpWE0KWWQSsIVC4W7SUgYTVLXrLLj1VsHBEvUpcFWclRXL6ZYYJA3Wf530iHL
         myfu2PofNFmPBkjgcSVL8cCatfbc6EOgI5aUG8mwEqYlG2XgbXRAMeH0ZMPcxZfPKk
         wuCOq28V/+RzTMIyV5SdV/Ol3QLfZCajoUYjb+fE=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <db495f50-087f-695c-67d8-22683cce0a77@linuxfoundation.org>
References: <db495f50-087f-695c-67d8-22683cce0a77@linuxfoundation.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <db495f50-087f-695c-67d8-22683cce0a77@linuxfoundation.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kselftest
 tags/linux-kselftest-kunit-5.7-rc1
X-PR-Tracked-Commit-Id: e23349af9ee25a5760112a2f8476b94a4ec86f1c
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 668f1e9267415153e30bea03828c0530874e92e4
Message-Id: <158578321625.12544.11451006072732483271.pr-tracker-bot@kernel.org>
Date:   Wed, 01 Apr 2020 23:20:16 +0000
To:     Shuah Khan <skhan@linuxfoundation.org>
Cc:     torvalds@linux-foundation.org,
        Brendan Higgins <brendanhiggins@google.com>,
        Shuah Khan <skhan@linuxfoundation.org>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        KUnit Development <kunit-dev@googlegroups.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Wed, 1 Apr 2020 11:54:36 -0600:

> git://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kselftest tags/linux-kselftest-kunit-5.7-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/668f1e9267415153e30bea03828c0530874e92e4

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
