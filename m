Return-Path: <SRS0=bQGS=5U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 475B8C2BA18
	for <linux-kernel@archiver.kernel.org>; Sat,  4 Apr 2020 17:50:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 247542076C
	for <linux-kernel@archiver.kernel.org>; Sat,  4 Apr 2020 17:50:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1586022627;
	bh=cKK4vs/ElMxlmbk52kFAcJUDROfeksg+vPch0uqr/Hw=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=fhbj5ZOd9kpQepkfpJh6FtIMwf3BBZ7eNF3ta4s10b4y6flPSMeLVu3pZd2DoNa2s
	 8b22MXQuSzK/qq4VvtAkS5bQ1pLXtqB6cFfk1kfantW5qTb3PIKno/yIcyY7Iw6/vm
	 9gpAseywgm7rVKCAdnUiY/9MvOfXsOUzTCGkLL84=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726476AbgDDRu0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 4 Apr 2020 13:50:26 -0400
Received: from mail.kernel.org ([198.145.29.99]:40328 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726436AbgDDRuY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Apr 2020 13:50:24 -0400
Subject: Re: [GIT PULL] dma-mapping updates for 5.7
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1586022624;
        bh=cKK4vs/ElMxlmbk52kFAcJUDROfeksg+vPch0uqr/Hw=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=Pt0NybnfUbUjG+K9PWNQgx3n0++R+6EAhGcraUZ46TT5jqQIUzZ6K2vfl+h6WSzQg
         qS9i+ves0qvlDDPFgCwTNVS3Yb12Tjp35v8fXYdWYg2TNuaaCNitE4+9rMLTf3By5k
         TT5eLz1fI9VqCF6c6OL+l0rbzKkF4O3xqb2TjUKQ=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20200404065855.GA656254@infradead.org>
References: <20200404065855.GA656254@infradead.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20200404065855.GA656254@infradead.org>
X-PR-Tracked-Remote: git://git.infradead.org/users/hch/dma-mapping.git
 tags/dma-mapping-5.7
X-PR-Tracked-Commit-Id: fd27a526bb381f43dded6db30b3b016468ab0e6c
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 6f43bae38269a55534e1f86a9917318167de6639
Message-Id: <158602262410.31764.10662666727749617192.pr-tracker-bot@kernel.org>
Date:   Sat, 04 Apr 2020 17:50:24 +0000
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        iommu@lists.linux-foundation.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sat, 4 Apr 2020 08:58:55 +0200:

> git://git.infradead.org/users/hch/dma-mapping.git tags/dma-mapping-5.7

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/6f43bae38269a55534e1f86a9917318167de6639

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
