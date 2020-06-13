Return-Path: <SRS0=WLRa=72=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53484C433DF
	for <linux-kernel@archiver.kernel.org>; Sat, 13 Jun 2020 18:00:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 32C46207FF
	for <linux-kernel@archiver.kernel.org>; Sat, 13 Jun 2020 18:00:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1592071254;
	bh=jUxv3dZ6wNo7KhYazYkrHCP34/YVeVN8UbV2dqj09yk=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=J+qCALBp0fVE6QpSSCfcmnCE3Vw9dUxXZiauoWYT9LgvKtiRYMHHv0PxuXF79cFqd
	 yb9HZf53uGpFDukJul7WKf7eJ1cbeztymsoNmKwHHRS3+w9iIIVqf1AREfNw2KCs8B
	 JEeyZ13snXPiMLlkarW4up4baIMSXyio+9RfzWoc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726830AbgFMSAv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 13 Jun 2020 14:00:51 -0400
Received: from mail.kernel.org ([198.145.29.99]:60148 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726765AbgFMSAd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 13 Jun 2020 14:00:33 -0400
Subject: Re: [GIT pull resend] ras/core for v5.8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592071233;
        bh=jUxv3dZ6wNo7KhYazYkrHCP34/YVeVN8UbV2dqj09yk=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=1cMEgtR0TnfjVSO4wR+B55969w3sQUMv0JqRhiXBq892fZp6OQmQ33SmWp3+laKs/
         BJy6UvQ9CNLsQVinfFBbnal0+/eBG/wQb0GJrqevAfc4k3p2sLdDezf8KNCz+lDd7+
         4fsAMkwWjJFG8+HUF/oomxCuAZoYiU4G9zze39GQ=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <159199950675.21782.3785702143162610645.tglx@nanos.tec.linutronix.de>
References: <159199950433.21782.7922990856385499228.tglx@nanos.tec.linutronix.de>
 <159199950675.21782.3785702143162610645.tglx@nanos.tec.linutronix.de>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <159199950675.21782.3785702143162610645.tglx@nanos.tec.linutronix.de>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git ras-core-2020-06-12
X-PR-Tracked-Commit-Id: 7ccddc4613db446dc3cbb69a3763ba60ec651d13
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: a9429089d3e822d45be01a9635f0685174508fd3
Message-Id: <159207123332.28894.7000363761584210831.pr-tracker-bot@kernel.org>
Date:   Sat, 13 Jun 2020 18:00:33 +0000
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, x86@kernel.org,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 12 Jun 2020 22:05:06 -0000:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git ras-core-2020-06-12

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/a9429089d3e822d45be01a9635f0685174508fd3

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
