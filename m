Return-Path: <SRS0=NqQd=7Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6B97C433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Jun 2020 01:50:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7EA68207ED
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Jun 2020 01:50:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1591840226;
	bh=UkomBBFKEy6mr/Yt72L+NB9xj5N2wGrKTzOcdmIBG5I=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=vP/nOOHv5GiTvMxuDQYI9EALwoeGmd5FPBf4C0jGBYzqAgtHcYTFU+Fj0TBP2hDRE
	 nJWXw/iDmn3iFLD0PlJjmHtSUw1L3OkAN6DKhohJ2gKXeTuk+Tb6TrwH/NiM4FunzO
	 yDb96/KwFY/EUWIq6BJ7rhfbCUxZntZtUqMsh2hw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726482AbgFKBuZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Jun 2020 21:50:25 -0400
Received: from mail.kernel.org ([198.145.29.99]:53562 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726268AbgFKBuY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Jun 2020 21:50:24 -0400
Subject: Re: [git pull] uaccess misc
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1591840223;
        bh=UkomBBFKEy6mr/Yt72L+NB9xj5N2wGrKTzOcdmIBG5I=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=Cz3o8DeTZfRokk4uomQKg52umlP/rrPL2NhaJqH89fdoveqFNpnxj2d1MuuoDUYlz
         qTboLbb/55tYa+tcRZ7ymwdUjzLxc2/KdGOLIqIRJ3MZDg/M50eT1veQIiYXzGmysG
         2z0kncMOqX2D5fwW6qtNj1Je/Xgg/3rHOTG88Kwo=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20200610202509.GT23230@ZenIV.linux.org.uk>
References: <20200610202509.GT23230@ZenIV.linux.org.uk>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20200610202509.GT23230@ZenIV.linux.org.uk>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/viro/vfs.git uaccess.misc
X-PR-Tracked-Commit-Id: b7e4b65f3fe92abbf4a1f57987a54c820969aebd
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 4382a79b2746faf9db98a34ae1a1cbd364473f75
Message-Id: <159184022383.24802.1000748704629192996.pr-tracker-bot@kernel.org>
Date:   Thu, 11 Jun 2020 01:50:23 +0000
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Wed, 10 Jun 2020 21:25:09 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/viro/vfs.git uaccess.misc

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/4382a79b2746faf9db98a34ae1a1cbd364473f75

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
