Return-Path: <SRS0=NqQd=7Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D869C433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Jun 2020 18:25:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 75B222087E
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Jun 2020 18:25:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1591899907;
	bh=jrJp4ZqPE5v8VDCl/9oK5kM1s0ZCRrL7U8KwCou7PgQ=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=nG/7K/7kIVd6ZBjyoRbChboLPCPicqswq4TJ9P3dm/ao7A1vfcMJ0UqHmZlFyP6s4
	 amYmLbQ5I5RN2qCP0TcJoJMV8swWUZSCgJ8cvuzsGIyRP8p8+nXYnpbw+3+KOXfwJW
	 Ft5LxtMAVzvnTilaZbRxCT1EvnwtxiTR7NSbibGU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728119AbgFKSZF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Jun 2020 14:25:05 -0400
Received: from mail.kernel.org ([198.145.29.99]:45794 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726386AbgFKSZE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Jun 2020 14:25:04 -0400
Subject: Re: [GIT PULL] vfs: improve DAX behavior for 5.8, part 3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1591899904;
        bh=jrJp4ZqPE5v8VDCl/9oK5kM1s0ZCRrL7U8KwCou7PgQ=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=xjhyNYXxHxAfNqLH4GenoExENXh3wXnILAFjYf/uVYBLdiGRHEgWPN9pVcmr1mOv0
         90NC81kwd286nKI0I6iETzct5bwzl131Kw1MkXNGi6Opdyor+X58C8DM3qzLHmHl87
         BzpE5aZz7u6r149GHKZ7cHrSy8ih0mmgETEKPh3Y=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20200611024248.GG11245@magnolia>
References: <20200611024248.GG11245@magnolia>
X-PR-Tracked-List-Id: <linux-fsdevel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20200611024248.GG11245@magnolia>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/fs/xfs/xfs-linux.git
 tags/vfs-5.8-merge-3
X-PR-Tracked-Commit-Id: e4f9ba20d3b8c2b86ec71f326882e1a3c4e47953
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 7cf035cc8326066a514146065b6ee8fc2c30fc21
Message-Id: <159189990428.7248.14261911727623489238.pr-tracker-bot@kernel.org>
Date:   Thu, 11 Jun 2020 18:25:04 +0000
To:     "Darrick J. Wong" <djwong@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        "Darrick J. Wong" <djwong@kernel.org>,
        linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org,
        david@fromorbit.com, linux-kernel@vger.kernel.org,
        sandeen@sandeen.net, hch@lst.de,
        linux-ext4 <linux-ext4@vger.kernel.org>,
        Theodore Ts'o <tytso@mit.edu>, ira.weiny@intel.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Wed, 10 Jun 2020 19:42:48 -0700:

> git://git.kernel.org/pub/scm/fs/xfs/xfs-linux.git tags/vfs-5.8-merge-3

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/7cf035cc8326066a514146065b6ee8fc2c30fc21

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
