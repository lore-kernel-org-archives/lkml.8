Return-Path: <SRS0=y5Sx=A3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9C65C433E4
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jul 2020 19:05:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C101F2076A
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jul 2020 19:05:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1594926308;
	bh=icy71BK8WmLM0oN0RBTEpa0yAsU5VgxxYcdJWSaQsdE=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=K8RDVmbfpLl6ZxRtqriB2j3WBOGFad5Ig/eK6OnZrcrKcvgSliZkq8jjICQuF29Ou
	 uUOpd27Nli7SbuN3J7/qQVXum7yoRDI//9Rux2MxEi68Hj3jwzkuxOdG0JOD1FNMa8
	 bgDjqFV7eaiex0jM4nO5sGGEmr0z5mEoxuQpcavU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729603AbgGPTFH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Jul 2020 15:05:07 -0400
Received: from mail.kernel.org ([198.145.29.99]:60106 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729148AbgGPTFE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jul 2020 15:05:04 -0400
Subject: Re: [GIT PULL] TTY/Serial driver fixes for 5.8-rc6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1594926304;
        bh=icy71BK8WmLM0oN0RBTEpa0yAsU5VgxxYcdJWSaQsdE=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=n7OkU1LOKjkZRuvwpIJsMN26tAOmgoAgweyyfQJCipTuh6VH+W12pOX8SsKbQudpe
         3HScjn2eX9NR6ybQi4pB4GjgVEU0hS8xShAST7LWyr0pEWY1HOe2JDfM5dXBw/CBnu
         9rqFezxkaOFQLnoYYBctYXSaE7+TWLuvzl6tOoKU=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20200716152917.GA2378726@kroah.com>
References: <20200716152917.GA2378726@kroah.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20200716152917.GA2378726@kroah.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/tty.git tags/tty-5.8-rc6
X-PR-Tracked-Commit-Id: f743061a85f5e9989df22ccbf07c80c98fc90e08
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 7531ee3147ed2fad5d5bbbd22880eea969dfc291
Message-Id: <159492630433.21154.1783585763333696680.pr-tracker-bot@kernel.org>
Date:   Thu, 16 Jul 2020 19:05:04 +0000
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Jiri Slaby <jslaby@suse.cz>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Thu, 16 Jul 2020 17:29:17 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/tty.git tags/tty-5.8-rc6

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/7531ee3147ed2fad5d5bbbd22880eea969dfc291

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
