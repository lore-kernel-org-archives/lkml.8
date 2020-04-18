Return-Path: <SRS0=3CHW=6C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E450C352BE
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Apr 2020 18:35:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3EF53221E9
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Apr 2020 18:35:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1587234922;
	bh=X1skhu5YxlhbdiDMFtNhK3bRkj4zF1TrrY2iamgPY18=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=ZoIgvyWODB4EivPP7HQMXIX8CqGHBpztnde2R6J9q9+NpknNji+G+T1AwbFZGPOeI
	 UWCBr4Phv4pXBfLmzmDES77pQnpFpjgR6U43WWqOVh2mmzMx1EvrFyTZn48/vwkxaA
	 45b1pTt81VgtEe8iosxOA1zca98pQfNWRuANxyUc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727834AbgDRSfV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 18 Apr 2020 14:35:21 -0400
Received: from mail.kernel.org ([198.145.29.99]:52908 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726842AbgDRSfU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Apr 2020 14:35:20 -0400
Subject: Re: [git pull] drm fixes for 5.7-rc2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1587234920;
        bh=X1skhu5YxlhbdiDMFtNhK3bRkj4zF1TrrY2iamgPY18=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=vRorZyyiTUL8QgROpjzCm2HjmZYDLLSWEeiup6vOQKyUV6wdh4jojlVFgCYh6IL+2
         JU90YW0cZgQtWetBREsTECDRJw4yxpM/+D1BfnYhfNa0M3phOH1Wzl/3XDvC2o5GFH
         QiOQQiMnfWLCyuhTLvjdQirLpjj/915vFVeQ7SRA=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <CAPM=9tyt1N=QTmsyBKYzMqYJLbNzrgrnNoqQrzn3735ePSCODQ@mail.gmail.com>
References: <CAPM=9tyt1N=QTmsyBKYzMqYJLbNzrgrnNoqQrzn3735ePSCODQ@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAPM=9tyt1N=QTmsyBKYzMqYJLbNzrgrnNoqQrzn3735ePSCODQ@mail.gmail.com>
X-PR-Tracked-Remote: git://anongit.freedesktop.org/drm/drm
 tags/drm-fixes-2020-04-18
X-PR-Tracked-Commit-Id: 4da858c086433cd012c0bb16b5921f6fafe3f803
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: fecca68997833ef75f338fbbb76dd12fae7ca3b5
Message-Id: <158723492054.13159.8229764495094735943.pr-tracker-bot@kernel.org>
Date:   Sat, 18 Apr 2020 18:35:20 +0000
To:     Dave Airlie <airlied@gmail.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sat, 18 Apr 2020 14:24:32 +1000:

> git://anongit.freedesktop.org/drm/drm tags/drm-fixes-2020-04-18

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/fecca68997833ef75f338fbbb76dd12fae7ca3b5

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
