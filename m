Return-Path: <SRS0=gmpU=CI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B619C433E7
	for <linux-kernel@archiver.kernel.org>; Sun, 30 Aug 2020 19:17:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2430120757
	for <linux-kernel@archiver.kernel.org>; Sun, 30 Aug 2020 19:17:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1598815041;
	bh=uPK22HGZot4BHcwc8gdYNjwRjlUaWFeQFsEuHzRf7g0=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=xbZhuORd9FnCkHYpucQc9H5ikVWNeqxGHRGNnebPWHzEhdkrsU3ETc1GeGHJAwKX9
	 9Y1HIqu/cG0+oKyJZphUXgoiNZNYtVO8BItuSOorvqp4qDF22eKW1966jgV0HhJm7W
	 4XMzO+dZMt8yVGzlvS/YVKecLSwU//TFIC48RdOs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727831AbgH3TRQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 30 Aug 2020 15:17:16 -0400
Received: from mail.kernel.org ([198.145.29.99]:44488 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726618AbgH3TPf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Aug 2020 15:15:35 -0400
Subject: Re: [GIT pull] irq/urgent for v5.9-rc2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598814935;
        bh=uPK22HGZot4BHcwc8gdYNjwRjlUaWFeQFsEuHzRf7g0=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=PAFTKrLCwIISFSyqlxXQaKV94eYxgjwpZVF8F23BB/Df0RDsLoUcjqZHT+cBeLx9y
         f5FTkq/b9Q368JMSdsi+Erei16INPecAo/QXEo0QZvemthGqYlJcpirUJQyKK87Yw1
         NPBkQUZTpu2Yl5uMXmPbgq8XWJYLRtVYff+xc0Bg=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <159881061564.27993.11909051048930389391.tglx@nanos>
References: <159881061564.27993.11909051048930389391.tglx@nanos>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <159881061564.27993.11909051048930389391.tglx@nanos>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git irq-urgent-2020-08-30
X-PR-Tracked-Commit-Id: ceb2465c51195967f11f6507538579816ac67cb8
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: d2283cdc18d3378587f9d05be4fd1818059a757a
Message-Id: <159881493515.11576.10402219451006342945.pr-tracker-bot@kernel.org>
Date:   Sun, 30 Aug 2020 19:15:35 +0000
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, x86@kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sun, 30 Aug 2020 18:03:35 -0000:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git irq-urgent-2020-08-30

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/d2283cdc18d3378587f9d05be4fd1818059a757a

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
