Return-Path: <SRS0=sqqi=7C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 025B8C433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 20 May 2020 19:30:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D507F20709
	for <linux-kernel@archiver.kernel.org>; Wed, 20 May 2020 19:30:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1590003003;
	bh=L28mxoLEiKKvTNlDautC1Ytl5LwVJQDq1/2fiDMtl64=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=UP2YHzJwX1Cl1t2FCiio33cnOqgsMPsNc0LAuxSRs6UJOnmGFC2f8HnNGLeo5nT+n
	 A7uDmwvMvVc6jC3plL9+H3GvsqdAfbbjBqQhBFXLgCzKCa0M9iPQ1x3Hqop+XfiiFH
	 aUAS7N4OWbZ5Byx5Y6ksHCq+Qku5U3BCwe3mmsoI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726837AbgETTaD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 May 2020 15:30:03 -0400
Received: from mail.kernel.org ([198.145.29.99]:40536 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726548AbgETTaC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 May 2020 15:30:02 -0400
Subject: Re: [GIT PULL] overlayfs fixes for 5.7-rc7
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1590003002;
        bh=L28mxoLEiKKvTNlDautC1Ytl5LwVJQDq1/2fiDMtl64=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=bB7C4iekUxPfRxttYqQZmJ3enjc0cKOCSNoHhPx9nN6GoaDA7+O9NiVXyitBQqhIa
         JiNqpI2Nw2n7zOjBj/eOfSWqA0pMAoA+Rvz32HgCVRL9vDGovr+VEON0mU6xH5yxbe
         Sxg7RnvidWwkEE1WNgw8T6h9wsjqsDJenX8uL2vM=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20200520142537.GD13131@miu.piliscsaba.redhat.com>
References: <20200520142537.GD13131@miu.piliscsaba.redhat.com>
X-PR-Tracked-List-Id: <linux-fsdevel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20200520142537.GD13131@miu.piliscsaba.redhat.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/mszeredi/vfs.git
 tags/ovl-fixes-5.7-rc7
X-PR-Tracked-Commit-Id: 9aafc1b0187322fa4fd4eb905d0903172237206c
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 8e2b7f634a851fb711a7e693e00905fc6c05b74b
Message-Id: <159000300246.7201.15233334499752091112.pr-tracker-bot@kernel.org>
Date:   Wed, 20 May 2020 19:30:02 +0000
To:     Miklos Szeredi <miklos@szeredi.hu>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-unionfs@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Wed, 20 May 2020 16:25:37 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/mszeredi/vfs.git tags/ovl-fixes-5.7-rc7

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/8e2b7f634a851fb711a7e693e00905fc6c05b74b

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
