Return-Path: <SRS0=1cir=3Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78CF1C2D0DB
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jan 2020 20:10:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 474162467B
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jan 2020 20:10:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1580155811;
	bh=BgZJcSPN/jIzKCCJrCntyF/GspTRMYdljBhfpKeEokU=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=xK0/u5m5k1K+G9C/XiagWAmuHQpnEvBegTTneo6R0bEvKpa+Szh0WTgskIUQ1BLqf
	 Fu3GUKBEd3aE5YbGFOOO7T9pce88SnvR5ZMyjlB/hvJGNW7tHE/wG/up7xk9R5eCmx
	 bL7EoO8RhBCf2b20XPLwwZQHFAWhIuMPIXA+Cxhw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727093AbgA0UKK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Jan 2020 15:10:10 -0500
Received: from mail.kernel.org ([198.145.29.99]:59888 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726703AbgA0UKH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jan 2020 15:10:07 -0500
Subject: Re: [GIT PULL] Device properties framework updates for v5.6-rc1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1580155806;
        bh=BgZJcSPN/jIzKCCJrCntyF/GspTRMYdljBhfpKeEokU=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=ixyKjI5T5ssovOHPem0O8yrUV2iwUsQ3KykEUfnYfslrgWu361K6QcWd1kiatE/QM
         DZM5hrTGcpybdUAP2NnPHdCEjolTscb4hoNZdkwf4lstPV8tuEN4poXzl1MLBnzRqV
         yhYMkAAyMY0kCB746oc+oueQ7QW1mjENbARgb2b0=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <CAJZ5v0jcOmamFM6AU4eDJx_ULZfV63P_+o5BoxOmyDHuFKRHOA@mail.gmail.com>
References: <CAJZ5v0jcOmamFM6AU4eDJx_ULZfV63P_+o5BoxOmyDHuFKRHOA@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAJZ5v0jcOmamFM6AU4eDJx_ULZfV63P_+o5BoxOmyDHuFKRHOA@mail.gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git
 devprop-5.6-rc1
X-PR-Tracked-Commit-Id: aa811e3cececac2f65f7fa7e17ab46c73d778b2b
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 85c009e8e5d2794e2efb1019e3648f3d8126f1b5
Message-Id: <158015580658.19143.16491557573063615147.pr-tracker-bot@kernel.org>
Date:   Mon, 27 Jan 2020 20:10:06 +0000
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Mon, 27 Jan 2020 17:34:34 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git devprop-5.6-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/85c009e8e5d2794e2efb1019e3648f3d8126f1b5

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
