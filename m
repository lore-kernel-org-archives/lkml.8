Return-Path: <SRS0=Zbf8=4B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77016C352A3
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Feb 2020 22:40:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4DD00217F4
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Feb 2020 22:40:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1581633630;
	bh=kC/SDpY5De9yokxEyUSinIMRIxy5yB5SfLn1zQSH6kM=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=0AUOOVvQ0bVXrzm+AwkDrLn1oEAp3uIfSLHGY7d/Na/B1bGakzmlwY1Ktsr8klAao
	 +HP3onHVuzlZDzztPLYB7wVU9E6LZSMLpUW2sxwkzMiFBHdfm/+/B5FcOje/kxsWTM
	 UmPRLVy2BfMxCyET7K5i+WVharQg7Q5Wk8DU9YDA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727924AbgBMWk0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Feb 2020 17:40:26 -0500
Received: from mail.kernel.org ([198.145.29.99]:37580 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727782AbgBMWkW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Feb 2020 17:40:22 -0500
Subject: Re: [GIT PULL] arm64 fixes for -rc2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1581633622;
        bh=kC/SDpY5De9yokxEyUSinIMRIxy5yB5SfLn1zQSH6kM=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=Jp2MzqMbOzIp70gOQZ9pU/2dtvi5AVTByXTz5mpLmzeKVpwXmvoHLwyR0+DdcJ6tn
         Et6UhgNDooNnE5o3yE2xY3BIHK4Gj7KvBjTGXRCf6pnSkiihdhSuRkXID7Z6VYJbIR
         l3i+p41b8EzONBK2ZCO4+BgeZfdzVehEmAJI/CGU=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20200213171002.GA8807@willie-the-truck>
References: <20200213171002.GA8807@willie-the-truck>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20200213171002.GA8807@willie-the-truck>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git
 tags/arm64-fixes
X-PR-Tracked-Commit-Id: d91771848f0ae2eec250a9345926a1a3558fa943
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: b19e8c68470385dd2c5440876591fddb02c8c402
Message-Id: <158163362239.23424.5154244625306292960.pr-tracker-bot@kernel.org>
Date:   Thu, 13 Feb 2020 22:40:22 +0000
To:     Will Deacon <will@kernel.org>
Cc:     torvalds@linux-foundation.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        catalin.marinas@arm.com, kernel-team@android.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Thu, 13 Feb 2020 17:10:02 +0000:

> git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git tags/arm64-fixes

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/b19e8c68470385dd2c5440876591fddb02c8c402

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
