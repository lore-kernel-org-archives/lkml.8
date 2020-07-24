Return-Path: <SRS0=4orP=BD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8DD40C43457
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jul 2020 21:40:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 634752070E
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jul 2020 21:40:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1595626805;
	bh=DxJA8cVzgvxqbDGC3Uzf8eFJ4JiqoI58bB3qOxHc3nc=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=IfG2sDKj5a0UqqyXz/Mih26BvfEnbLE443qd6dWyzj9D2WQ+M+weJMzKcEJRh7EPO
	 WMpNSdrTBdBoOBLPb1hFmu2vRX7+aXSRuTzE+f45WziKQURCxM1zvMOoc0s1ip6fm+
	 JBko4NIxWJDJWaJD5KUMQUCh6bXKY/YqzJ9qrruM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726907AbgGXVkE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Jul 2020 17:40:04 -0400
Received: from mail.kernel.org ([198.145.29.99]:48810 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726576AbgGXVkD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jul 2020 17:40:03 -0400
Subject: Re: [git pull] drm fixes for 5.8-rc7
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1595626803;
        bh=DxJA8cVzgvxqbDGC3Uzf8eFJ4JiqoI58bB3qOxHc3nc=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=IukPE7mvaDxQtVOYlHR3w4Jos/yos2OPqoPT3wQ85RteWQRZ0nEKufzzJEeUrCaOZ
         Tai3Lv74P55oJfYiqW0Usjq9y4uMwIEB2Z+yrBPHAYsDneu2rl62N245asoCFjpUwn
         DthQP1jo4eudgk4C3zBlw5zeZHB+TkQ1/geSEjmg=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <CAPM=9twWoMc=xxXnZ7kKYp_fmYEquLE=PgVtjPhcH86Ocv3W7g@mail.gmail.com>
References: <CAPM=9twWoMc=xxXnZ7kKYp_fmYEquLE=PgVtjPhcH86Ocv3W7g@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAPM=9twWoMc=xxXnZ7kKYp_fmYEquLE=PgVtjPhcH86Ocv3W7g@mail.gmail.com>
X-PR-Tracked-Remote: git://anongit.freedesktop.org/drm/drm
 tags/drm-fixes-2020-07-24
X-PR-Tracked-Commit-Id: d8904ca9d338cdaa67e3bd06d7a7d418e426648c
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 88fff0b7dcc132c924d710d75d1401264b6d0ef6
Message-Id: <159562680338.3064.493657765815732199.pr-tracker-bot@kernel.org>
Date:   Fri, 24 Jul 2020 21:40:03 +0000
To:     Dave Airlie <airlied@gmail.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 24 Jul 2020 14:56:40 +1000:

> git://anongit.freedesktop.org/drm/drm tags/drm-fixes-2020-07-24

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/88fff0b7dcc132c924d710d75d1401264b6d0ef6

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
