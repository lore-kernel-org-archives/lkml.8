Return-Path: <SRS0=4r1w=5T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 507D9C43331
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Apr 2020 00:40:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 26862215A4
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Apr 2020 00:40:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1585874419;
	bh=6Fq0RBm47SeNRN3pI4nuUmLYd+7mBF4nPYB411dFPz0=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=0or66mVr0pOluqXuhDEn8A4VcoWCe9skQgmgRFAmmXJChzOUWO/3CfUXeOxjibYH3
	 SDMbM0gFunUpX4w8EVD1y6d1AC0WmEp5CR0cSV+kKg6xG6xhFKL52hU1dvBybaelu/
	 xpb/wBchFkolugdZLdNSxEAUr4eQo41ET8XCjF8A=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390423AbgDCAkQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Apr 2020 20:40:16 -0400
Received: from mail.kernel.org ([198.145.29.99]:38840 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390413AbgDCAkP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Apr 2020 20:40:15 -0400
Subject: Re: [GIT PULL] hwspinlock updates for v5.7
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1585874415;
        bh=6Fq0RBm47SeNRN3pI4nuUmLYd+7mBF4nPYB411dFPz0=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=vM10yjNyR9njHFkAy533WNUOolWjt4F3fBiK+AgXk6FfnaI13yWdy+rx7JO+iC26a
         L6eHDSS07ZIF0QNOaxehuehKW9UZ+eE5qP97rFUTWMteZrh7w5MiBgU5nE3kpGWvay
         SND4JZ493ubkPZiss7H4v7OEcJQHEXwAHp0DuJQE=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20200402010837.GB751391@yoga>
References: <20200402010837.GB751391@yoga>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20200402010837.GB751391@yoga>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/andersson/remoteproc.git
 tags/hwlock-v5.7
X-PR-Tracked-Commit-Id: ef17f5193edd42e8913c93d0b601c101c56a15bb
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 11786191e2d946410cf5fde482b10cdd5356e76c
Message-Id: <158587441546.31624.17775444987242154271.pr-tracker-bot@kernel.org>
Date:   Fri, 03 Apr 2020 00:40:15 +0000
To:     Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Ohad Ben-Cohen <ohad@wizery.com>,
        linux-remoteproc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Baolin Wang <baolin.wang7@gmail.com>,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Wed, 1 Apr 2020 18:08:37 -0700:

> https://git.kernel.org/pub/scm/linux/kernel/git/andersson/remoteproc.git tags/hwlock-v5.7

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/11786191e2d946410cf5fde482b10cdd5356e76c

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
