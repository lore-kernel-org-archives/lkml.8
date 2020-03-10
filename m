Return-Path: <SRS0=K2g5=43=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A7BCC18E5A
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Mar 2020 22:40:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 10C0021927
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Mar 2020 22:40:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1583880009;
	bh=bv1LOEIUMDk94xJUo/qvqrgc8WpmpthHl23CoRZlaw8=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=jHRTD0f6bL5pNNBeR4t29e8Ca29AVcbIf1cPyi3OoHEec4XyOeSMi8wrHjzpJQVow
	 sjqvxTvSw33s/pWgozX4Xix8b8/YDBxMzhs30AH8sy09+8TEdKk0lDnqQey/9dbACa
	 apKd/CGO5ufXYu6037LGKKiV0sIIgxJIn0BlokAI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727834AbgCJWkH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Mar 2020 18:40:07 -0400
Received: from mail.kernel.org ([198.145.29.99]:32844 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726402AbgCJWkH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Mar 2020 18:40:07 -0400
Subject: Re: [GIT PULL] clang-format for v5.6-rc6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1583880006;
        bh=bv1LOEIUMDk94xJUo/qvqrgc8WpmpthHl23CoRZlaw8=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=FZHYtwqy8RpJublvJg6ueYbhlQ/HmxpXiP9obQjxh4hA1uJFD7IZZ/bMIrsQ000el
         0NPH8fqIRMeCX2pTmOg7ffbDcew6uPifSRZ7cyJUlOr3gQZIoqCGu0ZNTXbWxbA7hf
         mR4VhDrOtBBh4QK8bGK2PTrc6ef5Bw9zG4BzOvng=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20200310161556.GA17087@gmail.com>
References: <20200310161556.GA17087@gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20200310161556.GA17087@gmail.com>
X-PR-Tracked-Remote: https://github.com/ojeda/linux.git
 tags/clang-format-for-linus-v5.6-rc6
X-PR-Tracked-Commit-Id: 11a4a8f73b3ce71b32f36e9f1655f6ddf8f1732b
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: f35111a946548e3b34a55abbad3e9bacce6cb10f
Message-Id: <158388000665.13098.2125659062438326403.pr-tracker-bot@kernel.org>
Date:   Tue, 10 Mar 2020 22:40:06 +0000
To:     Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
        linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Tue, 10 Mar 2020 17:15:56 +0100:

> https://github.com/ojeda/linux.git tags/clang-format-for-linus-v5.6-rc6

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/f35111a946548e3b34a55abbad3e9bacce6cb10f

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
