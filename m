Return-Path: <SRS0=F+sq=6U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D6D8C47247
	for <linux-kernel@archiver.kernel.org>; Wed,  6 May 2020 00:00:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E6D7C20752
	for <linux-kernel@archiver.kernel.org>; Wed,  6 May 2020 00:00:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1588723206;
	bh=T+9FucEjzlqEq7iY5IxvUC9kEJdDWt/xNoEqIXS8dxA=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=SditRxf9BQoQ+yAAdLOPkrNkbRl1ym/K2kcK9Jg7iBw4fZIs2aUcEzC/1G34EliEA
	 EhKEURvcp1l2y536OwRl2QVxP0eptshNH0PQ8aHRkGaC0HaZogNiw28v7NnHiVW1EK
	 g4fUpFaKudMW/R7sf0ctDh97TeNERSatsa+BkrDY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729633AbgEFAAG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 May 2020 20:00:06 -0400
Received: from mail.kernel.org ([198.145.29.99]:51640 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728875AbgEFAAF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 May 2020 20:00:05 -0400
Subject: Re: [GIT PULL] platform-drivers-x86 for 5.7-2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588723205;
        bh=T+9FucEjzlqEq7iY5IxvUC9kEJdDWt/xNoEqIXS8dxA=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=GbwNGao5RRp188D0y9L7nY9k0pzg/9YBTAwoR5SUUyPxoBKbKqZ/eNSoH0fvSqfdF
         fEQyOFtYPdD6B79NMH9aLvKgn1uYi2euCZq6l/fQyis5opi4syBV16d5t2OM1jWAVq
         V6NOpD9B+yblrSU7Ti45A+nN09SSvzanu45gVEYo=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20200505172104.GA1157275@smile.fi.intel.com>
References: <20200505172104.GA1157275@smile.fi.intel.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20200505172104.GA1157275@smile.fi.intel.com>
X-PR-Tracked-Remote: git://git.infradead.org/linux-platform-drivers-x86.git
 tags/platform-drivers-x86-v5.7-2
X-PR-Tracked-Commit-Id: f8a31eca47bec197f5ec5dc40ad675450c2058a5
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: dc56c5acd8505e1e7f776d62650f3850ad2ce8e7
Message-Id: <158872320548.717.7313717404519876849.pr-tracker-bot@kernel.org>
Date:   Wed, 06 May 2020 00:00:05 +0000
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Tue, 5 May 2020 20:21:04 +0300:

> git://git.infradead.org/linux-platform-drivers-x86.git tags/platform-drivers-x86-v5.7-2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/dc56c5acd8505e1e7f776d62650f3850ad2ce8e7

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
