Return-Path: <SRS0=728o=CL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F890C433E2
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Sep 2020 20:08:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F074A208C7
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Sep 2020 20:08:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1599077298;
	bh=JaCimreaxNaAnihJKh1xVADdmT03ZqVkIQFc00jI2B8=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=lzWcfRUkEVVDPh+BRUiXralmCmxZr9XuXYuFOu8FeZjISAhY7ewTR4OCAYwiRz+t9
	 xkiORguf31Ygex1MvhyxSTprmw4bcgcJdkg9DZTusJDx2NNM78a7CT3Ilrn+ag9adj
	 i0bJl/Zmzy/11Z+jJ/T8VSM1p9XgMAN16qeqexWM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726853AbgIBUIP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 2 Sep 2020 16:08:15 -0400
Received: from mail.kernel.org ([198.145.29.99]:35194 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726247AbgIBUIM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Sep 2020 16:08:12 -0400
Subject: Re: [git pull] epoll fixup
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1599077292;
        bh=JaCimreaxNaAnihJKh1xVADdmT03ZqVkIQFc00jI2B8=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=zNy05OAuJz8l0xlfuo/b91X2SZdWqwo0lwK/CK5HzfNM1lFYgsmOkyRLioaehHVK0
         X4Lv6CZAGxAbWwXyZRTY7feMgbajvO2ZJtzRVK2fVth7P/t/cUyFumTernUcNuJndE
         4Ky/YFnNWPbwMT5BQQg3WkDQYya3wT2HngN4NbtA=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20200902153747.GL1236603@ZenIV.linux.org.uk>
References: <20200902153747.GL1236603@ZenIV.linux.org.uk>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20200902153747.GL1236603@ZenIV.linux.org.uk>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/viro/vfs.git work.epoll
X-PR-Tracked-Commit-Id: 77f4689de17c0887775bb77896f4cc11a39bf848
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 54e54d58184e34887cc40d0bc83720dbaf57db1a
Message-Id: <159907729193.15646.13492853215823650952.pr-tracker-bot@kernel.org>
Date:   Wed, 02 Sep 2020 20:08:11 +0000
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Marc Zyngier <maz@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Wed, 2 Sep 2020 16:37:47 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/viro/vfs.git work.epoll

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/54e54d58184e34887cc40d0bc83720dbaf57db1a

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
