Return-Path: <SRS0=OrIQ=3R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3AA0FC32771
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jan 2020 01:35:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0FA5E2467C
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jan 2020 01:35:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1580175325;
	bh=ZSu5mq6Oxdt0LaHPGJ0tpYBxr2ZqcPinCTQaArGsnXQ=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=2cSqWJbI6uFPxGhByWJxe0YSIUm8ymbJpA25TD75BO3b/EJyKPuObarjyWvvq0QV2
	 AuXcpKzdg07A3JLvmBryK6RtTAwXX8vtx2d4Aa1psRXyJGfqegDe0kQfDPNFY/btsS
	 eeqneEEzT/b7AlQs72lELufIvuiWp3rYFL7+Q7jM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729021AbgA1BfY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Jan 2020 20:35:24 -0500
Received: from mail.kernel.org ([198.145.29.99]:54350 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727093AbgA1BfG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jan 2020 20:35:06 -0500
Subject: Re: [GIT pull] core/debugobjects for
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1580175305;
        bh=ZSu5mq6Oxdt0LaHPGJ0tpYBxr2ZqcPinCTQaArGsnXQ=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=LBU7xiG7TX6f4h9PtJFH/kRSE73V3WB3GKOsg2pRzJ3RepbJLTwrGhI0wnhv2Z0Cv
         2GsJLpI4nZPmaxTlSnUrLUB7xM569cKanp8JRHyVRZDUfor+Kex9nwyr/2i6O4RbxO
         hoiSoahzu1Mb2WBI8hROtPcfvRQwTE7G9huHs1w4=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <158016896589.31887.18200732992760262654.tglx@nanos.tec.linutronix.de>
References: <158016896586.31887.7695979159638645055.tglx@nanos.tec.linutronix.de>
 <158016896589.31887.18200732992760262654.tglx@nanos.tec.linutronix.de>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <158016896589.31887.18200732992760262654.tglx@nanos.tec.linutronix.de>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git
 core-debugobjects-2020-01-28
X-PR-Tracked-Commit-Id: 35fd7a637c42bb54ba4608f4d40ae6e55fc88781
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 534b0a8b677443c0aa8c4c71ff7887f08a2b9b41
Message-Id: <158017530576.6677.3993435996530435106.pr-tracker-bot@kernel.org>
Date:   Tue, 28 Jan 2020 01:35:05 +0000
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, x86@kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Mon, 27 Jan 2020 23:49:25 -0000:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git core-debugobjects-2020-01-28

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/534b0a8b677443c0aa8c4c71ff7887f08a2b9b41

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
