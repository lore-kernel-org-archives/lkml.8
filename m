Return-Path: <SRS0=AKQz=7N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3CBA7C433DF
	for <linux-kernel@archiver.kernel.org>; Sun, 31 May 2020 18:05:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0A76D20810
	for <linux-kernel@archiver.kernel.org>; Sun, 31 May 2020 18:05:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1590948305;
	bh=4CRZa7JGRDtPrxJB3HXKHm8gh7sum89U5LPzt6xgYTM=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=pFbzXJkQs/0LQLAui8PowYZgDaJFuS3UQUf+7EE8o5Oh1b3ipWKfHBGE8e7yObgDh
	 72AgF1dDr7UZiFGG7RpTy4fX/eHdA6h8sJalXsHpYsEW8xhppHhURXoW5u8Wg3HJPl
	 7Sc601xVFgqzA5wW/TWuT2S0Lzn2W4Y9PpTkqQlQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728342AbgEaSFE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 31 May 2020 14:05:04 -0400
Received: from mail.kernel.org ([198.145.29.99]:41626 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726081AbgEaSFD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 31 May 2020 14:05:03 -0400
Subject: Re: [GIT] Networking
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1590948303;
        bh=4CRZa7JGRDtPrxJB3HXKHm8gh7sum89U5LPzt6xgYTM=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=OsShzPphWZaWbqrk1NS//SA+ERA2QksqWp1szrKM5Gk4xDf6lGT7gdPWHKZ0MGrfF
         XEakHHun3IGC3B2cdsMRrlzOCrQoFychULXX+ULAakMcqBABKGdoAboWLC/zjidWXT
         681qBpYTe1ZOBWTd0UuJSxHdpzOdpBciTMV258hw=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20200530.221309.1347376729998812574.davem@davemloft.net>
References: <20200530.221309.1347376729998812574.davem@davemloft.net>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20200530.221309.1347376729998812574.davem@davemloft.net>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net.git
 refs/heads/master
X-PR-Tracked-Commit-Id: d9a81a225277686eb629938986d97629ea102633
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 19835b1ba6b1f2d3fb5aefffa01ebd626513ff4a
Message-Id: <159094830304.9121.2392773888465749729.pr-tracker-bot@kernel.org>
Date:   Sun, 31 May 2020 18:05:03 +0000
To:     David Miller <davem@davemloft.net>
Cc:     torvalds@linux-foundation.org, akpm@linux-foundation.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sat, 30 May 2020 22:13:09 -0700 (PDT):

> git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net.git refs/heads/master

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/19835b1ba6b1f2d3fb5aefffa01ebd626513ff4a

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
