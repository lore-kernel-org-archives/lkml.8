Return-Path: <SRS0=dAmO=AZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42DA4C433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jul 2020 01:35:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1F24721924
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jul 2020 01:35:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1594690508;
	bh=D/Bl2d/W9e6p4DWfLpdQLJsdo0VCU8TQe8i6i7tmhv8=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=1HFBQipUUYUULecl4i5AFJqtuWz6yV/p/LzoXwBeqEswJj9J0vTFrd75bWED1y/PN
	 oezi3K2mEFGDNg31Sp6Rhx6hiqg73Hcfu+onQaTaSQaY/xViH9RcNyi/S6mKkUpoNO
	 TerMHSMUpioaUAzV0I7Cd+UqNG7GckrJRxknq894=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726852AbgGNBfE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Jul 2020 21:35:04 -0400
Received: from mail.kernel.org ([198.145.29.99]:49172 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726364AbgGNBfE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jul 2020 21:35:04 -0400
Subject: Re: [git pull] IOMMU Fixes for Linux v5.8-rc5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1594690503;
        bh=D/Bl2d/W9e6p4DWfLpdQLJsdo0VCU8TQe8i6i7tmhv8=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=lumb+JbSYY9uiio0MEji0Gw7NEPFMKmWzdsiMO62/MyFqadPpzANgXspuIvYTu5fz
         HZa+29m8BAWHEiu8q1P8KjJ+eYnNFdBNDiALTnWiQ2dm8i9VkewjyDbRKswgzhrghJ
         KW4SA8PYKDbS+JTv151+ZKQEI+pVhJctqv35Rpio=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20200713153649.GA2615@8bytes.org>
References: <20200713153649.GA2615@8bytes.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20200713153649.GA2615@8bytes.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/joro/iommu.git
 tags/iommu-fixes-v5.8-rc5
X-PR-Tracked-Commit-Id: a082121b55bac125f7d09d78de00607ea75a6903
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 0dc589da873b58b70f4caf4b070fb0cf70fdd1dc
Message-Id: <159469050366.22447.6799245194138996381.pr-tracker-bot@kernel.org>
Date:   Tue, 14 Jul 2020 01:35:03 +0000
To:     Joerg Roedel <joro@8bytes.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Mon, 13 Jul 2020 17:36:54 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/joro/iommu.git tags/iommu-fixes-v5.8-rc5

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/0dc589da873b58b70f4caf4b070fb0cf70fdd1dc

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
