Return-Path: <SRS0=6raZ=AQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8862C433E0
	for <linux-kernel@archiver.kernel.org>; Sun,  5 Jul 2020 19:55:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8CAA720772
	for <linux-kernel@archiver.kernel.org>; Sun,  5 Jul 2020 19:55:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1593978908;
	bh=XDu23HySQ1kWEBMi2YiS5y2kJbE33vur8zlbHgAtVAA=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=tCJfAd8ObK7AExtfJhexKv2wwSyUdnDL732g8+BWEW+dB1QPJEi0ReGRIa9ujLgEY
	 UJI3AcKAHa0Z3Y3cudoIYDvmb/peDNbXd15hbLKfa4/xbHsxYEeapbsQa0ixnjr3FJ
	 /TnRf2zn+/IeLvaar1LJGkrUALQH++/On2zvjoaw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728158AbgGETzG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 5 Jul 2020 15:55:06 -0400
Received: from mail.kernel.org ([198.145.29.99]:43992 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727891AbgGETzG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Jul 2020 15:55:06 -0400
Subject: Re: [GIT PULL] Kbuild fixes for v5.8-rc4
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1593978906;
        bh=XDu23HySQ1kWEBMi2YiS5y2kJbE33vur8zlbHgAtVAA=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=ZJXr0gWN1sFt5OUlpoTQTsGE8PObDEMqar9LothXkcaO2ZYBfFArLU36/PfsSrT7m
         dKyoAZtbF/SCfJmVejCv6VJ5OiJLBEjwp1vQhI5W/Gr6zdSyNPBBPAThW2QTLwybbq
         3eAahOSI+8N2zjIcahi9KWvnBUVFVQnemvfesYVI=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <CAK7LNAQEMNSM2PRaTwPoX+2hn3FpU2=kQEyJdFjH2xkz+eq5gg@mail.gmail.com>
References: <CAK7LNAQEMNSM2PRaTwPoX+2hn3FpU2=kQEyJdFjH2xkz+eq5gg@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAK7LNAQEMNSM2PRaTwPoX+2hn3FpU2=kQEyJdFjH2xkz+eq5gg@mail.gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/masahiroy/linux-kbuild.git
 tags/kbuild-fixes-v5.8-2
X-PR-Tracked-Commit-Id: ba77dca584f5abf30340672bc752fe7912731af5
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 4bc927367db11d8c5b1e20d05729f1ee748791b9
Message-Id: <159397890594.7489.740680151892513260.pr-tracker-bot@kernel.org>
Date:   Sun, 05 Jul 2020 19:55:05 +0000
To:     Masahiro Yamada <masahiroy@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Mon, 6 Jul 2020 00:13:09 +0900:

> git://git.kernel.org/pub/scm/linux/kernel/git/masahiroy/linux-kbuild.git tags/kbuild-fixes-v5.8-2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/4bc927367db11d8c5b1e20d05729f1ee748791b9

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
