Return-Path: <SRS0=qJsj=BZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.6 required=3.0 tests=BAYES_00,DATE_IN_PAST_06_12,
	DKIMWL_WL_HIGH,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D810DC433E1
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Aug 2020 22:06:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B8981205CB
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Aug 2020 22:06:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1597529165;
	bh=qB0xXx971nEleFvxsOUVtbgMJHnqqf3l5odXYLbJync=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=qJh09C0hDmTzXsKUkNFx1eqj6AXMRrxjxBgeBOZ20NjwxiggFbxYdnu8xcd55yxEP
	 YaJKTo3bgPCEM0+3Nin2dmou5SWeCnChE//Qp8mrL55ifztvkEm0TjtNrkSd1eZwVg
	 VO6mvQ7K6MESpuyYVoD2NHAxgc4QBGg8iYJMTYY0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729968AbgHOWGE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 15 Aug 2020 18:06:04 -0400
Received: from mail.kernel.org ([198.145.29.99]:39104 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729970AbgHOWFd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Aug 2020 18:05:33 -0400
Subject: Re: [GIT PULL] More ACPI updates for v5.9-rc1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1597504961;
        bh=qB0xXx971nEleFvxsOUVtbgMJHnqqf3l5odXYLbJync=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=xCS7GB8pV/jvBiio12ZiKCbaY9Yohuxl5LeEYz2sLMb7puMkmijeaT9iFfuVJWiQP
         iNXfUio8VI8BKrHbyZHgzT5cz47vKQ+AhiB33UIYLd/zcDZFuJ7MCBZV68DHNxlFK0
         YOjBQV3OdtFH8Aq+tEv9W9GdvILtu2/bp/Hl+klY=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <CAJZ5v0iA_PSMf9gpXsmymS8t2ctMeyJ3FJE_v1LqbFu+fF_R6g@mail.gmail.com>
References: <CAJZ5v0iA_PSMf9gpXsmymS8t2ctMeyJ3FJE_v1LqbFu+fF_R6g@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-acpi.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAJZ5v0iA_PSMf9gpXsmymS8t2ctMeyJ3FJE_v1LqbFu+fF_R6g@mail.gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git acpi-5.9-rc1-2
X-PR-Tracked-Commit-Id: 19fe87fd854a92c746ac73cb91a0bebac07a4618
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 341323fa0eed1b201130b7af84d40fa04725c832
Message-Id: <159750496123.10263.2199274626689102962.pr-tracker-bot@kernel.org>
Date:   Sat, 15 Aug 2020 15:22:41 +0000
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 14 Aug 2020 20:09:40 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git acpi-5.9-rc1-2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/341323fa0eed1b201130b7af84d40fa04725c832

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
