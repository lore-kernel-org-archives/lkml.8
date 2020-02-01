Return-Path: <SRS0=DSTS=3V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8BB7CC33CB3
	for <linux-kernel@archiver.kernel.org>; Sat,  1 Feb 2020 18:30:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 624FC206F0
	for <linux-kernel@archiver.kernel.org>; Sat,  1 Feb 2020 18:30:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1580581816;
	bh=HiWpPnU9TmWFQktnG/RmOxLMXAiqVAFfzLYy3Od4ilw=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=Dj46QAsPnE7pIeG6RmG7oAjk+04RB3hyID/MLX+k/A1l9zgFcFHrENAWlglXKyJ5i
	 ocZ/UEWg8OFjYNx7HgK4BscdXeIJ8MxSj7pvznPvoa34u5jtomky/dWILe0Iv4Wr6H
	 7OB34FMlxk/VdMs8tFr1hK5UTUR0H+IEvNZgDoUs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726881AbgBASaP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 1 Feb 2020 13:30:15 -0500
Received: from mail.kernel.org ([198.145.29.99]:60732 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726270AbgBASaP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Feb 2020 13:30:15 -0500
Subject: Re: [GIT PULL] random: changes for 5.6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1580581814;
        bh=HiWpPnU9TmWFQktnG/RmOxLMXAiqVAFfzLYy3Od4ilw=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=FR1szMYwLqOtNbFo8Q69dChwSn7huMSlt5V6Jg6T7XXLUC8bhPd7vQxOQexSLY+K1
         UAIxLba5448R9PUDTbJxC8IPIQvD3P6iBMh/coGa85LAk0YSENv4Shu/mP6UdgX6Bc
         QHK8RQgeiNqRyN8ceFbtKSvMrWdq3ntt7+w2vr6Y=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20200131204924.GA455123@mit.edu>
References: <20200131204924.GA455123@mit.edu>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20200131204924.GA455123@mit.edu>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tytso/random.git
 tags/random_for_linus
X-PR-Tracked-Commit-Id: 4cb760b02419061209b9b4cc2557986a6bf93e73
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: acd77500aa8a337baa6d853568c4b55aca48e20f
Message-Id: <158058181485.4504.7533437469118377737.pr-tracker-bot@kernel.org>
Date:   Sat, 01 Feb 2020 18:30:14 +0000
To:     "Theodore Y. Ts'o" <tytso@mit.edu>
Cc:     torvalds@linux-foundation.org, linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 31 Jan 2020 15:49:24 -0500:

> git://git.kernel.org/pub/scm/linux/kernel/git/tytso/random.git tags/random_for_linus

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/acd77500aa8a337baa6d853568c4b55aca48e20f

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
