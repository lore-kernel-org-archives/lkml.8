Return-Path: <SRS0=6uoK=35=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5DC4C2BA83
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Feb 2020 20:40:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A9A0220726
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Feb 2020 20:40:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1581280837;
	bh=7OkSibig9um5vAt9s30JpXnbrFpj1g5Xs4WdJElVp+c=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=AIxZpQdy4ukCcoTAGuMAJkKKxcAUatzBIWe9E1Xpya4ITZIPEwhGWHPav4h/1bpJa
	 3ugejz/nJ5vm2Ij/XCv/zBcDindATmFwspdrOgNj7Bz62806tw0Z7txO5bxAoYfmui
	 3EaZjc7MZaczM2EG8oNvax1px+ivEjSUE1YuNL5M=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727986AbgBIUkf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 9 Feb 2020 15:40:35 -0500
Received: from mail.kernel.org ([198.145.29.99]:43634 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727972AbgBIUka (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Feb 2020 15:40:30 -0500
Subject: Re: [GIT pull] x86 fixes for 5.6-rc1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1581280830;
        bh=7OkSibig9um5vAt9s30JpXnbrFpj1g5Xs4WdJElVp+c=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=Khf/uW/igp7FLo8d9Nmav9s2lUZdwBgdbMi7DsGSN5fyaKT7gAxxzRLz4UaGXWE48
         j4dX8uXxiW7hByQn4duhhAdJRuuCFGl5bwOLNDmFDlyOPW+pYw3Sd2TnK6tArI0cBI
         3rbNJr9vwTQx0Yu00xmr4zezlaTMOGiPm00vrl64=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <158125695732.26104.8703656786037209247.tglx@nanos.tec.linutronix.de>
References: <158125695731.26104.949647922067525745.tglx@nanos.tec.linutronix.de>
 <158125695732.26104.8703656786037209247.tglx@nanos.tec.linutronix.de>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <158125695732.26104.8703656786037209247.tglx@nanos.tec.linutronix.de>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git
 x86-urgent-2020-02-09
X-PR-Tracked-Commit-Id: 0f378d73d429d5f73fe2f00be4c9a15dbe9779ee
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 1a2a76c2685a29e46d7b37e752ccea7b15aa8e24
Message-Id: <158128082995.31187.7789453045572318731.pr-tracker-bot@kernel.org>
Date:   Sun, 09 Feb 2020 20:40:29 +0000
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, x86@kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sun, 09 Feb 2020 14:02:37 -0000:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86-urgent-2020-02-09

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/1a2a76c2685a29e46d7b37e752ccea7b15aa8e24

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
