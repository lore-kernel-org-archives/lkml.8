Return-Path: <SRS0=zXkI=7F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D91E9C433DF
	for <linux-kernel@archiver.kernel.org>; Sat, 23 May 2020 18:30:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B7D8D2070A
	for <linux-kernel@archiver.kernel.org>; Sat, 23 May 2020 18:30:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1590258604;
	bh=J1nzUGsp+jt/bbvokITb2nZWCDRks58eGlX6ZQ6IS/k=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=0nNbpvm05zsQK5xH8jNkW9kyzpIgtITGKELIimfWs5zhkhTRAm3fY8aiJ87TCo+7M
	 tpeQJMYieU6MGxd389v8BPeNw0LmA16eC/+sMQTEtHkzxwNNcMaDmbL85cu50ZprZ1
	 pR1s8edmLp6WqrSUmCRfaJ3XQF67+XyqyilJpk7o=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387976AbgEWSaD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 23 May 2020 14:30:03 -0400
Received: from mail.kernel.org ([198.145.29.99]:53194 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727117AbgEWSaD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 May 2020 14:30:03 -0400
Subject: Re: [GIT PULL] s390 updates for 5.7-rc7
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1590258602;
        bh=J1nzUGsp+jt/bbvokITb2nZWCDRks58eGlX6ZQ6IS/k=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=I2F6oC/9SyrPsp6JrtYFDhOk5jhLQYhGMFTWnUDeTg9BZsK6zLnTQjpkA2b5n3sMY
         6dPbMDnhrO/+VHBB0+6C4XY//jrHYuW/Q2dfCWwsOcFljzWZnadDYAWMPuST8YoggN
         UgRnnOxOZgb01QCa6NNMG0FdERvzRxXC1n1LqzF4=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <your-ad-here.call-01590229105-ext-5688@work.hours>
References: <your-ad-here.call-01590229105-ext-5688@work.hours>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <your-ad-here.call-01590229105-ext-5688@work.hours>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/s390/linux.git tags/s390-5.7-4
X-PR-Tracked-Commit-Id: 4c1cbcbd6c56c79de2c07159be4f55386bb0bef2
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 9bca7c40850eca2613d79878e6d730faeaa602cf
Message-Id: <159025860281.7121.14844093492746630510.pr-tracker-bot@kernel.org>
Date:   Sat, 23 May 2020 18:30:02 +0000
To:     Vasily Gorbik <gor@linux.ibm.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sat, 23 May 2020 12:18:25 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/s390/linux.git tags/s390-5.7-4

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/9bca7c40850eca2613d79878e6d730faeaa602cf

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
