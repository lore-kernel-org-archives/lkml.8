Return-Path: <SRS0=/IhT=AT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 215F1C433DF
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jul 2020 18:20:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0338B206DF
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jul 2020 18:20:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1594232408;
	bh=fA2wNV4aCSEQhlYsKq/RRQlqH7rWPum53CclJKqRszI=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=urW6nrPud20tNx8JLDZKZxqqAWBLUvEVwa7Amto90nWC0CkNTfy/iZJ7EpTBBWKI6
	 0sie5mtbcZPss9UJEbCPxW4/qOCAyJJG6xO/Pm8FEHMEizTf0SoBE2AntIj1k6Whdd
	 ap16gL2QXYDc/XtTCVoyeEsSFfeHHRljAuWPInGo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726382AbgGHSUG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Jul 2020 14:20:06 -0400
Received: from mail.kernel.org ([198.145.29.99]:42026 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725949AbgGHSUF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jul 2020 14:20:05 -0400
Subject: Re: [GIT PULL] sound fixes for 5.8-rc5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1594232405;
        bh=fA2wNV4aCSEQhlYsKq/RRQlqH7rWPum53CclJKqRszI=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=wQ2ulwkeGgfWMLb9moYbKZ3k/Azv5dkqK0Cv5IFHB2zCq2Cql7RelXq7KbvAU3q00
         O5Y8yHG9Yiene6/exw/3DeyfTjccaXB4+z7fw5m4LVL5x0T/g/afjPHiANoqButr+n
         03MxvA5xxfNlG1NpBjZAhLzTmu6RAVkCaImoG0jg=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <s5hy2nu9hva.wl-tiwai@suse.de>
References: <s5hy2nu9hva.wl-tiwai@suse.de>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <s5hy2nu9hva.wl-tiwai@suse.de>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tiwai/sound.git
 tags/sound-5.8-rc5
X-PR-Tracked-Commit-Id: f79a732a8325dfbd570d87f1435019d7e5501c6d
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 63e1968a2c87e9461e9694a96991935116e0cec7
Message-Id: <159423240544.17747.5042816254963136952.pr-tracker-bot@kernel.org>
Date:   Wed, 08 Jul 2020 18:20:05 +0000
To:     Takashi Iwai <tiwai@suse.de>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Wed, 08 Jul 2020 16:55:05 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/tiwai/sound.git tags/sound-5.8-rc5

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/63e1968a2c87e9461e9694a96991935116e0cec7

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
