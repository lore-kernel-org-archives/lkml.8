Return-Path: <SRS0=xNW4=3S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44278C2D0DB
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Jan 2020 19:50:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1CDF420716
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Jan 2020 19:50:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1580327412;
	bh=QVc3M1p6hOZL9NmKs704mTG8RxiuAPw0MZhCrwfmV8g=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=G8gPLFkn16rCElksbObcGN76ntGX78wdJ1t/6YPCuY03X/4+fT9MhIKPH2Dnuatdm
	 tUV8Q9Yj9ENRdq7x7FtIt8Fy1EEecK+jQoGD6xOFIynjzliyevp03hNS+4o60QD8Dn
	 vup/6w4MjuK/QlH5Rh4YRpfH9u/WRrfWl2NYxypg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727490AbgA2TuL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Jan 2020 14:50:11 -0500
Received: from mail.kernel.org ([198.145.29.99]:38008 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727379AbgA2TuI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jan 2020 14:50:08 -0500
Subject: Re: [GIT PULL] erofs updates for 5.6-rc1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1580327408;
        bh=QVc3M1p6hOZL9NmKs704mTG8RxiuAPw0MZhCrwfmV8g=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=mygKdnzPsvPt43UG1G+jLkMKz3bJctVOmPk+ISuRvnwWTouZMTXHVeAryU0Jry5dl
         Uv3pvH8jFCgS01la5Vz8wRXR8w03nZoGGavRykeJk+agOnxW/k/udrirqkPt1AecmU
         KOZazYITLwDOd7ED2v4oUFpcOlDywV5grtzINb8c=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20200129020451.GA5348@hsiangkao-HP-ZHAN-66-Pro-G1>
References: <20200129020451.GA5348.ref@hsiangkao-HP-ZHAN-66-Pro-G1>
 <20200129020451.GA5348@hsiangkao-HP-ZHAN-66-Pro-G1>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20200129020451.GA5348@hsiangkao-HP-ZHAN-66-Pro-G1>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/xiang/erofs.git
 tags/erofs-for-5.6-rc1
X-PR-Tracked-Commit-Id: 1e4a295567949ee8e6896a7db70afd1b6246966e
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 3893c2025fec6f0fa4b2d794f36bd56a55e46dec
Message-Id: <158032740852.31127.11742982511993883563.pr-tracker-bot@kernel.org>
Date:   Wed, 29 Jan 2020 19:50:08 +0000
To:     Gao Xiang <hsiangkao@aol.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Miao Xie <miaoxie@huawei.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-erofs@lists.ozlabs.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Wed, 29 Jan 2020 10:04:54 +0800:

> git://git.kernel.org/pub/scm/linux/kernel/git/xiang/erofs.git tags/erofs-for-5.6-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/3893c2025fec6f0fa4b2d794f36bd56a55e46dec

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
