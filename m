Return-Path: <SRS0=EowN=3M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CBDA8C2D0DB
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jan 2020 19:30:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A124C2253D
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jan 2020 19:30:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1579807808;
	bh=SWo2gUyR1xUO70txmovy7pGh9v+mr90IJdLa/NVY+qE=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=Z7HE+7PVBwzoaASn2LyTroP+BLlXtO8Cbz3TXydwmddiBDqrnhNEu8EU4BD/W+bXh
	 RViOAioVfWuIdqIA4Cu19mDoKx6TPt038iEGkHRCbQ6vYrVRzA7XYInjUiVhH8IsCs
	 4OH3+jbr0iOumooNfTUCYOFX9gWAP98PJxpuePTs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729117AbgAWTaH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Jan 2020 14:30:07 -0500
Received: from mail.kernel.org ([198.145.29.99]:39554 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729049AbgAWTaF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jan 2020 14:30:05 -0500
Subject: Re: [GIT PULL] Ceph fix for 5.5-rc8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1579807804;
        bh=SWo2gUyR1xUO70txmovy7pGh9v+mr90IJdLa/NVY+qE=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=eZrB2l2emXEfxDUNKqFIRdG4aQYRFhZ03LN6OnP9oA2EAQ9PD8+T71B3u9QDmzcmY
         0L1lT1HeKxFpiVVetAiO6wWmdK8X1Mbzn9J4HVHidw6oIXRTM90LlntszvhSxI/zUK
         D2pviJf28Zx/0EUp5uyqGldnwO8iPy8H4ZSwaoLg=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20200123173629.18402-1-idryomov@gmail.com>
References: <20200123173629.18402-1-idryomov@gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20200123173629.18402-1-idryomov@gmail.com>
X-PR-Tracked-Remote: https://github.com/ceph/ceph-client.git
 tags/ceph-for-5.5-rc8
X-PR-Tracked-Commit-Id: 9c1c2b35f1d94de8325344c2777d7ee67492db3b
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: fa0a4e3b541257da515def87b84529b3bfd08119
Message-Id: <157980780443.24133.15906527136972515422.pr-tracker-bot@kernel.org>
Date:   Thu, 23 Jan 2020 19:30:04 +0000
To:     Ilya Dryomov <idryomov@gmail.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        ceph-devel@vger.kernel.org, linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Thu, 23 Jan 2020 18:36:29 +0100:

> https://github.com/ceph/ceph-client.git tags/ceph-for-5.5-rc8

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/fa0a4e3b541257da515def87b84529b3bfd08119

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
