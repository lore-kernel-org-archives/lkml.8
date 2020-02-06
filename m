Return-Path: <SRS0=za8s=32=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DCD71C33CAC
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Feb 2020 17:20:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B2ED4214AF
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Feb 2020 17:20:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1581009616;
	bh=EUx9yUJBQkfJvQpBgPZK4UaQXRTEysxY7w2IOP/wiaE=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=f+L3gtwYlxOHq/66yWPBrpd9hcphB/Fxu/AMRSG+EQXq6rDNaYYJ4mTb0Sqk0sWaJ
	 MCZbTLNJy35LVaqljXEskLiCFLFUjVpsRGdu4FQO+VA7nZT1YFJxxMpuu7NpMm4ngl
	 kS5Se7VTN60+waoajwfJQlaMmTkPjSavgK+/IWtY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727711AbgBFRUQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Feb 2020 12:20:16 -0500
Received: from mail.kernel.org ([198.145.29.99]:41842 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727556AbgBFRUP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Feb 2020 12:20:15 -0500
Subject: Re: [GIT PULL] kgdb fixes for v5.6-rc1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1581009615;
        bh=EUx9yUJBQkfJvQpBgPZK4UaQXRTEysxY7w2IOP/wiaE=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=ATzLz5lh3q2z6t8+rJReffYoRVGNYZGwD4utXY7vRKmXRzl6Atn+RHrKENsP+kQnT
         qXkDhdH0JPzDAORaPatNZjyq4/O73q7ZU49PFBsXoVTNdQ/ZaNSzwpFfW63w4atBaN
         uYUNY9pEuB6RFfzDzOPok2TlnEBMuQD8PWqtCgPE=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20200206145200.pafzy25atqrh5wro@holly.lan>
References: <20200206145200.pafzy25atqrh5wro@holly.lan>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20200206145200.pafzy25atqrh5wro@holly.lan>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/danielt/linux.git/
 tags/kgdb-fixes-5.6-rc1
X-PR-Tracked-Commit-Id: fcf2736c82ca1908e3a0e74730c404baebd8ccdf
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: d854b2d639fd61ccdc184385ee4036658a52e57e
Message-Id: <158100961515.16939.9154525341972280108.pr-tracker-bot@kernel.org>
Date:   Thu, 06 Feb 2020 17:20:15 +0000
To:     Daniel Thompson <daniel.thompson@linaro.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Jason Wessel <jason.wessel@windriver.com>,
        linux-kernel@vger.kernel.org,
        Douglas Anderson <dianders@chromium.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Thu, 6 Feb 2020 14:52:00 +0000:

> git://git.kernel.org/pub/scm/linux/kernel/git/danielt/linux.git/ tags/kgdb-fixes-5.6-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/d854b2d639fd61ccdc184385ee4036658a52e57e

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
