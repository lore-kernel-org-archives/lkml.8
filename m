Return-Path: <SRS0=L1Qp=6D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA367C3A5A9
	for <linux-kernel@archiver.kernel.org>; Sun, 19 Apr 2020 19:20:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 966E821927
	for <linux-kernel@archiver.kernel.org>; Sun, 19 Apr 2020 19:20:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1587324037;
	bh=K2/08zbtETRGbtsAoPxsY8vHg10sW8HFY70xdKpzfZ8=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=mzPczzSVFq0ZcMPOMCkOJKGW+LOFBazLfuxwFr15fdeAnyDwuIpsz9N38sL9aYQ5n
	 0Iw2S43ptNE26FN0lsReSf2/XGxMwLrOvhuf+FtF6R/hi3qSc6N3danWrGei2lBBD1
	 Lg82ToEaSR/0/f7fucT/2UGH95ErkYuOwHOPWif8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726724AbgDSTUX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 19 Apr 2020 15:20:23 -0400
Received: from mail.kernel.org ([198.145.29.99]:54170 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725848AbgDSTUW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Apr 2020 15:20:22 -0400
Subject: Re: [GIT pull] timers/urgent for 5.7-rc2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1587324022;
        bh=K2/08zbtETRGbtsAoPxsY8vHg10sW8HFY70xdKpzfZ8=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=eu2DrMfPJUf9JteabLO9sUs73o2VfPefewVnBhDudujQaR7899VOBlz8fBlUy/ZJM
         Lbujl4Av1oSj+OScdk/Wro8wGwY3HICAIbidevIyAuAFG3pbH0/urkjMnnsdPRq99F
         woPR3x7sWVgQcLo2JmmLeFUSQOg3jdUqT1wqKvrM=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <158730460342.31269.11473437311616524528.tglx@nanos.tec.linutronix.de>
References: <158730459860.31269.9496277256253823777.tglx@nanos.tec.linutronix.de>
 <158730460342.31269.11473437311616524528.tglx@nanos.tec.linutronix.de>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <158730460342.31269.11473437311616524528.tglx@nanos.tec.linutronix.de>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git
 timers-urgent-2020-04-19
X-PR-Tracked-Commit-Id: 94d440d618467806009c8edc70b094d64e12ee5a
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 3e0dea57686d8a0cb8b870de0f5ccbd2e941d8b3
Message-Id: <158732402221.20624.6419520414029649239.pr-tracker-bot@kernel.org>
Date:   Sun, 19 Apr 2020 19:20:22 +0000
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, x86@kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sun, 19 Apr 2020 13:56:43 -0000:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git timers-urgent-2020-04-19

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/3e0dea57686d8a0cb8b870de0f5ccbd2e941d8b3

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
