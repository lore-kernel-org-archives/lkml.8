Return-Path: <SRS0=lrRa=AG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5776C433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jun 2020 00:50:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8D6C420781
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jun 2020 00:50:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1593046228;
	bh=W92s3O6ONLyRI+jk48nV3AgEreWhV9JHH3V6rkqQKms=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=1CNae3vh7GRhacBlGTesAzz2HD4V8DoAVfc7pC3qYzXTN7ixffrS8CukCnT4Qnaq6
	 ps+f08RuF7kIAvq3uZG06hOX7o7HqXwUFkJIyhutkbIfF3C5zcLp9m/hibuaMwM/P9
	 jobO2akFKus1YRjFm7BYd/wodJtofMsaMDe5r5Eo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389136AbgFYAu0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Jun 2020 20:50:26 -0400
Received: from mail.kernel.org ([198.145.29.99]:33942 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388679AbgFYAuS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Jun 2020 20:50:18 -0400
Subject: Re: [GIT PULL] erofs fixes for 5.8-rc3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1593046218;
        bh=W92s3O6ONLyRI+jk48nV3AgEreWhV9JHH3V6rkqQKms=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=DXXksSZ3N53Aiz/nKdvPbTgaz9VLB2XOdcOwxBM7IEki4ocWhUXtWtk7Jz6wb68Q1
         h0CTHszLmtXYWQ4rg5uspJ83xtcUOzo8k+IZoAP7Qa6yvsSg/QVk8meLhj7ll8dkNR
         pKFdeAwmd/aDLXmB7Ze5sxg4+JEtCXayFAXWpo3o=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20200624210853.GA6242@xiangao.remote.csb>
References: <20200624210853.GA6242@xiangao.remote.csb>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20200624210853.GA6242@xiangao.remote.csb>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/xiang/erofs.git
 tags/erofs-for-5.8-rc3-fixes
X-PR-Tracked-Commit-Id: 3c597282887fd55181578996dca52ce697d985a5
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 8be3a53e18e0e1a98f288f6c7f5e9da3adbe9c49
Message-Id: <159304621812.794.18321305239052628296.pr-tracker-bot@kernel.org>
Date:   Thu, 25 Jun 2020 00:50:18 +0000
To:     Gao Xiang <hsiangkao@redhat.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-erofs@lists.ozlabs.org, LKML <linux-kernel@vger.kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Andrew Morton <akpm@linux-foundation.org>,
        Miao Xie <miaoxie@huawei.com>, Chao Yu <yuchao0@huawei.com>,
        Fang Wei <fangwei1@huawei.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Thu, 25 Jun 2020 05:08:53 +0800:

> git://git.kernel.org/pub/scm/linux/kernel/git/xiang/erofs.git tags/erofs-for-5.8-rc3-fixes

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/8be3a53e18e0e1a98f288f6c7f5e9da3adbe9c49

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
