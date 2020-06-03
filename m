Return-Path: <SRS0=boYM=7Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 127F1C433DF
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jun 2020 18:15:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E5E3E20659
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jun 2020 18:15:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1591208117;
	bh=K6Efs6CV5NlGZYmESihG+Rsb/T6fLjNtBWCq2qqoml0=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=r53tEiN6gLXpfgDQGP+MC6stNra2+ltEWzNyb5dxPcm6i6mrSmA6byYzXD+4UYSbk
	 Pk77AJ5rUO8y+lTB3UbRI67Lczfq+JjvCFiC3krXh/DU6CE9TX9/kMxhh14tcERCgF
	 jtdgwQH89vTJrny6mUWF2jH/aji1BxR6x0sHuYdw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726563AbgFCSPQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Jun 2020 14:15:16 -0400
Received: from mail.kernel.org ([198.145.29.99]:38248 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726155AbgFCSPI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Jun 2020 14:15:08 -0400
Subject: Re: [GIT pull] x86/timers for v5.8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1591208108;
        bh=K6Efs6CV5NlGZYmESihG+Rsb/T6fLjNtBWCq2qqoml0=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=qOYeKUDFwCKiKoz8eZ0KgYoL+3Q4VNJRsHnD945HY1mA/U8TLcB7LCohmE6s0AZK7
         J9s77GhkwUGCHlSCONf4eP/GqleNXzT5qhmyxK6La7548p7W6Hu/dtMAhf75u89lhN
         lYG48eJoRregvMllktsQq3OS56bXJbCbJ+FRwCTs=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <159119692334.13122.14553226198669248718.tglx@nanos.tec.linutronix.de>
References: <159119692334.13122.14553226198669248718.tglx@nanos.tec.linutronix.de>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <159119692334.13122.14553226198669248718.tglx@nanos.tec.linutronix.de>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git
 x86-timers-2020-06-03
X-PR-Tracked-Commit-Id: bd35c77e32e4359580207891c0f7a438ad4b42df
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: f6aee505c71bbb035dde146caf5a6abbf3ccbe47
Message-Id: <159120810826.18635.10822571335417830625.pr-tracker-bot@kernel.org>
Date:   Wed, 03 Jun 2020 18:15:08 +0000
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, x86@kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Wed, 03 Jun 2020 15:08:43 -0000:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86-timers-2020-06-03

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/f6aee505c71bbb035dde146caf5a6abbf3ccbe47

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
