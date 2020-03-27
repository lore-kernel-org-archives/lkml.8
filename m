Return-Path: <SRS0=s8dx=5M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4056C2D0E8
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Mar 2020 21:40:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7A40D2071B
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Mar 2020 21:40:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1585345203;
	bh=TY7P5d5edbnMhkbhgi62QGmhGXd/DzW+Rqe8AgkY9rI=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=eH6zFs8cnixs+CVirU28McrHH30dXWULRN+7Xc9575P6NwSlV0tLfKbTT2HFb353R
	 xMi+2apIxfwnYT0EWfEZXLnrT0FmWgRQhVi0sHQkcNsnoQsCnODh3lQNCFu7bIvWJD
	 VhuLs/DR9BCCkwbNc3Rdnp91QAPhTt17SuGo2wFM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727729AbgC0VkC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Mar 2020 17:40:02 -0400
Received: from mail.kernel.org ([198.145.29.99]:59988 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727652AbgC0VkC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Mar 2020 17:40:02 -0400
Subject: Re: [GIT PULL] parisc architecture fix for kernel v5.6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1585345201;
        bh=TY7P5d5edbnMhkbhgi62QGmhGXd/DzW+Rqe8AgkY9rI=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=Bhc64j73RVg0DHGeTSqetjriaSoB0mMPVsympF3fKVlX52M+inHBiyAmjWPVT5L0A
         SsiEfqe7O+GdDpd+vZ73M//FmL5BMZpBxC23SHIqTjBUev7ixyK0yb3YSLV41J5Ky1
         8AvwzH766qUcHciccrFb01QkN9ezschdk3PDsuek=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20200327210615.GA25160@ls3530.fritz.box>
References: <20200327210615.GA25160@ls3530.fritz.box>
X-PR-Tracked-List-Id: <linux-parisc.vger.kernel.org>
X-PR-Tracked-Message-Id: <20200327210615.GA25160@ls3530.fritz.box>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/deller/parisc-linux.git
 parisc-5.6-2
X-PR-Tracked-Commit-Id: ededa081ed203165cea441fca706bdf358026bab
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 69c5eea3128e775fd3c70ecf0098105d96dee330
Message-Id: <158534520175.30868.17955849616976139806.pr-tracker-bot@kernel.org>
Date:   Fri, 27 Mar 2020 21:40:01 +0000
To:     Helge Deller <deller@gmx.de>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-parisc@vger.kernel.org,
        James Bottomley <James.Bottomley@hansenpartnership.com>,
        John David Anglin <dave.anglin@bell.net>,
        Guenter Roeck <linux@roeck-us.net>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 27 Mar 2020 22:06:15 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/deller/parisc-linux.git parisc-5.6-2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/69c5eea3128e775fd3c70ecf0098105d96dee330

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
