Return-Path: <SRS0=BhYR=34=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D18B3C35242
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Feb 2020 22:35:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A884A22B48
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Feb 2020 22:35:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1581201344;
	bh=uoy4aMayMWm+cmGu2cQq5t8+/Xttsr8RpTy/J72Vp7M=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=dChBRgj+hXr5Qo3S+k/zXHSoiVpCTRjkP4l11W72hlHUD2JgNz6CJTmYbKCGZiEHT
	 9PwkYAJqmK8pGKPr7Fd03s66sTyn4rFEqHUuL1WE8u9Jcc2jRmigMpvnwfVVH0v2Cp
	 y69liITHq0m6oahzMdZ5sVwM1UPgcAfKs+qVA2fI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727769AbgBHWfn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 8 Feb 2020 17:35:43 -0500
Received: from mail.kernel.org ([198.145.29.99]:56946 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727639AbgBHWf2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Feb 2020 17:35:28 -0500
Subject: Re: [GIT PULL 2/5] ARM: Device-tree updates
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1581201328;
        bh=uoy4aMayMWm+cmGu2cQq5t8+/Xttsr8RpTy/J72Vp7M=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=ypVEx9saVK6+d9fc/8AA4kLOvr3/99TuXImYTVWLO1xiX611vEKkGRtckdciSaQpC
         g8cZUzvIMW/egw2odlwQ7GJNDhbcN228OqgTM7aJruSkgZcAFkU+V/hB2uT2Xr48qk
         tm0vuDVpE/HgnnvUXlT+KsoUR8bj6pEiGiKeZmEQ=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20200208112018.29819-3-olof@lixom.net>
References: <20200208112018.29819-1-olof@lixom.net>
 <20200208112018.29819-3-olof@lixom.net>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20200208112018.29819-3-olof@lixom.net>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/soc/soc.git tags/armsoc-dt
X-PR-Tracked-Commit-Id: d030a0dd01306d45569c6a4449dee603f994744a
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 1afa9c3b7c9bdcb562e2afe9f58cc99d0b071cdc
Message-Id: <158120132832.28764.5136893287459921934.pr-tracker-bot@kernel.org>
Date:   Sat, 08 Feb 2020 22:35:28 +0000
To:     Olof Johansson <olof@lixom.net>
Cc:     torvalds@linux-foundation.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, arm@kernel.org,
        soc@kernel.org, Olof Johansson <olof@lixom.net>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sat,  8 Feb 2020 03:20:15 -0800:

> git://git.kernel.org/pub/scm/linux/kernel/git/soc/soc.git tags/armsoc-dt

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/1afa9c3b7c9bdcb562e2afe9f58cc99d0b071cdc

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
