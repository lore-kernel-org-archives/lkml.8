Return-Path: <SRS0=gmpU=CI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DBD40C433E2
	for <linux-kernel@archiver.kernel.org>; Sun, 30 Aug 2020 19:15:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B46C5206F0
	for <linux-kernel@archiver.kernel.org>; Sun, 30 Aug 2020 19:15:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1598814951;
	bh=Br6e0WOYrr+RijueJYikk4WsoKHe7tRGYDDJjzH4Bek=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=m+YeY2T8TC58UP8dW7GGXU+VyRpLiy+/6dQFlPNwM/+FFSjd3jjw4PARU1YLUx08R
	 WdBZKqcer09WSC6lPy03xo+0MtuZgEj3TNeVvYPncFPtTJGV4xt5IvtVB20DZHNolQ
	 6TFPFFTRlLpgzR5josoKjaIrg1KkA5zxzrChpRnc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726797AbgH3TPq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 30 Aug 2020 15:15:46 -0400
Received: from mail.kernel.org ([198.145.29.99]:44258 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726540AbgH3TPW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Aug 2020 15:15:22 -0400
Subject: Re: [GIT PULL] dma-mapping fix for 5.9
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598814921;
        bh=Br6e0WOYrr+RijueJYikk4WsoKHe7tRGYDDJjzH4Bek=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=1yUGSVPxtGF92RPCXyJFrI95SOXJphhwh5J/N7weO78YODFYqbx+3n6HlUpISRXk1
         BYdu8vROUwED6W299FNg7FjcjF0K9FcxM90dr/n9JxpXP+OmO8qzt46yfZudnQTD/E
         6IvOKOX1CUhdUbapCBGqzErTqU/WCI6sAFVd+K+w=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20200830063135.GA1224156@infradead.org>
References: <20200830063135.GA1224156@infradead.org>
X-PR-Tracked-List-Id: Development issues for Linux IOMMU support
 <iommu.lists.linux-foundation.org>
X-PR-Tracked-Message-Id: <20200830063135.GA1224156@infradead.org>
X-PR-Tracked-Remote: git://git.infradead.org/users/hch/dma-mapping.git tags/dma-mapping-5.9-2
X-PR-Tracked-Commit-Id: 892fc9f6835ecf075efac20789b012c5c9997fcc
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: c4011283a7d5d64a50991dd3baa9acdf3d49092c
Message-Id: <159881492180.11576.7289909181486653680.pr-tracker-bot@kernel.org>
Date:   Sun, 30 Aug 2020 19:15:21 +0000
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sun, 30 Aug 2020 08:31:35 +0200:

> git://git.infradead.org/users/hch/dma-mapping.git tags/dma-mapping-5.9-2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/c4011283a7d5d64a50991dd3baa9acdf3d49092c

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
