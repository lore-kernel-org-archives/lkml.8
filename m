Return-Path: <SRS0=HPGY=7U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75C8EC433DF
	for <linux-kernel@archiver.kernel.org>; Sun,  7 Jun 2020 18:10:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4F0602075A
	for <linux-kernel@archiver.kernel.org>; Sun,  7 Jun 2020 18:10:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1591553438;
	bh=3rBsY0PJy+xWxyRx+aUpth6U8mmUTg0DeSh+zvenCXY=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=UfuZhrqQQGr4LMTyDmucb3dbEAbWb/JyRN7jxMUDJj/Mm/2rY1bTEjwXGe7fIHuR0
	 4DfK+F6/r39LNGsD+i2ZXMQhqQuBTPa0VwP+BtJi32GBK332YTItbG17+YNq82CmNi
	 D0ODndEZhJ7uRfV2fJ5MOxdz/PIGD/LpiGEu8Sfg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729075AbgFGSKh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 7 Jun 2020 14:10:37 -0400
Received: from mail.kernel.org ([198.145.29.99]:56424 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729012AbgFGSKW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 7 Jun 2020 14:10:22 -0400
Subject: Re: [GIT PULL] Driver core patches for 5.8-rc1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1591553421;
        bh=3rBsY0PJy+xWxyRx+aUpth6U8mmUTg0DeSh+zvenCXY=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=uPOF6qFZziiUNrqwCGyknIEOy5AJx8Do4z4Fw6iJsznMYihoaawKNykSm/+CZrR5Q
         wE+YENq3mSHdx5HLQ1mZaW1xvUlVYaVGPeG6RtA3JUSGd+o1W9Ll8G+vGa34so2GWR
         8rpy2t1ebHuPfUPOuP42Vu22R7EF44MKCZTaJC94=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20200607132816.GA168380@kroah.com>
References: <20200607132816.GA168380@kroah.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20200607132816.GA168380@kroah.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/driver-core.git
 tags/driver-core-5.8-rc1
X-PR-Tracked-Commit-Id: 8c3e315d4296421cd26b3300ee0ac117f0877f20
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: f558b8364e19f9222e7976c64e9367f66bab02cc
Message-Id: <159155342187.28494.10596812703633646530.pr-tracker-bot@kernel.org>
Date:   Sun, 07 Jun 2020 18:10:21 +0000
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org,
        Stephen Rothwell <sfr@canb.auug.org.au>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sun, 7 Jun 2020 15:28:16 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/driver-core.git tags/driver-core-5.8-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/f558b8364e19f9222e7976c64e9367f66bab02cc

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
