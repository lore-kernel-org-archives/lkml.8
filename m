Return-Path: <SRS0=w5GM=A4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD379C433E3
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jul 2020 04:50:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A633E20684
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jul 2020 04:50:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1594961406;
	bh=CEV5+HvUM+LJKJaEOLF10YSjYvEU7QkhIiBxygFcz/8=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=JM1jrU+sgBMRj+CGdj6p4e/L/FhCO8T92FbKIMmgxRoz3CkCC7WpAT2H31PDZdpdB
	 9toPY77Rt3YnCO2Dc9HftxzOHyaEhcJavOyomXWKrxAJIMyG4hBLBvuJfk54PhEoGq
	 KghXw+kPB65pb5GjbZieJYbssKNSO9X0YaGp7tVQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726550AbgGQEuE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Jul 2020 00:50:04 -0400
Received: from mail.kernel.org ([198.145.29.99]:44178 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725811AbgGQEuD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jul 2020 00:50:03 -0400
Subject: Re: [git pull] drm fixes for 5.8-rc6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1594961403;
        bh=CEV5+HvUM+LJKJaEOLF10YSjYvEU7QkhIiBxygFcz/8=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=a5sNoLbBcOuJ7SOQPLPzaPrHJarkgWYV2FbpO7JfcUreRVCJ0e0nppYHuyzG5jdh2
         XVM9WTywhcrZghEFEHz/p++4FcI+f6YKq24v6dR9lSfVs861lmd7MOKU5oFGHO86Hs
         pDaQ+bdIXR1hzO+pqnG2/G/KCxX5mL85hP/nEL8w=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <CAPM=9txCq=97pFiCoOGLz7-Ght-spbVFKURx_b0kVw9sO1+=zw@mail.gmail.com>
References: <CAPM=9txCq=97pFiCoOGLz7-Ght-spbVFKURx_b0kVw9sO1+=zw@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAPM=9txCq=97pFiCoOGLz7-Ght-spbVFKURx_b0kVw9sO1+=zw@mail.gmail.com>
X-PR-Tracked-Remote: git://anongit.freedesktop.org/drm/drm
 tags/drm-fixes-2020-07-17-1
X-PR-Tracked-Commit-Id: adbe8a3cae94a63e9f416795c750237a9b789124
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 8882572675c1bb1cc544f4e229a11661f1fc52e4
Message-Id: <159496140350.7072.5113413721616431155.pr-tracker-bot@kernel.org>
Date:   Fri, 17 Jul 2020 04:50:03 +0000
To:     Dave Airlie <airlied@gmail.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 17 Jul 2020 13:42:02 +1000:

> git://anongit.freedesktop.org/drm/drm tags/drm-fixes-2020-07-17-1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/8882572675c1bb1cc544f4e229a11661f1fc52e4

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
