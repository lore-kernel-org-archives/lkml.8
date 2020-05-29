Return-Path: <SRS0=LUA0=7L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A51BEC433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 29 May 2020 21:10:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7305A2073B
	for <linux-kernel@archiver.kernel.org>; Fri, 29 May 2020 21:10:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1590786615;
	bh=C7jau0IuCea6Jhmahys1JOe9wMqgN9X0IW0uelXub2s=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=p0Z7xi6dr4j4gkmnbHjgK/6bRqSL5X4T3Wvy3wrGCKDx9m5X0rWIsAAav4vJ4D6XW
	 rzs6E2kq+m429UwdIpbfKocxEqSh4pjKQ7y9hftteHxrB1KZ1bDQglR2JFVFoZGrwj
	 4DX7qON5ZsfngSWvEbF8ErPVLo/mvRMDtnfwWH7M=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728433AbgE2VKO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 May 2020 17:10:14 -0400
Received: from mail.kernel.org ([198.145.29.99]:33716 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728361AbgE2VKG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 May 2020 17:10:06 -0400
Subject: Re: [git pull] IOMMU Fixes for Linux v5.7-rc7
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1590786606;
        bh=C7jau0IuCea6Jhmahys1JOe9wMqgN9X0IW0uelXub2s=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=BajMhUzt+DWyBJTRzbJNuS+6Cc6mQ0POB5RIIz4hxa6CdVbas8N/jnfMBg7SxIzPR
         a/zPSwHdocuG8SoHiNGjKv3s46bpeUriTedArPOKM3MRGS6rAEDRWozJqMcQXEAPdi
         IgK3d0In3U59v4tRA2ilTGshf/k5B9ikJZ7VfIzE=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20200529185836.GA31964@8bytes.org>
References: <20200529185836.GA31964@8bytes.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20200529185836.GA31964@8bytes.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/joro/iommu.git
 tags/iommu-fixes-v5.7-rc7
X-PR-Tracked-Commit-Id: 7cc31613734c4870ae32f5265d576ef296621343
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: b58f2140ea8605ee6ea0530d9c0cb5d049f9c7ca
Message-Id: <159078660639.32003.3784639971506990928.pr-tracker-bot@kernel.org>
Date:   Fri, 29 May 2020 21:10:06 +0000
To:     Joerg Roedel <joro@8bytes.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 29 May 2020 20:58:41 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/joro/iommu.git tags/iommu-fixes-v5.7-rc7

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/b58f2140ea8605ee6ea0530d9c0cb5d049f9c7ca

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
