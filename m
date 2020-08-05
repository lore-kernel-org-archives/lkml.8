Return-Path: <SRS0=MXgo=BP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1677C433DF
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Aug 2020 05:05:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D726B22CE3
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Aug 2020 05:05:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1596603914;
	bh=YpGVPuqweLLv9chmtdVU+MkwMsjM9PhN13sm8iwyKD8=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=FrzCQ58HVhPRPAUapFd84zEoeZIoD3v1dMb1exRKPclfj4vllx7AObz7DMI1AArUG
	 0JCeVt+5VIjcdF9J5UN49mWhnL7OFDsD5gtkxq7vVcfD+IIOXYfc7uYhP/1x5vhuKa
	 XBPtDWSJAufilwYaAwVMc351s7mPcoPg/XJWKNeI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726600AbgHEFFN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Aug 2020 01:05:13 -0400
Received: from mail.kernel.org ([198.145.29.99]:42752 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725930AbgHEFFK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Aug 2020 01:05:10 -0400
Subject: Re: [GIT pull] x86/fsgsbase for v5.9
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1596603910;
        bh=YpGVPuqweLLv9chmtdVU+MkwMsjM9PhN13sm8iwyKD8=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=kddA2zQ3PmWqdOyhj5zJGUQgvxXNoid7hM7jKJzRZM6+mdqUquMQDvZbDnFJOLA60
         LNrhqud3jEB8sMotchajWAYKdglRab4oeNxiY7o/8xdXKOsFWQwlm/I+j5Wpx0j09o
         1hsuZdVSuhwnSrT0V2TdWrv1OiP1wn/ku5kltTMU=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <159652931824.11821.3260830552527703172.tglx@nanos.tec.linutronix.de>
References: <159652931338.11821.6870342948950391828.tglx@nanos.tec.linutronix.de>
 <159652931824.11821.3260830552527703172.tglx@nanos.tec.linutronix.de>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <159652931824.11821.3260830552527703172.tglx@nanos.tec.linutronix.de>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git
 x86-fsgsbase-2020-08-04
X-PR-Tracked-Commit-Id: d029bff60aa6c7eab281d52602b6a7a971615324
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 4da9f3302615f4191814f826054846bf843e24fa
Message-Id: <159660391027.15119.11635164865306753437.pr-tracker-bot@kernel.org>
Date:   Wed, 05 Aug 2020 05:05:10 +0000
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, x86@kernel.org,
        Sasha Levin <sashal@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Tue, 04 Aug 2020 08:21:58 -0000:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86-fsgsbase-2020-08-04

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/4da9f3302615f4191814f826054846bf843e24fa

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
