Return-Path: <SRS0=xNW4=3S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6642C2D0DB
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Jan 2020 19:00:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9F7BA20716
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Jan 2020 19:00:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1580324423;
	bh=eBgXwRh/wRWbX3dnax6XOyXa3N3rcto8IsRZVRpUIdg=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=aMjUKqS/yk9Lp3EOgbxe2/WfW/HgSp3oTR12MhLFgJwVRhUemhT2X11q45It89kOp
	 Vk5r+ol1PJ77T1Gl1VK+9GN1syXEGPwE7fn9fH//JgwteR6S0Y7fScT63u/WayqF4q
	 5gZ5p6xRWSlK8qUv6exzZRN9eiaNdYam+LDNfEbY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728012AbgA2TAW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Jan 2020 14:00:22 -0500
Received: from mail.kernel.org ([198.145.29.99]:54290 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727941AbgA2TAJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jan 2020 14:00:09 -0500
Subject: Re: [GIT PULL] Driver core patches for 5.6-rc1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1580324409;
        bh=eBgXwRh/wRWbX3dnax6XOyXa3N3rcto8IsRZVRpUIdg=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=MjXKOXDlIdHjUrnHtOryjcTwfx65VXTyj5lsqFUG1uxrWXCbVZjhUNiM6XP+Izy/Q
         yyrmyv751kX/oUODw05iIaEK7PeNcvxnQ+cMazKtwI7nNscjpJIvhys1igtEGav2nr
         jcZa//q7CdikS6uHiiZyFlnbY/7mPPnZwcRCWOWw=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20200129101503.GA3858516@kroah.com>
References: <20200129101503.GA3858516@kroah.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20200129101503.GA3858516@kroah.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/driver-core.git
 tags/driver-core-5.6-rc1
X-PR-Tracked-Commit-Id: 85db1cde825344cc1419d3adadaf4187154ad687
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 975f9ce9a067a82b89d49e63938e01b2773ac9d4
Message-Id: <158032440952.15518.2767280079393798805.pr-tracker-bot@kernel.org>
Date:   Wed, 29 Jan 2020 19:00:09 +0000
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org,
        Stephen Rothwell <sfr@canb.auug.org.au>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Wed, 29 Jan 2020 11:15:03 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/driver-core.git tags/driver-core-5.6-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/975f9ce9a067a82b89d49e63938e01b2773ac9d4

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
