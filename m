Return-Path: <SRS0=flzY=3U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 022E0C2D0DB
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Jan 2020 23:10:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C54402082E
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Jan 2020 23:10:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1580512216;
	bh=LmqioFbwzpBP6pTd5yxHO9NFr1Ch+RoeV4ZMcs/MXIU=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=vj4WN1M2tYu++80e5fvmH9IMfu0yctVNAykshWOPMHejDk/0ghyEwNyNJg93k/3d6
	 c7HKywwdHq8ZZU9BXjlDKbAXMCURoTq9v5t3l3XTaaPxnOSGM6N8ZJxLtQtddcYtSd
	 3he1Hg5U/HWaZj5sETnU84JCARlQDMirlFfbLda0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727437AbgAaXKQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 Jan 2020 18:10:16 -0500
Received: from mail.kernel.org ([198.145.29.99]:46376 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726264AbgAaXKP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Jan 2020 18:10:15 -0500
Subject: Re: [GIT PULL] More power management updates for v5.6-rc1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1580512215;
        bh=LmqioFbwzpBP6pTd5yxHO9NFr1Ch+RoeV4ZMcs/MXIU=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=ls8EIekQznXaTu9IBHWEDcpfhsuDteh/I+0Y+LP+tdW24bnuJZBnY3J4+7XEoHccl
         xErkpJof6PStc++a0Px3ciYNkj7pjYCcKoxVsgDRtVdAgu6JAAQF8K2WyYQ179NdC/
         iyO25dxjr4UFa4IajO7y56EFiu+313NdxH31QyR0=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <CAJZ5v0h7igCZU43nqcZytEgXsQ4vHYs9CBbGr-uSruj8pwoA+g@mail.gmail.com>
References: <CAJZ5v0h7igCZU43nqcZytEgXsQ4vHYs9CBbGr-uSruj8pwoA+g@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAJZ5v0h7igCZU43nqcZytEgXsQ4vHYs9CBbGr-uSruj8pwoA+g@mail.gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git
 pm-5.6-rc1-2
X-PR-Tracked-Commit-Id: 82b2c6ffd399c9fcd542fd681bb8c6d41f035c7e
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: cf3c8f84d1401fed5010784034d104cc689061d5
Message-Id: <158051221509.10603.3162603799040500779.pr-tracker-bot@kernel.org>
Date:   Fri, 31 Jan 2020 23:10:15 +0000
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 31 Jan 2020 11:01:26 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git pm-5.6-rc1-2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/cf3c8f84d1401fed5010784034d104cc689061d5

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
