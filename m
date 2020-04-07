Return-Path: <SRS0=z/zp=5X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ACBFBC2BA80
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Apr 2020 19:55:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 76FAC20748
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Apr 2020 19:55:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1586289304;
	bh=r+VImNmnLBQUKy6aPx4G7SRNP8Qk/clSP1tZpxClntI=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=nBfn0AW8EAXMAErnGn+Peh24NhSJvNpJaQM1VWzEAdnBAXzxyMJkmPN9J/Q8J2irP
	 gOvCQX/Z28x1BQgfr97lNHnjuz/7Pnu9YvPfnHQqZiIj+F+sxG9KV9So517flxw38E
	 kKZfgNX4qkFtQbeeJVl9QEttIXwya9Ucjg3Err54=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727817AbgDGTzD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Apr 2020 15:55:03 -0400
Received: from mail.kernel.org ([198.145.29.99]:56354 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726712AbgDGTzD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Apr 2020 15:55:03 -0400
Subject: Re: [GIT PULL] parisc architecture fixes for kernel v5.7
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1586289302;
        bh=r+VImNmnLBQUKy6aPx4G7SRNP8Qk/clSP1tZpxClntI=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=f+VShvUrPZxu1C1Ms2KDU5EdVJqfo1DVQFjuvXIE2D7VSZ9q5S+etPphEm0wfuRAK
         BMcRBUWWUrW7lnZUJLcac5lJlye54Y39VAKA9wZDvX1TO3s/jiNG/xKisWu7tlciFI
         I6BUIPq7nie29FcuY0bc7opuFp6UEakT2v6vZ6sE=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20200406201615.GA23183@ls3530.fritz.box>
References: <20200406201615.GA23183@ls3530.fritz.box>
X-PR-Tracked-List-Id: <linux-parisc.vger.kernel.org>
X-PR-Tracked-Message-Id: <20200406201615.GA23183@ls3530.fritz.box>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/deller/parisc-linux.git
 parisc-5.7-1
X-PR-Tracked-Commit-Id: 106c90922e1e0cd5fcbb34be8ebbb3e8a8e71909
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: f9db97d751870cbffc85f4aa0d8aca8a79432691
Message-Id: <158628930265.3792.541815435181788203.pr-tracker-bot@kernel.org>
Date:   Tue, 07 Apr 2020 19:55:02 +0000
To:     Helge Deller <deller@gmx.de>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-parisc@vger.kernel.org,
        James Bottomley <James.Bottomley@hansenpartnership.com>,
        John David Anglin <dave.anglin@bell.net>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Mon, 6 Apr 2020 22:16:15 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/deller/parisc-linux.git parisc-5.7-1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/f9db97d751870cbffc85f4aa0d8aca8a79432691

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
