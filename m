Return-Path: <SRS0=pusq=BO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E1B8C433E0
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Aug 2020 21:40:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7A6B522CA1
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Aug 2020 21:40:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1596577215;
	bh=1Z/hgMUTKsJFFf+z1KUINoL4+XYMgzWonTZBdmSEQFk=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=EvjyR63XAeSxhZxBUbwPNBPxFCNGBVYCiLgL3TqPRto2L7wvKXR6RBG/WwK9JXhBz
	 ANC7qQRus2gwvg6orm8kRltTRXrg+iUeOYqpra6dRnhB7Bug1LQfB7SWZJJmpm57l5
	 fX73Q0unvtsX7EvmKfte/hRiPz54NST2F20a91nI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728338AbgHDVkO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Aug 2020 17:40:14 -0400
Received: from mail.kernel.org ([198.145.29.99]:51946 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728294AbgHDVkL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Aug 2020 17:40:11 -0400
Subject: Re: [GIT PULL] seccomp updates for v5.9-rc1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1596577211;
        bh=1Z/hgMUTKsJFFf+z1KUINoL4+XYMgzWonTZBdmSEQFk=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=lZ2nHok296YdTrADXEa0mMsA4YmxtN0ZmE5XELz/HW+JEF9gvgs1M8dL6lDtyFEk3
         1ew7uhUqbp6EyACopc7pOALbL3hcnlM8S/wxtxTLZqLsnWEL3FZKApqSRnZ+Km8/XD
         nX/XIgQ+F8eLaEovQvpPz7TNfqZL+VQKCKCllRT4=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <202008031231.0D9CBD0FD@keescook>
References: <202008031231.0D9CBD0FD@keescook>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <202008031231.0D9CBD0FD@keescook>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/kees/linux.git
 tags/seccomp-v5.9-rc1
X-PR-Tracked-Commit-Id: c97aedc52dce4c87d4c44de4e6af941cd102600c
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 9ecc6ea491f0c0531ad81ef9466284df260b2227
Message-Id: <159657721137.17686.13475565214310463918.pr-tracker-bot@kernel.org>
Date:   Tue, 04 Aug 2020 21:40:11 +0000
To:     Kees Cook <keescook@chromium.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, Aleksa Sarai <cyphar@cyphar.com>,
        Chris Palmer <palmer@google.com>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Christoph Hellwig <hch@lst.de>,
        Matt Denton <mpdenton@google.com>,
        Robert Sesek <rsesek@google.com>,
        Thadeu Lima de Souza Cascardo <cascardo@canonical.com>,
        Sargun Dhillon <sargun@sargun.me>,
        Shuah Khan <shuah@kernel.org>, Tycho Andersen <tycho@tycho.ws>,
        Will Deacon <will@kernel.org>, Will Drewry <wad@chromium.org>,
        Yonghong Song <yhs@fb.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Mon, 3 Aug 2020 12:39:30 -0700:

> https://git.kernel.org/pub/scm/linux/kernel/git/kees/linux.git tags/seccomp-v5.9-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/9ecc6ea491f0c0531ad81ef9466284df260b2227

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
