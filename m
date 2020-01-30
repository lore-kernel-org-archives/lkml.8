Return-Path: <SRS0=4zup=3T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3192FC35240
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Jan 2020 23:50:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F359020661
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Jan 2020 23:50:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1580428206;
	bh=tt3HgsvZ5f1NSLredYL9p0Zx285v1TU9VRXMgWzws+8=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=cWHSMLzLIgheN+9I5icuGULHMOYuyQV+ZQ8HJCnpQF0DQFSaqEZBZxkhU9BRukAB/
	 9rUSgRP0vJWsP2wmvfEPiTlIrHluHFSnwNrX+xfPUfNkS8XcIl+rE2sJJH0iDJsnLF
	 /DT4mk3u/qX48g7YqfgAunn9NqFD6H4x6yRqg2Dw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727806AbgA3XuF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Jan 2020 18:50:05 -0500
Received: from mail.kernel.org ([198.145.29.99]:35450 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727782AbgA3XuE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Jan 2020 18:50:04 -0500
Subject: Re: [GIT PULL] xfs: new code for 5.6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1580428204;
        bh=tt3HgsvZ5f1NSLredYL9p0Zx285v1TU9VRXMgWzws+8=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=bi1YEKnTeQ+jyXt1fCe95TuPnVKwZSZuh7Zt/W13AUjth0Xdy3TDa5GIEeH8rkPDx
         sxdEZ2NuyBWgRVHaSQaSEhl22RsRHSDU+MZJA2lBOoy+tQLu6jOjsJ/y4f/nwZASYz
         r1CdGxSZ34w+fU6h1YdLRJUDOei95EaqAyJNnBA8=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20200130161338.GX3447196@magnolia>
References: <20200130161338.GX3447196@magnolia>
X-PR-Tracked-List-Id: <linux-fsdevel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20200130161338.GX3447196@magnolia>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/fs/xfs/xfs-linux.git
 tags/xfs-5.6-merge-6
X-PR-Tracked-Commit-Id: b3531f5fc16d4df2b12567bce48cd9f3ab5f9131
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 91f1a9566f387137f2da1957792a8f9f07cd058f
Message-Id: <158042820420.30792.5005939379399587019.pr-tracker-bot@kernel.org>
Date:   Thu, 30 Jan 2020 23:50:04 +0000
To:     "Darrick J. Wong" <djwong@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        "Darrick J. Wong" <djwong@kernel.org>,
        linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org,
        david@fromorbit.com, linux-kernel@vger.kernel.org,
        sandeen@sandeen.net, hch@lst.de
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Thu, 30 Jan 2020 08:13:38 -0800:

> git://git.kernel.org/pub/scm/fs/xfs/xfs-linux.git tags/xfs-5.6-merge-6

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/91f1a9566f387137f2da1957792a8f9f07cd058f

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
