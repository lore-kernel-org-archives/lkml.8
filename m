Return-Path: <SRS0=boYM=7Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E559C433E0
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jun 2020 18:15:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2C5BD20829
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jun 2020 18:15:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1591208111;
	bh=N6lKc2UQsjy0TL1JIKnEJXXC99NIaNRCmFJS6Wjg93k=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=Afs+fIcfYcFkJOBoXJCdONJrYx3iZ73BvTzXuhunFGkUjUa7q+h6kijbNxbH9VfLp
	 75Gbil8AcLLYLo65okWY/nyXt6B7jVg86hCenHHV4dicRi4IiYW4EB6d8oW+VFbIbs
	 /IGUkWYq7JbXTR7e2D3hqfm6iLrsZqEZ7aUTl/fY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726521AbgFCSPJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Jun 2020 14:15:09 -0400
Received: from mail.kernel.org ([198.145.29.99]:38180 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725920AbgFCSPH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Jun 2020 14:15:07 -0400
Subject: Re: [GIT pull] irq/core for v5.8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1591208106;
        bh=N6lKc2UQsjy0TL1JIKnEJXXC99NIaNRCmFJS6Wjg93k=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=2alJMYJgR+m28k2b7NPYpE9b1ceA/ESh0PF21/tCpFU2bPe58u4wU27ZrU/qF7sSJ
         qsxULkL+WtGWXIrFcpZJld32hS9zvMraXSIY9KDOCHaoZK6PnjB0emt/XJ2sqbSBDu
         ZqjcUmGqY303GyQRCJU+CIP7rbHnBA4NHPiVGbMM=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <159109968973.14228.6780339995273133401.tglx@nanos.tec.linutronix.de>
References: <159109968973.14228.6780339995273133401.tglx@nanos.tec.linutronix.de>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <159109968973.14228.6780339995273133401.tglx@nanos.tec.linutronix.de>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git irq-core-2020-06-02
X-PR-Tracked-Commit-Id: d77aeb5d403d379ff458e04fc07b5b86700270f2
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: f6606d0c0010953e4c28c8662623662b5108b4ce
Message-Id: <159120810668.18635.11991503790150406255.pr-tracker-bot@kernel.org>
Date:   Wed, 03 Jun 2020 18:15:06 +0000
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, x86@kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Tue, 02 Jun 2020 12:08:09 -0000:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git irq-core-2020-06-02

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/f6606d0c0010953e4c28c8662623662b5108b4ce

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
