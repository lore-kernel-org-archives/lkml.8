Return-Path: <SRS0=4orP=BD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C4C3C4345B
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jul 2020 21:40:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EAE34206EB
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jul 2020 21:40:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1595626811;
	bh=JmfHpQhyhVXbM1pDawwwzHMLpDltIK1mSU66a0PHWvQ=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=o9FXUNNMJ/wYSjmRN+z/kAPzvD4bJiK2oMaOsnuEjM8RdLzGi/yR2KB3Aozp5ZLTu
	 M/ByFb9Gtn4DG/NVpul1gstDvUwCPNK27SQtcOka6Dz4pw+Kc/joU68wcnmZfHhGeO
	 sEGvQnIW6aYrJfKO5PoBLKecdTICW3S268ziY9rY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727774AbgGXVkJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Jul 2020 17:40:09 -0400
Received: from mail.kernel.org ([198.145.29.99]:48892 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726981AbgGXVkG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jul 2020 17:40:06 -0400
Subject: Re: [GIT PULL] arm64 fix for -rc7
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1595626805;
        bh=JmfHpQhyhVXbM1pDawwwzHMLpDltIK1mSU66a0PHWvQ=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=wzpVlglHe7R9CaI4CMHKLHzAuoZhRG2epZcPHK0kT4e7bHiHcvPokjdocOHJglFjq
         HTQAP0dQLrO64xjo8oLT/j5/qKa2/hFJgT9psT7xWrBZbH4xZlpBUPxlCRNtQWyFUY
         Y9qDZvHrHnGrYgLej1BBRFMOC1uh0VgOUp9qzktg=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20200724115236.GB17451@willie-the-truck>
References: <20200724115236.GB17451@willie-the-truck>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20200724115236.GB17451@willie-the-truck>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git
 tags/arm64-fixes
X-PR-Tracked-Commit-Id: 7b7891c7bdfd61fc9ed6747a0a05efe2394dddc6
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: c6d686047456bd3e36dce7de95375890fb8b7dd9
Message-Id: <159562680572.3064.1898794314546321622.pr-tracker-bot@kernel.org>
Date:   Fri, 24 Jul 2020 21:40:05 +0000
To:     Will Deacon <will@kernel.org>
Cc:     torvalds@linux-foundation.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        catalin.marinas@arm.com, kernel-team@android.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 24 Jul 2020 12:52:36 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git tags/arm64-fixes

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/c6d686047456bd3e36dce7de95375890fb8b7dd9

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
