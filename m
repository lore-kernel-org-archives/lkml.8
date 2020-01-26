Return-Path: <SRS0=fzvl=3P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1183C2D0DB
	for <linux-kernel@archiver.kernel.org>; Sun, 26 Jan 2020 19:30:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 823C220716
	for <linux-kernel@archiver.kernel.org>; Sun, 26 Jan 2020 19:30:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1580067004;
	bh=4gCJnciJ5nYwEKJy75rKr70Zoj55EufhJAneJ+Gc3lE=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=tpYLxwd/+cnEPuvArAkK612Hso1K7ecVOK1FkiEjXmYf3khOnKxEKL2H7LpNcreYG
	 7XRoZN87hIBQp7u9DuHPwQCYI9scqE4nXjjstAvcMohW86kkrPNiM7q1d/Pam3gzTL
	 xCQKKJ/Re6CUE48IQ3GysRjMt5d3KDKqtKJA/XwE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728904AbgAZTaD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 26 Jan 2020 14:30:03 -0500
Received: from mail.kernel.org ([198.145.29.99]:57532 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725838AbgAZTaD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Jan 2020 14:30:03 -0500
Subject: Re: [git pull] vfs.git fixes
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1580067002;
        bh=4gCJnciJ5nYwEKJy75rKr70Zoj55EufhJAneJ+Gc3lE=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=q8rSF1arcO2nh5d8YfAOfZoE68RgFCzpNrJZL8TVlxD+dNrkMfEO6g/nzLN+kBQ2h
         p8UGyFfnH26l+y8Pqn6tTzQfo3jenl5pKBgmmlTJol3Il4ZLJPmgnap3wptnYSTm3A
         YkyfUrycI9ji/XBQt+G60Mv0a7bz0agNCtNvAqy8=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20200126182517.GO23230@ZenIV.linux.org.uk>
References: <20200126182517.GO23230@ZenIV.linux.org.uk>
X-PR-Tracked-List-Id: <linux-fsdevel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20200126182517.GO23230@ZenIV.linux.org.uk>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/viro/vfs.git fixes
X-PR-Tracked-Commit-Id: d0cb50185ae942b03c4327be322055d622dc79f6
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: b1b298914f3ae226e99c98042c1648f740015724
Message-Id: <158006700275.5558.1959996691988543169.pr-tracker-bot@kernel.org>
Date:   Sun, 26 Jan 2020 19:30:02 +0000
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sun, 26 Jan 2020 18:25:17 +0000:

> git://git.kernel.org/pub/scm/linux/kernel/git/viro/vfs.git fixes

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/b1b298914f3ae226e99c98042c1648f740015724

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
