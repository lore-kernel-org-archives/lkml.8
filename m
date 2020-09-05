Return-Path: <SRS0=flm+=CO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 993CBC433E2
	for <linux-kernel@archiver.kernel.org>; Sat,  5 Sep 2020 22:36:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 68EE22083B
	for <linux-kernel@archiver.kernel.org>; Sat,  5 Sep 2020 22:36:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1599345416;
	bh=oTU24XDpz3OQJtk65d1jVgZIvhTIPPYMFSZMGdTPOFQ=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=S60o9ontA24OzDJ96e1WIEj0jQ7Irfm3YX6oBhfkvirB2tFLZCbI8wCkJ/GfPzjT5
	 i6c+JBtwu4OnTUdEpk0zNTd5CLx/y61z7UMccbIfHzhodvnjLvDrxscT2ywmV8E1uX
	 r5+nD0g3SiYN/Ct0gKulubAxpuyd5w2d5123F4Js=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728809AbgIEWgi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 5 Sep 2020 18:36:38 -0400
Received: from mail.kernel.org ([198.145.29.99]:48134 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728791AbgIEWga (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Sep 2020 18:36:30 -0400
Subject: Re: [GIT PULL] clang-format for v5.9-rc4
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1599345389;
        bh=oTU24XDpz3OQJtk65d1jVgZIvhTIPPYMFSZMGdTPOFQ=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=bGSXFvRg3apiP/6UaJEQuD8rkWajfeR7Y8Fbi44BAS1yHmj8CvUZMFhApr+j4EOAf
         nmf0lA0HJAuEph402EVMkDNiufvt7pwl1Ti4GyAEajmRpLuSWvjOHYYhwvm3VGPoN3
         vR46JGcnQ+RMqYGQhYEeH10DDRK3lwfyy+PjbpU4=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20200905114648.GA6048@gmail.com>
References: <20200905114648.GA6048@gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20200905114648.GA6048@gmail.com>
X-PR-Tracked-Remote: https://github.com/ojeda/linux.git tags/clang-format-for-linus-v5.9-rc4
X-PR-Tracked-Commit-Id: 4e4bb894467cd2a08fc3116407b13e6bc23a7119
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: dd9fb9bb3340c791a2be106fdc895db75f177343
Message-Id: <159934538995.12925.6319597420708323479.pr-tracker-bot@kernel.org>
Date:   Sat, 05 Sep 2020 22:36:29 +0000
To:     Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
        linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sat, 5 Sep 2020 13:46:48 +0200:

> https://github.com/ojeda/linux.git tags/clang-format-for-linus-v5.9-rc4

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/dd9fb9bb3340c791a2be106fdc895db75f177343

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
