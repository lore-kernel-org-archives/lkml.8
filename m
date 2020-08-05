Return-Path: <SRS0=MXgo=BP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4860C433E1
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Aug 2020 20:33:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6FA6622B42
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Aug 2020 20:33:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1596659631;
	bh=NhjeZwYqNTvtprf7yDqt7agKIrfEzw1nZ3NwS930wOQ=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=a3wNDyyBb0rZlt3d30zILGc5Zlh/mmAjoDgsxXWWY6aCdVvbPpBFamp3MZxv6BQU7
	 rmyPjWe9yT6aL540PHRGoxjH/T2UtzY/gXNFRexYktCIHsB8LUACy60Te57255pv83
	 2Zu0M91lZamKc2u6j5iq8HD9a54hoLj2eq9iCPDg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727019AbgHEUdu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Aug 2020 16:33:50 -0400
Received: from mail.kernel.org ([198.145.29.99]:58418 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725139AbgHEUdq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Aug 2020 16:33:46 -0400
Subject: Re: [GIT PULL] GPIO changes for the v5.9 merge window
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1596659626;
        bh=NhjeZwYqNTvtprf7yDqt7agKIrfEzw1nZ3NwS930wOQ=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=wIdwclmxLbtb5QONn9YfWvrCWDI20Fiq05rvm8FLjBXNrVyFLqJUpoI6tzgFVrN1Q
         RC0aZU5vqSbMWMbWvMeDRCCxvjTf0+lMdWNVnKwTlIPD1OnoCdLAOcXG+dx1ZfMSCF
         N5069sL/NHROuNk7Dy5TIG2PN8wE9gxnu4D/xDiY=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <CACRpkdamytgQTZ60g2R0UpRk5iy=uajtDp5VhsjKaM5H_CpUFA@mail.gmail.com>
References: <CACRpkdamytgQTZ60g2R0UpRk5iy=uajtDp5VhsjKaM5H_CpUFA@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-gpio.vger.kernel.org>
X-PR-Tracked-Message-Id: <CACRpkdamytgQTZ60g2R0UpRk5iy=uajtDp5VhsjKaM5H_CpUFA@mail.gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/linusw/linux-gpio.git tags/gpio-v5.9-1
X-PR-Tracked-Commit-Id: 22cc422070d9a9a399f8a70b89f1b852945444cb
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 1d8ce0e09301920454234a4096dee96a670a8e32
Message-Id: <159665962641.13939.3920276552797041360.pr-tracker-bot@kernel.org>
Date:   Wed, 05 Aug 2020 20:33:46 +0000
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Kent Gibson <warthog618@gmail.com>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Wed, 5 Aug 2020 00:03:28 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/linusw/linux-gpio.git tags/gpio-v5.9-1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/1d8ce0e09301920454234a4096dee96a670a8e32

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
