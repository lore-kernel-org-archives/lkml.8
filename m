Return-Path: <SRS0=nwpL=6I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 642EDC54FD0
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Apr 2020 20:50:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3582A215A4
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Apr 2020 20:50:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1587761423;
	bh=Q6N7CSnnW4EA8b5GJcLeLoY5IPtM9t+OO1wfUBfuKvM=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=L7dtMW2rQ+exTE+P3GWtbQ2TqLF1ldkkC+syggXLaCLa0XYQLte0KC2wJxegri34W
	 qr5bwd67ZU/ipBlpa8CfuCq+vrHsWLsRnMEzi4+mJoLKKUuYucvIMHHLz/Xdvxk1wI
	 O4UQyAjXHdNNzWJLs+pmAP6fcLevIOje08EWBH+c=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726240AbgDXUuW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Apr 2020 16:50:22 -0400
Received: from mail.kernel.org ([198.145.29.99]:46722 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726046AbgDXUuT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Apr 2020 16:50:19 -0400
Subject: Re: [GIT PULL] PNP subsystem update for v5.7-rc2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1587761419;
        bh=Q6N7CSnnW4EA8b5GJcLeLoY5IPtM9t+OO1wfUBfuKvM=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=STrMdc9koMugLsqwSwQhb6blE0jHjwwedjowVGN3TnWGI+ht5UqUFawoOO+r+jWRl
         J53mGAPAi3VvpAMFUQQRhPEWpSPzbowtxT3cFG97G3owT8yFRLFawXZOZxad0GF0Uw
         bNcVJMW3rbShJJ+HKfOvcV+lO06L4fTzW7FauC5k=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <CAJZ5v0hHNpEjdzE4QVhpb7bi43VGHdJwY17n1_pTmcXwXNtPew@mail.gmail.com>
References: <CAJZ5v0hHNpEjdzE4QVhpb7bi43VGHdJwY17n1_pTmcXwXNtPew@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAJZ5v0hHNpEjdzE4QVhpb7bi43VGHdJwY17n1_pTmcXwXNtPew@mail.gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git pnp-5.7-rc3
X-PR-Tracked-Commit-Id: 01b2bafe57b19d9119413f138765ef57990921ce
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 5be35f7ffca5265f565b1b7dcf4951805bd92482
Message-Id: <158776141965.11860.11758797527099865589.pr-tracker-bot@kernel.org>
Date:   Fri, 24 Apr 2020 20:50:19 +0000
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 24 Apr 2020 21:23:14 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git pnp-5.7-rc3

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/5be35f7ffca5265f565b1b7dcf4951805bd92482

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
