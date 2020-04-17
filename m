Return-Path: <SRS0=3W8M=6B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5903C2D0EF
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Apr 2020 19:15:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8BAD02076D
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Apr 2020 19:15:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1587150928;
	bh=+tua57vQELZzu82chP/E+EIujovOQck5GjGwA2IPaD4=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=AR38FTh6L0kYKx/17o++cHSII2NRGE3X88aEsqwETYFktoQvOC4IVUjQ5MOfHSwxd
	 1ly0M3P9OFRabPEtNXWxvoYYY8xah8f/h4MTp74pqWoP2V0ysYsN0oh1RQJP+JetkL
	 AoUxvuIO62xEkdbxTAqBGXUh2zqR2Kc5X0AkOW3o=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730516AbgDQTP1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Apr 2020 15:15:27 -0400
Received: from mail.kernel.org ([198.145.29.99]:38744 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728563AbgDQTPX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Apr 2020 15:15:23 -0400
Subject: Re: [GIT PULL] mtd: Fixes for v5.7-rc2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1587150922;
        bh=+tua57vQELZzu82chP/E+EIujovOQck5GjGwA2IPaD4=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=CP1tLFzrFvzsCMwiKbWC9/pXVBIXr1d4KuAfhzzrqrW0VmrjKxX59qiEZtitcAVRg
         /tnZu0HDOWw23zlfzJ+Enedy5cvZkCj45I3hZMBQZDmp9x+wml9Kl6wtfhosOHvkNe
         vUcWQsa15ARBAWYhxyBvyeZCrzBwgSoZzLM+vtZE=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <58708601.124954.1587140866342.JavaMail.zimbra@nod.at>
References: <58708601.124954.1587140866342.JavaMail.zimbra@nod.at>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <58708601.124954.1587140866342.JavaMail.zimbra@nod.at>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/mtd/linux.git
 tags/mtd/fixes-for-5.7-rc2
X-PR-Tracked-Commit-Id: 2098c564701c0dde76063dd9c5c00a7a1f173541
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: ceb1adbacb4971cd47533d667f91ed06a38d7d4a
Message-Id: <158715092271.7925.6177261944461862662.pr-tracker-bot@kernel.org>
Date:   Fri, 17 Apr 2020 19:15:22 +0000
To:     Richard Weinberger <richard@nod.at>
Cc:     torvalds <torvalds@linux-foundation.org>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Tudor Ambarus <Tudor.Ambarus@microchip.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 17 Apr 2020 18:27:46 +0200 (CEST):

> git://git.kernel.org/pub/scm/linux/kernel/git/mtd/linux.git tags/mtd/fixes-for-5.7-rc2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/ceb1adbacb4971cd47533d667f91ed06a38d7d4a

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
