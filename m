Return-Path: <SRS0=0sZ+=6V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2CF4C38A2A
	for <linux-kernel@archiver.kernel.org>; Thu,  7 May 2020 17:35:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D376B20735
	for <linux-kernel@archiver.kernel.org>; Thu,  7 May 2020 17:35:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1588872908;
	bh=Pv3d2qKx52IYMLKIM0tx1srdOm44PkwL0xKPOAUW9Ho=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=b7CWyeXc0+bCu5131eTUW1tjYoJxP/amifg7inppNCpQFBvDQO+Ea6pqxnuBKa/bG
	 B08S6iQCOatIjUKR3hTst8b4QknJNexZDRShNlsA9/7UKR0lPrq2wLb4VUHuaqPmXS
	 WgIxXQb1+NkUN0vZmTJTRz6T7Vkdnc10iZsJjSZI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728164AbgEGRfH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 May 2020 13:35:07 -0400
Received: from mail.kernel.org ([198.145.29.99]:33248 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728098AbgEGRfF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 May 2020 13:35:05 -0400
Subject: Re: [GIT PULL] configfs fix for 5.7
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588872905;
        bh=Pv3d2qKx52IYMLKIM0tx1srdOm44PkwL0xKPOAUW9Ho=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=B2GvWSO7iNuBB8gcpHcT7i2PT92SsQit9VfoZGcZ4BmXayo9UDHFH2q3NHrH8yZXB
         9aDa+imicH7egWzOVzwrs/zjX1SMagjZOgbfBOdsB1Si+BFktDJ20ynkJ1JT3fO0q4
         LevFfw1uWb3E+GHUpv3tq9Ysy47jPhG3ILynTdJI=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20200507161628.GA440967@infradead.org>
References: <20200507161628.GA440967@infradead.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20200507161628.GA440967@infradead.org>
X-PR-Tracked-Remote: git://git.infradead.org/users/hch/configfs.git
 tags/configfs-for-5.7
X-PR-Tracked-Commit-Id: 8aebfffacfa379ba400da573a5bf9e49634e38cb
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: de268ccb42d6ec5475ec5a5e60723b665d6e0af2
Message-Id: <158887290531.22656.8482767706592978299.pr-tracker-bot@kernel.org>
Date:   Thu, 07 May 2020 17:35:05 +0000
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Joel Becker <jlbec@evilplan.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Thu, 7 May 2020 18:16:28 +0200:

> git://git.infradead.org/users/hch/configfs.git tags/configfs-for-5.7

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/de268ccb42d6ec5475ec5a5e60723b665d6e0af2

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
