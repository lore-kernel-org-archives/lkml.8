Return-Path: <SRS0=z/zp=5X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D879C2D0EC
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Apr 2020 19:55:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0D89420730
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Apr 2020 19:55:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1586289325;
	bh=ZKtUtUcLPY2Rnw+fGZW0MOHZxsF/t0ZHV6+DHbpeYPQ=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=CAva4B0cndT1yEOk9rHYdSxOrJZ5sFbdLYhq/Wnfw9QGXT3M6QObT9aAD7Hn2+3jl
	 K8J4Rk1FZpRcemrcum7uTCKTcyFv4o7U0LxOlnFY6K9mfDR67iBW928afDpylfbWDM
	 HEVE7NOdsjXJuRq0ddlfJ40V+yi3b1KiPCBX4dUE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727831AbgDGTzX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Apr 2020 15:55:23 -0400
Received: from mail.kernel.org ([198.145.29.99]:56436 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726712AbgDGTzX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Apr 2020 15:55:23 -0400
Subject: Re: [GIT] Networking
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1586289323;
        bh=ZKtUtUcLPY2Rnw+fGZW0MOHZxsF/t0ZHV6+DHbpeYPQ=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=oVpiUnHvKJ2HwrY8xneBAndldpccaQNa0ocdat2hFmpuURDEQx1NYcaGNwyOrBIxC
         cpWKZQr9SUj+D85DDl0dpT0P1ctZf7jAhcuuYr+adrDfRdQJ5Q1BP6R52NYtPJcVD1
         kLeTXyOxnFApimlxsB9r4cpI78bCX+mdQ46Fcu/4=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20200406.112258.20998915860758260.davem@davemloft.net>
References: <20200406.112258.20998915860758260.davem@davemloft.net>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20200406.112258.20998915860758260.davem@davemloft.net>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net.git
 refs/heads/master
X-PR-Tracked-Commit-Id: aa81700cf2326e288c9ca1fe7b544039617f1fc2
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 479a72c0c6d7c24aa8b8a0a467672b6a6bac5947
Message-Id: <158628932298.3792.2129697418644763415.pr-tracker-bot@kernel.org>
Date:   Tue, 07 Apr 2020 19:55:22 +0000
To:     David Miller <davem@davemloft.net>
Cc:     torvalds@linux-foundation.org, akpm@linux-foundation.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Mon, 06 Apr 2020 11:22:58 -0700 (PDT):

> git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net.git refs/heads/master

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/479a72c0c6d7c24aa8b8a0a467672b6a6bac5947

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
