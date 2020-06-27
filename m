Return-Path: <SRS0=QqoS=AI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7EFACC433E1
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Jun 2020 20:25:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 621D62067D
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Jun 2020 20:25:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1593289524;
	bh=XbTdeeiqquxAA9FgJdshapqhWfFKzEoG7ZtE+3QKEcM=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=S3/iivHnlvcQspCv4jCYZ01VcQF0G5NtQllj4rMO0TX4SRRJX/Mq15fDqvObqN0Ks
	 mT5tACg6ad9KvX5UHlvR3I8QbKuKSI71HP5XyLekCIFoop94xEfaC9Z/sAfi/uTHWO
	 XMe8KWqT1FcAruM80rq5nmL3zUfaodqEu99zkWmU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726876AbgF0UZP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 27 Jun 2020 16:25:15 -0400
Received: from mail.kernel.org ([198.145.29.99]:40248 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726712AbgF0UZO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 Jun 2020 16:25:14 -0400
Subject: Re: [GIT PULL] Char/Misc driver fixes for 5.8-rc3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1593289514;
        bh=XbTdeeiqquxAA9FgJdshapqhWfFKzEoG7ZtE+3QKEcM=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=COZoi5IAzEH2/mCDKyCKX74r+ef66FbxUdxH6+LqZKnprqp3Ztl/9N0LKPo/9IZaE
         aAGlovB4pFqiDxI1tF0N3RZc17xJCmlK6PTAsUU94yjxQUe8BULotT7EuWW2vgIZpO
         hrsQ1UoBpCBtO42f7rasW3X97N8IwyMFRJo/+L7I=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20200627113952.GA1636771@kroah.com>
References: <20200627113952.GA1636771@kroah.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20200627113952.GA1636771@kroah.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/char-misc.git
 tags/char-misc-5.8-rc3
X-PR-Tracked-Commit-Id: 70b23b87b2d32e608f97e06425853331f17fbda9
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: fc3ebc3c647a15940f3371740e14bb0d1ad7fd9e
Message-Id: <159328951395.11719.6518212816391447019.pr-tracker-bot@kernel.org>
Date:   Sat, 27 Jun 2020 20:25:13 +0000
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sat, 27 Jun 2020 13:39:52 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/char-misc.git tags/char-misc-5.8-rc3

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/fc3ebc3c647a15940f3371740e14bb0d1ad7fd9e

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
