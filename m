Return-Path: <SRS0=sqqi=7C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3D12C433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 20 May 2020 20:30:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 65E1F2084C
	for <linux-kernel@archiver.kernel.org>; Wed, 20 May 2020 20:30:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1590006605;
	bh=7dgSowVWKb+a5DwviAHKDWmLUjcttsA4HWVfUlSUFIQ=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=p1TizKFzuUn6xec2fZ/BJ33i5tAdtBK19gV8yFiQUS0qyzwZFhKY55HBQjCCCzY6j
	 miWkCz9X9M9721iGFHWo5HS9gRkujIBZkVC9rR3At+ltmOA8J8/LdYyw+a7QWZKX6B
	 n6yXQV5xq3lQ61Tjc1XIpCzuLfFseARLfOGu9Sg4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727890AbgETUaE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 May 2020 16:30:04 -0400
Received: from mail.kernel.org ([198.145.29.99]:35876 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726860AbgETUaD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 May 2020 16:30:03 -0400
Subject: Re: [GIT PULL] MTD fixes for 5.7 final
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1590006603;
        bh=7dgSowVWKb+a5DwviAHKDWmLUjcttsA4HWVfUlSUFIQ=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=FPnQN4xn6UxZuLpjcB64H2HDXYLcJQevTS0MSy5NRNgagDoNC7sYEEsluYpeJTf6n
         w0GboC1Zclijk+h/r66FgwZ0A24LNCdATpzB0yY+hyQrAHTAnQxvZXfOn8Uj2Nin8a
         9/zmgvaheUt8exyfEUEYTPiVG+WXO7lQyidKXGio=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <1270319593.249344.1590004179760.JavaMail.zimbra@nod.at>
References: <1270319593.249344.1590004179760.JavaMail.zimbra@nod.at>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <1270319593.249344.1590004179760.JavaMail.zimbra@nod.at>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/mtd/linux.git
 tags/fixes-for-5.7-rc6
X-PR-Tracked-Commit-Id: f3a6a6c5e0f5a303fd8ec84ea33c0da5869d715f
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: b85051e755b0e9d6dd8f17ef1da083851b83287d
Message-Id: <159000660335.10849.12687061016548851219.pr-tracker-bot@kernel.org>
Date:   Wed, 20 May 2020 20:30:03 +0000
To:     Richard Weinberger <richard@nod.at>
Cc:     torvalds <torvalds@linux-foundation.org>,
        miquel.raynal@bootlin.com, vigneshr@ti.com,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-mtd <linux-mtd@lists.infradead.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Wed, 20 May 2020 21:49:39 +0200 (CEST):

> git://git.kernel.org/pub/scm/linux/kernel/git/mtd/linux.git tags/fixes-for-5.7-rc6

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/b85051e755b0e9d6dd8f17ef1da083851b83287d

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
