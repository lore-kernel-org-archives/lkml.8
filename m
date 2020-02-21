Return-Path: <SRS0=1210=4J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BDBBEC35669
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Feb 2020 21:10:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 95DF7208C4
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Feb 2020 21:10:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1582319421;
	bh=RJG0TSRKzyC7kRGCrxojQiF793bYRDTokqGS9BfGs1M=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=0J2mGNeFihKW4kDDLsyCFFGDu/9CoyQMC1iUdDpYL7sxSjdC5C2NU2EZHktdNHQSS
	 azJ3ouuFlzvChPAoPHfSN9wDkO12dN6Fh72r2akckTsdKTNGSiLDOyXCm8BBjE8z2C
	 xSTmKN5etzXNj36W9vmVWXBnvX8DCay8jzlPgJg4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729529AbgBUVKU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Feb 2020 16:10:20 -0500
Received: from mail.kernel.org ([198.145.29.99]:35814 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729638AbgBUVKT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Feb 2020 16:10:19 -0500
Subject: Re: [GIT PULL] USB/Thunderbolt fixes for 5.6-rc3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1582319419;
        bh=RJG0TSRKzyC7kRGCrxojQiF793bYRDTokqGS9BfGs1M=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=povoyYXprkxf60m2R4KJfUC6yD2py6GVFV7JyKfP2nCLg7oMqBGsOymp9uYi3nwPS
         OZFPny8nK0uLjXfezDtuj7+qq1B9GZrH+0pmV/ZvFTEd+XsTjGJmNsRztvi8Yk2pWT
         sUa3LB5cdvy+a5muS77E20eHjQ7k7D7OTmir09Kc=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20200221113901.GA114136@kroah.com>
References: <20200221113901.GA114136@kroah.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20200221113901.GA114136@kroah.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/usb.git tags/usb-5.6-rc3
X-PR-Tracked-Commit-Id: 8b978be8d067f58b29cbbf0579e88bb4a2d4350a
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: cee853e825a9ab64b54bd53f991e98f832c47317
Message-Id: <158231941895.18249.3540869557924097071.pr-tracker-bot@kernel.org>
Date:   Fri, 21 Feb 2020 21:10:18 +0000
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 21 Feb 2020 12:39:01 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/usb.git tags/usb-5.6-rc3

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/cee853e825a9ab64b54bd53f991e98f832c47317

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
