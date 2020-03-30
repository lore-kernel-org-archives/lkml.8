Return-Path: <SRS0=Mt+e=5P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 598FAC43331
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Mar 2020 22:05:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 26049206CC
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Mar 2020 22:05:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1585605912;
	bh=AuL+ISc2eSx42CFZAzL/KFMAP0lU7x4vIjfMwUTY4VM=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=vdUeoSjp5jiGDua1V8gc51XG90u7Zh66fLjdU3XjJUWt2RA3GmXl9bSdJ0mzupJ6Q
	 iCkSVfBZQfFxx87GDitX2WdoshagyOYtR8xRN+6lHOt2yZqQuR7fOfSCxMXy3JaRqJ
	 ulqD1ABaRFBi9mMQV2/zcnTdQZd4k0J8ZHYvMaxs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730949AbgC3WFK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Mar 2020 18:05:10 -0400
Received: from mail.kernel.org ([198.145.29.99]:41404 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730065AbgC3WFK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Mar 2020 18:05:10 -0400
Subject: Re: [GIT PULL] regmap update for v5.7
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1585605910;
        bh=AuL+ISc2eSx42CFZAzL/KFMAP0lU7x4vIjfMwUTY4VM=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=F/9lY+IJsrWcXx0qywyws0EUxyD/3CsDwfLcWpLn/vNvlGMPC7RqB9rStnuOr8FXW
         R1OUaMEbK7uS0KJQkuvPkbZykY3eF1FZOSJhS4/Tde5oc/W7BfgZ1gQwMOfXuiIBnw
         O0d230W+ajk8Hq7UiBTdBGS3/datObjPzoOxzByE=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20200330114919.GG4792@sirena.org.uk>
References: <20200330114919.GG4792@sirena.org.uk>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20200330114919.GG4792@sirena.org.uk>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regmap.git
 tags/regmap-v5.7
X-PR-Tracked-Commit-Id: ad5906bd6e9aa3e156dcac8fc070b153648e8b68
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: e129940938d84d8b71074e40a9cc4f69278eb1e1
Message-Id: <158560590993.3338.12403265191033867331.pr-tracker-bot@kernel.org>
Date:   Mon, 30 Mar 2020 22:05:09 +0000
To:     Mark Brown <broonie@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Mon, 30 Mar 2020 12:49:19 +0100:

> https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regmap.git tags/regmap-v5.7

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/e129940938d84d8b71074e40a9cc4f69278eb1e1

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
