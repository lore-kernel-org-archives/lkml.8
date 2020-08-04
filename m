Return-Path: <SRS0=pusq=BO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE3E4C433E0
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Aug 2020 03:20:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C66622065E
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Aug 2020 03:20:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1596511210;
	bh=XsXsjJVHdIBvKakMjHO5X0hvvk6NGl3JChFxsgjmrQY=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=lmVumKboFeviauYxHVpQBTC3ePbSLhR5SYgssIP6k/mDXydqA3knMfYKcrgBqyXd4
	 oE3We6BZF5+cykRzGWZxBjEnrzST3e2txEFb+p3N27kXqqLbDOggy9+36WrLuRFBsP
	 Nb/6IIKmw/E6q5NPP4XhIIOfbDwc1xw2RdT4KUYc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729834AbgHDDUJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Aug 2020 23:20:09 -0400
Received: from mail.kernel.org ([198.145.29.99]:39938 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729648AbgHDDUI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Aug 2020 23:20:08 -0400
Subject: Re: [GIT PULL] regulator updates for v5.9
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1596511208;
        bh=XsXsjJVHdIBvKakMjHO5X0hvvk6NGl3JChFxsgjmrQY=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=GlpJ+wbkKeIq+6FbDwxAWvfPNnAl7wfzvM1UFBNhyUe4qgbwGgkcZ4BY1Y1ZOEXjv
         F4ll2rKE2HXZhdClXOOWy/9CHgffg7zD3gIcgVjMlhcIAdieaotSJhMidbC9PHymHb
         NGE2p15teFQypyq9ZGJEHi7IJnLVDQYafBywXWmQ=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20200803124010.C7F9320678@mail.kernel.org>
References: <20200803124010.C7F9320678@mail.kernel.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20200803124010.C7F9320678@mail.kernel.org>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git
 tags/regulator-v5.9
X-PR-Tracked-Commit-Id: 3f02794888213efb224ef8e38d5d0e0f74b95416
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: bbb839901fe865a56d91aa88d70908a7d16268a1
Message-Id: <159651120852.27006.9268291150552633842.pr-tracker-bot@kernel.org>
Date:   Tue, 04 Aug 2020 03:20:08 +0000
To:     Mark Brown <broonie@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Mon, 03 Aug 2020 13:39:15 +0100:

> https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git tags/regulator-v5.9

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/bbb839901fe865a56d91aa88d70908a7d16268a1

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
