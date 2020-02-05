Return-Path: <SRS0=fqu/=3Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2AFE8C35247
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Feb 2020 18:20:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 04910218AC
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Feb 2020 18:20:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1580926817;
	bh=5MdfsOEP1cuD67baLfn1RYNv9TYnFHGGZioa9T++I1s=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=b8hT2862Gn96ToT1iN20k+uoOx3NBrBdg/ln9q938MXNIoAhIK5OaQ+q147ktUgL5
	 tjj0NKj/lCcY8m5wOQsW+YOBgIiDewYNGNDAopgjoUo9qFdD+UcgDl57pXRrI7lvBv
	 OJVH7Pynhu2vtLliqsO3eWFEijE9gbZNuB9gKIzI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727662AbgBESUQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Feb 2020 13:20:16 -0500
Received: from mail.kernel.org ([198.145.29.99]:51778 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727486AbgBESUP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Feb 2020 13:20:15 -0500
Subject: Re: [git pull] IOMMU Updates for Linux v5.6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1580926814;
        bh=5MdfsOEP1cuD67baLfn1RYNv9TYnFHGGZioa9T++I1s=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=VFyJQaimHAuTL40lIjjoWNNwukvIpXw9dAvUWhW5f7ZomT8LpfKFIsSFmJSEkAFxf
         Rr6536VEThFVZrrRVPwbzZFcQRJRUI3vqQZtn8ljLO4p/rAGy0gfYc/j5j64zeNbTN
         2r6TTL85yaYYIcQQq/HDmXAr1nlLy1XvhAfDEifM=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20200205140344.GA32375@8bytes.org>
References: <20200205140344.GA32375@8bytes.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20200205140344.GA32375@8bytes.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/joro/iommu.git
 tags/iommu-updates-v5.6
X-PR-Tracked-Commit-Id: e3b5ee0cfb65646f4a915643fe53e0a51829d891
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 4fc2ea6a8608d9a649eff5e3c2ee477eb70f0fb6
Message-Id: <158092681483.14135.11118001152469103340.pr-tracker-bot@kernel.org>
Date:   Wed, 05 Feb 2020 18:20:14 +0000
To:     Joerg Roedel <joro@8bytes.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Wed, 5 Feb 2020 15:03:54 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/joro/iommu.git tags/iommu-updates-v5.6

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/4fc2ea6a8608d9a649eff5e3c2ee477eb70f0fb6

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
