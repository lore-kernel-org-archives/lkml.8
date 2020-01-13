Return-Path: <SRS0=WByN=3C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1B33C33CA9
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jan 2020 00:55:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AD6AA22314
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jan 2020 00:55:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1578876904;
	bh=HMEpIO3iAVyKlv5kImX4HW06TyAK7WVzFHOTgbxj+NE=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=whlGwXdWbSLVyXCmG2wlMONvvD9sLySaTweep7qVVqHG0u4kZ3jt0wNv79Zbzx2R5
	 CQO3SYc7NOoC0hTk6pZpjxksIfFKRz8UiOW0rdp0pCr9jQpN5tG96DjVwMXNAk+eC+
	 5WWQBvXRavY6sIicMQnl0gdYBG3CDwn2DpIGrB64=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387585AbgAMAzD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 12 Jan 2020 19:55:03 -0500
Received: from mail.kernel.org ([198.145.29.99]:56144 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387502AbgAMAzD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Jan 2020 19:55:03 -0500
Subject: Re: [GIT PULL] RISC-V updates for v5.5-rc6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1578876902;
        bh=HMEpIO3iAVyKlv5kImX4HW06TyAK7WVzFHOTgbxj+NE=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=wVxzjZ8be2N/AbY0/Y3DZ6sqymqKFdp/Mh2qa0eAWZaYTVPJho6Z68HmrmMz6kPrp
         QDmwABIXcbpXvAA7fSfbuFo1mMC2FPG6nATHWOJfDeNwk9VnGDy8KXHiFEwX70dCcZ
         oj+xUlbWGRTT7dcAbqZxyb4na8G5C06e+5TnQ+SQ=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <alpine.DEB.2.21.9999.2001121053560.205587@viisi.sifive.com>
References: <alpine.DEB.2.21.9999.2001121053560.205587@viisi.sifive.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <alpine.DEB.2.21.9999.2001121053560.205587@viisi.sifive.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/riscv/linux.git
 tags/riscv/for-v5.5-rc6
X-PR-Tracked-Commit-Id: dc6fcba72f0435b7884f2e92fd634bb9f78a2c60
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 373adb7313b233d64e21f3f6329fb41a5e6ae180
Message-Id: <157887690279.24225.10430037868816805913.pr-tracker-bot@kernel.org>
Date:   Mon, 13 Jan 2020 00:55:02 +0000
To:     Paul Walmsley <paul.walmsley@sifive.com>
Cc:     torvalds@linux-foundation.org, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sun, 12 Jan 2020 10:55:14 -0800 (PST):

> git://git.kernel.org/pub/scm/linux/kernel/git/riscv/linux.git tags/riscv/for-v5.5-rc6

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/373adb7313b233d64e21f3f6329fb41a5e6ae180

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
