Return-Path: <SRS0=S/iQ=BK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E79A8C433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Jul 2020 16:45:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C264C21744
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Jul 2020 16:45:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1596213907;
	bh=g7/Sjx5H860yFgbgdoFjE2JvPJU6ToDa0EZli3c9IDo=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=0oMsi6xWQaE/UG9ucu7wB97+o/vzcIyTnEzrI5Cv8fbo723aUV9/TXN1Fa7LYUGMa
	 sNNnePRQNsg+fV9YGSMQv1IMa0i9Q5cAJqU+jmeojh3/40w67ieF1wljoyyz67NCcR
	 IZz1ujUuTUKmCPflO/X/27kX+TxQZ6j1x1G9F0/o=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732368AbgGaQpG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 Jul 2020 12:45:06 -0400
Received: from mail.kernel.org ([198.145.29.99]:38258 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728898AbgGaQpF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Jul 2020 12:45:05 -0400
Subject: Re: [GIT PULL] sound fixes for 5.8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1596213905;
        bh=g7/Sjx5H860yFgbgdoFjE2JvPJU6ToDa0EZli3c9IDo=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=gfqn4p++PcnPgY3mYRd4FHtaXLqPzQycnrnFG+4lOLSy8Hn+K5RmJ4rBa03m+D0Dk
         25z7wZ154xRbFgULeVm4tGT1Zu55icuf9vFO1OGbE81xx2DRxq9JfK430GVC+rg2O8
         RbaFpr8d8aNBqg6UqdnRwM453x5mWrBS5etrb0wU=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <s5h7dukayxh.wl-tiwai@suse.de>
References: <s5h7dukayxh.wl-tiwai@suse.de>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <s5h7dukayxh.wl-tiwai@suse.de>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tiwai/sound.git tags/sound-5.8
X-PR-Tracked-Commit-Id: 5649625344fe1f4695eace7c37d011e317bf66d5
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 78431ab723aa6f10258979acf88d9aaac2462cbe
Message-Id: <159621390556.29129.14513357898685834515.pr-tracker-bot@kernel.org>
Date:   Fri, 31 Jul 2020 16:45:05 +0000
To:     Takashi Iwai <tiwai@suse.de>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 31 Jul 2020 10:09:14 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/tiwai/sound.git tags/sound-5.8

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/78431ab723aa6f10258979acf88d9aaac2462cbe

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
