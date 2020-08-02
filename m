Return-Path: <SRS0=HA/2=BM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59CF5C433E1
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Aug 2020 00:00:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 31D622086A
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Aug 2020 00:00:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1596326416;
	bh=yMDYNeNyapT8XmtkK6J9+a9r1Iq85mz0E82nfOGPK6k=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=s/1j8W2YICTqOsgMtZ0XG4QQLlWE/zqfSzhIPosjYquhH331mQ2E1XRmF1h5uV7o8
	 Tb/j41xES2VsDnzpALakYoLW3A6i4LLUXDvH+lX9tRPIiFcldSx3FJx3+6nM8yUCba
	 w+f6aAFFDCJy+6MjwPsziENIGCImqPdKckrEHCVc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727976AbgHBAAL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 1 Aug 2020 20:00:11 -0400
Received: from mail.kernel.org ([198.145.29.99]:59646 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727893AbgHBAAF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Aug 2020 20:00:05 -0400
Subject: Re: [GIT] Networking
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1596326405;
        bh=yMDYNeNyapT8XmtkK6J9+a9r1Iq85mz0E82nfOGPK6k=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=y2EWJPfXEdmWTPCO9hhUxbHP1sPZ4B4uy8x5v3be1YqYqjpO96B5FednbMOaOgYZm
         BGSHzGkZ66NDrXOxVAZzAB1CgKFVxb+BFXFrfypp6ITrTDP/nEbVTFnxFIsbllQl9J
         gGhndCmGcxXwrQcYjeG6x5ESXnGawqHUhZklV+/c=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20200801.143631.1794965770015082550.davem@davemloft.net>
References: <20200801.143631.1794965770015082550.davem@davemloft.net>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20200801.143631.1794965770015082550.davem@davemloft.net>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net.git
 refs/heads/master
X-PR-Tracked-Commit-Id: fda2ec62cf1aa7cbee52289dc8059cd3662795da
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: ac3a0c8472969a03c0496ae774b3a29eb26c8d5a
Message-Id: <159632640514.16599.3256502942163300629.pr-tracker-bot@kernel.org>
Date:   Sun, 02 Aug 2020 00:00:05 +0000
To:     David Miller <davem@davemloft.net>
Cc:     torvalds@linux-foundation.org, akpm@linux-foundation.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sat, 01 Aug 2020 14:36:31 -0700 (PDT):

> git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net.git refs/heads/master

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/ac3a0c8472969a03c0496ae774b3a29eb26c8d5a

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
