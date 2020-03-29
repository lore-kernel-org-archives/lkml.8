Return-Path: <SRS0=I467=5O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19B14C43331
	for <linux-kernel@archiver.kernel.org>; Sun, 29 Mar 2020 02:05:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DEF1F20723
	for <linux-kernel@archiver.kernel.org>; Sun, 29 Mar 2020 02:05:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1585447508;
	bh=sGGF1qpIVGtH7JOkMnEUSTR6IqlLrRGRMdtQfBPtb54=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=beP8h647H44FuERPWd6YlWIg87izPJQefx//xzQjhjxVaMCAtDGBdM2K9XwcdIDOv
	 qA8tU+D33N6UWhBtg2hFrw3bbq0WChzZ51PETS4v2dR2SJKmfXg4gszrd+2WOHQtKP
	 Me51QAkmijAevoHiyZojI+ygx0Yr5HF43uqafzBY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727173AbgC2CFH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 28 Mar 2020 22:05:07 -0400
Received: from mail.kernel.org ([198.145.29.99]:37350 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726449AbgC2CFH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 Mar 2020 22:05:07 -0400
Subject: Re: [GIT] Networking
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1585447507;
        bh=sGGF1qpIVGtH7JOkMnEUSTR6IqlLrRGRMdtQfBPtb54=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=VbLJUWnV1BwXYvzjv3YrdZsKok/fxISXnPcL4oxnraf51w+sD/QzrXNePLz7wKmSS
         ZbsW3/Ro/bQZ6G/i77MzSvTidS9pqPVPywNoZ4VHGVXO1n4H1zREqMm0xaQgcVIi4I
         M0I5jFCB3Yt+Lt+Kolc1S75adNfE0mnNdYcZPJ70=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20200328.183923.1567579026552407300.davem@davemloft.net>
References: <20200328.183923.1567579026552407300.davem@davemloft.net>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20200328.183923.1567579026552407300.davem@davemloft.net>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net.git
 refs/heads/master
X-PR-Tracked-Commit-Id: a0ba26f37ea04e025a793ef5e5ac809221728ecb
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: e595dd94515ed6bc5ba38fce0f9598db8c0ee9a9
Message-Id: <158544750697.14300.9472742816968297242.pr-tracker-bot@kernel.org>
Date:   Sun, 29 Mar 2020 02:05:06 +0000
To:     David Miller <davem@davemloft.net>
Cc:     torvalds@linux-foundation.org, akpm@linux-foundation.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sat, 28 Mar 2020 18:39:23 -0700 (PDT):

> git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net.git refs/heads/master

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/e595dd94515ed6bc5ba38fce0f9598db8c0ee9a9

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
