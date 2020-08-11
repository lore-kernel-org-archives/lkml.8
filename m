Return-Path: <SRS0=vr6t=BV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 292F5C433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Aug 2020 01:37:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0496A20734
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Aug 2020 01:37:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1597109838;
	bh=enLc1wTRtRZNdcVLmThs4vQUkO9KUfGLLJQLQBG6qsQ=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=qy08XtTAwiGOBA3DOJyJkvnJnVrckgudSNpCYuYiyIQjPcqkz4EaXkBwLz2YNaXGX
	 QcOzCqeF+x9J32IoclJCC7rmW8ssBDEXexQ43Ki/RTztcYR28aAWtSMU9G1d2MFiHM
	 mWm+w7zfsFXOieW9rFPFzgYI+e9InqtofdzoJ9Uo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728094AbgHKBhQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Aug 2020 21:37:16 -0400
Received: from mail.kernel.org ([198.145.29.99]:52014 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727848AbgHKBhQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Aug 2020 21:37:16 -0400
Subject: Re: [GIT PULL] JFFS2, UBI and UBIFS changes for 5.9-rc1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1597109836;
        bh=enLc1wTRtRZNdcVLmThs4vQUkO9KUfGLLJQLQBG6qsQ=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=nkeZ+7iVQGuzZUWvTQPwNPp4Lj5bORb0BUKPsr8el/8q609NY4ZhFLMvYRVkvidBv
         v/dsLRPBiSt83K1dXkc2oDys+CJS8hORGLgnymXsjW0gEfnHD0kFLp8jUyoHr6X/j0
         8BFHvwggSM6icmW0VGZ077mV/oqaQlotaBUKDU8w=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <1956790813.229084.1597084052878.JavaMail.zimbra@nod.at>
References: <1956790813.229084.1597084052878.JavaMail.zimbra@nod.at>
X-PR-Tracked-List-Id: Linux MTD discussion mailing list <linux-mtd.lists.infradead.org>
X-PR-Tracked-Message-Id: <1956790813.229084.1597084052878.JavaMail.zimbra@nod.at>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/rw/ubifs.git tags/for-linus-5.9-rc1
X-PR-Tracked-Commit-Id: 798b7347e4f29553db4b996393caf12f5b233daf
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 163c3e3dc0ddcea3edac51612fced13c597f37dc
Message-Id: <159710983614.12600.18082596157940908446.pr-tracker-bot@kernel.org>
Date:   Tue, 11 Aug 2020 01:37:16 +0000
To:     Richard Weinberger <richard@nod.at>
Cc:     torvalds <torvalds@linux-foundation.org>,
        linux-mtd <linux-mtd@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Mon, 10 Aug 2020 20:27:32 +0200 (CEST):

> git://git.kernel.org/pub/scm/linux/kernel/git/rw/ubifs.git tags/for-linus-5.9-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/163c3e3dc0ddcea3edac51612fced13c597f37dc

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
