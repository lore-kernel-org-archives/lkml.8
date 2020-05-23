Return-Path: <SRS0=zXkI=7F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 769C4C433DF
	for <linux-kernel@archiver.kernel.org>; Sat, 23 May 2020 18:30:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4E4692070A
	for <linux-kernel@archiver.kernel.org>; Sat, 23 May 2020 18:30:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1590258618;
	bh=yr5Y6AeMgciUs8IemR4vYvk1Fwgv118/v3d7eFBcLDk=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=hvDfNUVNRLQYpJnCcEXr5Ty8dKdYaXnY3O89JOsXmkAJjDpWR+H4sCaKeQSHNXSp+
	 Q4mOihjD3xZvIds3DEoiOAewnKSUhFPScdm9RB8rlSu3ySLVwmU39EKtkpromuaVhZ
	 mZaa4xbVTt4JPbkS5a7TvKot814qaNujRodyGoHo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388061AbgEWSaR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 23 May 2020 14:30:17 -0400
Received: from mail.kernel.org ([198.145.29.99]:53220 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387945AbgEWSaD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 May 2020 14:30:03 -0400
Subject: Re: [GIT PULL] Staging/IIO driver fixes for 5.7-rc7
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1590258603;
        bh=yr5Y6AeMgciUs8IemR4vYvk1Fwgv118/v3d7eFBcLDk=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=EvNYFYY834DXFwDzFUzryZuuY9zmTqKoEHCVC97SPoouvepxg3hLdFwgLB2cX32bp
         k/osNLmDROf4uaKS9h3bcZWRI2g6T6DrsJJ8OQyC1wj6LEfMtZoWAYrBhdZUGOx+Ac
         Jrq55DpeVYEMS+JGNEIIFEwTaIMWAKU34x2+hWDU=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20200523131742.GA55395@kroah.com>
References: <20200523131742.GA55395@kroah.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20200523131742.GA55395@kroah.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/staging.git
 tags/staging-5.7-rc7
X-PR-Tracked-Commit-Id: bcb392871813ef9e233645557d6dd85bb1a6f41a
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 8f261041b18ee80ad8afdd1621c909c4df9f6cc3
Message-Id: <159025860329.7121.11409347777596776715.pr-tracker-bot@kernel.org>
Date:   Sat, 23 May 2020 18:30:03 +0000
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        devel@linuxdriverproject.org, linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sat, 23 May 2020 15:17:42 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/staging.git tags/staging-5.7-rc7

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/8f261041b18ee80ad8afdd1621c909c4df9f6cc3

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
