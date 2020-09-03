Return-Path: <SRS0=vQOp=CM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B169C433E9
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Sep 2020 17:09:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CCAD4214F1
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Sep 2020 17:09:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1599152973;
	bh=BcAYR7vU4inGUZh+kawOx+/d7nioL797uBUlD0wvabo=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=ESAYqrv8jbd/mxKMXuKKt4xgBUtYqk6Z1Gfa7a9KTiQpAt/UaP0G020KDgH7JAycP
	 Tbk7miKqSKlVoyF9ww4xaxvYdhJEY3MF22msJPsaNDu41iL5x+EL1PITz3a3/pc8TH
	 R617AtyL1uDJnUTIjGk2iyrdo83WMEIeHw5ULJAg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728754AbgICRJc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Sep 2020 13:09:32 -0400
Received: from mail.kernel.org ([198.145.29.99]:40994 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726025AbgICRJb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Sep 2020 13:09:31 -0400
Subject: Re: [GIT PULL] AFFS fix for 5.9
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1599152970;
        bh=BcAYR7vU4inGUZh+kawOx+/d7nioL797uBUlD0wvabo=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=Iv75t7XJwTAbauKpm+yyw62ej7Lin68RHlN62Jg7qUQVWbmdkbpU8XdXmNT9SeLaQ
         fltAMh578++7QfUgloi5rxW9LvLXYGuft45HGeSefcV0y17dlJ83qh6R0xq7MNO2ek
         hSuVOlAc3uX3Kai6KPALAs4BwT8u1boO5Pg8xZPU=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <cover.1599130324.git.dsterba@suse.com>
References: <cover.1599130324.git.dsterba@suse.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <cover.1599130324.git.dsterba@suse.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/kdave/linux.git affs-for-5.9-tag
X-PR-Tracked-Commit-Id: d3a84a8d0dde4e26bc084b36ffcbdc5932ac85e2
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 26acd8b07a07000d9f61ee64dc6fde0494997b47
Message-Id: <159915297083.22690.105371369741305652.pr-tracker-bot@kernel.org>
Date:   Thu, 03 Sep 2020 17:09:30 +0000
To:     David Sterba <dsterba@suse.com>
Cc:     torvalds@linux-foundation.org, David Sterba <dsterba@suse.com>,
        linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Thu,  3 Sep 2020 13:09:46 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/kdave/linux.git affs-for-5.9-tag

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/26acd8b07a07000d9f61ee64dc6fde0494997b47

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
