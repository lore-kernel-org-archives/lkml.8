Return-Path: <SRS0=/A4t=3B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9428DC33CA2
	for <linux-kernel@archiver.kernel.org>; Sun, 12 Jan 2020 17:40:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6B9C621569
	for <linux-kernel@archiver.kernel.org>; Sun, 12 Jan 2020 17:40:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1578850805;
	bh=F2rMj+tDgCY54uolmRKP8Lu3t4cWtvsfHk3J8aI4QqI=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=waCud7QILRliZSxLIY8cBuIgGml/PZoyhcGcz6jXD6N/NL0qypgDEdq1R22h8k0Z1
	 YV4/GY8jMrCjQ4Onr3fc7X1QbUaPdfiwoY4EeqltF35vTwt04Cht7qsW3SKu3hg75L
	 NlFP3V7SkzvdtEMZq7NXHLhUVtH14mhcv42nfWqo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733165AbgALRkE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 12 Jan 2020 12:40:04 -0500
Received: from mail.kernel.org ([198.145.29.99]:49716 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732957AbgALRkE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Jan 2020 12:40:04 -0500
Subject: Re: [git pull] IOMMU Fixes for Linux v5.5-rc5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1578850803;
        bh=F2rMj+tDgCY54uolmRKP8Lu3t4cWtvsfHk3J8aI4QqI=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=lLEEPy6Ds5dpxuAqq/QJJ+LYZBSXpWSGRkuJV6SC3oeQYNumlOFwz3mBoVs11KJuT
         CEBVmVS9uvG7v9K7c1BPGy1mTBedL33wIKOEJpYo748FlNU51lYRJMZ9tJ+1DcMxwn
         05mzKsvG1V27jh7fh+fwzVn68zy9a6p9yQT3aXwg=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20200112095936.GA17108@8bytes.org>
References: <20200112095936.GA17108@8bytes.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20200112095936.GA17108@8bytes.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/joro/iommu.git
 iommu-fixes-v5.5-rc5
X-PR-Tracked-Commit-Id: 55817b340a31951d23d1692db45522560b1d20f9
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 040a3c33623ba4bd11588ab0820281b854a3ffaf
Message-Id: <157885080357.18926.14855458420719655456.pr-tracker-bot@kernel.org>
Date:   Sun, 12 Jan 2020 17:40:03 +0000
To:     Joerg Roedel <joro@8bytes.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sun, 12 Jan 2020 10:59:41 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/joro/iommu.git iommu-fixes-v5.5-rc5

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/040a3c33623ba4bd11588ab0820281b854a3ffaf

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
