Return-Path: <SRS0=ne2O=7T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0133EC433E0
	for <linux-kernel@archiver.kernel.org>; Sat,  6 Jun 2020 17:15:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D55782067B
	for <linux-kernel@archiver.kernel.org>; Sat,  6 Jun 2020 17:15:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1591463717;
	bh=hvG55LaXo/IMf3DM80rTa78o0nrlJRathGCSMBEJC2U=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=n90SSpZoS1NtIm6a4r8+ZhFaEKnRH3cr4rhS8pw1IoAL1lxR12YjNEc7AqaTwbj5f
	 ATnd+CVHz/DFlk4SKY7V15LMlyyzW+jTLbySWrfALda0F3gsxDEsoT2bZT36sSLUaH
	 gqGoZ6mt+2+f95zYPXigCbAKddX2hPaxioN0ZUVc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728863AbgFFRPR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 6 Jun 2020 13:15:17 -0400
Received: from mail.kernel.org ([198.145.29.99]:39310 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728844AbgFFRPP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 6 Jun 2020 13:15:15 -0400
Subject: Re: [GIT PULL] cgroup changes for v5.8-rc1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1591463715;
        bh=hvG55LaXo/IMf3DM80rTa78o0nrlJRathGCSMBEJC2U=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=JFYmQyePdV5uhcpGz4azvtwZiYPWgHD4v3jCgPPe39fL8mNmw9vVQjou0H8IoDXwS
         ISWprOyn+KOZEW0M2UalL8OivWdekpSgK4M7uSDiBdvLbvTUsp0Oe0Evh8y/5hHCEV
         3rXVUgd+5fhrqY13ZDGCd2UZvHARpkSMstylNi/8=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20200605200601.GJ31548@mtj.thefacebook.com>
References: <20200605200601.GJ31548@mtj.thefacebook.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20200605200601.GJ31548@mtj.thefacebook.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tj/cgroup.git for-5.8
X-PR-Tracked-Commit-Id: 936f2a70f2077f64fab1dcb3eca71879e82ecd3f
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 4a7e89c5ec0238017a757131eb9ab8dc111f961c
Message-Id: <159146371502.31751.904509182514760412.pr-tracker-bot@kernel.org>
Date:   Sat, 06 Jun 2020 17:15:15 +0000
To:     Tejun Heo <tj@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, cgroups@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 5 Jun 2020 16:06:01 -0400:

> git://git.kernel.org/pub/scm/linux/kernel/git/tj/cgroup.git for-5.8

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/4a7e89c5ec0238017a757131eb9ab8dc111f961c

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
