Return-Path: <SRS0=aBbL=CG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3433CC433E6
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Aug 2020 20:29:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0B65E2087D
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Aug 2020 20:29:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1598646559;
	bh=TtilPxMYfk4JfCI5AMi/LlLdSfbmjMUA9CWxkiwWd2s=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=gxGgIcazO/VBiZv/XiZexvHyyWHKoZacbU5HPymTdJa3edWBSqwvVN25Vj2wNjGdg
	 PTrIJF87qQkEoh7ZDX7Hu+5yNOSr3geFq/NqOoc2nYMyAIsiPgaiDeYyD5AKJbqF6m
	 3mL3Rr8Ehu/OATSAHoETGKXf/jTtPWkf1bYsfjCw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726938AbgH1U3R (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Aug 2020 16:29:17 -0400
Received: from mail.kernel.org ([198.145.29.99]:43844 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726033AbgH1U3L (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Aug 2020 16:29:11 -0400
Subject: Re: [GIT PULL] Power management fixes for v5.9-rc3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598646551;
        bh=TtilPxMYfk4JfCI5AMi/LlLdSfbmjMUA9CWxkiwWd2s=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=DdL8NANHO4QH7tKsOEShMk/bSdcrfqfF8VpF+HIUHW5VTaD4+vmAk6AzLkgnopJ05
         lJk5/ytO+arAvnNs3vKUPCT7tQL0V7lWh5jJyUO04vjmH3C8dtg8WQEo53++oEuQ/K
         +LTJzvbKxuU3JvgOzkLICJ3rLBesKvbw9zEhJk/U=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <CAJZ5v0hYtUUKQmMi4P1-m+R5EDUsbzBySfFMDK6k48QZw2WrqQ@mail.gmail.com>
References: <CAJZ5v0hYtUUKQmMi4P1-m+R5EDUsbzBySfFMDK6k48QZw2WrqQ@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAJZ5v0hYtUUKQmMi4P1-m+R5EDUsbzBySfFMDK6k48QZw2WrqQ@mail.gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git pm-5.9-rc3
X-PR-Tracked-Commit-Id: ef7d960403ecd87276e12b69c26bf0fdd5f21a0e
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 326e311b849426a95cac0149406efb2bbd13fa65
Message-Id: <159864655124.14109.8179395407158942997.pr-tracker-bot@kernel.org>
Date:   Fri, 28 Aug 2020 20:29:11 +0000
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 28 Aug 2020 21:49:49 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git pm-5.9-rc3

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/326e311b849426a95cac0149406efb2bbd13fa65

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
