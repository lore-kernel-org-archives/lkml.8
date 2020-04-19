Return-Path: <SRS0=L1Qp=6D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB69EC54F70
	for <linux-kernel@archiver.kernel.org>; Sun, 19 Apr 2020 19:20:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BBB7822252
	for <linux-kernel@archiver.kernel.org>; Sun, 19 Apr 2020 19:20:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1587324027;
	bh=nTCcUYf71kICqtEJWZ3XtPYhK8WA+a1pdDU1TT9gdCU=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=HfiB13xvgB5Zp6T/KLbMSlGKlVM4qIl5YOBSCy74/1cs5RQFRSl/g+WEEXvfpOQut
	 XXwVVtkQaWWSRx5FCVAT2id+JjkrO7w4KzZeCEis5ENUMrzqI7oejXZEyfqFAM2yDY
	 lr1Um7XBEtsSUA8yGZ/pApSfdJ1ibg/r/jCWMKig=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726753AbgDSTUY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 19 Apr 2020 15:20:24 -0400
Received: from mail.kernel.org ([198.145.29.99]:54170 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726710AbgDSTUX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Apr 2020 15:20:23 -0400
Subject: Re: [GIT pull] sched/urgent for 5.7-rc2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1587324022;
        bh=nTCcUYf71kICqtEJWZ3XtPYhK8WA+a1pdDU1TT9gdCU=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=g+Uo3+q4aqvELpd/auq3p0LpIuUshqUKmQQALTPgvfm05mJUTz11vVGEibDKbHVpf
         Y5dN40817qsyzxLCULEaa9j1sN4tMv9NjRzim+hH5/WgfTchYWRucKzOKKDHgX9/Cd
         IoakMl3RljNqiN0SCcICrJjUxH+M7mVtV3aRUnAI=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <158730460222.31269.10288599242154679193.tglx@nanos.tec.linutronix.de>
References: <158730459860.31269.9496277256253823777.tglx@nanos.tec.linutronix.de>
 <158730460222.31269.10288599242154679193.tglx@nanos.tec.linutronix.de>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <158730460222.31269.10288599242154679193.tglx@nanos.tec.linutronix.de>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git
 sched-urgent-2020-04-19
X-PR-Tracked-Commit-Id: e0d648f9d883ec1efab261af158d73aa30e9dd12
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 08dd3872770b78d3d5e26d251b5853aa26e35d41
Message-Id: <158732402286.20624.6752424460175529417.pr-tracker-bot@kernel.org>
Date:   Sun, 19 Apr 2020 19:20:22 +0000
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, x86@kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sun, 19 Apr 2020 13:56:42 -0000:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git sched-urgent-2020-04-19

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/08dd3872770b78d3d5e26d251b5853aa26e35d41

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
