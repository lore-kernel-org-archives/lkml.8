Return-Path: <SRS0=MXgo=BP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4F60C433DF
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Aug 2020 01:25:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BA51420842
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Aug 2020 01:25:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1596590711;
	bh=eqKhtugrtqOVJpDeY6YyhwGbDPbz2z8/g5wncRkwwRI=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=x3UyWNSdDsLRiutLnoKvwvGZzEDooeCQ6fmsZMee5c+p2J9C4kR3NGp/GIpdaH0mk
	 mbeOj2xq571tkak/Sc8LAJ0AAzIpk8hNtYBBvgSf6sFtFDZ7MM559rFS7Zuuc6aAz/
	 W+2IjMlKwKJ9giP+rhly3xhAs4q1mMyUqK1cvj6c=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728078AbgHEBZK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Aug 2020 21:25:10 -0400
Received: from mail.kernel.org ([198.145.29.99]:34330 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726664AbgHEBZJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Aug 2020 21:25:09 -0400
Subject: Re: [GIT pull] irq/core for v5.9
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1596590709;
        bh=eqKhtugrtqOVJpDeY6YyhwGbDPbz2z8/g5wncRkwwRI=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=EqM/eLWB4trt/Z1kEyKdQBNp+wXsiGOFuMdlrJpdfJ+vQuv6CA4+If3YzqatmVz53
         V97z7LjJ+3jj3KBJjecXYppz9402MtAsgfb8BMA4ZNhnXClJBNYC5ItAtU+qmGvrYI
         0rCki1mH1rB5b5M69P0vw8j6wTnaGBHbWeoWm0QY=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <159652931460.11821.10453621811208035324.tglx@nanos.tec.linutronix.de>
References: <159652931338.11821.6870342948950391828.tglx@nanos.tec.linutronix.de>
 <159652931460.11821.10453621811208035324.tglx@nanos.tec.linutronix.de>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <159652931460.11821.10453621811208035324.tglx@nanos.tec.linutronix.de>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git irq-core-2020-08-04
X-PR-Tracked-Commit-Id: 3d5128c1deb5d27993fb11ba5e517798f8021046
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: f8b036a7fc231fe6e8297daddee5dffdbbf2581f
Message-Id: <159659070929.20322.15656482454738646896.pr-tracker-bot@kernel.org>
Date:   Wed, 05 Aug 2020 01:25:09 +0000
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, x86@kernel.org,
        Marc Zyngier <maz@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Tue, 04 Aug 2020 08:21:54 -0000:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git irq-core-2020-08-04

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/f8b036a7fc231fe6e8297daddee5dffdbbf2581f

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
