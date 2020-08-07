Return-Path: <SRS0=KWFo=BR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9A97C433E1
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Aug 2020 17:47:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B8C0322CA1
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Aug 2020 17:47:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1596822465;
	bh=vbFNKxs/yarHbmPIwn0fg4eZYtI5E5LLEpv0lxuy/cc=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=YbsGqkCmSsAMMMqiHfj/nFetkBPwUNO8SAm6RL6mFXJFr/ypC+Kddkw5G5KREXefg
	 RtqKwZQhfgi7UCJydw0I7KJ4D/AWOp36pSO4FNIlVvgS4Gp9T0tN7/NaWmOBIgl0oz
	 Rp2gHeKSiYeFIEFG1gukUEU4A7JxhPEKQkmsh1/I=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727030AbgHGRro (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Aug 2020 13:47:44 -0400
Received: from mail.kernel.org ([198.145.29.99]:39968 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726015AbgHGRrT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Aug 2020 13:47:19 -0400
Subject: Re: [git pull] m68knommu changes for v5.9
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1596822439;
        bh=vbFNKxs/yarHbmPIwn0fg4eZYtI5E5LLEpv0lxuy/cc=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=QM/DNvbbVO1fVSyPG/QX8L6HkJof2DVD/9vDI89L6z6lG2iDU3bnVg35Q1rrr2hAT
         Mndj3NI6lom2uosWQgIt3qryK8CkQlMQw/mq2I2mNkxev3F2HxlwCDLqRYkFZs0Q+J
         q2v/y3nWXjC4MbFegIZTDQHvOEx7ZyfryOuZ6TTE=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <71db8f0b-0178-30a7-3871-c56eb5688432@linux-m68k.org>
References: <71db8f0b-0178-30a7-3871-c56eb5688432@linux-m68k.org>
X-PR-Tracked-List-Id: <linux-m68k.vger.kernel.org>
X-PR-Tracked-Message-Id: <71db8f0b-0178-30a7-3871-c56eb5688432@linux-m68k.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/gerg/m68knommu.git tags/m68knommu-for-v5.9
X-PR-Tracked-Commit-Id: fde87ebf1daa8d96e4412aa06536da4b55103e02
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 60e76bb8a4e4c5398ea9053535e1fd0c9d6bb06e
Message-Id: <159682243948.18750.62413015728339534.pr-tracker-bot@kernel.org>
Date:   Fri, 07 Aug 2020 17:47:19 +0000
To:     Greg Ungerer <gerg@linux-m68k.org>
Cc:     torvalds@linux-foundation.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Linux/m68k <linux-m68k@vger.kernel.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 7 Aug 2020 14:56:52 +1000:

> git://git.kernel.org/pub/scm/linux/kernel/git/gerg/m68knommu.git tags/m68knommu-for-v5.9

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/60e76bb8a4e4c5398ea9053535e1fd0c9d6bb06e

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
