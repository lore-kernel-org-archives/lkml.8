Return-Path: <SRS0=OX35=4D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E4F3C2BA83
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Feb 2020 18:40:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7B94F2072D
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Feb 2020 18:40:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1581792022;
	bh=nmrC8Gv/Y1Cox/igouzLpzsYakwEcuZMZUQp9HRg8Ak=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=A3TenKA5tDMP3mO8ZbnaweiW9ftXowa7fuK+Vh4OTCzPcj571hNQgNUHMQCt3TV/M
	 sigLuEyjcwUzduOa86FZx27WTzhsAMAjB4ToStnt4JUYaeQc2LTUrV57Nv22knrUKC
	 gX4blTulrp3aZtezdvPJ4VpsoBcDV6J7D0TVr6QM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727875AbgBOSkV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 15 Feb 2020 13:40:21 -0500
Received: from mail.kernel.org ([198.145.29.99]:37438 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727804AbgBOSkT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Feb 2020 13:40:19 -0500
Subject: Re: [GIT PULL] Ceph fixes for 5.6-rc2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1581792019;
        bh=nmrC8Gv/Y1Cox/igouzLpzsYakwEcuZMZUQp9HRg8Ak=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=ANuDMHcrzFeweHvHX5kOCKZ+3RuNHTe6e32/YP/MGgQ/C4N1OMsx5SU876taXdPiQ
         49Hec8b9TvK/OiESViwmdmvILYTQPKGlovt9GBA2BPYxl2ckcG1x46VxlBi5LqBWlT
         GtJXAkfMfyVExK0qhCN85r3ToK5F2s+QCYeDrgic=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20200214164944.6044-1-idryomov@gmail.com>
References: <20200214164944.6044-1-idryomov@gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20200214164944.6044-1-idryomov@gmail.com>
X-PR-Tracked-Remote: https://github.com/ceph/ceph-client.git
 tags/ceph-for-5.6-rc2
X-PR-Tracked-Commit-Id: 3b20bc2fe4c0cfd82d35838965dc7ff0b93415c6
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: cf556edfde6cfc293ce63de02ac23f725e41dfb1
Message-Id: <158179201914.28665.11052799318253522198.pr-tracker-bot@kernel.org>
Date:   Sat, 15 Feb 2020 18:40:19 +0000
To:     Ilya Dryomov <idryomov@gmail.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        ceph-devel@vger.kernel.org, linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 14 Feb 2020 17:49:44 +0100:

> https://github.com/ceph/ceph-client.git tags/ceph-for-5.6-rc2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/cf556edfde6cfc293ce63de02ac23f725e41dfb1

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
