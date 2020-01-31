Return-Path: <SRS0=flzY=3U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD084C2D0DB
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Jan 2020 19:35:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9551D2082E
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Jan 2020 19:35:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1580499324;
	bh=IUMbiycIe1bt0rX1nc5L5vMe8l9p7Q4JvNaX6pAiDyc=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=pYGB2li6H6TLhDvLXeMBLIbpGFWfMuoHLqge5664i7+jGMCeCJO2Q9GsxwhlM+xx3
	 AF7gbhulToMbnHLiqJKAWZXZB+7dH95WZ0Kl1Qg5Ih0oyQPZ0cuSMuaSU7muoPdFjr
	 xqvxJ2hEZf89UD7m7SoEq86/X5bzMgUTszLBGTL8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727413AbgAaTfX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 Jan 2020 14:35:23 -0500
Received: from mail.kernel.org ([198.145.29.99]:55514 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727379AbgAaTfQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Jan 2020 14:35:16 -0500
Subject: Re: [GIT PULL] ARC updates for 5.6-rc1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1580499316;
        bh=IUMbiycIe1bt0rX1nc5L5vMe8l9p7Q4JvNaX6pAiDyc=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=HaGm7W2VBveiKRW9vCudVOvyVIpSHtI79LARltdq3D+bcbxV92qUNh0IqRyD2go5o
         24cKK9HnfNl8cUMdQT+gRh/aDZlWEb015z+S7AxZWiJggcetVCn3vFlasFHGoOiNBo
         G8S3E6xA5uxRPCDD0bsP5O+fcE2fjWrmn2yDcb7w=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <d709d1dc-69e8-3fcd-f790-8699ca6a4e04@synopsys.com>
References: <d709d1dc-69e8-3fcd-f790-8699ca6a4e04@synopsys.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <d709d1dc-69e8-3fcd-f790-8699ca6a4e04@synopsys.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/vgupta/arc.git/
 tags/arc-5.6-rc1
X-PR-Tracked-Commit-Id: f45ba2bd6da0dc8000aa7ea7a3858fb51608f766
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: b7e573bb4a7a511741f8942b1fb03cfe602ee57f
Message-Id: <158049931650.14867.17056834872077409001.pr-tracker-bot@kernel.org>
Date:   Fri, 31 Jan 2020 19:35:16 +0000
To:     Vineet Gupta <Vineet.Gupta1@synopsys.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        arcml <linux-snps-arc@lists.infradead.org>,
        lkml <linux-kernel@vger.kernel.org>,
        Jose Abreu <Jose.Abreu@synopsys.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 31 Jan 2020 17:43:34 +0000:

> git://git.kernel.org/pub/scm/linux/kernel/git/vgupta/arc.git/ tags/arc-5.6-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/b7e573bb4a7a511741f8942b1fb03cfe602ee57f

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
