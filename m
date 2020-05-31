Return-Path: <SRS0=AKQz=7N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76601C433E0
	for <linux-kernel@archiver.kernel.org>; Sun, 31 May 2020 18:05:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 54EF6207BB
	for <linux-kernel@archiver.kernel.org>; Sun, 31 May 2020 18:05:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1590948308;
	bh=4R9NAGmF1fPGWwF0gJY5iO+sfPc3+M8/uAxtOhjnl/4=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=yAw4PsIN2/Eg0TtezuZcSegOyLmWeO1mQo8gxl/WQgL/oadBqH5FVYEd7nA2g4PBY
	 jQ0555oIdyf9mb58zcSDLI6Hftprs0XN/xiPOV5DRUQy1EfWH54+Z+/lWMptRcZkAd
	 avK+pzeWD68vpgczC/H2cQfdEoZrcX7rzXYrcT7M=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728356AbgEaSFH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 31 May 2020 14:05:07 -0400
Received: from mail.kernel.org ([198.145.29.99]:41682 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726008AbgEaSFE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 31 May 2020 14:05:04 -0400
Subject: Re: [GIT pull] x86/urgent for
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1590948303;
        bh=4R9NAGmF1fPGWwF0gJY5iO+sfPc3+M8/uAxtOhjnl/4=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=WvVeCDJE0WdT6BFOozPHMI7RXF724E0du4IseoJLTpJXRsry8vDlB/CdT2gIpVn4e
         y7tf1kkL5ImMbwPTc6/FWvZH2Ehbx3DIgPC0xgqG7N1z6kDs0obrCUUMH8ZaVx2r0X
         MYe5moCAcuQC5QDIMNk12truzuJRRncozZGfp0qU=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <159093352213.1582.6158805873763136008.tglx@nanos.tec.linutronix.de>
References: <159093352092.1582.2279719529823662123.tglx@nanos.tec.linutronix.de>
 <159093352213.1582.6158805873763136008.tglx@nanos.tec.linutronix.de>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <159093352213.1582.6158805873763136008.tglx@nanos.tec.linutronix.de>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git
 x86-urgent-2020-05-31
X-PR-Tracked-Commit-Id: aa61b7bb00f7c0738823237a06161d568442b93c
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 8fc984aedcedbbabae91d8496bd0b608c0749a98
Message-Id: <159094830360.9121.16682067837629324659.pr-tracker-bot@kernel.org>
Date:   Sun, 31 May 2020 18:05:03 +0000
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, x86@kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sun, 31 May 2020 13:58:42 -0000:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86-urgent-2020-05-31

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/8fc984aedcedbbabae91d8496bd0b608c0749a98

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
