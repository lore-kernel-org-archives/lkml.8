Return-Path: <SRS0=3sb/=3H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C5D6C32771
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Jan 2020 20:20:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0FF4C2469D
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Jan 2020 20:20:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1579378818;
	bh=zdUuFfwPjw56piFdlZ0Rx7UoMad348euLk8S62p3gCk=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=OSaXhoGWOK4XyLp4sZYdVOCk6cRUYAwT3pPiz881viswqcSSHIoCkVy2KxY5F2w0n
	 kllMDu1OBFhoZ7ocDfPUWB1jY3I2beyd2CqXtOOP5TclJE/1NZOuIXX4TudMGM4itj
	 RIKQ7KzSB/3VjfhN8gnbKZhLwCXJuNT+sGsDuYSg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729073AbgARUUR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 18 Jan 2020 15:20:17 -0500
Received: from mail.kernel.org ([198.145.29.99]:42324 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727573AbgARUUE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Jan 2020 15:20:04 -0500
Subject: Re: [GIT PULL] Char/Misc driver fixes for 5.5-rc7
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1579378803;
        bh=zdUuFfwPjw56piFdlZ0Rx7UoMad348euLk8S62p3gCk=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=sm3qqZxN4+GtYh4yRFbOfnVJd5eztHSmRsitM3SIANc3rSSpyGBS0vwWOs+5eEDOi
         0h7cl3J5ZDLtUtVzZtvdhqShKm5kFMl3wVxr5VRWchw4B80bMPb+Gk79mA9td+iXdk
         sOnbIrND8+o1uZ0HTXY54wG7xQFL198lZoNXiC7U=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20200118142326.GA80220@kroah.com>
References: <20200118142326.GA80220@kroah.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20200118142326.GA80220@kroah.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/char-misc.git
 tags/char-misc-5.5-rc7
X-PR-Tracked-Commit-Id: fb85145c04447035c07cd609302d6996eb217a1d
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: f04dba64d667419493d1f9aadd50b19860312b6c
Message-Id: <157937880375.12197.6844839879598223384.pr-tracker-bot@kernel.org>
Date:   Sat, 18 Jan 2020 20:20:03 +0000
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sat, 18 Jan 2020 15:23:26 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/char-misc.git tags/char-misc-5.5-rc7

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/f04dba64d667419493d1f9aadd50b19860312b6c

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
