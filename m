Return-Path: <SRS0=bQGS=5U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5D2BC4332B
	for <linux-kernel@archiver.kernel.org>; Sat,  4 Apr 2020 17:50:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 926C22074B
	for <linux-kernel@archiver.kernel.org>; Sat,  4 Apr 2020 17:50:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1586022631;
	bh=nEvxDfugBteWRqUcG2AhaZPvHgaoyJZb6JLw1mHFGNk=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=Bl8gnH3Wm3wUI283jk/cFjZiXK6M3jOdryEhv0Xigr1EMXFizOc3j+ppkDZ5rKjMO
	 RiZd88189cpuhAS3d5QGvQBSOpFzEtseVopE+UDEPhYPlS0+B5p8HDmcOBQV5f87ZE
	 jNxvZzMlnZiBJjpL1ezrVkxlvLqzNXJZ+Pj2v87M=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726554AbgDDRua (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 4 Apr 2020 13:50:30 -0400
Received: from mail.kernel.org ([198.145.29.99]:40524 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726510AbgDDRu2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Apr 2020 13:50:28 -0400
Subject: Re: [GIT PULL] s390 patches for the 5.7 merge window
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1586022627;
        bh=nEvxDfugBteWRqUcG2AhaZPvHgaoyJZb6JLw1mHFGNk=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=1Wg/OpNJPJYpnpNwQSoOAUyM38IbBZpTFjvKyEXpJqU3fTuzRGBfRXO+o/RowvI0V
         1bx0IyJxil6yjwnLP6JzESUZUo4BUQra87hr/DibIc54xR0epG0nR+tBWrauAXP1Z+
         ILPGL/Spsfzb5Yq1QDLyE8pr4pirdEP6zjlJD2Bw=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <your-ad-here.call-01586006344-ext-2743@work.hours>
References: <your-ad-here.call-01586006344-ext-2743@work.hours>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <your-ad-here.call-01586006344-ext-2743@work.hours>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/s390/linux.git tags/s390-5.7-1
X-PR-Tracked-Commit-Id: 1058c163dc31b3335c9cf7c4fa42ccf87be73017
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: ad0bf4eb91c2f9b93479b679e5472094ddb76da8
Message-Id: <158602262784.31764.4676490478972592998.pr-tracker-bot@kernel.org>
Date:   Sat, 04 Apr 2020 17:50:27 +0000
To:     Vasily Gorbik <gor@linux.ibm.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sat, 4 Apr 2020 15:19:04 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/s390/linux.git tags/s390-5.7-1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/ad0bf4eb91c2f9b93479b679e5472094ddb76da8

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
