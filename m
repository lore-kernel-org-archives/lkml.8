Return-Path: <SRS0=pQss=CP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C3ABC43461
	for <linux-kernel@archiver.kernel.org>; Sun,  6 Sep 2020 19:14:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 11CF02080A
	for <linux-kernel@archiver.kernel.org>; Sun,  6 Sep 2020 19:14:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1599419657;
	bh=vSn4eQZTLFvGD2Hp/EuDAxGBxkMT9Wrn9dnzb9lh6is=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=Ik5bAh+Wb9dIljzeNcWvMb22sRylJldVVGe/Rlgo/QYMBR+pUlsFfC7xYJ3Jz10ol
	 ztR2X8nNNIkyi3iSgu551VOoRKMTRnbfvj0TtZmxc4ypK4CZ1PAMBvslfJpA9ZV7QQ
	 +X+3aO7zqOdARk7nSH/uKEP+E0Un+qolZGI0cVfQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726367AbgIFTOP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 6 Sep 2020 15:14:15 -0400
Received: from mail.kernel.org ([198.145.29.99]:41198 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725773AbgIFTOO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Sep 2020 15:14:14 -0400
Subject: Re: [git pull] IOMMU Fixes for Linux v5.9-rc3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1599419653;
        bh=vSn4eQZTLFvGD2Hp/EuDAxGBxkMT9Wrn9dnzb9lh6is=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=Mt68C0cMN82Nu7ftQj5E7RaRDxet4fZ0NMDqQiGIJy/SyRVCNsR2jDevqk2MQYZh2
         YXj15dM4S5znHlVQgeV/g+xNrZ+Vq2FAKd8Ru/5JYXa2UzWhj/3RJYPq09n+royksa
         kcGssYnX2s89TLa8jpYM7Tek+E7rgUE6BCcbAieA=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20200906150115.GA29365@8bytes.org>
References: <20200906150115.GA29365@8bytes.org>
X-PR-Tracked-List-Id: Development issues for Linux IOMMU support
 <iommu.lists.linux-foundation.org>
X-PR-Tracked-Message-Id: <20200906150115.GA29365@8bytes.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/joro/iommu.git tags/iommu-fixes-v5.9-rc3
X-PR-Tracked-Commit-Id: 29aaebbca4abc4cceb38738483051abefafb6950
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 2ccdd9f8b2ce7290aad6f0a34200ad394e61f940
Message-Id: <159941965380.19439.4825563684088118188.pr-tracker-bot@kernel.org>
Date:   Sun, 06 Sep 2020 19:14:13 +0000
To:     Joerg Roedel <joro@8bytes.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sun, 6 Sep 2020 17:01:20 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/joro/iommu.git tags/iommu-fixes-v5.9-rc3

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/2ccdd9f8b2ce7290aad6f0a34200ad394e61f940

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
