Return-Path: <SRS0=w5GM=A4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83041C433E3
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jul 2020 17:40:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 612AE20B1F
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jul 2020 17:40:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1595007614;
	bh=BBU1GFqKG/oACZ+TArHuatCU6FJ/NAlOuR8HsJ43zG8=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=Dbrvl1ojJno4+uolykIiWLs1weF+pnfsc4DYQXVGErEsUgbm2zxtmFuZletvLqB3K
	 YKSIuh/Rp5L90ir2X8q9v7hqXVdvAq6HBR3USs1jYIQH1/xb9VbNqSJ/x3lusxb48h
	 ovRRWody/+R1gQSsGxLnlX8AMxx6rDkBHHr9cCrE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728100AbgGQRkN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Jul 2020 13:40:13 -0400
Received: from mail.kernel.org ([198.145.29.99]:56300 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728068AbgGQRkJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jul 2020 13:40:09 -0400
Subject: Re: [GIT PULL] regulator fixes for v5.8-rc5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1595007609;
        bh=BBU1GFqKG/oACZ+TArHuatCU6FJ/NAlOuR8HsJ43zG8=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=hcQUw6NpE2hPl+UVDlpjicM1AOV80bdSDMceVfQT2e7PD9YDdQQWw4B+Pjnx+TL3G
         vrESVX/vLFWjJBB5PqlXzWN/YzOSI3jWaa6iw4q82ggpC9ulkgphHRH5oWP/v5q0m7
         nOXQrniM6RmbW7kQzHZSQzaxFPROVbgcBqpZHo9s=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20200717154305.AA4DF207DD@mail.kernel.org>
References: <20200717154305.AA4DF207DD@mail.kernel.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20200717154305.AA4DF207DD@mail.kernel.org>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git
 tags/regulator-fix-v5.8-rc5
X-PR-Tracked-Commit-Id: 412847fb47336c58885ac6231a5f34ac7ac862a0
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 8da822e8a573767c4777a4b3f11ee12954a8cd0e
Message-Id: <159500760923.14528.12864840790554210464.pr-tracker-bot@kernel.org>
Date:   Fri, 17 Jul 2020 17:40:09 +0000
To:     Mark Brown <broonie@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 17 Jul 2020 16:42:54 +0100:

> https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git tags/regulator-fix-v5.8-rc5

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/8da822e8a573767c4777a4b3f11ee12954a8cd0e

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
