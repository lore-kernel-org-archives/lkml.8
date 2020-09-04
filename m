Return-Path: <SRS0=2gBQ=CN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD389C43461
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Sep 2020 20:49:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 77E9120C09
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Sep 2020 20:49:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1599252585;
	bh=WA4QnPIUDLP9jjk6EAN0u6tHYjm6avKgW2vvGvBtzEw=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=o8B+F23xOi1e1P4uyT7gBFKmluOf3dURz92rE8e6bNzDXFNKV5UNJnxw+RjzBhT2j
	 1QIXCq5xiaEtcmlJbZSFgBDan473dsEMOEGL5qy3OT4h/Ln3PE0rLzZ+pFVUx7pobj
	 mv+hHoGfpWyvAZkVzF6O6IgGu0kyFGoaNRu5vvi8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727916AbgIDUto (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 4 Sep 2020 16:49:44 -0400
Received: from mail.kernel.org ([198.145.29.99]:33378 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728197AbgIDUtg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Sep 2020 16:49:36 -0400
Subject: Re: [GIT PULL]: dmaengine fixes for v5.9-rc4
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1599252575;
        bh=WA4QnPIUDLP9jjk6EAN0u6tHYjm6avKgW2vvGvBtzEw=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=PLMqKFNjliW+YdI9Nq0dqA7e+8IfPO4LJbjw8GIHqdYzUDYYNvkH2p4swnT0iYOfI
         CrVXVTFvjB0zTAybCjnuWWkyU5fba5lgazBlENlhk9Pci0zewWpZLwkL0VB+1kXSpa
         UZkZA44Rs3yu9QIZD86BlGvNFAump9uQEavMCR/o=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20200904102433.GB2639@vkoul-mobl>
References: <20200904102433.GB2639@vkoul-mobl>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20200904102433.GB2639@vkoul-mobl>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/vkoul/dmaengine.git tags/dmaengine-fix-5.9-rc4
X-PR-Tracked-Commit-Id: 46815bf4d5a2e6ed64e4fa636c7d13f025bf40d8
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: e2dacf6cd13c1f8d40a59fdda41ecd139c2207df
Message-Id: <159925257588.25529.1850922214887955186.pr-tracker-bot@kernel.org>
Date:   Fri, 04 Sep 2020 20:49:35 +0000
To:     Vinod Koul <vkoul@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 4 Sep 2020 15:54:33 +0530:

> git://git.kernel.org/pub/scm/linux/kernel/git/vkoul/dmaengine.git tags/dmaengine-fix-5.9-rc4

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/e2dacf6cd13c1f8d40a59fdda41ecd139c2207df

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
