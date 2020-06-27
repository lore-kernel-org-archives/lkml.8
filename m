Return-Path: <SRS0=QqoS=AI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1DFCC433E3
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Jun 2020 20:25:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A10402067D
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Jun 2020 20:25:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1593289524;
	bh=fbYrsCer1z/zOX2JYA572ehcuYvqaX/yYNi9GFDg5+w=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=CfB7YKrPvcCuaoldsNytqMNH/CHChV5/e8Aepu7IGa2VfmRJVqphwrsK76mDJY3Z/
	 bTGKec2WLnZbyOKx86Gz7+bLvgUcJzkzCSLPK9L/bqeVHcmqd98JGXROrUhxHu+cOK
	 0OG9dvghhFhcVF3UtfuxF1Lke+wARfgQpysRZbGU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726909AbgF0UZT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 27 Jun 2020 16:25:19 -0400
Received: from mail.kernel.org ([198.145.29.99]:40262 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726715AbgF0UZO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 Jun 2020 16:25:14 -0400
Subject: Re: [GIT PULL] USB driver fixes for 5.8-rc3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1593289514;
        bh=fbYrsCer1z/zOX2JYA572ehcuYvqaX/yYNi9GFDg5+w=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=EUADxNKfjeVbu/GialC1j+2HjZgEUGj4QBpEnS4MPKuATl9PFxaSzZftPR1GrqNwx
         SKlFN7Vi6B9Yw3DM76Sa46Lxmz+Bwd/IMLu9IIzcterdEVGuz95HRqehpLpg8Yk0vp
         9ZsIoFz56lvYIF3oulZdnfqAvsmOnZ6WvhPKe3j8=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20200627114013.GA1636882@kroah.com>
References: <20200627114013.GA1636882@kroah.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20200627114013.GA1636882@kroah.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/usb.git tags/usb-5.8-rc3
X-PR-Tracked-Commit-Id: ed8fa04243e22f7b8f470d08e5806c9f8c6a460a
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 7eb8f53b8afe87a7993c9d71d3d01bb97c50bd0a
Message-Id: <159328951427.11719.1463054512484214153.pr-tracker-bot@kernel.org>
Date:   Sat, 27 Jun 2020 20:25:14 +0000
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sat, 27 Jun 2020 13:40:13 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/usb.git tags/usb-5.8-rc3

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/7eb8f53b8afe87a7993c9d71d3d01bb97c50bd0a

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
