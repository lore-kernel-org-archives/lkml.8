Return-Path: <SRS0=IBMW=4Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E38C3C10F00
	for <linux-kernel@archiver.kernel.org>; Sat,  7 Mar 2020 14:30:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BD5BA2073D
	for <linux-kernel@archiver.kernel.org>; Sat,  7 Mar 2020 14:30:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1583591411;
	bh=7lCgzxyiHnGiJOIf8spbcxGm+V3taEloG5KvU+xZd0U=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=Lo0HqvgS0+r5Slz/tuJcRMUqkXpNq+s71w+da3I5iSmyky8RqGAJipNAIS6A/NDHg
	 sgpgfbcvQC7QOosQ3gOrcseGvq2Tl4VzeR2zMYTLUyd6vHuETC8a1Zd6VzOqCVl4zS
	 xEJv/Q3ZBwrNt4T3QNpAmUv17x9Eg6oFWBj98B3c=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726445AbgCGOaK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 7 Mar 2020 09:30:10 -0500
Received: from mail.kernel.org ([198.145.29.99]:33808 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726402AbgCGOaJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 Mar 2020 09:30:09 -0500
Subject: Re: [GIT PULL] s390 updates for 5.6-rc5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1583591409;
        bh=7lCgzxyiHnGiJOIf8spbcxGm+V3taEloG5KvU+xZd0U=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=BgTIqSWpqPNG9aHxHuOi3wONlpsr2XnkbTunA5hEnn2cQZZX44W6NvPuHSqpF7XLu
         u9ZdmZCZ2HpVM3t1OrvAh89hyTJXVsMoLbTdmolWOaJTW54Yu61fECsECWC0Y7L9Px
         eUS+TmzMMuneldXeqpUYJYHnlHRtXbSCzMR15gCM=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <your-ad-here.call-01583586405-ext-2652@work.hours>
References: <your-ad-here.call-01583586405-ext-2652@work.hours>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <your-ad-here.call-01583586405-ext-2652@work.hours>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/s390/linux.git tags/s390-5.6-5
X-PR-Tracked-Commit-Id: df057c914a9c219ac8b8ed22caf7da2f80c1fe26
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 9d588f63602778716921bb638cda412cdeacabc8
Message-Id: <158359140906.13770.15430093611151209822.pr-tracker-bot@kernel.org>
Date:   Sat, 07 Mar 2020 14:30:09 +0000
To:     Vasily Gorbik <gor@linux.ibm.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sat, 7 Mar 2020 14:06:45 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/s390/linux.git tags/s390-5.6-5

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/9d588f63602778716921bb638cda412cdeacabc8

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
