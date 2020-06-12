Return-Path: <SRS0=ixK5=7Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1FC85C433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Jun 2020 19:50:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F0B4720835
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Jun 2020 19:50:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1591991431;
	bh=Yp31jMU1NFpVB+68rtJaUyYJqxUnKne9W4NwD7WmI5M=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=l32zppsx/gPoq+fH47Y/AI4eCP1dlvae/An/5wRgJ1QkWSkk3qamg0bjtAsuTP6vt
	 7pdEJu3tK5ObCdjJj1X7R0eenqosEV/vU2+/ER6PqbQKz0mMUMsCV0rn4mNU/ut+gI
	 ThRIXKgB6O8It/Iv0OSsWgI4NqAsa7EeW8D5/2pA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726478AbgFLTu3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Jun 2020 15:50:29 -0400
Received: from mail.kernel.org ([198.145.29.99]:58382 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726283AbgFLTu2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Jun 2020 15:50:28 -0400
Subject: Re: [GIT PULL] pwm: Changes for v5.8-rc1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1591991428;
        bh=Yp31jMU1NFpVB+68rtJaUyYJqxUnKne9W4NwD7WmI5M=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=K2Lezml+thFrP23XOZV1jsRPPebE5c89EEQZqpKL1rgTOPPaPsSRwDV+ZZSH3MxuH
         VKFkWF+/XwGPiBSx8LW2dOD4lBXFH2ttetnSWfR44/uLv0NlhYTJ41ct4vli/S7Y+Y
         p+mY1ATnexsiQjtXeBvzzzXkcb5D3sjOXT+OZBw4=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20200612135049.2341678-1-thierry.reding@gmail.com>
References: <20200612135049.2341678-1-thierry.reding@gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20200612135049.2341678-1-thierry.reding@gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/thierry.reding/linux-pwm.git
 tags/pwm/for-5.8-rc1
X-PR-Tracked-Commit-Id: f5641d053d46a9a18fe13f2ecb4a7b4a66d9cdf7
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 9433a51ec1533e0620ff08d0318d215de73ceb77
Message-Id: <159199142860.26414.13269648687571484564.pr-tracker-bot@kernel.org>
Date:   Fri, 12 Jun 2020 19:50:28 +0000
To:     Thierry Reding <thierry.reding@gmail.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, Lee Jones <lee.jones@linaro.org>,
        linux-pwm@vger.kernel.org, linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 12 Jun 2020 15:50:49 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/thierry.reding/linux-pwm.git tags/pwm/for-5.8-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/9433a51ec1533e0620ff08d0318d215de73ceb77

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
