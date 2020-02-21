Return-Path: <SRS0=1210=4J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD0DFC3566F
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Feb 2020 21:10:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A1082208C4
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Feb 2020 21:10:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1582319404;
	bh=EAhw5aKVp633Mjlm8PjcZ587/Y5BkFMb7kGbuTm3fIc=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=uDFKliRVd7ga5PeJqrIUJtb3dxIZjiiGJZICT3lmjCBvXm1zhsK7OW2LpMp05kDxG
	 CTnTuejBnS1zgfSazCeJ0YilL/GOoJ33lpI+zZ7C4qSvt0c6l/NssxH+FGixrZRSfM
	 uaVUBwi/xhX7buqnE0MCn47S3sRctXCJoQAtR1Gc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729574AbgBUVKD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Feb 2020 16:10:03 -0500
Received: from mail.kernel.org ([198.145.29.99]:35676 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726878AbgBUVKD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Feb 2020 16:10:03 -0500
Subject: Re: [GIT PULL REQUEST] watchdog - v5.6 Fixes
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1582319402;
        bh=EAhw5aKVp633Mjlm8PjcZ587/Y5BkFMb7kGbuTm3fIc=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=bMhZ1+x6Mfh9hG/nj0RCVK5RuI4vCTUD/LZmtP3stQYjgmchh6p+5mJRR3lKN6da6
         DX4RJcG74kpnv9VA3jAQYis81ZpikQb78fxwFcbcevCHdPW+4j4gsk8dQZotR/CG+i
         r046DkodS4Qj4xu/tlfamEvkSNOLUKFNzObVUipE=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20200221131549.GA13194@www.linux-watchdog.org>
References: <20200221131549.GA13194@www.linux-watchdog.org>
X-PR-Tracked-List-Id: <linux-watchdog.vger.kernel.org>
X-PR-Tracked-Message-Id: <20200221131549.GA13194@www.linux-watchdog.org>
X-PR-Tracked-Remote: git://www.linux-watchdog.org/linux-watchdog.git
 tags/linux-watchdog-5.6-rc3
X-PR-Tracked-Commit-Id: 44144c809e39d64ff9931c7e8956c42b2baa89e6
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 0c0ddd6ae47c9238c18f475bcca675ca74c9dc31
Message-Id: <158231940241.18249.17078932166893961335.pr-tracker-bot@kernel.org>
Date:   Fri, 21 Feb 2020 21:10:02 +0000
To:     Wim Van Sebroeck <wim@linux-watchdog.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux Watchdog Mailing List <linux-watchdog@vger.kernel.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Marco Felsch <m.felsch@pengutronix.de>,
        Randy Dunlap <rdunlap@infradead.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 21 Feb 2020 14:15:49 +0100:

> git://www.linux-watchdog.org/linux-watchdog.git tags/linux-watchdog-5.6-rc3

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/0c0ddd6ae47c9238c18f475bcca675ca74c9dc31

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
