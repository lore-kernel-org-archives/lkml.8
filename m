Return-Path: <SRS0=EKp2=A6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89AC8C433E8
	for <linux-kernel@archiver.kernel.org>; Sun, 19 Jul 2020 20:00:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6685120709
	for <linux-kernel@archiver.kernel.org>; Sun, 19 Jul 2020 20:00:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1595188820;
	bh=q/HKGne/8BSIfnLSWosSnPdPjMOBu3w2eGNBuEplZfk=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=WVjabpCVX6dsk+f90IKwZUmXqjzDkDZHWdCj2vd+hYIiZ8GlmyJrLzVGrH4kO3aef
	 wmDtwTbz6jfHkJbvmGh2Lh5IDyvmKEKIsidfaxwscpcuLawLinayj68ydfy/1Tfsq9
	 U5emTSIXIU6TvEEli5kvlJAWXzdNbDSKhVKh8zs4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726780AbgGSUAT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 19 Jul 2020 16:00:19 -0400
Received: from mail.kernel.org ([198.145.29.99]:46346 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726675AbgGSUAF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Jul 2020 16:00:05 -0400
Subject: Re: [GIT pull] timers/urgent for v5.8-rc6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1595188805;
        bh=q/HKGne/8BSIfnLSWosSnPdPjMOBu3w2eGNBuEplZfk=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=Ywh/Ue+Xg78s0SSdtScht8Hzwjy95VEa98IjOAH0rIfaFyxugVH7PpCrE0O8u1+oT
         zY9TEn5WkJdqBUGQH8QU9OS2gkUQnq/VCXfqPO3YUFJSVazwctH+yTi+dtlC3A+tYT
         TSCF3rJWdEi8TsCEJ91DgtWaodqpMEdf1vZxSNdM=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <159516469255.4147.9121109492857011441.tglx@nanos.tec.linutronix.de>
References: <159516469014.4147.6471285397574034610.tglx@nanos.tec.linutronix.de>
 <159516469255.4147.9121109492857011441.tglx@nanos.tec.linutronix.de>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <159516469255.4147.9121109492857011441.tglx@nanos.tec.linutronix.de>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git
 timers-urgent-2020-07-19
X-PR-Tracked-Commit-Id: e2a71bdea81690b6ef11f4368261ec6f5b6891aa
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 66e4b63624fcfa47f4d4e0d451f22a8f67902426
Message-Id: <159518880532.26827.13650306164037252706.pr-tracker-bot@kernel.org>
Date:   Sun, 19 Jul 2020 20:00:05 +0000
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, x86@kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sun, 19 Jul 2020 13:18:12 -0000:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git timers-urgent-2020-07-19

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/66e4b63624fcfa47f4d4e0d451f22a8f67902426

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
