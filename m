Return-Path: <SRS0=1cir=3Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C893C32771
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jan 2020 23:55:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 50B162467B
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jan 2020 23:55:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1580169328;
	bh=8xPXFqtI1U6LwTg8mH6J8uvOBrUvWUFWVp3N6BzKkr8=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=KbR9Z3BsjjY3eCi8qE1NNVhU7kOY/PFpCCHmBg2ZSqRjuXjuV38uGMXS5DDVf0X0Y
	 qxqNCWC7Xii/PS9stDBqZYNGnz2Bhg0dKpWvwh9gFixCxLZ/Fd44PdNZxVAPcF16bn
	 a6yvQM3pslc+oCv+IZKjG01R1Trr04n2UlYA45HI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728708AbgA0Xz1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Jan 2020 18:55:27 -0500
Received: from mail.kernel.org ([198.145.29.99]:54348 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727307AbgA0XzE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jan 2020 18:55:04 -0500
Subject: Re: [GIT PULL] workqueue changes for v5.6-rc1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1580169304;
        bh=8xPXFqtI1U6LwTg8mH6J8uvOBrUvWUFWVp3N6BzKkr8=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=Yzu4HhlyziQ0PiYwR2Xc+Ydy6X9JAcCuSSK8u+rkVJNvcFB9VnVINJmqcMf7X12VS
         2d7m15MG2Q8jGyhsiPMEp0gznHKnzZa/QuCG5thCLymT/AVbyDC9uNci9sK55I1i9O
         2zgdv/UWlCjQgKesmX9zaJxzvBpCbKSapsj45OGA=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20200127214345.GB180576@mtj.thefacebook.com>
References: <20200127214345.GB180576@mtj.thefacebook.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20200127214345.GB180576@mtj.thefacebook.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tj/wq.git
 for-5.6
X-PR-Tracked-Commit-Id: e8ab20d9bcb3e98b3e205396a56799b276951b64
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 16d06120d73acde39ac0d5e3c539b4f407e9e588
Message-Id: <158016930420.17044.13948798521933608689.pr-tracker-bot@kernel.org>
Date:   Mon, 27 Jan 2020 23:55:04 +0000
To:     Tejun Heo <tj@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org,
        Lai Jiangshan <jiangshanlai@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Mon, 27 Jan 2020 16:43:45 -0500:

> git://git.kernel.org/pub/scm/linux/kernel/git/tj/wq.git for-5.6

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/16d06120d73acde39ac0d5e3c539b4f407e9e588

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
