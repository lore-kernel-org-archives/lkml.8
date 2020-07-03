Return-Path: <SRS0=gItQ=AO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EDDB8C433E0
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Jul 2020 21:15:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C642120782
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Jul 2020 21:15:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1593810909;
	bh=ctPSV8r6NWu+b3y1KFgMQ0FA4GIl5K00veLAKseYkV0=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=QBzX+cs8VkHz0mb1gQ/N/sMIFaX0afkEM821eFjpOnNOx1yFPT1alJTU4uboJoVNO
	 N0Eaf2gbHai/eiu4V6FEbqcZeKIBV1qHmob8pH38zig2mQinR86pSbScPmdAekrnNU
	 6gIYxL5POG9zdm/zWCvid0eUivN6a8FE78lJSRZw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726894AbgGCVPI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Jul 2020 17:15:08 -0400
Received: from mail.kernel.org ([198.145.29.99]:56232 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726474AbgGCVPI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Jul 2020 17:15:08 -0400
Subject: Re: [GIT PULL] Additional gfs2 fixes for 5.8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1593810907;
        bh=ctPSV8r6NWu+b3y1KFgMQ0FA4GIl5K00veLAKseYkV0=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=fQcqqJH56+sL+GXdF6uWUR1XtzWV+POEDcOG4NV0soKp4WFxfe4ZBc9eLzufSd0B0
         7rdPZ8Tn5L4aIVES5hO+XBV/Ej/T1iccwDPfR08TKcfPObxvnRisKGtyC/cElvlYly
         70DOe7ELv4hQ/0dztpAZ7nIMG77aKgQBHacBnp40=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20200703101854.1493930-1-agruenba@redhat.com>
References: <20200703101854.1493930-1-agruenba@redhat.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20200703101854.1493930-1-agruenba@redhat.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/gfs2/linux-gfs2.git
 tags/gfs2-v5.8-rc3.fixes
X-PR-Tracked-Commit-Id: c860f8ffbea8924de05a281b937128773d30a77c
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: bf2d63694e9ed5142711325e0039b017d40fae4c
Message-Id: <159381090787.9451.11625675407027186843.pr-tracker-bot@kernel.org>
Date:   Fri, 03 Jul 2020 21:15:07 +0000
To:     Andreas Gruenbacher <agruenba@redhat.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        cluster-devel@redhat.com, linux-kernel@vger.kernel.org,
        Andreas Gruenbacher <agruenba@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri,  3 Jul 2020 12:18:54 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/gfs2/linux-gfs2.git tags/gfs2-v5.8-rc3.fixes

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/bf2d63694e9ed5142711325e0039b017d40fae4c

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
