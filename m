Return-Path: <SRS0=boYM=7Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED4C1C433E0
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jun 2020 01:10:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C8091206E9
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jun 2020 01:10:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1591146607;
	bh=Yn9mHxjqxws6vQ0rrEyWuufyN0hqo+ADRa9GCpbDcz8=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=d7pc/agziS5ZKoCOSvCybumEJmSdnrM7EbR/B6yHEt3xA7XXb3S8t61EteTpTKK/2
	 Ue7HgUY7BTQ7gk3gp1u/QNOE98wn1Uza6LR8TfDbfyuvu3J7Vs+xZldVhxlYQtTwzB
	 Ue5zDqpGrrx9tEVqlvJA8bnVFjpluOba4dX/DFCI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728001AbgFCBKG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Jun 2020 21:10:06 -0400
Received: from mail.kernel.org ([198.145.29.99]:43860 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726112AbgFCBKG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Jun 2020 21:10:06 -0400
Subject: Re: [GIT PULL] Audit patches for v5.8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1591146606;
        bh=Yn9mHxjqxws6vQ0rrEyWuufyN0hqo+ADRa9GCpbDcz8=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=J4nkKT97VEe9xJUBa7M6PbiB6Gmp8x3/pmqUIcxyaPG1r7YL9mLCH4BEXDz2f+Ea9
         jYfZ2zeCfR/JPYEXWCHqRD/nxWj3tjp/Iwu8HJGtuHS6Jz0DKATqcUKn4oQvbk9FTu
         snW4dqbrAwi70Jly3mzVizu2SPCKPa8zsB0DjX/8=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <CAHC9VhQqnAG5DxvoQKa643d06rDTVtHVFEj5arCsHwyoamCckA@mail.gmail.com>
References: <CAHC9VhQqnAG5DxvoQKa643d06rDTVtHVFEj5arCsHwyoamCckA@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAHC9VhQqnAG5DxvoQKa643d06rDTVtHVFEj5arCsHwyoamCckA@mail.gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/pcmoore/audit.git
 tags/audit-pr-20200601
X-PR-Tracked-Commit-Id: 9d44a121c5a79bc8a9d67c058456bd52a83c79e7
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 9d99b1647fa56805c1cfef2d81ee7b9855359b62
Message-Id: <159114660605.11472.8600694237100035153.pr-tracker-bot@kernel.org>
Date:   Wed, 03 Jun 2020 01:10:06 +0000
To:     Paul Moore <paul@paul-moore.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-audit@redhat.com, linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Mon, 1 Jun 2020 20:48:59 -0400:

> git://git.kernel.org/pub/scm/linux/kernel/git/pcmoore/audit.git tags/audit-pr-20200601

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/9d99b1647fa56805c1cfef2d81ee7b9855359b62

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
