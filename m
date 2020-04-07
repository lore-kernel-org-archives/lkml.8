Return-Path: <SRS0=z/zp=5X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 433FEC2D0EC
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Apr 2020 19:55:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0766B20730
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Apr 2020 19:55:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1586289332;
	bh=DaJda3zXtcFXkWyIZuejGWq7C0TsDmJ0DAG90FwqzAo=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=Lo+jOW/7DP+OrXspCwYD6zWk31EZtIfsxzGb+oNMxl+9IChM9fHpN8zRaAQvdeuAr
	 zzqhZ0ENjnWAMTg0Nef3SKJwwcjFJhA1rdbD92SXnzKSx68GRwDr85cCe10qNLw82m
	 9Npb6ON3sBme16ZGPUQi9CBo7M4+7/95OgCYe0FU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727918AbgDGTza (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Apr 2020 15:55:30 -0400
Received: from mail.kernel.org ([198.145.29.99]:56594 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727892AbgDGTz2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Apr 2020 15:55:28 -0400
Subject: Re: [GIT PULL] UBI/UBIFS fixes for v5.7-rc1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1586289328;
        bh=DaJda3zXtcFXkWyIZuejGWq7C0TsDmJ0DAG90FwqzAo=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=JdgdNOzN2frDG3eiBxR6ICwXoP3E5ChSJdrIKfIUu1KDNzIEkv2SO9XkYIQuFzD7R
         RX0CvbqgnTB9kO6E4+OlLDU32hDJfQDnnR4wDw+/l8xG2GDF9AhiIiLzty8fZlipqk
         WFo2vmC/KWk3ajrDB5l/c2OCetIH3fprGgvabyKI=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <793490269.91815.1586263081165.JavaMail.zimbra@nod.at>
References: <793490269.91815.1586263081165.JavaMail.zimbra@nod.at>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <793490269.91815.1586263081165.JavaMail.zimbra@nod.at>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/rw/ubifs.git
 tags/for-linus-5.7-rc1
X-PR-Tracked-Commit-Id: 3676f32a98cd6ed4481c21bceb8b4829d4b6d1cf
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 763dede1b24886d327bfaed7cf59ee3c01c7913e
Message-Id: <158628932815.3792.16265491519028967812.pr-tracker-bot@kernel.org>
Date:   Tue, 07 Apr 2020 19:55:28 +0000
To:     Richard Weinberger <richard@nod.at>
Cc:     torvalds <torvalds@linux-foundation.org>,
        linux-mtd <linux-mtd@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Tue, 7 Apr 2020 14:38:01 +0200 (CEST):

> git://git.kernel.org/pub/scm/linux/kernel/git/rw/ubifs.git tags/for-linus-5.7-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/763dede1b24886d327bfaed7cf59ee3c01c7913e

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
