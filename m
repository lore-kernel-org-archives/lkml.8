Return-Path: <SRS0=1cir=3Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,URIBL_DBL_ABUSE_MALW autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97B8DC2D0DB
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jan 2020 19:15:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6D29F22527
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jan 2020 19:15:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1580152511;
	bh=d6PDGyoZupDhjEjLM9gB+lbi2WUqJj0VApiJBLR8Z+I=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=yEzlDYirVhJacQCUgn4apqNEAzyQwx7cfy8mSl+VKpQ+Jik/xwUw7l15fZwo/jYo7
	 SLrZa5h8lX61uP33w1FONYHbqhIAaAlqL0Ni2uhEOdXL+Q9k0iQsNZrLgTa0wZ9F77
	 9qmGO9r7tw/v1DKshiBrKz2g2Ah1SyR4DdODGuaM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729210AbgA0TPK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Jan 2020 14:15:10 -0500
Received: from mail.kernel.org ([198.145.29.99]:48738 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729159AbgA0TPH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jan 2020 14:15:07 -0500
Subject: Re: [GIT PULL]: dmaengine updates for v5.6-rc1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1580152507;
        bh=d6PDGyoZupDhjEjLM9gB+lbi2WUqJj0VApiJBLR8Z+I=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=IukIQtWim8d120obvFjCBMczPM3c79jF81mmb+jy+0ni3EFgVpqa4qWeDFV2Mqe8a
         Lr4spQEdRZoMWzn2gYelC9tPuqkbG4g4R6Ynk2XExkmh8OwukaIWfPbKPfhGu0m407
         bWda1Iq5SRVH0aH3U8hRShU6AVknmJoFoLLAhtTE=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20200127145835.GI2841@vkoul-mobl>
References: <20200127145835.GI2841@vkoul-mobl>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20200127145835.GI2841@vkoul-mobl>
X-PR-Tracked-Remote: git://git.infradead.org/users/vkoul/slave-dma.git
 tags/dmaengine-5.6-rc1
X-PR-Tracked-Commit-Id: 71723a96b8b1367fefc18f60025dae792477d602
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: a5b871c91d470326eed3ae0ebd2fc07f3aee9050
Message-Id: <158015250749.1024.11601911779192777243.pr-tracker-bot@kernel.org>
Date:   Mon, 27 Jan 2020 19:15:07 +0000
To:     Vinod Koul <vkoul@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        dma <dmaengine@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Mon, 27 Jan 2020 20:28:35 +0530:

> git://git.infradead.org/users/vkoul/slave-dma.git tags/dmaengine-5.6-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/a5b871c91d470326eed3ae0ebd2fc07f3aee9050

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
