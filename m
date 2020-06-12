Return-Path: <SRS0=ixK5=7Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF77DC433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Jun 2020 19:26:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CCA0B2083E
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Jun 2020 19:26:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1591989961;
	bh=BEnJrzqvMuYpXAMpphS0j5QS8iaksoh4GLbaBhcMbAI=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=GrP7TfIVMRI/Ca4Z8ShBKlf3c02uVo6Z8mdL1GUwSv+wpH1LRojv2qWPEJHiUQpTU
	 QUiNE7MiVO+ggvlvSeZCCyoURm6FmSOHztSsSuP0zS2nxLdjUV3F1lmuy6FWr8BDoO
	 fF216v+3fGTkKT/K560smJ15tNaNjFYxOWNKTdPQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726576AbgFLTZ7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Jun 2020 15:25:59 -0400
Received: from mail.kernel.org ([198.145.29.99]:36888 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726460AbgFLTZc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Jun 2020 15:25:32 -0400
Subject: Re: [git pull] iommu: Move Intel and AMD drivers to a subdirectory
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1591989932;
        bh=BEnJrzqvMuYpXAMpphS0j5QS8iaksoh4GLbaBhcMbAI=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=uXFNm8u3IEk9U3bVwC76ryJ5Aem1ysPI9bgyMzCZsFGJRtWgC0GclObvluj5IvSZJ
         ssgg2abB08g8J4z8Ycl8q59EcFw15niVYrJtts+fomyw1IHT11n6qoyj0I1UaLsPHD
         FW7yPVB4HenhPP3gZpPyu0KgnvJgoENbvhWZKjgE=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20200612152205.GA18833@8bytes.org>
References: <20200612152205.GA18833@8bytes.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20200612152205.GA18833@8bytes.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/joro/iommu.git
 tags/iommu-drivers-move-v5.8
X-PR-Tracked-Commit-Id: 672cf6df9b8a3a6d70a6a5c30397f76fa40d3178
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 8f02f363f76f99f08117336cfac7f24c76b25be3
Message-Id: <159198993250.4050.3240312078488270067.pr-tracker-bot@kernel.org>
Date:   Fri, 12 Jun 2020 19:25:32 +0000
To:     Joerg Roedel <joro@8bytes.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 12 Jun 2020 17:22:10 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/joro/iommu.git tags/iommu-drivers-move-v5.8

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/8f02f363f76f99f08117336cfac7f24c76b25be3

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
