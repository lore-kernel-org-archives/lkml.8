Return-Path: <SRS0=6raZ=AQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 568A2C433E0
	for <linux-kernel@archiver.kernel.org>; Sun,  5 Jul 2020 19:55:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3263720674
	for <linux-kernel@archiver.kernel.org>; Sun,  5 Jul 2020 19:55:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1593978917;
	bh=aiBWfMzkl37lCkWbe7TZ1Aqsn5YpyZyaHsCKVcjpFo8=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=OPCzqyC9l/mq4pa4Hivvm91EFSkW+uz3+74IEN45nPKAVEbZxzs+6oX1bt1aVauza
	 fG389XYok4ChPzJw4L23Pzmadm+ytBwxdMvZIIdWdeH92+Ho+pxDCS+0N94r4lhuAr
	 B/gbRfZCkxr7YSVkDdtKJysy09GDB9jBus6Hwoms=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728245AbgGETzP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 5 Jul 2020 15:55:15 -0400
Received: from mail.kernel.org ([198.145.29.99]:44074 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728133AbgGETzJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Jul 2020 15:55:09 -0400
Subject: Re: [GIT pull] x86/urgent for v5.8-rc4
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1593978908;
        bh=aiBWfMzkl37lCkWbe7TZ1Aqsn5YpyZyaHsCKVcjpFo8=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=PvoQ92BgWQH4XcuhI15qR8Wm5KzglgXSkRo4NiJJoQGXpuFt0padlF8WyNqEJmY7R
         pyTPEwvUEPG9hn1qC43ZIHR9R2amd/QbGlMataaGezV+5bRCeoyhbBB9Dv09eXC3fG
         KN/82xo8o8AgkyblHUwtN2fsivlXG5iEMTjRX3J0=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <159396401656.28963.9621378879403780463.tglx@nanos.tec.linutronix.de>
References: <159396401414.28963.18435590961866091585.tglx@nanos.tec.linutronix.de>
 <159396401656.28963.9621378879403780463.tglx@nanos.tec.linutronix.de>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <159396401656.28963.9621378879403780463.tglx@nanos.tec.linutronix.de>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git
 x86-urgent-2020-07-05
X-PR-Tracked-Commit-Id: cc801833a171163edb6385425349ba8903bd1b20
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 72674d480076067d627e708c0a062dd900438bd7
Message-Id: <159397890864.7489.753240432174147350.pr-tracker-bot@kernel.org>
Date:   Sun, 05 Jul 2020 19:55:08 +0000
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, x86@kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sun, 05 Jul 2020 15:46:56 -0000:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86-urgent-2020-07-05

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/72674d480076067d627e708c0a062dd900438bd7

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
