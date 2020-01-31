Return-Path: <SRS0=flzY=3U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4D36C2D0DB
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Jan 2020 23:10:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7E11B2071A
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Jan 2020 23:10:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1580512205;
	bh=/4lGO12f5eXg1wUlViSfevjuU3JmcgJpY4vIImfZNG8=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=LViAF/wUHgpILqMRP8nvabSzXg0URYuDte0rkHKn42OctahLDRVJxbfGAaiD/Cj0x
	 65bhkLXz53lSNzPIRNf+ToXA3nAwlPZU/LUVZp9oY+DsFF76wW+WWOihlcP8rZy8ju
	 rMYTlmWY1orOCmQrd0qFwLXcycTP/xmndekeHUwU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727407AbgAaXKE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 Jan 2020 18:10:04 -0500
Received: from mail.kernel.org ([198.145.29.99]:46214 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727388AbgAaXKE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Jan 2020 18:10:04 -0500
Subject: Re: [GIT PULL for v5.6-rc1] media updates
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1580512204;
        bh=/4lGO12f5eXg1wUlViSfevjuU3JmcgJpY4vIImfZNG8=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=0bVRPlipS1E4vCcBCcV8PtPYgWRzx+FD7bbOvFT5ZIXBVPYdprbKjU4vSeTuwvble
         KKwtxAz/S2BXImIgYrexMf6YAJWN3d3JXOWz72t82A58yAcUEs4lYokDLLo6AwkguX
         QACXRPTF/h53dMlO9jM0uBo7WdRN9zLMsp6eenO0=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20200131164922.7b105df7@kernel.org>
References: <20200131164922.7b105df7@kernel.org>
X-PR-Tracked-List-Id: <linux-media.vger.kernel.org>
X-PR-Tracked-Message-Id: <20200131164922.7b105df7@kernel.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/mchehab/linux-media
 tags/media/v5.6-1
X-PR-Tracked-Commit-Id: 1697d98124819aab09b86602978bd4f50e101e2d
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 846de71bedefb530461ee70ec82f7c810ef14e59
Message-Id: <158051220392.10603.11381217102247578315.pr-tracker-bot@kernel.org>
Date:   Fri, 31 Jan 2020 23:10:03 +0000
To:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux Media Mailing List <linux-media@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 31 Jan 2020 16:49:22 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/mchehab/linux-media tags/media/v5.6-1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/846de71bedefb530461ee70ec82f7c810ef14e59

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
