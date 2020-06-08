Return-Path: <SRS0=Cjtw=7V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7679AC433DF
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jun 2020 00:35:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4CA8720774
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jun 2020 00:35:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1591576541;
	bh=YqXIFIAjqJbxE2m06PeW1zEwda5QmyEskXknR0AK2tc=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=m8NcwFOZMWwvkKKx4ZRL2ksYpvzK1U1vGcYrA3u/FW3tFUtHhZGhF515fkVlhboqY
	 Q6HD1TlmGWuxaLhYm3A0FoO865goKMy9gtuqca3acO8tCnJzYbmIFo8D1JXjNohdl0
	 5ANaYGa+y1kuhsJZKMQbppprFUWiB2TRxtx0I56M=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728243AbgFHAf0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 7 Jun 2020 20:35:26 -0400
Received: from mail.kernel.org ([198.145.29.99]:58892 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727965AbgFHAfY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 7 Jun 2020 20:35:24 -0400
Subject: Re: [GIT] Networking
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1591576523;
        bh=YqXIFIAjqJbxE2m06PeW1zEwda5QmyEskXknR0AK2tc=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=dCe0pb9wN4IXgb9qBXV8M5woV7pEWFDS/3zBk770qQy7SjJlLUDbzoeoO1G/qX1FK
         JZG5/vWd/Ng1ejmbEtt9lr4Lh9u4otySGuM4niHA6iyUr7YUVZcSWcT91btOWnLsbU
         hUk8+gR0DNMFYxl8f8V4IW3km1aH/ONYbgMz14PM=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20200607.172143.1367434746586532493.davem@davemloft.net>
References: <20200607.172143.1367434746586532493.davem@davemloft.net>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20200607.172143.1367434746586532493.davem@davemloft.net>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net
 refs/heads/master
X-PR-Tracked-Commit-Id: 4d3da2d8d91f66988a829a18a0ce59945e8ae4fb
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: af7b4801030c07637840191c69eb666917e4135d
Message-Id: <159157652386.5945.6745030865102165967.pr-tracker-bot@kernel.org>
Date:   Mon, 08 Jun 2020 00:35:23 +0000
To:     David Miller <davem@davemloft.net>
Cc:     torvalds@linux-foundation.org, akpm@linux-foundation.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sun, 07 Jun 2020 17:21:43 -0700 (PDT):

> git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net refs/heads/master

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/af7b4801030c07637840191c69eb666917e4135d

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
