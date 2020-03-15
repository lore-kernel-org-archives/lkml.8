Return-Path: <SRS0=iqK9=5A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD2EEC10DCE
	for <linux-kernel@archiver.kernel.org>; Sun, 15 Mar 2020 20:25:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A6A9120736
	for <linux-kernel@archiver.kernel.org>; Sun, 15 Mar 2020 20:25:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1584303908;
	bh=eiuLjTM0H7dwvn819pmsnMr/lPvShNx1pDwdSrAXyRQ=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=KUECFCfxaZQENEdvIsAQNTVQ49kCU0IiwYk77FtGGe1miVlr9jsiJYzrxG8BtV3OT
	 EhNyRDWXoywaZLLijJQnWfwZDZYNTeIIHdb0vmuHw6sVqUVjX5yuWvEyI0/l0yO/3Z
	 OLkiaxZJitXRM5gnEz3YcAVrWpsxjv6m6YgiB5W4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729162AbgCOUZH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 15 Mar 2020 16:25:07 -0400
Received: from mail.kernel.org ([198.145.29.99]:45594 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729149AbgCOUZH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 Mar 2020 16:25:07 -0400
Subject: Re: [git pull] IOMMU Fixes for Linux v5.6-rc5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1584303906;
        bh=eiuLjTM0H7dwvn819pmsnMr/lPvShNx1pDwdSrAXyRQ=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=N1thktkZN0Da+XmJMgGqEbwh6qedl5hyY8gzb5T3LArQIyhhDrzfVz8frkUI9LnVr
         Rhz+OuK6CceQHZYPD1NIXSrtsxPr8s3jw3NJiSMx6ud2TFGW0JwchOisx7s/BPY9v/
         emu3Fa0mFlRe2bINEcXCOIeMHo7yBAVMc4F4r12Y=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20200315091602.GA18173@8bytes.org>
References: <20200315091602.GA18173@8bytes.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20200315091602.GA18173@8bytes.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/joro/iommu.git
 tags/iommu-fixes-v5.6-rc5
X-PR-Tracked-Commit-Id: 1da8347d8505c137fb07ff06bbcd3f2bf37409bc
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: de28a65cd0e39d031dfcdc61fbe06268cb4a5f94
Message-Id: <158430390668.13594.6670059982592088397.pr-tracker-bot@kernel.org>
Date:   Sun, 15 Mar 2020 20:25:06 +0000
To:     Joerg Roedel <joro@8bytes.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sun, 15 Mar 2020 10:16:10 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/joro/iommu.git tags/iommu-fixes-v5.6-rc5

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/de28a65cd0e39d031dfcdc61fbe06268cb4a5f94

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
