Return-Path: <SRS0=dnKw=BT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8CE52C433DF
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Aug 2020 19:56:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6501B206CD
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Aug 2020 19:56:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1597002972;
	bh=5sMrsy2EEveGl4nlwCywba/xRt3KKs5jiqpLXwQ4910=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=zZ5C2968+jbjrfpJadOm6RU0cxxRofkaF6DC7AOmFaJbRYJZ0VKeoianzwJR3XXzQ
	 PafK2FObwtfVemDdAKjOJrMv+K9eRvITZXEOciseN9Hp9LtPqQF6MZqzcD9u/tEWMg
	 UlralsRrhxrJeoVBfzA+695Xh7ECXMKjm8AgEXX4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726450AbgHIT4L (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 9 Aug 2020 15:56:11 -0400
Received: from mail.kernel.org ([198.145.29.99]:44960 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726291AbgHIT4K (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Aug 2020 15:56:10 -0400
Subject: Re: [GIT PULL] mtd: Changes for 5.9
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1597002970;
        bh=5sMrsy2EEveGl4nlwCywba/xRt3KKs5jiqpLXwQ4910=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=pOF7jVFkoiPdD4W9+QZw0fF2yEF+5b+iAQ94wn+T9I7m0PtS79j3UHBQ0CRXtgVv5
         rMCy3bzwJULjwy1sJJmc0+8gYThtECUxZvHS6BPG+O+owfQ3B6HMj4+UnaYoNb80as
         ESlPLCQDdLhXw36Py6ZVQtMI8xEGfjmSlL69Por0=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20200809003453.79673eb3@xps13>
References: <20200809003453.79673eb3@xps13>
X-PR-Tracked-List-Id: Linux MTD discussion mailing list <linux-mtd.lists.infradead.org>
X-PR-Tracked-Message-Id: <20200809003453.79673eb3@xps13>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/mtd/linux.git tags/mtd/for-5.9
X-PR-Tracked-Commit-Id: 6a1380271b75e0d9a961e192e56b733fedf7a23a
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: dec1fbbc1d7c46aed9fc1d3ee1f7f4fc04d6ed51
Message-Id: <159700297006.31137.5146495495916399431.pr-tracker-bot@kernel.org>
Date:   Sun, 09 Aug 2020 19:56:10 +0000
To:     Miquel Raynal <miquel.raynal@bootlin.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Tudor Ambarus <Tudor.Ambarus@microchip.com>,
        Richard Weinberger <richard@nod.at>,
        linux-kernel@vger.kernel.org,
        Frieder Schrempf <frieder.schrempf@kontron.de>,
        linux-mtd@lists.infradead.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sun, 9 Aug 2020 00:34:53 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/mtd/linux.git tags/mtd/for-5.9

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/dec1fbbc1d7c46aed9fc1d3ee1f7f4fc04d6ed51

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
