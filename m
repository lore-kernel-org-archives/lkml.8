Return-Path: <SRS0=aBbL=CG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 476FEC433E6
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Aug 2020 19:58:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 19FEB20825
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Aug 2020 19:58:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1598644720;
	bh=pLb6YgNF7r3bbleGDfeo95EUv/ZD6PP1am1Rc1qaHEw=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=rcUz3o75nl9wArYystZFTMtokE3GcPLp/vFLUVG+mrN9PHmLTuRlWck6U51j7QTBj
	 w9vcQgPBO1E0+BG6FGUCmcOIcC4IxIpfbXDup8f/JMlIdmPuLvmPGXvkQBVDjG8YII
	 pqGVECL7BV8FxgdNPEVGcP+yiJQ/Nk6pWbMzocqU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726236AbgH1T6i (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Aug 2020 15:58:38 -0400
Received: from mail.kernel.org ([198.145.29.99]:34256 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726828AbgH1T61 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Aug 2020 15:58:27 -0400
Subject: Re: [GIT PULL] Ceph fixes for 5.9-rc3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598644706;
        bh=pLb6YgNF7r3bbleGDfeo95EUv/ZD6PP1am1Rc1qaHEw=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=WNvieWsCHkjhFMxOAq++arN8DhylzssYhW26Fj96bVvW26MLd245Oz5UK02GI6/3Q
         zKRoP9cnjWUoT7IjZFzj235T+B1sZ6DavFmGS76K3wgwL2X90vI+xq4+dcfKSWTKgP
         DjY9dGLd6gE69OGLrJDNvuhRHNsi5wTDDTKZxETo=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20200828122000.1422-1-idryomov@gmail.com>
References: <20200828122000.1422-1-idryomov@gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20200828122000.1422-1-idryomov@gmail.com>
X-PR-Tracked-Remote: https://github.com/ceph/ceph-client.git tags/ceph-for-5.9-rc3
X-PR-Tracked-Commit-Id: 496ceaf12432b3d136dcdec48424312e71359ea7
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: b0bfd5eca956c498b8f9c7ec4a25f355f793f24e
Message-Id: <159864470692.31636.7304735457148606684.pr-tracker-bot@kernel.org>
Date:   Fri, 28 Aug 2020 19:58:26 +0000
To:     Ilya Dryomov <idryomov@gmail.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        ceph-devel@vger.kernel.org, linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 28 Aug 2020 14:20:00 +0200:

> https://github.com/ceph/ceph-client.git tags/ceph-for-5.9-rc3

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/b0bfd5eca956c498b8f9c7ec4a25f355f793f24e

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
