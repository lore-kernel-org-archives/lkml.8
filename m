Return-Path: <SRS0=TsDl=7R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2EA39C433E0
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Jun 2020 18:25:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0FFE020663
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Jun 2020 18:25:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1591295135;
	bh=BVPv8lQfP6qdYDEuYVD1lhUdUCLeBy+ZRhuEhgd6NrY=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=Vsh+6ioLLDg2SKAKP7L6J9YGj0AKBryUoDExDVDgAl/DpkmoTC5cENxvRWVVw6m0v
	 dN75bco/n5a/ib0Sh+PsU88/4B/Q9PRFB61mRZ8bA85uBl8tGLnPEyhgZV1kE8iGQ2
	 OUG1B26TYFzHVR48bBAmXhzLjTMNQK4I6fL6tPbc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730892AbgFDSZe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Jun 2020 14:25:34 -0400
Received: from mail.kernel.org ([198.145.29.99]:44858 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730821AbgFDSZN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Jun 2020 14:25:13 -0400
Subject: Re: [GIT PULL] chrome-platform changes for v5.8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1591295113;
        bh=BVPv8lQfP6qdYDEuYVD1lhUdUCLeBy+ZRhuEhgd6NrY=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=z5gTiiqAE6PiLnAzobEG+cPhYuuAM05LRNuYMUCVkau41EmTunhK5kMFiLF/+tEyD
         SRHnwPtOZDQjjEKCSEP6dg8UMoRnT3OAltEzuHVq63kLcY+Stk6+2ALGJJ+ktkETm9
         doXJoVIpZlZ+d/HUKP8MjQVmNVUnL1tj98YmK2XQ=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20200604001441.GA257203@google.com>
References: <20200604001441.GA257203@google.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20200604001441.GA257203@google.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/chrome-platform/linux.git
 tags/tag-chrome-platform-for-v5.8
X-PR-Tracked-Commit-Id: bbb7ad49b8350b79261ce087c8e101d92f15533d
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 9875b201e05a8dfd107530853a0d021c8eea95d1
Message-Id: <159129511355.18772.2220816950683156445.pr-tracker-bot@kernel.org>
Date:   Thu, 04 Jun 2020 18:25:13 +0000
To:     Benson Leung <bleung@google.com>
Cc:     torvalds@linux-foundation.org, bleung@kernel.org,
        bleung@chromium.org, bleung@google.com,
        enric.balletbo@collabora.com, linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Wed, 3 Jun 2020 17:14:41 -0700:

> git://git.kernel.org/pub/scm/linux/kernel/git/chrome-platform/linux.git tags/tag-chrome-platform-for-v5.8

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/9875b201e05a8dfd107530853a0d021c8eea95d1

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
