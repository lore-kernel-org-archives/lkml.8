Return-Path: <SRS0=ixK5=7Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5978C433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Jun 2020 19:25:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8DC1920801
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Jun 2020 19:25:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1591989930;
	bh=9q/une9GhfDWGBwqN44FN6ZXiUpeqgY8P7Aw4ywlCLk=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=dPIW9lwYcYvqJWVL/DTs7R+4YQDMU+sW5C/ihS0k1H08Xg5D54R8ZRGgD95zbLqfR
	 uLk+E6hculLuCis3CCNMuasG3CsyL6FXR/DGGfbIY+Ob9eYBJYHNR2fuzDWihvE65A
	 a5RB2EPVeoUf0QN4msL4oe4x0us+deQZftAO3fkQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726414AbgFLTZ2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Jun 2020 15:25:28 -0400
Received: from mail.kernel.org ([198.145.29.99]:36742 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726393AbgFLTZ2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Jun 2020 15:25:28 -0400
Subject: Re: [GIT PULL] xen: branch for v5.8-rc1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1591989927;
        bh=9q/une9GhfDWGBwqN44FN6ZXiUpeqgY8P7Aw4ywlCLk=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=OT/zUEBtmlewIZxiIRqXsIJKlJcbjk1ofiB89Q0qTMR/T9oyWu5Ia200ifvU+E3yb
         mRvRVeW4IZV0jqIYlYWx+fwMpj/tWgUCYVNyJDm+Vji5nyWRCobywtenz7SFhso86a
         R3OSF35VvmWMcuud3GNK2Nxt9qm8o0w+0uF+dSoA=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20200612053747.13750-1-jgross@suse.com>
References: <20200612053747.13750-1-jgross@suse.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20200612053747.13750-1-jgross@suse.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/xen/tip.git
 for-linus-5.8b-rc1-tag
X-PR-Tracked-Commit-Id: a952f64d14e5f8461f04cd9d729037db9099ddb0
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: d2d5439df22f3c2a07c5db582d4ef1b2b587ca27
Message-Id: <159198992784.4050.12743890623621670472.pr-tracker-bot@kernel.org>
Date:   Fri, 12 Jun 2020 19:25:27 +0000
To:     Juergen Gross <jgross@suse.com>
Cc:     torvalds@linux-foundation.org, linux-kernel@vger.kernel.org,
        xen-devel@lists.xenproject.org, boris.ostrovsky@oracle.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 12 Jun 2020 07:37:47 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/xen/tip.git for-linus-5.8b-rc1-tag

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/d2d5439df22f3c2a07c5db582d4ef1b2b587ca27

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
