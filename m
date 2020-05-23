Return-Path: <SRS0=zXkI=7F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6194CC433DF
	for <linux-kernel@archiver.kernel.org>; Sat, 23 May 2020 18:30:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 43F2A20787
	for <linux-kernel@archiver.kernel.org>; Sat, 23 May 2020 18:30:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1590258608;
	bh=WAhRRebspSPdiarVc4RDRIPhUBJYs+zIrFZKaoJsJKA=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=VdWSK8GQawdw4JDgoBx+eCtLcjb5vz2hPdWsR+5TUI7O7SjSodc5QUj0mIlvRRcmQ
	 Ysh6aobHkZ4mRcM91l+xAVshM3pka0PCs8HdwFElrYjV8H7ki7qm+EwZO/K81kLgmc
	 EnseSVZsKTE7YH3E6HjHwY8hpRC5W/l0K3YFYUXE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388003AbgEWSaE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 23 May 2020 14:30:04 -0400
Received: from mail.kernel.org ([198.145.29.99]:53236 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387969AbgEWSaD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 May 2020 14:30:03 -0400
Subject: Re: [GIT PULL] Driver core fixes for 5.7-rc7
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1590258603;
        bh=WAhRRebspSPdiarVc4RDRIPhUBJYs+zIrFZKaoJsJKA=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=UbgkWBU86oyimqFRGSmmJSs7LhPOcOUYdiSB9ab/KpTR/oe0ImN9TSX4u8X7rIhFW
         MNdDfFjTlk3mXx+TVWr0T1m7dz8Ybvznl6S21ShLt31jEGKIta37Prb5w52f3B5YhG
         RxXAm29CmhQFhlqDhtDOSLjHZ1xGYeB+ozqU0F7I=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20200523131759.GA55886@kroah.com>
References: <20200523131759.GA55886@kroah.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20200523131759.GA55886@kroah.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/driver-core.git
 tags/driver-core-5.7-rc7
X-PR-Tracked-Commit-Id: 4ef12f7198023c09ad6d25b652bd8748c965c7fa
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: e6764aa0e5530066dd969eccea2a1a7d177859a8
Message-Id: <159025860354.7121.1225647998271124374.pr-tracker-bot@kernel.org>
Date:   Sat, 23 May 2020 18:30:03 +0000
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org,
        Stephen Rothwell <sfr@canb.auug.org.au>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sat, 23 May 2020 15:17:59 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/driver-core.git tags/driver-core-5.7-rc7

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/e6764aa0e5530066dd969eccea2a1a7d177859a8

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
