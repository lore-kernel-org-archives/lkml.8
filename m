Return-Path: <SRS0=n+Ub=5Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 916E8C2BA19
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Apr 2020 20:00:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6227520730
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Apr 2020 20:00:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1586462429;
	bh=S06Ker0AUMFzpVFs0Ly9cgPbaixlj2GldLgaC6kXGoY=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=WDvNUWzuxhE0Rw9Gur7RAr6zR26IwugGZNKAp1Ge2gp7fK4g9ST7EERL17aTHfDrb
	 5Zlhni7cEnxJpE+TMq+K55Z5synNQkUUSEkN9bRGMTlTsKMDRyFiEjhDyQMvgGpR88
	 nA5f442NLB6OxrGWwnFj7rtD0ks98OOWiLXR2ZXA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726857AbgDIUA1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Apr 2020 16:00:27 -0400
Received: from mail.kernel.org ([198.145.29.99]:36528 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726638AbgDIUA1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Apr 2020 16:00:27 -0400
Subject: Re: [GIT PULL] Modules updates for v5.7
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1586462427;
        bh=S06Ker0AUMFzpVFs0Ly9cgPbaixlj2GldLgaC6kXGoY=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=ojttuttxXX5VrFDfT8GXFA2nzSX0fp5qrYWhibLgqxWulPtc5idllrDeV3SpmYGX9
         ZwtqO7WizzKLlPaBtSqfXmuHCO6d5d43DSVUymDUb6Agb7arJX6z1JKFcfQ3jl0fVO
         YV63E5Pz9+MMLQZKvKFw2CAOydIeigitCrcuXoJw=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20200409091323.GC26619@linux-8ccs>
References: <20200409091323.GC26619@linux-8ccs>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20200409091323.GC26619@linux-8ccs>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/jeyu/linux.git
 tags/modules-for-v5.7
X-PR-Tracked-Commit-Id: 0f74226649fb2875a91b68f3750f55220aa73425
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: c0cc271173b2e1c2d8d0ceaef14e4dfa79eefc0d
Message-Id: <158646242770.17533.13954751309242498705.pr-tracker-bot@kernel.org>
Date:   Thu, 09 Apr 2020 20:00:27 +0000
To:     Jessica Yu <jeyu@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Thu, 9 Apr 2020 11:13:23 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/jeyu/linux.git tags/modules-for-v5.7

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/c0cc271173b2e1c2d8d0ceaef14e4dfa79eefc0d

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
