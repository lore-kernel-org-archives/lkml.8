Return-Path: <SRS0=s8dx=5M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27F3AC2D0E5
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Mar 2020 16:55:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EDC572076B
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Mar 2020 16:55:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1585328108;
	bh=5GmCGse5ThixCBJK4fRqQmxGOVFWWuHQS36UiFoeoVo=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=dP8gI1QlaRcT8V03CEdoYXX1vvR8SQ0Nx8+UJ9hgmL8gNj0BmBszcjpzwN29nrO8R
	 BmC2dXC/ZJlamCXxUAhMEq7Zfng0gV6TRpA4G0cy9fUrrUrC4/2nDPvpgRRh94e9we
	 kWjTrym56wWQz21bN49jiHkOVX/gDREJt8QGE9EQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727600AbgC0QzG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Mar 2020 12:55:06 -0400
Received: from mail.kernel.org ([198.145.29.99]:51096 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727185AbgC0QzG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Mar 2020 12:55:06 -0400
Subject: Re: [git pull] drm fixes for 5.6-rc8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1585328106;
        bh=5GmCGse5ThixCBJK4fRqQmxGOVFWWuHQS36UiFoeoVo=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=uB0Jk3P1+bSNUw36JsbT47ruqLtLLSB3qiQ8lI8wGvIa0MpX2+4++vikOX3ru9vBt
         NRRMjKkPswYrynt+rpISVFymsCFBwWkPRKD8t41PAoi0WQ3ApH9CVgjPP8wz+PnXWO
         Yn9Csi/5tZF/JjDdq+HSOlW1sYgoP/g1yNNhNZBM=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <CAPM=9tx=PisdA7qzEBz+n9Sqc4YfSpaSV-ja3tf7MjBnZ=_NXg@mail.gmail.com>
References: <CAPM=9tx=PisdA7qzEBz+n9Sqc4YfSpaSV-ja3tf7MjBnZ=_NXg@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAPM=9tx=PisdA7qzEBz+n9Sqc4YfSpaSV-ja3tf7MjBnZ=_NXg@mail.gmail.com>
X-PR-Tracked-Remote: git://anongit.freedesktop.org/drm/drm
 tags/drm-fixes-2020-03-27
X-PR-Tracked-Commit-Id: c4b979ebcafe978338cad1df4c77cdc8f84bd51c
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 7bf8df68cba0536479aead32297e47908922582c
Message-Id: <158532810616.31172.8807001450688549024.pr-tracker-bot@kernel.org>
Date:   Fri, 27 Mar 2020 16:55:06 +0000
To:     Dave Airlie <airlied@gmail.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 27 Mar 2020 16:58:46 +1000:

> git://anongit.freedesktop.org/drm/drm tags/drm-fixes-2020-03-27

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/7bf8df68cba0536479aead32297e47908922582c

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
