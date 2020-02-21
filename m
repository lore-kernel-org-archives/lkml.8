Return-Path: <SRS0=1210=4J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 799C9C35666
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Feb 2020 21:10:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 50401207FD
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Feb 2020 21:10:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1582319420;
	bh=A1EkMtqwTaYtxY6J1eO4CDA52gGDeiVUuY2B73zelp8=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=ryLg5VR3DQMCQhgfG7d3Bcnb51ER8JYtRHyyGgA5Vc4iUKtEY09Yd/NgFr4hJplaA
	 j1FMBOjRuuJof8ewx1Yi8CiSRRgU5HihgSDosksIVVCipWDTV/8EIYAoCjlGZ05t1N
	 SS6OWKdr5ACAjUoFtknmuiavYPOm5SrZpIWii30g=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729641AbgBUVKT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Feb 2020 16:10:19 -0500
Received: from mail.kernel.org ([198.145.29.99]:35764 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726731AbgBUVKS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Feb 2020 16:10:18 -0500
Subject: Re: [git pull] drm fixes for 5.6-rc3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1582319417;
        bh=A1EkMtqwTaYtxY6J1eO4CDA52gGDeiVUuY2B73zelp8=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=kxoTn7sJOka7K5WnnpHLm8OPMajvyTF0gHd1Ol3VIeyW4YlW86JRhlP25/4u59A7I
         H5JyspKp6c3gzHTBvO5jnAP4pV72o5aAcNNsZBBeKfqD/U7UoUIgmzCc/N1Uzk+g7D
         qIJRJCONJWF/wgOK9uDi5rJmKwoXjmTmspjci/Gw=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <CAPM=9tyKU17ntxT9JEbWf+ZhiQ3pMOQtjLVGmDViR43Boj7zdA@mail.gmail.com>
References: <CAPM=9tyKU17ntxT9JEbWf+ZhiQ3pMOQtjLVGmDViR43Boj7zdA@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAPM=9tyKU17ntxT9JEbWf+ZhiQ3pMOQtjLVGmDViR43Boj7zdA@mail.gmail.com>
X-PR-Tracked-Remote: git://anongit.freedesktop.org/drm/drm
 tags/drm-fixes-2020-02-21
X-PR-Tracked-Commit-Id: 97d9a4e9619a822c5baf6a63e6f5b80fee4d4213
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 88f8bbfa94ce18eff7b322256ec4b5f885dea969
Message-Id: <158231941769.18249.16730626184494486901.pr-tracker-bot@kernel.org>
Date:   Fri, 21 Feb 2020 21:10:17 +0000
To:     Dave Airlie <airlied@gmail.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 21 Feb 2020 15:52:10 +1000:

> git://anongit.freedesktop.org/drm/drm tags/drm-fixes-2020-02-21

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/88f8bbfa94ce18eff7b322256ec4b5f885dea969

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
