Return-Path: <SRS0=bWCJ=AA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D3C3C433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jun 2020 19:30:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4B18820707
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jun 2020 19:30:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1592595034;
	bh=4CyzdlmLdjpkF3YA5KXNHCXDN/3S7EZxaRbD8U7Ho/U=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=BSfZvkcukbxbIZlugM8YyG4POhzy3u4WEpB0RvLGarWCxfFsw5aMj9sfuK0ZSVVXg
	 zZpWseG+OTHP6XJ8FvShEGVglP300jqdZ3NeICNcPed3Uhno+j8RUGTP610BHseC8o
	 cEHgwa7R3hjO6aQpXVVOiAPlmsnQglDlWUaoIaKA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388782AbgFSTad (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Jun 2020 15:30:33 -0400
Received: from mail.kernel.org ([198.145.29.99]:43816 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388587AbgFSTaX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Jun 2020 15:30:23 -0400
Subject: Re: [GIT PULL] Ceph fixes for 5.8-rc2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592595023;
        bh=4CyzdlmLdjpkF3YA5KXNHCXDN/3S7EZxaRbD8U7Ho/U=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=nSc60p4LAeEwEeUjmHsY2V9o4Fnj7Zog0uqUIPvVGWz6wntZgDr4ZjGB19/st/pA9
         ozLe2wHvEEnJrC9EIPUIaWuYrRjAV53+0oouZDTniPIgEjvclJ5M0NI7jnJEPKreqj
         FURZZlHy8ccBXybP4HFepxWqXBNI0HxulGj57gK0=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20200619123547.14353-1-idryomov@gmail.com>
References: <20200619123547.14353-1-idryomov@gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20200619123547.14353-1-idryomov@gmail.com>
X-PR-Tracked-Remote: https://github.com/ceph/ceph-client.git
 tags/ceph-for-5.8-rc2
X-PR-Tracked-Commit-Id: 7ed286f3e061ee394782bd9fb4ed96bff0b5a021
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 672f9255a727d04c98b05ba7af625ab7032c8028
Message-Id: <159259502339.2705.15825277458052180337.pr-tracker-bot@kernel.org>
Date:   Fri, 19 Jun 2020 19:30:23 +0000
To:     Ilya Dryomov <idryomov@gmail.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        ceph-devel@vger.kernel.org, linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 19 Jun 2020 14:35:47 +0200:

> https://github.com/ceph/ceph-client.git tags/ceph-for-5.8-rc2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/672f9255a727d04c98b05ba7af625ab7032c8028

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
