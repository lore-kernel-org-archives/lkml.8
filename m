Return-Path: <SRS0=bYqs=33=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 831EAC2BA83
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Feb 2020 21:55:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 56EA622314
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Feb 2020 21:55:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1581112528;
	bh=GmfHsAi2L8vVRWBdqdTqIK2X5WyLyDBPcOXaUgGhuG4=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=JG/BGivL2V7WfJwoWUB1PzJ1Dwd4iBNe3cVJTFkOoDp/rQubcUvclXGDQjM/8DhFW
	 AIaInJhjp71/1x8bWyWeB9z9CnssPYrGWKmzvz4RyRJ3mU4PkGfTB1UkSjyqnZ023o
	 2lK9OgRjbSWsZJt8kbOrFGty5wgemjjcYAmibOSk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727802AbgBGVz0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Feb 2020 16:55:26 -0500
Received: from mail.kernel.org ([198.145.29.99]:42410 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727697AbgBGVzU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Feb 2020 16:55:20 -0500
Subject: Re: [GIT PULL] Additional ACPI updates for v5.6-rc1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1581112519;
        bh=GmfHsAi2L8vVRWBdqdTqIK2X5WyLyDBPcOXaUgGhuG4=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=zhKjYnu7QePq2lyNj55j7gHMURu8nb50O4v3dCHdVdAaBsdfiOZSC7PepRtqMLPL9
         +QepvPY3XkDmri/ASsKJbk/c3ymVZuOPTO1J8iohH7oll1soIKXvNgtz2gV06Xl1Hj
         +wr4cqUEd41y1QihOfPNUI27dRfoHOKvaBatsjvI=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <CAJZ5v0iWhN=pxnedntPn5kriN-uEULvTjHADtJj59a5W14a4sQ@mail.gmail.com>
References: <CAJZ5v0iWhN=pxnedntPn5kriN-uEULvTjHADtJj59a5W14a4sQ@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAJZ5v0iWhN=pxnedntPn5kriN-uEULvTjHADtJj59a5W14a4sQ@mail.gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git
 acpi-5.6-rc1-3
X-PR-Tracked-Commit-Id: dec0a81a7814c8a876e663e0627468e6b1a7d2fb
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: ed39ba0ec1156407040e7509cb19299b5dda3815
Message-Id: <158111251949.9631.11774276832242457428.pr-tracker-bot@kernel.org>
Date:   Fri, 07 Feb 2020 21:55:19 +0000
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-i2c <linux-i2c@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 7 Feb 2020 11:36:02 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git acpi-5.6-rc1-3

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/ed39ba0ec1156407040e7509cb19299b5dda3815

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
