Return-Path: <SRS0=vN1y=BQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF381C433E1
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Aug 2020 17:20:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 14DAE2311A
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Aug 2020 17:20:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1596734456;
	bh=gyXX+HdRZ7SM2gEywmJ6pPnNvhW75iP/TGXRzKrY0jg=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=G2jlBgD/vaaqVFDvvQ24WVDm12cIGfiYwvLG4cSL7sHQ0aGAO+tEq54r8vJsAe8bv
	 amM+T4lqG84SL/7Byr/vUlW/X0KHjECBAjRdHRJ9EYjzNg1yFdp6a7B7uuiNkAeP5p
	 5hTtH3sTpMUgfSblG/MG0VDedWnz4HBjTucJTmhQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730440AbgHFRUR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Aug 2020 13:20:17 -0400
Received: from mail.kernel.org ([198.145.29.99]:44846 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730365AbgHFRUB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Aug 2020 13:20:01 -0400
Subject: Re: [GIT PULL] csky updates for v5.9-rc1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1596734401;
        bh=gyXX+HdRZ7SM2gEywmJ6pPnNvhW75iP/TGXRzKrY0jg=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=zEbhLkmpKoumiOPosX84ptPWaCvmcQydiS+9Pv1uTCKgxKM37XCkvd0Dek9fyh1sc
         07DtSBFOGB8XwtRAP0oYAddyW2CCbIowoj9alksdatjLJ4XJoY9VSwp3rJUh9dKHmF
         eG/voVmWPbxk5N1z6l8S41bE5RrTEm93zm7SHU4E=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <1596672601-8227-1-git-send-email-guoren@kernel.org>
References: <1596672601-8227-1-git-send-email-guoren@kernel.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <1596672601-8227-1-git-send-email-guoren@kernel.org>
X-PR-Tracked-Remote: https://github.com/c-sky/csky-linux.git tags/csky-for-linus-5.9-rc1
X-PR-Tracked-Commit-Id: bdcd93ef9afb42a6051e472fa62c693b1f9edbd8
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 2044513ffe4a9c18e6e2a64f048e05d8b62fa927
Message-Id: <159673440057.17279.11436521736758693246.pr-tracker-bot@kernel.org>
Date:   Thu, 06 Aug 2020 17:20:00 +0000
To:     guoren@kernel.org
Cc:     torvalds@linux-foundation.org, arnd@arndb.de,
        linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-csky@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Thu,  6 Aug 2020 08:10:01 +0800:

> https://github.com/c-sky/csky-linux.git tags/csky-for-linus-5.9-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/2044513ffe4a9c18e6e2a64f048e05d8b62fa927

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
