Return-Path: <SRS0=PEot=6K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E93C7C54FCB
	for <linux-kernel@archiver.kernel.org>; Sun, 26 Apr 2020 18:15:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CEC642070A
	for <linux-kernel@archiver.kernel.org>; Sun, 26 Apr 2020 18:15:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1587924931;
	bh=Fcq6bfIkMCJ3DlIZmp/+Yox3Oru8kye048U154+0d/8=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=FDhUJZhP29Fj+Z/4y5J63JfWlo0RQEpHJo+9YAZzSHjDrzxfhGm6F4hzDU7kSPq0T
	 RPTFAtHy1Ed4FAiFUc2lRDKZaw/RXUiNzXqyNxQxFuAEn7pSMc1cyFhrCp0Rx0S88r
	 D2lmq4SDq/YVBYRoqiknZKq/VMHqTCC4a4jQfSmU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726284AbgDZSPS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 26 Apr 2020 14:15:18 -0400
Received: from mail.kernel.org ([198.145.29.99]:50756 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726223AbgDZSPQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Apr 2020 14:15:16 -0400
Subject: Re: [GIT PULL] Devicetree fixes for v5.7, take 2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1587924916;
        bh=Fcq6bfIkMCJ3DlIZmp/+Yox3Oru8kye048U154+0d/8=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=ez6PiCuACCAYLvqJhHmXF5sK1y41GiBZRINfJF/pR09JSxJ6X+uQoX0GxemSUHJ+n
         Lk1OQJyfssbwYEX32xaVLTH5HgcXIQodRMVkG05+efM3yB85IOQiHYH9L1ACWxjh94
         iVvbU3u3Mrp5JbS+Pk/0e59v3BUJICWmgVywvr8M=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20200425234253.GA32365@bogus>
References: <20200425234253.GA32365@bogus>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20200425234253.GA32365@bogus>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/robh/linux.git
 tags/devicetree-fixes-for-5.7-2
X-PR-Tracked-Commit-Id: 4bc77b2d211e107fa54b1f39cd0d7dac5537b8cb
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 587928829ac2b5f5e0f1e2d3ed5d65a14869df75
Message-Id: <158792491654.6795.10489802406329422714.pr-tracker-bot@kernel.org>
Date:   Sun, 26 Apr 2020 18:15:16 +0000
To:     Rob Herring <robh@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        Frank Rowand <frowand.list@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sat, 25 Apr 2020 18:42:53 -0500:

> git://git.kernel.org/pub/scm/linux/kernel/git/robh/linux.git tags/devicetree-fixes-for-5.7-2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/587928829ac2b5f5e0f1e2d3ed5d65a14869df75

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
