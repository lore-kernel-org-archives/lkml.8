Return-Path: <SRS0=L1Qp=6D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F8DBC3A5A9
	for <linux-kernel@archiver.kernel.org>; Sun, 19 Apr 2020 19:20:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DEB7521473
	for <linux-kernel@archiver.kernel.org>; Sun, 19 Apr 2020 19:20:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1587324041;
	bh=6frm6mVnlLcARXOPPgoPUFrcD3ZntnurP5UG52j5NO4=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=DLZ8rJmFy+UL6VllqNbCJMHTsrrtdJ1AiKj3qjailuMOSQOsbz8vRUvSQs3gNa1AG
	 Jy0bdPf5EM0huvJnRs3CAmbZvxGwMeBLYR0Jk/iuDM3ALVEkGzAO+HskYHohaO5E1x
	 xZFjuRK0J4YmZ44IfjR09fJMuIZ2Vxxs/dEwqEsA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726776AbgDSTUk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 19 Apr 2020 15:20:40 -0400
Received: from mail.kernel.org ([198.145.29.99]:54206 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726713AbgDSTUX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Apr 2020 15:20:23 -0400
Subject: Re: [GIT pull] irq/urgent for 5.7-rc2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1587324023;
        bh=6frm6mVnlLcARXOPPgoPUFrcD3ZntnurP5UG52j5NO4=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=cBxJUFT7y6XB5AWpKo6OJDtJwh5MSBHH0UQG3JWL5gnmpJWygCuJXmVUzjKN69vfs
         4TdEdCFbCb75TwjSJHehumhVv5ScuQrhpDn0AWJRRCK7Axt4ULLZQAUCJkvg8mBZ4+
         ITzATxO39HBsKOAHLKohgZOJAcV8tL4CjhPSwPh8=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <158730459980.31269.13583785801133825132.tglx@nanos.tec.linutronix.de>
References: <158730459860.31269.9496277256253823777.tglx@nanos.tec.linutronix.de>
 <158730459980.31269.13583785801133825132.tglx@nanos.tec.linutronix.de>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <158730459980.31269.13583785801133825132.tglx@nanos.tec.linutronix.de>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git
 irq-urgent-2020-04-19
X-PR-Tracked-Commit-Id: b5963029d9e31dbc39a4d74f7fe8a748d689d3c2
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 80ade29e1ed0d04fdb108b2344f27b89997fc408
Message-Id: <158732402319.20624.10951519417320083403.pr-tracker-bot@kernel.org>
Date:   Sun, 19 Apr 2020 19:20:23 +0000
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, x86@kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sun, 19 Apr 2020 13:56:39 -0000:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git irq-urgent-2020-04-19

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/80ade29e1ed0d04fdb108b2344f27b89997fc408

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
