Return-Path: <SRS0=HPGY=7U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69F87C433E0
	for <linux-kernel@archiver.kernel.org>; Sun,  7 Jun 2020 18:10:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 464F620663
	for <linux-kernel@archiver.kernel.org>; Sun,  7 Jun 2020 18:10:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1591553426;
	bh=AVSnVdn8QYqs2IJcyNcQPKgcRUvjXNi49B21zfNuAsQ=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=bLdNL+kR+FEx1y8PRCEFhDq50wQ4yl2+fXhGDtQDdOo2XYaHF+nxXfIsJb6n8t1L/
	 uvhP3Hy62C2Xk79aS1VraBdyc6AZ6x+jfaxVWzN9SnDbSkPIIt7kZjHLtiLmzuSBEc
	 jsWPtT8lDAwgP8vAi3aP9U7W+kPABNof5+aO65qg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729033AbgFGSKY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 7 Jun 2020 14:10:24 -0400
Received: from mail.kernel.org ([198.145.29.99]:56424 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729003AbgFGSKV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 7 Jun 2020 14:10:21 -0400
Subject: Re: [GIT PULL] Staging/IIO driver patches for 5.8-rc1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1591553420;
        bh=AVSnVdn8QYqs2IJcyNcQPKgcRUvjXNi49B21zfNuAsQ=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=iBpUlEZWoFxVXFytOBR5h0pAXgKlEGU85iVtOdT2+oqb+aVOWs06MNg2eDWSShsTq
         3IiRV2jNJRpKFuH4TyK7MDIuoSdhLYpbnz/JhF864+Mhf6gND1qtaccSljEWFzf0lF
         vnG1DFRVsPfFZQwYk2PELLTUxMwhf8ulnIXurLaA=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20200607132747.GA168291@kroah.com>
References: <20200607132747.GA168291@kroah.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20200607132747.GA168291@kroah.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/staging.git
 tags/staging-5.8-rc1
X-PR-Tracked-Commit-Id: 77f55d1305c11fb729b88f2c3f7881ba0831fa6f
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 80ef846e9909f22ccdc2a4a6d931266cecce8b2c
Message-Id: <159155342087.28494.163613726871312579.pr-tracker-bot@kernel.org>
Date:   Sun, 07 Jun 2020 18:10:20 +0000
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        devel@linuxdriverproject.org, linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sun, 7 Jun 2020 15:27:47 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/staging.git tags/staging-5.8-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/80ef846e9909f22ccdc2a4a6d931266cecce8b2c

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
