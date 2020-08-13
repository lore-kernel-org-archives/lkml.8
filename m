Return-Path: <SRS0=dFdc=BX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1BF98C433E1
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Aug 2020 19:47:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F1B1A20855
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Aug 2020 19:47:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1597348059;
	bh=cjMLOWhQs5cuj8IW5S8x13sMEjRDT67pdegwOBiNG4Y=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=a5otC1MLztRryqP3fopKOx7ZzdrkHe9S+jelsXNpcsT82vJBrn2/E/4zxfqNSJZxk
	 /ZM2yhO6Tscgldt5jeI14PokVuzMGevjjbDlhWHwT9YcFZ3TgPAa6uRJuxP1i/qmxI
	 XnMYbZBJVq+hoKSA/UlxnGj3g7O0hLCm90S+UUVE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726667AbgHMTrh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Aug 2020 15:47:37 -0400
Received: from mail.kernel.org ([198.145.29.99]:37126 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726305AbgHMTrg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Aug 2020 15:47:36 -0400
Subject: Re: [GIT PULL] s390 updates for 5.9-rc1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1597348055;
        bh=cjMLOWhQs5cuj8IW5S8x13sMEjRDT67pdegwOBiNG4Y=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=fiY+IM7WRYI49V9DGMboUsCqNI+ov6sKKo/+Q0SUiZfZ3Gr46/sdpT4HQdice55j/
         nkzf06U9lASrfYJrs9iucQmpCrFAgJslIxuVhDB7PqJn3HKsAmewP1XRkjqUALQ+cz
         t1DvPyhCKvSBSxUJ4zO+TwNwQdnsWMztpWylrFUY=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20200813171043.GE12168@osiris>
References: <20200813171043.GE12168@osiris>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20200813171043.GE12168@osiris>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/s390/linux.git tags/s390-5.9-2
X-PR-Tracked-Commit-Id: b450eeb0c973ed4125ea91e35613f029337fd28b
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 990f227371a400c0fbcb98b75c91a7dbd65f6132
Message-Id: <159734805566.27850.17107855781053736053.pr-tracker-bot@kernel.org>
Date:   Thu, 13 Aug 2020 19:47:35 +0000
To:     Heiko Carstens <hca@linux.ibm.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Thu, 13 Aug 2020 19:10:43 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/s390/linux.git tags/s390-5.9-2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/990f227371a400c0fbcb98b75c91a7dbd65f6132

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
