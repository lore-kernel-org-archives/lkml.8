Return-Path: <SRS0=1dCa=6A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71390C3815B
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Apr 2020 17:55:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 52346214D8
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Apr 2020 17:55:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1587059728;
	bh=etVCD76bhHfxKZx+YL8EO2UfLMLM5gDpfBrdGDEmRXw=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=FAZtRS5g3WRU/PxBkQf1noGXBb/uc6fd2XuHPDI/kM9ABp5LOjjpn9g+1KfwMCoTN
	 eTQG4pxd+cXiE+95mN0GAGteo7aYx0n/0hALkq5f/DltMrKVpt6B7GwHS6vASIc/4K
	 mLV8JeirMbTDbIYF8kYmKqEL7i9B+gzs/YTU0A+8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390089AbgDPRzY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Apr 2020 13:55:24 -0400
Received: from mail.kernel.org ([198.145.29.99]:47724 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729436AbgDPRzW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Apr 2020 13:55:22 -0400
Subject: Re: [GIT PULL] Ceph fixes for 5.7-rc2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1587059721;
        bh=etVCD76bhHfxKZx+YL8EO2UfLMLM5gDpfBrdGDEmRXw=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=c+WRKd6f3DQITdxYwNhPzEKTBM7Qps9SVdGdNQpwO5WY/GLSpACEdz+6rvWDVAgUj
         nK/RCYZtywI4S3lDafWx7LZ7vEgQ5QlmUtGDQ8sSKgjokmIqsmf79JTjVve7z8+0ik
         K+wqZBLxTWT4AUJqUvCtC7pLFb1XzzWkykSMOUfs=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20200416172321.20778-1-idryomov@gmail.com>
References: <20200416172321.20778-1-idryomov@gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20200416172321.20778-1-idryomov@gmail.com>
X-PR-Tracked-Remote: https://github.com/ceph/ceph-client.git
 tags/ceph-for-5.7-rc2
X-PR-Tracked-Commit-Id: 2a575f138d003fff0f4930b5cfae4a1c46343b8f
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 3fa84bf926f32edf798cfad0317e14df41ac0509
Message-Id: <158705972176.30027.7508667561184560509.pr-tracker-bot@kernel.org>
Date:   Thu, 16 Apr 2020 17:55:21 +0000
To:     Ilya Dryomov <idryomov@gmail.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        ceph-devel@vger.kernel.org, linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Thu, 16 Apr 2020 19:23:21 +0200:

> https://github.com/ceph/ceph-client.git tags/ceph-for-5.7-rc2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/3fa84bf926f32edf798cfad0317e14df41ac0509

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
