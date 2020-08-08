Return-Path: <SRS0=uMsS=BS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1E4BC433E0
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Aug 2020 21:19:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B0736206CD
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Aug 2020 21:19:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1596921572;
	bh=3G/EeJst0qFvsObv1xDyvL7ARoopzfQjTIVwYiGm2CM=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=r/9jT70/1Q13oGDCNflYUmk0xg0CrtxieHFCGMwGIHPIQlvawi8vCHYRqbGMvOSdv
	 /4qzhuuxjcTJWHqLtreps88RghyGXAwdCKK6Esv5OT3CHTkR31zCM3+2KgGRqnw7+9
	 5ZLPpu4eQPN8JP+v5+fssobTo28lQFFL39NT/UqE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726400AbgHHVTb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 8 Aug 2020 17:19:31 -0400
Received: from mail.kernel.org ([198.145.29.99]:52260 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726069AbgHHVTa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Aug 2020 17:19:30 -0400
Subject: Re: [GIT PULL] arm64 fix for 5.9-rc1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1596921570;
        bh=3G/EeJst0qFvsObv1xDyvL7ARoopzfQjTIVwYiGm2CM=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=yqcEs0oNhISq4K4Icd1VtolHk8ohy4B8ohwcmVS4XL6QE5uIqWG9b0pj1SP5Q484z
         iGSW+w4/1Mr99H20wswAYS55ykyKoZbTrQifeeL+OBes3vvQ9/Pk6Dwvr2II3XYxWf
         iSsvuQlimE66g3T28i2pAEMizY7t1x0pz5Ot9fOI=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20200808205312.565-1-catalin.marinas@arm.com>
References: <20200808205312.565-1-catalin.marinas@arm.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20200808205312.565-1-catalin.marinas@arm.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux tags/arm64-fixes
X-PR-Tracked-Commit-Id: eaecca9e7710281be7c31d892c9f447eafd7ddd9
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 06a81c1c7db9bd5de0bd38cd5acc44bb22b99150
Message-Id: <159692157033.31144.5696354639295452320.pr-tracker-bot@kernel.org>
Date:   Sat, 08 Aug 2020 21:19:30 +0000
To:     Catalin Marinas <catalin.marinas@arm.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Will Deacon <will@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sat,  8 Aug 2020 21:53:12 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux tags/arm64-fixes

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/06a81c1c7db9bd5de0bd38cd5acc44bb22b99150

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
