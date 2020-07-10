Return-Path: <SRS0=2Lxt=AV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A891C433EB
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jul 2020 16:55:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E9B8D2078B
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jul 2020 16:55:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1594400129;
	bh=4xtFgdqVjChkA/XYf6Ft3Pxm5wm+B45aRaxQFpZLLuA=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=A3sOPYCAHbyraq1j8X9sSrcEc/qmyBXsMvnsT8vXD4Uq0QQB0R88+acQCgqj/nxGm
	 Yd5gdIVmaxt1FexDHmgw9+VoH7w9F+jf58VssFiOeGTfe+wTvFP9qoqBBpvNbvQ+Vt
	 QbnJQXLHWrDvtVIp0PIiTEhwYf3SkH7001RtViUc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728761AbgGJQzU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Jul 2020 12:55:20 -0400
Received: from mail.kernel.org ([198.145.29.99]:33878 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728410AbgGJQzG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jul 2020 12:55:06 -0400
Subject: Re: [GIT PULL] GPIO fixes for the v5.8 series
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1594400106;
        bh=4xtFgdqVjChkA/XYf6Ft3Pxm5wm+B45aRaxQFpZLLuA=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=j2RU/LK8TaxwVhOgwLXWSkeW9YFqLhrjn0V//sd60qcA1eIbVd3l/5WYjyOZwQOC9
         fHJT1oe1bqKx7dCRNdSi9waXFghMlbD75cZ4zedM2zI6sTmDpzl//ST+ZTHPPeuLv0
         kb8ziQJf+38VtyB2pNyP4V1iNmrZ9wSWx9LutSg4=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <CACRpkdYXcvN_Sqk=Am_r3uyNEfcnta7ZQuYEmBO8g=Wsp4y27w@mail.gmail.com>
References: <CACRpkdYXcvN_Sqk=Am_r3uyNEfcnta7ZQuYEmBO8g=Wsp4y27w@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <CACRpkdYXcvN_Sqk=Am_r3uyNEfcnta7ZQuYEmBO8g=Wsp4y27w@mail.gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/linusw/linux-gpio.git
 tags/gpio-v5.8-2
X-PR-Tracked-Commit-Id: 93e0272a4395819d51c7501b3cde771863ccecd2
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 3f8834327ae7d8bfc34793cfce72663af35133d0
Message-Id: <159440010630.18761.4945541908697262210.pr-tracker-bot@kernel.org>
Date:   Fri, 10 Jul 2020 16:55:06 +0000
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Navid Emamdoost <navid.emamdoost@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 10 Jul 2020 17:32:11 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/linusw/linux-gpio.git tags/gpio-v5.8-2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/3f8834327ae7d8bfc34793cfce72663af35133d0

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
