Return-Path: <SRS0=zXkI=7F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34A44C433E0
	for <linux-kernel@archiver.kernel.org>; Sat, 23 May 2020 18:30:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0DBE92070A
	for <linux-kernel@archiver.kernel.org>; Sat, 23 May 2020 18:30:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1590258622;
	bh=17U8764jhQELSSDLQ+esCvjUyVsB5ESP5z0pbqzr/rw=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=oMmexZyr+2dJ1NuVGEqtdiynEWkehgtVZ0U9IS5I1vgiQuJRAeLaDouRhVG54xZCv
	 X3Csl7b2mDiKUFhV1aJCk2u5QtsgYKIKF7fo+B1gaLzqpYIJCfmgNaiilcFGBqxR5w
	 nJi3cTTpYEEoTQI66VLnLe364p+rsCKYv0NoAIQs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388080AbgEWSaV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 23 May 2020 14:30:21 -0400
Received: from mail.kernel.org ([198.145.29.99]:53208 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727989AbgEWSaD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 May 2020 14:30:03 -0400
Subject: Re: [GIT PULL] TTY/Serial driver fix for 5.7-rc7
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1590258603;
        bh=17U8764jhQELSSDLQ+esCvjUyVsB5ESP5z0pbqzr/rw=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=HIEqkFm7ODFEDmah4IFPYcmvKQy0c96TUGRDs4ej/5AKjG6VJSsoknXIQiiA3YmpS
         uqGnOl6rMdsLMw6ix2QaQeV5IBRL4WN+5jz56mNmXcrGQ5ZEI6FrH9VycCKqwToKcd
         p/FjM38wY5nolu+DXHTIKDniv4vwqBHW1HnfeGIY=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20200523131724.GA54852@kroah.com>
References: <20200523131724.GA54852@kroah.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20200523131724.GA54852@kroah.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/tty.git tags/tty-5.7-rc7
X-PR-Tracked-Commit-Id: 17b4efdf4e4867079012a48ca10d965fe9d68822
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: d3044d7d220529a4ce0cbfe00de63996935908d1
Message-Id: <159025860306.7121.6752228151829320876.pr-tracker-bot@kernel.org>
Date:   Sat, 23 May 2020 18:30:03 +0000
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Jiri Slaby <jslaby@suse.cz>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sat, 23 May 2020 15:17:24 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/tty.git tags/tty-5.7-rc7

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/d3044d7d220529a4ce0cbfe00de63996935908d1

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
