Return-Path: <SRS0=4zup=3T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7167EC2D0DB
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Jan 2020 23:50:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 43733217BA
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Jan 2020 23:50:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1580428226;
	bh=SX4dd91lUe1tOyO4Sif0XUIJozxIpAwzV+9mPvfm39M=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=KKJ+dYuLnv/wzb8ZgLUdNAFTHMoHS6naQ3ek2IzNS7z5aToWEQux+Zim67wiLFP2Z
	 mkulruSHrEV0EHUQ/0JtzBA4b0vCbjCfVCxfgjaJCjAyb9o/RgUnAXGPhvC1t5vLFV
	 Bn8NRQbVopZkUjAepxw2rmjzkA8Ob0Qc8piauEPI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727872AbgA3XuV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Jan 2020 18:50:21 -0500
Received: from mail.kernel.org ([198.145.29.99]:35904 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727845AbgA3XuS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Jan 2020 18:50:18 -0500
Subject: Re: [GIT PULL] f2fs for 5.6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1580428218;
        bh=SX4dd91lUe1tOyO4Sif0XUIJozxIpAwzV+9mPvfm39M=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=yVexK8+KmAARoH5F2UkYD+kvV6XUATWC3fMYpaKVMHYzQfLx3pQoDXzAGyumsQ+Tm
         En8+qyZGo9s4dKjdxEF0CI+bVy7BzEQYSBdujUQAROI/Phlob0RI/WTlzUl8swDDj8
         AUHAG2IOQMAkG4rFIFFHNfUwc2/zk7UT3HbC/n2k=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20200130185335.GA225399@google.com>
References: <20200130185335.GA225399@google.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20200130185335.GA225399@google.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/jaegeuk/f2fs.git
 tags/f2fs-for-5.6
X-PR-Tracked-Commit-Id: 80f2388afa6ef985f9c5c228e36705c4d4db4756
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 6e135baed8e70b00b88f7608f6b041461a5270bc
Message-Id: <158042821807.30792.10663230485770061389.pr-tracker-bot@kernel.org>
Date:   Thu, 30 Jan 2020 23:50:18 +0000
To:     Jaegeuk Kim <jaegeuk@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux F2FS Dev Mailing List 
        <linux-f2fs-devel@lists.sourceforge.net>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Thu, 30 Jan 2020 10:53:36 -0800:

> git://git.kernel.org/pub/scm/linux/kernel/git/jaegeuk/f2fs.git tags/f2fs-for-5.6

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/6e135baed8e70b00b88f7608f6b041461a5270bc

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
