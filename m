Return-Path: <SRS0=j177=6Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77AA5C38A2A
	for <linux-kernel@archiver.kernel.org>; Sun, 10 May 2020 19:45:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4F92824956
	for <linux-kernel@archiver.kernel.org>; Sun, 10 May 2020 19:45:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1589139905;
	bh=bYqSfo4lMXohnc3IhL03zeCrUobYVL6txTc5psvv8o0=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=oismtRmWDaMAsWcJZQzCT/AUpCYdLrrcFf6JMB3Mb9RwcZZm/eDkwjKerPwB5dZxG
	 oiA9IoFTPPdgUvqwXNXXSbVVyL61f3L2ZPCvl2OavMIqVQ5dMaCR8xC4M/qCRCN0In
	 sORJ7MIQ6MJddqdlhLErt3GvcikvFgN9TS8STcV0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729267AbgEJTpE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 10 May 2020 15:45:04 -0400
Received: from mail.kernel.org ([198.145.29.99]:56778 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728823AbgEJTpE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 May 2020 15:45:04 -0400
Subject: Re: [git pull] IOMMU Fixes for Linux v5.7-rc4
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1589139903;
        bh=bYqSfo4lMXohnc3IhL03zeCrUobYVL6txTc5psvv8o0=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=jwnIJFHFdDGmhDt7scI/4fbSvFmpLBfXZnpLPHgrC7Fxc4TMZw6kAza245HSyQQQg
         6ADSMmgulm5rncegW6MPFo5zKGQ1hm7QL1QQVLckUdrlv3Ux6MbmrASkuOIx+rjsc5
         T+iPQidDmU4VKNP9r1kFfQ7e6113iJmDwntdqkGI=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20200510122634.GA32616@8bytes.org>
References: <20200510122634.GA32616@8bytes.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20200510122634.GA32616@8bytes.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/joro/iommu.git
 tags/iommu-fixes-v5.7-rc4
X-PR-Tracked-Commit-Id: fb3637a113349f53830f7d6ca45891b7192cd28f
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 27d2dcb1b95c8c39da417839c11eda2e665cd389
Message-Id: <158913990386.3456.15345880973524741179.pr-tracker-bot@kernel.org>
Date:   Sun, 10 May 2020 19:45:03 +0000
To:     Joerg Roedel <joro@8bytes.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sun, 10 May 2020 14:26:40 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/joro/iommu.git tags/iommu-fixes-v5.7-rc4

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/27d2dcb1b95c8c39da417839c11eda2e665cd389

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
