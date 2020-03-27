Return-Path: <SRS0=s8dx=5M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5DEFEC2D0E7
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Mar 2020 03:55:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 35AC9206F6
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Mar 2020 03:55:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1585281309;
	bh=YUbNBibbfrmEl/1mIpfiUjinUfmzDp+tKjmtDUXetrw=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=ZMSHyYilVR+Ik6cixxXqLZ2338NlDLZyWVQXalBIVidP9QrFR/wgnU2OAc3441sh2
	 0KRugTql87A9ufSYMkgL5FYStGI9bonQnaJwpGqLzHoEf2qFRxJXytAPZWsgT2C6x1
	 1ym8VIDH+cOjErLBUolfqv9O8ast+mT16Wn09LKY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727696AbgC0DzI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Mar 2020 23:55:08 -0400
Received: from mail.kernel.org ([198.145.29.99]:53256 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727509AbgC0DzH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Mar 2020 23:55:07 -0400
Subject: Re: [git pull] Input updates for v5.6-rc7
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1585281307;
        bh=YUbNBibbfrmEl/1mIpfiUjinUfmzDp+tKjmtDUXetrw=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=V2H+wWOzE/rdIhOx5nk6LWfn2oQFY6wkY4lZAxJ/lVlh2DWuWFPmQV6omXpWqL+Ne
         HT62UbtnrN95GDVdVfam745LjZ3kFea9QBK27bAoMpUMjxH49Z94fU7hcuhDHyuvAA
         HD+7c9P+fMUUGYpgafF6DZ40C7mfZ96QrM8xBz6I=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20200327023233.GA180354@dtor-ws>
References: <20200327023233.GA180354@dtor-ws>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20200327023233.GA180354@dtor-ws>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/dtor/input.git for-linus
X-PR-Tracked-Commit-Id: 4134252ab7e2c339a54302b88496cb5a89cdbaec
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: f3e69428b5e26b0851d7ef4c15859cffebf2b9de
Message-Id: <158528130722.10723.5001510742544875460.pr-tracker-bot@kernel.org>
Date:   Fri, 27 Mar 2020 03:55:07 +0000
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-input@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Thu, 26 Mar 2020 19:32:33 -0700:

> git://git.kernel.org/pub/scm/linux/kernel/git/dtor/input.git for-linus

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/f3e69428b5e26b0851d7ef4c15859cffebf2b9de

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
