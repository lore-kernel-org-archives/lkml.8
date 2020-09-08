Return-Path: <SRS0=o+hd=CR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97304C43461
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Sep 2020 18:26:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 61E6F2080A
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Sep 2020 18:26:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1599589589;
	bh=EA56Y2PAWEn0I+v7dzXzED2ZEgWwWS9lgmkRcjziNUk=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=kjJARKoWf/QPhZRwwjXHnCjaMtIj72yAjWmrx5H2L5aCsvYkrZM9lZ5jwOz0TZ/7F
	 HiHcYZdesnUWYRRIbylBSrUgDNXkLDHq1GH5x4TLgUQ1LU40JzZc5lR9zNOR8JR53a
	 LOaibQih3niNa9TGwB+UQKj/gzo5h4/MR7hkLsHk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731442AbgIHS01 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Sep 2020 14:26:27 -0400
Received: from mail.kernel.org ([198.145.29.99]:60386 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731059AbgIHSTR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Sep 2020 14:19:17 -0400
Subject: Re: [git pull] drm fixes for 5.9-rc5 (special edition)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1599589157;
        bh=EA56Y2PAWEn0I+v7dzXzED2ZEgWwWS9lgmkRcjziNUk=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=t3dp4ASZT5RXvDNrTn/L0tCilu+KANvKSJxIdpCQUoo38yV3di5aDqCzfUf5m5q+O
         5BhJ+7APv1AdkpgBnxwYzvPfxgx5IICLmpByfffZy9Jd2ELUha1cYVY+UQhosJuU7g
         uXCHr123quIDwgMJA4UA2UIM/6/7wfpHDDV6m72c=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <CAPM=9tw2tebfrjMEiB5fUy8USZrjq4b_siciDecFfMu8H794gA@mail.gmail.com>
References: <CAPM=9tw2tebfrjMEiB5fUy8USZrjq4b_siciDecFfMu8H794gA@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAPM=9tw2tebfrjMEiB5fUy8USZrjq4b_siciDecFfMu8H794gA@mail.gmail.com>
X-PR-Tracked-Remote: git://anongit.freedesktop.org/drm/drm tags/drm-fixes-2020-09-08
X-PR-Tracked-Commit-Id: 20561da3a2e1e0e827ef5510cb0f74bcfd377e41
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 6f6a73c8b715d595977774d48450a734297ab21f
Message-Id: <159958915704.19003.18086198109433271774.pr-tracker-bot@kernel.org>
Date:   Tue, 08 Sep 2020 18:19:17 +0000
To:     Dave Airlie <airlied@gmail.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Stephen Rothwell <sfr@canb.auug.org.au>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Tue, 8 Sep 2020 16:22:25 +1000:

> git://anongit.freedesktop.org/drm/drm tags/drm-fixes-2020-09-08

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/6f6a73c8b715d595977774d48450a734297ab21f

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
