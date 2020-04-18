Return-Path: <SRS0=3CHW=6C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56539C3A5A0
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Apr 2020 19:30:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 343F52223F
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Apr 2020 19:30:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1587238222;
	bh=9sBG0TBFSt6I5+ZCmPPrYZfYsMw3sbn0EymneScj19s=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=xt8L9Rj15RB6fHfiTn3rKXgS4c/T0k29blhjsT+0sBJhMthHvPGgNSl3AfmpiD3At
	 4r2V1CRJ5MFoC4oydIQTox9CWMMgDZvs9b/cMpo4EPSK0V6EbWrDfAtwF3MXoaawhL
	 iPaCpnYXKJ4wbo73PtKQQ4aGqE/M4KTXANV5yN6Y=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728211AbgDRTaV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 18 Apr 2020 15:30:21 -0400
Received: from mail.kernel.org ([198.145.29.99]:44478 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727907AbgDRTaV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Apr 2020 15:30:21 -0400
Subject: Re: [PULL REQUEST] i2c for v5.7
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1587238220;
        bh=9sBG0TBFSt6I5+ZCmPPrYZfYsMw3sbn0EymneScj19s=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=Ius+WVANyqFs6YnvStffK5RBy0XnuAUpvCX80tMmWFYbt59tp9q3ChsotvvR/4LG3
         rGFbsNWhvo4o1RbCIkMt+6AsRuAQCS2JFnF5+M9nGM9tPkrB3vbeWtH6KUdzV0F+LO
         PeAcbWVUTeLHhsYkqUGOvgmUlVkxgYrmIOqHHEys=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20200418065344.GA1880@kunai>
References: <20200418065344.GA1880@kunai>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20200418065344.GA1880@kunai>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/wsa/linux.git i2c/for-current
X-PR-Tracked-Commit-Id: 8814044fe0fa182abc9ff818d3da562de98bc9a7
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: b484f3c3c6f1d56cd976351d6e1bb1a4944d7447
Message-Id: <158723822068.11589.10465455330200174636.pr-tracker-bot@kernel.org>
Date:   Sat, 18 Apr 2020 19:30:20 +0000
To:     Wolfram Sang <wsa@the-dreams.de>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org,
        Peter Rosin <peda@axentia.se>,
        Bartosz Golaszewski <brgl@bgdev.pl>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sat, 18 Apr 2020 08:53:48 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/wsa/linux.git i2c/for-current

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/b484f3c3c6f1d56cd976351d6e1bb1a4944d7447

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
