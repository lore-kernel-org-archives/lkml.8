Return-Path: <SRS0=Zbf8=4B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7CF7AC352A3
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Feb 2020 22:40:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 50FDC20873
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Feb 2020 22:40:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1581633628;
	bh=HWBEPIDIYU2jL99IeKBdmtrRF+dOnsvIV2Jqnk26pEs=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=zIu6SLah3VaekxRHiDz6hjICn9zAlQKrlX9+Ur4saraKC6EwwE05GyiKu6Nhm2b4+
	 fVR4kZjTFCFnTP6Guu8LqhQ597POJZx5/H186Adt8Q0LRgw5shjEq9FEq/nrutyqcX
	 RRmpGohSVIINmHADeYrGig3CebbaTqbWiMIA8aek=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727979AbgBMWk1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Feb 2020 17:40:27 -0500
Received: from mail.kernel.org ([198.145.29.99]:37562 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727609AbgBMWkW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Feb 2020 17:40:22 -0500
Subject: Re: [GIT PULL] GPIO fixes for v5.6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1581633622;
        bh=HWBEPIDIYU2jL99IeKBdmtrRF+dOnsvIV2Jqnk26pEs=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=uLxCoXYgcAap45FxPki1G2DX9goJkLz0RsmDJFHeasAEsJFkPzR1U5LxnNhsknxc0
         sPwqfzYQpzmq/TlC7puRDD5yiqVSzxEDZxp1uzjq2Fs6mf/yAZJuzHOptCPdQjuUYG
         xFDiuyU/txAoSnRZM1sLUruB0+suSLySSXmZk9ck=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <CACRpkdYAtMeqYaBGF__6dP7tOc_oh573Xtrxza-qcT7TtFNmSw@mail.gmail.com>
References: <CACRpkdYAtMeqYaBGF__6dP7tOc_oh573Xtrxza-qcT7TtFNmSw@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <CACRpkdYAtMeqYaBGF__6dP7tOc_oh573Xtrxza-qcT7TtFNmSw@mail.gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/linusw/linux-gpio.git
 tags/gpio-v5.6-2
X-PR-Tracked-Commit-Id: a924eae75106258c0797706a0578c5af499c9ff5
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 1d40890aae812378fdcf47e203abf49476f9c071
Message-Id: <158163362200.23424.8644629964941196858.pr-tracker-bot@kernel.org>
Date:   Thu, 13 Feb 2020 22:40:22 +0000
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Stephen Boyd <swboyd@chromium.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Thu, 13 Feb 2020 13:06:38 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/linusw/linux-gpio.git tags/gpio-v5.6-2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/1d40890aae812378fdcf47e203abf49476f9c071

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
