Return-Path: <SRS0=QAx1=7P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 471A6C433DF
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jun 2020 20:35:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 21AC1207DA
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jun 2020 20:35:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1591130133;
	bh=2rVwh4/siikVrpgwYQuuD+buqge9Sw5sBfNz6/5D/G4=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=YuaD7IQVSUFy0n7VyDyaew+avO0Vky/2qq2/ik2Ha6lhpWgVp/Sopvhab/52LPH4t
	 4gvXaG97gnBMPqZ6Y5+m9gMaNiLDX3i1qtipvVp6lf6+o1KW3Sutij2qbIqleXg/G2
	 IsPRk7//I2DKliKSBSTsyS3jfCetkP0bD77L/FWA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728661AbgFBUfb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Jun 2020 16:35:31 -0400
Received: from mail.kernel.org ([198.145.29.99]:46384 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728459AbgFBUfG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Jun 2020 16:35:06 -0400
Subject: Re: [GIT PULL] Power management updates for v5.8-rc1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1591130106;
        bh=2rVwh4/siikVrpgwYQuuD+buqge9Sw5sBfNz6/5D/G4=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=DaTHAH+Ih2x/zpFGh+ICXsG43LB4CLkxU33kHtD/QNLxT1+vEP6H0f1vDbrWmymFl
         +o/95tHMuX+6Z+3XQYlMXf1y6f6H29Kb6083QTTHM+nneHBiYOjFCTz5bQWEAaqIod
         VYKiuvCkpQTkLaYEgjCmRReZf858bTknNPNc6P0A=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <CAJZ5v0gV2T9BUBGT8TOt+kdO6+T_WwmcO1PPonWu76REGkoorQ@mail.gmail.com>
References: <CAJZ5v0gV2T9BUBGT8TOt+kdO6+T_WwmcO1PPonWu76REGkoorQ@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAJZ5v0gV2T9BUBGT8TOt+kdO6+T_WwmcO1PPonWu76REGkoorQ@mail.gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git pm-5.8-rc1
X-PR-Tracked-Commit-Id: a34024d98eeaa78e2cd22017180df778800b83fc
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 355ba37d756c38962fe9bb616f5f48eb12a7e11e
Message-Id: <159113010624.19446.15600149439571163343.pr-tracker-bot@kernel.org>
Date:   Tue, 02 Jun 2020 20:35:06 +0000
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Mon, 1 Jun 2020 17:48:27 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git pm-5.8-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/355ba37d756c38962fe9bb616f5f48eb12a7e11e

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
