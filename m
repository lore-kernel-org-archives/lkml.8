Return-Path: <SRS0=fqu/=3Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BFDB4C35247
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Feb 2020 18:20:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 944B5217BA
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Feb 2020 18:20:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1580926820;
	bh=pkF+Zu7Fc6EtaNl3fzwBn92fLIb5ER8BmVSENmewRAk=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=0exdvHIZppoLS1zJLJ0qIm/9qjyRnglcxOG95Aw/x+ia8tqQKu9R13cgCzafScjn+
	 uRtKNTM1OlcTxzRuxzuuxrOCibnnoEyB6EOB73J9cVFK3HVUluSctJ5fkMgJVsDrD9
	 q5ADH84T8Z2eJ1Hql7C+p3WTsa1Q8OHH7o6gtTx8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727722AbgBESUT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Feb 2020 13:20:19 -0500
Received: from mail.kernel.org ([198.145.29.99]:51924 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727682AbgBESUS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Feb 2020 13:20:18 -0500
Subject: Re: [GIT PULL] pwm: Changes for v5.6-rc1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1580926817;
        bh=pkF+Zu7Fc6EtaNl3fzwBn92fLIb5ER8BmVSENmewRAk=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=1+mftukO69IDnwumaGqXvcG8o/P2CnDrxfClc396gReqUvQNOTItC9Hq80gvYrJu/
         QA5WL9lAXj9te2RhTA9LqoCBlDjsdrdYR47TCYfDjiS5wtIvsUES1yzJsQsyijrrW/
         EAeFnCgePF2LM84LSiPQxLm7OJyooxXJZ2uzLKMM=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20200205142511.2172050-1-thierry.reding@gmail.com>
References: <20200205142511.2172050-1-thierry.reding@gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20200205142511.2172050-1-thierry.reding@gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/thierry.reding/linux-pwm.git
 tags/pwm/for-5.6-rc1
X-PR-Tracked-Commit-Id: 9871abffc81048e20f02e15d6aa4558a44ad53ea
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 4c7d00ccf40db99bfb7bd1857bcbf007275704d8
Message-Id: <158092681758.14135.10923863172785841060.pr-tracker-bot@kernel.org>
Date:   Wed, 05 Feb 2020 18:20:17 +0000
To:     Thierry Reding <thierry.reding@gmail.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, linux-pwm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Wed,  5 Feb 2020 15:25:11 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/thierry.reding/linux-pwm.git tags/pwm/for-5.6-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/4c7d00ccf40db99bfb7bd1857bcbf007275704d8

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
