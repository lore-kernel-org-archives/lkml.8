Return-Path: <SRS0=8dav=5Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81611C2BA80
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Apr 2020 03:20:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 55B3B2075E
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Apr 2020 03:20:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1586316031;
	bh=L+DIR3jC8US59W13pYHZK12GXHZNxn69pA7DhvFn20s=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=DRXKljNf3rpS4KlRZl2IGbUtkR2ry9aKrEgzTxAQjk4xTov2RD0gzrJQwZ3rpyQj6
	 7ijlLiP7YoKB2F5556fVBsifGC5awmclXt1Std7rIIjxUxxyVgUrryjk2M/lP7Gq3D
	 K2w/PiWBgTT2aS6m8ZR+uRPOOYDxOmE9e+OP71AA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726578AbgDHDUa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Apr 2020 23:20:30 -0400
Received: from mail.kernel.org ([198.145.29.99]:34696 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726437AbgDHDU3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Apr 2020 23:20:29 -0400
Subject: Re: [GIT PULL] Backlight for v5.7
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1586316028;
        bh=L+DIR3jC8US59W13pYHZK12GXHZNxn69pA7DhvFn20s=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=JO5Pr/hYLRczO39LoJKDNq/8QpZrZAdf6jVS50dEDa3PuCkYPT5oxT8pVOSAH/lgf
         yjib5J85AXiyrznAu2As8EoOUoLdYIRirUCL4kSvKRx7vdGIPm5It4DEVvZkhbke+L
         qYOVeYEvIh3zFAEuBAgqnKLyzunyPJpuMtm8/QL8=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20200407094021.GG30614@dell>
References: <20200407094021.GG30614@dell>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20200407094021.GG30614@dell>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/lee/backlight.git
 backlight-next-5.7
X-PR-Tracked-Commit-Id: ee0c8e494cc3c135350cd5c4752e82af3feae1ab
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: b574beb6257a21c231a6c2c272a0aeb84b655437
Message-Id: <158631602854.18814.11571076639940543407.pr-tracker-bot@kernel.org>
Date:   Wed, 08 Apr 2020 03:20:28 +0000
To:     Lee Jones <lee.jones@linaro.org>
Cc:     torvalds@linux-foundation.org, linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Tue, 7 Apr 2020 10:40:21 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/lee/backlight.git backlight-next-5.7

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/b574beb6257a21c231a6c2c272a0aeb84b655437

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
