Return-Path: <SRS0=kGB5=CE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3B28C433E1
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Aug 2020 18:34:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A380D2078D
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Aug 2020 18:34:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1598466865;
	bh=pFCKkYkRl6Q7QCAzdDuMZrVZN8ZTnPedKYVWXpg2RWo=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=XeOk+9btWbWOOFl3iAtr5nK+fTytco4uydCmD1uiklaZ2VHHS1R2LVlGj+zuk16CL
	 ApB5KiYM9atA5xDyVekGRk2GhBnm83RlBZdssnzHgLC9FHb1zJwvgF1zIBh1UWTRh8
	 OFERwQZLSwMMjItSxoTW9eHej17TzIIHHr+9Mn4c=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727780AbgHZSeY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Aug 2020 14:34:24 -0400
Received: from mail.kernel.org ([198.145.29.99]:41738 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726878AbgHZSeR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Aug 2020 14:34:17 -0400
Subject: Re: [GIT PULL] Char/Misc driver fixes for 5.9-rc3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598466856;
        bh=pFCKkYkRl6Q7QCAzdDuMZrVZN8ZTnPedKYVWXpg2RWo=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=SjdxneVz7QVsMPZZG4ZoxUqkv/JzFJXe6tFPgx5i+KPtl+Bm2kJ1rdJzEyd3Y2dgh
         OFh0Fpwu/vddoBD/3z4qOy7Vx7Ejm/8EapVqqW68U5XQKJVVvXkqBf19jC9H5EK1CO
         o9A74o2QgxPyS1NvsffJmbqTMsYBdsbctLW8DvkI=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20200826134211.GA3881983@kroah.com>
References: <20200826134211.GA3881983@kroah.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20200826134211.GA3881983@kroah.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/char-misc.git tags/char-misc-5.9-rc3
X-PR-Tracked-Commit-Id: 9c97cecab0d49e40460d9b5230ab4bf036f59491
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 27563ab6ef75abc64b7da2c7a321b7edd89dfcf7
Message-Id: <159846685683.8056.6162061380278635629.pr-tracker-bot@kernel.org>
Date:   Wed, 26 Aug 2020 18:34:16 +0000
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Wed, 26 Aug 2020 15:42:11 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/char-misc.git tags/char-misc-5.9-rc3

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/27563ab6ef75abc64b7da2c7a321b7edd89dfcf7

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
