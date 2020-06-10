Return-Path: <SRS0=CVC0=7X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4A0FC433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jun 2020 22:05:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7AF8E20801
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jun 2020 22:05:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1591826724;
	bh=RM/iJOiaO0HwXMjBe4KNkA7pDX+za5dVp3r4su6abVg=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=r61q+rCgxdDEQsywl5sco3/CwRM5DZ0h7oDJhu8xvjk037OMR8YBfZ0s4CK5grD2c
	 gzJEknNTEww9SHd0tJEIwZszvsgv/XGZWktL9WfxzF6jWcG3fp3v4mFz3CAl7czowX
	 aZNgejySBVZAW1iM5XUU1vr/ZVEIoQYkqE0559Wo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726647AbgFJWFX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Jun 2020 18:05:23 -0400
Received: from mail.kernel.org ([198.145.29.99]:41240 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726589AbgFJWFW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Jun 2020 18:05:22 -0400
Subject: Re: Re: [GIT pull - RFC] locking/kcsan for v5.8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1591826722;
        bh=RM/iJOiaO0HwXMjBe4KNkA7pDX+za5dVp3r4su6abVg=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=SPCAM41VITaZX4mpfwqA4Va3LYX26l6yRl1yQu++sjUnWb0ojJmnRL836ZvhwXgYP
         v/blZUzMv/hXRJDsH07GFV3clu+40XWKbtIIfnoyx7aZ1xtEWA/+MctsEvw4MGuKGx
         UMNNuJ819VJdECR2RsHyd1fN2oPj9mTT+vl12EE4=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20200605111531.GA19216@willie-the-truck>
References: <159110310259.14558.3096683243532489290.tglx@nanos.tec.linutronix.de>
 <20200605111531.GA19216@willie-the-truck>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20200605111531.GA19216@willie-the-truck>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/will/linux.git rwonce/rework
X-PR-Tracked-Commit-Id: b398ace5d2ea0b7f00d9f1ce23c647e289c206ca
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 4152d146ee2169653297e03b9fa2e0f476923959
Message-Id: <159182672228.28998.17237087023095909692.pr-tracker-bot@kernel.org>
Date:   Wed, 10 Jun 2020 22:05:22 +0000
To:     Will Deacon <will@kernel.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, x86@kernel.org,
        Marco Elver <elver@google.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 5 Jun 2020 12:15:31 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/will/linux.git rwonce/rework

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/4152d146ee2169653297e03b9fa2e0f476923959

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
