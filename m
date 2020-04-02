Return-Path: <SRS0=iZC5=5S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4AC4AC43331
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Apr 2020 22:45:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1CA2420757
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Apr 2020 22:45:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1585867519;
	bh=xL8DcdY/HvHwbNpAvbFwdMUTMx6kSTf9oiT7uBAya2M=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=tSqXuTBuNuh7g7y7StAhvxVVQvY/SHzdcRc5NzcoeetlcJwoNoObF/X4/aeeatWHZ
	 mcnOt8UqKWzDCerVGpCkemYzJ7PHjVJF150+9+qSsLiUqNp/715ygJ6zkBUsKK2ob5
	 cUZRVdmW4MgKp8bOjVvmAQKTYINr7GELddoFXk4A=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390365AbgDBWpS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Apr 2020 18:45:18 -0400
Received: from mail.kernel.org ([198.145.29.99]:37616 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390352AbgDBWpR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Apr 2020 18:45:17 -0400
Subject: Re: [GIT PULL] x86 fix
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1585867516;
        bh=xL8DcdY/HvHwbNpAvbFwdMUTMx6kSTf9oiT7uBAya2M=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=QTET95y/3fhl5mk3bJfsyK6NHPNYI7vFH6BqWEnwy12/WmqE65yXCOsERQ3GHbIL9
         ZJR8JUODnEbA7KSn1tysgkHvRR+6I6q99BTA3jznPZJj0AdUCFSdYyKai7rcBvR9u0
         12tznLrFbvQLa/6CfNj1vQUJ4ELlRB60Wg9Bvs3c=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20200402095125.GA21592@gmail.com>
References: <20200402095125.GA21592@gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20200402095125.GA21592@gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git
 x86-urgent-2020-04-02
X-PR-Tracked-Commit-Id: 1651e700664b4597ddf4f8adfe435252a0d11277
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: f14a9532ee30c68a56ff502c382860f674cc180c
Message-Id: <158586751659.2810.18180834461022424328.pr-tracker-bot@kernel.org>
Date:   Thu, 02 Apr 2020 22:45:16 +0000
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Andrew Morton <akpm@linux-foundation.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Thu, 2 Apr 2020 11:51:26 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86-urgent-2020-04-02

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/f14a9532ee30c68a56ff502c382860f674cc180c

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
