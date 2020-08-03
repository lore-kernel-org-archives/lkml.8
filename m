Return-Path: <SRS0=5bHT=BN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9CFD3C433E0
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Aug 2020 21:25:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A9C7D208C7
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Aug 2020 21:25:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1596489905;
	bh=o6h9CJEoeX8/ejE7QhxPsgxoQEHkTR7/BMMiMJeNSNU=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=DxRI+k7wZPitJ87k7J4MUGKxcYlJWv08sQGVQ/HvPzqRtXBDbeFsc6mZh0jFAU+Mq
	 ZK68tVXypWtYMIEmZ6lhy61kKO3lCLU8/ARnRYfy/KI4aFFccB5y8Au34Nd+/Tbix0
	 ldSgbSn49sKgVzMlvgcc0WM59kML24s1wcOfhLGw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729075AbgHCVZE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Aug 2020 17:25:04 -0400
Received: from mail.kernel.org ([198.145.29.99]:46822 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726370AbgHCVZD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Aug 2020 17:25:03 -0400
Subject: Re: [GIT PULL] s390 updates for 5.9 merge window
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1596489903;
        bh=o6h9CJEoeX8/ejE7QhxPsgxoQEHkTR7/BMMiMJeNSNU=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=Qq91mfsdh5v5jkEnyWaVoPL+1AQn+GAFQwO0MadjQLB9QZeBfIXjUWg3z8Y8QpgCe
         6e1CIN6OpmOrPE51OjwxqvSKXVSXq3bKdcZaF0P7hf6/39isj6vQ8n4sir8EVVLVb0
         MuoR+dMc+2bvBpV+2Yrp7aq4rxxAIxc/uVpG098A=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20200803093315.GA4083@osiris>
References: <20200803093315.GA4083@osiris>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20200803093315.GA4083@osiris>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/s390/linux.git tags/s390-5.9-1
X-PR-Tracked-Commit-Id: 9a996c67a65d937b23408e56935ef23404c9418e
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 45365a06aa305c9eca1cbf48aef48a7a0cea3b4e
Message-Id: <159648990348.7765.12917815378039110463.pr-tracker-bot@kernel.org>
Date:   Mon, 03 Aug 2020 21:25:03 +0000
To:     Heiko Carstens <hca@linux.ibm.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Mon, 3 Aug 2020 11:33:15 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/s390/linux.git tags/s390-5.9-1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/45365a06aa305c9eca1cbf48aef48a7a0cea3b4e

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
