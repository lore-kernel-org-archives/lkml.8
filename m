Return-Path: <SRS0=iqK9=5A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0714C10F29
	for <linux-kernel@archiver.kernel.org>; Sun, 15 Mar 2020 20:25:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 94B0E20637
	for <linux-kernel@archiver.kernel.org>; Sun, 15 Mar 2020 20:25:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1584303918;
	bh=cPsj32PgN5wdLIpLdKhl/zLBJBFV2k4WlCBEemu3Vsc=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=Z9h2wf0gSJgfPTw0oLsHbhXyNaW0WgX9e8s4k9bx6i3o/PGWGkemFq+jXuwcyufY0
	 d5/L/+2+gtvTpmJYkYY9HLaXgXxaVYaDY0Fqwsv+VBheGnIxoYQhfxilVX3ShdD0cX
	 hQJAglzvCWNdLRp06qfmqBBDRY47XG8yg5G6zEeg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729195AbgCOUZK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 15 Mar 2020 16:25:10 -0400
Received: from mail.kernel.org ([198.145.29.99]:45730 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729164AbgCOUZJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 Mar 2020 16:25:09 -0400
Subject: Re: [GIT pull] irq/urgent for 5.6-rc6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1584303909;
        bh=cPsj32PgN5wdLIpLdKhl/zLBJBFV2k4WlCBEemu3Vsc=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=kgJQ2RJpiImRpoxn643/1trBCM08/aGc8867r7TygPJ9pziqVj+1PqS+O+lXu+Qah
         9hgrpQNzlujl/fM8aIftYAiSvn+arrOaz7DSbQkOevIYDLgLDWykZsF0gbhNg/n6fx
         2iqnpYIBaAm9y/VXk3PVR8QyGzL1LM0w1j8B8hzs=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <158428527863.14940.18079500436167505465.tglx@nanos.tec.linutronix.de>
References: <158428527861.14940.12920965330771600615.tglx@nanos.tec.linutronix.de>
 <158428527863.14940.18079500436167505465.tglx@nanos.tec.linutronix.de>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <158428527863.14940.18079500436167505465.tglx@nanos.tec.linutronix.de>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git
 irq-urgent-2020-03-15
X-PR-Tracked-Commit-Id: 92c227554c8e735a494cd4ddca2d5bebcd705b2c
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: a42a7bb6f5362c77f38cdc5e2d05e9fe0c2ade2c
Message-Id: <158430390906.13594.14962260576327872130.pr-tracker-bot@kernel.org>
Date:   Sun, 15 Mar 2020 20:25:09 +0000
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, x86@kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sun, 15 Mar 2020 15:14:38 -0000:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git irq-urgent-2020-03-15

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/a42a7bb6f5362c77f38cdc5e2d05e9fe0c2ade2c

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
