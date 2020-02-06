Return-Path: <SRS0=za8s=32=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C949BC352A2
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Feb 2020 08:20:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 97A24214AF
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Feb 2020 08:20:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1580977221;
	bh=IUSryFWC9ZJOPvcYT/YWlVuk80o3f3kRyNGh5kRY/II=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=EG6B7cteMfqE17XKIhVZjSc8tBNkk/9uzx+Dsk1X6hYSNlJdLEsn2pBK4tUX9Np/z
	 k97KyN0ExgSRdGiNwhPh1lKgj4FnxQbP+FOyDhSW0zdhHLkGmaPmA4I6TwjtwZpiGq
	 Fp5S1ZjtN7tXgMfPXJYS+SpydwVAcMw5+hAom0jE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728003AbgBFIUU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Feb 2020 03:20:20 -0500
Received: from mail.kernel.org ([198.145.29.99]:39714 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727977AbgBFIUS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Feb 2020 03:20:18 -0500
Subject: Re: [git pull] m68knommu changes for v5.6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1580977218;
        bh=IUSryFWC9ZJOPvcYT/YWlVuk80o3f3kRyNGh5kRY/II=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=Pcfqxj+cRmvUeI5R1tde5Ksvio+LoLrs/4bQGr23Zqh1FKLm+vkUa8WwXU1Vqweqf
         dqd+FW+cNK7ZpCtOSCjxOx8PhpxrG8l8eBcOlZxmmLFjN4rypZHqZU6/4XLqBQ/pzg
         K3wu4h7kKuFw0MmtuXGaAmhExcw1iit7FSPHfny8=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <70537bf1-51e2-e668-4d82-7e4ab73abbca@linux-m68k.org>
References: <70537bf1-51e2-e668-4d82-7e4ab73abbca@linux-m68k.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <70537bf1-51e2-e668-4d82-7e4ab73abbca@linux-m68k.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/gerg/m68knommu.git for-next
X-PR-Tracked-Commit-Id: 8044aad70a1fbd66376cdb2a13e536db9dd6c132
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 5b21115414f5b5220e7ab3ca7f5d2c1396f11854
Message-Id: <158097721818.4470.6918267910577426141.pr-tracker-bot@kernel.org>
Date:   Thu, 06 Feb 2020 08:20:18 +0000
To:     Greg Ungerer <gerg@linux-m68k.org>
Cc:     torvalds@linux-foundation.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Linux/m68k <linux-m68k@vger.kernel.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Thu, 6 Feb 2020 14:13:50 +1000:

> git://git.kernel.org/pub/scm/linux/kernel/git/gerg/m68knommu.git for-next

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/5b21115414f5b5220e7ab3ca7f5d2c1396f11854

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
