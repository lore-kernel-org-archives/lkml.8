Return-Path: <SRS0=bl3x=A7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 883C5C433E5
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jul 2020 20:50:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 65A1420773
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jul 2020 20:50:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1595278208;
	bh=DIFaQftN44mIiB90bPH6hZbjxNtwXoghZ9cwipdluOE=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=k3xz46OwVE8E6zhjUHsG5WiUClHotmxU0JeUz2RkINsGWeFX/iZeJSwxcZjKfbo04
	 PqcUCDDQXY8520Z5S36EtsbUIgrQlhxAtqBzehVDG186Xfs3OV7xs0XMHzOQ/OXp9O
	 OAfxW1frf10kD5uSYJ8IgR3XZ3JOHP/C7mXp7dIs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729434AbgGTUuH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Jul 2020 16:50:07 -0400
Received: from mail.kernel.org ([198.145.29.99]:57912 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729396AbgGTUuE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jul 2020 16:50:04 -0400
Subject: Re: [GIT PULL] VFIO fix for v5.8-rc7
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1595278204;
        bh=DIFaQftN44mIiB90bPH6hZbjxNtwXoghZ9cwipdluOE=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=zmacJtPF8i+9IuIbeg5f9FLyy0vAbGtTAWwc/r3Vck1/v4DUeNPrZkH0IE1OaN7ZV
         IDU30vWVgSJv014QmwGfsLsU+b2L5HkPqTuVgOVMupCy6p8KRBvNbc375p9zg34oJB
         PxRzKAq7PFMi+WI9fPg9hDia276eiGf2SYMr59vE=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20200720083427.50202e82@x1.home>
References: <20200720083427.50202e82@x1.home>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20200720083427.50202e82@x1.home>
X-PR-Tracked-Remote: git://github.com/awilliam/linux-vfio.git
 tags/vfio-v5.8-rc7
X-PR-Tracked-Commit-Id: b872d0640840018669032b20b6375a478ed1f923
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 4fa640dc52302b5e62b01b05c755b055549633ae
Message-Id: <159527820414.21281.8254818529301492915.pr-tracker-bot@kernel.org>
Date:   Mon, 20 Jul 2020 20:50:04 +0000
To:     Alex Williamson <alex.williamson@redhat.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Mon, 20 Jul 2020 08:34:27 -0600:

> git://github.com/awilliam/linux-vfio.git tags/vfio-v5.8-rc7

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/4fa640dc52302b5e62b01b05c755b055549633ae

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
