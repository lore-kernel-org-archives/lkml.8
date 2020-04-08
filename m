Return-Path: <SRS0=8dav=5Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5208AC2D0EC
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Apr 2020 03:20:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 21510212CC
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Apr 2020 03:20:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1586316033;
	bh=OFj9KvG5PuUTr1E/ynAV0LC93klhWa8RLn5WM8uBMQI=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=ee0Vc4xmNaZ9Zs0GnkBj/4MRAo65NKKQzC/U11Gz/WZtdwoOqtIhil/HV8EVvLCLV
	 heuitjvymPoUR2zdM5PPSfcyZSdd+IzZe36oAStxzrxvCev2eK9QjX7L3e4PNTq+x9
	 NVtz1+NqwljthOcSOp863Bn8CC8dPx7y11s4/98w=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726595AbgDHDUb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Apr 2020 23:20:31 -0400
Received: from mail.kernel.org ([198.145.29.99]:34774 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726571AbgDHDUa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Apr 2020 23:20:30 -0400
Subject: Re: [GIT PULL] MFD for v5.7
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1586316030;
        bh=OFj9KvG5PuUTr1E/ynAV0LC93klhWa8RLn5WM8uBMQI=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=X6CKgttiredsT+X1mU6merYGy0+ZgXz0qMe7954srkEL9R+txebFWxZfNu5YHW5hb
         91kfXqvmVXJxOjYQA31/sPvc4unhQUe9BZo4aUkl/Rg1TNhSz60TbykQ3aGSvKzoV5
         Rl/HrdHbVOQUFCSE1nkVR6CtVROslFlZTdd9VvR4=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20200407094334.GH30614@dell>
References: <20200407094334.GH30614@dell>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20200407094334.GH30614@dell>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/lee/mfd.git mfd-next-5.7
X-PR-Tracked-Commit-Id: d2923aa4535664ae5c46c3a093985afd18fec118
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 8645f09bad14df3776484b44933a41c446343087
Message-Id: <158631603009.18814.624832954979751609.pr-tracker-bot@kernel.org>
Date:   Wed, 08 Apr 2020 03:20:30 +0000
To:     Lee Jones <lee.jones@linaro.org>
Cc:     torvalds@linux-foundation.org, linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Tue, 7 Apr 2020 10:43:34 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/lee/mfd.git mfd-next-5.7

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/8645f09bad14df3776484b44933a41c446343087

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
