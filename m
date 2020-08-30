Return-Path: <SRS0=gmpU=CI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0CE1EC433E7
	for <linux-kernel@archiver.kernel.org>; Sun, 30 Aug 2020 19:15:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DCF3E20757
	for <linux-kernel@archiver.kernel.org>; Sun, 30 Aug 2020 19:15:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1598814933;
	bh=/TH6jSnK48SMc2KpuWvdXeXdpDFfMz53qEWnp34BeF4=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=msrQVEZdEKHjZKL7UaWAzKEuuBpL0/Uy205oSc00y4hH9ukrnqs2glkQK2jvCw3QC
	 c1G9HUN+TrBwC788gxgfTp5kSmJDh94+pO3u0IKFk1uBfePjqJMujDEcx/pRDAGnwi
	 0LE+KppW6iVXUu8kozFrlZ51oXltsXWz3F4VyfIA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726595AbgH3TPb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 30 Aug 2020 15:15:31 -0400
Received: from mail.kernel.org ([198.145.29.99]:44234 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726178AbgH3TPV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Aug 2020 15:15:21 -0400
Subject: Re: [GIT PULL] USB fixes for 5.9-rc3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598814921;
        bh=/TH6jSnK48SMc2KpuWvdXeXdpDFfMz53qEWnp34BeF4=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=zLHlXTN6mFF2OLq73Nx1YQKNVU+4qNxB3MTI1hiLn2AQ2DQJ9UvpIBlmIxYL+Semi
         i/DI8PDK9N4ACgpYIudtGIkLo9oo3B/2umdwq4JIteP1nLn5vpmnR7QZLoBbeaDdGb
         ENPJDmyOnUQqIUGnhsCquO6cYLp0mbbC95XFr0Mg=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20200826134315.GA3882506@kroah.com>
References: <20200826134315.GA3882506@kroah.com>
X-PR-Tracked-List-Id: <linux-usb.vger.kernel.org>
X-PR-Tracked-Message-Id: <20200826134315.GA3882506@kroah.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/usb.git tags/usb-5.9-rc3
X-PR-Tracked-Commit-Id: 23e26d0577535f5ffe4ff8ed6d06e009553c0bca
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 068834a2773b6a12805105cfadbb3d4229fc6e0a
Message-Id: <159881492157.11937.12778329216839262691.pr-tracker-bot@kernel.org>
Date:   Sun, 30 Aug 2020 19:15:21 +0000
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Wed, 26 Aug 2020 15:43:15 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/usb.git tags/usb-5.9-rc3

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/068834a2773b6a12805105cfadbb3d4229fc6e0a

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
