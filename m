Return-Path: <SRS0=wESH=6W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D60AC38A2A
	for <linux-kernel@archiver.kernel.org>; Fri,  8 May 2020 16:15:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7640C24953
	for <linux-kernel@archiver.kernel.org>; Fri,  8 May 2020 16:15:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1588954510;
	bh=W/uDl22rAephmj1W1RzbAiC6vyZKBBkx+XoGmVuOhm4=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=VeroMT/Vve0icluYO84idbDZyPXhmOtCeGktbqMYlWtD4bfQYM8ZBusfMpRFEJ5fc
	 P2/FZfh/D1Zh13mdWUxSMMtdQ5TVsFvbrUKqCCp7j7+/LSXS3tqqTXo7jZCnvIFWvh
	 DvVt2fr9ivrq1GRf+pmsgyjvj2Vb9aGVDF6esm84=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728227AbgEHQPJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 May 2020 12:15:09 -0400
Received: from mail.kernel.org ([198.145.29.99]:39022 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728256AbgEHQPG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 May 2020 12:15:06 -0400
Subject: Re: [GIT PULL] Char/Misc driver fixes for 5.7-rc5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588954506;
        bh=W/uDl22rAephmj1W1RzbAiC6vyZKBBkx+XoGmVuOhm4=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=yriSWMp1QV4U6zLRV/U5hIHeIxwICfPxZqgxHidyHRb9CCoaH3YUeUqwUL8ZfUxlf
         BUa6azCqlydbtQLaEJG2zCydjeod5bRUZyZrprhbwGXjTW8ak208Fw7hfvtwF0c0jd
         tpq1Tu7S5b9JQrjogimaDuLz5Bpcc0kahU6qFg0s=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20200508141902.GA360776@kroah.com>
References: <20200508141902.GA360776@kroah.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20200508141902.GA360776@kroah.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/char-misc.git
 tags/char-misc-5.7-rc5
X-PR-Tracked-Commit-Id: f0e1d3ac2d7c16a5d2c9d67f5a61133db7681af8
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 4334f30ebf395b204c6cbeabf371a5a998d6ba7c
Message-Id: <158895450602.20886.16493366076911476168.pr-tracker-bot@kernel.org>
Date:   Fri, 08 May 2020 16:15:06 +0000
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 8 May 2020 16:19:02 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/char-misc.git tags/char-misc-5.7-rc5

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/4334f30ebf395b204c6cbeabf371a5a998d6ba7c

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
