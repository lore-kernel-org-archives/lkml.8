Return-Path: <SRS0=vr6t=BV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8FDA5C433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Aug 2020 20:27:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 671D8206DC
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Aug 2020 20:27:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1597177650;
	bh=Fh35tu6KdlcAgV+RF5NXn55IaK3ovCiVDr25Ah1KA+I=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=ap0Mea8cyGH8oTPTCoxWPcNuIR8LQFT3ZFcVXDpuHGxy7zR3nh7kUt+OJ7wnu5bN0
	 uPaD3GWcCc60ZBwNTPk9JvVkcDq4cDRaGdyIfn8XowZQBiy5jYdLvRquMqRSArh2+c
	 0APlmVXvAeM3i3Zwd8SAaHWpJK6bMOu7NBgFPDIM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726547AbgHKU12 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Aug 2020 16:27:28 -0400
Received: from mail.kernel.org ([198.145.29.99]:56424 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726479AbgHKU1Y (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Aug 2020 16:27:24 -0400
Subject: Re: [GIT PULL] hwspinlock updates for 5.9
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1597177643;
        bh=Fh35tu6KdlcAgV+RF5NXn55IaK3ovCiVDr25Ah1KA+I=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=HYxs75ban3/DUy2QgPM9YE63z4QOxbLQxo8LjFr75aUqP+nETvZmkPPpzNMOpYMQF
         mDW9LqvuFJ62SXybVm7o+cUa/XtuqWbNPSLxqi1RfGsE7Mu1sn1kCyX2nVT8tMR5C1
         Pdg+06dnIV59kyT/93OZu6gf5Qx8/wXgY6LVAlWg=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20200811052900.404638-1-bjorn.andersson@linaro.org>
References: <20200811052900.404638-1-bjorn.andersson@linaro.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20200811052900.404638-1-bjorn.andersson@linaro.org>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/andersson/remoteproc.git tags/hwlock-v5.9
X-PR-Tracked-Commit-Id: 35efb0e1d5c60e334ea719586ff2509fde2e613b
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: c636eef2ee3696f261a35f34989842701a107895
Message-Id: <159717764384.9233.2091317091094808509.pr-tracker-bot@kernel.org>
Date:   Tue, 11 Aug 2020 20:27:23 +0000
To:     Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Ohad Ben-Cohen <ohad@wizery.com>,
        linux-remoteproc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Ezequiel Garcia <ezequiel@collabora.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Mon, 10 Aug 2020 22:29:00 -0700:

> https://git.kernel.org/pub/scm/linux/kernel/git/andersson/remoteproc.git tags/hwlock-v5.9

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/c636eef2ee3696f261a35f34989842701a107895

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
