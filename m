Return-Path: <SRS0=2JZx=64=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD71EC433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 14 May 2020 19:02:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7FAF42065F
	for <linux-kernel@archiver.kernel.org>; Thu, 14 May 2020 19:02:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1589482955;
	bh=xxXE1I6+QBWEfouz1QVY8vdxUq4FAM4KAv6r0PXSOM4=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=RQ261SPYG37Ik2GkZT58QMIh2UJvjyFt/qQIOTOULpiPPompyJO0NzHC+7Hd1b/AT
	 iXreCAKW1kTWtBjiUgtiT1U21/7AWMLkScsdZYqy5hlE9LKRgpBD38ASiYcBjTb08y
	 RnoBgr5/z5oJ75zGhtq9RUwVQkRTACZXKT51tOas=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730042AbgENTCe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 May 2020 15:02:34 -0400
Received: from mail.kernel.org ([198.145.29.99]:55406 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729287AbgENSzE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 May 2020 14:55:04 -0400
Subject: Re: [GIT PULL] thread fixes v5.7-rc5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1589482504;
        bh=xxXE1I6+QBWEfouz1QVY8vdxUq4FAM4KAv6r0PXSOM4=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=iKVzGIeQdSCiAVV3HcN69y4M1wxtLkCUHN2wlDxRzE0y9TZpDb8rgGfC31pTCyrFc
         XbeeeRXg4eYegxorHT+I5V8d98nzaeWzmIbx32HR3NRe67IPle5I8zH2pQMJwrsNZ+
         S66sfz48pR3ZmcuX/kVVosTsZteYsjzTD7VZLkNE=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20200514170451.1821723-1-christian.brauner@ubuntu.com>
References: <20200514170451.1821723-1-christian.brauner@ubuntu.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20200514170451.1821723-1-christian.brauner@ubuntu.com>
X-PR-Tracked-Remote: git@gitolite.kernel.org:pub/scm/linux/kernel/git/brauner/linux
 tags/for-linus-2020-05-13
X-PR-Tracked-Commit-Id: 3f2c788a13143620c5471ac96ac4f033fc9ac3f3
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 8c1684bb81f173543599f1848c29a2a3b1ee5907
Message-Id: <158948250396.25823.14716230911955912328.pr-tracker-bot@kernel.org>
Date:   Thu, 14 May 2020 18:55:03 +0000
To:     Christian Brauner <christian.brauner@ubuntu.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Thu, 14 May 2020 19:04:51 +0200:

> git@gitolite.kernel.org:pub/scm/linux/kernel/git/brauner/linux tags/for-linus-2020-05-13

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/8c1684bb81f173543599f1848c29a2a3b1ee5907

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
