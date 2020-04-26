Return-Path: <SRS0=PEot=6K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7CB8C54FCB
	for <linux-kernel@archiver.kernel.org>; Sun, 26 Apr 2020 18:15:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8757B2070A
	for <linux-kernel@archiver.kernel.org>; Sun, 26 Apr 2020 18:15:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1587924937;
	bh=gl7jkcOzoGAGUf8hazeyTJkVwaavvZUeMjYUkdz0R2M=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=Az8bl7lPqkug1ul0xtLmLJlf4gNTs0REGM3oBNJlGiIJlvmYGZqk2N77VUc8xtRJ1
	 PRexj1z3DsQ9gkYNUFtsOqnjps3tKjj6sPdmxHfLhhb44qMgylyE9M/t6gqp8FnNei
	 Rpf4BnlpHkZv5Wt+xz9xaLlNV75Y/xKsgSs2Lafk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726401AbgDZSPg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 26 Apr 2020 14:15:36 -0400
Received: from mail.kernel.org ([198.145.29.99]:50788 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726228AbgDZSPR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Apr 2020 14:15:17 -0400
Subject: Re: [GIT PULL] s390 updates for 5.7-rc3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1587924917;
        bh=gl7jkcOzoGAGUf8hazeyTJkVwaavvZUeMjYUkdz0R2M=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=NN3GYUlmCeg0wmCq7HlAmHm28WV8fqTwzJJftHqRS0VvezYHhtTh03q+oLPPxj0Be
         WX0M+C6O6JBI/aq6YdzbOM1FOAJq2siKw6y+ezxCuokkYNzdxCtK7euToawC29QIP2
         IRaQtMZZ/8Two2jOUtaoYT6aQcXQ4wgnv6o2Vrd4=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <your-ad-here.call-01587886761-ext-5453@work.hours>
References: <your-ad-here.call-01587886761-ext-5453@work.hours>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <your-ad-here.call-01587886761-ext-5453@work.hours>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/s390/linux.git tags/s390-5.7-3
X-PR-Tracked-Commit-Id: 673deb0beba5d39c2e0bc6536e00b03b6ef59cc0
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 749f04615a3d435e98a13cc1e38be10774e1c64b
Message-Id: <158792491712.6795.16500152102835869858.pr-tracker-bot@kernel.org>
Date:   Sun, 26 Apr 2020 18:15:17 +0000
To:     Vasily Gorbik <gor@linux.ibm.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sun, 26 Apr 2020 09:39:21 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/s390/linux.git tags/s390-5.7-3

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/749f04615a3d435e98a13cc1e38be10774e1c64b

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
