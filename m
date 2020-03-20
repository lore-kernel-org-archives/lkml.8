Return-Path: <SRS0=Xzqw=5F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC8F2C4332B
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Mar 2020 17:15:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B708120781
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Mar 2020 17:15:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1584724512;
	bh=sPeqxLPkY9jSvH+bYEQ4W17WiSseeSfNtqCCKyBEL1Q=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=wJ2DZ1ey0S4qcjHOk9RObYIGvCYCg0ChjgON397SgYAfOeOeyqu0QqJLHzxVR6HIb
	 LcQ+LcOOVzhXYZIO7YXabiVnffAjKzoEHmK1o+nU6g1wWQlh3xMdlVRP0OaqU2c7Wo
	 0dvTgF4ZXySBS04gqqzF5cLHS/hQ+nWJfibeMUac=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727323AbgCTRPL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Mar 2020 13:15:11 -0400
Received: from mail.kernel.org ([198.145.29.99]:46684 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727259AbgCTRPJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Mar 2020 13:15:09 -0400
Subject: Re: [GIT PULL] USB fixes for 5.6-rc7
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1584724509;
        bh=sPeqxLPkY9jSvH+bYEQ4W17WiSseeSfNtqCCKyBEL1Q=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=KurSclTMfJ+D0SHE+BWwvhLeR83I+tLoJu3FIhhckXDkCoYpLYpilOc2Ol3PTHJpr
         R++YoSpaS0UpF0wKy1sGcSpNLXM5zm3B5a9IJM3bw+xbRkxmlXiqjSC8b/R7rZk9x5
         fpn/+SdiuycGdHcIpOIjSkcagT65LdyLZM6fjMms=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20200320142739.GA760409@kroah.com>
References: <20200320142739.GA760409@kroah.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20200320142739.GA760409@kroah.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/usb.git tags/usb-5.6-rc7
X-PR-Tracked-Commit-Id: 2866ce8696167de300e27d50d521b5f671bab5d4
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: b07c2e76c419fe7ac8949e5ffea4a29414291b7d
Message-Id: <158472450912.23492.1461265135513637898.pr-tracker-bot@kernel.org>
Date:   Fri, 20 Mar 2020 17:15:09 +0000
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 20 Mar 2020 15:27:39 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/usb.git tags/usb-5.6-rc7

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/b07c2e76c419fe7ac8949e5ffea4a29414291b7d

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
